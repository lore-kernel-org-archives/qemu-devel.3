Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBE1C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5rG-0001Mv-9D; Tue, 25 Mar 2025 11:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tx5r6-0001ME-2l
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:06:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tx5r4-0006y3-0n
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:06:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCff21018769
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wLyqui0SXNF9Icq5LG0f+pnQefBbWdQ01haZYMMRZD0=; b=Eo7K33I5g3uCaDF3
 x1p2IxNlDrvc0VYd3pT91SQi5lqn5E3QW9tk1s6m/PCx9hHo88BlcuuYx4WRudx7
 MEC2PyoxVXQ0oo7nCM+PblBZaj3FgCYt0SSk3vBOvvzqgC12p3qIBLiFCjbebBRa
 w4uUs3fdD1LJ3AlZqaqj+luD2gsze7shmue6fP7dFM1mV4/RcZKHNYBJSGtLmJF7
 YFizwxQu/ah8N1oNpEpqHsc+rGtWAX/oQNSpyMqr0YrhonFZG/HQUf5Ng+9Fkip4
 JVcsx/JAJqKROltpuxGOv1C8QCNZfU2ufzf7wUftfvyksXETnBvhuY3vn3cPDP1R
 7E55wA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnrhem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:06:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3032f4eca83so5042997a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742915170; x=1743519970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLyqui0SXNF9Icq5LG0f+pnQefBbWdQ01haZYMMRZD0=;
 b=tKfRldDCTmytpgunWgMLBIG/fhZoDYcT9hQNrqoTsYZPgHUmvLcF/zjNNCT6t2m7nC
 hXOWa3YDD8+OnSMkL/pNuzee8LC7AuOGkQQr+SCdCmQlrSxio+m4hSlI2Lt8XzxW91rF
 NjEg7WyveW2rdGwGyDdSICJXrNnilJXsnjfmbKWkiIYN78U1LZow0VA+yVEYqFHZ4zOb
 aKH2RY5Oa0gV37+qUIZtLC/KMX6w9BTs/u/DqNn9N64kwBgG2Ojh5UTGRF6PCtkc2rKy
 v5b80KJh7dPAuzrb1ikL8bUs1DJSeYjXOOKfD495Z5+EjnYALbEZOvTD6H7qq6F+nAtp
 RtVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF2xXr9WrnIjpFTe1M3wynfwVR5nI+SDIfR+7XS5SdU9l0dajNGVkOioxF2anRfN40e00GVQQy62g6@nongnu.org
X-Gm-Message-State: AOJu0YyRirnkI5d4lp8PwS4WaVOL0BUnWWdTIDdsuNBF9IQaj5xfaD3o
 pTjKKeDPS2dWzEOGy48Jd1SQdr2Nv/w0skJ1dbVMQIcc/kLngX9ykNmw7iLEYsMD4MNlqHwjdzO
 xZ9gv7UgA6tyPhFvSyjLrDn49ZtXfaIbv3/D+YNS4nZVqpcMUlPVX3A==
X-Gm-Gg: ASbGncuso1xL7Ou74brCRLYgpevz+obWdfXT0KEt2W8towQB606+/BMqPJQousXKUdq
 OqajPoALKatcJiMy7F9ey7f/xLbJdwDiLI6EpL9eJDUSZiDnAcLWaiDqgiXjx6vWgkO84+3ObLC
 rT1X4RYOc5Fa8mk32tB98FJ2dBp9gCIVrhoiOvfvNkwbhqdlqqSo0Mf7uEsUZnsAcLuAvczo5DD
 Y1q0TXntMiJmmKfhXVNB7WQSxW3ZFjQFUzqxYBAtzQytk8VTdJUtkpOmva68NHjLHa84fRuCYV/
 pJybQ4D6ShCAwTViEdSjbW+1OrB3NG3lIsExQ4LuX39m+V6+TajLbYqkEaV3UYxIWAxldh+cxA=
 =
X-Received: by 2002:a05:6a20:3d89:b0:1f5:535c:82dc with SMTP id
 adf61e73a8af0-1fe4330dcf3mr29199212637.42.1742915169899; 
 Tue, 25 Mar 2025 08:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAInEQ7saIeGXJdhjXTIpbms51pnLId6UcthyUbXj0VB9lpMWGHEO75q58UMRNaxKRBu+Tjg==
X-Received: by 2002:a05:6a20:3d89:b0:1f5:535c:82dc with SMTP id
 adf61e73a8af0-1fe4330dcf3mr29199146637.42.1742915169324; 
 Tue, 25 Mar 2025 08:06:09 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm9150220a12.65.2025.03.25.08.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 08:06:08 -0700 (PDT)
