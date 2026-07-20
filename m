Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F205C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllq2-00008c-6M; Mon, 20 Jul 2026 07:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllq0-000061-9n
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:07:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllpy-0003jM-OK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:07:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvm5K2277812
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sJv7+Gv0zK/wu1dnqyCdssPDKIHV7fNZoHB2V7OGyGI=; b=I/t6YE1D7ed/swI3
 dcb4Z0Md15H4elB05Kt8U7w7sFCJ62X0FW8eLH37sJO6Q+HG9degCqHFym1C3IOC
 rBPXN8Jd/NDPRXqKyslnCCcSWN/YeSUjp1f2IpkjZfbDb6/y5iRqA3pbKzD3sgOZ
 K42ABVI+JXUCB6+KX3CoIusQqJu3uJqZ1yNv/qvFZmMpSNMprX0zChaIWECcrIvO
 dGI7VRIt/mXhjCb+qrgKY5beBspHsyA9pYBQSheVMUxeIrxXjJrsXTvktwhZukvb
 cqsSYfloZmr7phtq4jd/rZ5mrG/MpM8cNreukQcRkwcVIvp3+5kVrmrwyDKOpkon
 JTGfdQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c149t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:07:05 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-668687d4fd3so257272d50.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784545550; cv=none;
 d=google.com; s=arc-20260327;
 b=IqsEFr95BU/38lhHPD4pDOJfQ2aMnzyNwHerAyzxlWF+eGvBy9tnUlaPKuO6QUXJwg
 xA7F15JVpDFa57gtpzNUPVQyivc3St9dTm1+aq6t+MkkB2X1jnpeN56XhbLWfd3n7ay1
 1lmwyVy1UB6xj51px+IXZNgs2EW9gaqZ0h9A3fV72pceCyaVmqlzgJuW+wopsrKjjJmv
 ZsXGA481CdhFYEIX24AUP14NjNFrlzxxvwBsfhoCzEmqkJBjdPmL2GGll05FRszykNt4
 nEuBRr7rLaVyMa9AEOIeRNx9Y26rSH/qd/n9dYQA2IDIIUo6vuU48I5cWH86sYPThYN9
 LDLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sJv7+Gv0zK/wu1dnqyCdssPDKIHV7fNZoHB2V7OGyGI=;
 fh=7aO39Y/fN5rUr0hTAbk1Psdch+H0oPBTsDjX83dWuBI=;
 b=MTPu9lPHaeksIPH1fW6w706JD5vPAlHxvniyuvnEksWMh7gO0euh2QsjMiJB/Ibsiw
 Y9vaH4Lx3lqX12q0r3zbt3/baMz0LcScb5y2dctlpm8Les7cqfyfXzUDHOf5/u3tCJHJ
 IYAWpQuEA7wB/SxsMjj5o8ABelVIbkbQep2h8Pb/i0SDFe4jNgvaXSOwGqbdrPGePadT
 KDzxf1Q0ZTqtp0sa+si7lIYIu3I0T5bz+5e9ZjsSqi8I7KnpI26zsZ45c9C7GR0UzGl/
 lvQtnP21uTFlkwKGK6b9sSFRChAo1m1LjMzC/9r3rpabnUUHHQx2gYOL/Jwm1+jyjSuR
 qHqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545550; x=1785150350; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sJv7+Gv0zK/wu1dnqyCdssPDKIHV7fNZoHB2V7OGyGI=;
 b=SUq1NqgaOzkMGXDjsK8+OTntG6+zOPMJ7LpPTZOMctPalcy7Q5uAjAia7vMIrRvCN0
 n52SUEmzILjLsMPr0s5PdRNSEzpzCALPqPTTZx6ZMJPCsEAA/E0B+jNb4vxIWfZeYgnU
 4NV88gUBXZ7xfHigjBgWILJsW4I9Xa754qu88D1vE781UAleLTHGqydCrFR67CMHXIcg
 uAKRnRnC/8R8th5ulB/I1Gt3Ky26UEFCMcLwAt1ccisVMA2t2mrVp8qdkY1EoyeClJxZ
 ywNbbjvt+aVBwsJdU8uuyKfLQXMt+U1F95iNKQBwqKOyvax9IHlgc6QO8acIRUvNHIm/
 sPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545550; x=1785150350;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJv7+Gv0zK/wu1dnqyCdssPDKIHV7fNZoHB2V7OGyGI=;
 b=AfxFsOvSzRUsZoi4dmMOYhZBVPD/2jhtUKsk2BgOQqqttPs8cdUzpcx4Tgoy/1Qksi
 TWWnTr1/b4x6gjWbcyU4fO6kwSgYqYT11lKbqUcL3s51mFRj/3dg9eiVg/ci+rOACJkc
 sj+vhaTs+xIu2fqq+bOqpwuVpCzPNUyckYZoO1TTtEDiVEyiJJXMQZkYUO3jyuj1qQHe
 L7i+Mkp+gDwn5G3ZJVlB0Shu9w8THOYAcDZrBNQcOwmksrbiAyAu6BD04Tq9wuybIfeP
 60v88yR5Imt6ujJCYzSKk96Pg5+J8aZKRMJ9hyzdW+7bUJIP7fFZl34DA10iSncwXFi6
 gnmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKYnK2wiRP0rhjVQZGFmxGpOB8pNW6Y+47jmNfxuRBAdvJJheNdWk+0plMwdHM2M7WOdU9VmfTV/ec@nongnu.org
