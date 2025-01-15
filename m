Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFE0C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7ov-0006Mo-GT; Wed, 15 Jan 2025 13:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7or-0006M1-Qr
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7op-0006VI-ME
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDEb1jmCYlGsY9igpHDK8At5L72Z0Fy0/80IJEPSb0E=;
 b=Af8kAWTavQM3rO/e4dRWDGrHx9alJ9qepXAc4XIyZn+dVkrmS7VS9c8jKGV5PPFK6ECjUc
 ALJTRZWdgNG2cKwQdAr5figpQvU6YLcVCxBG/obuEeBAqMdo1lqBhHcEb+n1lKqRV28Pmc
 da/nP9aGmOWH2aqEPwnHlfmWKw2kaeI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-bC_ToINANyGpMyksH5xzzw-1; Wed, 15 Jan 2025 13:08:39 -0500
X-MC-Unique: bC_ToINANyGpMyksH5xzzw-1
X-Mimecast-MFC-AGG-ID: bC_ToINANyGpMyksH5xzzw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436289a570eso32464695e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964518; x=1737569318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eDEb1jmCYlGsY9igpHDK8At5L72Z0Fy0/80IJEPSb0E=;
 b=F0Knr/d+SwdG48s45orEm+2buWNLMA+Nt/1b0mDDA165ZC4NDhSyy1Zw/Y8IyJeVE8
 794ysECAVfXPidPL0wdkXm81x2hInoUXFOCkkcspI3rfsC7T/LH6PMaa5jJrbMG8Pz7Q
 c9Qei0r5iA0qRTsBglFSsUi6nmCSmX8OA4OarGdhwwpfQcW6o8e1DHTY3eBJmid7GT0H
 TN7koVEKvOwoe0af9Q+pSjswuoyotisFmwkJHScsMbeb5niKFUCEFe/oNWJHkKfzRkKt
 +CG7jPhBSP1P53uU5mhc991VtIFBJAvxZeeHSqMITu82aXQG5iNLK5R77fpQ5JE01YmQ
 /Miw==
X-Gm-Message-State: AOJu0Yx9X/+ooi8WT9iLcx14Yhp+kDeHidCTtv2XBXSUjJ0o66mxknQy
 LzqCfzwBUWGLvNVMJ+z6DM3/RPM6beBRySa3IkHk7Vl6u5vP5Ga31UFtPQtVmDsd8SqavwD8Ryn
 AQTRRzkzCFBXln1kEF8rAOLlXwnWHCGBCBpNURhHRsANerKaRd1W2pwG6QdvXhy/oyclxbKRuNr
 +oDLN17wspDc8+VEr3DD9CgWOU93EVEg==
X-Gm-Gg: ASbGncsrc3Te2ZVQ4J/zO1M+LHUNFNskWptltkwKh/dGMMlhJxfZ2PkDf0rpXkk812i
 ft8UuDLA14YXk96sn7MklLRUPZXzgrw30tP/rRfBc28voHeNddhnKToYI0tuB3/Jh0giHgobf4b
 T+iZjB53wVZ1QHLWjjuyvOx33RuzKRWSTBYyUlT8H8Io9hVtqRvc3GqoGMLM9qSI67ppjM/aJps
 iKkNusT6HyQsQHgjutN7dr+M4o4JGH765To8FtgBSVYV+XvpKtG
X-Received: by 2002:a05:600c:1e02:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-436f04e048cmr205157085e9.8.1736964517997; 
 Wed, 15 Jan 2025 10:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGErAs7BJq0grzq6CVsX59y15FOyD2Vvu/EOBUzx2FqIr0DwQCLG2wx+zOqn4xKFoK4buAq9w==
X-Received: by 2002:a05:600c:1e02:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-436f04e048cmr205156825e9.8.1736964517618; 
 Wed, 15 Jan 2025 10:08:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0b1sm18410878f8f.12.2025.01.15.10.08.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:36 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eric Mackay <eric.mackay@oracle.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 03/48] tests: acpi: whitelist expected blobs
Message-ID: <e043be2290ffdd666ad2ab35d2341c137b21a3b4.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20241210163945.3422623-2-imammedo@redhat.com>
Tested-by: Eric Mackay <eric.mackay@oracle.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a1047913af 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,43 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
MST


