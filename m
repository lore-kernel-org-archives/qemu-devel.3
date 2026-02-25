Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702C0F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv637-0007I9-Pd; Tue, 24 Feb 2026 22:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv636-00079f-3u
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:56 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv634-0001lP-KF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:55 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so55556665e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991933; x=1772596733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0epq+6QZsCe47k/6CG2pTReGs5alXgPwTRbusLrwnXo=;
 b=XDoqnGhYbHF6RYxkwrUtNr12aMwL5KGI+XuAMXjm+SZCMpYfX2+wCjPdjxgnzht8op
 dxHv5JDoUf4LU01jD5q5oo5y3BYTDt0Vx4koky0OBIAFKjAMvtvE3Td9vX8WU7h5Tc4H
 0lQhr6sAcQcnQpgxf+u+WDbt/V9O+u/3AfAmIRpR5M05v0S+HTeIogh3n1IvDWBppR0c
 EDfweBwBqlaQF44mAR+1qpHy6ASw4YWNOuXabIbJmFUA/cPFJbcVuVzM3k+zBnupia4j
 96MXRs198MZGBD2FJNcZmLjphf9v8RFHoPBLtS6iH9wzv9tolfO2WovkN/uB3rDeoKgN
 I+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991933; x=1772596733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0epq+6QZsCe47k/6CG2pTReGs5alXgPwTRbusLrwnXo=;
 b=vp1neyu5nL31UbbI3iJpIrBSAImaAY35+2zghVUrloVPVgHCuAKHNYwy5pF7R8ssI2
 XJn3twPLmRyZN8Kcc/GWyzV9/5GcioXBM+r6pzs+gBBlgOx9/TXUC2+BMomjB+3vW24c
 iK4x6A+uRSoFvHiN+ARNhBZlkYNbwZbSo3zXXqIXOMwsPm/RTr0viJ0rArlAXPut7BIZ
 3R6n9bJMRALa9qm86WLTTQoAMtTrvigR37rGKy/CMuT1zDlqldXFhdP1tYhh+D/IdfrB
 e/GTmlapl1bDfe2egW+Vz6HvYZW0a4+eLr6LYkusBZF0B0b2Q5hteT4FOT/ZnbIq48vz
 940A==
X-Gm-Message-State: AOJu0Yx5RgQWuAef9cDTJm2uuw9Y1dgF4i/fn42beFM+fxRSTe0LIUGU
 OK3PkzQK9w+y9SjdIT0LxaYud7YkQX0ZZq/HK5d3s+AEqjkx53fbULseGwb4FjKb0McFUW+dRcy
 FzyvJpLU=
X-Gm-Gg: ATEYQzxMFWk/YfOHJJZHTPnRz7NnhJeXAGxUPXiW0iaKXrjl69h/7hSI5LnVzq5niWN
 VxZwxR/MIBG+rC/BGvUjgUUC4LvTU89T5jAr1hFT1A8rH07kl8npeT5NtgTZ9wDd8YBLMcJY6UQ
 2AL9eYc/8QgfRLXqEHTXcVGx2VoUCJ9uUQnaZQ4/7T6KQ6twCP5NNivc2mFCjayYHwdY2y8NK4b
 cCXRLC2z6HNTxKUQQwpw5z8O58H8lfqHXkTNmnDd4nC/yhHlVyaQLSRutttrBYceYYl4ZkrSQpm
 wWTB5gFfi56bhp/wZextYj3z0tTnKzDTOxnEnTZle2/ABisc/Be5uWjzW4hrUCMN3tj08rJ3J5D
 NcCmgH4PIp5dnUGeURWXpT60sq4WcsBT5tr/1tqDFNnUquA6QSD9BXmUjlBg6Ih1K8xwMY6lrYh
 xS8DgX5a0ciJwEkbfDRPPWTviz7ryYuvB+/hWOCWPhAh0F3OrK2EuB2vw5MQvQcoj+Ktu6iLey
X-Received: by 2002:a05:600c:314a:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483a95b3e62mr256637975e9.5.1771991932843; 
 Tue, 24 Feb 2026 19:58:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf8b6sm1632735e9.20.2026.02.24.19.58.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 10/11] fsdev: Build stubs once
Date: Wed, 25 Feb 2026 04:57:38 +0100
Message-ID: <20260225035739.42848-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


