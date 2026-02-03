Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D731E7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExM-0008Ax-SO; Tue, 03 Feb 2026 06:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx5-0007zF-JL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:15 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx2-0005Au-AK
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:15 -0500
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b88593aa4dcso757579766b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119530; x=1770724330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0V2C0hSasiZ0RXRAJCGAe8Bly/ben/AN3ObuqG7QFIY=;
 b=yMOIfzMCS41ghoCvKHzb10f7vGUlRTEtof/FNY9DtIUmXEqz4QSfZaYF5OlkhaS9st
 0cCdxS9bDE3E6Qvg0W4NwQsZb9OA0he8jrTOgqPYGags5lK7jchnThcRkjO+7S911TRR
 ZJ0YghxN4hc8y7GKZoBFi8xeBG0ccopnjqHXRGUjziMpE/Mb3UqllOgLm8tgz4vTePrN
 zKos9Txs6/oe9HGOJslmMbtDLmKQKIbg7usOuueeCN1bj4HeKR5aHisApdGDSFd5shKn
 C4bryNf7vXDKDjgPSh4xa0ZZC9q1Qb7yS4ngblvKIh+k9yl91XsU4e1mPtrElzWbON7C
 s68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119530; x=1770724330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0V2C0hSasiZ0RXRAJCGAe8Bly/ben/AN3ObuqG7QFIY=;
 b=nDkEwxByIoAWtJSQkOJwC0LTtL7hZjoug0/n31g4Qc8enCoKdhE5z+ZVJSg0Dc8iUz
 UEYrx9yUg13lI8IQ+UDDU3WD8hh1d2CTdUQWs+5QkaieFFrWOuDCEPumCRE4Ga4O2nbw
 /QdBs/c6hqdiwJC59D1mDCz/I6dq+uv/5gJ4F/5m47q0l9thjGZcV9t3/nLgFdNv0Mis
 l2EpbykWPAZNCi5jvWGHVEDJ10FULAYvQaFXjayYmKN+T+Fj+Qci40yqVi5nyTH4x22G
 Z8NJfNdsimYSBuFxrRdMgT1zT0jvaG6jGWQpGjoq4y77AeGrV0+qSdcyOeJywWoAVhs8
 Eqfg==
X-Gm-Message-State: AOJu0YzoanWZEquFsGDPsmt43k8/OFtAHHBxy5qcXv4K6HFAHy4mIKHY
 b364mUrSFKfaiSY9gjpYyBs90TrEceiO8KYgkW5oZ+X61Kjdv3yULjRFBcUUFrm/jto=
X-Gm-Gg: AZuq6aLC+s/LusNc21FYVb+ICJLeHBZZiYrzAy3SbnE24y74ogMWCvZFgfSk1QSTBJZ
 Vakk57ObYm7yCcz7IEGrelISjAlLmMG3/FH5v+p4UKSWo1kj7Twfi+vMan5oMF4wKUkOFe2W5WN
 n0mr0/V43dkvt/XUcbEdpjh5r7Zg9ElGIQ6ODn5b6eVVc/ewShybd1KMS0P8tI8to+HexBy1odB
 v3brkGDiPvMPmq7UAK55zEs9FqJW77ZslfA4cL13aQpTcczJ9+A9mT7wnBPCk/2i0q9RoBkpvVW
 Sd4RphrSSodeJZ+JFAoidSVy46NNKbOmBg/b8ntHPZZ4uY5wovZiIE7Z6nYgJverlztNahMAJxt
 txvj1xwhWsMZlHU/lQSqsaLCpGth1JLf7r5WKblhdJ6skaDH6QVKm8MTstegdLQpWAykzmfeyDJ
 WlewssLzLjIfY=
X-Received: by 2002:a17:907:2d0e:b0:b86:e938:1b21 with SMTP id
 a640c23a62f3a-b8dff5d8e42mr918857266b.23.1770119530082; 
 Tue, 03 Feb 2026 03:52:10 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbef86991sm1042865266b.4.2026.02.03.03.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4AC9602CD;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH 07/11] include/gdbstub/syscalls: Add EIO and ENOSYS GDB
 File-I/O errno values
Date: Tue,  3 Feb 2026 11:51:57 +0000
Message-ID: <20260203115201.2387721-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x642.google.com
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

This patch adds the EIO and ENOSYS errno values that were missing from
the GDB Manual [1] when the other errno values were defined.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116014612.226183-2-yodel.eldar@yodel.dev>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/syscalls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index d63228e96b4..6200416f77a 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -22,6 +22,7 @@
 #define GDB_EPERM           1
 #define GDB_ENOENT          2
 #define GDB_EINTR           4
+#define GDB_EIO             5
 #define GDB_EBADF           9
 #define GDB_EACCES         13
 #define GDB_EFAULT         14
@@ -37,6 +38,7 @@
 #define GDB_ENOSPC         28
 #define GDB_ESPIPE         29
 #define GDB_EROFS          30
+#define GDB_ENOSYS         88
 #define GDB_ENAMETOOLONG   91
 #define GDB_EUNKNOWN       9999
 
-- 
2.47.3