Message-ID: <fb8116b7-4658-4ed8-9c89-fd7b377ef380@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 10:06:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Hexagon (target/hexagon) analyze all reads before
 writes
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com
References: <20250325021440.81386-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250325021440.81386-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e2c663 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=DvPxcWX3HN2qFr1vO_AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: DutVJHBz3OGSHc0Vp7s2omLOblg8RMkW
X-Proofpoint-GUID: DutVJHBz3OGSHc0Vp7s2omLOblg8RMkW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=856 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250106
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/24/2025 9:14 PM, Taylor Simpson wrote:
> I noticed that analyze_packet is marking the implicit pred reads after
> marking all the writes.  However, the semantics of the instrucion and
> packet are to do all the reads, then do the operation, then do all the
> writes.
>
> Here is the old code
> static void analyze_packet(DisasContext *ctx)
> {
>      Packet *pkt = ctx->pkt;
>      ctx->read_after_write = false;
>      ctx->has_hvx_overlap = false;
>      for (int i = 0; i < pkt->num_insns; i++) {
>          Insn *insn = &pkt->insn[i];
>          ctx->insn = insn;
>          if (opcode_analyze[insn->opcode]) {
>              opcode_analyze[insn->opcode](ctx);
>          }
>          mark_implicit_reg_writes(ctx);
>          mark_implicit_pred_writes(ctx);
>          mark_implicit_pred_reads(ctx);
>      }
>
>      ctx->need_commit = need_commit(ctx);
> }
>
> Recall that opcode_analyze[insn->opcode](ctx) will mark all the
> explicit reads then all the explicit writes.
>
> To properly handle the semantics, we'll create two new functions
>      mark_implicit_reads
>      mark_implicit_writes
> Then we change gen_analyze_funcs.py to add a call to the former
> after all the explicit reads and a call to the latter after all
> the explicit_writes.
>
> The reason this is an RFC patch is I can't find any instructions
> where this distinction makes a difference in ctx->need_commit which
> determines if the packet commit can be short-circuited.  However, this
> could change in the future if the architecture introduces an
> instruction with an implicit read of a register that is also written
> (either implicit or explicit).  Then, anlayze_packet would detect
> a read-after-write, and the packet would not short-circuit.  The
> execution would be correct, but the performance would not be optimal.
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

I found no regressions when testing this patch downstream.  I agree that 
this reordering makes sense regardless of whether we can find a test 
that fails now.


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

Tested-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/translate.c          | 18 +++++++++++++++---
>   target/hexagon/gen_analyze_funcs.py |  4 ++++
>   2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index fe7858703c..5271c4e022 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -37,6 +37,10 @@
>   #include "exec/helper-info.c.inc"
>   #undef  HELPER_H
>   
> +/* Forward declarations referenced in analyze_funcs_generated.c.inc */
> +static void mark_implicit_reads(DisasContext *ctx);
> +static void mark_implicit_writes(DisasContext *ctx);
> +
>   #include "analyze_funcs_generated.c.inc"
>   
>   typedef void (*AnalyzeInsn)(DisasContext *ctx);
> @@ -378,6 +382,17 @@ static void mark_implicit_pred_reads(DisasContext *ctx)
>       mark_implicit_pred_read(ctx, A_IMPLICIT_READS_P3, 3);
>   }
>   
> +static void mark_implicit_reads(DisasContext *ctx)
> +{
> +    mark_implicit_pred_reads(ctx);
> +}
> +
> +static void mark_implicit_writes(DisasContext *ctx)
> +{
> +    mark_implicit_reg_writes(ctx);
> +    mark_implicit_pred_writes(ctx);
> +}
> +
>   static void analyze_packet(DisasContext *ctx)
>   {
>       Packet *pkt = ctx->pkt;
> @@ -389,9 +404,6 @@ static void analyze_packet(DisasContext *ctx)
>           if (opcode_analyze[insn->opcode]) {
>               opcode_analyze[insn->opcode](ctx);
>           }
> -        mark_implicit_reg_writes(ctx);
> -        mark_implicit_pred_writes(ctx);
> -        mark_implicit_pred_reads(ctx);
>       }
>   
>       ctx->need_commit = need_commit(ctx);
> diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
> index 3ac7cc2cfe..fdefd5b4b3 100755
> --- a/target/hexagon/gen_analyze_funcs.py
> +++ b/target/hexagon/gen_analyze_funcs.py
> @@ -67,6 +67,8 @@ def gen_analyze_func(f, tag, regs, imms):
>           if reg.is_read():
>               reg.analyze_read(f, regno)
>   
> +    f.write("    mark_implicit_reads(ctx);\n")
> +
>       ## Analyze the register writes
>       for regno, register in enumerate(regs):
>           reg_type, reg_id = register
> @@ -74,6 +76,8 @@ def gen_analyze_func(f, tag, regs, imms):
>           if reg.is_written():
>               reg.analyze_write(f, tag, regno)
>   
> +    f.write("    mark_implicit_writes(ctx);\n")
> +
>       f.write("}\n\n")
>   
>   

