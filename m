Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7568CC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoPf-0008Be-LX; Sun, 16 Aug 2026 23:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoPZ-0008BS-SI
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:53:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoPX-0007kW-Hm
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 23:53:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCvH2855667
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xVNbgi8gnl05s5qEntDqVNJSNfz+R0j0D1URc33VqZI=; b=OqzIVqVpcqTmPlWi
 YsC7oJFpbNFf0V1TBcyfIESrtpTjOHk4abR2xCf2GJUbq2TnieAp0p60upMHRFrd
 tYPfc98We2spKsmPtzcafTeZcSwBGZWkMAaDXj4ms621iSzN79NugZyNSoT57xaG
 gY6Y5QFMfLjcaynMQlrkogXysKNBGkfkJCZOs5TartR8zYYqwVS0nH2tAE0n0Sej
 i3PzBtgVjS3WzhpWoCd5nnrV3Gg4u1XlCA1ln4O8gVDLrM7uv2x+ZyUt5A7H7i2n
 EowAEJ9qdYqtwN/HXrzkPm4Mbrpnc619alBKiJQWpbynpOpb0KMlYenb5QOLL/XV
 PYXxlg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwn10g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:53:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so301776085a.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786938796; x=1787543596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xVNbgi8gnl05s5qEntDqVNJSNfz+R0j0D1URc33VqZI=;
 b=JivV4NzIKMn9kxssnLvp81L/g9zhO5gAsqbKJPYvYH4VmIOUuR4OD1RCrZNCY9uj/E
 DajrIUJyubkswxlElybNuDI6zajyPq8bt3aBEzBTpWSDL3jQJccoK2Gjan1iK7septnF
 rLUly9dnxp5QoavXBKFgcXBrelQFirxiSPaNSN6R1Arv9YaQ/WBn1VsSlI1n94BKfwtL
 OsVAeC9SCgKC3D+EMcIHr8ekh9ncIwEuiI78ROib7v2jH7LhHp4/iuzQRaI4gnPFbT89
 SN7J9Kzj3efrtBxlquFkt5hNt5uvBZlThiRMfGc8ahflJFexXObF08Dui7cX8IRTP4R2
 AU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786938796; x=1787543596;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xVNbgi8gnl05s5qEntDqVNJSNfz+R0j0D1URc33VqZI=;
 b=kUKe1hdRYRCynJ6hkgyHUZEVMlKHn253F9mzYUCjTmvW2D8DISlMO3YNBGyWmgM0T/
 z3LFVcGhuozMFoZ90l51OkNZj615ZwYakCJ+p+3tTG6NtVoKRMjmGHOIqoEJi34TNKz+
 pRbSeDBxYV68s0Znoe9ZYxReMgtXxa3jnCNvB5c9iHHMntxFeMz9I/fEKzWIB6fdOYxI
 2Ica0wGWr1hLvbuegqN+o4G9/RnMYgTZQaR0XnKUlnwDC9+aEMYd9J8PMgCb0fu0/N6S
 oJYglyDVjyeLx9QE/BJOn0WQoBftlI3gzYAZ8RNPEXKHgvfvNkFC+O53UxwQi0yfdofu
 2hfg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp1etWaIkaYZ4vvGpzVzbEUNUip0Xo9n1Zj+ujGV74E739LTGn1oYZJo6RjoB5SXyHwmxdb63N7DMz@nongnu.org
X-Gm-Message-State: AOJu0YwQgJMALbiqPs9AALEy2otIFBxM+d0C4ypPBKq0V2cDOnOGG/+D
 wgRUul+fk8N4e90MN38VedcqCVDNsrCz8X6es+JWPxKe+6rHYZ7eRrXCW+eLS+CuShvgZLnSnW2
 kfvrU2UKvmJ/VgrJFoyHXXtmAIBxdTy/GAvEbAR7mRmfjC9vEktcGy+3gBDLPuF7HJB5f
