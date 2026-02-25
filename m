Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3528F5545A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7DX-00072O-5X; Wed, 25 Feb 2026 00:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DV-00071s-AA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:45 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv7DT-00047j-UW
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 00:13:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4398d1f06caso804566f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 21:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771996422; x=1772601222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGvKgLHeevLALbSBED4Jn7ttMmQ4t+uZlwFqVihbumU=;
 b=ahfm1W4ZuHeuih9cz7By+oS5ETKMCVKyWwocWd3RHrRwlb6W5RYzfdLJrxMQmYWhDx
 0Uv2OCmd8kGZLkSTE96P7Pee9qtlLv7+iWcnG/HsZfjS9/PLab1WynMfNgE+hNVuoKPa
 z9zrdnTVg6jPzg2JIfPxEKbD3S78vyHy141GkRBaV54I/3UJEeMzcFTsvy7zgBQ/biHm
 pdwjfATHu5veMwg7NaOaE1BSMN/rK1PgcIBTmOIkWYbmMXrJL9A8k0KrfxI7Gl+vdvtQ
 cIkX9671icaM0l1gNEhtZJpxpEuE1HX2Uem2B/oBudKKcghI7ytXojfmttiFjnl57Wi2
 QcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771996422; x=1772601222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CGvKgLHeevLALbSBED4Jn7ttMmQ4t+uZlwFqVihbumU=;
 b=Tchu6JKQAz1zO5f2G7dUMbj727k4ESNNtisOq3xhftJYo9rDeE4JF5oGP9I4+3EoTx
 nf8Z+8FMPvtl0I6gO2crgOyk2nW6Tu/rPXCvIYA6zYNlioYJESKcNNDBd8S37xYqveZf
 SCLQYfVv4XHhJx/synBsB9Hxy4Mk4dcNflQA0JuYAscs67cxIaDzDuaW9JHLjBtJP6Ls
 Gor3adbdhOGz79um1Ls1ZVqsxOZ3/m9TVD/PUFDcPl0q2p2uP4/bqCp1W5EvnpNVj//4
 lpaSEoElRfeOIKUnsnkrXWgBWZVy7lXM9dMmWsgNOl4NE+bU/7/qYqQXgMvqHL5mj9b6
 M2Pw==
X-Gm-Message-State: AOJu0YwqYX5mQKyW5Ih2bDxGKAd67O63NiHx4HZ7jdwHDnzhHPNp9PFB
 h5K2ED9KxQJDoO5veMIudlBn5xJXQwtjdeCQFhAX57PjMsAnW4vWntcQwJZlchRC+QRl6OQgpwv
 U6dgGzPc=
X-Gm-Gg: ATEYQzyUblVDTBBEZnlNPmKH2MexGSfaPfI/3VZsg1nl/YzeY1F4faZROZ4MVF0uSpg
 LexX5UJdUNTE3R0id+kAocBtsxtcNU//JoXytKJesU3IzTZduJlwlL9YkYVHzLPGVvASmiUNcL6
 4tMUPw2XU2Y8/v/vmxX8K0wTKYC959w4V/pwfQgbwY8JuQ8zLQLfkixAh+dekKERdi6sFxz6D6U
 gR8bSNup8o+mIAQIG9sUzzDjjCiI/txQp752sbsC3XEbMqt2Yy+W3qFq23asHmK/4h9K9a36vPw
 PzwvshnIfNexTttONQOa5vCzux72wIt1QAba8vHvwAlPAfu7cNoNVdTA8EK6PCCv1+nBY3sR86B
 Zjt1XVE16k+5iO2MxIbWliMpFgr/NrhvxMRc7O5JeLNMTQakXY1Wz9+oSN1dAibOWzD6ax9nc4B
 rgqOo0pHJZLmSkFvt/GDq2n4Hp6zVSTK8LU5SXXxBNH0x/4tM0lRijKY9OLNi0EWiFK26cWmmV
X-Received: by 2002:a05:6000:26c3:b0:437:6758:ce70 with SMTP id
 ffacd0b85a97d-4398fa70637mr1467991f8f.26.1771996422125; 
 Tue, 24 Feb 2026 21:13:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4bf89sm29682387f8f.29.2026.02.24.21.13.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 21:13:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 5/5] accel/xen: Build without target-specific knowledge
Date: Wed, 25 Feb 2026 06:13:03 +0100
Message-ID: <20260225051303.91614-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
References: <20260225051303.91614-1-philmd@linaro.org>
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

Code in accel/ aims to be target-agnostic. Enforce that
by moving the MSHV file units to system_ss[], which is
target-agnostic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/xen/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/xen/meson.build b/accel/xen/meson.build
index 002bdb03c62..455ad5d6be4 100644
--- a/accel/xen/meson.build
+++ b/accel/xen/meson.build
@@ -1 +1 @@
-specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
+system_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
-- 
2.52.0


