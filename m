Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE39E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHE-0003oe-3g; Thu, 26 Dec 2024 16:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHB-0003o0-IJ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:14 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvH8-0003Bm-EP
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:11 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 002E5114018F;
 Thu, 26 Dec 2024 16:20:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 16:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248009;
 x=1735334409; bh=M3agoKfwtNZT3tIbqyd6WdpZVjvJbxjbx3xjLJb8/7U=; b=
 sDddRUi+GlrwEA0L4zkWs8slarPJjnPNe5/A1pzUtofWrtPeAnljOifMiH8b5+1Z
 rH4JY9O50U/glIkcX13VI8bwzuTAVo4fx9pIUy6E9tPz9vvUR6i4ts1JNyesqsOS
 cvcR4kZn7L7yhB91ttrbPVJQ7Mp8vpECn/lqh9Vq1JZ0GtO7+ifpM604iFhI0Z5k
 TnMNIvSoeorzzmof90PClSd68WdbGQzOhtob1njIfwHnlIcz/2/yzgaYI3crpeWc
 NpvjykGSoHwEtrA0W1Rg7GUvRT7ZMfhhF4Yt/4WHmGU7Lazn7R+IulHSsGfHMHoa
 dBctDiWUW4NEiU1aZy4zFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248009; x=
 1735334409; bh=M3agoKfwtNZT3tIbqyd6WdpZVjvJbxjbx3xjLJb8/7U=; b=i
 Av95beNJuvNlP3qQlcj0ACid2nsxTj1LmnQZ71nps851On5tdMOb6Z3liD46QW9k
 FMfCnKh7Wh61if7gTbIFzhlR+JcKZoITqVDobewmjCj/pxjPeRdsn3p07NqHf3yu
 zlQx3ZB7Dx4ZBapvjzGjfcgw9KTAfLJGnuQYUFtg/eRXeUmTNh1EQ4afNwfeJFnQ
 BFyeFPXSV64oZEGUvFZtu6ceyjhlBo1WzHLhqW/ZzU72yNopUMFyZkgqzE5/6pkE
 bkd1ND/SK4uDH7IevhAWhdxaL7mWS3MwMNploTSYeb6pRPvypUduGfBoESnNFsAN
 lkN4Mxf+eNmlDzy1tzMMg==
X-ME-Sender: <xms:ichtZ5RVUtL4EY6muG6UPoRQEQoEsuxaZsqq8vTCzQfJ7xBlH_zkEA>
 <xme:ichtZyyEVwqy2rg98JLBT2YkZjYq8qS5PTfEPulx2Cm4nwZCPs99mrRU4TfkmzCO4
 QT_dQDnafydHCLoiUE>
X-ME-Received: <xmr:ichtZ-0m8__dRPemBNvE6e45Efsy_ExMHg9tjDS59mVlBIdoOzxj1epZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedune
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
X-ME-Proxy: <xmx:ichtZxDt3xzRYxeqORTwpVFQpkNjRHeSdf6Y_PFNw7NA6mWLRyhRHQ>
 <xmx:ichtZygUWCHz-PP0XMKXG4a1KkLLziAqo1svps-rXjmieQORkry41Q>
 <xmx:ichtZ1ohYxqXY_xje_C5RygVODspaz06koMNV4DXeDe7JsqfktQB4Q>
 <xmx:ichtZ9igwYnF3XimqN2wEuDtM2y5-emvv-nqiJ3Lk6F4grWKKp-zXQ>
 <xmx:ichtZzaH9wVz-y_2Z9Nh0E8JzscfhvcQs0P8qqUaX9h1Xj0BCoEBjnLL>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:08 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:44 +0000
Subject: [PATCH v2 13/23] target/loongarch: Fix rdtimer on 32bit build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-13-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=e8KJe3ckOME7jpdGuarkSAXJviJf0h3QG8AzFQR7IKk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9k+/yJYt/Hnbg+bkzDDk8s37mytp+npaC/e8GmPO
 iT0Ojk6SlkYxLgYZMUUWUIElPo2NF5ccP1B1h+YOaxMIEMYuDgFYCIFvIwMC+zXJv09G/Ty8eSm
 vdlex66XP0l6r/NS/7Uxv+7Zqxuf7GVkuO7d9vO4bCVvTMiW3kkfOOfKaH74rX/8ekSLZ772FRk
 hPgA=
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

Use TCGv_i64 for intermediate values and perform truncation as necessary.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_extra.c.inc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index cfa361fecfa9ba569034b2c591b910ae7a3c6427..f9fb828ce51f2ee925edde7330d3054da534ecb3 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -46,13 +46,15 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
 {
     TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
+    TCGv_i64 val = tcg_temp_new_i64();
 
     translator_io_start(&ctx->base);
-    gen_helper_rdtime_d(dst1, tcg_env);
+    gen_helper_rdtime_d(val, tcg_env);
     if (word) {
-        tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
+        tcg_gen_sextract_i64(val, val, high ? 32 : 0, 32);
+        tcg_gen_trunc_i64_tl(dst1, val);
     }
-    tcg_gen_ld_i64(dst2, tcg_env, offsetof(CPULoongArchState, CSR_TID));
+    tcg_gen_ld_tl(dst2, tcg_env, offsetof(CPULoongArchState, CSR_TID));
 
     return true;
 }

-- 
2.43.0


