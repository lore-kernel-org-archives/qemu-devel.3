Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8682AE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvGq-0003e5-T4; Thu, 26 Dec 2024 16:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGq-0003dg-02
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:52 -0500
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQvGo-0002wU-M6
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:19:51 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id BA25813801CA;
 Thu, 26 Dec 2024 16:19:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Dec 2024 16:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735247989;
 x=1735334389; bh=S4LKGFTypIdV3P5Y7CtYczPKE/btLEKjM8yejT9DHdU=; b=
 aa9RTjecAmw1+MPgV4EcIPNERKf9Kqwux9NLIK2qtI0D5YPv2Vl6MIZgvSGEl0dr
 aNNZW1wmTqBRfinzdAGpSupP0+Eo5Adigef46/qQ1ONjowsfZBtdRT7DDLgPzM7O
 dVkzo3V01Q7phf1XRByXEdxRmIEn+5qGwlCE9zdQ0+h4fLSGOP4Ck5Nj/hakCjn5
 Yqn5dTAxwdz0mX1MY8tmRjcQAKybNTg6/zIkLaYhmNt94GnzuFpRWIE5cMVnMbkX
 bhH/N966ACYZmdHVsO6t+GDFW8dEdtOA/lruYt5KGPJjGUm+ou5SdLdR0FMWoTFJ
 bUuPtdZm3fZCaFOi+vRyHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735247989; x=
 1735334389; bh=S4LKGFTypIdV3P5Y7CtYczPKE/btLEKjM8yejT9DHdU=; b=d
 yL0X7VTCWfgmJLuAxeDasY7Gs3zNGWRqXQxvihynvrcJI/hPYm/Q2RU8JWhVOL7S
 dCrmLksbUQZ1A4CZi307LUS8FEX3BqYDuA3NjVHR8+yDpNT7I6tKsNXsfa86dnw4
 bSLlp+aAue+dIVQ/O/wW+J81YHBpl4HBlj9j/B9O1au0Vfqa/klJRL53c4MZ0iKw
 taVpjhtwtOu/ry2a4KTjIdbgm2r4yRua/1aOy5+ktgpOfEK1phMgMDWMWMRNUuw8
 deQnxpUTnMqsuXFs2SsN8yeSPUsidQjU7Z8Ge5oP/rT4tqVx8CuqvVF0vc/p5+yB
 u5TZyynmOPCoIindAKMqQ==
X-ME-Sender: <xms:dchtZ93vOwowT1pN24eBwqtZXgMjWNGsqrtAHD1tRPT-xCW4uawJsw>
 <xme:dchtZ0HLt0JaaiepPsFtMAoBBbSjjskc58cmRuJ5pjbZFJvnFsWtFUljAiKwqbojJ
 zGmgXISGAq7NAuW58o>
X-ME-Received: <xmr:dchtZ95IKj67tGgwnEJgwFHXitKOcqTkMfZwK-ba3RjAm0wRE-ZobrH7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:dchtZ63mA2vnaWcWHErVjF4hb0_v_H8A4Af1M0g8OEFpox8pUNH5Vw>
 <xmx:dchtZwFqqPtjya9nMMxjIcRZV2TNd8oawQQ2AlRvD9cfSM0nY-teIA>
 <xmx:dchtZ7-kxI0tfRGYaGoU2qF7YX2cqyuiIFhflKh3FJ8uxfZGvLOLHg>
 <xmx:dchtZ9lQb_23l8uG2cZYdx52B5xV61KsV7y4aISqG-Hj4vVd9MD_CA>
 <xmx:dchtZ3c55eAg82tx5yXEdkI-TYFFG5Zg2BcIJh3TX4rRIlSplqG1ywtF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:19:47 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 26 Dec 2024 21:19:34 +0000
Subject: [PATCH v2 03/23] target/loongarch: Fix PGD CSR for LoongArch32
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241226-la32-fixes1-v2-3-0414594f8cb5@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=6C/XW5GxVl4u28OCGxlKZ9TASN0NONQ1NU6nHVutsUw=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvTcE9lsTzY9PN+sWKFevo9Bd2HitoACKamd7Y2LMyL4O
 KTmGAV2lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwETmJDAybLBbVvdPP6Fc+HW+
 jtSsI9vnsZ/i3HqsftPSeZILr3dd8GRkOBa3Yp70/Oc9qeIbpx868b22ytpW9lHVtfvqyof2cR3
 6ygwA
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

As per manual, the source of PGD CSR is relevant to highest bit of
BADV. In LoongArch32, all CSRs are 32 bits only, thus we should check
bit 31 of BADV to determine PGDH/PGDL for LoongArch32.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/csr_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefabc7722263fa46e948e21de37b4203c..821aa6af46ea2129d771fdc937eca72317cefc1e 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -26,7 +26,7 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
         v = env->CSR_BADV;
     }
 
-    if ((v >> 63) & 0x1) {
+    if (extract64(v, is_la64(env) ? 63 : 31, 1)) {
         v = env->CSR_PGDH;
     } else {
         v = env->CSR_PGDL;

-- 
2.43.0


