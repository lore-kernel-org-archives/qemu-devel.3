Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4D0C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjH2K-0006wO-Lb; Sun, 10 Mar 2024 07:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH2G-0006v5-BG; Sun, 10 Mar 2024 07:08:08 -0400
Received: from fhigh7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH2C-0005jc-T4; Sun, 10 Mar 2024 07:08:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 9626B1140064;
 Sun, 10 Mar 2024 07:08:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 10 Mar 2024 07:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1710068881; x=
 1710155281; bh=63ZMpYFrSvLaOSintTqdxKjcQVNzy/0ic4rsbwOJIfA=; b=S
 ChXkiHzJpkxRZ4R8jEooreBBs+8YcOup6owNauQ4m5znEgkGfq59K/yU8wdQG4XC
 z3MxJhjguwwXU2KKMI4dlnuTLPL1I4j70KTPfjiy22KH2sSP8dmY00ApgKgoadpS
 9XtHIndwG8SggNx2sGDf5PCXMj0XNkoL1R2D0Z3b/1oggk4IZU9SzHqG5QQJ3Lt5
 TpzwTj+Ow9BcvVd+0GdsYNv4ngxf6uBeK45jROPUkiD67ykq6sGu535TKEJ98XMv
 RfwLUrSCBGo6T60I6SRI99weJFAXeQGlUSSUO40nITUu8XOIwaX4QdlevbmkJttG
 1+PWOAFqSqu32yURcxSZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1710068881; x=1710155281; bh=63ZMpYFrSvLaO
 SintTqdxKjcQVNzy/0ic4rsbwOJIfA=; b=O0S7w9WVlXen0D+2xJhGfGMBbJzmp
 5BnGIkypC1tbgyvzEiJndWG9PEgE+GOevpbf5/5IcpLqzGZBOBeQr53plchtapfG
 Km0BD4SY4IAi7FbBjzdU0T5b+OXfyVfckdn+8+WekXdwJDOX0+siDyvmhG5Hit7f
 Zhf/2LjgfxMu9FfLlyT6ZxKI784ieDqWMtF5BBy1gnFsIv4JurThPbPT8sEb/N/6
 0odSkLMzdjws7hI6PZbO90ecxjARD0BsWu8Ynn11xxWcW3ejk6Mj04/xRX6jB1vK
 rsi5U7grJEeBDhdU31nkbBgKN9P6kxj5d6GqZZGkCrvHIaEeazSNmWhFA==
X-ME-Sender: <xms:kJTtZcQfhPjIemOEsq5knS_LrDnRAgiOPd-n3LMrnHTdHVdGKIa3OQ>
 <xme:kJTtZZy6cQ22aWQ9xrMMDfAbA3CNY9aIgpFShLUvIsIf9QZhq-1MTOknHQbFn2Mdr
 OlQigAaI1neN2GRQvg>
X-ME-Received: <xmr:kJTtZZ30RC65Du6OViYuc3tfvaE58pjN6jBOT-XsRMvxA7lkNIIC2y7D7kuaRE_hilf0-fujAJ5WVdMw2fXoyIaG4uX7NjsdCKMcY0qoISJJg77sS0daA4h_PBlhHepqHjO9vuCxdMFkFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieelgddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepvdffhfehfeefuefgheehudelleeijeeuudfftdduvedtgfehhfdtfffgveekueef
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:kJTtZQChwJIUjNEm0_HB3dA_eCoFs95EB8mBE8BCH5YnAWtRL36EHQ>
 <xmx:kJTtZVhR7jT3j9ssrmaAUZIhyeSd9ZAkhbVgg4093IWFlLwcxKHznA>
 <xmx:kJTtZcpOlHRiWN_L2y2Z_2_hZ51FcfnTrBIY--a2Ie4k69BytnUBoQ>
 <xmx:kZTtZabpa7kft41OEF4DSET5mFOD5aL9w2Y_G2qchyWK_pUGdIPEYw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 07:07:59 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 0/2] hw/nvme: fix hibernation-based migration
Date: Sun, 10 Mar 2024 12:07:24 +0100
Message-Id: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyU7WUC/x2MSwqAMAwFryJZG2hrdeFVxEWtUQP+aLAI4t0Nb
 gYG5r0HhBKTQFs8kCiz8LGr2LKAuIR9JuRRHZxx3lTW4MQ3bqKgO66XcCYcQsKxqevGe+uDi6D
 jM5GW/3HXv+8HbCO37WgAAAA=
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Cc: Julien Grall <julien@xen.org>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=874; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=+2PyS6j9QtGX9/hr9euhqlTWNZsl9k+6ghilZKFm3W0=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXtlI7/r0uI8hCa9SWtlqua3IENTppxoF3jD
 VnTk9+YwMr4BIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl7ZSOAAoJEE3hrzFt
 Tw3peysIAK6a/9cbqBhDCFGbnbMcSXXRToQRT7omn9SmHXfWUuAAi16JrLynnhzBMq7gJn0sHff
 OxXyFpTGBM09LIMHmDJ4amhhMh+JEt+kYivQbirjLw+N/3+dMzZqUYSxc/F0Oga16JSYi1RuIn/
 D5/egBw+OzaKUwzchlOyFsLJglNzbj3M0cg1eeqbz1bDLbv9B3Q+gJ5C3rbF6ZvxCtz5BPhIe62
 PGDgd5714mJNiNRlBNK1fyhn4GeISaFB/GkIOuXNAfpcp8NvGRdLqVx/G/ijO9AlCSBzlkJ818P
 IkPoLiUTFQG4s2TAJEVQgn2ONzc5I3eHqspvlRD4Wy4sm5X4RRKAnKsk
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.158; envelope-from=its@irrelevant.dk;
 helo=fhigh7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Julien Grall, in #2184, reported that hibernation-based migration with
hw/nvme is broken when suspending on a pre 6.0 QEMU and resuming on a
more recent one. This is because the BAR layout was changed in 6.0.

Fix this by adding a machine compatibility parameter that restores the
old behavior.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (2):
      hw/nvme: generalize the mbar size helper
      hw/nvme: add machine compatibility parameter to enable msix exclusive bar

 hw/core/machine.c |  1 +
 hw/nvme/ctrl.c    | 73 ++++++++++++++++++++++++++++++++++++-------------------
 hw/nvme/nvme.h    |  1 +
 3 files changed, 50 insertions(+), 25 deletions(-)
---
base-commit: f901bf11b3ddf852e591593b09b8aa7a177f9a0b
change-id: 20240310-fix-msix-exclusive-bar-d65564414a2c

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


