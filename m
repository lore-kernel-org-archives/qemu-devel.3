Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF74E7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGz-0003fu-5z; Thu, 26 Dec 2024 16:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGx-0003fW-NL
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:59 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGw-0002xa-Cm
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:59 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E5BB01140122;
 Thu, 26 Dec 2024 16:19:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 26 Dec 2024 16:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247997;
 x=1735334397; bh=zFX/R/2OBNMM/usy/SvwghUXl01SL+AnQBH94JO8ndM=; b=
 k4JwZQycTGhkh00mumnBFpmbw65DuoYf0v5KwNsvc4mk7kxoCOBwql0owQQ9u/T2
 z6QU9vzfS4WbiOHLToRQ+1EWg32eQNGJwwCGVEBS2YfWvZTafTxa70dXPnh/Uwu8
 bA3gtg/SeWYLEmvHaRcs5hLrIItUBg9eS6KcFGET+apohpNPE/jrXwtpp0t/CjFj
 71oZbgT7PVrfAIRcEJrw1AbVv2SH4tISEK9jdc4FTv5Fn8l3zBvwWL/m4Jz6SfIo
 lEy0BMqbQTfIlxJ0pccYYAQ4gGPD8Wlq41BW2h4HVJ8Q/Kg2cVSyJiBi1+YfYwKL
 YYKiF9Po2qZSRsBhBh9Ihg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247997; x=
 1735334397; bh=zFX/R/2OBNMM/usy/SvwghUXl01SL+AnQBH94JO8ndM=; b=x
 HEY4DpIO6O+UQPHBIWm2ZNfuRsVpaLK/0QLsjP5/UP4CxtcDWmI4fRWxja7LnkWk
 lWFxRVfcGnZxQjj2PZuray6SHZDMhlvlzMbGdqjmQOMnwCo6bvh3pr3mBM0jNpnz
 BI9BM5wfO+Xn+NX3w0QYkcxf692mFm60Ag+grwnylWchQI6wDtLtbje531obLfKu
 XaB1yEYnKSkZf7OpGq5xKlWgjrgpnvrsrhLTxwVxuZZz2RGL+u9j9wYCFeMyxcyd
 /60Tmv0IdRcsEnLj8zoLV6roAeY6XgIC2SGLydSUgjOlfb9UMYYO4hMnU+2EyTCi
 1NPFoVV1vqeW3QZdQ+tbA==
X-ME-Sender: <xms:fchtZzC8654PgM5N9W8JQcA29pDZ6za-RoOVVpsfXq-Ss1r3Ynw7Ag>
 <xme:fchtZ5hcqNkOISuGPFmDj1KsulC3Lui1GyZ1cSmskjz6Ogezr1Ok61tXblzJI9aDL
 CraMAY7cMrZcFSZcb4>
X-ME-Received: <xmr:fchtZ-lUYBPWCYxwjHRJiHRd2WHS-mN3VfW7i-Iur9faIr2LjttIv2_N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:fchtZ1zp_GV1YOV6yVXwI3BanRlLi-n0nzVv6rGTyzVUiSOLjaoTkg>
 <xmx:fchtZ4TIa8sTqa3NJaFtRL9TtSXyWodPAJNiIgH0YxezzCuFWOAo_Q>
 <xmx:fchtZ4aUoUVNEHGQ1Y0iMB7XOmF3sQ-6oc6ckKAx3kjLYEz9Gx5HGg>
 <xmx:fchtZ5QyYmP5WK6saQguH9wzQD5EuHvsjjhHqVLFTmwOLX-TJc6GQA>
 <xmx:fchtZ_L_DxIL2Y8JpKZsk6wba8MzL3_ZyWRY6ebsw77CfSD3ESnzvBhj>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:55 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:38 +0000
Subject: [PATCH v2 07/23] target/loongarch: Cast address to 64bit before
 DMW_64_VSEG shift
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-7-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=862;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=hDOvSXO+z0VzV0fEPlaxByL62UfL44EDg9vVWEzf4c4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lT5L0TLD/ON7P+l9AWx3JYP3FN6CGRyNuvK07f6
 PGxP9/SUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABMxPc3wT5kt+IAoo4wdw1cB
 kR+zsrZ/f5CedUdb4WSq0qG1foaHOhn+8H2O1vC/HsVz913znqv3NGRKvq18t0U7Jjmjm6HIrMS
 VBQA=
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

Avoid compiler warning on 32bit. This code path won't be taken anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 580362ac3e9ffbe6c8523cf57902dcda018ceed5..b8da136eb0554ba661a15e3069ee0d6bae61af86 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -196,7 +196,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
 
     plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
     if (is_la64(env)) {
-        base_v = address >> R_CSR_DMW_64_VSEG_SHIFT;
+        base_v = (uint64_t)address >> R_CSR_DMW_64_VSEG_SHIFT;
     } else {
         base_v = address >> R_CSR_DMW_32_VSEG_SHIFT;
     }

-- 
2.43.0


