Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7425C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYsU-0007qS-SE; Thu, 15 Aug 2024 07:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsT-0007le-C4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:49 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsR-0002Ce-Er
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:49 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f032cb782dso7543341fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722165; x=1724326965; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FzUpp6Fi1RnlgfSqrQ44A3uw7FwtxkcGzmQ+3Wqxx7k=;
 b=nTZZZJDED5ETg3Nr/jvJRvYWwKiu2TARhFCK5+WsVM9neGrff2k9V0bqfsYFK6lmRe
 9MMFHAkr303N+TFTN5b9e09nTtsOzGI0WD8vue+B/XPec2cN1+1IhXyKVrVDopIpR3xm
 XxNenF3wjyjhXEIxvnXaYqSFCgsr6ZfnEacF1vOHyWqqtFXBBgec2S+/SR7fko5FmaM2
 4pmqoOzaeFU/4N+HSvdvAh2Jn1jHUbPSKPEoE844PT7Lam5G+JFCPsmGT1fjZygZnfX/
 3s5WjP0dTXmWJif+R3Xl/vS6udAyKpJiT4sQQBVth4qRB5vEAcQlF1EiKyQHSfk1ideh
 psZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722165; x=1724326965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzUpp6Fi1RnlgfSqrQ44A3uw7FwtxkcGzmQ+3Wqxx7k=;
 b=iedEWtorgxtg9k0NscI0beQqFux/8d1oU0vBAbwwBMiOYUPHEr7Oq2Q33xa8MyJzQU
 C4Om8k8MMOsSb1WwPC1GksQW4dKKUEN21rgHdp01zYjOgu1/LUKiZ/LDeUnREHf/HEzg
 7BXOpFlUTDYCMxjZ5X3GO1/VIbdUcCoLN39JkivVyR54MVGuG1TJGgIiufYLXAHxgs3q
 qOZiotiuHBs7V6S5u8xPwXKQ55mOGvv3wE/ixkvqXl2MYLUUoAXN++Hgp07Q3O7h5RxX
 IE62oGjx6g0SO/RRE/gZ8r5Vbrp83+6YsNmZiOhBAfcFikh+VxqgVj4WH17hlCgBfA/0
 us0A==
X-Gm-Message-State: AOJu0YwJNWu7DS1P/SWO80eCRlMGbeWFV7MjEbiNsXOEJedJiVV+VRno
 umZz+0wk2G0S6zc6FVzzCQraOuTW/zjCyJG/IWlMmK+XLNmc11Pg4Z2zDztPd3s=
X-Google-Smtp-Source: AGHT+IGeI9y+BQkOMLUrhP3hqn9MlEkhUq6NtXKkVTFziFoiDwgVV/9XdapMuZUsyaKpIJ8gqR405w==
X-Received: by 2002:a05:6512:3195:b0:530:aba8:d37a with SMTP id
 2adb3069b0e04-532edbae1d3mr3360658e87.37.1723722165225; 
 Thu, 15 Aug 2024 04:42:45 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:44 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Aug 2024 14:42:18 +0300
Subject: [PATCH v7 1/7] Require meson version 1.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-rust-pl011-v7-1-975135e98831@linaro.org>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=gbp6ZWDM9aBE3sP/4abftjNYYPlmCRvIHyPSrr8nbBM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW10MnhDa2VOc0NZVG83UnhXd05Ud0EzRXNlCkx1MGw0RStaTlpMai9uY1Nh
 d1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJRQUt
 DUkIzS2Nkd2YzNEowTkttRC80N2h3RGJrUGkzcm9uV3U0dXEvaVJEdUQ4ZG9scjZIc25KT2tlOQ
 o3d3doNjlQakZxMFM0VUw5ZVhDNXZJdTZ4ZlFKVlhwcXlRbU01NjA5alFuSEFobmxBTUFyWFNXe
 WljelNQS3dWCjB1RjA5MTNHMXVCTTBPWWI2c0hqbnFCYXVWbE9QNkcyZlVoVi9BdjF4VnM1MVda
 VWw2U2U1N29PY3k1Sjh0S0cKVXczbFJxWmdWNHNaSWFtTEpERWx6bTd1TWpINWN3ZG5SZmRBTi9
 PTGtIc3pMNjA2ZkxkKysyd3pBRGxzRUgvdQpRclVDdEdSTjNFQUFXUjhFREZZRFowSW1xcGdxbD
 d2OXVrcjZjbGZNclFQSFdrbHNIKy96Y3BrSldJQXM0RWJpCmx1WlNLSVEyYUR1MUk0NGQ2S3N3Q
 1llclAreDh0ZE1UTGdaVThqbzEwdmxoM3RzZ0ZaT0Q4Nm9MRDRFK3JTakoKVi96NklFcXlFc1Vq
 bXJuZGZtUjEzK0VoakcxRlMycU52UlAvVi9EZEFiVVFtSDkveUZYMEtjMEwzeDQ3R2c1cApNVE9
 GSVJtU0Ztb2h1elhMajJ1TlF3ZkRDdTdQbXcvYnRoVDBhQURGRlEvYXJ3TGRjdkxQM2t1WnE1T1
 UycWtDCk1oY1VydEZzMnYvRWxIZHNDdk45NGVURXpoRjZNK2tvSGk3TWo0WmhrbzZ3b3g4RE5oR
 GhZL0hjM0p6aWp0QU8KcVRSc2Q3aE82YlljcU1aUHFUMmNhRTdUMHBWN1RCeVhwcXF1QkZyN3kr
 NVUycnF5dEVDUUEraXQvaW96bGltRwozaVBtVGV4Ry8zb1B1a0RTcCtaT3RyR1pQWVNnTGRMVVU
 zTDFXTUp2aTlCdjVlUWN3WDczSzk1WU91MDc1OU54CkppRHI1dz09Cj1WdzU4Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
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
2.44.0


