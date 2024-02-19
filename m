Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA91BC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 19:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc931-0004Yn-Jq; Mon, 19 Feb 2024 14:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rc92p-0004Wr-JO
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 14:11:16 -0500
Received: from wfhigh6-smtp.messagingengine.com ([64.147.123.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rc92k-0007jA-VX
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 14:11:15 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2B52A1800071;
 Mon, 19 Feb 2024 14:11:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 19 Feb 2024 14:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1708369867; x=1708456267; bh=RxS+XGDuENg3h+qpE0HMYFyAzXU1uK69
 HiERXeO7PvQ=; b=1FIB88x/eTYPQ2/DZmDaRTXxfbgq35+nslGRXHrwgeHHLKbx
 j1+mt0Jvh8CA6B7YqGyKCyT/coWtQrrBKC9Ap8l2mfqsWLeLhitE8fDmquL3kdcB
 LUsoUAi9vl5JWTjSzET53UvKZZRytffk4G8vIz7uC8vTYApiFiDNPwAdwWVvxQZ0
 GCELbptihwl4MZ4ZHl6aC4B9gfNhs1R11kjUUSbBeOFBME4zJSYlHiYCDc/QQrID
 CFVcS4oGgVDF7TUDy6tUvWFBSXWkj0hg3ZHhCYm4pnDmgq4OcFSBo4gbxq0d9alB
 U1AnXUO5OEjxUhJ+2+uTbR9x0rlsfEBtVwfylQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1708369867; x=1708456267; bh=RxS+XGDuENg3h
 +qpE0HMYFyAzXU1uK69HiERXeO7PvQ=; b=Fp16qgmjeRi05m+9RhCs4jgaoe/m8
 /0W1DdkToXSG6QcfjKD2Mq+WADqvBEcVK/htdZ8Wl8gekxm89MfhokXdyTI3r4nM
 yOMmCctLZ47mEbEaxWMZWwAdLf/i2pkZLhbU4bPLGoBA6pVaypkduCIDgQscBeyc
 kRO9y7hMXuaxS66T6k1vGaw/atc1DPPJQ+XvIqEY1eilh+a1Al+mkjStQfHeZLJF
 kv7lfGf4HQ7kDQwHDdlK2mwOTEdWrglPbVkmQG0vFQ0EcmyUfOGhMm9i+Vy/BdRE
 6FzcaAmxXY46FTBLyKVBLZUpfVN8bXb8z+V+PgsOYi7NaEih+DTVPsuGg==
X-ME-Sender: <xms:y6fTZf-22fv6UmBOTLZ9Lxgu5b-kKCWQ2KoN-ylRFdGnT0aKwTMlcw>
 <xme:y6fTZbsgJvP_nsBdm7-CfKxH3HXvjFxONRcUshg9qaLsIwXMtPlWG1Xc2lNQFBKSa
 ypLkJAApv3FhQ>
X-ME-Received: <xmr:y6fTZdBJaBbfj5iVjItLy45kOkqt0G7QP7dwsf14tytWTMhKRjifOIEd4Jn-OMlbimmXrtm80xRwxwiuw3lAT7ODD4a2j5dSjvgtrca43Q-_SXuG0cM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelkefh
 udelteelleelteetveeffeetffekteetjeehlefggeekleeghefhtdehvdenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
 ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:y6fTZbe5W-3nO1c124YuyxgB6NSayVcQDOWWzXgS9u5IBRS1Vr2xZg>
 <xmx:y6fTZUNB4Jtwb_QpwEGts__pK5DMdPesTcg7SOITyzMN4VAjxB69GA>
 <xmx:y6fTZdmXyJ3B3M2ereg0INRG0hp_JoOn9VZorkaBqGmed5cfZiXeHg>
 <xmx:y6fTZRqQcYOpSDrwYJSdhjz3d1tZT3JP6C7QYKoUlUxHhU3GpXec3-h602k>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 14:11:06 -0500 (EST)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] configure: do not require gcc runtime library for firmwares
Date: Mon, 19 Feb 2024 20:10:29 +0100
Message-ID: <20240219191054.283154-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.157;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfhigh6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

probe_target_compiler() when checking for multilib support checks if
-nostdlib works together with -lgcc. It isn't necessary for building
various components in pc-bios/optionrom, as evidenced by looking at
actually used link flags there.
Alpine Linux for x86_64 does not ship with 32bit libgcc, but its gcc is
otherwise perfectly capable of building firmwares in pc-bios/optionrom
dir. Make configure recognize this situation.

Keep requiring functional -lgcc in other places. Few more may not need
it, but I don't have an easy way to test.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
Changes in v2:
- use an option instead of positional parameter
- add explicit -lgcc where it may be relevant, instead of having -lgcc
  as default
---
 configure | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index ff058d6c48..3e92685221 100755
--- a/configure
+++ b/configure
@@ -1216,7 +1216,7 @@ have_target() {
   return 1
 }
 
-# probe_target_compiler TARGET
+# probe_target_compiler [-nostdlib-ldflags=...] TARGET
 #
 # Look for a compiler for the given target, either native or cross.
 # Set variables target_* if a compiler is found, and container_cross_*
@@ -1226,6 +1226,9 @@ have_target() {
 #
 # If TARGET is a user-mode emulation target, also set build_static to
 # "y" if static linking is possible.
+# When testing -nostdlib build, extra ldflags can be supplied with
+# -nostdlib-ldflags option, useful to add -lgcc will be added for more
+# extensive multilib support test
 #
 probe_target_compiler() {
   # reset all output variables
@@ -1241,7 +1244,11 @@ probe_target_compiler() {
   container_cross_objcopy=
   container_cross_ranlib=
   container_cross_strip=
+  nostdlib_ldflags=
 
+  case "$1" in
+    -nostdlib-ldflags=*) nostdlib_ldflags="${1#*=}"; shift;;
+  esac
   target_arch=${1%%-*}
   case $target_arch in
     aarch64) container_hosts="x86_64 aarch64" ;;
@@ -1432,7 +1439,7 @@ probe_target_compiler() {
     case $1 in
       *-softmmu)
         if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
-          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
+          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" $nostdlib_ldflags; then
           got_cross_cc=yes
           break
         fi
@@ -1553,7 +1560,7 @@ if have_target i386-softmmu x86_64-softmmu && \
 fi
 
 if have_target ppc-softmmu ppc64-softmmu && \
-        probe_target_compiler ppc-softmmu; then
+        probe_target_compiler -nostdlib-ldflags=-lgcc ppc-softmmu; then
     subdirs="$subdirs pc-bios/vof"
     config_mak=pc-bios/vof/config.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
@@ -1563,7 +1570,7 @@ fi
 
 # Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
 # (which is the lowest architecture level that Clang supports)
-if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
+if have_target s390x-softmmu && probe_target_compiler -nostdlib-ldflags=-lgcc s390x-softmmu && \
     GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
   write_c_skeleton
   do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
@@ -1666,7 +1673,7 @@ for target in $target_list; do
       ;;
   esac
 
-  if probe_target_compiler $target || test -n "$container_image"; then
+  if probe_target_compiler -nostdlib-ldflags=-lgcc $target || test -n "$container_image"; then
       test -n "$container_image" && build_static=y
       mkdir -p "tests/tcg/$target"
       config_target_mak=tests/tcg/$target/config-target.mak
-- 
2.43.0


