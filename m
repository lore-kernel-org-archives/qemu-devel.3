Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABF4C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWXy-0005bY-83; Mon, 24 Aug 2026 11:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXv-0005Sb-It
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:11 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXs-0007Bh-Of
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:11 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso6397323a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585107; x=1788189907; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zEBSWmDHcpbyAT5+oxLyqv+4C5kL0TnHpRS3uvgoVbI=;
 b=jwtvpKCrwpYLN+4FtoeNfNykkRmFg6x/SUepBuNNRu80ibLt+YxhGPQ8/f86e0IMT2
 Gv7PspdC5YTgpwZOP/QsOhqsQ9VygvCOuE6WUp2kmwRzKWRhcXj5x0xkG/gBe6w6h5Nv
 0siaL2Nlvo8BlBT87/Wz3xpauVTtzTCGgHG/lSLlLd3vtOcPnnm3UEPQPJ/2bet0sXRx
 uWb0/iMGdkmLVx5eoOhaYxehjA5kHhDAMqWzbuQ3l7F1M7WSTFk7EkQD+dEWol49hROd
 MIYKHaUWXzfUm6gTrwMA4oRExntuPdAW09zibOUSSo4OS34k7tBYnZmr/FCwpT7437H9
 JCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585107; x=1788189907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zEBSWmDHcpbyAT5+oxLyqv+4C5kL0TnHpRS3uvgoVbI=;
 b=FXKh/bENUsGjfSdibcEA4IVIUr8HIuA7yIrb3jCcAKtqFI46Zgjdf44u7cYv8j4bMn
 QPqpfrv8iNCjoU5vduaODDNdMlnWdHAI34jIWh4pzuJiWKmZG5DQipWw7fb5y7mUngy9
 bBGvV7m0b6J/rQe4dCNxmSCuD3iYhi8u3oaLlKxWhqZTg/O9Dcme81hwwW9qsOIFUl6s
 l0v+D2b7BTwa6kCxuz1fwpXasm0IP/og7XwvnbVwbVYZkgDQdUuOWD1MS3lmxwpLboaJ
 OLlAn7VfcfgpMdFpTIE0O3rv7OSgTLuKv387qbaA1sMTeqXIjRKsSRX1UJRaUKLAwSVX
 1V9A==
X-Gm-Message-State: AFuF++kibfD3vvZq1Pac2l00ip/QT9yY4BIugEg9coxCM8/rjHmrsONc
 3s1vMKG/AxCiyvqZdIGqMMrPCDV+lKWNDnipdEfenuQdNjLf+F8asNpgq8Wq8Y/rCBg=
X-Gm-Gg: AR+sD12P6+Cod0qi6zn1ZnePYbU0GtIHFcR5aWGdIDPVfl6jj39ZuMczOxbZtK5SILU
 suYjAhkcS8f7I2GkcmCNpEZkEIArE0MMbq8obplgULbTX3ZiSdLTRrezCOeGPjCZZy6t2I9zDSf
 fqeRWQ/YupoD1569ST47uv5brioIx25/ydDWuU/098a1RrspVHymI/AE+JOq+3wsg66vICSwJXo
 81q3LK9yZmhVKtaCer28eBLZJV3iIQaDAIZ01xr6LnHekOuyj4AiL6fCBYLf4nai+79Uwcco7+5
 ScH2B7kizQkgxofsM2nP7xMqdoVcxLdX0WWJ4dP7leTgblDrEm/LUkZHfPWXGvooJQOpSdwceMF
 tscXq/FOR3yx51+F7cRqAyk4RzyGRUVVROLaQkfBc3lPjP8nO8t9T2CRg9N5rjTqLIIaiKyvn+z
 cdnK36/f+b9V8HwYMAMxRB6lOhZXJZkPz7F3psxGPObVKAUUf3NQ3KCrKheLHN
X-Received: by 2002:a05:6402:1f4f:b0:6a0:6978:bee0 with SMTP id
 4fb4d7f45d1cf-6a582b62783mr24037052a12.9.1787585106912; 
 Mon, 24 Aug 2026 08:25:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e001095sm9806117a12.6.2026.08.24.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:25:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 630795FA11;
 Mon, 24 Aug 2026 16:25:02 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 24 Aug 2026 16:24:50 +0100
Subject: [PATCH v2 3/8] gitlab: add arm-softmmu tests to the macOS build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260824-fixes-for-11-2-v2-3-352c6b890402@linaro.org>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
In-Reply-To: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=B9ZSx+meoWvdNqJq36oJBwbjPxCumeybg4Iya8CkY5Q=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqjGJNnu7NhMoxC7BsjB9Zi+XIJSWsI3a7ytnwa
 j94NjxmHuOJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoxiTQAKCRD70NsJWp4q
 RHjcB/wNGlY9qSB9kIBU3maa+79vGLdbJ2bOgAlw7VnFCdkASaXJsmK1+gE4nIrqak+Ah+f3Vfn
 Ki/UrABJsC2/EVzzPOD0Jx21xwdzwYT4mMcJUuWhwUpLE6A4zMPZNFs0G2LsQEA99z2E770Sc3p
 igV7R4ldS3BzjSIvy9mnB4hI/Z/pMXhm7YsmiMtM/8Rz8HhS21wbnxnkl+Kd0oOgAFlsWiK8Q8K
 TAonKqYIfe177YT2A0c6qpuxq3Q3JbsVKvjtn4G97TpFybCtya2qnWT902uq7fgoOCUyfxibcYf
 HOk8uvBJoCfeaVd1rgEFAwQeVl4mswo411ZqHR652ohbR0Se
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now we have fixed the compiler issues lets have at it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260723200904.224413-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index bdb3eae18f0..40b9b637b3b 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -22,7 +22,7 @@
     - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
     - brew update
     - brew install $PKGS
-    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - brew install arm-none-eabi-gcc aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
     - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
   script:
     - mkdir build
@@ -40,8 +40,9 @@ aarch64-macos-15-build:
     PATH_EXTRA: /opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
-        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu
         --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-arm=arm-none-eabi-
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins

-- 
2.47.3


