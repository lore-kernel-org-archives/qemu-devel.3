Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0C6C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTS2-0001nR-46; Mon, 24 Aug 2026 08:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyTS0-0001nI-NK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:06:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyTRy-0003oG-VD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:06:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMeTr3195004
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xKgEiWiffeZ2KZXRG9zjUKMLyv8x/cjnXuQv8nvpJSc=; b=IHDNyJ7zgJT63fzD
 gT/+jnDEVkr6xdI6919ORCv9VqxYWblAw9sbvwjCwvV4GNZ3DSHbjcStcNM4Scqg
 HLX9855BOzZcWTU5go15LK1AtmbSDAJN5enFmdgMP11633goOhpWkL8t9GI5lugQ
 6FelThYOp7x1m/gTswdBJFVIHXoy0o/qtOAT2ajfd20+YVmfVKShza3F6tJpTUMv
 relOmlwpTbrCOSS4vOP5jRtPuNazOgr1wpQ8BYAhPqFCGNwB60TXv7HErcxXrqV3
 SHS1S5FhUr6ySoSteaaZxbH81jlPpB/anvncXjotRZiotUKkwiYB2CLfI8yN16xy
 6HeMfQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgs4vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 12:06:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so18222236d6.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787573209; x=1788178009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xKgEiWiffeZ2KZXRG9zjUKMLyv8x/cjnXuQv8nvpJSc=;
 b=aA1X/uu5RukObaNrt0WcPM927aEiKuSUZw2AhIPJ5/txAufccqAXkwMWG5YDEsNjHt
 EaCT/jmyQqWNRtSnriEZiqiFHretrgs9TGNW9QoXcJP3zAKOyzkuVI75XaDGpEL3I+vA
 MHQ2XLUf9G5HudZGCpcThUGAuSizNxrktP7ANlBBjkEgWxADMjHPZNfmEk8EDPhv/VJk
 ZqgjEzGjhyFCrcDzwLIG8b/QiI7ppERm2PgS484gO0cgrBc5s5YTgkV3R6ueHeU0bBHk
 SGkIosfK5CbyTXpl+m7EcDw0tc1AH9rvT+3XC701SJTzeKecO2+CuQ2RMVZ3JbBDEE+X
 7cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787573209; x=1788178009;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xKgEiWiffeZ2KZXRG9zjUKMLyv8x/cjnXuQv8nvpJSc=;
 b=a9jR8rb+ezq3Wlploy76aJgByWcYnSNcCE47N62dVnFr0SSIuob+S3qe89C/v6jQm9
 ApzE1Mbq9/yd0rYn82CJjcANhfia73tIE8yiG8UdAhfGvk+E81Zxcyekot04qxo4WEJC
 Lo7tEtssmJRTTqLVWpnuGg3LXX1z0FFZrIm/aGAlYG0/5YSXF/2sSy8XDCFtccoQ1wJO
 3eKL3wnshen2s/fmDIdfMA4wWffAGo0ak9uKz9PRhODYCfDy5oh214poAkS8lAjNkAc+
 yAKBdbuY5J8xCiXGe6m4YiNPUP/QFlyBBqOLgESImxFT2LWJsrrlk32IVXvJbeo0UfAY
 NXCg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+UwUFvY6080+fcDuMbt58ar/hNmhq8jgzdZ41ijsexZz7b6z0N/+TM0g8Kq5KXtQvY2EACp/Gt9bB@nongnu.org
X-Gm-Message-State: AFuF++mq8vbZhuz++FwcMT8Stc4naesy44otu7NMhl1EyuMwAn2m2s00
 TOWff4bixSIP0QzdhZReUpMKYYlu+wx8nf39qBWhDn4ovAWRqmYH0qhNSAd9/keEVOHE23evnFo
 AMnvF96Z6NViTed3BwHZX8eL+A7kSt0ENiulcGB4g0NOMiIuunrgUWFPpAQ==
X-Gm-Gg: AR+sD123Q9z0UAR4r/bgQimueb88VhvV80Ldf7J+49S0PQqiFO6Cvo3XA6JBNeukC5n
 dNWwaaJ0b8VFF9i88TF+RvgC/pz+PHvQ9eHCTyqv7DpHL0ULlgSiVHRo865hY4zb5us3vGa+zJD
 BZwQxW12npVt3V6zJkEVrqWqTBUvCR5SZQJM2dI6jmZ7ndi/JJrMCUUEHUnMJRKEl9ISHUkQveh
 vRmt+JkFGwL3BrBgNHskwkKnDHNFAd8pnlym5/bcZwNwJw3nc97honatYoyJAcTVPPSNl2ymI4X
 MPqDIoy7l7XcMqv8NdR8Q/yf4z56BQBLLFNh3AS6a1e/bPY/YofsLSLjseIjdK32GNgy7W3BOmC
 8qDB57gxecX4Vb1kSl1741cu217TFBLaVQget
X-Received: by 2002:a05:6214:d6b:b0:907:bf2a:481f with SMTP id
 6a1803df08f44-90c809430dfmr263412806d6.1.1787573208700; 
 Mon, 24 Aug 2026 05:06:48 -0700 (PDT)