X-Gm-Gg: AR+sD1388ttb2wHk1C57v00alNk/5QSMuJorir4GneZMx7Ys00oQgkYVylp/WCe8iRW
 OCG9MmCS/DeGfQ4vnPQagubZNjHhyAdtBCHVMn0k3l9fj4ymvuC3vAHi5gSrqzV+sP5ZEFMKyl3
 bLeSsL8d8mGHCTKKvuRmdXD45o2NnLCR1rX13kn/frqC2qtUJCnTtcQoRrKciFD6cuz9axhnN8v
 mnmKlu64h6Z7xFRGXLrevV8IIlxepsgkFgOVDAKaIavpAhOwUODY2gvAVbF6jMXRzvM5D8eqxty
 3QsP2aPJF+GDTQy42MJ9XdKWO7O9aPHLNrPDlz47yKE9EvcoK6dOuoXv5DClfkDNGy+P0OPb3XS
 Z1RjL2qFXDnO7wGKp/Eedv8QZLNttcAYoqz8=
X-Received: by 2002:a05:620a:4442:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-936c07231e8mr2896190285a.15.1786938796661; 
 Sun, 16 Aug 2026 20:53:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4442:b0:936:a8a0:cdf0 with SMTP id
 af79cd13be357-936c07231e8mr2896188585a.15.1786938796279; 
 Sun, 16 Aug 2026 20:53:16 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c603sm376261f8f.21.2026.08.16.20.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 20:53:15 -0700 (PDT)
Message-ID: <26d7e5e0-fcdc-4051-bc5f-d06b4decf1c2@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 05:53:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/49] system: decouple qmp_inject_nmi() from Monitor
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-7-e53fc35bc550@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-7-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RRQwJnXOAgpHSXo3YPZBCs6iEv6Js3Be
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfXyQxIgqtNjSnd
 NnEKqWpbDttxOeSW4pYEAQGDSijH6UKMKBU9hFXlH8YK6AexaBN3yIxVKcf+Vm1Fb0Zw7F0yfjN
 woA8TF2KEd0HZ6q9kVBz7pN5aMF84hSJHpeUsA9vv/xVdEZOTZwrb/Hgp4zonM2WB3fZi34NNgs
 JmWoIPYuKu+JCM4yNlOHbKCsC1CQ4M7fmtP8BcqZ99P6p/koY94urR+PvTtB9xTxOsKhQDqDSTo
 5xa0HIZj6V5R+8wNg1c6VJLi6QoVrmF4vOt9ddQhQvG3XupE3en/3UtEQBOfgNWGXecJPkHBJAN
 qfK18/t69rd2qeFKvikeuRCzLomSr00QHs/HTLswF9hXn9apbxYaSRlBuE9CjXZV/TJIUqHejHO
 SPVN1Zkotc02Fg4bdU9szJ5Jn7sbBJzTpMt6x4MipK8Debap6nZow9vp44F6yX5SQJSTggcYxiQ
 aB3YBC+ak5opGy+6LNQ==
X-Proofpoint-GUID: RRQwJnXOAgpHSXo3YPZBCs6iEv6Js3Be
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a8285ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=kgZFkM1rrgPjQoUPX_kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfXySaYo9/D7H0j
 kM9d8bHgFqHMZW8WjWEuG+HtULiEg1RI1DJhtSQ1omdpIDQbniZO3SMBseg11zH1XEcdvCZar0m
 otemUbxC1GLYaa2JcDpE2/8D10oD9+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/8/26 21:12, Marc-AndrÃ© Lureau wrote:
> Use first_cpu directly instead of going through monitor_get_cpu_index(),
> as this is HMP-territory. QMP doesn't have a `cpu` command, we should
> add arguments instead when needed.
> 
> Update the inject-nmi doc to accurately describe per-architecture NMI
> delivery.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/machine.json | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 2d63c1bac3b4..29ab1cb9d7f4 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -432,10 +432,10 @@
>   ##
>   # @inject-nmi:
>   #
> -# Injects a Non-Maskable Interrupt (machine specific: for example on
> -# s390x CCW only the first vCPU receives the NMI, but on x86 machines
> -# all vCPUs receive it).  The command fails when the guest doesn't
> -# support injecting.
> +# Injects a Non-Maskable Interrupt into the virtual machine.  The NMI
> +# is delivered to all vCPUs (x86, hppa, ppc64) or to the first vCPU
> +# (s390).  The command fails when the guest doesn't support
> +# injecting.

You can drop this one.