X-Gm-Message-State: AOJu0Yy+8m7Pj8GuGLiKXYPbuHEy9TxRVFbIQLmqM8tCLTTJk/zr2sTE
 oaz7pICWZS10EfduOxfcza3KRqYh3OBlhFJA1vOUQRtvpmaGwPk7Qh5beilv4N52dRn2gPl+JYG
 abY6IGy5rjZK2CxMdp6Kw6K2woYYEct4aFGIFqDH8G5ZIJHjyNDeITF4RD8+QRcB3vCGT9G5dBt
 CBcA/tMgGmTaKekmei4pV1SymJ3wQBzrQ+
X-Gm-Gg: AR+sD11YQru/gJ/9hhr3SHC3NcsKd4na39ODOLMVTM8uloBLQ5/xwhE/tb2zo/JLZU6
 gUmrRhEZ+hM9ynyOmHZ2pEHM2T8Y3xqkmgQfUakGCKVNai/umyPUw06IohaoGic6iIgG5edW17b
 bgd606VyPkK1XxjDoVy3EQE1YNnkaZZt1dSfv5abNvOtMD2go+Q6VkzE+Ox+c=
X-Received: by 2002:a05:690c:9990:b0:81a:ea53:c40b with SMTP id
 00721157ae682-81ef2672ae7mr44629457b3.8.1784545549824; 
 Mon, 20 Jul 2026 04:05:49 -0700 (PDT)
X-Received: by 2002:a05:690c:9990:b0:81a:ea53:c40b with SMTP id
 00721157ae682-81ef2672ae7mr44629357b3.8.1784545549432; Mon, 20 Jul 2026
 04:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260714075659.2258023-2-subrahmanya.lingappa@oss.qualcomm.com>
 <e0a13116-ecfb-481e-a883-5c95e3b31b73@oss.qualcomm.com>
In-Reply-To: <e0a13116-ecfb-481e-a883-5c95e3b31b73@oss.qualcomm.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:35:38 +0530
X-Gm-Features: AUfX_myFHzKRRGIWqOEBb6DNVLSBLify9UnYarl8reLlfSA9wltntYQmTVaiOLI
Message-ID: <CAPxK-6fRW7gXXcpDmJqDwc_19uUDnRiOPR0R5bmju_a8+DL+zg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] build: add optional librpmi dependency
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5e0159 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=LgkO7a-NOqtw3HH30u4A:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: 8BRwbjyI5R6hU9OIloyRCXXl73UfJbvY
X-Proofpoint-ORIG-GUID: 8BRwbjyI5R6hU9OIloyRCXXl73UfJbvY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX1Vkof+8GDsro
 Jc0eMI5DD5zXpx3Zf0fOflqnQxOT1lv0QAG99u2rw0dHpSBu47deIahwIphJSknDxylMWhI8qEV
 J7E8Iwz/ULP77szDMXWNGwRnuf1p0UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyNCBTYWx0ZWRfX//Rh0c0YLszN
 +mYYo05stlfgFCdJWIZd5nOhSK73swNMKYzrovUMXQ46l14tofjQoGVLr2GZAmrwzfNJSEvVYRs
 UFVNA/kbMrqZS0RslcBtnjjBTBIrRsM84KZd7jdzqoEJBg9OM2Z3op36fTTVKqrzwiDOi1WRTLu
 ncrOk9EppuKnJZ3NCV3G1Y4+zxxSDprOi8NT+sTLws9t06X5SLlsqeWAm8gkoiWLvT9kbd/lqv1
 LlR6g4jmsjMUARADb0DSMXAN6bCUozdyJ76qEufP3Wj9OOvwiI6b2bEKJllKQStWwWWD5yMEmO6
 6Y8tYHiCXvn2kuzp0frUeuxsOXD7eznGnulFXobLnsgHb07A1ItYPAl7aWFdX99bq5pnRkMfv+1
 HUYtIDo/FhDUrthQTgTl2XuLO25FeovK6ln8hF9XRnwF8A/pncNTLaH99K2I63DjniCRotwgDdn
 W1+KIEitu41H+DVPnzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200124
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe

