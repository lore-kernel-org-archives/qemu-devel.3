Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7EBE7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHM-0003qg-2H; Thu, 26 Dec 2024 16:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHK-0003q7-69
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:22 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHI-0003D9-95
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:21 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 984A713801E6;
 Thu, 26 Dec 2024 16:20:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 16:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248018;
 x=1735334418; bh=mK00rNU3uUZqwx6EGUl+GHsiUe4Y9J4gnVo/RMfXeas=; b=
 e7CIFt/WFYZ8Xsv8uD0xGVUkgGOGN0PzzObEmmFgT8i8rQWoHlsWzJsAnhIWmLoG
 61tk2IbkvBVHIjnlMTjqblOF9IeEnDOGk3plMjTo1hDUsbem3rG/N6gSW/twji06
 e8W5SIut2TTLQMqa3IH42BA9FWiop3dI5Z0he2IcGM8if4amCjZa6KmgkRAuw7iE
 LbWQMoPDWsqKPYO2GbAKgB5ADRavToGmNcIBfRivMAIoK9K4cT6jDCzLD3xif8+z
 6nid+9PYYWMsYSTIqiO0Kd3EFkTTdA1jzaqdPXFl36ya9zWURAb1MF4y6XX0h++0
 FacIz6UjR8wU9QO8dP4Fgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248018; x=
 1735334418; bh=mK00rNU3uUZqwx6EGUl+GHsiUe4Y9J4gnVo/RMfXeas=; b=G
 ffrSj1o2flVEwBoBB3GYJaXsjwKdMHBhM4vvw9v9m7vXzvLoBl9E6Q/AJLefN6a6
 Bq+DaBGqZilJIX4bbcMUrV5zyVqAOm+drET+3gMerh74sP3hnWAlG9D85Ty+MzNP
 KCfSs2FtSMis4EvWs+ZvXD4xOYj7oos0v2pL1gzo1r4hLHgbnhPFuddIwtDcwpcm
 7UZHRLIsj+OiV2VoCikXVolGdu9p3icJjWENPqJnta3XlMxQ3n7SWf5G/NmP+9VS
 WMw5DQHnhPMJu/bxRSKXMEy5jbjNdqQbU3VTq291rUdVjF9JLkbIX7SO7ILuKdZk
 npH3BEPSMorrHosSSaQ6Q==
X-ME-Sender: <xms:kshtZ5gtCxGRkLN9FvFNYp9V1RspFZXDYbHrW2DbGWA643_5OWLerg>
 <xme:kshtZ-AVz2x5dph-1rPXvfRv_tnMtoZnj8mhFBXf55hWZYqNaMrpj-RSeH3bjgw8L
 wuu0O_7ym1erZwMat8>
X-ME-Received: <xmr:kshtZ5Hos8NzpSHiHZHlwcrtJ0JVSCwygFjM-gPOQJR5nbpB3JJaMexG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpeefne
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
X-ME-Proxy: <xmx:kshtZ-S3G1_4Pyp5oiMtd65-ST-e2ZI6g5zAl2iDvhqM840Y-esCcQ>
 <xmx:kshtZ2zod-B7hXlNHb-bUSHhGLjHrGbAP0FL2loDSFNJMFweev7z2g>
 <xmx:kshtZ06aVbpfeAvkEXHPX2lZdqFsVOXJohOZRT7dOKCkagAz5xJkxg>
 <xmx:kshtZ7xYmpWquV61HA3DRVVk3C-6OwuhueazD88GAxfZZ6lpaxNq5g>
 <xmx:kshtZxoAvoyEKQw0Y4XNZaJdsHZauR_6KV5_LYCQVTrrg8ke0HV74OIK>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:16 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:48 +0000
Subject: [PATCH v2 17/23] target/loongarch: Refactoring is_la64/is_va32 for
 LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-17-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=3fvPVcmduevZWpvYs3fGnpSI9/FSXVdg+OVVSEa4VNs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9kiaxcssl2j3pvI5S5Xt/vlp+ALnKLt17z6TgdvT
 HFZeepaRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEwkV42RYfqpTSeErVf+sU6o
 ePg1kG35/k1FZ79Kn1FJYrEO7n1xegHDP62kK9vPOjbnHOnRWyPLvSI40Hr++61RF5xLtJXk1Na
 fZwMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a1-smtp.messagingengine.com
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

is_la64 should be wired to false on LA32 build.
VA32 CSR check shouldn't be performed in LA32 mode.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 4f542a3376831141d012f177dc46a0e928afc85c..a2d416b6634b7f6787c93eac2b777a2f6c71bebf 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -438,18 +438,26 @@ struct LoongArchCPUClass {
 
 static inline bool is_la64(CPULoongArchState *env)
 {
+#ifdef TARGET_LOONGARCH64
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
+#endif
+    return false;
 }
 
 static inline bool is_va32(CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
-    bool va32 = !is_la64(env);
-    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
-        va32 = true;
+    if (is_la64(env)) {
+        uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+
+        if (plv >= 1 &&
+            extract64(FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32), plv, 1)) {
+            return true;
+        }
+        return false;
     }
-    return va32;
+
+    return true;
 }
 
 static inline void set_pc(CPULoongArchState *env, uint64_t value)

-- 
2.43.0


