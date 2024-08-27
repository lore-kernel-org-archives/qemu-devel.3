Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11EBC54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIa-0002En-2W; Tue, 27 Aug 2024 07:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIY-0002Dd-IG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIW-0000hk-OR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:42 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a83597ce5beso832471866b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757819; x=1725362619; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hs3oTf88fWF9dCWzDoBrmDVG+Xb2xIfD60tPGPs50rg=;
 b=NMEtkhYitDX5uik4LRkcSju6A+AjHGt2j6fxYHRU0f31P0pZZ2LY29arveMZ/GD40o
 Ir8RuZoGkl+y/cfGhGGPEskUZ7QrcEy73m+Vrt4A+xNCbYXvnojfdjSGgN6FPDe3gXyY
 SjgnloriTQaDhHnN4N15/sm/1fnqq4Lg/Oz5rKS37i+GAQRcxr25bIJVMzu/6fMx3vL+
 x2j+gmovK3j7dYm1YkKHu2fatbcamHXjeY4O5cD3/vLpadfMEFw0BcS524olPGhHwXd2
 V+YORYVpnGu1qiocm8PW+u74PO7XMTnQnAPbTrSLXGnxNnq5xFDSqciWlM/u3zzfAs18
 FSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757819; x=1725362619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hs3oTf88fWF9dCWzDoBrmDVG+Xb2xIfD60tPGPs50rg=;
 b=qz6FInvCmgQOW+CpcfMsfwmFYu9SdVFTsaiOPWUZoaAdeF5sLh7rT//6qKr1i81TmG
 +0X4cwFbk1sSxPEpqmFmggJHZjaHuOlIVCqqM8LNyWIeb0NPMrw+kJ+qPhnwla9zjftb
 HooA57lEPxEYeT/y0R0DOYrbYxn+SghwFEh4FJc6DiEJqluJ8jaUdf1RZTT1eeaklir3
 FBDyVaG5uKnL+CVNxhTQF/E7Vi5nHHdcA8hh39v705WiUxD+NEVjwHGqUH0+SAyr7t7n
 aqeWlt68rY8OEC8TVFWNzRoOog5or0LAD6d3C+LopCgAKW9Ty3uYlH3ZM0Lz+KzyqJ9y
 FqxA==
X-Gm-Message-State: AOJu0YyMLnFCWR+hQVUA8GtsVul5T4+bjRD0Ldy/ZF1kH9TuLrV1oNwc
 VinpSPnnuTh85p5dfOJ6vYKk62zf8MM9R7uDdLELveA60b7C8S+8nG4gt0Lhd3o=
X-Google-Smtp-Source: AGHT+IFkQFUpZCif8s5EjZ8m5npPhQ0qwA7rVtreOWfQ61ewY2pW+TfVt5h70n7i7m+AQNaP3o/qCw==
X-Received: by 2002:a17:907:6d21:b0:a86:beb2:1d6d with SMTP id
 a640c23a62f3a-a86e2aa88fdmr262648366b.26.1724757818507; 
 Tue, 27 Aug 2024 04:23:38 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:37 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:10 +0300
