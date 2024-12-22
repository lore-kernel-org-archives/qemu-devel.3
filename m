Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E28EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPPDL-0003PV-U1; Sun, 22 Dec 2024 11:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPPDE-0003Ou-Fp
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:53:52 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPPDC-0006Ad-1x
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:53:51 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id BE2731140106;
 Sun, 22 Dec 2024 11:53:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 22 Dec 2024 11:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1734886428; x=1734972828; bh=Y+
 w9BXTtR2eZsN3zwWDEkoXR8lP1JSKMcvfNI13LUl4=; b=vuXBO4itZ3SERnUmno
 U/zy1KGu/Igeoy5ojDPzN24d92FbWOneOTUKyctrILj74LRb5GO70cnGeSyrJezb
 0wtIeBn1NbPrdJqdDsGi7RRMbuABlGy/5QsieCEyBmKfaAIPGAWV+4uEvepgnlSF
 A4K8niBUogRbF92Ue8sIGD9POXRe8+G2zElXBgCQwqR8pj82/VA+5SImxHanBGKs
 zvojkni+j9U7vwPETrM5m1h4Y5KQhUfUxn0V0dl7n1P539yyOPOK6jX1d+6XdWr2
 91Hn04krO6gQIQGp8PR4y4JXUMJ9qaWzvhoC1WYWs7ZzpERAdlpoiVhWIMrOzaCx
 jvSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1734886428; x=1734972828; bh=Y+w9BXTtR2eZsN3zwWDEkoXR8lP1
 JSKMcvfNI13LUl4=; b=F7XZxnoweIpNeKLUj4LMq5W1ytIGlfb6xteoljHIHvUW
 Fy/KKWwHACwhFGaLWq/v5sGD5jWioBmX/+wSPGz1zpCj9FmlStE/fX4pK3dHzTkK
 ZAu7OldauWKFaD3mvKOQ88dMI0gyCWXZFawZlbNa5Tc6/NDEtLu5UbN8l56RT+fC
 jomCOdDq+i/RAFeSJe6AXSn74F6N9O98xktRmF6PCejPKPn99Di93bQQgBj8VA9F
 HodAGsOSZsS89M9TBNZstqkwQT9MgwbBOTiQYoyebEnpCdYCZyslGa3M3xoPCbr2
 /aPY5gmWRYRjeDbXWcx5mgZMEiij+61sZ2CroZK1AA==
X-ME-Sender: <xms:HERoZ0ZSE_BsS7d1Q8wIa_B0FOMxt3ox164Vux7u6X9zscxhe7jBxw>
 <xme:HERoZ_YHo2jdpvwF95lOeBFMCmhly_7fXVeZAQ9Lyesuh160cCxoisCCIoPchzbmI
 P5T0JKt3bE1KRn0cNg>
X-ME-Received: <xmr:HERoZ--_uag8uR_ltESA1fMC15ELe_UAldbkvDWNUhWv8YxwWlLuXEal>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgleefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepkefhueffudekhfelvdffieejheegtdeu
 ieffveelkeevhfevvedtkeefhfegvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopegrrhhmsghruhesrhgvughhrghtrdgtohhm
 pdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegsvghr
 rhgrnhhgvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirgiguhhnrdihrghngh
 esfhhlhihgohgrthdrtghomhdprhgtphhtthhopehthhhuthhhsehrvgguhhgrthdrtgho
 mhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:HERoZ-revjAQVMNhF1hODQbHb9v6P-LKWR73hPuoerisqCakHusDxQ>
 <xmx:HERoZ_rphuVtONkAgWErsPUWiaYqxnQTL7_DrBM875s-_VW1skV7TA>
 <xmx:HERoZ8TXBvBqwSIxclMKMNWS8aacQH_MS07_keo6VW6sXWncOmo1jg>
 <xmx:HERoZ_qHEaxGCg6hG7EEYDZuMaSTPDOWIRG0FVN7qV5bjDFmmHpvRQ>
 <xmx:HERoZ7J7VqWAU35i_QVGt3tTyC8b9VUHozhGTQfbGlLN_-Ovst-6bCZb>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 11:53:47 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 22 Dec 2024 16:53:41 +0000
Subject: [PATCH] Add a b4 configuration file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241222-b4-config-v1-1-b3667beb30a4@flygoat.com>
X-B4-Tracking: v=1; b=H4sIABREaGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIyMj3SQT3eT8vLTMdN1UEzPLJANzUwsDo2QloPqCotS0zAqwWdGxtbU
 APw9+5VsAAAA=
X-Change-ID: 20241222-b4-config-e469b075802c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=OA2uFRWE7vTOczGecDcsipKUPPuK9IUVgYnh3r0y3Zs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvQMF+mXDys/bmOcKn7Mdx+X/t7vF3e+LGJ5I6xx78apw
 0K7KgUfd5SyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEjnMyMkwJ+yWQ1rl9wVXf
 GJGlKe7zgu9enrhAYab2uka9Jfcu+7AwMuxRVWROLGQLnfhnh9XOsM3+rz9PTDm9NSv1W90CpdO
 xWswA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

b4 [1] is a convenient tool to manage patch series with mailing list
working flow.

Add a project default config file to match QEMU's mailing list conventions
as well as adopting differences on scripting.

Examples of b4:

```
$ b4 prep --check
Checking patches using:
  scripts/checkpatch.pl -q --terse --no-summary --mailback -

---
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
● cc5a4c890fed: Add a b4 configuration file
  ● checkpatch.pl: 27: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
---
Success: 0, Warning: 1, Error: 0
```

```
$ b4 prep -c
Will collect To: addresses using echo
Will collect Cc: addresses using get_maintainer.pl
Collecting To/Cc addresses
    + To: qemu-devel@nongnu.org
---
You can trim/expand this list with: b4 prep --edit-cover
Invoking git-filter-repo to update the cover letter.
New history written in 0.02 seconds...
Completely finished after 0.06 seconds
```

[1]: https://b4.docs.kernel.org/

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .b4-config | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..5feac15642958350c457d1769bf881184ae1a79f
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,10 @@
+#
+# Common b4 settings that can be used to send patches to QEMU upstream.
+# https://b4.docs.kernel.org/
+#
+
+[b4]
+    send-series-to = qemu-devel@nongnu.org
+    send-auto-to-cmd = echo
+    send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback
+    prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -

---
base-commit: 65cb7129f4160c7e07a0da107f888ec73ae96776
change-id: 20241222-b4-config-e469b075802c

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


