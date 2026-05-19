Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB4CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDi-0006im-GK; Tue, 19 May 2026 12:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0006cr-Q4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDS-0000eP-R2
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:49 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43a12c2ecedso2391415fac.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207764; x=1779812564; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=bHMLHfeEOPpyakoSI9xauWtRodtSTzj3CTdbnwJFZspl/Xs60j4M8w8MBUTdeRlOBn
 jvGunRi45Y123xa1PptVVGWmNavFs3hzXGvhArmfOQSHTb9WHWbrH/sQ2tTbpTDb9/xs
 kMsHYX1ZaFakjN0WBJ0FMyPakd96q2DKZbcpVCka6s8XcExawWzOh50DmyWEBypnlSIz
 lFmp/GoG4AbPaBzg7bkErH31g65CKzXZAbVWbDkMjWkNAAZj3Dxl5QXul5tvszO1JqQs
 Mh8Lty79HgRe2K1GpQ3/FunirAb1tWtBMPYOs7yxT3hpdvNn6ODvrhrItbEJgk9tDlxh
 eEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207764; x=1779812564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=BYsog+STj9MiU5kxWD57fjcegkgE21Gn47FKYZ1YdfdnfGdUZU5p/mxOJsTcN3aj5r
 YF3+MVgZ52Ix3o2crWF2KSH74aoI/fTBSrAbV3uEtpBGJki5HA0ATsYOJFPE3rdQ1RjU
 Fl2GWOLH+i9vUIOLQG0cFO0FOUIT4f9woZ0lILn0co+dkMDj3x20bLkaqykCOFOPxY/O
 YyvE1GMUng4gHO5Ql1P+xTUfBGgEKs4b+9JIYhj/9isWoEjSIERAsaAajWQAm4vHRuvJ
 Rz8ZLMz8FHugS74oqGsf12R1JF+T6ndt0bdfsbkRP7SFenPcgvo2BkK1fqHrXe6KW+wu
 E10Q==
X-Gm-Message-State: AOJu0YwMaUssKiHYXsMjWwtwulGnpLYbRZiqy5G1dxjlp6kEkCkx3pmw
 JRZ5qyDyM2VUHm/LB0TLCMxFEUtKlUnFiek7O6GFpHLG6rAoXmXLs8SKT7Qcow==
X-Gm-Gg: Acq92OEPbz9icdNObTA7C3IGTIiBY3vIKzp50i1xGkfXUPXshrmX9a540KFMJJH/Mhz
 DAi+mGwTIooUjXte54HdBx9i4PFMguP0A88/N6Yij87KnpKikf13r2p04RPl9sCAHHAtkoUNdRf
 DZLJ1s61oASxTXFO5bc68LevBrJ4t/W4n9KyfqFzHipQGb9OuJynpC0Pzfp/Omb+6bxRsP4WCFy
 6EjCpjlD1oJXQoYlG29mHCDtLCnpIGoSXDSAzP6/fwtZ9sC73gFUUd54BgYD0XhKAjhwWITEva1
 m61hziLf82KK835bZDxNk8Bw7fKo7G1P3iWKtflzmBoM3tnBz52kJG41ADMHv4+itxUa+gApJ65
 hD4zXxMip8hFe1FOpLB8taXBxaVzci/FaZtZfMQGwscHHFfhc3WZR0wtB4lVn85QzYSCj5WcD5G
 j4scEbEKmyrPHpJGZHDZm13RdfWgBbFYXWLahictTZKTrtV5ygCBOCK1jQL7EeNJ4rLoquZP8eh
 zqriJu2mcc6ETMCKhh4nV55nziYM6OH2/al5IXov/GTQHw+Oh20Lp59C5pqGyoCrY+3
X-Received: by 2002:a05:6871:14b:b0:430:b01:1f79 with SMTP id
 586e51a60fabf-43a2db5afabmr12658614fac.2.1779207763877; 
 Tue, 19 May 2026 09:22:43 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:11 -0600
Subject: [PATCH v9 09/40] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-9-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x31.google.com
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

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LWUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8..db7d5f55f0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f897b42807..401c4bd14b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0