Subject: [PATCH v9 1/9] Require meson version 1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-1-e90b9c28f861@linaro.org>
References: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
In-Reply-To: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=976yLnV0JBZ+zRQNoPMo1zso0NnZiUTggQc9JMhWW0A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMwTm1jQk44Nmd5RFRnTTFid1hYY0wwR0FYCjFPVWhXZjB2cjhWbldKNlFB
 NkNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05BQUt
 DUkIzS2Nkd2YzNEowRCtiRUFDWVNVSm9MSS9rRldOcGw3OVRKeXU1TXQ3cWkxbVBUOHFJclpVbg
 pmV2pERkJrSUJPT0Rua2ZRcDU5MlFIN01tY1R2bXVmc2VkNllFY1pUYjBUcjhHYkd3YnVrTGYrZ
 EJSdHdnMk5aCmEzVVRVTXgrcVp5TXdVTWpVcStHSXV2ZjZLS0s0L0dWUVNZUG1ZYkhrSUMycUwv
 WWl0SVRVRUk5YmVoM09YYngKRm5SeUtYVElFdFZqZjRscUd5dkJndFdiSndHR0xveEl0Umd2MFB
 wQ0prRGgraDdSQ0ZrRHJUczJLcGw5S05Wego3a05XV2RrUm9QbFB1UUJNaWJ2dldDSUV0MFNqaE
 1VL2thUFp5SGZEV2N2dk12ekpIRXptdDk2ZFdIUG9BaHpuClZ1RjhtbG9GMUdabXUzandvOFdnR
 FUzL1F6eDUrTEtQTDBhaE5jdTE0bDZnRlBMRnBDbnB4dGtKZWxMeUluQTgKOHl3Qk9yYVZzNGhJ
 Q211c0xhL1Rtb1FQSFZZbTc3ZU1wQjByMWVFOEtPN2hoQ1NOZlFnRWdEekZVZko0T0c3Qgp4Wm8
 3c0phTDN4YTJtWEZTUTNFTmg4NS95eVZOZXpYOGVOVFQ5YnF4dVJ2UG4xRFFwMnA1NUx3RkJPUE
 50eHErClNCZnRuaDNJcUdZWGRSSHp2bUhlcWpzWFdYMHdwV3VwNHRITXlCcTFKY0FVSkdzd09jT
 XFlc1VaeU5LU3lRbEkKV3pwa2VxNVZNeDV4N3ZsOTFBNFV4TTRLdjEyTEQ1dUFOMnBQKzBkWlpy
 K1l2MStNWE9seVdIYStTcjJxdnFrWAowWm9paU9xeURCdUhnKzVKN2NFNXRTSUpmR0h1Zmd3ay9
 aY0ZKbExmWmlHVUlSTFkzWDkzNzNuWXRsUENDVlNCCmZ0OHBPQT09Cj1lOHMxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is needed for Rust support.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                                |   2 +-
 python/scripts/vendor.py                   |   4 ++--
 python/wheels/meson-1.2.3-py3-none-any.whl | Bin 964928 -> 0 bytes
 python/wheels/meson-1.5.0-py3-none-any.whl | Bin 0 -> 959846 bytes
 pythondeps.toml                            |   2 +-
 tests/lcitool/mappings.yml                 |   2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 81ecd4bae7..7eb4b8a41c 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.1.0',
+project('qemu', ['c'], meson_version: '>=1.5.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 07aff97cca..0405e910b4 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==1.2.3":
-        "4533a43c34548edd1f63a276a42690fce15bde9409bcf20c4b8fa3d7e4d7cac1",
+        "meson==1.5.0":
+        "52b34f4903b882df52ad0d533146d4b992c018ea77399f825579737672ae7b20",
     }
 
     vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
diff --git a/python/wheels/meson-1.2.3-py3-none-any.whl b/python/wheels/meson-1.2.3-py3-none-any.whl
deleted file mode 100644
index a8b84e5f11..0000000000
Binary files a/python/wheels/meson-1.2.3-py3-none-any.whl and /dev/null differ
diff --git a/python/wheels/meson-1.5.0-py3-none-any.whl b/python/wheels/meson-1.5.0-py3-none-any.whl
new file mode 100644
index 0000000000..c7edeb37ad
Binary files /dev/null and b/python/wheels/meson-1.5.0-py3-none-any.whl differ
diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd8..a1c6ca9662 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
+meson = { accepted = ">=1.5.0", installed = "1.5.0", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 03b974ad02..9721016e0d 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -63,7 +63,7 @@ mappings:
 pypi_mappings:
   # Request more recent version
   meson:
-    default: meson==0.63.2
+    default: meson==1.5.0
 
   # Drop packages that need devel headers
   python3-numpy:

-- 
2.45.2


