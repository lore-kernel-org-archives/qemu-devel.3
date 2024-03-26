Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11374CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp619-0005Dy-SJ; Tue, 26 Mar 2024 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp616-0005DK-S0
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:00 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rp615-0000en-7L
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:35:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ea9a60f7f5so2335637b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711456498; x=1712061298;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vYBWS+x0cCz2HwpXjLNdbyBk5DIta0GpDi9Mx2R+9is=;
 b=W88syRZ7pBOiLHJltUkR93fphlBbbAD2Fggdo/yF67usBXV/FdOTmmmVRBevavORdG
 eqksBg6NhEdH223fA7QSAMkMywvJ8F+knGVZ3Pfgy5IBcX9aQqFo4y77dZZPZhMtN1il
 AGS3mTalVmzdv2UwvKPZe2+74hEeUxVZ1TDfc1hgl7pQAnYj4Vo00ilNIawNH86KgHiU
 ZPbqECJignwq5EMrWBJUz6Ben68TR2hSq+xScbHAk2Fq55nZ/79bpTsi4V706TFYDxDX
 uDtrhJQGHkWu9nQ7Jb/K2CtmwxfJ3pbMEIhFcQjaUBd4iUF52GvlWf8lXw6wjSYwJPGi
 n4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711456498; x=1712061298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYBWS+x0cCz2HwpXjLNdbyBk5DIta0GpDi9Mx2R+9is=;
 b=xLNOcbDubDtR6A/BK7/1nNpMlz3ICoMD9rhizGdHKLgURIO7u40Un9Tp6/YlCQlwDJ
 YB97yyUvVg5RaaAgHekAiBB4gvXxV2cRhzD6Ets3l8bGV0PV8IUqjRE/nY9t7rTKshGe
 R3U/t+fMDGJ74ewmyuqbaCFzVSxbiWyywwdf/6Anp2sEvX25waywz2pzd1SBAhwVOoPC
 kI+myVkAdFpiVVCNiY5wXhZQEZzuW3JZYKu0W2bz067TBHHbedvTyB42YQ91CU5sPWjK
 Yd5w37pN2LvRXJJSGKe+y+8uOFFkjmnVbKn5E8jAxCWhkHXw1kBd28GwmRd3r0HMiajj
 jRQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQREiZoIx7ISzggr8tEs7Xtg5IrSnmKW6D7vCDbkSu6q8fylt95L6zAVlOuU3uiVnk+0ZMi+7otFMLlClKP/bgYQfHmoI=
X-Gm-Message-State: AOJu0Yxo4KH+1/yjZk6y6RqdWYhcrszKouEE7YlTTqAvEAKbNRbmX3df
 CFKfChizp0r6YB3SyMr7UTQMITgKCOH1jg02wkwtM6KiDscZINUM6iKwUTV+Oc8=
X-Google-Smtp-Source: AGHT+IHK2/a9ocYwQfFGOprp1X5uI0qcJyrqhoEAEfhHKWVq5Z8dj53aenuBibdidfnBJgSG1lmEjA==
X-Received: by 2002:a05:6a20:12d2:b0:1a3:4671:2285 with SMTP id
 v18-20020a056a2012d200b001a346712285mr9557900pzg.44.1711456497934; 
 Tue, 26 Mar 2024 05:34:57 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 d2-20020a170902cec200b001d9a91af8a4sm6691831plg.28.2024.03.26.05.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 05:34:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 26 Mar 2024 21:34:22 +0900
Subject: [PATCH for 9.1 v2 1/2] buildsys: Bump known good meson version to
 v1.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-meson-v2-1-d9f9003775e9@daynix.com>
References: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
In-Reply-To: <20240326-meson-v2-0-d9f9003775e9@daynix.com>
To: Beraldo Leal <bleal@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: b4 0.13.0
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We need meson v1.4.0 to fix MESONINTROSPECT quoting on Windows:
https://github.com/mesonbuild/meson/pull/12807

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 python/scripts/vendor.py                   |   4 ++--
 python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
 python/wheels/meson-1.4.0-py3-none-any.whl | Bin 0 -> 935471 bytes
 pythondeps.toml                            |   2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 1038b14ae0c8..da463fbde557 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==1.2.3":
-        "4533a43c34548edd1f63a276a42690fce15bde9409bcf20c4b8fa3d7e4d7cac1",
+        "meson==1.4.0":
+        "476a458d51fcfa322a6bdc64da5138997c542d08e6b2e49b9fa68c46fd7c4475",
 
         "tomli==2.0.1":
         "939de3e7a6161af0c887ef91b7d41a53e7c5a1ca976325f429cb46ea9bc30ecc",
diff --git a/python/wheels/meson-1.2.3-py3-none-any.whl b/python/wheels/meson-1.2.3-py3-none-any.whl
deleted file mode 100644
index a8b84e5f114a..000000000000
Binary files a/python/wheels/meson-1.2.3-py3-none-any.whl and /dev/null differ
diff --git a/python/wheels/meson-1.4.0-py3-none-any.whl b/python/wheels/meson-1.4.0-py3-none-any.whl
new file mode 100644
index 000000000000..ca9adc3f024d
Binary files /dev/null and b/python/wheels/meson-1.4.0-py3-none-any.whl differ
diff --git a/pythondeps.toml b/pythondeps.toml
index 0e8841599935..4269decf0e3e 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
+meson = { accepted = ">=0.63.0", installed = "1.4.0", canary = "meson" }
 
 [docs]
 sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }

-- 
2.44.0


