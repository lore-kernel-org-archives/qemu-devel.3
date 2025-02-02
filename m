Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D07C02190
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 05:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teSKL-0003I2-AU; Sun, 02 Feb 2025 00:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1teSKJ-0003HG-IR; Sun, 02 Feb 2025 00:15:23 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1teSKH-0001j2-IR; Sun, 02 Feb 2025 00:15:23 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id AA84511400CE;
 Sun,  2 Feb 2025 00:15:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 02 Feb 2025 00:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1738473314; x=1738559714; bh=Mg
 LHRbaXm+1XqeYWCpjY5mfcE0MPkPMsVpib3mFqh5Y=; b=ROo8mnWfc0A0KWXHTO
 DZnR+FBaBePeIVnkcQXRX3lW7z40NnSkTHpxoNnqM43rjL9Y25KBy/Sa/BDZ7rIS
 gC9AuyHndZd7WS33GlvNZc2CQFh4M0RYt+VuC/1J7fPVDYSTDOiOAHQ3wXoTHMQW
 78+DrxQwDf7uMv+h3Yf78UBGwtb4iMMB9BlxtyKViCEIqMP60kMuxaSAlfU8+Wbp
 vz1pRhItEZvU9HeZ/R5VLsEZ9kprPNphb2okvOKBCZqT6Prde7aRzFaUp9emcTgy
 EW2LdLHj0aLOEbiJosEbhyGGbHyqHWHjniCg3l4dKQc/e13Ii/NZcyuboXNwjGL0
 PiLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1738473314; x=1738559714; bh=MgLHRbaXm+1XqeYWCpjY5mfcE0MP
 kPMsVpib3mFqh5Y=; b=t3HErZNPJ9COdV1svfec1g5gnyoyIgmRVnRZgD2jiqxg
 iNWsWea8/kyZRdePLz8c92TefFGcir0RjCuRDg9mMa8cmx/hBsdELM30lGcSzsfJ
 wjO0HCeFFLAt42/UNX5jjSYEfXv2VGkTvQkHC5zx/ncj/LNxojZbz05jVHPsb6Ss
 8FCDoBli2Wd42VkITrmXRemarYivntsKuL4uZO/+S1xSfTZAwCsRKazDVUtlZGP0
 t0uP3qONNm0abnJ67oe21EEiCM5UCgiozHBulsr7er+0QC55g0+AJhwarbYLMrWA
 uGaE50EPb4K0HIJhZ/fDu+39V4iaoO/PevkUVDWqhw==
X-ME-Sender: <xms:Yf-eZ76A-NaXZc5zBWPwLBFKtHx3NKDpotFwWtCTjrHsOoPZJbtBsw>
 <xme:Yf-eZw6hl4ZHAos8ae2sFfhxOy2tX-35LMSeiAx-A4rWfvooS9IN_7TT8BuOng7-5
 V9VoHL0BWG44c3WPVY>
X-ME-Received: <xmr:Yf-eZyd_ih38VcHkoh7xM9yy-qW4DGiO0GNvslWtB6kdP6XCFxToiid1MEq5_zluJnE0Wb9WzBM8MkbeVdEQ2Xlmb6M5XZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffotggggfesthekredtredtjeen
 ucfhrhhomhepjhhulhhirgcuoehmihgunhhighhhthesthhrrghinhifihhtrdgthheqne
 cuggftrfgrthhtvghrnhepvdevjefgtdfggefffffgheeifefgvdeutefhgeeuudektdeu
 udeufefftdfhhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepmhhiughnihhghhhtsehtrhgrihhnfihithdrtghhpdhnsggprhgtphhtthho
 peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtoheplhhifigvihduhedukeesghhmrghilhdrtgho
 mhdprhgtphhtthhopegsmhgvnhhgrdgtnhesghhmrghilhdrtghomhdprhgtphhtthhope
 hqvghmuhdqrhhishgtvhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepuggsrghrsgho
 iigrsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehprghlmhgvrhesug
 grsggsvghlthdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishes
 figutgdrtghomhdprhgtphhtthhopeiihhhifigvihgplhhiuheslhhinhhugidrrghlih
 gsrggsrgdrtghomhdprhgtphhtthhopehmihgunhhighhhthesthhrrghinhifihhtrdgt
 hh
X-ME-Proxy: <xmx:Yf-eZ8KZDFE64pPZfvV9Rc8UIXMGsC_y6EBaCaqLgy4og84LSwdggg>
 <xmx:Yf-eZ_KHnQtJJAjOfaSmH2S--2V4agMZUcT5vOSi0-CJbat3haRwMQ>
 <xmx:Yf-eZ1zqNCojLpjDzFjqlHEb6ZDqG8QRVrANudWACkVgpuPSo6yy9w>
 <xmx:Yf-eZ7IChMp3DTtghD-qMf_xaMev_6tDu0VuFQw56RtLTpI34pYUfQ>
 <xmx:Yv-eZwWvYzbpuTDSbbNuzLW2iXrcGJeBEheIEMRn2Q5m32z_o27ZD8Yk>
Feedback-ID: ic5914928:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 00:15:09 -0500 (EST)
From: julia <midnight@trainwit.ch>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, julia <midnight@trainwit.ch>
Subject: [PATCH 0/1] -----BEGIN SSH SIGNATURE-----
Date: Sun,  2 Feb 2025 16:15:04 +1100
Message-ID: <20250202051505.1846933-1-midnight@trainwit.ch>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=midnight@trainwit.ch;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=ham autolearn_force=no
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

fY3jfRbpdO9l1l2wwAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQP6c2B82m4kq6h046Ou/LV6c9I/D/uUtUlivmbvR/lSdCWOiPIYnpK5HPtvhcgVYoQ
8X1k8kKjplch4iy6JnNgU=
-----END SSH SIGNATURE-----

julia (1):
  target/riscv: log guest errors when reserved bits are set in PTEs

 target/riscv/cpu_helper.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.47.0


