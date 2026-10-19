Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059EDCCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjs5-0001mt-AZ; Mon, 19 Oct 2026 05:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xIjrb-0001iA-Sy
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:41:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xIjra-0004WG-2t
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:41:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PCRx2193384
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lw80XRv1geymiXBU0kHCn5VDsjJ8geZSwDWB43Kxya8=; b=QxaAKM23xRJ/qlTR
 7sGv9SpVbd/Cmff/wtwy1LxCU+Rt9oujic9oEGxe9YM+PBsSmI5Abw/CVNWYP2st
 tQprfxAgBsjQQslPkP/+cGQfIcdV9fv52R7gwgol+UJmwm8GTqrDdz9EL8zZs6zM
 OwyyfTSo+f9tOAEIi9sEQRamGhJBom1U1Kz2+krzcBccb+2na+dk5Wzv5qMsY3WK
 7/BJ0+dLNSwKl31/oqR1aCr5wmaqUoZkrwJLHLsKDfog8x+95gV2BAsMTONCPxjV
 Ec99ZSRqvxDJLUlCpmgr7p+MLrUBMlUi0GYCdPlYBrPwCjLLiCr3nTvwHWyliBSm
 OXGHlw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1a3ah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:40:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53635e21ddaso21787261cf.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792402857; x=1793007657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lw80XRv1geymiXBU0kHCn5VDsjJ8geZSwDWB43Kxya8=;
 b=jRkzfLW6jnWW7iu4wmfsSmrlOhoQaY2HAim7Hbinf79C3+3cHbUxxeWs0xVb5ds55+
 ZoGzYXXvySmn5YAJK20pF9gX/WIk7nf/pqCfcr3ScQsm/kb2bQYNrjo8dAdhkr2CiXWv
 i6d3+7JIIiTmq8FF6K2MPwhh6MluFm1VTZu3dH8DWl8U0VIa+ZTOhlEvrDzRD19X+YWn
 17NtdIqKmkWFX035EEx0KmY2y9lz4Vo+C1v5PPTkZVnPFvpL7vlGt6RuziFeMyzfHIfR
 aut7tx/yBnrNqMyEvVVibyCvuKzebZD3s3ZhRUUy66/dsg2gzwkfmQYU3FNJEa6BYcaB
 xkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402857; x=1793007657;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lw80XRv1geymiXBU0kHCn5VDsjJ8geZSwDWB43Kxya8=;
 b=bf8OH97rKycppCYnU1Dvsv0cYZryt6eAStK+eVrkOF0/yUxszeEZs9dM1NyA6LCcyt
 9vLJEOdafusIQV2MAtZ5h30OiU004UFsCZDLZd3kl8UQdXDy+s5Ie/fHgLBsyCh+xr5T
 q9K54aKmHnRtNhJuYfmGCVVDCEjJD/PXbC3Qxb3DNyCrxFKnkJQnvu5rzg9V8QXIegM1
 zJXgUsp2LetvNdRnKG2J4bPWLDlzPnpZu/fCPxcVSud/xKCebFa/sJBHUC9rGP5wnUfY
 669uZgbiJvaqlb+LCR+oyPdPrd0cXp6IWGZnYrkDWMoXVZeTmQCiRaJOuDpZPefSXwi+
 TIuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/n/kavCNKzgWnO0sdhzCU2aIc9FGq28GbeUWP8IWd3ZBVAjHFBjxzQJjIlDKu9nfaLRnwX/womcJC@nongnu.org
X-Gm-Message-State: AFq9FYI8BWqu1g5rHe89TmYwENdALbo/mkbzFbF6VbpLYVyrTU0f9uFU
 rsunxp3DVJcKKGoxP4ZPmnAzYiGLFS8y83Fx3U5nuVNKnHqlB5lV1yRnRRQVlPupOZMEXMTL1WO
 WCXo6ctN0u0vCUJ436BQtDl+0fU4aDoI76pBTHtv4Bb64mIjkgTYv/nuG+Q==
X-Gm-Gg: AYBFou1OV5mJPWkGZoTIjfWD65yAxZ4H1jTpB/DKJ2HWCCYDzRl+prcbPpCHlvtEhXP
 h7XBOLZsu3/FIvTqxXdKleoZ4niLZM/83rJS+UlmlXpevna7ANdYoOfLXB8vysfSf0zOOczBuN8
 CmfY2papqJwIOcdLEKBherC1ljbs8l3/SGN4N3a1mZMCKU4N9/HDoQBHdcoVbIQ1Rf9HL9HgymQ
 awkoFPFmD3GX9NtMy1gnmNKtGrNadCN6d+8zu9Cr0DEmeAA94Q9fvGFV02uSpY+c65HzeA/AloI
 4KQEoC2aTFBpwCLX8vUVoIo4QX8gRwIOPgHjMTxwdRuIl8iWLRq6Vj+ApuNFiddtqZzBsTq6pTg
 fY+AfN83vesDcjkmYa7vB5HcFOzauxGD9dfPgXuAgjrDZjgccdpYW5zhF+myzW2aybihm7x7T
