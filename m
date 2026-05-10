Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17E4CD37AF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 02:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLtgJ-0006AR-RM; Sat, 09 May 2026 22:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgF-00069g-SN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:07 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLtgE-0002yn-3W
 for qemu-devel@nongnu.org; Sat, 09 May 2026 22:14:07 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbe437b072so1740982a34.2
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 19:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778379245; x=1778984045; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J1ZRoSPBOaSt437oXh0nVo6B6fvVjXwz/ir/Au//TAs=;
 b=mEh0iH80N2BbqWxQNq6DK3D/JHAnyeUPIfdQS/HT/oGB+O457uxN00O3xwhdyRkpKK
 SFMkNa7ubPOPLK5nczf+7l19x08qMQCdAHhL0geOkeda6DhcR/XGKm8R9UuZIXfkOJi6
 2dLq/OjgufxbFjZWteZ/qHyiNvnJkFVkGA2k5QkPPlQ73fb+dSRoIEjZucPed+BmK/XS
 pjTgv5DAhIeCjLWHt7Lem7iIvGUhEAKdWC+OtjukfQHmppx/G/DPxD2lEgl+BIOxwE1j
 iXAGoodasyyNsKK56Blzn08zG0mQrawjN96MIgFLPPYGVbqOJ1Xh9pS8tRAkzWnp0mF2
 eXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778379245; x=1778984045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J1ZRoSPBOaSt437oXh0nVo6B6fvVjXwz/ir/Au//TAs=;
 b=GwiSOqWobl8Jq0MdsjvSzvIhFoO5hE1oeYlzfUoqvUjaCOXYox7p8/O2W1qRX34ubT
 69KtkY3Yy7ILApKTUlQJ7sQ4PxSWQwdRAN33+Um7WETaUCkWKEGTc/Ki0PPDZxWBUTyX
 7kVKURP9ldcQnHNfVo6Q3Z6CMziixzHDzoef1uM8pecyZBGH/5WcuFK2qEG4IlCx4lY+
 2NUjHsb+ip9wp+ImvVyL5MFw9GBfaao9hAxjU9zjNToQ4YMN0sjB30Dk4IhwWgztfGsY
 LsthoVuoGNPoIpBvrsraeYPAzST7I9w/obkk9PuEaYQc5IESlFv4HUcHQPJnOJXdzT8S
 b9Tg==
X-Gm-Message-State: AOJu0YxVTzBzkAYL9557Te+nXduCF1WDklsvieIBYzR6JL2mBwa/bzlN
 +VK09rgU8D4w6WQ/DipvWxHogIGBlFwxVweFGrSoNuzLOe4YxW6eBhMb732ZI04/
X-Gm-Gg: Acq92OEPRrWyGQCHto6b9v17XsjCQ0QqayR6/5wZ80zHsjcTTQTw9xeB0YomUA89QFD
 rG5x5ESxU3IwzWi1ZBGAs08o520YYveorQrdu/kXpjUmpxnhsQDNyyCWX1gF+fBFaqTf59BXzzo
 Y4YIxQWwxj1Zss2U4G7/VueoN+4RkMHUI/6D9WY8iWAX+c/EpxlUi1K4oQAV6JmMTzgmvJdvnW4
 w0Df8+ETPlgGM5UApKVN07VLiaGiOJ7vbAEP0uC9ZsKNfhA0JKXxMjf4qhu9oCXE4TApnbqYKQF
 dkjm+AfKzYjwLoRG3GpE/pJlhoIDcOixSeu82UhSrNnf0AGrkrnBrRd8lb+w+IO6tCoPlU2bkKw
 443LXBXvtwthtFBujG3+RyNfaoXq+TjT9BUaPQbLB/y755QYEK92MRgA3tVGCE6FbBKDpz+zKkW
 EsqIu8shuEqvOYy9RRVLxCv6WzsnBd+YZiuH++LUxWNz0AhmE7pEmyCrqvUczrfRgu8ZwTBTnNe
 +TGSKdYD5OcfknkaPr9TPW59v8WUAh0D8pqTvppGxBoxQbOvGy7lVinJE1bA3oEKZSBRWz6pitI
 tHI=
X-Received: by 2002:a05:6820:220d:b0:692:6030:1189 with SMTP id
 006d021491bc7-69998d46f82mr9615556eaf.45.1778379244768; 
 Sat, 09 May 2026 19:14:04 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm3645643eaf.9.2026.05.09.19.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 19:14:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 09 May 2026 20:13:35 -0600
Subject: [PATCH v4 12/32] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-mips-octeon-missing-insns-v2-v4-12-d669dcd05c2f@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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

SAAD is the Octeon+ doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Note that SAAD shares the Octeon+ gated SAA translator path.
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
index 548ab1b220..2a3f502e1f 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -180,6 +180,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_UL);
+TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


