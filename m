Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B590F4BB6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux2M-0004Jw-Ue; Tue, 24 Feb 2026 13:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux2C-0003T6-0d
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:27 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux2A-0004W7-3x
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:21:23 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so4410897f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957280; x=1772562080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvMJBlihfqunx1Ew7ilG+UP9FOoNlaW48rjg9xxbkSg=;
 b=lb7uYYP2WiDccol5Hr3rskLGlkJjebPqYyqY27ea/aaawWp2Z20s5yKZnD3XlC1Ax5
 /CPz9bKaUfX1eXgMj9yV4NmvUL88lEaprU81p+6u8JEHbl2u0nbAE2bVHXc+z/4pnCiy
 VRiyUPUhq3ZWnOxT/jcfIHX1qWGgOCCwdtOncq9i8R08lROTg/nJWz3a2ntKqXZNmQAq
 oR3+DdmRxvZ//ez5qav6IgN7afw2qVrM7I1yWQf/Eix9EE2cwRcIZHk4UeQwTUquynwP
 LEHUlqv3opUAT1XHm3uiWi+CUnrrd4iRbegC/KRr131VbW6i6yc1LUzWU827VS4pZqgV
 geWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957280; x=1772562080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hvMJBlihfqunx1Ew7ilG+UP9FOoNlaW48rjg9xxbkSg=;
 b=E4IeHHl4ctEnWlDDsLMrv/9CwLcd93VLemwRjyvKhixlXbZmIS0rOkEug6glNiR9WJ
 z33M66decNKv5akBLh5Hw+D94kikk8dyokdAtIJKkUHxsZFGz1bJZiemcXZDCH8SbiSn
 L8ORRYJWg3yWMP5mQoH/UEHTrRcGT0LTLgCxabX3O9HR40IyPb35njFOt1FMWeCYBIzZ
 imhbkx6QJisQuCbnjsJD9ya9Z+GDaz6VdBAylKo0J6v7qqEcXa1m2YBE0I3gVsCbfRsl
 yqD4mZ0Mc0fXG4kwbJAWMDw6uHDmletPonvIPoD0MObxAqodxtfn7uRO6trsprEuCYF+
 8ZKA==
X-Gm-Message-State: AOJu0Yzb+EzGWHvtmNeUPvxwBkrxMkr3obXR+tByoqvN2xkhvP6X7MuK
 x94tuM2fT2G3XhWgZiNSXjadiejNdBhDiWVJiMaeLQ8bYrWVsCFT7fqUD/0n4LNZ6Ny+QOffK8f
 Ck8FFQSk=
X-Gm-Gg: AZuq6aJaC8Gi4t5Ma0prEf2yXD1TpptTHnTpJp62VV+RAiqW8g/BGpd4yj5Yn82/n05
 EdSwG/zcavtOWSHne4w5nVFv8dFz2aRmGCoBp8aWg6P5vkX3MfTpohbILz0/se7PsUdrhv6UvdW
 nUDDKNLHBD6amaEUAlm5wM7IVoHLE+OYZwEVm9oXSII/5v6uvzwbdPBvZgDui87DYtoCW5f+LrK
 9rhE0A6y3xKStU0+mLtSOBSn6Hmap0xaKF9l3bsEe7VQJAL6ziJhhFGD5mbdWx5SuaWrciXzw5z
 bFKh4ckWGpTg2b31frriUza3YAT7qT1a1g4rlnI0acG1SnfbeWrVrIBNW1OjBOixaEc3cInr4jD
 sMe+8BtFBJJYFXqxfooMvcojd/kYAdmWWSxT6ZxpS/qe+Wdb2RFJOXUZfgzKW0HMkKwpSNXXVWd
 Vzi4gN6RmZ4zc84cVFpRYzdAPMW4QabhpLmSTmmxEandCUe6M1q6sefWVkJxQljHjuk4ZIBFWZ
X-Received: by 2002:a05:600c:4f93:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-483aaa15e35mr233774045e9.18.1771957280095; 
 Tue, 24 Feb 2026 10:21:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483beb004a8sm1715935e9.3.2026.02.24.10.21.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:21:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 09/10] fsdev: Build stubs once
Date: Tue, 24 Feb 2026 19:20:15 +0100
Message-ID: <20260224182017.99865-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
 fsdev/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fsdev/meson.build b/fsdev/meson.build
index 95fe816604f..b552cc7153a 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -4,7 +4,8 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-iov-marshal.c',
   '9p-marshal.c',
   'qemu-fsdev.c',
-), if_false: files('qemu-fsdev-dummy.c'))
+))
+stub_ss.add(files('qemu-fsdev-dummy.c'))
 if host_os in ['linux', 'darwin', 'freebsd']
   system_ss.add_all(fsdev_ss)
 endif
-- 
2.52.0


