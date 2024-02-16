Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489C5C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 18:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2i1-0005nY-Gn; Fri, 16 Feb 2024 13:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rb2hz-0005nN-Cu
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:13:11 -0500
Received: from fhigh6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rb2hu-0005sp-6S
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:13:11 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 0BD8E114009A;
 Fri, 16 Feb 2024 13:13:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 16 Feb 2024 13:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
 t=1708107182; x=1708193582; bh=g4Bx5J3rm7lI/qFnqCLX1FdEAQchH94E
 o1zzM1RjUvA=; b=Lq3SFxC2fHdJ1Foei8jEDhtM8RzZEEDS/JWygDKcl30cLssP
 FPMDUu054lKuQwJZ82o5eD4EDxFS+gyCrcpkL5BVfmWUBpbdqkdnBz4zVb6Kgntc
 UOgQVixF4E5raSkeD1oSTZMiA4m46pRaNBZibD68Gt/FMrALX47+83tiUP9F743q
 Y3VrxEMklf4bA5VraVVBh86waEO3pY9wryVHj2fFzm4o32NoTxDVeYqOa6Ze7N+w
 PSnuSoKFaiNeyF3wSVmdAXtRE9wnvENhk9xeIVKTXFIHhcq7UGhSKVv+5EJq3AoM
 8z3tmt2wO55OO8lmHAtZl5XHEtt6800bcB9hqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1708107182; x=1708193582; bh=g4Bx5J3rm7lI/
 qFnqCLX1FdEAQchH94Eo1zzM1RjUvA=; b=I6QZ5PnusRU/jQJW/RckB3gbDTWpi
 +OYBEy/9eJu29+M0ySdq/z7wCfd/byHs1nlO63+95NWLgcsVeUitKc9NDTQloAal
 Z/PGiRc2D8Aov/HeVidTDuYeymuO67171sQxN1A6zLjfdCp5/H+nIu47C/dQQy+P
 stPIzhM/ay6XsiNnSo6R7zjZuF2pWjqM+YxEH45qlHJs8C11+Aam4iQ+qjVJjBDR
 R3SlwTHPDsY/vrKzNjZI4ISicF+rzHblCTt+gIA+SOKE2itxlEmg13Syt3/uDfyD
 KOG7RA80PjzV7HLAJE6qTGwQNTlcoEpLqBVvkBSMtCkWnvwSXZn07CsOQ==
X-ME-Sender: <xms:raXPZVTDLgBdVaeDswNpHzwpLFhyxe7rBzIop6xVA-fXTdDrJO4cyQ>
 <xme:raXPZey-zEiBIPGkGC5BuiIl9JAqwdR58PpdQ4ag6oVT22TQXN95Yth5zAaQCo4fr
 2kEFlUdnCnjEw>
X-ME-Received: <xmr:raXPZa2qpZNjUxIs9tpOLSDa50ICnQOfkHSbaPOezlf3ZqAe6yamPqjj86krdRj9A7r5N57t1ayJfEhEcM8PSnwa4ysnLNayBM1EGZBIaprfOlCda-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
 ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
 hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelkefh
 udelteelleelteetveeffeetffekteetjeehlefggeekleeghefhtdehvdenucevlhhush
 htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
 ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:raXPZdCFQFfVup_o-HaD6Hp2uJtmQaf7Rtmuqh15s6HhV-vnEMXidg>
 <xmx:raXPZeidtRavR9hXCCS6pq3h-fCXUmzZd64Oc5ty5SgbCgYkBopPrA>
 <xmx:raXPZRpI-Rm-307G08vRv0FGMWDW84oz7o4i0eTjPG7dQLhyq-3l-A>
 <xmx:rqXPZWeqPOOBrk6FQq7voTCWBlUBkc23hz1bzk8HPBBw1u804J9-Iw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 13:13:00 -0500 (EST)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] configure: do not require gcc runtime library for firmwares
Date: Fri, 16 Feb 2024 19:12:17 +0100
Message-ID: <20240216181238.262772-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=103.168.172.157;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fhigh6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Keep requiring functional -lgcc in other places.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 configure | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index ff058d6c48..7721999f49 100755
--- a/configure
+++ b/configure
@@ -1216,7 +1216,7 @@ have_target() {
   return 1
 }
 
-# probe_target_compiler TARGET
+# probe_target_compiler TARGET [nostdlib-extra-ldflags]
 #
 # Look for a compiler for the given target, either native or cross.
 # Set variables target_* if a compiler is found, and container_cross_*
@@ -1226,6 +1226,9 @@ have_target() {
 #
 # If TARGET is a user-mode emulation target, also set build_static to
 # "y" if static linking is possible.
+# When testing -nostdlib build, -lgcc will be added for more extensive multilib
+# support test, but the -lgcc can be overriden with the second argument to the
+# function.
 #
 probe_target_compiler() {
   # reset all output variables
@@ -1243,6 +1246,7 @@ probe_target_compiler() {
   container_cross_strip=
 
   target_arch=${1%%-*}
+  nostdlib_ldflags=${2--lgcc}
   case $target_arch in
     aarch64) container_hosts="x86_64 aarch64" ;;
     alpha) container_hosts=x86_64 ;;
@@ -1432,7 +1436,7 @@ probe_target_compiler() {
     case $1 in
       *-softmmu)
         if do_compiler "$target_cc" $target_cflags -o $TMPO -c $TMPC &&
-          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" -lgcc; then
+          do_compiler "$target_cc" $target_cflags -r -nostdlib -o "${TMPDIR1}/${TMPB}2.o" "$TMPO" $nostdlib_ldflags; then
           got_cross_cc=yes
           break
         fi
@@ -1544,7 +1548,7 @@ echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 if have_target i386-softmmu x86_64-softmmu && \
         test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
         test "$host_os" != "haiku" && \
-        probe_target_compiler i386-softmmu; then
+        probe_target_compiler i386-softmmu ""; then
     subdirs="$subdirs pc-bios/optionrom"
     config_mak=pc-bios/optionrom/config.mak
     echo "# Automatically generated by configure - do not modify" > $config_mak
-- 
2.43.0


