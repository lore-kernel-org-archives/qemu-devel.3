Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB76EC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 13:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl6gZ-0003hJ-QQ; Thu, 20 Feb 2025 08:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl6g3-0003cF-67
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tl6g1-000822-7W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 08:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740058395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ad54lpnjxvoljK6bbFtYkvpstO0cRMtfo3otsnkNusw=;
 b=VmJ9ORiRP6jE7iiVyZXxYkgos4ptSnc4jkwakkYf8iagiQfuEkeo2NKJjRrUnVHxsBtWv2
 OMQ59tbOfieW4x5tJs/dGtzU20Z1KZd/3Vr0Vtwb/udCjbBRZcAqiimBggaLXpTnkxAUx1
 jIdT3nwGQ1b0kkO/BNbwaEifU+krBp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272--qdjGoVnP9e95nHtMPNRVw-1; Thu, 20 Feb 2025 08:33:14 -0500
X-MC-Unique: -qdjGoVnP9e95nHtMPNRVw-1
X-Mimecast-MFC-AGG-ID: -qdjGoVnP9e95nHtMPNRVw_1740058393
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f44be93a8so470975f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 05:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740058393; x=1740663193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ad54lpnjxvoljK6bbFtYkvpstO0cRMtfo3otsnkNusw=;
 b=SEmZNS820lQJ8eUVO7eqF9iQ+xEDL3JZn5NA48rP4sjKGT2kq+21NL+gXE5867lT5G
 jv3qP5+JTuQSALvTfDgYBixsN8Ovlb5bFexygrnsJsDHK6YwjK13OD2o7NiO0ocBVMBI
 KvOUs4VVurWwoMuqlY36iimcpgaAomy4ebT3L2vmjbhqRUd4wWWbEVusMXMWzus32xM1
 q94TaJOyHNDYTBUntSsaTrFa0d8Gi2EvXniSNzrhDvif6+Gk1Yu4acunfDSwmt9hXuPQ
 DxVMNx+8/IaS+79WLdmcBM97DJJQwn/zPkonhvW/0iGyURchuiVEaTfEpqbUzneuwXsx
 IVzg==
X-Gm-Message-State: AOJu0YwCk6S4FYkJ2JBGhGwYj6g2j7W6yKCxiU/JczfV0MHA7+8UsI+B
 2VMVUTUH5LSVLWGgmAIB1pSOxkaLkViotZ+kqrJnC32Zu9SMFqT4LicXOWJ57OLTcfyGyEyXrfp
 Ain45xlVB32H2tB0V4gghUlNLRzSLp/1hh5peBry0scgDqypQ6Saq6rRee6dFvTXxYaaRXPI9AA
 d2hOvCnAbbwKLOG7nyfhYnxRWij93dGmixHga3YUc=
X-Gm-Gg: ASbGncv2cK66zrOFaF1XExlTKV+G2D9FR0r5G7fZNtrqyKvEkaqEqA70Ej5lMcie+FZ
 +tDfj3eh20GnBvosUjA1T21Wmd/r/ccr0sqJr2nVuNRuOoallWtM6CGdgOyHLd4dRFJghLB+2iG
 uy0sxr18LlUy8bXJ7ovhlwfpdrycYHM0MGj4GbF4P3LKya2dLbG/h+KqMX4hlQVmakkRG1+qImH
 wYCWyCclfPBRuuGj9P+I4NCridqf0qQ37wPmVc3cxjriSn5qSSWminDReH51uKIckH1IO/yzOS8
 4FzJAcW7+kY=
X-Received: by 2002:a5d:4403:0:b0:38f:24f4:93b9 with SMTP id
 ffacd0b85a97d-38f587974dfmr6195062f8f.28.1740058392804; 
 Thu, 20 Feb 2025 05:33:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwXijjdw72HWL8fprHbQLsrRPFdt8GmsLN8XwRmdHpDXM6C7hqlr9e0Xkb1i3qvBo/PLsQNg==
X-Received: by 2002:a5d:4403:0:b0:38f:24f4:93b9 with SMTP id
 ffacd0b85a97d-38f587974dfmr6195041f8f.28.1740058392438; 
 Thu, 20 Feb 2025 05:33:12 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd51sm20675503f8f.29.2025.02.20.05.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:33:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/2] pvg: add option to configure it out
Date: Thu, 20 Feb 2025 14:33:06 +0100
Message-ID: <20250220133306.1104382-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220133306.1104382-1-pbonzini@redhat.com>
References: <20250220133306.1104382-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

... and also to require it (--enable-pvg).  While at it, unify the dependency()
call for pvg and metal, which simplifies the logic a bit.

Note that all other Apple frameworks are either required or always-present,
therefore do not add them to the summary in the same way as PVG.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   |  8 +++++---
 hw/display/meson.build        |  4 ++--
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index ad2c6b61930..ad8e7c1890e 100644
--- a/meson.build
+++ b/meson.build
@@ -821,7 +821,6 @@ version_res = []
 coref = []
 iokit = []
 pvg = not_found
-metal = []
 emulator_link_args = []
 midl = not_found
 widl = not_found
@@ -843,8 +842,8 @@ elif host_os == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
   iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
   host_dsosuf = '.dylib'
-  pvg = dependency('appleframeworks', modules: 'ParavirtualizedGraphics')
-  metal = dependency('appleframeworks', modules: 'Metal')
+  pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
+                   required: get_option('pvg'))
 elif host_os == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -4846,6 +4847,9 @@ summary_info += {'libdw':             libdw}
 if host_os == 'freebsd'
   summary_info += {'libinotify-kqueue': inotify}
 endif
+if host_os == 'darwin'
+  summary_info += {'ParavirtualizedGraphics support': pvg}
+endif
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
diff --git a/hw/display/meson.build b/hw/display/meson.build
index b9bdf219103..9d82fbc9c89 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -62,8 +62,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
 if pvg.found()
-  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m'), pvg, metal])
-  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m'), pvg, metal])
+  system_ss.add(when: 'CONFIG_MAC_PVG_PCI',     if_true: [files('apple-gfx.m', 'apple-gfx-pci.m'), pvg])
+  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',    if_true: [files('apple-gfx.m', 'apple-gfx-mmio.m'), pvg])
 endif
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
diff --git a/meson_options.txt b/meson_options.txt
index 5eeaf3eee5c..59d973bca00 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -198,6 +198,8 @@ option('lzfse', type : 'feature', value : 'auto',
        description: 'lzfse support for DMG images')
 option('lzo', type : 'feature', value : 'auto',
        description: 'lzo compression support')
+option('pvg', type: 'feature', value: 'auto',
+       description: 'macOS paravirtualized graphics support')
 option('rbd', type : 'feature', value : 'auto',
        description: 'Ceph block device driver')
 option('opengl', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index a8066aab037..3e8e00852b2 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -168,6 +168,7 @@ meson_options_help() {
   printf "%s\n" '  pixman          pixman support'
   printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
+  printf "%s\n" '  pvg             macOS paravirtualized graphics support'
   printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
@@ -436,6 +437,8 @@ _meson_option_parse() {
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --prefix=*) quote_sh "-Dprefix=$2" ;;
+    --enable-pvg) printf "%s" -Dpvg=enabled ;;
+    --disable-pvg) printf "%s" -Dpvg=disabled ;;
     --enable-qatzip) printf "%s" -Dqatzip=enabled ;;
     --disable-qatzip) printf "%s" -Dqatzip=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
-- 
2.48.1


