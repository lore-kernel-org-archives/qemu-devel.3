Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E562FF5139
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXG-00007x-Ow; Tue, 07 Apr 2026 14:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wABTq-0002am-Aw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wA2n0-0002to-6P
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 05:32:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376gXUE492497
 for <qemu-devel@nongnu.org>; Tue, 7 Apr 2026 09:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eTEoXjbBwQbAAMbm9EfWVtY7NoPaxKGk2EEZqBYN6VA=; b=QJOhObbbRv4zmVtG
 jgRe4XxrKUah5LlKU79Yj4THcj2vRY35tV3unuA83eD0xB8UknHhqvAktQcZiLlB
 RPa6wLFWgSly02+rwrzXwxnev9DGl3BEJwl4Py7Xb/Tf91hy95rox7rPh1AQLM80
 AHkOzxt3mpmKuwjo1u6zmmqrXdlRZHCugGGEIVa2PtIw6UdIXAiaVlDHLZw9Ra08
 u3Md0m8GgednfqYpk7ntld3Bumf20tgtk64UEE25+bAqxH8eoV2W9dvmxatSZYXg
 M5Kspv6DW6QJF2JKdmzwEQUdVcRfV7kGUGORc1lUogz28rhitioEGelPVJfAgkXx
 4r72yQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8t1ju-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:32:02 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7a1f794a45fso31432547b3.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554321; x=1776159121; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eTEoXjbBwQbAAMbm9EfWVtY7NoPaxKGk2EEZqBYN6VA=;
 b=Jk0NwYz54FxR2QmWuDVbID9mmqVBpXoC2kgf5RFFgQqf7+FLV6KEUu9Oo8zHt57qWb
 Eje9eCZ6CwjMOsq5aIGT+Gq44TmHtRhjbn73IKqs06+SLJktcOY9+jtZVcphBgRP1nOS
 F4YH9BP4SDuH6hNmc/MAlc7LcRwvo8VhKSpSAN5rvQnSN+AAb2feP0QIywFod3ZagLsz
 ZS2V0NPzb80sQRAVasMvQMUYu2n0+oE/eISkcA8uTHVd/MNQ3ksH0WSNKC/zdf0pDXaR
 UoNGosmkXwCI7aHqzyfMpWcl+3nAzrYGPc2gob0N06TKmG2fbwHKUjTd7GdnJIPTuI//
 MbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554321; x=1776159121;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eTEoXjbBwQbAAMbm9EfWVtY7NoPaxKGk2EEZqBYN6VA=;
 b=g0pwUXI3R8XFb4oC8ktpkBpkg593gHn8PtvXQMdZI0pp+q25QONn7+83pRlRSS+jgw
 cbJkS1n51aadQbGnR4Hbx7X6Ht7oQiwAm/+Q4KCu8d6hTYRYGPdSmxi11z79uwT4Ae9D
 8cNQdW7VRWHQ5H2IDGgoh4bTibkZfcQ75qT82rzhMBk63xSKOkGRQV8rjRD37EbKabQk
 6L0c1pvf1qFZfbINJbdkSODoaZhdInO516E19NGXkMG4DzED6XPUcZ45MFBGU9X5Rblz
 xjGh8kYYemLOwL39v01rF536RSqyG74X5qgaFgNftvigHbOM7QfB2bBoFdv0cO94tGkR
 jMnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX39qDiPqAKX9+cVXj79Cq2NZi/urj9lZgwzFn4Lw1gYPHdf16gi5Gwmof+cijCjDXFzhvlcoTkv5R7@nongnu.org
X-Gm-Message-State: AOJu0YzKe80cYrk+DwiYv3OuoS0F1A8uTOHdVCUBsKQolFD5aNEgio5J
 2gH0Gq3QebOZVxaQRzKHYydLZXwy4MZOr0m/yoYc4iEZieZgoAonw8DbDKeNy0kyXtRMXs2e7E3
 Ze0g00BVHDsiWr+gCyKC0nT2k2sSxWyECZd4mOgLynOHYF9Qw83ilaxm+7A==
