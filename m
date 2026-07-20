Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFE7C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkA5-0005Wp-TC; Mon, 20 Jul 2026 05:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlkA2-0005UU-J4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:19:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlkA0-0007aV-Nn
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:19:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K965XS2110642
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ApbP7hYuqc8R2yOVpRZwPLW+EwvbTObRLWXaVaOR9Vw=; b=BiFo7Vp2FjynFrPm
 Dby7MR771tKleFUkeaBCMwTa3Ao7fDgHQawMnShr9UszC6wnVcOofxkxf8FaJ/EF
 ovTuiC+WNWaRB60YItn98zAfDfQJ67+tccRbs9klvyIfcUU6/5j/Kz7/4/g0Lkcc
 FqTEpwK//qqctzns2GZd1ufWsQFJptApD0RMtfMWA60eZBtr05O6OAvRSG5NAJI5
 KAP1VXmNKXjYAmzWQK0u1Ndjzpfno365Bv+28JMExXMZE3bMzkJ7pBbDF46P5XSF
 P5oOqdqJ+0ARuNTcjGTClC55GokJi/LMRUJdtMHAsfYI4w/SlO/wzV3mwmn/DQW5
 Fket1Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre829p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:19:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so236742371cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784539178; x=1785143978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ApbP7hYuqc8R2yOVpRZwPLW+EwvbTObRLWXaVaOR9Vw=;
 b=QOZza6R7mnP3CIHM2GjSHFMbY13N1qHLwOT/q5JEJKuam0wGXHZGWnqU4rvoWjRZQZ
 M6kj5Fe+nD0pViiPW5Sc/eUqysWCirR66lezzETvmT7PvZGkkVaY3qSnoqXJK4fVoXVj
 PPPkyecb/rRPIzKzQI8EvK9LUAkBwBpII8fU+7p9Zbtqs7SGdj0MTju60gA6ylzQF7fU
 MvbFPenLer3AVYHLXKnRkhTJbZdBSVeBNdU3+4ZR39VeztT1NmQJypkv2bNGGVBNtZCB
 fg4FZ82UV+L89E9/yzYdUDdygDHjF/xf/WmteUIJc3K78ZP/Osxw4npvsAdTPSTK21g5
 k1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784539178; x=1785143978;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ApbP7hYuqc8R2yOVpRZwPLW+EwvbTObRLWXaVaOR9Vw=;
 b=TPuWK7HeE8MM8WthOdcjaXdt+1hEVynaLHkNfS5olA4gckVlJhqh3Pk5LOED6jmp3z
 k4pvhJqL2NHaTAytBfJVsZ7jJQifv9CEddwKqqpL23qn35VRUN37fTyI4xX4XlUA0nga
 MO/jap7DnXF79jHY1kanh3Fb37dvw5AyCal9bxqbWq5KMc81k9ZJnzEgs643KhWPh8Q3
 FtJ41psvOgfuQqeRthHJcPqsr2c9yvIjSZQ9vHPAcfWblDKfzlK5rZ9v0sMEwsuoaBH+
 Ba97pExOl9TpYeHQHsZgCCX0GduLaO1Um43zPPRVN5V6Qc4qQ418h7KKA6AmFzdkiaqJ
 MeiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNXuvDv6z6bCsg07RBM8IR9hrlGP+7CbaYfvH1VWqyEUpuHJZuponGE1p/L2jnLzjc+DVW1ou4hJIs@nongnu.org
X-Gm-Message-State: AOJu0YxmVs/evDN43ztpqa5Qi2efXypDqrDV4nwSpoN2OKooVXhLxo1s
 NjClWUKZaM6k8Wn3tM0iXjfWhVT/KIWOqWZf3JVeENylUjRlEddvf/KFGR9j4Tn3ZPpZgf9rxOj
 7emVp8hco2r/vWOlDIG550WvDjfjYfLOtEI9uwte9ivCsYCGX34IAibLX1Q==
X-Gm-Gg: AfdE7ckkxXKDeKbBBH86m4EF765kJPiXsbd5U3by5JQQlWMv2Tae6BM0jVIVCEZkYyJ
 LQIIt6MNFXjRL+y+Lu4Z7fcCFtURxSjTruUfD33enQKwv0U2x13n4zTy2Y5nGXvwFiJupBiwzC6
 I0RXX55eb+1DS0Q5JRZvjYow6FWr1w2KC9OaQQZlRYIc0KZrUtRehB4/Ug+Hku2UsHyGLvl37p2
 H1nIRPa+G+nnu2LexjLq1rnNtGljVWLosi6sKaeIP1qeJknq8A3LBWY6sLcaDlvwinTn9Fe5Wbj
 c5DEsECaFKEYFkrOlMoI/CqLpnLfoRE6tPH8FFM8yjyq6Z70VDoXr5avO9+Gqz3q47BsW0xQphf
 6luqty59XDkI3v8PGyzhZK2Eg0TJqephfJe/W32ceI4jiKrbKpNo=
X-Received: by 2002:a05:622a:155:b0:51c:1b22:b84c with SMTP id
 d75a77b69052e-5213ee77fa4mr125124201cf.60.1784539178253; 
 Mon, 20 Jul 2026 02:19:38 -0700 (PDT)
