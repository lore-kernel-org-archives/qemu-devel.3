Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4ACE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvHH-0003pZ-IK; Thu, 26 Dec 2024 16:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHE-0003oh-IL
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:16 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvHD-0003CN-5N
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:20:16 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 3180F13801E3;
 Thu, 26 Dec 2024 16:20:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 16:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735248014;
 x=1735334414; bh=To9ljGdoXUmo7Z5V/SBdfQXvdYuRRAbw4vPpVlePzWo=; b=
 cv3WlCh7hdUeUjIPg3GgQ+1fCAMj7BuhUcQA1XkhAkwXzDOj1Fhj6kggNIMk8t0B
 wYd6oiYTy5VJnHEe9C/3curyldSYxVvGgZFz5DOejsu5Z8wnv792Ddsw7fIeJ99P
 X5s4akkPSPwCnBFFO3GtWsCZbJwA9t3zG9mpgQvQ/kxCVceGKhR7cr+yFNdTsz18
 52ofF2SUjuGeqZKTekEMUjlUa90iRLJnXbI1nFeZ+wmLnDnrdf7XJ3QdsrdEYHMN
 JzpDi29n25C9TLHg1GRcW0GGx4QLXtumwvf/exdg824G3bG5oyq6jkvswz7Nb20A
 UhFf6THioQXw5NWH/RtBPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248014; x=
 1735334414; bh=To9ljGdoXUmo7Z5V/SBdfQXvdYuRRAbw4vPpVlePzWo=; b=n
 g5+B6sUTtRGPkD/OYF3cqGeX/N5p+3dCQHDiPHdhJ2KAVIJ0lwz+zNQKU0i0kyCi
 LrBqaad9b5Ko9VUEthy3Qs97GKLZDbshJEINj5Y+6b1Vtg+LejaEMSyUp+VY3Y3y
 J+TKcJd9/cSh7QDs+y35F//Da4Jh8KYHuXBeeu68Wn+8Mo8OIQjF3DweZPnuhoXk
 ISnTLfgxmEwkHtpaYZBAEPe4rxNOrKuqQE/CRrfpjlzeOY10a6AfqjXpTuUq+QrA
 VG6P2k1CIkQOhMv5uixsycn1eEKK51n6NXhmwZWsFSLESdBsuJzE1QrhnfZk8xF7
 j4yjyxfCp/KaJX4Qx84BQ==
X-ME-Sender: <xms:jshtZ4Ys9xLDPH2DB6BYOhgjTqaB-qu20bKfB6fIH2zvGQa7xYBaaw>
 <xme:jshtZzZ1vKydVvpzp-UYH42RNhWRhoJsHalYGoCN8n80qYqfCRNksWSpCohOAGl2V
 qvdHGtBgqQ3Qna-GTQ>
X-ME-Received: <xmr:jshtZy_EtLZvyDUWcjYIUP2RHuFtQVruvRaCJCxbtWCy6cEc9UjiSvXd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevveetheeggfegjeekjedttdet
 ueeludehveejgfejtedvhfdugeetgfelhfevkeenucevlhhushhtvghrufhiiigvpedtne
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
X-ME-Proxy: <xmx:jshtZyoucRVPG0XeixPwkoACTCRYKVK72IBhrFKOjvVZsF5lxc0hGA>
 <xmx:jshtZzoopgdJDIx6ohCvMJnVMYwUFxoN5TDPZH1PdY7pA9SIUZMvGA>
 <xmx:jshtZwTZQWwk3h1XzKVKTVtxZdFym32RiJKQ2kInea9VGZIbcn8Y-Q>
 <xmx:jshtZzqQUDsRUaGcuo6M7BP0p58eRya-zmlArY7WDqyfsO6JPzW3gg>
 <xmx:jshtZxgTiXGfWdkRwfyKRIS1hHa0n7ty5q7pbjJVjH5NqiX4Evt2jtwH>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:20:11 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:46 +0000
Subject: [PATCH v2 15/23] target/loongarch: Fix load type for gen_ll
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241226-la32-fixes1-v2-15-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=T7rwYaO9vvl/k/burhzTbL2wPlJMYc+RGt0BZXxOn0s=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lzDptFmWmozk57Y3FE5SBD0SHGTBnOggPOlh3lJ
 QundR7tKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIm42zH8DymyckvmyPRpnzF5
 25YGi0tvbhvW/p/LlXriXybD821XwhgZnr6TsEhhXKT9fl3H2ZXv/cuZ/s/M6PxYl6wwlyFyenA
 UBwA=
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

gen_ll should use tcg_gen_qemu_ld_tl to load t1, as t1 is
in TCGv which means it should be a tl type value.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 8584441b543712af8a56aa234c90fd6370c8df01..138bcb3e9999b2c186057c658a019136311f1b82 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, MemOp mop)
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv t0 = make_address_i(ctx, src1, a->imm);
 
-    tcg_gen_qemu_ld_i64(t1, t0, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop);
     tcg_gen_st_tl(t0, tcg_env, offsetof(CPULoongArchState, lladdr));
     tcg_gen_st_tl(t1, tcg_env, offsetof(CPULoongArchState, llval));
     gen_set_gpr(a->rd, t1, EXT_NONE);

-- 
2.43.0


