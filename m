Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C42DC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1JpB-00036Q-UI; Tue, 01 Sep 2026 04:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1JpA-00035W-Lg
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Jp8-0003Ig-WA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788251190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+H0dueytTeKNL0mjuf7wQcsbnHP5VWliirhpPi1V6U=;
 b=cr1C7ndSnZjljCpH78VTynEVYc4cVKBbCOw6ovyGqvlHqWMtLlFrFZFoLpz2gFrFT2PgfN
 wZTzhnqOxOvWjDFeVurKvau5eXsMxE9sUMS/hlWJX9b7/lGOEumPycsNqtcjWovfGQ7861
 qCrBuUJGoJqcUsDqxo8MjU94+wAEHbk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-qyYdn_b7Pf6X93Mpj0aeHg-1; Tue,
 01 Sept 2026 04:26:28 -0400
X-MC-Unique: qyYdn_b7Pf6X93Mpj0aeHg-1
X-Mimecast-MFC-AGG-ID: qyYdn_b7Pf6X93Mpj0aeHg_1788251187
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 285BA195423B; Tue,  1 Sep 2026 08:26:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA15018001CF; Tue,  1 Sep 2026 08:26:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 71CCB180614C; Tue, 01 Sep 2026 10:26:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 10/13] tests/acpi: update expected data files
Date: Tue,  1 Sep 2026 10:25:43 +0200
Message-ID: <20260901082554.804169-11-kraxel@redhat.com>
In-Reply-To: <20260901082554.804169-1-kraxel@redhat.com>
References: <20260901082554.804169-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260824164751.1700783-11-kraxel@redhat.com>
---
 tests/data/acpi/aarch64/virt/HEST       | Bin 224 -> 224 bytes
 tests/data/acpi/aarch64/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index 674272922db7d48f7821aa7c83ec76bb3b556d2a..c1d0b7cf1fd7bf483a9aafd711082d89791fae4c 100644
GIT binary patch
delta 56
zcmaFB_<)hi!!<bM0RsaA<AsS_794-w85kHCIAkUUicCykow%QqMS$V2`@{l0roZkJ
K7ifXV0ucb(yb-+s

delta 56
zcmaFB_<)hi!!<bM0RsaAW6ne_3yxdP3=9km95NFFMJ6V&PTbGQBEWFVd18Sc(=F$T
K3$#FFfd~M<x)8kp

diff --git a/tests/data/acpi/aarch64/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
index 1deb1d2832201a5da7501821f1ea20d3eecb08b2..35b3e5588b1314f5dabd1913c4beaece2f5f3d82 100644
GIT binary patch
delta 22
dcmbQqH<OPmIM^jblAVEpv2-IBFFVs;cK|$G1wsG-

delta 22
dcmbQqH<OPmIM^jblAVEpan43AUUsHi&Hz111wsG-

-- 
2.55.0


