Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5C5C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaF-0006VM-Gp; Fri, 04 Sep 2026 09:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZo-0006KH-4r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZm-00033O-8Z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so995037f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527004; x=1789131804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nPLDzXuzbV1BfCbu4m3c13rmpJahvjVQlKqUbqJSOWY=;
 b=rl7nl11oYwrpNyuXsmwb590BZRb47gVNbdYUHJQcLEx7eSb/u/ATOcns2oqWV08gDU
 z+BJBk7iYjOOLolVKQ0B4aF6AFl+HOKUZvpsdr3Qu0I4SGbkZ56BoL0PuCIzzXNXB/HY
 o6/u0TSYLgTF8m4E5g0NUUNeOjZ8qS7qKemarT+7wQ7WDdSGXiN/tmYa0JOqgvLiDMmK
 b0+QGeiwEpPUYMFZe1qJfpDEx5/jey6EN632dSm5SuSMXT1uAQimYUm2qJiG+v0+VndG
 hyp38qbQAvBAfYBLmfYvMJXUsKY9ZiLPJ8cgMPzQNVLvculpW5T4kWKHoE8ELyB6VlNL
 Ajtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527004; x=1789131804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nPLDzXuzbV1BfCbu4m3c13rmpJahvjVQlKqUbqJSOWY=;
 b=onmiNPosjXUPXahzZfsyfMmdo9rAJg/xrcYSLCKBpR5G6RziHaCFo2FUi0yD4rb3Nc
 MSbXZlNXqeUhX/1cS5BTp+XhHm7yvETsgTyqlyHF2EtoiVzQ+FSNuatAsOu7i+VZKeQu
 wCj+ibfQ1dJO39k8T8txyHUjAEeoIPVLggI//QvD4iiWV/zC9/AeMCF06HsChl0mGBUB
 kSAFjq50eOkZpYCSB8dDPhThz9OZgvOehCQwCKVPo/LWgKgusNjlZNgilxVLN/sbJ1hR
 BCNzuqfAPX2IYR88K9VmXb+KmicQvBmOtFnHsVeGLU04q/HL4U7r3/KgF8JelaptsXBY
 f+KA==
X-Gm-Message-State: AFuF++m3BrqHqSNrAErtCSWW+YMmEU27wHvWXt1maXbn5Ywfk4grYMaJ
 gtgTm9mHxmHLOgX2i0J69J5nsOV2Krzp2DsB9Hh8y96rxi6aG36Xr8OEj89ohO2EONI=
X-Gm-Gg: AYBFou0TtIbJ8+z2ugZ9EJWLaOwdMx/ju1wWHbPgMFWGt9xeJVju5bJNKMJzUP2lhok
 mvK/pHAtevHeImGLDq0MzWcYQwnmgXEvHYEMxm0WoPhmvgQBq/mKGhYjJt42GG98s6J/C6XnNfZ
 nkUCqSxFG5RNMk3hYexGSc8ZCBPsIb1kQmIUiWq/Dx1c/0i47u7wYCYmmo7jSA6rtkXQmVepdet
 2iB5A1Bv+vJKel0aPt4sMQrpjbC3AJJvJVyyPWpdz6Nb38HnbyMjrJUNdPnwWuXd7LNonZ5qOwU
 5cs3Gt9zvsD6Xpx4ubQTzwbgnUyzIJfKUfIXU9RaxoY/nxm7YeOvMEUOjp1DRtZSl4cNvlgMoFs
 Rl24UsRwOsbpVeytRNrbD9tamNcUKLjP2cOuxB3zHdRIb7IjZcLx99f9bZjaHswKashKTC0Y8h+
 ENVmr/KruOoyz2DAhgQZNIq9L+qS0BWutKmrwZkpiTmXWfFBDKEbn2ylJoz3XRubl/4FSs+xA=
X-Received: by 2002:a05:6000:4304:b0:484:3313:fd86 with SMTP id
 ffacd0b85a97d-485872d6572mr8539126f8f.27.1788527003826; 
 Fri, 04 Sep 2026 06:03:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm2533792f8f.3.2026.09.04.06.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1D7261710;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 027/105] tests/docker/docker.py: remove "Image is up to date"
 info
Date: Fri,  4 Sep 2026 13:44:41 +0100
Message-ID: <20260904124604.2207440-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-28-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fea6d0f85af..315fa2ff848 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -429,8 +429,7 @@ def run(self, args, argv):
         dkr = Docker(args.command)
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
+            pass
         else:
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
-- 
2.47.3


