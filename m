Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875E2C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJT-0005YN-J9; Mon, 14 Jul 2025 19:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIF-0002WR-SO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIE-0005oH-F5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mk9mKZgFjAYJwELNbZOkW/ell0njkShYeNK1NqBrpwg=;
 b=PC/3H+EKDBIZM8nBeZHeF7hEOwp1MFUSpe6rQDpxDvWrsM4Wf9hosfza//FK3ZJfZBId9Q
 0mR+1LB4czX/Sfi6hSUhrjzvVkyYv472FzQx6mH6zhb6im3002Bnhjr4Jeou2BQeQzIXNL
 xhkTbnne8LP6Bu99d8eifK5UMWlTNwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-1ZHpUTPjNGi8QnfdJm41PA-1; Mon, 14 Jul 2025 19:09:04 -0400
X-MC-Unique: 1ZHpUTPjNGi8QnfdJm41PA-1
X-Mimecast-MFC-AGG-ID: 1ZHpUTPjNGi8QnfdJm41PA_1752534543
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453817323afso30144445e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534543; x=1753139343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mk9mKZgFjAYJwELNbZOkW/ell0njkShYeNK1NqBrpwg=;
 b=O7MD1YD4UqN6TVJYXIZ7sfmH30Xly7NvrtdFDrEVsoZ1bo5ikNhs1xsZFmTptJAxAR
 WTzhDoSjdSvq4/NxVW7lQaFxfEjKijAiCF6ex1E0OMV7LGHy/BI37/2dPA68kp+VKQYU
 OtN1NOHWOBVINImR+yqrWfHte4+Kb2XkcGMzwVnpUNCEq2oxPLAf0F3XwYhR+dvfH+NZ
 PiExhrXFY8tB+efqQQbhJnSvDlUTq8ojQBLVYHcpyEqUH5t8DS0L1CVQ5l0Fg0JyOxBR
 nzAHS8jt2gYezfdaaHPT2CDZV383/hC4ZLKAEMQiNNlzsjJEV9bWF5sh5X+juVr9nXLg
 W4CQ==
X-Gm-Message-State: AOJu0YzlODtUidxvhZNwXhdsAfcSKNkdWKPP9gye1F0EG5wlbsXKTPg6
 IMqMpVGf+LZcHyd1R9ETMS0pLs2+Qb6zD/GJylagIaGLwQhPpsSZV6LXguMwR9GJAkz/AYBMdzg
 SqUjtSK82MzDS8PzTBsNiUWGwHITZd1clth8iNLJi2xlDVBWMuPGZY3KTVcIb9yGVde5ON6XK/O
 mDF/uwonCE9BYIuKqluFjbr75H5dGzHUOVtg==
X-Gm-Gg: ASbGncsIi4pYybcyTOO9excbkCFP9EGz5hSH/9Ig8Qq9Cpg3h66NYK6Ibxo8p+Rbm2F
 jRs8TMSapiy3ATU8hm+Umf8Ggnvm13UaD7OXexYbzf+UZL03SwvoxqwovXMllFcEet5mqdfKhKv
 A93jtvT//otM5QH9ZD9SHAvF9CnmyRPOq+AhrQuXPjJWv9OdKZ5OyQBaS68DnZ4HjegkRq/fSyD
 S1yTJZ/aVPruiC/A+AH1ef2wM8AZJU8JXLr+DhGAW3ehGQ60KfJJTR0p9PLI4i48bUEVxBs/OJD
 SMv8XNm05yKWMtal2zaSqxs2fbnQC/JA
X-Received: by 2002:a05:600c:8b85:b0:456:11db:2f1e with SMTP id
 5b1f17b1804b1-45611db3291mr74639915e9.15.1752534543199; 
 Mon, 14 Jul 2025 16:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNlHrHVO2tQeygkjz5f2bEmmwhkGoJIq8ofS8pK47BUolgsBc+2GRSnq/+22mJ4C7ZbPvgew==
X-Received: by 2002:a05:600c:8b85:b0:456:11db:2f1e with SMTP id
 5b1f17b1804b1-45611db3291mr74639705e9.15.1752534542785; 
 Mon, 14 Jul 2025 16:09:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45610a39cacsm69274645e9.38.2025.07.14.16.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:01 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 64/97] qtest/bios-tables-test: Add a variant to the aarch64
 viot test
Message-ID: <988af0a097e0f2c6118f94ebbfc742799b9e0457.1752534227.git.mst@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-19-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e988deac02..4701975c05 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2275,6 +2275,7 @@ static void test_acpi_aarch64_virt_viot(void)
     test_data data = {
         .machine = "virt",
         .arch = "aarch64",
+        .variant = ".viot",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
-- 
MST


