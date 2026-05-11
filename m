Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E00CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHb-0004ki-Ld; Mon, 11 May 2026 14:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHX-0004jD-7M
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:08 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHV-0002nl-T5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:06 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7de44ed7a11so3692075a34.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523785; x=1779128585; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4IK85PPMBI2youTGdlMjIY8YEP9i5/O2uDLfdpbX004=;
 b=MfQM7FSOPwKJlRWnWS3gHDzpphhEZlK+G7eziWMLL6/pUNVgQBPj+uoS9ryulNkbBz
 FyhrTY3gBavEu8YJakgMTlTxNAxOHmLWyxx91L+OvYQ3IY45SzYcnm7Gs1N/08s3v0Sk
 PAV6KbTZ+KMnbTZtkEZsdtH3Zd8DoT6ktbtWjmaVMG2PVs3clzQVYlGyvMJ5UeWcbuqE
 +11XKc1jCjgOJjk+MEq64gK72xSskPnkRQDYNrHY3atMumXXBlFREMqkChjwfUuH8HIQ
 XnhLYIFli/VR1zqKPe1jvHov25qbMt8vtGo8KxieS0Ho0BODq/KWg3H0fkws1IDHFrOL
 3DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523785; x=1779128585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4IK85PPMBI2youTGdlMjIY8YEP9i5/O2uDLfdpbX004=;
 b=NxZ3N+RucL7YUBjVjjWzXjHlXSTtYmz7UDAzrbvy0H6EM5hXa08CqbOcHA3rpl/GV5
 J+mEUJop607jnv91s7SpZbaot/oagB6NCgx09eWdnk9FDn5YXtsyBoVlEc3dhlvTg9Ld
 Lt+IkChY3cCVALmA0Z1sv8Y4/T/SkBXf48dPrmemf5ovk6Jvit3Po2HqL1oDMcMpBZl8
 lY+m/OgaCzwQCn0n7RZtUodwiKT1jxxrTpRGGZnoICCzVBiw+Syi08OaScpcNLIkaz9d
 PiBIkTvLWi5aXVdbnpilzcUoCSDLHe9z5S4gLj6Aw05aZG/W9Y+1+W3APA9ei681FwSE
 QaKQ==
X-Gm-Message-State: AOJu0Yxh3zFdepe0OUS1QtExj0opihIxBHWUdmR+R1mRkF3PcsxGpqHo
 7wnwl7glJoYaM8qg5rMI24+aWTWSDSuOlOpX1CYeIqU+6ToQAugNFmZM
X-Gm-Gg: Acq92OFTi5Q5cCpFySxpQntv/Ndrxjm4ufbsIOtEX9vop7zkhdsap5czB1zLPCD6FU4
 xToA0Dg3cmUYCLqQLGLgIUZvZRRLJTI+L/cSHBkEMB6syB1aCZVliMg8M+Ux1YWHRZWzSsAvaoX
 yiLFfaFkXEU/vqpal16Rnk4F6O26LmfGHBU0SgMiIQf8oMKegD3MVJwl0rvXNT7dHjbKgS5UXyj
 Xwk0GarhKs5mGYxCsP6m2dFCR8n6eHBblahH0tL00Y01DOxcbLhABMyU2XG8Grj3n5vVt/wPBOk
 c/vQqPy4guOjNwk46BCvnBjAKOL1tL44QuwJh0pVjZGB21Y/e/5Bp+1GYYhVoBoKBgO6cjm1MYs
 /zd1GkcAq75YChq73o/+xhaqph5BSJVvUizU7z+7jX1EV4tg0jWRnR8V8qWxKQVD5VqFtLfSLcq
 24jbLUQE0qpYhVeaDpphNndkOfFp1ojnjo0mZqfmcIXZbWELYOSo8Wfd09Pptt+uWwsZNOzKwH/
 /RvYoja4ImARCTSoN0g8iELhHnYk3F09vO5bXeRVv/5iaqRK4SqBuwOA0hlj9sdkP8+wzdD8WxY
 jLw=
X-Received: by 2002:a05:6830:608b:b0:7d7:58b0:7685 with SMTP id
 46e09a7af769-7e3666ccc61mr9384420a34.13.1778523784773; 
 Mon, 11 May 2026 11:23:04 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:45 -0600
Subject: [PATCH v6 14/35] target/mips: add Octeon ZCBT instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-14-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x333.google.com
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

ZCBT has the same user-mode memory effect as ZCB for QEMU's purposes.

Reuse the ZCB translator so both cache-block-zero forms clear the
containing 128-byte line.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v4 -> v5:
  - Fold ZCBT into the ZCB decodetree entry with a selector comment
    instead of adding a separate translator thunk.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon.decode | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d8a1bfce77..5377f7b3ef 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+ZCB          011100 base:5 00000 00000 11101 011111 &zcb  # ZCBT
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx

-- 
2.54.0


