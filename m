Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84C606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fKiZwa3j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NlVKWM81
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJI9S-00027G-HF; Tue, 20 Oct 2026 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJI9Q-000270-LP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 18:17:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJI9O-0000cK-IP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 18:17:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtbLx2222514
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 22:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xu52ZTgZcuxc+ebFNIRbIgkwwDxboywZPY5R1YwB4HI=; b=fKiZwa3jkFop0NIC
 uoUKtBrAURFRVBRKlKf3MltO9FSe2VRUHGwbfKnj7pVw+OKFvhN6gyDDlZcm8+Gl
 5THWJolyzLexwW9cEDBTHA7kN9cVxKYmPIIlfK1duUBExjMawqDBbeQhhWlhooNq
 fnXFgUvcycJofXowGcNWA/h0Lrsq5aaTK26ZlBPCLf3fMcOVhQF0Nd1fJTopA4ov
 Ll10/C3KjKXXrgGU8tNbDH0h5Yc21T0wCmYs75w4fDaxjMprEoJXFSv0sI+b0jfe
 FLMIGRQ9vXaULEpKzBN2FAo8f4ZHS8KGBLldXXSlZQ94bEBKbRfXBM7dxUyOl6pq
 4xJyRA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0gtqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 22:17:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c902e0da2so1456802eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792534659; x=1793139459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xu52ZTgZcuxc+ebFNIRbIgkwwDxboywZPY5R1YwB4HI=;
 b=NlVKWM81J/dCryvNRK+PftwckMUBD2ehAJ8KdZ/tma+SYRkN53GN7iXlPgNCWcIFhP
 JTIy34ALxcPrSsuOD0V9fW7pVAbhmbJeMLIGeGcFTVnTJRSPBLvSXsG8Z9EnREyoPAp2
 gRixoz5Alxj+4RhQnygc3vONMOh+PAm2MSJ5yHO7JLnkwmWL2eXFYHyx8PUYFjdcHB2V
 hcY7zQBKYaVnJH9HzB1h4x6s5X/qj0Qg4h82aLOk6XTibj1k5hL797+8HWCbCmN9kdJP
 D7ygBADVSTBMynuoUAFsYsm8j9KChsYaSQJCk0e106OKW1f+whzWAactyyHavB/GCgpw
 NoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792534659; x=1793139459;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Xu52ZTgZcuxc+ebFNIRbIgkwwDxboywZPY5R1YwB4HI=;
 b=UUyAAFjtcMCvwGMrcU/ExVd4CueYvzN6PPz2pL7dm/WMF8sKfjbAXUVuqpXbgG7ZvL
 ccLRjYKcHFoT+6J5VD0p9njwtP83WL38h2qXoZ3/Be502M1XMeyvpc+lBcgy9Ts/RMfo
 4cdOpsH3xVSSd+TB5PEKjwUhXumfa9rGcxwlIoDm0d+nb//PVxgsg+YruOJoS5Xwr5xc
 Oe/SkQDaOCaQQj3MCyJ8Mm2K1PnyuDrspfthd1k/J+OdV2oLZ8fR+NeXNtqVPzA5EqrD
 xi3j1tOiQonSa7zS3QN992E/xsnjn++H4fShsPDBp+iuJ+2e5YrS/5VOkDoJDpIijBCq
 nZvA==
X-Forwarded-Encrypted: i=1;
 AKwUvByd2SXLdmPvWT5QfpczrTJjS4nrji/Weq6LFHckB8S3QwyabmQJ2b3TTlHVY04SRBbKvr5nxMiSrsQX@nongnu.org
X-Gm-Message-State: AFq9FYKIf+waSFWGL01Kl1FM0GN8bF3K+CBFoL9AODdjW6QRpXP1CHv0
 3xeNEmBqCfLmwuwhb0NOR/neY4Y3mAYOy6aaHlIkgtxOekRu7vyIjMR4vEPAiVVT/7LX2e1UGaM
 7CmjAHxjITd+40+Id2hfESqWf5XPg/i3bxv2mztZ4xR8qzB33Jby//itVEA==
X-Gm-Gg: AYBFou1Sdvvn5sEj6cyqwMGZnBArPYEB6htNfL+WKRTKy4Gx5pffHTGlW7DWgyN2tMJ
 4P82WREkavDivbtmNgXSSCZEPArjptcdr0XYhPHmsHfS+gm6scl0i6UB/giMWCUx3iylOyJicZn
 L7UDqTIu5OZCQkvy+968AwA6WrpIr1e5QjAeXxnl/IvTOnMpcwdwkYhwxMcaYrCMKH+44x6v0Rw
 sT8EHtg4IsdyHRYmxXnMk8L24HU1Xt2DUpUSGIzicwuWmDpqnSxwO5x5FSHMFz19nEaD/1qmKCB
 6XBzuILF8zqe9TJV6iqYqtyUGlQ1u/XjrQnHWbMe0V0h+HneNkMpSgkt4VVQ6RopyIEwm7ljPPG
 UNyQOjpNtWPLPphvYQ+VrP9CVzU0lo0uBeKyhke7XSNX5uWGk2CaH9I63kdrCATk/pEs6+A==
