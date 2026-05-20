Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDEBCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgW-00014j-Op; Wed, 20 May 2026 00:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgR-00013Y-DJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:28 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgO-0003mK-Qb
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:27 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso4337206a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251843; x=1779856643; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=Gn+9VNg9b2VvvlIB/IJt8nsmABIxFtliVZ6hm/XMrkxw3ruNnWGx932sd354GJQcOA
 yey6XHz6Hz8IQV4+Pzdl3CKW4Tdh5VFEeh7SAX9DapPmA9/nO/nGNSbAVhBQ+zaBe/oU
 xk7SupncVbGatHrMzX8WyqxaLONnrb8M5IaSSe3yc1JpeAEwq0Dee8AlUBILLJoH2Jkv
 dYh0NI1fuO5Mpvxv7i5lVBKI/jQ0aFTpnG4pj0CWyH4i06qD1mrQvJHJU/+gdz3IEsUB
 awOc0V7ttJFslNDyYSikPl/Zzd9O2eWwZr8Mi7n94iT1ikabwCNW4xxJn8kZIV2TFyXB
 aqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251843; x=1779856643;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=rtlPpdGHEr1b51SLfP4He2ILWt4BHhYxo2CL3jtw+KSUOno4eEqn09nidVjQZGH78B
 32Us2o2Fpblnl/G47wslGrKMXMKVKoKJL6/9D7WXOgAXZ1NhyMMCxG0XPHF/UVhonhDW
 59jyzLQw9I3cGACiXmlIvSzVfJYh90HbaK8l9nGoNa49D8MvI/xZw/UySF25QGhDEbMV
 Gf9VjZEfRXQKQQ4SEFW5UA76VIk/u5L1Ymqqk0BVEqSua0O3YHE3oHT3VbID6HUBTMuy
 QpZkuLu3S9nY0MIqrHPraDddDV1fFn5ktC2nNntLXYOU3/UKGBtF2lxjV49ZkH2/fFWa
 df8Q==
X-Gm-Message-State: AOJu0YypAu+F4W8qy2w8761pXL3ELNHAwjQx2oVV2Ttr4cGmb4NdH3c7
 5SCXAx1J/z+ohPHibN/kP0BMhPpuvgBU+oAjhe2U6CDo9mD6uCOWBvGz
X-Gm-Gg: Acq92OFVYX8IrjzGbyLJ06NsWCiYhdVFdVEWSMl79EXwIKc1uk4mbZj8HwMxGc2TXEb
 mBEM1dQwm5hKZps8irGJOux8+TWqUbppj7/6lSKoCaO8n06mb7HhkqAwl5ZimKnJAT8W9pJwQvm
 BXr7vbjk+9GrV7USwWARsH166eKuQ3sDtffEa+o2Y9qiK0DknnI+qCc/vIYxbd/7xrpJOm6P/lD
 fU2jnKR3e2ZZ+U6SfN9wEoSVaXhOZ+i9rwo8Wv17p5kADlXeiH87M+bDPGxII2aYYdd/KRFmk2X
 e0zFWoEstCFfjl6aYxTKWNF6E+/xLlj+2RdzSnc9aT7BZbQYOeZHBv65jfkqjtqknmCNp3I/7B4
 Z+n6EPPnSXjzLOpgwPXKUgOrDUtuVSMXb4d9WGDMfECQZtE2JfXFQOkdGAru8s77DXzGfe8sUrl
 +ZdElW8gOQYpbRCy8tdE2cqszPxGqMJeP6tjrZKZVYhw2KOjJmAdKYOv7bvclMkwizb+ZUucCo4
 TDf3NVHxVih7NluCRZd+2t2oMCI123SN/0JyCc4bmoOaX+ByTRLPVpMEhYu0LQxFfsl
X-Received: by 2002:a05:6830:67d9:b0:7dc:c7aa:22d4 with SMTP id
 46e09a7af769-7e4ea01b6cdmr14699448a34.1.1779251842897; 
 Tue, 19 May 2026 21:37:22 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:01 -0600
Subject: [PATCH v10 07/45] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-7-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LBX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d..efb1a48b38 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497ddfb10..451737cda1 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);

-- 
2.54.0


