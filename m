Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F185FE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHV-0003wI-HH; Thu, 26 Dec 2024 16:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHP-0003uW-1l
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:27 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHN-0003EE-Nw
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:26 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5D66B1140198;
 Thu, 26 Dec 2024 16:20:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 16:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248024;
 x=1735334424; bh=Wn81zmb/wOHLnmGIuhH/D0MryJOnpofku8vcL5IQi2Q=; b=
 b5VDN0YSe7pkrxrItX9alysjbnDdmoLdvSg4NBujDoP065dTUzyoB5avyEl/Dkn2
 7sAIBIZCM/J7EoNcdoYgLjD2wClBNcuahHEQLgEd5e60A2BcKQT3CzcogKhzpgwS
 5itLJ23/HWzXlThNeS/0OJ+XVs5xVhH3hTz7xjyfzvX29Srhl/ZnWPuYPvgoDipF
 7FW7c5OjkEr4tZt/L+n/T1zpBwtGLj7dLxE018ArVGF9/efN5GdbBjK25NHsod+U
 9y2m6jxgqagy7Q8iASzO6m9w8YaJRJnaqEgOeLxt2CAs1ztmBLL9HWfuK1Hc3xHa
 553XiwtfgZSqx+FaGfu96w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248024; x=
 1735334424; bh=Wn81zmb/wOHLnmGIuhH/D0MryJOnpofku8vcL5IQi2Q=; b=b
 jSeP1pC9id9WQ5Pi7fxa8h0mRFQTxNtEoY8HM4Mq7GSsbZPpb9VX0Q8782HtGksf
 S0qhmBAXvfOgL4YfcsocMV2HbaMSWY3fPwKH0CZmHOwXZQAPOL73TiY5H81XiwBs
 pizgFvtxGRUDqM9TgdIfbnQ5uikOvkySxDEDkd7ib76bam576ziy4UgFOvRBp6Ia
 D7sED0krHh4SLtWq1IvtV5uFaBVZw2GDV2ZJRldQtNZx4zPTIFiEYa/+rashBLtK
 gLpBguf/hpdWKzKGIrN7ecLSDC53FdZw7gdvoLNWlQjCAGHoGLMIOaL5twU1Vasl
 PCXDvTJni+edAFnDuTYIw==
X-ME-Sender: <xms:mMhtZ2TAnv98re70izgXOGGgdVH9RUKLgjehgC89Uo9c6bM4xpqP3g>
 <xme:mMhtZ7zel9OS3wZlmrTVdUx_u4v1B9neVPkiK7QF0DUduFtCT5qMS1LYZDvzADPPC
 pDD85gOBAHjg1WKXTQ>
X-ME-Received: <xmr:mMhtZz0Wd9698yzjnM2nvscbME_pp_-qA12dsh0eYJrxoLi-zEFC4H9K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeegne
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
X-ME-Proxy: <xmx:mMhtZyCyzmHiRWbsIBHMoU4Q5NeRH5AN77Wb8QwkFlGpRhZquMQEcQ>
 <xmx:mMhtZ_hbzopGMNLntX3abxa-DQk_8Ah3vaAOP64veADsxI1b0ibdzg>
 <xmx:mMhtZ-qUBNr4mNM6uMxHrNfDyDGMXp5iN7k9xOsPzWGRDx0eCicYTw>
 <xmx:mMhtZyg1E5h9YLXFYV_z7JzrdOcbRhzQFScX4MRpxwDuJiNU-2sEBg>
 <xmx:mMhtZ4bPFoCqcwY0yNsGlRgsHDHVXuJQvpoBmQWK9GzX2UEWdiZqIYQ3>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:22 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:51 +0000
Subject: [PATCH v2 20/23] hw/loongarch/virt: Default to max32 CPU for
 LoongArch 32 build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-20-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=FBUn2ePNQYQFLuMxPG6+QOkSyR+VuhIkJlorSkF3OU8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lPJ62MUTnKd+xXsJ1pb9dTsVn6Dezc8RE/74ZfL
 rHfI2XZUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABM5Xs/wPzdrY/1JSf1n+6Z9
 X/FJvKcwlyU0ZDYjo5j/mykBuz31Qxn+VxXnnpQN+VV5uKhlWmHg05Mi511PTalIu7XvedcJq2Y
 XNgA=
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

la464 CPU is not available on LoongArch32. Use max32 which makes
more sense here.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 3a905cf71d46e3c5a29672f7bb73faedf1d29444..343d2e745e155d59f0ff17124b3c77ec9b3c111e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1440,7 +1440,11 @@ static void virt_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->init = virt_init;
+#if defined(TARGET_LOONGARCH64)
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
+#elif defined(TARGET_LOONGARCH32)
+    mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("max32");
+#endif
     mc->default_ram_id = "loongarch.ram";
     mc->desc = "QEMU LoongArch Virtual Machine";
     mc->max_cpus = LOONGARCH_MAX_CPUS;

-- 
2.43.0