On Mon, Jul 20, 2026 at 2:49=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 14/7/26 09:56, Subrahmanya Lingappa wrote:
> > Add a meson option and config probe for librpmi so RISC-V machines can
> > opt into RPMI support when the library is available. Keep the dependenc=
y
> > optional so default builds without librpmi continue to work.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >   Kconfig.host                  |  3 +++
> >   meson.build                   | 14 ++++++++++++++
> >   meson_options.txt             |  2 ++
> >   scripts/meson-buildoptions.sh |  3 +++
> >   4 files changed, 22 insertions(+)
>
>
> >   ignored =3D [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
> > @@ -4971,6 +4984,7 @@ summary_info +=3D {'TPM support':       have_tpm}
> >   summary_info +=3D {'IGVM support':      igvm}
> >   summary_info +=3D {'libssh support':    libssh}
> >   summary_info +=3D {'lzo support':       lzo}
> > +summary_info +=3D {'librpmi support':   librpmi}
>
> "rpmi support"?
>
> >   summary_info +=3D {'snappy support':    snappy}
> >   summary_info +=3D {'bzip2 support':     libbzip2}
> >   summary_info +=3D {'lzfse support':     liblzfse}
> > diff --git a/meson_options.txt b/meson_options.txt
> > index a07cb47d35..9f773a7886 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
> >          description: 'lzfse support for DMG images')
> >   option('lzo', type : 'feature', value : 'auto',
> >          description: 'lzo compression support')
> > +option('librpmi', type : 'feature', value : 'auto',
> > +       description: 'RISC-V RPMI support')
>
> Either "RISC-V PMI" or "RPMI".
>
> >   option('pvg', type: 'feature', value: 'auto',
> >          description: 'macOS paravirtualized graphics support')
> >   option('rbd', type : 'feature', value : 'auto',
> > diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions=
.sh
> > index c003985047..e8a20068e7 100644
> > --- a/scripts/meson-buildoptions.sh
> > +++ b/scripts/meson-buildoptions.sh
> > @@ -140,6 +140,7 @@ meson_options_help() {
> >     printf "%s\n" '  libkeyutils     Linux keyutils support'
> >     printf "%s\n" '  libnfs          libnfs block device driver'
> >     printf "%s\n" '  libpmem         libpmem support'
> > +  printf "%s\n" '  librpmi         RISC-V RPMI support'
>
> Ditto, "RPMI support", otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>
> >     printf "%s\n" '  libssh          ssh block device support'
> >     printf "%s\n" '  libudev         Use libudev to enumerate host devi=
ces'
> >     printf "%s\n" '  libusb          libusb support for USB passthrough=
'
> > @@ -376,6 +377,8 @@ _meson_option_parse() {
> >       --disable-libnfs) printf "%s" -Dlibnfs=3Ddisabled ;;
> >       --enable-libpmem) printf "%s" -Dlibpmem=3Denabled ;;
> >       --disable-libpmem) printf "%s" -Dlibpmem=3Ddisabled ;;
> > +    --enable-librpmi) printf "%s" -Dlibrpmi=3Denabled ;;
> > +    --disable-librpmi) printf "%s" -Dlibrpmi=3Ddisabled ;;
> >       --enable-libssh) printf "%s" -Dlibssh=3Denabled ;;
> >       --disable-libssh) printf "%s" -Dlibssh=3Ddisabled ;;
> >       --enable-libudev) printf "%s" -Dlibudev=3Denabled ;;
>

  Fixed in v4. I changed the user-facing Meson option/help/summary text
  to "RPMI support" instead of "RISC-V RPMI support".

Thanks,
Subbu