X-Received: by 2002:a05:6214:d6b:b0:907:bf2a:481f with SMTP id
 6a1803df08f44-90c809430dfmr263411746d6.1.1787573208173; 
 Mon, 24 Aug 2026 05:06:48 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c93a90735sm59628836d6.47.2026.08.24.05.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:06:47 -0700 (PDT)
Message-ID: <faa2fb8a-063f-41c9-a1b2-e2c64b8e1809@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:06:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix LCOFI masking in sie/sip/mvip
To: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813134002.862578-1-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfXxAVCnxYB27y7
 bQ9qooSd3avtPdrOFASxE45QMUQ8wWJOYFeqBbsQz304qyeORMFr72ZT2OI+pFQcOQtaFh+yaaB
 7rqb5NbVfwK7zIcpPwEDGrc41Vv8vlY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfXzLzAM89qsxHP
 +epp7cNzcsKQm5O0rCNUrDKbt4fspoTW1ntRuTdcXJ6NLqxn1sl0uYARDubICAKCWn11IhxC2/H
 /xFbUeJdXI3mgY9ENLg0+cLYFeJEelt6PBjfT5wBJqfPo1gH7aIX+xor3D1/krknX3DDWN4AQwC
 /7750pKOLv8+vhE2kl29RLByxlZHMcEvzlaYLN6lAHfZuTYiru1pCwAPMR3NC5BoyT0EMJ4VUJ4
 bbizNrxx1gQfNpYTSsJ0Oiaq4YqDhJst1h0LIK2cU/MAXZvPQqz5+dwHvzIPv7c6YHWBDelJSuc
 cL3dRRgrXH8COUKTPNYZn9syOKE4refWmM4y2ujMIv1MPN/iqa+IDff1au0GP4ZtNuL8t/LFsBi
 QiR86HxDzfqZSGc9YE41lkrFIkpv+C+gHt4L9rjayRY6apuKGKmaXZ3cW4Xd9sYcteVJ1XzuwQ1
 iyEIycqwFja/Z3mjkkQ==
X-Proofpoint-ORIG-GUID: HyW4tp3Mt22u5ufYco-DRrIMAFIIK8Hq
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c33d9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=WmrVEKmstOSfcGThU8YA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: HyW4tp3Mt22u5ufYco-DRrIMAFIIK8Hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/13/2026 10:40 AM, Mayuresh Chitale wrote:
> Commit 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
> dropped bit 13 (MIP_LCOFIP) from the supervisor-visible interrupt masks.
> As a result, with Sscofpmf enabled and LCOFIP delegated to S-mode, the
> overflow interrupt would be raised in mip but never delivered and hence
> perf sampling stopped receiving overflow interrupts.
> 
> Re-add MIP_LCOFIP to all_ints, sip_writable_mask, mvip_writable_mask
> to allow it to be writable again.
> 
> Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
> Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index c05c8ee076..ca68c1f5f1 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1890,7 +1890,8 @@ static const uint64_t delegable_ints =
>   static const uint64_t vs_delegable_ints =
>       (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
>   static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
> -                                     HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
> +                                     HS_MODE_INTERRUPTS | MIP_LCOFIP |
> +                                     LOCAL_INTERRUPTS;
>   #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
>                            (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
>                            (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
> @@ -1936,11 +1937,12 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>   
>   /* Bit STIP can be an alias of mip.STIP that's why it's writable in mvip. */
>   static const uint64_t mvip_writable_mask = MIP_SSIP | MIP_STIP | MIP_SEIP |
> -                                    LOCAL_INTERRUPTS;
> +                                    MIP_LCOFIP | LOCAL_INTERRUPTS;
>   static const uint64_t mvien_writable_mask = MIP_SSIP | MIP_SEIP |
>                                       LOCAL_INTERRUPTS;
>   
> -static const uint64_t sip_writable_mask = SIP_SSIP | LOCAL_INTERRUPTS;
> +static const uint64_t sip_writable_mask = SIP_SSIP | SIP_LCOFIP |
> +                                          LOCAL_INTERRUPTS;
>   static const uint64_t hip_writable_mask = MIP_VSSIP;
>   static const uint64_t hvip_writable_mask = MIP_VSSIP | MIP_VSTIP |
>                                       MIP_VSEIP | LOCAL_INTERRUPTS;
> @@ -3953,9 +3955,9 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
>        *  alias_mask denotes the bits that come from mip nalias_mask denotes bits
>        *  that come from hvip.
>        */
> -    uint64_t alias_mask = ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +    uint64_t alias_mask = ((S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
>           (env->mideleg | ~env->mvien)) | MIP_STIP;
> -    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +    uint64_t nalias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
>           (~env->mideleg & env->mvien);
>       uint64_t wr_mask_mvip;
>       uint64_t wr_mask_mip;
> @@ -4188,9 +4190,10 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
>                                   uint64_t *ret_val,
>                                   uint64_t new_val, uint64_t wr_mask)
>   {
> -    uint64_t nalias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> +    uint64_t nalias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
>           (~env->mideleg & env->mvien);
> -    uint64_t alias_mask = (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & env->mideleg;
> +    uint64_t alias_mask = (S_MODE_INTERRUPTS | MIP_LCOFIP | LOCAL_INTERRUPTS) &
> +        env->mideleg;
>       uint64_t sie_mask = wr_mask & nalias_mask;
>       RISCVException ret;
>   


