Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C4EEC01A5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ax4-0003mh-JN; Mon, 23 Mar 2026 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1w4ax2-0003mL-DB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:47:56 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1w4awz-0002Kv-Jc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:47:55 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 3FB73EC010A;
 Mon, 23 Mar 2026 04:47:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 04:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1774255671; x=1774342071; bh=otcQ2Ali03w+PA52KvfAg
 +GxSS4w4PK0XGhlil6m5bo=; b=fJXo9twIP0XBoO78ySQQcJ/d4hcoNgHw6UxLX
 VSH1msZLVkSz75CikNsynLx7tqPJ3yk1w6o0IeA+MDSm9ez5a5vAnT/vOJoA93bb
 V0MCT2UYwqVTI6P/8/Twm9zygLhjibTYhpSTfT5lpHS6OtNNInxhqB6dvcdH1wDG
 3mDZijJ135uav9GDy6ZsunXI28/YW0udfKT99QNRiyuhHF1rM7mje4K3ELS4HKaQ
 GV+sF1ZUtjjouu1WHcErv6Hx5x7d+Jes3akU3Wnq+B9OlUSTHDLKf5bjg8KBNFL/
 10v7fYwD6thL6auxVc+a0kpPYgBL1oDIyRNthGoNIyKffbGFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1774255671; x=1774342071; bh=otcQ2Ali03w+PA52KvfAg+GxSS4w4PK0XGh
 lil6m5bo=; b=Imepn+vwOP4hcylNDifIpcHBgiiZOHDHhWF6mB41+tVogTYsO0F
 QQOeF8GMeReoUx3l801TBWXQTGfeGsryln/pyARsFF71zC9cbgO5DY6SyXF93mm5
 rgl6qv+nvr9tyD26I5D6Ksq0wB0OS86RUEhc92+kEH0pzVJhbPoeHW6XvAPMMfkS
 6AlhjmvS48kfZUuKOmQiiL4dg+ns0RLJTy0Dgpx+Ftfw8NiJOwrJzw7hFnHSZtfz
 4OfO/QVcqPkEwt/6AVrYCb5scdIjQqnEZRlCc3TYqdb8TQpXcwc7HCASSRkTqPJ4
 GG2I1AxGvaevoox4s5nnV9eHpUZza7m25BQ==
X-ME-Sender: <xms:Nv7AaQLQe6ojdudYXBp_wGh6UsdLIsHhcr89_Z7xnC1fw64DrZxQNw>
 <xme:Nv7AaQTeAlyR5cnqV21v_S0ivlEvH7sWJeFgxHjB2YsscE7FtdDUnvp4cYkEDvDkt
 UFsxX-sMZwjUjw7tTnAKjTT5bCvdkNBzwPO3D1-paS14nOyGvAx>
X-ME-Received: <xmr:Nv7AaYopM1IFewkHT1kGflbWmk81J7ccyzWjSom8i7Cl9zydvoobBmkQ40GYzvLFkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekvdejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucft
 ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepheekgfdtve
 ettdekuddugeeugfdujeehuefgleegtedthfffudfhheduhfduuefhnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrih
 hspdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehp
 hhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlse
 hnohhnghhnuhdrohhrghdprhgtphhtthhopehthhdrhhhuthhhodhqvghmuhesphhoshht
 vghordgvuhdprhgtphhtthhopegsvghrrhgrnhhgvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:Nv7AaVpsgVFV54Vs3m7hA9ZtY0_nipeTh2cRqK4pj05umYwMzu0qXQ>
 <xmx:Nv7AaSMMVli6vvBc8aPNosURC14I-FTjWFlCjY544E24DU9qDzilgQ>
 <xmx:Nv7Aaeyq7k7omX_c0McZClzg6xYfkHTkJQSSub9CpQzAcP3INFAE9Q>
 <xmx:Nv7AaTsEAPDhvyl7HCLy4UfE9B8izZLNFjnxldTMEkaKgrMLLN7USQ>
 <xmx:N_7AaQcX3TrX-iZK2LlRxPREiNNkL5a1KJ5JgKh9HL-OUksSbG4KeRLb>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 04:47:50 -0400 (EDT)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
 id A908688CD104; Mon, 23 Mar 2026 09:47:47 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] tests/functional: preserve PYTHONPATH entries
Date: Mon, 23 Mar 2026 09:47:39 +0100
Message-ID: <20260323084739.1013748-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=hi@alyssa.is;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Otherwise, it's not possible to use a packaged qemu.qmp.

Fixes: 1497377857 ("tests/functional: Prepare the meson build system for the functional tests")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 tests/functional/meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9bec5a0751..8c4d7f70e1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -76,8 +76,10 @@ foreach speed : ['quick', 'thorough']
     endif
     test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
     test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
-    test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                               meson.current_source_dir())
+    test_env.prepend('PYTHONPATH',
+                     meson.project_source_root() / 'python',
+                     meson.current_source_dir(),
+                     separator : ':')
 
     # Define the GDB environment variable if gdb is available.
     gdb = get_option('gdb')
@@ -96,8 +98,10 @@ foreach speed : ['quick', 'thorough']
       teststamp = testname + '.tstamp'
       test_precache_env = environment()
       test_precache_env.set('QEMU_TEST_PRECACHE', meson.current_build_dir() / teststamp)
-      test_precache_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
-                                          meson.current_source_dir())
+      test_precache_env.prepend('PYTHONPATH',
+                                meson.project_source_root() / 'python',
+                                meson.current_source_dir(),
+                                separator : ':')
       precache = custom_target('func-precache-' + testname,
                                output: teststamp,
                                command: [python, testpath],

base-commit: 8e711856d7639cbffa51405f2cc2366e3d9e3a23
-- 
2.53.0


