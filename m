Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246D5C5B559
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZJ-0002X2-Uw; Sun, 01 Jun 2025 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZH-0002Me-9d
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZF-0004fA-O1
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1R8EGI8kUf6+QvZ144Y6v9Xkzk62rtpVvSzTNxcczo=;
 b=aa9SfcAOq7eFGcy15TNI+Bn2yA6XDhGkfvd0/MMQzb41ZyhrXrOIwbxaP1axaEqjTDMu7w
 FxyzPDPV6zML+x8IZiQqWVyTbgdmXiUMWXZBkCs2Am9nJDeMEriNo6gchcTAhzhdmw0DLS
 8vBSqd/TJ2D0hw/D1TzJUbXll7t4Wtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-m5Lhv1iNMHi0GNosMX81VQ-1; Sun, 01 Jun 2025 11:25:44 -0400
X-MC-Unique: m5Lhv1iNMHi0GNosMX81VQ-1
X-Mimecast-MFC-AGG-ID: m5Lhv1iNMHi0GNosMX81VQ_1748791543
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eed325461so22432445e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791542; x=1749396342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1R8EGI8kUf6+QvZ144Y6v9Xkzk62rtpVvSzTNxcczo=;
 b=hvdRuVJgGoN7Rn37y/OV2cnT24uz+hhHsJNiry8CDfzWbFZUIPW9HsqOl3jiwa6Gbm
 XE3UgE86NCBx+2VaRqPxUcJIdPOckz+SEAVn8BbcTUM3Cn25DRO3nT4XaiVM5bI/keqp
 t8tsOm+J236lElprp+2CjKL00XaFuVnDz+1UhLWDzdbTkE4k7BJwz+vTRMj0z9ZCoykU
 Yg19GsbU23eabG9pcsICpMPLYVuPWupScrkhZ70wsry/RjUGWmIF4hFnA5Gt0+BXXtxa
 XBNN8JlStIf2BpO3yaO0Rb3IMiopD0w3VuE4ItPfKaaBt9vaqXVdDGOw76Rk6tWujpLb
 b3GQ==
X-Gm-Message-State: AOJu0YwvvyBElrlKzD+hnY0iHcy/5A9c7iVt1qNfreUMo5MKbyQcz+Lz
 EG9R901y4/YKBQ+AJqSrV0qvWQ8/ky5KV12mxfSGX/L4O8ymHYd2x9VAQKpqgbod9bziN/sfVcy
 /4L9PkdpetXopMna6XS4LmPU+DSAAQcrNyfIascdWy15a2QD4HQ0Ef0mMNo4do+WWFHZK9FwNu7
 nvtz9F2KB07VgEwLcbvOvx5kQ7CYBn+niIZw==
X-Gm-Gg: ASbGncsBnffXr0HJcY91zGLkNk7NLEesrvJiBQnJih/US18CNCr+8IW4usJjEgs7EFd
 ioDQUlwDYExD7gl83U5mOL72ZMs8KoU7aN/1I0BmhA/sWUquB8REP+JPbAK4RlueGRsu3gvI+Lb
 WFnN42g+j8GjeQj0dQasZ8aixdDL+BQRDAHW1qVDMxikpyasbqmuJ+RmgHFRo/4wsq8DSSkekhn
 5ywh4pGerDEh1AeG1jiY3hiaj+f2JYRkrUQOPbPYPq8onJgdSB4EvWSqMCdODLNPMCuKEp/crdZ
 pErVYA==
X-Received: by 2002:a05:6000:2081:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3a4f89e24cdmr7322676f8f.58.1748791542156; 
 Sun, 01 Jun 2025 08:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbn7SNkqkwQkezZ6BMt+88VKRXG8VoV605MoI+hrbiIw77ASu2786aHzCTSinvh8ZyhvDjsA==
X-Received: by 2002:a05:6000:2081:b0:3a4:ddde:13e4 with SMTP id
 ffacd0b85a97d-3a4f89e24cdmr7322650f8f.58.1748791541655; 
 Sun, 01 Jun 2025 08:25:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972f3sm11975637f8f.69.2025.06.01.08.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:40 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/31] tests/acpi: Remove stale allowed tables
Message-ID: <a0b833559ca19cbe0bbd7fa60106b7b6686d7617.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Remove stale allowed tables for LoongArch virt machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250520130806.767181-2-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bad1380eec..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,9 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/APIC",
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/FACP",
-"tests/data/acpi/loongarch64/virt/MCFG",
-"tests/data/acpi/loongarch64/virt/PPTT",
-"tests/data/acpi/loongarch64/virt/SLIT",
-"tests/data/acpi/loongarch64/virt/SPCR",
-"tests/data/acpi/loongarch64/virt/SRAT",
-- 
MST


