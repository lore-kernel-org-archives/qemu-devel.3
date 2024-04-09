Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AF8C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGj-0000e9-CU; Tue, 09 Apr 2024 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGh-0000dB-3h
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGf-0004fU-IW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e3ca4fe4cfso24518625ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691388; x=1713296188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqej1cqMOghQjm8tlS0ZXIP7cn0Zxc/ocvLIj3d7Cp0=;
 b=C2LY+22DL8Nx/SZfG6LqgC+WG8D1Icnl6pSLExAjj8WVy9uQkliL3iduFENtY09lIB
 8ORDRXsdLLlZ1JaGcnuof0DP3vS/oRDIP56j4anQs2EpfwtQrY8ICANiz7KrgbD+k2f/
 oqtz9TYDEm4y8Mne0YYlgo6QsgXt/wkI2vhQmiblCusAZdiePRMaCf7yBaMDHliD4sDj
 vOsUCp/knPNSUqy50hAai5/uQYdKcqFqnyQIptNJAtpLn1cxgc1gWCSpvf74VNkrFsIW
 lD4J+r7UnDEtKJy3kKVb4V8s/XlxoR13qQryN/OEe8jBQElbcrMeCYfSCAgvgBwsCvFP
 tFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691388; x=1713296188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqej1cqMOghQjm8tlS0ZXIP7cn0Zxc/ocvLIj3d7Cp0=;
 b=Wcm2a3luocN0FJDwtLbfd+IDeU9sfD2hv98Y8/alZm0zf3T5CBY4LimG7gzIsgsF8d
 hWHNwCFPG66PjyLFuVFolmyzV9MSH+CUt8kveVLakmzpbc3dciGi9XKBoXlc0gSDNVet
 XblQUvinuEhWguTKbZbQjCAnsSBWd+0xul10uvtlvLg/OtlHZAJogjXllR7LnGrT7tYs
 tpHDEPlExNrmENqz3FNqYReZirr4vdpUmROdDWuqRGjy/w6itpRKefq3vUnXm5Qc40Uz
 YNZUpqytE9Wp4g0KCcmVMnQaoSyAFXaL6vE2pHpfSpfLx5805sF0Fihp1MGyuK4uBrFO
 YfJQ==
X-Gm-Message-State: AOJu0YwrsLRQRYmrHZKOjyGBv2UmLZGyKRKm6yJSwK/frnW5UlzyN+Ps
 7TaDhSW+lh2iWvS1g7J5AJEQ8Iyf3clZMq2N6fjYMUKmGH9nOIx8IYUaIc+5pzpZgnCaKGOMZaD
 O
X-Google-Smtp-Source: AGHT+IFky9feGN4NGBCCapfS3j04xjrGjL1Lao1vUI1bCGeTOwsBdcihARIsQJjbdDxc70ET00DV6Q==
X-Received: by 2002:a17:903:22d0:b0:1e2:aa62:2fbf with SMTP id
 y16-20020a17090322d000b001e2aa622fbfmr747566plg.45.1712691388290; 
 Tue, 09 Apr 2024 12:36:28 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?J=C3=B8rgen=20Hansen?= <Jorgen.Hansen@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 15/20] target/i386: Preserve DisasContextBase.insn_start
 across rewind
Date: Tue,  9 Apr 2024 09:35:58 -1000
Message-Id: <20240409193603.1703216-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

When aborting translation of the current insn, restore the
previous value of insn_start.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e..76a42c679c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -139,6 +139,7 @@ typedef struct DisasContext {
     TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
+    TCGOp *prev_insn_start;
     TCGOp *prev_insn_end;
 } DisasContext;
 
@@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* END TODO */
         s->base.num_insns--;
         tcg_remove_ops_after(s->prev_insn_end);
+        s->base.insn_start = s->prev_insn_start;
         s->base.is_jmp = DISAS_TOO_MANY;
         return false;
     default:
@@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
-- 
2.34.1


