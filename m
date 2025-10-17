Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD38CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9nNQ-0004of-Tf; Fri, 17 Oct 2025 12:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNN-0004nr-0D
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9nNH-0001CI-Ok
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:32:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-29226bc4bafso6071015ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760718734; x=1761323534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wmlWS0sUrakSiaKFj6FiuRiCehdD6kFKgRgAe4fBI4w=;
 b=pfwAzMQcXOZ/C2j/sOIhEBwxDPJVIKirdSBxjIlMgCFDOI1OA9e7V1I9xAlWvEcDBi
 LRWX0Zvckq0L/lCCHgQTAHyY7ClcUoTtQY+j35s3kE64sGcol0ItbP3t1WAb49oKLo+E
 dTAJr1Ly+lSbJJdrl74cSAdIGL+IA7NKhFv1l+w9Y14TK4sxXflo7QjupjKdhxxjPi7b
 OoX2wLYwhQBlbK/4Kf784jGTIpK09NKgIuFWskFN3EQdTnOWS29fjtMnXBq0Uj/+OSew
 jNrpSY+/a9KYoAUTBsST++08up1iyZnSwbkLY9N359c5ev/DRi4Gr3w7SKhjzn8Wj8/t
 BJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760718734; x=1761323534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmlWS0sUrakSiaKFj6FiuRiCehdD6kFKgRgAe4fBI4w=;
 b=W2C6dQ/bex0uigzPm6dOXaIpsbpVcKEDTjvM45d6qp+sxsI2TQ7v6e3jUt6hTpgN6p
 9Vw5fUGJYegMREjIe2M1gdyBr1IzsdLVW7NMpqaYz8jgq0KxEvbl6SztDD1MjzmzdMY4
 nXQNECg8V6qx4tf255NmBiExxM4eYpBU6KdEQjjRrvEjozyTZSLo5uaaMFlUPhcpl5Su
 M1CkbfHerTTJEvtqVVAqR+FAnH7xjIABwflbXZpCZqY9u7ullsaAcEnLEgMDcZ4RCZ4j
 ziaUMv9hATtOEOM4MsIdU3hymY7NqRzJmVGxrrd8LRYMCwOz7hdKfQgfZD8nxmmEBc7I
 7g/A==
X-Gm-Message-State: AOJu0YzoaVsRzTDn0oQ3e/C8EpsoqdM7l6Ywyq35JvAqIQtKAYPVbI81
 I53Jy1PmUOueoJIIcBWDNLGqVC8MvIpLJcO4OEl+Rp1ZPu8iIh3f3uG86WxqUulBFm/y6v+1dhk
 nosM/0nM=
X-Gm-Gg: ASbGnctFAm/J6RD9/UPoTxaTwI4lpSBaUNKlbeoBBW8oqdR700BGSDa/bQcCUhTnLyC
 RV3yMwm1KimR/OYhHM+KldG2V0TtVR/ol3GGqoHlvG59agD/Lybjh2yDL2tCz9yzpoycs8BPYTO
 z7wtGLETwAxaUS04xmxjBB6r8RAsAk4Figr3N+g8e/WJr6XWMaLQmKryIF3lZliyGQDfD1ydJNw
 BPdXeF5mytkHHDDDL5qJkxedE4u9GNquD/0wymSL+Hiw9UxBOkWKZ90elhkt8JzfNleR2Bq27fK
 FzrfDe2W6n2z4aRW38fGXRjqOQkOsJjX6ACMLdJIzETcpCqiWBwWT60kro7DQ9pb+XKI91TCvMc
 sRV1Uhr3rxEEL+AFXwSNgbSV/8p/2BfS+4MTgmRLqBlBZ3vZvQTfuqMl3kkLazfxyivAAOGlAkO
 kc6tefH5c/Kj7FGNB0
X-Google-Smtp-Source: AGHT+IGg2+/ebUgHK/UCKwHxF1tebOLN4uNr9a1TLd1JegXL0hC06oEAFwmVXabr+p2q8uzs/JdF+A==
X-Received: by 2002:a17:903:2343:b0:290:a3b9:d4c3 with SMTP id
 d9443c01a7336-290cb7594d6mr51424015ad.56.1760718733739; 
 Fri, 17 Oct 2025 09:32:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7d1bbsm68667715ad.65.2025.10.17.09.32.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/9] tcg/ppc: Remove dead cases from tcg_target_op_def
Date: Fri, 17 Oct 2025 09:32:05 -0700
Message-ID: <20251017163206.344542-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017163206.344542-1-richard.henderson@linaro.org>
References: <20251017163206.344542-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Missed some lines when converting to TCGOutOpQemuLdSt*.

Fixes: 86fe5c2597c ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b8b23d44d5..cd2b68f9e1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4435,12 +4435,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(r, r);
-    case INDEX_op_qemu_st2:
-        return TCG_TARGET_REG_BITS == 64
-               ? C_O0_I3(o, m, r) : C_O0_I3(r, r, r);
-
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.43.0


