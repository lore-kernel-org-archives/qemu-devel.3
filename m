Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F576F4BB70
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux2N-0004TH-KU; Tue, 24 Feb 2026 13:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux2K-0003xY-EB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux2I-0004bi-Hb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so72424035e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957288; x=1772562088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GO4jDCd0Pe5AxUp1czjbrWWzJll8+alOSoTJpwNJy/Q=;
 b=OjRbViNb4qYJuvyV8y/F98jKulicsIi33r3wpuqITfkB+gA5WsXNqXtbSMOYN8iaii
 jVjWMRJYmOGw/5UrTteeOWqCbv7BvBJK98XO95k5EUkiG/76YHyuK0u2YJu2jsp7Dl3F
 FCielPu7QBxEFRLC4vCIN3Q7i3aYBSuFmMk9nSej+dKarwhmlgrviLs+5xmypQDNtRH8
 v8I+8cLvze0d9gxW2x9pjDcwKTN+gRhurfA0gaFwiudALeF3DoqmC+uXLOYXXbvdHL3a
 LHFFVkwvRvq0FuASN68J/8UUCYXbby0KjXtU0ubya3+O2otIooq+1rWX+P/jucjvhAIL
 L4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957288; x=1772562088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GO4jDCd0Pe5AxUp1czjbrWWzJll8+alOSoTJpwNJy/Q=;
 b=MvJmDjwoB9GQ3DsbM2F0CwDZM3DNIhMhxJYIRaekMwUULhxtU2P/0CjsBgAFUi+Ldu
 q16nRXiWqCys0G/fWm7q3cQvFCuNky5nz0Yq977/PDhCYQ9GpkD/TUyAbLethmXS0emS
 q5TK57Z3y1rek++r0pJiLLg+RL/SohpQdFx/1zULpz3lUAHAZafaNMCTvKuw6abiKz/Q
 v8Y89XuhHnC/eK+/uvePYxhK4uEBCdFOOuqTCSWmmDcgoDnFr7LvsacYBRcpxracKkGT
 5jAEBcHJ04x/3aR3SElsDVrcnLy3SAJVuowhjghrqxhKReIBW8QowdDGvB+oGUeaz32L
 IyNA==
X-Gm-Message-State: AOJu0Ywddxgbrh2B3kh1eeunsRnxaqPQ3yopR/y1nc5PbueBbh2mY+2U
 VtCW61ymOeoocvYrrs2hNSjOedVXh3XJPht/ADYxyQryM/ZZb3vdCDNODTtI4dJ2wqeNvNkWgFp
 HMf+jZuA=
X-Gm-Gg: AZuq6aLvpYymaA0CUts4U+PiuKTBbvP76Z/6XG6W1PVuzyklS5V62Nge04Am5HmhCyO
 3vvWIIyzjOgha0rLf44UKKQSqQVNK3s/tzB4MCuYLo8PVD2qEryKib4xMn/XA06MOO5r39Qd3z+
 Nw4PR7qncItmlvo8v0shNpVSYu6RCiyDKXbzydfn/iOqEPOlejNafi3vExdXWtHuVvmtTaVQ++i
 8VNYPXNip+XgyjLIs65rA8TPG2ThdeMqIFtqmXd5t5ngqk8eXdjMrog+4ndpjepW+iIgJXa32JU
 pdZlqs8VXz4fu/T0Ls61eMom1rjVkJx59CWfSg0WSrOcPFOiIlJR9TX3qLMJKObJctEUNpAVgX+
 E7iw2lCFC3cBPoafOQ7mDeEcIcylVCTb6u8eX62J8Jcvl/Ko/rr5U57z0YUoltGFW5SEJAK+nuY
 sinPEga5JEC6nGQUy0GN+HHO3M6aQxZDKRMm6r+K0mvKq/1jLGhQbCi08VDXKon311ja+lhO4a
X-Received: by 2002:a05:600c:37cc:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-483a95bec82mr243100405e9.9.1771957288359; 
 Tue, 24 Feb 2026 10:21:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm17794345e9.10.2026.02.24.10.21.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:21:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 10/10] semihosting: Build stubs once
Date: Tue, 24 Feb 2026 19:20:16 +0100
Message-ID: <20260224182017.99865-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 99f10e2e2bb..15e3be26989 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -1,4 +1,4 @@
-common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
+stub_ss.add(files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'user.c',
   'guestfd.c'))
@@ -8,12 +8,13 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'guestfd.c',
   'uaccess.c',
   'syscalls.c',
-), if_false: files(
+))
+stub_ss.add(files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
-  if_true: files('arm-compat-semi.c'),
-  if_false: files('arm-compat-semi-stub.c'))
+  if_true: files('arm-compat-semi.c'))
+stub_ss.add(files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-- 
2.52.0


