Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39CBD10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 14:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOGPW-0004Zl-7j; Wed, 26 Nov 2025 09:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGPG-0004M7-Ol
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGPF-0005NP-Be
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764166924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GgePewO2nHmMcoXWdSHlgQXMU3wcPQMhaYqxzJsOSU=;
 b=bBwfgxfw61P2TZvma73YfVon0P2xbzXTtGP6bWE7FzmjxacdxDxv9m+S29VzeMHdGGhCfm
 FNrNoiYPKZpPRzLsqwUDmK1yU8VZSZj6mI4A4InFGQiPsIR6xwhK2Y/uvIISpqa4CMN+WD
 NtPfDwN04hfJdmWVU8CUzxiunvrHcz8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-rDDAR9nzOsaXBk3a5yLpFQ-1; Wed,
 26 Nov 2025 09:21:54 -0500
X-MC-Unique: rDDAR9nzOsaXBk3a5yLpFQ-1
X-Mimecast-MFC-AGG-ID: rDDAR9nzOsaXBk3a5yLpFQ_1764166914
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15FB41956096; Wed, 26 Nov 2025 14:21:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.126])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 275571800451; Wed, 26 Nov 2025 14:21:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DC2CC1800395; Wed, 26 Nov 2025 15:21:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] tests/acpi: update expected data files
Date: Wed, 26 Nov 2025 15:21:08 +0100
Message-ID: <20251126142116.4077056-8-kraxel@redhat.com>
In-Reply-To: <20251126142116.4077056-1-kraxel@redhat.com>
References: <20251126142116.4077056-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

New firmware builds change the memory layout a bit,
so some addresses in the acpi tables need an update.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/data/acpi/aarch64/virt/HEST       | Bin 224 -> 224 bytes
 tests/data/acpi/aarch64/virt/SSDT.memhp | Bin 1817 -> 1817 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index 674272922db7d48f7821aa7c83ec76bb3b556d2a..cc1641fdb4e7144a72278f7ef502352139d7b9e1 100644
GIT binary patch
delta 56
zcmaFB_<)hi!!<bM0RsaA<A;e{793`73=9km95NFFMJ6V&PTbGQBEVqgHnBjD$;@ry
K0xb|(AOZlXP!7ES

delta 56
zcmaFB_<)hi!!<bM0RsaAW6ne_3yxdP3=9km95NFFMJ6V&PTbGQBEWFVd18Sc(=F$T
K3$#FFfd~M<x)8kp

diff --git a/tests/data/acpi/aarch64/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
index 1deb1d2832201a5da7501821f1ea20d3eecb08b2..a6c8bd9ea06c8704f82a35792d6415f42e0de23d 100644
GIT binary patch
delta 22
dcmbQqH<OPmIM^jblAVEp(RL#jFFTW&8vr>C1VR7+

delta 22
dcmbQqH<OPmIM^jblAVEpan43AUUsHi&Hz111wsG-

-- 
2.52.0