X-Received: by 2002:a05:622a:155:b0:51c:1b22:b84c with SMTP id
 d75a77b69052e-5213ee77fa4mr125124011cf.60.1784539177850; 
 Mon, 20 Jul 2026 02:19:37 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954995b78dsm174683335e9.0.2026.07.20.02.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 02:19:36 -0700 (PDT)
Message-ID: <e0a13116-ecfb-481e-a883-5c95e3b31b73@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] build: add optional librpmi dependency
Content-Language: en-US
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-2-subrahmanya.lingappa@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260714075659.2258023-2-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXxaPtG0mFgqlS
 Bt6RGklptyZ3pvO/5JJrJ+cW6b2nsNxXhHTEgJtWdP6qxYSKkmWeM/+VGvZRy1ZAIJG/6xeIqO9
 AvCmM37YjMlnllixPvCb9TB8+VinRKc=
X-Proofpoint-GUID: XmFZ6DuCal6uCBpz2U_ERKyKZAlA0Ry6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX4uDgLunebaMM
 JlZQa1mwaHOJJPERuwQt8DkYwGv+UYq6vXmsn093vN1gFHVxtzwMahSJ4pvboFfAhTbbvm8jNJ+
 SJPCE5G/zU5s350bHmBxrfQWhNE8kpi4AvAUr7F8xMVXYR+FtGktC9BhFudiiIB3YVMvJ34ZHX4
 xvVt2vfL5lo51gWsKe7B3vOtOINJiArpOseGoNQefhS+/oNXHlxGLKC7kznzqCDWIrYtBkkA//k
 xAzVBkea01lWvWogAH2T1GqLPXh25BUnumKJE/+NkTEQxpNaehyt8kbZzW+fuhxfdIjaScGLE++
 Nj33kxIVhIZov9pwOeSO2Sa8b/LN9KNMXMAFpOCwwX8WxtZYF6DMart4KLr7BZJwiz2evbR/R3l
 Eozg6fwAezzSF7JKDtX22yUbN/OUO87dz/SQu/12GgkEP6o2cakT8BXStk22aTJLMlnpRYAZOA/
 rlem16cJdZq/gIlbRnA==
X-Proofpoint-ORIG-GUID: XmFZ6DuCal6uCBpz2U_ERKyKZAlA0Ry6
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5de82a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WRReY8dDeiYyY52TRfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200103
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 14/7/26 09:56, Subrahmanya Lingappa wrote:
> Add a meson option and config probe for librpmi so RISC-V machines can
> opt into RPMI support when the library is available. Keep the dependency
> optional so default builds without librpmi continue to work.
> 
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> ---
>   Kconfig.host                  |  3 +++
>   meson.build                   | 14 ++++++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 22 insertions(+)


>   ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
> @@ -4971,6 +4984,7 @@ summary_info += {'TPM support':       have_tpm}
>   summary_info += {'IGVM support':      igvm}
>   summary_info += {'libssh support':    libssh}
>   summary_info += {'lzo support':       lzo}
> +summary_info += {'librpmi support':   librpmi}

"rpmi support"?

>   summary_info += {'snappy support':    snappy}
>   summary_info += {'bzip2 support':     libbzip2}
>   summary_info += {'lzfse support':     liblzfse}
> diff --git a/meson_options.txt b/meson_options.txt
> index a07cb47d35..9f773a7886 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
>          description: 'lzfse support for DMG images')
>   option('lzo', type : 'feature', value : 'auto',
>          description: 'lzo compression support')
> +option('librpmi', type : 'feature', value : 'auto',
> +       description: 'RISC-V RPMI support')

Either "RISC-V PMI" or "RPMI".

>   option('pvg', type: 'feature', value: 'auto',
>          description: 'macOS paravirtualized graphics support')
>   option('rbd', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index c003985047..e8a20068e7 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -140,6 +140,7 @@ meson_options_help() {
>     printf "%s\n" '  libkeyutils     Linux keyutils support'
>     printf "%s\n" '  libnfs          libnfs block device driver'
>     printf "%s\n" '  libpmem         libpmem support'
> +  printf "%s\n" '  librpmi         RISC-V RPMI support'

Ditto, "RPMI support", otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>     printf "%s\n" '  libssh          ssh block device support'
>     printf "%s\n" '  libudev         Use libudev to enumerate host devices'
>     printf "%s\n" '  libusb          libusb support for USB passthrough'
> @@ -376,6 +377,8 @@ _meson_option_parse() {
>       --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
>       --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
>       --disable-libpmem) printf "%s" -Dlibpmem=disabled ;;
> +    --enable-librpmi) printf "%s" -Dlibrpmi=enabled ;;
> +    --disable-librpmi) printf "%s" -Dlibrpmi=disabled ;;
>       --enable-libssh) printf "%s" -Dlibssh=enabled ;;
>       --disable-libssh) printf "%s" -Dlibssh=disabled ;;
>       --enable-libudev) printf "%s" -Dlibudev=enabled ;;


