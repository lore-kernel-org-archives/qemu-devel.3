Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C900E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHb-0003z6-MN; Thu, 26 Dec 2024 16:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHT-0003w6-ME
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:32 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHS-0003Ey-A8
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:31 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C5BFF11401A0;
 Thu, 26 Dec 2024 16:20:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 26 Dec 2024 16:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248029;
 x=1735334429; bh=4SuT/ejVgzQsl7vXnic05xBWiNs6QkN+U6Fe72PfgOo=; b=
 YmOgBQwySScZRuCeFKLikTuAW28l3FYcl9zRiITN4ZiV9J92tp4t+M/q5PTWbJwQ
 aa7HywGPQEFdjmOI2Rx0atQ1uaXGL5Q1Qw73Ji0Q/IA9sbmNiVjv1bdzTPm64J89
 bbE5y1AX03o/USNQ1R4tzukjw0qOLjqJBRi3jH8PMnnpj4c0Mr7qHtZqcQBG5all
 UlNLvGXwcqlPQwgJDkXfVrPWkNU6ki80MECiMxi3nAPvou4MmrMgt2ooozneEPRx
 jIIpCWAff39uq5tGZ7JF5xY1YMlrEIL6ajXKOzyG5i+fQnCDarQusdwxn2V6IfWA
 WYFmzy5gp/7YKSvzzTghkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248029; x=
 1735334429; bh=4SuT/ejVgzQsl7vXnic05xBWiNs6QkN+U6Fe72PfgOo=; b=A
 fnm7p9RCxnpTaMRKsHG5cUOj9OABQRO46d1Pq+DMgneTI2EkQvUg82H4jQzV7dgJ
 XvYCjoj81rYguYrJw5freMeWEAYXHoCtHQZuVkIpkEfqGSEeiYfVwkMh4NdK71t2
 lW5TVon93MbarQkA0oBpvwqpR5R+ygZY57CEpC15YAR6AgsFw79T1EtF3yi2nlxW
 /5O9RrmYPa0zC2irk7aLVQV/koHfemBhZWHK1RdCDLyHR9X1qBJEWVgwakFF0mCD
 fXUkqpgBwb9BexogL1W54lAGMDjtjUOrXO1XEOOq5wb93Biweio4KScQslEH5uHR
 epkJ6xofHSwyLA4rGKhJg==
X-ME-Sender: <xms:nchtZ2ufr98xSu-z6c-lAl5fq2uzMatuBlOzI1NuejSJBI2w0IDiuQ>
 <xme:nchtZ7cemw8cAhVc0fz7kr1yIwCTef7WEsFPJuhGwZuqRSkANnDcHV8SP8eyep-mE
 0QMgTnURL88eVLoU9s>
X-ME-Received: <xmr:nchtZxzWuPyIv54u7zRsYspj8nsOT8Riy6A_WyDVzX3zlYK4UjrFiupz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehmrghrtggv
 lhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphhtthhopehpsghonhiiih
 hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhs
 ohhnrdgtnhdprhgtphhtthhopegvsghlrghkvgesrhgvughhrghtrdgtohhmpdhrtghpth
 htohepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehq
 vghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfigrnhhghigrnh
 grnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:nchtZxO-w5m6PDNlvvMBVbwcMIFVBM4Bk8ZfW3B7IkfB08c3ZIAvWg>
 <xmx:nchtZ2_E5EQ0zOjH6_IlLPADMPaXVDUwJTgv0Aj-SLXo2BnCv-f-Tw>
 <xmx:nchtZ5X5Hbe71V6FtY84OKrlVoM67Q6v6cGbO_i7TuQ2jJg5YedUhQ>
 <xmx:nchtZ_ez-KM57gv31_y6HK6ZQfUYM4H0zQfHI9xvnPk4nUPYA8ZJ-A>
 <xmx:nchtZxWgJWZNUX5oDT2nqmE1U_rUwSrQTiHff7_RSySR6KP4fypEMAeh>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:28 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:54 +0000
Subject: [PATCH v2 23/23] config: Add loongarch32-softmmu target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-23-0414594f8cb5@flygoat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
In-Reply-To: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JNYj8ZyURlcFCCdBmVClS5y27OylWlkDj1ACXlLsUCM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9kiE7qn9kq7/ArnzH/AfuSsblD/xOXPg8TPbfmvb
 h6qUjWvo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACay6TIjwzQrzk+zW98281pf
 t+USvDjr3H/X8DNfljL13w25HpEbFMTwk3HZWpbi3jNV7ZUfF0xZ5eIbYdWQ2l25J68l6VBmS9B
 LRgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a4-smtp.messagingengine.com
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

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS                                     | 4 ++--
 configs/devices/loongarch32-softmmu/default.mak | 7 +++++++
 configs/targets/loongarch32-softmmu.mak         | 7 +++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8839f22e3ed306a598da1e4ab2f9f1899f574275..0c45d28508015d448c0b8a46cdb83e3974da2e28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1210,8 +1210,8 @@ M: Bibo Mao <maobibo@loongson.cn>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: docs/system/loongarch/virt.rst
-F: configs/targets/loongarch64-softmmu.mak
-F: configs/devices/loongarch64-softmmu/default.mak
+F: configs/targets/loongarch*-softmmu.mak
+F: configs/devices/loongarch*-softmmu/default.mak
 F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
diff --git a/configs/devices/loongarch32-softmmu/default.mak b/configs/devices/loongarch32-softmmu/default.mak
new file mode 100644
index 0000000000000000000000000000000000000000..b28b5c7c9e2195cffe065716ee33ec2bf26e2b31
--- /dev/null
+++ b/configs/devices/loongarch32-softmmu/default.mak
@@ -0,0 +1,7 @@
+# Default configuration for loongarch32-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+# CONFIG_PCI_DEVICES=n
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_LOONGARCH_VIRT=n
diff --git a/configs/targets/loongarch32-softmmu.mak b/configs/targets/loongarch32-softmmu.mak
new file mode 100644
index 0000000000000000000000000000000000000000..50e0075a24ac6bf3717db967b03b816b52a25964
--- /dev/null
+++ b/configs/targets/loongarch32-softmmu.mak
@@ -0,0 +1,7 @@
+TARGET_ARCH=loongarch32
+TARGET_BASE_ARCH=loongarch
+TARGET_KVM_HAVE_GUEST_DEBUG=y
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
+# all boards require libfdt
+TARGET_NEED_FDT=y

-- 
2.43.0


