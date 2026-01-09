Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE3D26D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjY-0008FB-Bo; Fri, 09 Jan 2026 11:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjR-0007lM-K4
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:02 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjN-0007YP-N0
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:01 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so2423985f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977575; x=1768582375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clmUza8l1GwtG34+YXHZaXD4EgmAbnoa/13LIvHiXg8=;
 b=pFOIGs+AsAmOvnTKhb0LrRjhOBhjbsjStcO9rIodWYverBI3iVgxpmt8O7Nanb+T0s
 5ogffb3/e6ABj+Gz44QKTmMGb5vRRyww/6yH5uxJKeMjfHAYWESPkoUhBfw8sDnUrLWC
 Ngb9z2YnF48zFRmZ5aYgqc6zWlqWr9fUZDFVJMPtGrwISHPjNSNNM8giCJRG4Ja635JJ
 5EJvC7qVeriFP7wQooP+kSgBW7OX48crzPkluQQgd6rTYt/7NXP5uGkVySdEmMTV22+q
 taOpoAXfDMoZu/U8EPjuOQlSW7MCgEkq3bL9JKjVgAIAWLEmAN/c07OGhuC4fjzdnHnU
 B1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977575; x=1768582375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=clmUza8l1GwtG34+YXHZaXD4EgmAbnoa/13LIvHiXg8=;
 b=kLMxjPE9sqp/1+Y4O+s5l0Qm4oOkqHlYBSmkuCAqFC5SmUrRFFbGubL5nwZjtx3yhC
 7fdZdgWrFsYTzx846TYYCkG3oSl/6JJC6pktLNTDMO51LS+Ui7jowUlCxK63l3LrdvnG
 XKxW6k1jgd8ISY5wnb6jEWbILVvHTJDPRnMZ3Vr6L7XL8zPMGgzNgFyXNBSxfpsEBfQC
 tf+ZBhnhHFHlbvU9LA+BbrQeA5SWQ72W2kX2Pap3EFEf2o83SvMmRCVHdJY9rO7Rojju
 vCD7pL3yYyihvCzZY5nxMnuqAsSpOKpKMz3N9/ZlXduQ+Rez4qUw3m8dbawqw7sMQ4AY
 +R7Q==
X-Gm-Message-State: AOJu0YwydeXdYq6uSG5KTGAmu35N0IWvqAk4hh3yqn4b6hm8kzHGddK0
 wlcMLXs7GSdORTsY6I7JvJnsdEoheMi+FwNCkEadbv4QAoUDCHh8J4aZl2VWyJbAjMS+Z4QCwbr
 gkabmPhg=
X-Gm-Gg: AY/fxX4gfaKbs4axd5h4nvkGn2H4OHqL3wL7EzcM+5A/TRQiLpM6cqOpVpqq4FwtWRh
 QrVBv2N4K8Z9AeVqoFoKlG2s6HABnP/Klszme6g/6+xTgKfkLIFQKK3laAn9JP6KMzOhZST0Q2r
 N8Vzm/hude4ITCbjUxIB5EdighVKoPfZ1UXYZ/D8yWBbwZpaq5KmwxfUtxm4Oo255T/eOOLyDgT
 M+YczehUJeHP9/C1L6sJzOTNej9yQZbZMbhKw+NGSPTlW30myidjN7BEWv42NDVMzpJZEQulcJA
 CRy8gPEVw/H7beH+HWDgftjxXaCGdBboBpZICR8PTYIFUDYt16ifjfxS+agLP4c1BCpvf99CzIw
 KlVX1UCJG4xOo+8LyuN25u2TJ7++aqAElA2hfdXWNyUB7mTLdsEcl0S548pQsWWdYuxAGAsDF7o
 h4owC/csp8TXIiiD9oy9n4T5El2a+qtCEWkTDwx0ElqfvcZN7Dxc00XRO+a3W4
X-Google-Smtp-Source: AGHT+IHZ/jTrG94+hVfwpGawvYB6HWJ3Z2ukOnEMfDqRRQ6q3lV9y9qN8TWCm2OtiSfCQJB+6NJvXQ==
X-Received: by 2002:a05:6000:1448:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-432c363351fmr12489972f8f.14.1767977575540; 
 Fri, 09 Jan 2026 08:52:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm24198592f8f.22.2026.01.09.08.52.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 17/22] system: Allow restricting the legacy translator_ld()
 'native-endian' API
Date: Fri,  9 Jan 2026 17:50:53 +0100
Message-ID: <20260109165058.59144-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 3c326555696..8d343627bd9 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -188,7 +188,8 @@ uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
 uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
                             vaddr pc, MemOp endian);
 
-#ifdef COMPILING_PER_TARGET
+#if !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API) \
+    && defined(COMPILING_PER_TARGET)
 static inline uint16_t
 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
@@ -227,7 +228,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 {
     return translator_ldq_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
 }
-#endif /* COMPILING_PER_TARGET */
+#endif /* !TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API && COMPILING_PER_TARGET */
 
 /**
  * translator_fake_ld - fake instruction load
-- 
2.52.0


