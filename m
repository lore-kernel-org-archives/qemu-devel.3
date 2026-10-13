Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C44CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGb8r-0001kM-In; Tue, 13 Oct 2026 07:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGb8p-0001jz-FN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:57:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xGb8n-0000qI-Om
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 07:57:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DBTugv949398
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +XfwQ0Ih8XUc1K7dyYvKIaSNXqQJz7OjBqS0OBqSsf8=; b=b2H2J2wA41DQy4Cf
 GEYF5cKU7+W0tBgYyCZq3UjAlj8bKyRumC8vNKZbhSP98NwmelLF0J+NXM6bRRE7
 cVDgmsL8iCLu689JfB/JIEEw5YWpuy6VF6Wd/kaH6pdA55F24tN0kitZqAYV/sRl
 P40DWG+j+T0N4acGPy8shK9xnG087/XRFSQ/3OimaB9U01259y0rMs7lImTSU4AM
 zRRwtQDLpvNlBHDq3AOJwI2SbYykIIz9e20yKbJ3uJwNQnFVTajjTjI/ie+/t6no
 uABs2itqdTxspf6R/OLYfWUKZEuBwSVWKL5CP+N7ferWeN+Oc+MHOvPVRb4rXqlQ
 Zqm3nw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f629e80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:57:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337f26ee19so87227241cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791892674; x=1792497474; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+XfwQ0Ih8XUc1K7dyYvKIaSNXqQJz7OjBqS0OBqSsf8=;
 b=XVOOWPqbmXWU15SOxmiykXiNSQ9BHZGFKhgupHkpLFIhj3bV+sJuGRAARjpQERxD0U
 vulmtuThM3UePl36OVsL1AcSsTzAPdkgSTdoK0ehsB4FQ24S8fuY0tUHBbxMXNVXmV2J
 t0v5DuDFoMN67V9JiwInVXfWfb7A9VANhGQ2WaAnSBUo2Kfk6HrpLoBfU2YwNTapL+k3
 th1PzxJg0Vr6gc240iDOM0YBrJDs65QG/doPbvdKJXFUBJr/0V0GaYfU+gynyTOoLreY
 Q8yTc7+T381PR3aRqm2YFWImxajhi52+U33Hs6FRtmPDUWMRhkKizmo3v9N/Fx1MQ50c
 XjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892674; x=1792497474;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+XfwQ0Ih8XUc1K7dyYvKIaSNXqQJz7OjBqS0OBqSsf8=;
 b=zP6gnT15xulRjXqpjM3gfNjf6irzqTwapSKYNYMJzAsoVt/YvQeIBDXAphkYDZCZgt
 C0d2eAlFwaSQrqugwIBT96poDY7e1StwBgVeG6t8AYrFRyD3gNWbsJfLFZ+AKHyq7/Xx
 TfYDoDE2bBwozLV8Q9Bpt9h5i3qWoUPKWxzOqGn2BGMxLQ24fVeWKYv6hK7ol0k84786
 fudKBY+VJ22gruITatTMw7vF8TD2Nd2MEMgFS1tVM9UI/o6tuCEveq6WK1m1ZaC5OyDH
 Pd3XSROcuA9ezGn483FeUrF8uwUPK3xKye8HiqA077N5wYCFLBDgwXLroJXX37eK4lCT
 EGPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZaUh9v9PRRZqa/nnQIuqKP4+hyT7JC8ZMggOC/JjdhCJTrWoKuhwC6vJimA0NLuGm60jKWAzvPs3W@nongnu.org
X-Gm-Message-State: AFq9FYK4glsCyKZdB0zpF+22XmE20TC0NtBFCGse1j+GefNinjL8+C9I
 S90vEpSgjlh+Qkp0e5edbEtf9UG7m61wT1ewBM3pYacFBXAmCkWzjM6QaDHJo0hw4shuCI62h2m
 Zuyqeijiz73HPMApTtDMqWfw6EkNL28GRl/QXXR/qYKu1mG6Nkhc4IIykww==
X-Gm-Gg: AYBFou12ub6bj60K2brcVG8nriZc0IzUW8hY8hXOWfVEGufbbxw5oGCOEPuVGaAcJq+
 9gxKrUWB5wE2TLBLh9A+fa44JysSeeODJMQ4zNPtNPeFvKVKZjIsppulo/imnb2et67fQAH/ugy
 N8U3yQ73lPa/M312TDRqTjTE91WEXK3C78ugjzK99vSCm7o/6p5iqf4W9zorHAQv5EXKHiXRjVl
 TTd7/7G6TjMO23AVGvgq4aj8NQ0C9LiERiL1K92mV7dAycUocDBgyZtbDXj3+x8KK0+945q/KVm
 942duAZwD7LFOz5AtWn+SDQ2Q2tLyaNevvMjVn9Vf9IdKbbLvVh129NdoQSsAHt8w4Q9rFWRZbw
 d6/+BBzbPeTo4Dn9qiI4BdXpfkDxY9eEg8k0=
