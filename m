Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9BAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1savIB-0002uu-6u; Mon, 05 Aug 2024 06:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1savHz-0002qv-Ua
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:50:09 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1savHw-00019v-S3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:50:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 0C1FE138FD78;
 Mon,  5 Aug 2024 06:49:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 05 Aug 2024 06:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1722854989; x=1722941389; bh=4RU+Dc1Cnp6lCR44m9Pzg
 Vxzi1qrBMsWqfFd5se/mTE=; b=F4tedkUzTv00PxumA+Kk0/rEjZkQPgzocSb9r
 Ilm5NJ8s1IfTF78DjMlmap/DHm9dmlOAOZnorJnlOJkUbMnql4y/C3MWrSbA1uVt
 odp+txx+kOJm9wFh3d8O0mgCbttOIr2+bctPPwi46utH130giyP7/axZ5vNdUbXZ
 KnF+uFMQiQHYzDYGinHIVsaBwsj20w789oohb6wEI3EdkUHgsu/UpkgP5SzUnVRY
 mdWINPocZl8iPlvKf3u57wv8jOLy1vZvUJ91O0d2Mtc6EXedB42R2gI8yQETJVPo
 d1rQ13Sz1Bc8YgjKePKG6YicVD3yP336lb1jmgu0zinQhaCQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1722854989; x=1722941389; bh=4RU+Dc1Cnp6lCR44m9PzgVxzi1qr
 BMsWqfFd5se/mTE=; b=F0YCP6EHVGZ5wA+Jx38ynWRQ1Pg1iLEXot0OQ07DygnE
 rwXjdK6p3OhtQ0pH0R6EkbL5qEwICME7xI+uGa3SX4IzBuy0+zuYNs/YEsLPAxaA
 J7BZxD4Cchr588XjOjJmbqSiXJqEr3F37/YNanoPCp67KgY03+kZBiYQbjug8VOR
 YEU6qxk95ldCD6VDIAM2jKZRWNNTxxIUsB+V39bTJPWeFOKcfeOMC343RfnIy0Jd
 zxDcSby+iUBCLunKNpNrqpV+6fxxXasVQ1puLcgZjJf4rT2rB1xP/nw3679o6mtF
 xA7m8WiBiVX0b2vx0v6TlWKuPMAXaE6UijnCloT5Jg==
X-ME-Sender: <xms:TK6wZol0hDJFy4Z36gg6lBUc0rFYXepY-qYJW_thMEMKuwvo0O2ynA>
 <xme:TK6wZn3QWgdkbDBDj5hAfmNE-TdRMZ1Gth9GaYDoDYUhnEpW8KL13KHM4IrB-dA3m
 bQT4cOnI40SGoMDyg>
X-ME-Received: <xmr:TK6wZmprl0mr0rKwKuLxZsqzTWO75zKu2sCi21SAK6Rsg7slqrntzGwFJh6Lg2y389Do8BhycRZqTXFnARrSCm5T_LQr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdefgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
 tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehkefgtd
 evtedtkeduudeguefgudejheeugfelgeettdfhffduhfehudfhudeuhfenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
 hishdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:TK6wZklklZaalUhBk593rJGUe1bPjOc9OgVXyvClBl1y8qumXl35SA>
 <xmx:TK6wZm0NRVOeXl6y0RtNmGmiQz7lMNo7bzGiKF0EqzMkm8VOxIxdCQ>
 <xmx:TK6wZrtB2eWdmC1j0R2XRiDhIxgZ_wLGKl5HaEhiBcPSaD7OouR6Dw>
 <xmx:TK6wZiWQkEN6SI0kCWoYGSGDWOSa8g26ZkTXzTOL4NVDL76AYBK4Cg>
 <xmx:Ta6wZkB7yf9FprZMzJs4vYuCWvCE6E0IGezyqt9o5K5_KQss8IYjuh1L>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 06:49:48 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id D34933ED9; Mon, 05 Aug 2024 12:49:46 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Brian Cain <bcain@quicinc.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/hexagon: don't look for static glib
Date: Mon,  5 Aug 2024 12:49:21 +0200
Message-ID: <20240805104921.4035256-1-hi@alyssa.is>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=hi@alyssa.is;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

When cross compiling QEMU configured with --static, I've been getting
configure errors like the following:

    Build-time dependency glib-2.0 found: NO

    ../target/hexagon/meson.build:303:15: ERROR: Dependency lookup for glib-2.0 with method 'pkgconfig' failed: Could not generate libs for glib-2.0:
    Package libpcre2-8 was not found in the pkg-config search path.
    Perhaps you should add the directory containing `libpcre2-8.pc'
    to the PKG_CONFIG_PATH environment variable
    Package 'libpcre2-8', required by 'glib-2.0', not found

This happens because --static sets the prefer_static Meson option, but
my build machine doesn't have a static libpcre2.  I don't think it
makes sense to insist that native dependencies are static, just
because I want the non-native QEMU binaries to be static.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 target/hexagon/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index b0b253aa6b..9ea1f4fc59 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -300,7 +300,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
     )
 
-    glib_dep = dependency('glib-2.0', native: true)
+    glib_dep = dependency('glib-2.0', native: true, static: false)
 
     idef_parser = executable(
         'idef-parser',

base-commit: f9851d2ffef59b3a7f39513469263ab3b019480f
-- 
2.45.2


