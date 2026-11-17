Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ta1ZYdQs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOKI-0002jH-4X; Tue, 17 Nov 2026 13:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOKG-0002fQ-Bq
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:54:40 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOKE-00016m-QI
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:54:40 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso13630a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794941677; x=1795546477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ha5YZxCe+fucO5QYzSYZXVUE55wVJRDIC1jgRIZp6cg=;
 b=ta1ZYdQsHUSJasx42NWoOoV2VG4VofrxuBcSZVl3a19h1P4GLF/wRTiaKu/SrjqZGc
 RZG5WUrKyTbWXMZ1TOKpWTyaeLtINZ6z2W2jMBGNYjfL/O4qOAioKHgKhCQkxi7doGBK
 vwQCh7jGT/F6X0bf0jfCO2Dk9RDFYUWcwNg2o1Z3kX1V71++MVZoxwBJO4uPucbBo+5J
 F6M5amLB7UGGp+8lmo0Xte+JYT+s7cSMoh65c6Ocl7z1ovDzoBoTKwuSAErdqortqFFw
 UVvH3p6OcXZjGPTSukk8w1nYfsWnQe66yCTmqdncbVZMWp2HqLc+sVASJEZ0cGqFN9H9
 3dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941677; x=1795546477;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ha5YZxCe+fucO5QYzSYZXVUE55wVJRDIC1jgRIZp6cg=;
 b=IHiur+Kdwd787LlDsnroEXaAY9gilnRBZBB6J44gLazjOyEaiidTcjDfqgRpxh+gEF
 FqN9Iy+ZApkXMDLffHfPnvvCtsJnQtKbqCjjNeppJITzLt5yUYHGqq86g+mBtst+dYOs
 NVvgoTQkdQcBtRDQ2fjnab+qfhNa81KxV8rK7j6IT2J6yOXH5xiu9ugsa4X5UmnKHMqx
 LvVgSTZiIU0QqTmeBesriYckI6tiA5nfkuK+GiS+Z5D8hb3YntgUr0SvTTdWXfHEFbck
 bfg0KM0yvdichcXNvLn56QNhQDbPiEhdCypeUw8QtO/OsUtKVaslIn7r6Ogs1xlX5NxT
 X7cg==
X-Forwarded-Encrypted: i=1;
 AL+hErEALPbnof3F67e9jV83iZRgCIrN8a6oBNX4S4J3APpwuoSUr+ZjdktPI+DQdT+rRLt13sF5G9UA0j5N@nongnu.org
X-Gm-Message-State: APuU4Z9t9Tj0epkvCd8GgRGEqxGmtmi29F7JuKmxROUbtlsVi425PhxS
 zVLOX2DScBUDubHaxw46Rr+z3vxyiOUEdfiKjyiXQLQSmEhfnl000NCPdHOqzvg61eA=
X-Gm-Gg: AZFdTZfGqNIPbVF/xMzh6vfOvvGk1YiZHdwBEpIeDbQnqotpbmXNZLshOq4ruvWMvH+
 3N4hnMshJj2HunhDQvIHMzruqLQvinX4XaVI9DdEv2QyN61rVPBw1sMmyMGQ/QtYge0uZOifMyh
 tuwyDTqcTVzAoRedHWyPi4r5r7l/P6RJLSKsgIplrfVuNvCQyBu8YVsj2/AYmywL0UWuxNXh9l0
 BKa38F8kaqAn3y1LjRL3Z+4utgnbCs9432vkuswyRp+QWhtSmfBBQ5HalfNwfcHUNjHjKqM3658
 I1IFY0OYxhpmSlXYR9zmpXj6N/3eYY/8YNHnq9figsZmQVGHSKnwR8mdEgzNEKVEmgQvcArziba
 wsRRPHESR05Y/Vj5EaQ+BPm46LLurXuss/xhbioWPDX/kpU+yisXu0mmRQ1itQ5pL7YfM5c8TAu
 w7dB/+DB/oUeWwfecm7J4TyuXZFu2I198Ybl50VGfKHM/TTbz6/z+D+GuOlwje5XgFg+UOx612N
 3xw5eUttiAbyitceE7/I2wfKvu48KJYf0O+x8JG3bAFja13A7BQ5NbWthYphFnFKq1hQ70ueMfk
 7aSWuHqRupVRXGPutClq1moDu527SxUCy5PDNTkrDo/crVTAzY5IbE0ce4ijKhVqOuz95vU=
X-Received: by 2002:a17:90b:1644:b0:3a7:e11c:4e6e with SMTP id
 98e67ed59e1d1-3b3d07cafe2mr330012a91.59.1794941676768; 
 Tue, 17 Nov 2026 10:54:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1d32d71sm110939a91.1.2026.11.17.10.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:54:36 -0800 (PST)
Message-ID: <0c5bb423-f761-4556-87fa-4e59dba754a7@linaro.org>
Date: Tue, 17 Nov 2026 10:54:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] target/mips: Check for MIPS II when decoding
 BLEZL/BGTZL
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> Branch-likely instructions were introduced in MIPS II; on MIPS I
> they signal Reserved Instruction. BEQL/BNEL and the REGIMM likely
> forms already check ISA_MIPS2, but BLEZL and BGTZL (non-R6) did not.
> 
> Fixes: d9224450208e ("target-mips: Tighten ISA level checks")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 10811db827c9..f521e0ec5bd0 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -14621,6 +14621,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
>               gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
>           } else {
>               /* OPC_BLEZL */
> +            check_insn(ctx, ISA_MIPS2);
>               gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
>           }
>           break;
> @@ -14634,6 +14635,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
>               gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
>           } else {
>               /* OPC_BGTZL */
> +            check_insn(ctx, ISA_MIPS2);
>               gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
>           }
>           break;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

