Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71461C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgWE-0006AL-71; Thu, 27 Jun 2024 00:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMgWA-0006A2-Gb
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:13:54 -0400
Received: from wfhigh6-smtp.messagingengine.com ([64.147.123.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sMgW8-000070-QZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:13:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 0584218000C7;
 Thu, 27 Jun 2024 00:13:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 27 Jun 2024 00:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719461630;
 x=1719548030; bh=CMrfGIFF36AWFwFUfZ1btN4ogSaJSoe+fW4Ddv/zPfM=; b=
 jSWHPyCi5UuwxTW2k0Rb4SSZzrJWYAeQzu9DqIEY/wCHTF9/FZa2VEj4RJ1OaW2f
 NqTMVL7Yvd9be2rhl4TBjZ6+TSmMVpz7C7gKxxnlWawcfJCo/haynmh6l7fc25gY
 W5V7mIJ5whgyPp9YWtj5X45M5jLC8Hv0hjqTKhQ38jxbRBC1nNFahZwyLS/gpt0d
 qjWrowlgh4m2lAO4BhsQJplgqhjaTZQ5kQZKBfxgtUd3uhEOPRDBdkMegS/aVmn5
 EkKf9KFdBCHbVJztLDkUHPxgFlvPHtniZPn0C087r4ucSPRepAn0ARXkrj3nkzGa
 IpN0gRy7D/t2qIlWavx5pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719461630; x=
 1719548030; bh=CMrfGIFF36AWFwFUfZ1btN4ogSaJSoe+fW4Ddv/zPfM=; b=V
 G4ynK4s9272+0WwBdlmiszc8SwmgNq6OGfeCIO04lK9RZobsiloDG8fIhLxrv4PX
 VGuV6usbHUtuQ+eOhUl9sOAroiHq2V3NWr6VAtB9jeRt7KZKC7V6HQuV5Efa/jwA
 Wjsv6Gz//DYliHGbjxFwl+IJl8kSioMpGQlyGcAG5loCm6oVk78S7odxNEijFqHy
 OJmyoyv0VmrXaUDN2i281viMjri4MihOmoP7U3M6PBEsHh0jUXCo4RnlmaVyXA7C
 sLOZkkdCe5GYHqJfXqgpkUio6SMViI1fdU24QfOXDK4jbtlrCb6ovry4FIh/z5t+
 li8EnFEF+4hQXgdH3swAw==
X-ME-Sender: <xms:_uZ8ZpathcyTyXz9FTBToCwWDgpcjqXDn2AfdJRZwxAkjSzGuF4erA>
 <xme:_uZ8ZgbJHZHOp65PkNvrbxPkB1gg-CW96XQqHZBSUl5hmfYWHqPJcnLJ3_BJDaWvf
 _ZIaksOUibmKgx_bac>
X-ME-Received: <xmr:_uZ8Zr9TMglB6W8ZxRZPR7KgShq3KFzHh7J6e950G_HeeVrdd3n3CM_QrTwnVCY4wgmekU5Go4MlVkuk7fZpUD_K2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdefgdekvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
 geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_uZ8ZnquojzNoyS4OpqVzkvaLTrjXp7JFkNM8gocEkGnnQaq2SiFlA>
 <xmx:_uZ8Zkqqwdo_MTWeA1eO_LvSEHk1InoCQwrp_2nGWJBmixFUgxQusw>
 <xmx:_uZ8ZtSZksw5_UOgPv0pKs5n3yGv1hshFueMtVtD7ol79R4UrZjg0g>
 <xmx:_uZ8ZsqIreqSzcIWdMBj9wSdoUY3VDk5lOErmu-XkIxjcAx8leg4fQ>
 <xmx:_uZ8ZpD2LZ09aleJUvQQ2gw3zahFzw3gF75ONO7yGmbRL94o-cs1imSl>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jun 2024 00:13:48 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 27 Jun 2024 05:13:28 +0100
Subject: [PATCH 2/2] MAINTAINERS: Add myself as a reviewer of LoongArch
 virt machine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ipi-fixes-v1-2-9b061dc28a3a@flygoat.com>
References: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
In-Reply-To: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=791;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ieI8OByJYwoL4Sx5WKbjP4EnH6pItE07ZE+/vMWh1PE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSaZ59NFZv0eMVr7Pf8EzaQ6V8180XHa6uZ66PSzs/Rk
 Jm9UXdeRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEwkehLDP00h0TtHSxZd+WLr
 wn+Ch998VtuZ3Nkhi1he2c434XEVfMzwzyqvjyvwY1a0TzX3HLVtYl0sYc/5eh+rX33EeXb3O78
 MHgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh6-smtp.messagingengine.com
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

I would like to be informed on changes made to the LoongArch virt machine.

I'm fairly familiar with Loongson-3 series platform hardware and doing
firmwre (U-Boot) development as hobbyist on LoongArch virt platform,
so I believe I can give positive review input to changes on that machine.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19f67dc5d215..9a646ea58483 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1239,6 +1239,7 @@ LoongArch Machines
 ------------------
 Virt
 M: Song Gao <gaosong@loongson.cn>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
 F: docs/system/loongarch/virt.rst
 F: configs/targets/loongarch64-softmmu.mak

-- 
2.43.0


