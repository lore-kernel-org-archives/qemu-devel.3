Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A66C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoHK-0004co-HQ; Thu, 13 Jun 2024 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHI-0004bs-8l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:24 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHF-0007ET-Gc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 7873D13800E5;
 Thu, 13 Jun 2024 13:30:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 13 Jun 2024 13:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1718299819; x=1718386219; bh=2Y
 lomw0G04tS9jeu4S2jeUUKBm1VnFhpe0L3Kiu/arQ=; b=srYAd6OkMGBdRUG8x/
 ZqbvAPDbPZAHneyPqVgB/1105fqDyo0yqqyzZjDbLW9wUdkKp3OHRCx8GK6rdEw0
 BjWSFjWGNk4BU7o4IrCBKSqloi4bbu0t/5ROl4jj4tWLR+Lm84GUd2mJCUB7D9PD
 PWSfoQR870qkusDKWhIDPMapz2XOhg1PfIgqUp93Sx9Tfy2DXQ3y0jpmDsJ5s+M1
 M76i49rpLtgRsPg0J5lcEpJTYE2X9KaNrY4ZhX9jN3shfbdZSsRQI8rldn2WTnbe
 suG80UIauK+S2noaMCZgiPJXhz7Rk9KP/fOtoCfjHCt0mNtEd8+W2tva9uww1wJ7
 ib1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1718299819; x=1718386219; bh=2Ylomw0G04tS9
 jeu4S2jeUUKBm1VnFhpe0L3Kiu/arQ=; b=LWJJ6MPLtN/+Zcuqv+D1mrU/Kg3bP
 MtegnnqxCwnDTvgQ+39XrCbus/kFhvP7ml02fZXGGvUBQgHwCdAJ3IlFXtFQlFVY
 NdJoLapkT2CJQY67HsDBMJFLSE9IkYoD5w4KbBVp8EUHVAIsB/ej9gdihf02GU26
 tKckObYl8864c95XUhC0EAg+49SkDaFKiP4SJ0bszI9gMVK9TG5Vu+9kIVVipjha
 BK5AXBDt90w8Vxfivnvz7t+SFRdncCLE/g1XKlN7eLoKDBb4xv1LOekyqz21jGKA
 C9vDE33FOvIfvO7jWtbx/vBLDx0q3I0y6l161TZA0PWpnB8vHBPzE+lTg==
X-ME-Sender: <xms:qixrZjWc7mroBqOXVB-acadTI8sKxSD9B2LkcUaBXz4owWihHfNZfw>
 <xme:qixrZrk8wiZGFdZ-3i4f3Fd2jMPlP6vq0VIZZWCx70W6IWHO3tJEgmYyzfRqQxnxv
 Sg3gb6HYZCZMU7GJbM>
X-ME-Received: <xmr:qixrZvZoLmNpy3Lp2wLoWgHWG_TDj_bQhdVjamusuezpUkrNn5I5ipM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefhuefggedvueeujeekjeet
 keekvdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
 fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:qixrZuUgu0igV9ZGKb8KdnQZwhG9GYyP37gGqDDHRIa3or1j5A5idQ>
 <xmx:qixrZtmDmjxTH1heLN5eRJJnNas1Zn533lzTzGPPs2OakP-HjzLdMw>
 <xmx:qixrZre1MduTBlxwGo8gUH0DReP1Vgeyy6-7_NJaMLNy_A2O8jogGQ>
 <xmx:qixrZnFavqZS2uS366Jg-NaGUnzIkwHvuJRPbMvC1WhpuWL50XnfsA>
 <xmx:qyxrZjekjEAvAKtwh9ZvsdVOVv97wd8ExtjDYQmJmpDvcq937UV0eJ1u>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 13:30:16 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] S3 and S4 sleep for loongarch/virt & microvm
Date: Thu, 13 Jun 2024 18:30:14 +0100
Message-Id: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYsa2YC/x3MQQqAIBBA0avIrBPMZIquEi1KJxsIFYUIpLsnL
 d/i/wqFMlOBWVTIdHPhGBr6ToA9t+BJsmsGrbRR2A/yijH4LdsTjSwXUZLDuGuDuE9uRGhdynT
 w8z+X9X0/HDhfsGMAAAA=
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=XAnJmJpbuvqPjFRZcGPddcmvCUgokVhu06na45ZpMZ0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRsnVUdsqkMElzy/Wsv3xORnv3qpUak1oYnl81ebhLvu
 v5yA0NjRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkrzbDf//t7ie3H18mWnj1
 5utr5c8/68yO3rmHadKykmq276rPXj9k+O93L4rLXe7KGhk9ofVl5z6fMXj60+jHjjcH3fyLv20
 4Mo0fAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi all,

This series implemented S3 and S4 sleep for loongarch virt machine
and microvm.

For loongarch/virt a kernel patch is requried [1].

[1]: https://lore.kernel.org/loongarch/20240613-loongarch64-sleep-v1-0-a245232af5e4@flygoat.com/

Please review.
Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      acpi/ged: Implement S3 and S4 sleep
      hw/loongarch/virt: Wire up S3 and S4 sleep
      hw/i386/microvm: Wire up S3 and S4 sleep

 hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
 hw/i386/acpi-microvm.c                 | 18 +++++++++
 hw/i386/microvm.c                      |  3 ++
 hw/loongarch/acpi-build.c              | 18 +++++++++
 hw/loongarch/virt.c                    |  3 ++
 include/hw/acpi/generic_event_device.h | 12 +++++-
 6 files changed, 115 insertions(+), 9 deletions(-)
---
base-commit: f3e8cc47de2bc537d4991e883a85208e4e1c0f98
change-id: 20240613-loongarch64-sleep-37b2466b8d76

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


