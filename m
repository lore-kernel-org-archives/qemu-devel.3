Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382EE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTU4f-0003qc-O0; Thu, 02 Jan 2025 17:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTU4U-0003nK-Ve
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:53:45 -0500
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tTU4P-0006Rq-Ry
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:53:39 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 82E111140189;
 Thu,  2 Jan 2025 17:53:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 02 Jan 2025 17:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm3; t=1735858416; x=1735944816; bh=Uf
 8WH2D28Nx4Ga/Cxfgp46hAqIyRkpW7M5tP2XHhCeM=; b=R4T7vsQ/FVjQa1x+CO
 ZLBjmgrEQvdNk3oILSLMYDHgUwOe0MdsxonawZmFhbzZ9sEQ/DryoIronlrYH3Kb
 7Vb7JNFS7TEFaOwz8gle9/J0kooaxc1m1vijMxTcYCZboe0NhZHLqwcyApUeQ8Xk
 KSrRKgr5Pwl4OzSmd/HfTzXTsaWqlJE80Ea1IEIse6uijDLZfBWYJnQ+HdEbbKbq
 r9QnPTyDkEvh89dBo5ktnMGUdjegm9gDbpOs411usNE5f2OeNPOXnsSHOiTJWIBK
 5Ud7b8EgtJ4dkWscix2Bb5btzEiSRbmjVZE/IBC8HEZayv90aTX5sG/BgfSeXEYd
 sFFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1735858416; x=1735944816; bh=Uf8WH2D28Nx4Ga/Cxfgp46hAqIyR
 kpW7M5tP2XHhCeM=; b=DEf2iQtlmEWv9NhTslL8yN4kRXg9ddX7Qf8YPuonBU9x
 SwDsxF5mSvF2NAE2u6w0pfIQNa8eDgAiK0lOrN8SJpIX/mPYeG5YFjCNXAzuKggQ
 gnrw8xUkW/rx4EPpGnKeZhCWLLDpiUTcG66ei4KYPMnsk8OOVDNtomaB6FEPnj8S
 QAvIghKk7BekAWpBXbq2Gncud7R4fouH8gVEuncRTcPYb9NpfNe81v1BjSbJAbMa
 winJCPTCEhnCJkLsitD6WIIXbBuB4evrJ2aAdLagN94XK8GMD57cJxAE7U5Z/tEX
 IJFP/8WcyyDoXoDmwNOuW6/sQEsbcRlh/AlFbqck/A==
X-ME-Sender: <xms:8Bh3Z6oI2u9LYAPNukgqik4Ry-PlpvSQR4jJDauEmuGbdI2gfV9sXQ>
 <xme:8Bh3Z4qITLRypYJSCQ_dc-58ZBf7NH0o4iSC8C_XMgEdzZu58khF17XqFogeu7BmC
 BRrlJyPaymOlOb7Oh8>
X-ME-Received: <xmr:8Bh3Z_N22gmkETSrTBjxgqf0tMYrUoT4_9GPI_EmGa-73l3aIObH3iQq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgtdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecu
 hfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomheqnecuggftrfgrthhtvghrnhepkefhueffudekhfelvdffieejheegtdeu
 ieffveelkeevhfevvedtkeefhfegvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
 enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgr
 gihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhopeejpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopegsvghrrhgrnhhgvgesrhgvughhrghtrdgt
 ohhmpdhrtghpthhtoheprghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtg
 hpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopegrrhhmsghr
 uhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomhdprhgtphhtthhopehthhhuthhhsehrvgguhhgrthdrtghomhdprhgt
 phhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:8Bh3Z55jyh8oYZ0dS29uSRgNiOynCauYhf3_qYzFJ1_wZHCXHrmQgw>
 <xmx:8Bh3Z54imHRzN3IJ3d86xKyPD-5dyyS3VqvfU9cBWTjq7p_nzHmdyA>
 <xmx:8Bh3Z5hNb8JQEFmsjvbxDOsiPfrhVZP_g-BG6cca0GKKiWyApCLtkA>
 <xmx:8Bh3Zz4r2JNwTyDi1x7-Wr4w97KhK5qkEPj6NchXnq32m5jMKi8KIg>
 <xmx:8Bh3Z0ZJcfGb9Fpnv0EkYWJvghE9eVDId2CPKQlqYnVe6HpK2_C_Sjg2>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 17:53:35 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 Jan 2025 22:53:31 +0000
Subject: [PATCH v2] Add a b4 configuration file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAOoYd2cC/23MQQ6CMBCF4auQWTumHSqoK+9hWLR1gEmUmpYQC
 endraxd/i8v3waJo3CCa7VB5EWShKkEHSrwo50GRnmUBlJkNBGhM+jD1MuAbJqLU+3prMhD+b8
 j9/LZrXtXepQ0h7ju9KJ/6z9l0ajR1U3TOna1subWP9ch2Pnowwu6nPMXovLZJKQAAAA=
X-Change-ID: 20241222-b4-config-e469b075802c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BSH/sxHycAguWF6+BUIHO8WdVP8BeFk8Ov5omzHHUAo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvRyife7uVLqlC4+6f3n/q1Pxe21L9PLa4uUE2zf+H0yu
 fOY5+ffjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjI9oMM/70lz7/2V9oYpf26
 TZjNI095/R5RpjnLTtyTCmAq+XHB6Ccjw/J18++w7/s+a6dTYWMDh9a58m+zPli9X6tS+5hN6QP
 /T0YA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a6-smtp.messagingengine.com
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
Changes in v2:
- Add lore masks (philmd) from:
  https://lore.kernel.org/qemu-devel/20241224135054.10243-1-philmd@linaro.org/
- Link to v1: https://lore.kernel.org/r/20241222-b4-config-v1-1-b3667beb30a4@flygoat.com
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

Co-developed-by: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .b4-config | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000000000000000000000000000000000..4b9b2fe290f92f784cd3229616e2cbf0e8550e02
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,14 @@
+#
+# Common b4 settings that can be used to send patches to QEMU upstream.
+# https://b4.docs.kernel.org/
+#
+
+[b4]
+    send-series-to = qemu-devel@nongnu.org
+    send-auto-to-cmd = echo
+    send-auto-cc-cmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback
+    am-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    prep-perpatch-check-cmd = scripts/checkpatch.pl -q --terse --no-summary --mailback -
+    searchmask = https://lore.kernel.org/qemu-devel/?x=m&t=1&q=%s
+    linkmask = https://lore.kernel.org/qemu-devel/%s
+    linktrailermask = Message-ID: <%s>

---
base-commit: 65cb7129f4160c7e07a0da107f888ec73ae96776
change-id: 20241222-b4-config-e469b075802c

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


