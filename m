Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6EBFD88C1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05A6-0000i6-BE; Tue, 10 Mar 2026 18:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05A4-0000hx-MO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:02:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05A2-00059d-S4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:02:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48540355459so20314885e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180160; x=1773784960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbjCxPdxTy0F+sdur/B9cQkzQDmrjNtGzbXRyewiX7w=;
 b=nm/x9TGcsbvYqgs/VaGYfyMSIh8QnT9I6qs+3dLup7fv6pqWzDW2shC4tO6TgcxMTe
 EbFFX19/kSrWPmvAtjx6Ju53y12fY7gnJJKs0NMFU9rAFWWMc/3YeKes+CkuRyaiM5fd
 ++tlyravhmo+0P64ag535Mdo7bUaCXqkDzKIJlSjoUGVpkc7dEIFw+NHPKI1I6U+enuG
 /Aq+87zSu2yQHSIgusRPTEoIO5p+6BbKEOU7FHNKIArhyxmyrJxysPBf+i1Mu4HWBtvY
 HRQG6Bv4/nXq4nk565TREvK1BsqUCQxiwxafpN4zF3t7+Mtj9fFARSOzv36N2+mbqE3o
 j72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180160; x=1773784960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VbjCxPdxTy0F+sdur/B9cQkzQDmrjNtGzbXRyewiX7w=;
 b=NCefdvggrxKHWldabqJfVwE+zIXPgopW3ANhR608lfcRCAlV0afupJ1AlfInXzR4TG
 oh+PpWOEvZ8esK9rRHn2Q133i5lfcvowivd+yxBiLafJjomAkbJNUUzid+klDqZCeKkS
 ewLpgmdKdBGjaOkoyj3PygxSkHLL7tNmFrFMbI0x5lLVk5L3uM51uSrjsDS1KjdncYKq
 n/JNyiaVz0IHg8ejQB6Mgv6HkTG1icYUd3mDt1T1ng8JH7RoTCstcKhnBnwBVXBNjIK1
 ks3kuKH/rvwzO/01poyt6kigBCz03+/vj1bO1Y+4pzTFy2R04Cx2N6k7nUP/7LqCj1oQ
 Z/lQ==
X-Gm-Message-State: AOJu0Yztio0Gvhlgtxlrt+LaV7djFxTQHJMgpjEtFJ6D861Htl0vln9q
 z1hM+DaIAfaQyEHIcJEHTi2uSrt+HJ95r5syiKTE5wS51OS1ZrVNkMnfO9bPdzoL2Aq/Fp2Yl/0
 VkzxdhK8=
X-Gm-Gg: ATEYQzxTMZP29gYkQprPv9HLj+/LFR2/LGC02GCHpJj9YuIjjvqJGcjV5UZSF2B19fx
 cnqHoHfsq/gFi+B/XQcynsKvNV7xmBg34nrMk2faUvAoDm3tbV1JFV9gofOcEpkuLdJjJWLvxWz
 eM1LbKBhn8KKFI/q3rw3RnrOIPeFbUGQ7mx+e9w3hir68uQ2JpC2Lq8Hkvp7hNJjL9rWeP85C14
 KVNnPB7ZeYLw8Lr/OsCnDwf9Nr/dts1v4qBAxXbsZqPGKEs3dRDd9lPz81MERrqBRf9g7Kjwo6x
 3UlAZnbtKiYWQPYdDA1PikfgSAq/hlvFgVzeU3n2nnQCu87TXdnqzM5q6B/DYb5r09M4V3i35BD
 /bSahgRlmsJO2YwQsO9FM/OMmqa7IJmNmQYxpuUfLjFSl7dPmJ4sIqDF/V4Uv00VmjfGmOjFGwj
 uXQmfA4oZwRvH1QeQeVI59otLBTzSNzXj7NRrBiR3cellbVVhRS+bmN7Yu2tmgwyCyU7i+jnsw
X-Received: by 2002:a05:600c:4ed0:b0:485:40a6:442e with SMTP id
 5b1f17b1804b1-4854ad71905mr7581765e9.0.1773180160477; 
 Tue, 10 Mar 2026 15:02:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm184687925e9.10.2026.03.10.15.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:02:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 02/12] meson: Restrict gdbstub to user/system builds
Date: Tue, 10 Mar 2026 22:59:05 +0100
Message-ID: <20260310215916.55815-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Limited builds (tools, documentation) don't need to generate /
build gdbstub files. Only process the gdbstub/ folder when
user / system emulation / acceleration is built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1867560da63..db8918dd303 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,7 +3754,6 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('gdbstub')
 subdir('semihosting')
 subdir('audio')
 subdir('io')
@@ -3805,6 +3804,7 @@ if have_system or have_user
                          output: 'decode-@BASENAME@.c.inc',
                          arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
   subdir('libdecnumber')
+  subdir('gdbstub')
   subdir('target')
 endif
 
-- 
2.53.0


