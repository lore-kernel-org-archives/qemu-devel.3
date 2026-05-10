Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C19CD37B5
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx6-0005Af-9u; Sun, 10 May 2026 16:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAws-00057n-5y
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:29 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwq-00041P-Hv
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:25 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d68a9063so1308799b6e.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445622; x=1779050422; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2k4gr2/sfJHr+qAcHdD7j9VuR43dwFxO+rvDmB/Bk1w=;
 b=kzTYq9pH/twsFsiGJcUAjCCJHADk5Lv9rEGB0Ue/DMxj7MlBPY9CkVGF2Yrz4VLYdQ
 mFqAxl2xwDMtn3bEclUOPs/kueO1Fl1qh/LBVvhA+4I4ejifYZpjOz0JUQqiIG1W6DMP
 y9HnyB3xRqtwGZCmrwZmYv4ZWcgbcNrvD+0ZjTqoQf1WMhCByjU1mdT+HTpAOD7y4kRu
 e42Plkfaf9bZd1GVDhwgD2hp7yA2l+puLXotFNFu+8f5qrvT7Fl1trqyxStX7cC6yJp9
 PS5UDc2E7qidVuHW3t9c7/v7JMYvDkMHns8et+bFqqn0JF00y6RL/SnyVkJ8sWbsrQ4m
 4zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445622; x=1779050422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2k4gr2/sfJHr+qAcHdD7j9VuR43dwFxO+rvDmB/Bk1w=;
 b=BK/TbN6PpXXtDZjHO7Zx+HIbzVrr6tas/S8RSio5aM0fBm+NGPsMzdheWs7xMDU1my
 pPjjVPbgXXmwiRpNQZwBWuuU5pfYBab0eoIoZwWrM2CL35epMDhPczlkPLyzOoHuj6e2
 1de0FiGuAPYsGETpIVs9pO37IC+xZF22QIrI49YL88m8TfyvVjFLNXTZm1yXgXIj1XTH
 67mlgnwlXF3XQIlC7r7ILvbPVpY8arh6KO8QexjyFNixgLeQcarh9ouKov3a2xC/xYRo
 19VQAq7qyJy8KXeYlv71R0ZbnF+4SHOCKJJV6ZrzopV2wkc6v+vyYwiyEUQkvntyCRJ3
 BTwg==
X-Gm-Message-State: AOJu0YzZQH+VjGRk6QdeFp+y4G004vUwmueWk9Qcd7AkBvZjkl7Jgbgc
 iKP1mKCngQhUQ3cgcKQ7OLYLrne060GyjdMi3TNuJSKiiPc5AnO06bR3
X-Gm-Gg: Acq92OGwQ/vCvI8ovFRDVPRw30hsPwucsN+Oif0UXsSjyN+wdf9A8A1fc1Al3ei5+zR
 unf2n/rHfmq1U7tMKkxzWMqspzt733k0QdT65SBYmTwiC2Kf7qFDArpAak7vpUJA3CqdmEC1Dpc
 bavtRO8Gngv1iyky48mAT1FUo5Y6Otd9/dbyM4UeZO+dL7YBKmkww8TU6oUaf04T4kW36bjTLSO
 08VdYKMwlP1mN1Gb7vcIE+tGwZwFTXRiaI6R8TRApQcjdFfpvk3+guRmuYryP4MENSbQtwXAUOX
 Og7A53pn3Ysp/ZXSvYoGGz3MogoYd4X2W0yka3dxASpvrC+mTH7VijKR1NjyY4ucpD1TGozQbAh
 AQFU6iY+0ml4dF8H5uvbX7kUtJhglx02JflJawI4ohi+TmM+Si6sA2xvAhusALjsG5sSWdAXXAM
 mSWbGxslO7QyZ/PWTN8oaRboXo4UMN/zYzGdbxsJZnbDc4Qqa9ad7HXWrxcWU/nKbtYhIHwlIGw
 w9f5OkldDPPZ9N/pwETIaJjtRt/qxQ2upgmEU9PZV8hBsRVuQJlDg==
X-Received: by 2002:a05:6808:3508:b0:47b:d07b:ecac with SMTP id
 5614622812f47-4824a5672c2mr3640742b6e.10.1778445622201; 
 Sun, 10 May 2026 13:40:22 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:48 -0600
Subject: [PATCH v5 18/32] target/mips: add Octeon MTP2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-18-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22c.google.com
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

MTP2 loads the high Octeon3 partial-product pair from rs/rt into P[2]
and P[5].

This exposes the final guest-managed partial-product slot for the
Octeon multiplier operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTP2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt P[2]/P[5] pair handled by the shared MTP
    translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 670a12a956..99606c80f6 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
+MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 1a6a07c9ee..f128b4adae 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -277,3 +277,4 @@ TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
+TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


