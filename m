Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C74CD3447
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgZ-0006E4-9K; Sat, 09 May 2026 22:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgS-0006CA-PY
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:21 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgO-00030V-49
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:20 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-694891f8f75so1866712eaf.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379255; x=1778984055; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VXHlRvkJCSKoRasedhMGAv9XHTebfGI4BrYNPbJbH9Y=;
 b=IS12YUpFD5ACiV5FJMjg8+3HJbOyfU+SnAd69G2WTa06h5EDIzBBnQrvcN1qVQcEKc
 N4h3YLjx81+eDui/WkLUx1/ObP/dszAbv+UXbVz0VIAPH99WqYRqeoXFmetqU7dHze7E
 jCDhW91vSyGtOXDF7DHQ500LNyz+Xp9ibFQW8CgvkwE5lEE1XRN34Jp2sOvPzwcegV8Q
 g6IvyToVxgIy9FtF2Fm26HR6FPtAC6AD81nkMVTKT1A9Qd9IqaBk9Iveo3wV2N+0iIgY
 OL0tAjxKFj/uEG62/tJiioLkhfebe3kxlTIvhHZI6h9BBp4AU0Iu+i5WgWmn/2bK4ieF
 4Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379255; x=1778984055;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VXHlRvkJCSKoRasedhMGAv9XHTebfGI4BrYNPbJbH9Y=;
 b=p2hPzp2E5mFcCNuTfRWDyjsb8kR1Zt+MeVNnOE2oh8JH38ElGz7BSMau/jomjXGmfy
 Hr5fWbvFITEYWgCJxuENOmeefR9UP+QMixTaOPnykH6GuV0q4m4CJbHuZ/DbdbSWyyc4
 g8dfArW2Y811iJkFM/6Q9CS7fM1SaH1cZlexOIDFKOJz/NBJ2wGPWhdptR9xSzA3KNYa
 5EIBTGVIhOJKUWj7sOIsUbVRTDHjFCPF1POes1k6rueIdkHrmzRLMz+4DB4jqHOtpYZI
 CkMbShjVQUviaT/hr+1IO14Bmj13HoinywIpJHhqKrI7PZpcojE8H+cQs9LydDEYz6qI
 G5ow==
X-Gm-Message-State: AOJu0YzKeBBH1FKQQRIszY+K3GPIWgHlwgz29RlV0akmlK955BfMkC8w
 gOGYx8sbHbg4wAxzx5TpzjcM7dZ6/WckBGUbMcQT0eztIsJ6dLEj+JZCdSZ0jFho
X-Gm-Gg: Acq92OFSQ+9Gp3aN4WCISq/wez53kbPq1//Fs70eWfzFLe/4mJXrnH6X7jZ+fywn60V
 PxuKWD6HssVTqyxCnvYE2bD0HXs6AucL0gAyKDJmxSocNIXpAza+ziTpK1j4uPeCG6bTzBtETGL
 rs3EltIuZZoSHhkKkC+A4UwdqV/dhG4XFzpHrKwipquhbRIUJDATJV55fiCKWFYxEq1LAry8UWC
 iRuecFcclSnUfvsrcdpqkeK2u5K3dw1wgIiHS1woZ+tKT09cLHo6o7iDlM1mGhIQ8YgPr6qCP5o
 qZKeGnFlX4G2KHWjrOJ3nVcGaunGCfH1jlDqfhBALiJiD6Ei5T++CC08VXA2jGdPNHdVDzAerhy
 ua6Sv//g5o/NXLOhK9QCPGAzkpbGz61l8A31g9ktrG+Zu/sPupfvzACweCJxG5Pi932N8O+fl1/
 lyUuVhPYk5/fOg5UxWPBHXk25s08ufDTP4uTNnhxreUfWoFk7DzLuQM6wpi8IkRnNihGR5PuQnf
 miwsFigU9XoPcauLvlMnnsWCVn+UgNZqmT2Mt5pcv6gCJUWtZqnqAZL6+j6f2AIEMLT
X-Received: by 2002:a05:6820:6af0:b0:696:9393:41d6 with SMTP id
 006d021491bc7-69998cba398mr10574673eaf.22.1778379254650; 
 Sat, 09 May 2026 19:14:14 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:43 -0600
Subject: [PATCH v4 20/32] target/mips: add Octeon MTM2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-20-d669dcd05c2f@gmail.com>
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc30.google.com
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

MTM2 loads the high Octeon3 multiplier operand pair from rs/rt into
MPL[2] and MPL[5].

This supplies the final operand pair consumed by the V3MULU multiplier
helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt MPL[2]/MPL[5] pair handled by the shared
    MTM translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 82d0410e6c..7de2a8f6ec 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,7 @@ MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
+MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index cbf2e3188f..366b70548c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -286,6 +286,7 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0


