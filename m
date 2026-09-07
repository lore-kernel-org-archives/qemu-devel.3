Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E55CC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3dLf-0001bm-Cb; Mon, 07 Sep 2026 13:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3dLb-0001au-91
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:41:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x3dLY-0004VN-Fd
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 13:41:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687H8Qta415984
 for <qemu-devel@nongnu.org>; Mon, 7 Sep 2026 17:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BGJF8a70pbTndm2hJWcCX6Lk5X5yOuDdFOoF0bgGyw4=; b=C12mzDb/WM2WhZqT
 9k1ZKJH3+ESOe3BQVUX377hElv7LCFYqm4o1gMoy8iPBlznwS5rs51HvFJcgkUPd
 R6FEzUvOWPZ/E4N/eWsw1z/q2QtWKbvLzRGZJjo+rloWBVJf7SZ7k2E6KtDKy6AG
 uK0S+vu94PmrmDvIibBl7tCptVx1LNEIcQ+w+36RDHmauxgfvBFdSuLurZgYl5jN
 BU8aGYx4X4YlZ/spYaH+kSJ7pqw25O57txIwvkkZzy0PnzdHi/tIh/SGJ74FqP0J
 tlCuNx4OeJDFhlft3Xfy81mqADIdXQfR/nF4xcKI65D+UrCQXaa3gXHA3OMB2DHu
 MRqN6g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfyj57x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 17:41:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90cddf4f59eso64723196d6.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788802890; x=1789407690; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGJF8a70pbTndm2hJWcCX6Lk5X5yOuDdFOoF0bgGyw4=;
 b=B3MHEcGVppX818xzWL9R39Gf+DrJ+oPGt1Y7M81L/t2SkkaLSrW0PJmBx/Fwnk0I96
 2t8gnrxLtbAVijBQMQNLSz8MZx++xiWryolIrDR7bspFKstpm5MAcFm+z6rCXznkshLF
 UVngZd7DD2OiogdVOII1Qf0r3D52ZGvrzPHzINZpGxn992qluo1VgcU+nELDwo0ebbZ1
 IQGJ+WmiuvATJ9CAc7Cr/ULAwUoGzNZm+oglyLMmxAOeNwc8XToGXlEmcNn6MVFozbGC
 RbKEy3r6ggBlK2tr+XpOSrJ+UUIKCg23i7BG7zxHRc3oNt+/0RPYS+YCExI3syVnDwVo
 /3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788802890; x=1789407690;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGJF8a70pbTndm2hJWcCX6Lk5X5yOuDdFOoF0bgGyw4=;
 b=EqYFZhxaxe4B64GthgZ6q118LiseEz301nlWAheaMonu1CTuaIU4Yxu6B3bfILJKPM
 iXWSz4S6eXBlhMKy4iBUIOHjMmyRMldSYeJ+OlUARfkvHntb9IdWBYdi9dRTbszupxqj
 Euigir3sRrroc/UaUnC3n/PWksU3RFG0SgCwitA7N3JwxGYbocteVFJswF47mQQhkhh6
 bVuGVWvgHbBBPrIvX4MEsOqyIUA/vXqWzhreVy6FNi62ESaKkLq8Nb6r6UrCN4KNlNAk
 HfmBTrs17pEDN0BpcXFps8ZMLX41cBtfnyh9V6DEak7FuaLAZuDQhyAMRlEe9+s1059f
 Dfpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQKqLdSJakHFifV9dvUbUMR/93bfgE/MaWnTezydS3Nlfb+llPrrsI2F0DlsmImLx7fdyCG/IZd5Bl@nongnu.org
X-Gm-Message-State: AFuF++lh/Y2WQv6UGnz/N5233M4GNnjgEXC59M7XSM0orQLKME5iuTNC
 iAp/XYh81qOZ1DQhwkAn6NJ2SA32+VvsQuseSoLMDRlQ3rNCbytEM69jIdQoxZfC/I0LGiO9dsU
 CzvrcBOi9S8vjHEVRN6A8BSNTUS1dXDuH3H8ELsVuuMN9Yi1l9hJMjPjgyQ==
