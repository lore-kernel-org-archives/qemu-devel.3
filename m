Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03551C02196
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 12:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spRbR-0004yr-6P; Sat, 14 Sep 2024 08:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1spRbO-0004re-6x
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 08:10:10 -0400
Received: from fout8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1spRbM-00016O-1J
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 08:10:09 -0400
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 153601380391;
 Sat, 14 Sep 2024 08:10:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 14 Sep 2024 08:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1726315805; x=1726402205; bh=ig
 QJbvSm3GOcmk8BfllBf2j08a2rltjGAzzNn//V+C8=; b=XS5C1oF29zY1SwWtrQ
 wnqEzmVseovjow33w0dRguLYdoDWL2QHA6pn4pQW5iYo3yHNosBNn8GDuXmepmWo
 KjBnA6ioZOclJuSEp7L1/CauCWSC42Mrn0Nwc6O2CAWkCOyKDijQOhoXMgQpT5Z+
 amuSI5nx+3cjQUB6F8IB+Skaq0/1kC7XWNYTRZUb/s33IIkvkINT2QZ+8l4WJY/N
 YGqMm4wXT6bHWy4riNCSFDhevUdjyasMQD0DWcvGNhcNa3sS8udj72+Fw9LNTrqL
 /GSVyA5P+yJb9+WXG1suFbahst6YtSI/Py5hOmt3BJD/dB+JUq0MGSh5nZdWHF1z
 44Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1726315805; x=1726402205; bh=igQJbvSm3GOcm
 k8BfllBf2j08a2rltjGAzzNn//V+C8=; b=FcjkFLjpg9mfKWt+p6AU+HVoVlA7m
 UsaedlFJqFiAwp4pvdWeh32HgyqScrs/HAN1qAGtZ/FYYKXnCwCYFYiwmt9Oga33
 O8iTEiJVgO4ivEJQ6WwS07wauWadHE8Vls0CqWpRIOfRMkoej1wEYRWsZFyyNBrC
 qR7yh6at0hRc6xj9t743PDcSZNo87AT2P72BoGxg/kmPzkWKRoqnNP7u+23Kiykp
 MX9XweTa3X30zxA/o9ZkMfD3psXugJQz4Vyzbh7Yh5J2mJi8NywDzPeFVaf8Ih9P
 4vaPeJGjduvhRziW4DX84E2VFrn4jm18xUhN+emO8K9USXYfdWJYH7aSA==
X-ME-Sender: <xms:HH3lZsbJX69K_NdxyBhVShOT-Vz1a5swl0600_8V2mIB0QdCD28Fdg>
 <xme:HH3lZnbpjrmFXLJaYdY_-yMnDufY2LFERO27v6iu_kiE5oz5M_HdyCo4FvkWoM-hm
 je5Z9NRrpWxj7SSObw>
X-ME-Received: <xmr:HH3lZm_Dwet1_OqLvVZNFfEQjCvNKfXSQY90g1imdNEwhixZl59fMrD4-m6CoqchDoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeet
 feegieeijeehfeekheekveduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtgho
 mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqh
 gvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehjihgrgihunhdr
 higrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgrohhsohhngheslhhooh
 hnghhsohhnrdgtnh
X-ME-Proxy: <xmx:HH3lZmpcTSh9nlBgs052xRafNxyAQsLtLkNhIccsXGtjetDm0wePUg>
 <xmx:HH3lZnpZ8wMB1zrATWFEPnLjavxFVAbXM72vnw18cXOO8YlTasvCpQ>
 <xmx:HH3lZkRRXxoJms4pw4YE9utoFS8tSi6Aq0ZHfTUhmw7EIjb9XEyUmA>
 <xmx:HH3lZnpD5jIe1TA-nPCSU0oq_gRhgABOb6tMVzejmrN59dHg2B-Ztg>
 <xmx:HX3lZmUbP3oXnvaDSywRK375HLdQv_MNjqftQ7Y7bkkMyPBZL7Kuc26_>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 08:10:04 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] hw/loongarch/booting: Booting protocol refactoring
Date: Sat, 14 Sep 2024 13:10:01 +0100
Message-Id: <20240914-loongarch-booting-v1-0-1517cae11c10@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABl95WYC/x3MQQqAIBBA0avIrBOyrKirRAutyQbCCY0IxLsnL
 d/i/wQRA2GESSQI+FAk9gWqErAexjuUtBVDUze6HpWWJ7N3JqyHtMw3eSdtZ7Dd9Tj0doDSXQF
 3ev/nvOT8ARMfQA1jAAAA
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=752;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=4up76yiBu+BMwZ0SeKD0MroDj75F5Oo3yI6sUIhkd9U=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSntTK2V02fpyyyqTjT2shjftp0nuwfk1dPdBks7FY+E
 r4l/Lmpo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACaifozhf1qF6L7vPXuW8p3R
 TZ4v/9CqonP3Bx4lj1wJv+LuR1s5bjEy7NDZunVtzwUuxVccN0q89I2/Lbhkfe5K76OK1+mFG/q
 XsAIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

This series refactored booting protocol generation code
to better accommodate different host ABI / Alignment and
endianess.

It also enhanced LoongArch32 support.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (2):
      hw/loongarch/boot: Refactor EFI booting protocol generation
      hw/loongarch/boot: Rework boot code generation

 hw/loongarch/boot.c         | 321 ++++++++++++++++++++++++++++----------------
 include/hw/loongarch/boot.h | 106 ++++++++++++---
 2 files changed, 293 insertions(+), 134 deletions(-)
---
base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7
change-id: 20240914-loongarch-booting-b5ae3f4976b7

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