X-Received: by 2002:ad4:596d:0:b0:915:e9af:3145 with SMTP id
 6a1803df08f44-91bdf0aaaa5mr128925746d6.12.1792402857237; 
 Mon, 19 Oct 2026 02:40:57 -0700 (PDT)
X-Received: by 2002:ad4:596d:0:b0:915:e9af:3145 with SMTP id
 6a1803df08f44-91bdf0aaaa5mr128925526d6.12.1792402856603; 
 Mon, 19 Oct 2026 02:40:56 -0700 (PDT)
Received: from [192.168.68.103] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcbb0b231sm93087826d6.31.2026.10.19.02.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 02:40:56 -0700 (PDT)
Message-ID: <8360ad12-6dab-44e6-a930-17ed8e92a09b@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 06:40:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261018230741.6560-1-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261018230741.6560-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX+Ho30CcFPsQc
 TWlZ9rA2BzdwsHzsb14OPqCbAJ5hcizmf6lMQ04x63+FIzuMSXuLR6OCITk4YUUUL4UcqtpfKd8
 0AaDkr2gkqJbE0zqCGrYbnSsl+hD2TA=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad5e5aa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Gv721ALbR4eKpHl3R-AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX1IHqi/ZSLlb5
 BPpbUpBL8OSgmCY719p11R1orrzaM8RQ1EDf6Nv/5rGQ05i/bI49MOBlw2zATyY3NR5QgzeK80x
 AKZ5wn2JNb6GEl3POJDLKGMPOKFYYj1bp0ztKveiUXq5d5k+cyRUgmi+7/YeU/8Bo9ryLh/e5Vq
 0LnmyVX7LogIWiF1vDTGrZXJr+8oDvaFJ5xlMqPHGxrAVZsl2kB2F+X2lAP9WALW4aONYO2LGDm
 e4k5HQpHaO46NhfCL0hKyXvrlF8ead2casMe3WqwHyIHRwvgUfHgRRhoHMCkxxy8WI81PmFLR0Z
 yUJHnCeMRpCyJaM3A2pQ/xxgOr4ikvjW56Rl8+R9UYxgQFYjS6Mlh2quCyPAviQKp2cE0im076T
 BNMsspQg9129SpnFYQ4m8zuhIFAQ/ZY3cuYGotIiUcEwPB+6ePfFXLToKmxSOfEPPLoy/8h3vGQ
 DjE+m3xhlyEazUG3JXw==
X-Proofpoint-ORIG-GUID: 4xlrevTfLBDHNaKr1MsX0k9ssQLUWl3o
X-Proofpoint-GUID: 4xlrevTfLBDHNaKr1MsX0k9ssQLUWl3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/18/2026 8:07 PM, Philippe Mathieu-Daudé wrote:
> RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
> for the release v10.1.0. Remove the stale comment.

I wasn't aware that we need to remove stuff from deprecated.rst after
awhile.  Thanks for taking care of it!

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> 
> Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU properties")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   docs/about/deprecated.rst | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ccbc4219497..368fa1b4ed3 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -349,30 +349,6 @@ the addition of volatile memory support, it is now necessary to distinguish
>   between persistent and volatile memory backends.  As such, memdev is deprecated
>   in favor of persistent-memdev.
>   
> -
> -RISC-V CPU properties which start with capital 'Z' (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -All RISC-V CPU properties which start with capital 'Z' are being deprecated
> -starting in 8.2. The reason is that they were wrongly added with capital 'Z'
> -in the past. CPU properties were later added with lower-case names, which
> -is the format we want to use from now on.
> -
> -Users which try to use these deprecated properties will receive a warning
> -recommending to switch to their stable counterparts:
> -
> -- "Zifencei" should be replaced with "zifencei"
> -- "Zicsr" should be replaced with "zicsr"
> -- "Zihintntl" should be replaced with "zihintntl"
> -- "Zihintpause" should be replaced with "zihintpause"
> -- "Zawrs" should be replaced with "zawrs"
> -- "Zfa" should be replaced with "zfa"
> -- "Zfh" should be replaced with "zfh"
> -- "Zfhmin" should be replaced with "zfhmin"
> -- "Zve32f" should be replaced with "zve32f"
> -- "Zve64f" should be replaced with "zve64f"
> -- "Zve64d" should be replaced with "zve64d"
> -
>   Block device options
>   ''''''''''''''''''''
>   