X-Received: by 2002:a05:622a:2445:b0:535:a5f7:d58c with SMTP id
 d75a77b69052e-535a5f7ddb2mr191570681cf.70.1791892674093; 
 Tue, 13 Oct 2026 04:57:54 -0700 (PDT)
X-Received: by 2002:a05:622a:2445:b0:535:a5f7:d58c with SMTP id
 d75a77b69052e-535a5f7ddb2mr191570391cf.70.1791892673587; 
 Tue, 13 Oct 2026 04:57:53 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7324c9sm102113781cf.12.2026.10.13.04.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 04:57:52 -0700 (PDT)
Message-ID: <96294abc-af49-433d-99ec-9376b7b78091@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 08:57:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
To: Rick Richard <rick@sloservers.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <d6db9f89-36d6-436d-a915-407cd28e1778@sloservers.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d6db9f89-36d6-436d-a915-407cd28e1778@sloservers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6ace1cc2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=F-tV29oOAAAA:8 a=EUspDBNiAAAA:8 a=8i7eK1leYjGsEoUvArQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Y2dezMJzicAI2PZykhZh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NyBTYWx0ZWRfX49zJdQ3JT5FJ
 WNCJa2O80UnjEj5XgdvV8qFBumu6NcvI9rtFxpR633ZJG7c+80nkcFIMBIbDaljGTemuIGp7AHZ
 OYp3ZhaB8hdUqAmJOELoB6YanhCU3Zo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NyBTYWx0ZWRfX+7TrSwNErejE
 BWTZ7wdD5xoDSqBj1X3v0aYPegXWHFPeo0tGZ1uNMbrrEXfZW/vt3/svqttU0qxDuc4VOMRnHwq
 8XReUpuhteDf7hWtjMN/6XUNLhVi/5OlDQe1hWSHa7K17Z6sr4bcB/Sgp+nziAHyGE64fSZW4m4
 RmOveGdpxLOb1WESdpZ0ZYTb973M9udKHnh9ip4lI+vv7gAHavnRIJOGvh/Uwl5do5EAdWXBqjA
 HY9+FB264KfjYRrqt3KnZO8yPubOn2NeP9eZSoceqAonXQT/RXWmTyHRTpodBkZ4AefZVxLf15Q
 4InJk9Ag6DhTIUI2ZsoAcuxP0pXMxQklnfScISVShrlNRAbnMe/RElI60tlsG3LfcbRkRANzphl
 OQsVwhKn2qgRMlDk9RU7T7Hr3WTtLXWb2OET7+ukCSezUnrJQrcKKWgRCdUqHcgL70yXLvrC+h0
 w/gbkQ7wfDyrjkfH0nw==
X-Proofpoint-GUID: TzGVKJcSac5cY0-leB-DPKYAw6OybA9F
X-Proofpoint-ORIG-GUID: TzGVKJcSac5cY0-leB-DPKYAw6OybA9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130047
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



On 10/2/2026 10:47 AM, Rick Richard wrote:
> With Ztso, plain loads and stores follow RVTSO, but the barriers
> around them use TCG_MO_ALL.  That also orders a store before a later
> load, which TSO doesn't require, and is expensive: on x86 hosts it
> adds a locked instruction around every load and store in a
> multi-threaded guest.
> 
> The barrier after a load now only keeps later loads and stores
> behind it, and the barrier before a store only keeps earlier loads
> and stores ahead of it.  That is all TSO needs.
> 

Fixes: 09c4e88759 ("RISC-V: Add support for Ztso")

> Signed-off-by: Rick Richard <rick@sloservers.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> I found this while looking into why riscv64 guests were so much
> slower than aarch64 ones under bsd-user on FreeBSD.  The default -cpu
> max enables Ztso, and turning it off with ztso=false accounted for
> most of the difference.
> 
> On an x86-64 host the patch made xz almost four times faster and cut
> the time of a clang compile by about 30%, the same as running with
> ztso=false.  The output didn't change.
> 
> I also tested it on a Raspberry Pi 3B+, which is arm64 and doesn't
> give TSO ordering in hardware, to make sure the weaker barriers still
> hold up there.  Everything ran correctly, and xz was about 12% faster.
> 
>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 4 ++--
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> index 40b4c9aa..d31e4295 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
> @@ -424,7 +424,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
>       }
>   
>       if (ctx->ztso) {
> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>       }
>   
>       return out;
> @@ -485,7 +485,7 @@ static bool gen_store_tl(DisasContext *ctx, arg_sb *a, MemOp memop)
>       TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
>   
>       if (ctx->ztso) {
> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>       }
>   
>       tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae..8c21ab87 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -731,7 +731,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>        * around the loop.
>        */
>       if (is_store && s->ztso) {
> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
> +        tcg_gen_mb(TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_STRL);
>       }
>   
>       mark_vs_dirty(s);
> @@ -739,7 +739,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       fn(dest, mask, base, tcg_env, desc);
>   
>       if (!is_store && s->ztso) {
> -        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_BAR_LDAQ);
>       }
>   
>       finalize_rvv_inst(s);


