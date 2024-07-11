Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5713EC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1in-0003wk-FQ; Thu, 11 Jul 2024 17:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1il-0003up-Jv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:52:59 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sS1if-0005Y0-BM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:52:59 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25982aa59efso596245fac.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720734771; x=1721339571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8KIXwkZXyq8Ux81YoTSAxOBE0pbfYwmygweH+SbG/w=;
 b=gGUjl4+leOeBis/ziVySpUV/SMGw4kcamfs6ux3toT5fWmjby0bFs7rNoZv8UQ85cq
 XkTDgdjctGtLSERcQhbuSICh7anplyUtvyYwNMjoQGJCpFdDhgB23UdDY27aLq1lybWr
 bMsyZHQEyUi+qhP6n/s1qxxoX+kn2PoIK+YJmm+LEGjrpKfyqodZ60N/WftAQAS3q+VP
 1XHMwBLZvwSALDL3w3FrdCnDOCEngZzsXxeumW1deCThzBr5b79Sg07Mcg+TTzz5dxy1
 tnJcDHivpZ+7lQcsgFafr2pJMnhy9BCcCU+sxqlzWnIKP5ve6vYNlGIJSIqQkj7oSafF
 65kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720734771; x=1721339571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8KIXwkZXyq8Ux81YoTSAxOBE0pbfYwmygweH+SbG/w=;
 b=PpMDdqcvs6omsFrmSVCMeKaPtklf2gfJuws0101XnSsLQHPlPzS73thNGih3C/6fdb
 uhW7STHLAwAcgfPaxHTH8q3JBJEm57ktVrwOKTtD8XmutfsxcPSrPpKNuW6ZWRt6jYDN
 RUacqnQ0IJpkXT4AFcF9KOmGJ1YcU9lzhZd4iNx7c4q6P2Y3qThV/EGbnQImzt2qukuo
 +Zk+X3K4MaTzRMhonbdgDEGkWPEF1XgWVW2+yEmUTwmdu0lrijykK7Zf6tiX8Hg7Vpf+
 lkExkdy4T5A+SwY8p6/FqW3L3Iskene4rJ0sQhj9UMfWOLfEnwJDChmXrUmUyNSi96bv
 1FCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgH5HO5h92LhNWR1wfE8I5+VqUZkoPoxofUL2w79pgVImYdsy97Z1BSMnOjA4dr/mOCB3gPuogII6LqdzpkaKeUMOVzjg=
X-Gm-Message-State: AOJu0Ywad6I7/7xX8MLvU/U+pM/DVKgYMbiF/ZBo44FZynsVoknsiP8m
 1qKntnMdjtQ7CjX1nZr3jsqS0kuywke0eDH5vm3UuL6oo1hOH1IiPNFG6mBEC7k=
X-Google-Smtp-Source: AGHT+IHXS4KqfD5dL20PDI1NMSzo5ZKEp2wXV7Vp30XmmPnRS57Fkyyq7shLr2biZJnSZliW0DjPiQ==
X-Received: by 2002:a05:6871:88d:b0:25e:bdf7:7e08 with SMTP id
 586e51a60fabf-25ebdf84150mr7104927fac.0.1720734771027; 
 Thu, 11 Jul 2024 14:52:51 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([208.184.112.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7044ac2876dsm713125a34.2.2024.07.11.14.52.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 14:52:50 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v5 01/13] meson: Introduce new instruction set enqcmd to the
 build system.
Date: Thu, 11 Jul 2024 14:52:36 -0700
Message-Id: <20240711215244.19237-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240711215244.19237-1-yichen.wang@bytedance.com>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hao Xiang <hao.xiang@linux.dev>

Enable instruction set enqcmd in build.

Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 meson.build                   | 14 ++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/meson.build b/meson.build
index 6a93da48e1..af650cfabf 100644
--- a/meson.build
+++ b/meson.build
@@ -2893,6 +2893,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
     int main(int argc, char *argv[]) { return bar(argv[0]); }
   '''), error_message: 'AVX512BW not available').allowed())
 
+config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd') \
+  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable ENQCMD') \
+  .require(cc.links('''
+    #include <stdint.h>
+    #include <cpuid.h>
+    #include <immintrin.h>
+    static int __attribute__((target("enqcmd"))) bar(void *a) {
+      uint64_t dst[8] = { 0 };
+      uint64_t src[8] = { 0 };
+      return _enqcmd(dst, src);
+    }
+    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
+  '''), error_message: 'ENQCMD not available').allowed())
+
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
     #include <arm_neon.h>
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..4ed820bb8d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -121,6 +121,8 @@ option('avx2', type: 'feature', value: 'auto',
        description: 'AVX2 optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
+option('enqcmd', type: 'feature', value: 'disabled',
+       description: 'ENQCMD optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index cfadb5ea86..280e117687 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -95,6 +95,7 @@ meson_options_help() {
   printf "%s\n" '  auth-pam        PAM access control'
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
+  printf "%s\n" '  enqcmd          ENQCMD optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -239,6 +240,8 @@ _meson_option_parse() {
     --disable-avx2) printf "%s" -Davx2=disabled ;;
     --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
+    --enable-enqcmd) printf "%s" -Denqcmd=enabled ;;
+    --disable-enqcmd) printf "%s" -Denqcmd=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
Yichen Wang


