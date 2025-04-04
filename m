Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D83C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XQK-00010U-HU; Thu, 03 Apr 2025 23:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XQJ-00010L-E1
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:08:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XQH-0000en-8s
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:08:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53433q8T023022
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 03:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /0HIS6VEZc7yhvtm2w+O1qKl1p7UgadHXP90SkYc9bY=; b=jVdw0i7w/LbBPl53
 lOV0IeNF8ouPbjz2OAVuhTs4sn6xGJVz/v3PZ3HxC+ndWK5z76TcbcyV246UZLh4
 zHKSgTx1T8H1mTd5Te3lhtBKZfzmTR+6eRk7Ww63t3NInauGVlqI5pgDlR5kss5g
 +QtxFaB60RFHtnOoOoP/S1FS/pUTceucKH+WznRQX4PYuS1ENIf6zpywyJdkSK0I
 Qesno/t3HYspNVRmmvgstUiQTX0OszLMMO3MlRvSKTJozu0tfvhqf8u9grDVLDyr
 56JwcfN+JWoqM9mtYr4e42ZzPXOka5hB4jOxQGenMQ59liJqkIMsbJ9fWHXqJcu6
 XMdLhA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d8rh2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 03:08:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-af8c34d03a1so1602517a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736125; x=1744340925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/0HIS6VEZc7yhvtm2w+O1qKl1p7UgadHXP90SkYc9bY=;
 b=ejSZZiMQdaxp5ovuswjEY8fN/kSNPs4jZTB/AnTBofj/XsitchxV2E8CQq2c+SK36+
 Khf4TyZm18idfHcffalFd1aV3aB7vzWTLp2PjTtxFw7k30Vn/6nLncSqfBokYg8PpUj8
 woNwpl/yu6SfBWll5Mt/32tSgax04hzfMXMG/EuwXFfyptx9sojAwM+2d3hE/UcbkTj6
 8Y5pOb/D4BRykLs/00XIMgcmiTkk/0UBNV/gk8dTkrFnzMEuByQ+WjJqyyh8846EXJx+
 wJuYmkCwK39EZDz6W0iKHDf+3JMIBAeN3Y9owtW050BKqF6j9pOvFrMfYW4AEAXPzhw9
 bxiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAqpcozTT+CEjNvMqa6ICOCT1kHrM8V8S5nf6iqm45S0u2Y5t6wRIFlISqIOJ/MBzH1S4CZbogNOoJ@nongnu.org
X-Gm-Message-State: AOJu0Ywk1IGjfMOmLfJXkf993q/NuARmuTlPh9K0B7BUHX0XZizW+W3r
 MRpgNAvJrOcSMcH+Tl6Jfn8D22Skootjn5Ue/XuvVE7IKHMKtOnvgxaA6P3OsBq75pk22zwtxzJ
 AyqXXG3+VXD3nT6eHBpa0SZqWXr6eu4Eu4+qeK49FXB7PMY1707sicvLqrTYKjA==
X-Gm-Gg: ASbGncsZ19kse5LIQmeSU5hAwehy6LzGQ5VTCXPp+fqBvu//zyNnXG7sbuRKzhfapbO
 xdsH5biJ+pVVTlenujxtF2KOoEAGld1iMdv9f/5EWMiDqeKsmAxf2X4HM9gxisARHrc+fhLGSrx
 t7VhOiqA4YKzq5YzGDU9qS9OnJkTaRcZxKP/V8EkhtvexNWdlRR1ryFXvTxsa59z/0/LdFSJ+qY
 G5JRyh2M0tt9k6nMTDy2Da5G1XgqcjayXn83j1v4UJf6eUHoqALIRr2ywsHziUp1At46U6FHqgB
 OaynwMPqAc8l4i/I8wiSy3wwzBcFdi5ocY5Qt6z9tu9hcn12LKF8dzbuFD2vcmJPNrguI7K5EBs
 9ENXap2H4WITmqB10
X-Received: by 2002:a05:6a21:b95:b0:1f5:591b:4f7c with SMTP id
 adf61e73a8af0-20104601feamr2370952637.10.1743736125650; 
 Thu, 03 Apr 2025 20:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyo5SYu9jFE9HaA21LywF0dl9apib+iNCMkXO2n6MCCIle0Nx/Z7Baa/AtHDwY4sLvibu1QA==
X-Received: by 2002:a05:6a21:b95:b0:1f5:591b:4f7c with SMTP id
 adf61e73a8af0-20104601feamr2370921637.10.1743736125204; 
 Thu, 03 Apr 2025 20:08:45 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc3fd6ebsm1925605a12.49.2025.04.03.20.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 20:08:44 -0700 (PDT)
Message-ID: <0f4f377f-6c43-4b2e-b3a1-6ef09395237b@oss.qualcomm.com>
Date: Thu, 3 Apr 2025 22:08:43 -0500
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
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KcPSsRYD c=1 sm=1 tr=0 ts=67ef4d3e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=DvPxcWX3HN2qFr1vO_AA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: mhJFTevQYnwmAr6Ycrt5wXgCEip_lgBL
X-Proofpoint-ORIG-GUID: mhJFTevQYnwmAr6Ycrt5wXgCEip_lgBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=857 mlxscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504040020
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


Thanks: this patch is queued on the "hex-next-express" branch at 
https://github.com/quic/qemu/


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

