Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3D9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmT-0008Jz-GM; Sun, 21 Jul 2024 20:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglQ-0002Yw-K0
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglO-0005xL-DD
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0mtOB+kdXXWYOHCvpvehEzKr387KURYV1YXTFOFkqBM=;
 b=MmsLm4XwWGuY5lGHldHayci3aCCVVV0Pbv0k+JWECaYNSQi8UpW+HEz3lrPMNDaMTzKjX4
 Hbuw6MOGV06/ji6qV3DiYl52oBL2yp1mmb2sRJa4jsoiQQCglDm19ZTMr+ZIM80m9h/LW7
 XAeH/GtTxZ3PAVd/1ow0h29L4fRPx9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-ZYno_MHqO8WgTp5rNYwDrA-1; Sun, 21 Jul 2024 20:18:47 -0400
X-MC-Unique: ZYno_MHqO8WgTp5rNYwDrA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36832c7023bso1998783f8f.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607525; x=1722212325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mtOB+kdXXWYOHCvpvehEzKr387KURYV1YXTFOFkqBM=;
 b=twYLNhRH6AyWQ8rhJbn5M4mMFhcgbRhICRUN+UFirWSJgVw4n37cEK9gPiIyft1KBE
 92WUmyACtnxA6Rc86kVGz7x6uBAzKBjVUeRQrfe1AMZA0oXQx0s1SAzrm6L0GICidQ0/
 juCgvw5Cvjf7CRAngVv/KXgDI0AeGaQIB/YM4RYnsW54TXiPDCLg36h8dOYvWXTiAunH
 G7fNO3h3+2DqqaPOZ34/l77FMv2P4mrlHl+cenMBEDNA0uqddgPLvwo5APm1QcUi72ro
 suaEHzIZ3XZ+aEhUvSdeC9lXF38zl58evqxw51XEhW+U1NBzSyPsor2i/Cp//mmNItAN
 tl2Q==
X-Gm-Message-State: AOJu0Yxpn4YTTmeMVKrVtHxHT/Mf2iO8yOMrCCXKVVAMlwK2btzvdqAF
 AINsaoAlrSbhjAcFYQT6Am2WZxdfDqsseFKmvNp4YYjUylv7RnTNWSf0NSFvONu+dUYSV5tR/3I
 kgQES7pUTKCZhYgGnt9WRZyh59ydu7ch+8h+IQBGzSKP35EluIH/hbhJYs8o1ot7LfR+N+Gv4/D
 W5G9mLsb8VuHj7178e41aDargzaBGIWg==
X-Received: by 2002:adf:ed8d:0:b0:368:664a:d4f9 with SMTP id
 ffacd0b85a97d-369bae3654fmr3626642f8f.28.1721607525417; 
 Sun, 21 Jul 2024 17:18:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq4aisgZ8WlyYTytcvABA33osNBxKn0f+Wl26HpwGQNZUowaQ7sTphc2MToHO5QAEZNQG6QQ==
X-Received: by 2002:adf:ed8d:0:b0:368:664a:d4f9 with SMTP id
 ffacd0b85a97d-369bae3654fmr3626629f8f.28.1721607524921; 
 Sun, 21 Jul 2024 17:18:44 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684757sm7058218f8f.10.2024.07.21.17.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:44 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 53/63] tests/acpi: Allow DSDT acpi table changes for aarch64
Message-ID: <04fccb2e79edf00f0521efe364243a4f495df3b5.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Sunil V L <sunilvl@ventanamicro.com>

so that CI tests don't fail when those ACPI tables are updated in the
next patch. This is as per the documentation in bios-tables-tests.c.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-4-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9282ea0fb2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
MST


