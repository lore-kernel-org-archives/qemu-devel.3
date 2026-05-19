Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4927DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDg-0006hC-2q; Tue, 19 May 2026 12:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDX-0006d7-1p
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:52 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDT-0000eX-7u
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4042905015cso3226741fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207766; x=1779812566; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=T9yOEICfmPl0sVjTyQzd00lP5g8wOeT7s5f41XeRp/wfVdBva5eKFcWHNQL90QMp97
 uup9tJMdBdBKgYhPxJEUGBqzI7TAr6fVA2M5oQN4r7Wfz70NkTKccu0ZLt5xI/l2IHSM
 I1dN2RK8LqBdhkEgAmLeoDs78zAFfe40xwl23Ivdk3LOkxgtsrq7aKIyOVEV044GA9P+
 9s01g5B9csVYVPaRIWdQnijo/OZsqBY1ruosrmNN3Cjq0R050vUsVuJPkmKVBKtRJw23
 5whNz0Q0H77QtuAlpdc2X0WwRl/VgMDkm/x2ucK9962xn1+f07WaQ5IdGebiFrVtg9sQ
 GYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207766; x=1779812566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=cp+Nm6pJ7EBn2eeqhZ4stQ8ByUCPVzoh8SBYe9s4FVQnPstl0faan1D2v16TcAFJhT
 68f/PQ24psHcZGkCot3VKqBihrKYy+UCRr9MVRrfoE1yQx+CGcLgKvEWqMFaTooG7Cma
 cnxru6Ip+sSYlHKv6ZGfE7MOLaR9Qc28oK7EH+TT62b/khnBjoNugrNw1urN8ZbjjDtl
 b3QsChyGXnhLsHXhVOdAgqIh7qItTOBj4j+yhtDcEZ1JyPOIoR59zE/S+LhN8wyPz2an
 n43m+bhJSEtqSbJT65vp2cpn/hFwb5vQekJi/qks5UiHx1ZMKdJFGoAzz1ks+DfRyrL/
 lXqw==
X-Gm-Message-State: AOJu0YyF6u1NB5kv1th46zwplxskUUN9dwGEDRWlajqjrAGvBDsN9GRW
 FipWy88Qa+owTUE4hT7NKJx8MQq4eahR69fgntMZWYNeop0Sda1AFVc7
X-Gm-Gg: Acq92OGgQeC7Q4L7RZyLsWCFiWJ+hKL2qlh5FnHkvq3/RWO2x/k4ksvmR7Kyv1bCReS
 VccPeiBuYesMpKCQJxQdUI+d1+9VfxxKZToVMiHv4QNWoW1A/U35/OT/LUyedPx9lvqeHtNL+8U
 iCwfWsoAxQUWcAfN+WJlgv2sfiBuaQL9pUmJRJFRHvZbiNkwDsQz/FN+KIMEiT3ze4hJKZjv3NK
 YyaLLwsve7XJrrofK2AzEMe/2yTJJL7qnkV++tgOSvrAh04OkCibnRskh+Xw4NtIW+jHh0f1gdV
 RHN973InLjv23x7REKhGVmWlpCOiGkXhbu1dQhCRJoHBtlk4mP53WmdVUSHAJYu4TUaqjyGyLjh
 Vs/wTGeGAan1cK4yYLY4A9KW9kN22xMKY4IlJRYLpinByDmouengg7xeuxhECwDvvDDFrckuyVA
 SQccmJE0b2WsD/fTDpTAaKS0hoUUEq+TAC0Ib7i7ugqFJaZ2O+XCiAUIS3P9zgZoZLEJ4sydsml
 0NsPg3FBXCu5Xr7BhKRMmdSAEFN1B3X7dv5uTuDUw7/eO8wwIGwj5pR8G8O/KPWU96Y
X-Received: by 2002:a05:6870:d628:b0:42f:efe3:1b58 with SMTP id
 586e51a60fabf-43a2d9a243bmr13275564fac.13.1779207765789; 
 Tue, 19 May 2026 09:22:45 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:13 -0600
Subject: [PATCH v9 11/40] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-11-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Use MO_64 for the doubleword atomic transaction; the signedness bits are
    irrelevant for a discarded fetch-add result.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Note that SAAD shares the Octeon+ gated SAA translator path.

Changes v4 -> v5:
  - Drop the Octeon+ gated wording/path and keep SAAD under the existing
    Octeon feature bucket.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de42..d77717cd50 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f00692830a..d3dfef2e0c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_32);
+TRANS(SAAD, trans_saa, MO_64);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


