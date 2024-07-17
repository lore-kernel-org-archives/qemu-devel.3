Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206C1C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2XI-0003eO-Uf; Wed, 17 Jul 2024 07:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Vg-0003rR-6G; Wed, 17 Jul 2024 07:07:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Vb-0007Zn-W9; Wed, 17 Jul 2024 07:07:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D9FF07B382;
 Wed, 17 Jul 2024 14:06:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 419C610B297;
 Wed, 17 Jul 2024 14:06:41 +0300 (MSK)
Received: (nullmailer pid 844432 invoked by uid 1000);
 Wed, 17 Jul 2024 11:06:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 16/16] meson: Update meson-buildoptions.sh
Date: Wed, 17 Jul 2024 14:06:40 +0300
Message-Id: <20240717110640.844335-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717110640.844335-1-mjt@tls.msk.ru>
References: <20240717110640.844335-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhao Liu <zhao1.liu@intel.com>

Update meson-buildoptions.sh to stay in sync with meson_options.txt.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/meson-buildoptions.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index cfadb5ea86..c97079a38c 100644
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
2.39.2


