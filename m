Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF36C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjNKR-0007kB-GX; Mon, 13 Jul 2026 16:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wjMal-0000Ou-KC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:45:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wjMaf-0003TM-63
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:45:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc44aso1337155f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783971917; x=1784576717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nIKPn37ekPjotsQBGbChfqYBuVfdRftV02OfijT9yAY=;
 b=WxSZ0+NFHwvt8iO4O3Ijw6i53vwikihmuF0oyGqa1Gtu+L311orQ+CaUDgTh4cm0MS
 mhNj1Vly6twdrgOtxVAAZ/SpGtqR4uMF5eomYkolKCtSpoHGGXZVmFHkVuLC78X1A4JV
 QVIUa9OrNyh26lGnHOtUAunfV+v27PPYT1iMFx2+5m8baHqsRaTuHRbdrE5Yg66f2Hx9
 Ux5o/zidyIbrN4JCga3saiRXaAmMVgGdHRG5tm2GhxlclxLy7hsL2lFxUl1ccZx//j6Q
 jpo3igw1jiFhuoEpm0suv7nolWp0XGQZQSfhaMPiOpEWPGPEoNOgbQkOK0PnWoRZTHKf
 uFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971917; x=1784576717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nIKPn37ekPjotsQBGbChfqYBuVfdRftV02OfijT9yAY=;
 b=Vi8lBvtOP6voxiJ63ENMmUZMy7ClNHHBhsTO8Jb/Fk3l4RBEFo7UTB2UjPF9ccsJTL
 r/rdtXuJ6ih0wuwUw6r+ctbJwt69q6ThSsdU3YRH9zEeS6A34FwGso7eRJNhlJ2iXqOn
 A2RH/r8y+ndxaYy1ZqBcH3C+ujNkpJxQNdCpM9OTPNT2ta1X237anR8kvPUpiRIINA2b
 oMRweKw6SWMi5CQBhS/9VNV4HIoLj/jmnHYCTN6Xh0wPiaSiLi1VAVpjN/1RHwdCoxrF
 sETbgdEml8qP//K4FtmxPbXkHNaBKbVc0TnbAs8wD+1nnPcrPkqiYczPGCpG0oCfP0BO
 WuCA==
X-Gm-Message-State: AOJu0YxW/YAyWnXCmEQ+566EgCSaj6KUtorLQ34638ea53Kdmeb52OIm
 6hI4ydhhXfsk7AXWGtpCX/GB1ZkhSkueyrzXC5iWJNWH9IEMHFRfV8bLFvKYAXbfPgs=
X-Gm-Gg: AfdE7cn1W+WoBGpETl9Rd9Sl0TQfjCCrVtIdOnMliBHcu6BT6cNYxw5M95yVZeq65kQ
 CXV6XHcsSYvm1KpjUadHGA+DK8BLa4GnpJ2yyt1dzFQ5W3jNul/r5OHoJVkK9/WuF3M/b+E5pxP
 McHU0LMJnXncT/Y38I+krvh0BbbDDmhQUVD9AS1PLzNGYYuyQnja2Eclsh7IdIi7+OV40dncShO
 82AEdewS+iWkWK1ZsUYweSHwM389oUOqs8AuSJx0fI8R5m4ava7cQTdbhEwhO2HNO1Iyg5vkVxu
 GYG6fUjiRDCLWE1a0g5VNYQU+4iFVJ0UTy2yEIX53lvju5cSropBLS18qyiHeZ+LbUKjA6b0nPG
 P48kEeaXuapj+c+smHuD3W73g5cfkRUurfw5UOt4gAgAPijBPi9mZImOCRdDFCSdLbmO+pLX/tY
 sPydIrUKBkd4OVyrTMQ0KKHOLLIYP3mCPK1I6e6iU6AffwXVpyBhooevRSsw5rSOidinQE1ces6
 VIa4xcarLFhn2k/TdxAKTIemJsU/0iwTrzv3IkgTlk/xHxUCBIlWIiosPUFqQ==
X-Received: by 2002:a05:6000:4906:b0:47d:f02a:99c8 with SMTP id
 ffacd0b85a97d-47f2dc9bdd2mr10999394f8f.23.1783971916429; 
 Mon, 13 Jul 2026 12:45:16 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm2052990f8f.24.2026.07.13.12.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 12:45:16 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH] net: only advertise passt in netdev help when CONFIG_PASST
Date: Mon, 13 Jul 2026 19:45:11 +0000
Message-ID: <20260713194511.1058450-1-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Jul 2026 16:32:38 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Rohitashv Kumar <roohiit@amazon.de>

show_netdevs() lists each conditionally-compiled netdev backend behind
its CONFIG_* guard (CONFIG_SLIRP for "user", CONFIG_L2TPV3 for
"l2tpv3", CONFIG_NET_BRIDGE for "bridge", ...). The "passt" entry was
added unconditionally, so "-netdev help" advertises passt even in
builds configured with --disable-passt. Trying to use it then fails
with "Parameter 'type' does not accept value 'passt'", since the QAPI
NetClientDriver enum member "passt" is gated by 'if': 'CONFIG_PASST'.

Guard the help entry with CONFIG_PASST so the advertised backends match
those actually compiled into the binary.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 net/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/net.c b/net/net.c
index 2892f17..5c39f8e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1385,7 +1385,9 @@ void show_netdevs(void)
         "dgram",
         "hubport",
         "tap",
+#ifdef CONFIG_PASST
         "passt",
+#endif
 #ifdef CONFIG_SLIRP
         "user",
 #endif
-- 
2.50.1