X-Gm-Gg: AeBDievpEwzLHlksRjJZE8ZzxEBXwQ7mTn48EMNlksS9DfGTnyqH43cMNNEl2ddEaIG
 ugZpXY6pnqOZu116EBxk7eG4wJuOqR7JsL6ZEevjLQy00uuNvDurZPfjClpk+guhngIydSj1M2F
 h5AJb1wPj7BMhIfJP5A12zlQKHGlVybFZ2hDrDD3HatAaodkkAfAp/9SCzs9Z7z3YdM8eNpq2zl
 UoGMqIAm748zMAH+NHTR3dlqGm169clo1br8Xht665tp10cPllphL6yCv3PbLzTdkNW9Kf1IQcF
 ajeBdhV6j8fytNcyl5igqO45IRGLVneNVYeEnlGUFllj1KMlNYuKwX/RfkO6Q6K+Z4Xq7pDmuRu
 64TlG7hOrO67eMNi18ltftsiTOdRzjhvT5/EWhxNMQf8EN31CA6sCehWr
X-Received: by 2002:a05:690e:1341:b0:650:2770:804c with SMTP id
 956f58d0204a3-650486876b7mr14530177d50.10.1775554321643; 
 Tue, 07 Apr 2026 02:32:01 -0700 (PDT)
X-Received: by 2002:a05:690e:1341:b0:650:2770:804c with SMTP id
 956f58d0204a3-650486876b7mr14530165d50.10.1775554321277; 
 Tue, 07 Apr 2026 02:32:01 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6506afc39basm2733969d50.8.2026.04.07.02.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:32:00 -0700 (PDT)
Message-ID: <801ef2e9-7e68-49f8-bffc-1656f9357bfb@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 06:31:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/riscv: Use ELEN for Fractional LMUL check
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-6-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407043614.372871-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o5Re5Gu5Je25vpST3CR_B8Fk0sUDf3yc
X-Proofpoint-ORIG-GUID: o5Re5Gu5Je25vpST3CR_B8Fk0sUDf3yc
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d4cf12 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Wg2i10Q8swPuJs8jTFC2sw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=UOqw556B9czlxbsWkWsA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX0s9XZmM3lm0s
 URdAh6aabOF0pDW3httUu2vFObpP+TbPMiFUxhEPbn523j62GYwb9vhjkqCL7BBE26T053nYVkN
 +lLgn9hjviSzG0nbEtbBD8cTu48oIRhWoN/weq1euhdW+6xMIHQ7NfV1LgVXf8xG5N0mIgzxkgU
 5eScfG4FqnEXh+mWVQG3xS6LKWE1/l5QvnoUiT00QFU/DcxhHV+jGCaA+65xmQgFUoFlzzK1l3D
 azeM3xcdFhM6ajE4nPEaqUeENqwj2LpKNNyYSiqh8S4Py96P4pW1DUhareMSAWYwI5k7s3tVP8Y
 /Jo8DjSMqNS58O84NnmQEGFiKVvoC4M/xn4y/Hum/R/jBizmOLJLDU3yj8XuVPSCJ8bmMcCxTSr
 2Cs9zn6r6Zh8Dr4AAs+I6e4IMDWlLyzAJhX1FTNR61E5hYDb/b/rbZManukNgQvv4KZ5fjQqofL
 m8D+ZKFc+z31wSUDRfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states that
> 
> """
> For a given supported fractional LMUL setting, implementations
> must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
> """
> 
> We were previously checking VLEN, instead of ELEN, so let's update to
> check ELEN instead of VLEN for fractional scaling.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   target/riscv/vector_helper.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 83dd26314d..b4fc791eb7 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       target_ulong reserved = s2 &
>                               MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> -    uint16_t vlen = cpu->cfg.vlenb << 3;
>       int8_t lmul;
>   
>       if (vlmul & 4) {
>           /*
>            * Fractional LMUL, check:
>            *
> -         * VLEN * LMUL >= SEW
> -         * VLEN >> (8 - lmul) >= sew
> -         * (vlenb << 3) >> (8 - lmul) >= sew
> +         * ELEN * LMUL >= SEW
> +         * ELEN >> (8 - vlmul) >= sew
>            */
> -        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
> +        if (vlmul == 4 ||
> +            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
>               vill = true;
>           }
>       }


