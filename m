Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6273CC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWBQ-0007ph-5T; Thu, 01 Feb 2024 07:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBM-0007nV-Rd
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:41 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVWBK-0002AS-Bs
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:28:40 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d051fb89fbso12224041fa.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706790516; x=1707395316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB4Epfg8EtaZj5aKH+XSQiP5F2xLNHDHewznk8QZ/uQ=;
 b=Mhf5eHhMd9726iLRgT9RJF6EXSLQojnDqkZb8e2c211DUlYi6jvHaOobEIPayuK+1e
 Kkje8KSPxT0kbWE9vX6bjuJirXQ6Ooj+K5dtWmZcKSu/OTDQ8SQzuausiIOnzVK4jFuD
 ba4i6bcLl8lYfrVl3QP7ZGgqMj9WZIfH/DgsJAqdGaA0ySMbyvOsiqT/fzozR4sSyt6I
 M4Y+e5oZQhq8WP0WGAhsCv+q/yW8Mq9FG4Jw4O53fS77j43bTDQVr3B8f578MkiYsJsA
 wOfeINeedt0DzSJfUKzqYn+u2afXlSK3KrWAmnLFBQpIhxQX6upHRiq6rA7lSEnw4VcO
 71gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706790516; x=1707395316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JB4Epfg8EtaZj5aKH+XSQiP5F2xLNHDHewznk8QZ/uQ=;
 b=k/w+nczmLmxiTGLpRrX9/Menny1Gy02SiXZWhZT/Vj4xTlbtLuKiBEd/zrmFpDDwXC
 Z3szGCu+oZeuUQj8ilNzLDNa4H0Hg5wOcPHVRDRG2Y/vembGf/z3XM8+F9TuOACeC/Hv
 dUtrHkMlm0qXwEezqMGRj+/6ZoEj46jE7JaXmCOe/7z0AtrqfQN7qRnQPuf9ouzdVA7g
 4PuxVqYJf4HFRmfvZFK6tQPL1eGD+3nITR1AvPBlWq96Gkd5eZxUKpSv/nZNTYgKUyMr
 SRJi65JuYPRVG8hJFOvhFqwz4naX6/a9Z01TUxHiCbW/UpHgbeRWzgh9/0x271d7Pjqr
 UO/A==
X-Gm-Message-State: AOJu0YwCQPN/vQerzF0R6HkCtqeHB5imJhRPvG+N+11AWFKO9+d7yi+L
 fCho8okQ63XQxakc2PXF8V3NqgNQGeQEjfNgntj0hNTrjbOimehsAw0D2eT6vbc=
X-Google-Smtp-Source: AGHT+IHfQ3BAlodQIwg5MRRVv6skMju6Ub91ft3nNbR41ng8DNcgl413x6yoHbvU+Yn7FTp+gi8niw==
X-Received: by 2002:a2e:924a:0:b0:2d0:58b9:2bf3 with SMTP id
 v10-20020a2e924a000000b002d058b92bf3mr3633384ljg.20.1706790516372; 
 Thu, 01 Feb 2024 04:28:36 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW6RyN6yqTxhJY7XB2eZbbKlZIoLtk+r8yMdvLzY//FuqQrAuQ7u0YYnST4sLz8+61z2D8dpgSyB1g0nZ0tXJW6lRmu2IOYksW1fyeB1unTTlNhsqe8u6khODW4tPeV5Z4s8kpAVPs0gup8vF+lUi4poTgztrZxyyhsZhVUUpEiIoMAH+LY2XKySSFme6372RZy7IHmeegM9iEyRpltzlRTm+4w11T0fH6yUARFfE3WaxUP3WHqMgSHvoBqoO1EZcIbtiUF+oThrBMFchCZuGdOKF7ghEkrlnZIgxAy88D9+7Hjl0yWjVlaZw7ceJIEMYuUasajWOfOFYoSge+n/XJcAqIAbIslaDC9vguj6YihichrLEgHcEqdYVAvzAokB51wc3gUnNeG+EtFo35c9xHURio3Ia+YRdnUjBbhrIKMEvVbXJa6l3t56LIYoIEG0mjn8pninNcfgOavxm10wDTCusy6P9kwyjsYy5udPsFnm4vQ3iyx+UEnilNivv85nXmmAJ6vEX9knNoKzAICZanprhpfOitjbn2Q0YOvPHWDdvZCoCBNeAZH8aoN2Hrwbg7Y2mOk0Pan5PqXwacn1XKB6HMXAB+LEAu/ACSTxNrLZM6/zIbXDsSQnXKIhbnD/IZ6NCIntvbTsrtE4JXT1SoIECEjaHphMfRjzhIE8niZ7khzdRohSsgLcueVjA==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 cs10-20020a0564020c4a00b0055d37af4d20sm6621335edb.74.2024.02.01.04.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:28:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E4DF5F9D9;
 Thu,  1 Feb 2024 12:28:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH 1/5] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Date: Thu,  1 Feb 2024 12:28:31 +0000
Message-Id: <20240201122835.1712347-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201122835.1712347-1-alex.bennee@linaro.org>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


