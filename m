Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4300C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPbZj-00043o-O4; Fri, 05 Jul 2024 01:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPbZh-00043B-PY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:33:37 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPbZf-0002Zt-RU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720157616; x=1751693616;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5Ez9qTFqxtPGHfn12yOLp9B7F/ZvkkC871Gvj4GqQtQ=;
 b=OXe1MTSgWr36HUqZ3SJMdXZJDLsi/h/rmCGHbGdwI4W/2VvjoKxpNENu
 Yx3Vl9jRZHkYAMf/Ycwvua5MLPUZmg9n++tBQlSGJ4v23tBzjnwFFj/K3
 c9nFBwRvhJimuvA9Q1OkU9Q4Z23gNouF9u2X1o2qkreFvUKGhqj2HJSVY
 DuV2cdtzHvOEjK7ZWGyWtK+1TpztmPs7/ENh938JOUU5ofD6ggXUGwPTz
 i6SQ+mDQ8ZFsUVE6wI37NPDFHkebIioEfdHypp+1iAiORU+tdWLG75Lnz
 RwhqIqke+Qn6nnm/oWWr7HxtaT5onfMLQ942GBDF7FFYPqge1iL6XHMqa Q==;
X-CSE-ConnectionGUID: zH5jcjxPQJSqXmdyqCP0oQ==
X-CSE-MsgGUID: 9df7vILzQFe2UOabq7wh8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28831667"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="28831667"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 22:33:31 -0700
X-CSE-ConnectionGUID: M0cNfvk9QI6ITAnqQcxA5g==
X-CSE-MsgGUID: N58HUIl/Q5CGURDGwA3p2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; d="scan'208";a="46709607"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 04 Jul 2024 22:33:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] meson: Update meson-buildoptions.sh
Date: Fri,  5 Jul 2024 13:49:03 +0800
Message-Id: <20240705054903.2100562-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update meson-buildoptions.sh to stay in sync with meson_options.txt.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/meson-buildoptions.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index cfadb5ea86af..c97079a38c9e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -83,7 +83,7 @@ meson_options_help() {
   printf "%s\n" '                           (can be empty) [qemu]'
   printf "%s\n" '  --with-trace-file=VALUE  Trace file prefix for simple backend [trace]'
   printf "%s\n" '  --x86-version=CHOICE     tweak required x86_64 architecture version beyond'
-  printf "%s\n" '                           compiler default [1] (choices: 0/1/2/3)'
+  printf "%s\n" '                           compiler default [1] (choices: 0/1/2/3/4)'
   printf "%s\n" ''
   printf "%s\n" 'Optional features, enabled with --enable-FEATURE and'
   printf "%s\n" 'disabled with --disable-FEATURE, default is enabled if available'
@@ -166,6 +166,7 @@ meson_options_help() {
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
+  printf "%s\n" '  qpl             Query Processing Library support'
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
@@ -187,6 +188,7 @@ meson_options_help() {
   printf "%s\n" '  tools           build support utilities that come with QEMU'
   printf "%s\n" '  tpm             TPM support'
   printf "%s\n" '  u2f             U2F emulation support'
+  printf "%s\n" '  uadk            UADK Library support'
   printf "%s\n" '  usb-redir       libusbredir support'
   printf "%s\n" '  vde             vde network backend support'
   printf "%s\n" '  vdi             vdi image format support'
@@ -221,8 +223,6 @@ meson_options_help() {
   printf "%s\n" '                  Xen PCI passthrough support'
   printf "%s\n" '  xkbcommon       xkbcommon support'
   printf "%s\n" '  zstd            zstd compression support'
-  printf "%s\n" '  qpl             Query Processing Library support'
-  printf "%s\n" '  uadk            UADK Library support'
 }
 _meson_option_parse() {
   case $1 in
@@ -440,6 +440,8 @@ _meson_option_parse() {
     --disable-qga-vss) printf "%s" -Dqga_vss=disabled ;;
     --enable-qom-cast-debug) printf "%s" -Dqom_cast_debug=true ;;
     --disable-qom-cast-debug) printf "%s" -Dqom_cast_debug=false ;;
+    --enable-qpl) printf "%s" -Dqpl=enabled ;;
+    --disable-qpl) printf "%s" -Dqpl=disabled ;;
     --enable-rbd) printf "%s" -Drbd=enabled ;;
     --disable-rbd) printf "%s" -Drbd=disabled ;;
     --enable-rdma) printf "%s" -Drdma=enabled ;;
@@ -501,6 +503,8 @@ _meson_option_parse() {
     --disable-tsan) printf "%s" -Dtsan=false ;;
     --enable-u2f) printf "%s" -Du2f=enabled ;;
     --disable-u2f) printf "%s" -Du2f=disabled ;;
+    --enable-uadk) printf "%s" -Duadk=enabled ;;
+    --disable-uadk) printf "%s" -Duadk=disabled ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
     --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
     --enable-vde) printf "%s" -Dvde=enabled ;;
@@ -560,10 +564,6 @@ _meson_option_parse() {
     --disable-xkbcommon) printf "%s" -Dxkbcommon=disabled ;;
     --enable-zstd) printf "%s" -Dzstd=enabled ;;
     --disable-zstd) printf "%s" -Dzstd=disabled ;;
-    --enable-qpl) printf "%s" -Dqpl=enabled ;;
-    --disable-qpl) printf "%s" -Dqpl=disabled ;;
-    --enable-uadk) printf "%s" -Duadk=enabled ;;
-    --disable-uadk) printf "%s" -Duadk=disabled ;;
     *) return 1 ;;
   esac
 }
-- 
2.34.1