X-Gm-Gg: AYBFou1byI5zZFNTkC2GEIQH5J5DmTIXhOeUg1etJVSqzQ9MmsUChO98xgIfuBLqH4N
 MOUKGndmM1zqDrpPkXo9yOiDrmElfaSoHBEwa9Qb3Mn2JIFCk07UM8CkMo/w1tLeSr6fLnz2Nmf
 VVH8C/cRWeAzf3239sJGFyMWjV17wJe7QuLjmPEYaDtFh5HL46PX3sjeuz9gfVS17ELxg96vHfW
 IQ52dgyRxdphblDNyoaiw4nn+gE+JtE4psqEBZnFHphmvbrshMV5cdSNX349xbpOnn+5GtXynaP
 ww8bNh/o7t1UUGU8PCManfp0AaoWqQsW8f+z+MmdfY/ERHoxYjioonBrIvVRGXChMjE9/MoMzOm
 pcfDN2CrIgwm3Gu3QiR3HNcsWi1+IL4K1ZB8=
X-Received: by 2002:a05:6214:498b:b0:910:44be:42b8 with SMTP id
 6a1803df08f44-91044be43eemr269661906d6.6.1788802889881; 
 Mon, 07 Sep 2026 10:41:29 -0700 (PDT)
X-Received: by 2002:a05:6214:498b:b0:910:44be:42b8 with SMTP id
 6a1803df08f44-91044be43eemr269661236d6.6.1788802889398; 
 Mon, 07 Sep 2026 10:41:29 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040664be1sm96570276d6.18.2026.09.07.10.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 10:41:28 -0700 (PDT)
Message-ID: <41e26f5c-631d-43a8-8ef0-0fb4a26e2bed@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:41:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/riscv: prioritize Zicfilp checks for
 misaligned JALR
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
 <20260905093749.491-5-wangyang25@otcaix.iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905093749.491-5-wangyang25@otcaix.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vSie_RHqnIIJ1uL-HLyM2H0316QpoouY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE5NiBTYWx0ZWRfX6UtnyLRfNaY+
 jHNIyB2L6Hcy80ej19D9ffwZ0VdtANyg91zX553RWROllXzJP5rBTMeaIdtnLDvb/qQZel7MOMQ
 6ZEchzFuI7EaUoh/0SM+jYgYxjZYOI5BviVa9b92XfEUNElJ/JwcwZ1mv8l8r4ZxGlDoqkTSL+4
 k/UR7e8Lv+w/1bkGKtaS9fzgtzPZIIX030nKtCE3LzPmmOg5SM1nm5ysdJ62rsWfbMVhpQnAvXn
 HBMMKmNxNptuxiNpukrSYNc8SIJODirfT82XwrtVMsdnwbMJp92p0sgvePiVsyf0dKHSjHSG5ei
 auhsMy61eOmj+uKZ35fvNY3nmMEN0kGHGrJ5Sm/QuNiLCP8tvSuoA5+iAykx490XdOQwZU1U1LV
 4xp85mpaRindvXQiySrCJzIr1jrDDwgtDnZDTOpeep4mbDl2JkjztQMYyEmS5z9BKyU+JIHOw1O
 VnyN7nhCvucQqqbuccA==
X-Proofpoint-GUID: vSie_RHqnIIJ1uL-HLyM2H0316QpoouY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE5NiBTYWx0ZWRfXxfZzdDV29scG
 0mwBdW8bXKWA1pXhzF6/CHb0YmqS6efIlMLSA5SQhA03OvhratPOlARROYfLrb2YE8uulsg2+oe
 Wz6F75qsoQcSwZci6RGzQwA9FES98xk=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9ef74a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=phMR9B-mS8p-AgJQbMwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_05,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070196
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



On 9/5/2026 6:37 AM, wangyang wrote:
> When Zicfilp tracking is active, a misaligned indirect JALR target also
> violates the landing-pad requirement. Generate the landing-pad
> software-check before the generic instruction-address-misaligned
> exception for tracked targets, while retaining the existing exception
> for untracked targets.
> 
> Tested: RV64 M-mode and S-mode Zicfilp controls and misaligned
> targets with c=true and c=false.
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4415
> 
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> index cc1b5dbbad..aa79a5ef3c 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> @@ -187,7 +187,14 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>   
>       if (misaligned) {
>           gen_set_label(misaligned);
> -        gen_exception_inst_addr_mis(ctx, target_pc);
> +        if (ctx->fcfi_enabled &&
> +            a->rs1 != xRA && a->rs1 != xT0 && a->rs1 != xT2) {
> +            tcg_gen_st8_i32(tcg_constant_i32(RISCV_EXCP_SW_CHECK_FCFI_TVAL),
> +                            tcg_env, offsetof(CPURISCVState, sw_check_code));
> +            generate_exception(ctx, RISCV_EXCP_SW_CHECK);
> +        } else {
> +            gen_exception_inst_addr_mis(ctx, target_pc);
> +        }
>       }
>       ctx->base.is_jmp = DISAS_NORETURN;
>   