X-Received: by 2002:a05:7022:b0c4:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-18dbed5047emr4237518c88.12.1792534658587; 
 Tue, 20 Oct 2026 15:17:38 -0700 (PDT)
X-Received: by 2002:a05:7022:b0c4:b0:166:fc9a:11b3 with SMTP id
 a92af1059eb24-18dbed5047emr4237482c88.12.1792534657929; 
 Tue, 20 Oct 2026 15:17:37 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903bf5d0a1sm1242338c88.14.2026.10.20.15.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 15:17:37 -0700 (PDT)
Message-ID: <964aca4a-94e7-43c5-b0ed-dbc04f0c0fd4@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 15:17:35 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/intc/hex-l2vic: find the next pending irq a word
 at a time
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261020022955.3662627-1-brian.cain@oss.qualcomm.com>
 <20261020022955.3662627-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261020022955.3662627-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4OCBTYWx0ZWRfX69Qx7bxYPzbd
 QoCVC9iusaaQmWVUfv5KbTio7JpEMShgXA0yYv674sLQ5PXSstU58+f3+yNw1RsXptowtiD2Xic
 WOdJ3iYBcZs4cXrRSGtxJIYieV2WAm+OleNcyHJuuaJPWsqIIosbqYUxmjR/31jHNfiHXNHHRRo
 0ddhxoxxmlA3648eU+3K8ByZah2aogfL6SLpvD1MGmx2vLELUPiuhK6RkQZzk8YEWjzQVkvhOPN
 rt4VeJedxPx/C+3aiXCcXEaMBzHyzOxRkyXeeznm4Rot3qp1XGlYxycDVSHvLznW+ub6TOPe3mV
 RAafBQsYlkspAmjqC46cprg1kM3mNAfPMwK6Yd5n5LKe+wURGy6ZbMSyNeJvolpLCGcESapm9bO
 bLx+l4dOAPkfueZovv5K+9KZga+4C6/btv0lvYNz/rd9MSZo6h2JXbO3GFVW7VxAVIUoEnq3DzT
 w0axax9NQXy2xaa3pBg==
X-Proofpoint-ORIG-GUID: eFdREVcTeNS4xhL_Nzw1DJnQiitehjwr
X-Proofpoint-GUID: eFdREVcTeNS4xhL_Nzw1DJnQiitehjwr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4OCBTYWx0ZWRfX2kU/6I3BDcJx
 4wAdUMkT6g0w8mQlz48d8EQFdvLb/PD3TaKg1SO+XrQ+5093TanlSbqTtIeJYn3O1w5eekFrslc
 qcHYTW8xBjfSOUT6XQNt8edp8N2xI2Y=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad7e883 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=d3ik7FBoytx2BvnnMTsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 7:29 PM, Brian Cain wrote:
> l2vic_update_all() called l2vic_update() for each of the 1024 irqs, and
> every call rescanned all of int_status for an active vid.  ciad runs it
> on each interrupt return, so this was a hot function for an OS boot.
> 
> Check once whether a vid is active, then deliver the lowest irq that is
> both pending and enabled by scanning int_pending & int_enable a word at
> a time.  The delivered irq is unchanged.
>

Looking at definition of l2vic_update and vid_active, indeed, calling it
everytime is costly and cause a full rescan or irq status.

static inline bool vid_active(HexL2VICState *s)
{
    const uint32_t size = L2VIC_INTERRUPT_MAX; => 1024
    const uint32_t active_irq = find_first_bit32(s->int_status, size);
    return active_irq != size;
}

static bool l2vic_update(HexL2VICState *s, int irq)
{
    bool pending;
    bool enable;

    if (vid_active(s)) {
        return true;
    }

    pending = test_bit32(irq, s->int_pending);
    enable = test_bit32(irq, s->int_enable);
    if (pending && enable) {
        ...
        return true;
    }
    return false;
}

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/intc/hex-l2vic.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
> index 736f1be3b1d..86d2be6a744 100644
> --- a/hw/intc/hex-l2vic.c
> +++ b/hw/intc/hex-l2vic.c
> @@ -290,9 +290,17 @@ static bool l2vic_update(HexL2VICState *s, int irq)
>  
>  static void l2vic_update_all(HexL2VICState *s)
>  {
> -    for (int i = 0; i < L2VIC_INTERRUPT_MAX; i++) {
> -        if (l2vic_update(s, i)) {
> -            /* once vid is active, no-one else can set it until ciad */
> +    /* once vid is active, no-one else can set it until ciad */
> +    if (vid_active(s)) {
> +        return;
> +    }

it's a good optimization to check this before entering the loop.

> +
> +    /* Deliver the lowest-numbered irq that is both pending and enabled. */
> +    for (int slice = 0; slice < SLICE_MAX; slice++) {
> +        uint32_t ready = s->int_pending[slice] & s->int_enable[slice];
> +
> +        if (ready) {
> +            l2vic_update(s, slice * 32 + ctz32(ready));
>              return;
>          }
>      }

This second optimization limits loop to 32 iterations instead of the
full 1024. Maybe the comment could be explaining this better:
/* Quickly find lowest-numbered irq ready by scanning their statuses
range by range instead of one by one */.

Regards,
Pierrick

