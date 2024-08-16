Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4091C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seqMT-0004FO-JR; Fri, 16 Aug 2024 02:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1seqMR-00048e-Ka
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:22:56 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1seqML-0004Mj-WC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:22:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-710d1de6e79so1249061b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723789368; x=1724394168;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tjtZn77GLTmvYEORgc/U28GN1RbeUXV/+OVfzgS+jrM=;
 b=jK5alqIFaNlih1fAiojZx7cEXxqv6q15edswdocMUmJTQRhC7k+GRNyePCkNw8xAfE
 GfnQtsEMyX+qZuUQjscMt2sx8DK7TJkzTiay/ippQjxCxg8ARcy/I7q/VV+VRs2nT1OT
 r/4ykKuaSjrccKKP0gTloj8fYVEjUt5nxJL9mKxDBzgoFf3kU41JE8XRjL+flHL2Bjed
 xV67UdNX5osBMsPwMCk2viyqXPN3Vd0jFoiQ99nmfhEPAXNXRZE4wanajD0h/ajzOCnR
 025i1Va8PZF/+fwiV/QdUOrFdhgkn/XjgQxrWY+Y/4pWD95a15VelMndtLZ44FZKFBcB
 3XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723789368; x=1724394168;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjtZn77GLTmvYEORgc/U28GN1RbeUXV/+OVfzgS+jrM=;
 b=WPMguW6UbWP3YW6Yl16nsPSs+V7sxF22Ydop7oD3b2wSvW5o9B+Ss5v1/aiTXoMBfn
 sbDEMnltAVVTeiFUPOzGKYU59RdsLjwEImp4Z6Fa8whvkNOnVMMr+YlADdfXREvxDMen
 xV2jiRXXB+pCiDjWvlAC+Her+rpTs6gbaih+bgwCPQhT07k+31BoO1rkPhwM0O9hVJSm
 N2Cq868R/UODJXNfNeRugB22x8G+lGeHprC5oXbkeuXjDV7ivtrT7H+OPHzsGpnVXKrk
 JjaGdTI3TnqVPDE98Idq7IhUGegsOz6y6mu5T/3XZ2ap5vb2wj8EIgSvhkiM9hXsZiB6
 TLNQ==
X-Gm-Message-State: AOJu0Yy6MouzWKz0NLH8jicuTUNLnrXxm0e49Tfgidjcmk0PDmOXS/bs
 HGIg+MVt7J1VObVDSwT1ROBdYXTLC+noK2gYkVEpesv7lP6dF11qenay3B0lNKUE4nFuWMCQIWp
 G
X-Google-Smtp-Source: AGHT+IHLmksn4tOdIz9raDDD4VFRGnC1H0sEzwdSM258WE4LiJuyEjivXkViWK8egQCXGzYdiiFR3Q==
X-Received: by 2002:a05:6a20:d492:b0:1c0:f315:ec7e with SMTP id
 adf61e73a8af0-1c904fc9edamr2595808637.28.1723789368040; 
 Thu, 15 Aug 2024 23:22:48 -0700 (PDT)
Received: from localhost ([157.82.207.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-201f02fb432sm19260085ad.54.2024.08.15.23.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:22:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 16 Aug 2024 15:22:16 +0900
Subject: [PATCH v3] meson: Use -fno-sanitize=function when available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-function-v3-1-32ff225e550e@daynix.com>
X-B4-Tracking: v=1; b=H4sIABfwvmYC/22MQQ6CMBBFr2JmbQ0zJam68h7GRWco0oXFtNhAC
 He3sMLE5fv5782QXPQuwfUwQ3TZJ9+HAvp4AOlseDrlm8JAFdWVwVq1nyBDOSnTaBJD2jILlPs
 7utaPW+r+KNz5NPRx2soZ1/VPJKNCJUJWuEaDbG+NnYIfT9K/YK1k2pl02ZlUzDKiZTyzrvjHX
 JblC0SbFYLbAAAA
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
-fno-sanitize=function in the clang-system job") adds
-fno-sanitize=function for the CI but doesn't add the flag in the
other context. Add it to meson.build for such. It is not removed from
.gitlab-ci.d/buildtest.yml because -fno-sanitize=function in meson.build
does not affect --extra-cflags due to argument ordering.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
  but only updated the message. v3 fixes this. (Thomas Huth)
- Link to v2: https://lore.kernel.org/r/20240729-function-v2-1-2401ab18b30b@daynix.com

Changes in v2:
- Dropped the change of: .gitlab-ci.d/buildtest.yml
- Link to v1: https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 5613b62a4f42..a4169c572ba9 100644
--- a/meson.build
+++ b/meson.build
@@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
 endif
 
 qemu_common_flags += cc.get_supported_arguments(hardening_flags)
+qemu_common_flags += cc.get_supported_arguments('-fno-sanitize=function')
 
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)

---
base-commit: 93b799fafd9170da3a79a533ea6f73a18de82e22
change-id: 20240714-function-7d32c723abbc

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


