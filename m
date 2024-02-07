Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AAFC4829C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwF-0002on-H6; Wed, 07 Feb 2024 11:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwD-0002nw-RJ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwA-00066Z-Uc
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fff96d5d7so7338985e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323893; x=1707928693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB4Epfg8EtaZj5aKH+XSQiP5F2xLNHDHewznk8QZ/uQ=;
 b=S1/XuH9hhVCF17vL09deGuOPCEvDKTUWFGonrGvtfAQlnfYnDHLG9gurWZBPzu93JD
 mMAXEk2QzuU5g7qovS1sxb/IBZ38/UqeF9nPK1QvnqmtebkjusizrjWaC3L0/E9mnNdw
 VeCqeIMY1IwdvbmhNq+IEuepGT3YFZhiEBqcjGonyt8Cf8c5DiThSG960t3535KkT6ZX
 oUqg3s5Sf69QHoZYUJfAYXdTCceHa9Zb1qKP+aRGGDBwMUWmMDdXrO0n5Jq2lcCMj2OT
 l/oI0C6M00Jy7PhVkz5w/3fZ6eK1TMXVY+m6CXeok28/NPp+KiiDDit+ny4jDf4vHEA7
 XLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323893; x=1707928693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JB4Epfg8EtaZj5aKH+XSQiP5F2xLNHDHewznk8QZ/uQ=;
 b=JTvpIqGzWdk8yqd5xI+A2J19IBeB+p0AIjiK+pIdalQOsxiXSVMqFw3T9mXcTMN7Jb
 ETdcrtNUrayeFSYm1WLmnpmk8UpErB+4Au+hLjwNHRP1RMaZyGrubLzT2rWnC6VVCKaA
 gHChCJhv/Fe2HI/f30UX5eahaDCtMYRTNe0o3ePOSRkiyrkJLRAThLQJBoKCoPPRDCaa
 Lo0nGXr7Hpns7pGzNtHAMWDS7FPBxNkmLF/mUDmFnczTqVO1SHAvu+hik5xDgs2QdMzo
 ka4m90oHLeD9ymLxELq5sfqerY6z+LW4oHdYZghv/FX14KueqHWmHkA8vQdIJgX9aGWL
 ucvQ==
X-Gm-Message-State: AOJu0YyvOTEIF7tH0Cw6bbQS5qc09V3pz2+Q8xurKJSlXj0mFOZEh+MA
 euFeGEorp9cb8jYP8VWEZ///R6ffjQkstHSZoEBW2srmLOBsRzQavorkPSsD48U=
X-Google-Smtp-Source: AGHT+IEvPFJ9AiHPXUgrQGtYUNZtWpPgdfAya6MNHNQ9hp7Y4s+Nd6cMYbuiU69XSt7x4kxOo+adjQ==
X-Received: by 2002:a05:600c:19c7:b0:40e:fc29:f503 with SMTP id
 u7-20020a05600c19c700b0040efc29f503mr5405118wmq.2.1707323893503; 
 Wed, 07 Feb 2024 08:38:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVp0oEbxQlW6lhYbqyiSfzsKgCLMiomGRKPA033C3MhkCfL8fILFps9xeAf/6Yl8ainmRYQ53W2P/oK0WJuCXotuRRzakC+kxGpY0oivDFJktSNHlI/GOKq0HFQqAf6ivyjx/yD5XhIln1qOPA0t088I5s+/ISRLlRpXigdaq/ZyZd2ewr+s+gZ7mN/1+ScxGBj7UW5NLdxFOjXjQCIYSTIHJmwMNji7mHrOVp9kvt4PHtXI6wl8DAP1uf7MrAFa80LAeuuqxk3sN8OLjP2iRmjimMiUjdaz1B8+oRWV5GOWKykDSpUPSlEl9W0goLRkS+7/aiiAwtwmGTQWqCwOfJy0zGX2gE1NskLgNPSh8fS+M9jL+TDNdeQUEq6B2GFA2bopBKOYQoF4EeVYwpbIa+w2BZ2bPYTQpUZsqyFhxgGfanNibpUyLBTDzBQ+ut45Kn7BtsJd7ZDWb7mjngI+UrOE2z14Y9Kg+cTMXGD2MSNiKKgnP85b+Y4hG7CL1jpCg6xK8EdnWrM52cQQsg2uRTRtqHcW55CNuk1ySQV+EbsG8808OgzUmzL5OxEMJFTA34TyywR+brmx9ZCjrfgpOxwiYIL5I/AaDS0PxiUE+Q9bnA93AHzIfKCdhRU/k19eLE0B4+HE9mxO7lsh+Kt0DumFz9JqtwrsvotX4SkwWQiBFf5pzNe6JxCMfZJsskUMIP6O3ezSpIUEDiG3XKp4Me/bCMZn/8gjs/7XR8WpTYt1iYqTLNsiJg9pbcixbGpyDVQeV99ED66J0F1fwi+H1iQt/2glPfy8PHUACCjuhTUoF0Et4gCJR2/nD4DQmrC7jiMn08JZ8ForUt/A3EijVwHLmEYmD4k6Nn+1rRsnJWnsg87Bbs7sOjME0VlwNvRYw==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p22-20020a05600c359600b0040ffe1ca25bsm2621880wmq.21.2024.02.07.08.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C8BB5F7D3;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Fabiano Rosas <farosas@suse.de>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 01/14] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Date: Wed,  7 Feb 2024 16:37:59 +0000
Message-Id: <20240207163812.3231697-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Avocado needs sqlite3:

  Failed to load plugin from module "avocado.plugins.journal":
  ImportError("Module 'sqlite3' is not installed.
  Use: sudo zypper install python311 to install it")

>From 'zypper info python311':
  "This package supplies rich command line features provided by
  readline, and sqlite3 support for the interpreter core, thus forming
  a so called "extended" runtime."

Include the appropriate package in the lcitool mappings which will
guarantee the dockerfile gets properly updated when lcitool is
run. Also include the updated dockerfile.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Andrea Bolognani <abologna@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240117164227.32143-1-farosas@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/opensuse-leap.docker | 1 +
 tests/lcitool/mappings.yml                    | 4 ++++
 tests/lcitool/projects/qemu.yml               | 1 +
 3 files changed, 6 insertions(+)

diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index dc0e36ce488..cf753383a45 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -90,6 +90,7 @@ RUN zypper update -y && \
            pcre-devel-static \
            pipewire-devel \
            pkgconfig \
+           python311 \
            python311-base \
            python311-pip \
            python311-setuptools \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 0b908882f1d..407c03301bf 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -59,6 +59,10 @@ mappings:
     CentOSStream8:
     OpenSUSELeap15:
 
+  python3-sqlite3:
+    CentOSStream8: python38
+    OpenSUSELeap15: python311
+
   python3-tomli:
     # test using tomllib
     apk:
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 82092c9f175..149b15de57b 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -97,6 +97,7 @@ packages:
  - python3-pip
  - python3-sphinx
  - python3-sphinx-rtd-theme
+ - python3-sqlite3
  - python3-tomli
  - python3-venv
  - rpm2cpio
-- 
2.39.2


