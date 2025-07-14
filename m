Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD6DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMX-0003gN-U1; Mon, 14 Jul 2025 19:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJ7-0004sO-9o
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJ4-0005y9-II
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=enHLUCrIsqLlC37PkazjlZZO0bUiUz91Xpv6x/79LBQ=;
 b=SAYELPntGlkkzb8QsChWmq5HvcSXO/jOOajh/2G9FYZuFiRO9U897hI1eemMqWRh/tX5KD
 /XwxNyYUvXRWzOhWtMEIORbAqz1vSO0hrOrKq8dDnICWZRa4OCp5xuNNq4pNYFjWl30PAc
 EAv4sprqLv/QkLYwCzCuOYGxsIsCw7g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-knGXwjBiMrOxrLttscmjkw-1; Mon, 14 Jul 2025 19:09:56 -0400
X-MC-Unique: knGXwjBiMrOxrLttscmjkw-1
X-Mimecast-MFC-AGG-ID: knGXwjBiMrOxrLttscmjkw_1752534595
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b5f97cb8fbso811858f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534595; x=1753139395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enHLUCrIsqLlC37PkazjlZZO0bUiUz91Xpv6x/79LBQ=;
 b=EJmtZkGw2zSiS8XbJfmR6M90nXql1KofhydpJKwm+H3TiP2rXVdoCjr8hIpHjX8nPD
 DPZpio2OptOpP9suP3GKDVAAU6frXbSrJvIec88edtvXFg7PeM6OddArUhDM7bWMp+y8
 WM/JBy+Tc0tc850ElaDUVoRHZG5toECrtN/J3NvIILJ/dEKhQbYGxy5SFRY9IfTSTfox
 s5P7MDtJvYMolxtkB40mdANhvcs2vLcNmciGjjxJiolPMYZNwaxbdJC/dGgv7c6HcbCc
 q1h6zeagZCULLaMN1hCPmwFPQ6JnjrVRiB1rtyNjlDRd9he0FyZvIyuA/6NNXzEMtRba
 SdNA==
X-Gm-Message-State: AOJu0YyNJkslEeC/PlnuFrp8PYhS9b8ls3d+JvMOy/xpVdE9xPU6JCCL
 iruijq+Ln8gYYnsKXbHxoiTwKJ4bn7v21ZZRaP2iAiKnRQ9vqfLbKkuZtrs5DiaEPCD8FkcRdQW
 m3Hf48A2UxQ+KS3phPFYOn8pCvPXS3UdCrDF5A9lb3p3CzHjYVtyMfGHxq6VOgnN2sz9fopgRJC
 lOK5HBTPm5kSXDQEh1jd5PprCzcLxniOnhVg==
X-Gm-Gg: ASbGncsSofjQDPT4iySTOTRaPSeb3le1jhZZT55etD4p+rfmfmmNci+AkeQVi0X/ePy
 ax3DZq8vr8rrdomsNmkW/8AUIYesxNX/lNzw1raQ/0q4Sc0rGFeFi1mZ/aN9Q9+0Q8Z9Z9+juI8
 UdeSqLwV2aqs/nAHUhrzFTPDfxFj/Y8V4CE1ReIMcq68QDmgCge91MLcK+RwpAOUU2TiZvuGqSm
 UJDfu6uAu3YPqeQkymZd2NvWDRWTr84ETTJCsn8hnLOwdCHS54ZjnQIPpfhVJHSS5th464leuZs
 LBtT7WIloBZiTGIfv2BeMsm+unIG1g8T
X-Received: by 2002:a05:6000:2a0f:b0:3b6:8f6:e5e1 with SMTP id
 ffacd0b85a97d-3b608f6e699mr1013011f8f.27.1752534594870; 
 Mon, 14 Jul 2025 16:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZFIW+W6R2vMeFwMsMH92dsSKWGowDaG3SDcU3c/er7P2OU9r1O7+CB+qMgQdwtdYngkKNA==
X-Received: by 2002:a05:6000:2a0f:b0:3b6:8f6:e5e1 with SMTP id
 ffacd0b85a97d-3b608f6e699mr1012991f8f.27.1752534594410; 
 Mon, 14 Jul 2025 16:09:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e285sm13357594f8f.76.2025.07.14.16.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:54 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alireza Sanaee <alireza.sanaee@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 83/97] tests: virt: Allow changes to PPTT test table
Message-ID: <117ca1d6e59015aac16aa73f866829fdf15bb372.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yicong Yang <yangyicong@hisilicon.com>

Allow changes to PPTT test table, preparing for adding identical
implementation flags support and for adding a root node for all
the system.

This is related to both loongarch64 and aarch64.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-Id: <20250714173146.511-2-alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..5c3ff47748 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/PPTT",
+"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/PPTT.topology",
+"tests/data/acpi/loongarch64/virt/PPTT",
+"tests/data/acpi/loongarch64/virt/PPTT.topology",
-- 
MST


