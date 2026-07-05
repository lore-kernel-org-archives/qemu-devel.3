Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63CAC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwC-0005FP-Df; Sun, 05 Jul 2026 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwA-0005F0-BF
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNw8-00019l-TS
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gOig7T9TXJk8k/eyxbncF441hI8NL8jYn2f6MBx/XUc=;
 b=Gllkhg7wqiIjj4kAurGHhdB23jK9zYBQc/y2vqIMpg+f1iJqLAOsZNxdfhC4K93o6Nnr3Y
 lg7z/vBAiip6JXrvlyTjxqXOhjyF/BXmNvsmeUnwUlsaeF6lAnSiQlRanz18QNhwM6r4cH
 J+dJJzzLWFFxFscaWL4eR1bmck7XyN0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-TxRHWTEaMs2BRh6-uK_Olw-1; Sun, 05 Jul 2026 10:35:10 -0400
X-MC-Unique: TxRHWTEaMs2BRh6-uK_Olw-1
X-Mimecast-MFC-AGG-ID: TxRHWTEaMs2BRh6-uK_Olw_1783262109
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493d88406cdso1969745e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262109; x=1783866909; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gOig7T9TXJk8k/eyxbncF441hI8NL8jYn2f6MBx/XUc=;
 b=JLkSAn7k82F0llBCAF92SQLVneZO5ocvhIdQyiXZfiGAGpi1dlYzgat2szs9ZdHHRM
 ZJLlLx2Aqu6JeqlaRP/mfe0qXOEchyuM2lxFZrHgXD6x0RqkgRtIZsxIN1/39Pmoir+k
 kAW9Dhpa8cpROdsy6KFuRz6ROr3UIlU/QtF4U/CiCQmvuQ1UcKXIBWgGotSewL/X8Ff4
 3nNnc+QRj7847bw0/XS8AhAIdTm37p/EWCnzVGaeJ/KQiJLs/yCb/o8L8og9wiHuJbqd
 PNFyJdHpI4JreiUTSTFrebb1CrhrF0Fa/0ePQL3XznyEbqeXSvJZqGzL3QW9LxG2crAH
 MsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262109; x=1783866909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOig7T9TXJk8k/eyxbncF441hI8NL8jYn2f6MBx/XUc=;
 b=SOmgxIPAxgztpGpBy6Rxx3cdL1ohImdX66ymEjqdiZyacmJ/1rHtmRpoEkHd82bX+o
 SIUmUWmA1KUb8d8qqG6EuVIpscdPLzfhEUNIna0NaN+VU6Jg/We/n3D3BN87U8DNlVaL
 z+Z+fp2N4yFem1ZwddulcHrdI5bTQCvn+oL5N8nZDCtA/r1t0iuJHf1+IKv1MHft8vvv
 ILUQQ2T29zypmaMPSyJ8IomgDEIG8KV4YYpWx13Fu41m8C4UoiXFVDktStQqMjU9as6l
 Mu3fJySBcsk3F7ki1UOYsn06IQ7J49rMPH0kCYD/yffV/GQzJe79bUKG5trPqKjy4JgW
 WIjA==
X-Gm-Message-State: AOJu0Yxrpuiku/X+23tEFO/ce4/xib2EOb2GsuN+J1DEPbmVEvzzI0ZB
 YN/c7uJvsT1jszaYjL78/2WTJAVUacKRsnsD/yYp/nVEDng+sS/YEUhsk9QI8hP5Y98ADRaADF+
 wCRSqo63wdenVUE+ce6/TCzTIBDa7yF14Io8QxoDgzlGazqryAtSjtpojdx7TmjG9A/4S0X36HS
 H3LTJ/WkRWHnjK5zbZSw2VisjeD7V/sp8r/A==
X-Gm-Gg: AfdE7clCNM+CKNCxsESND67Y8yBzpG5jVNkwOxBhaPmHfKs5JKSzi6Eknxxb18EA6tw
 wcyqAkgotqYLfhC73Wkj628eYqn5wUojkYN/wDWCV/Y83xH3gxj/KRoM3fmW7UznJlZSIhmqOpQ
 EbK7v7c11wtX8izFPI9Yzl2UwGqtr2V1OBKShP18BGOREj8MweOQ+CuGQ3uLzSsYt5uKI63HKm6
 mtZv1M1Oy7hCImX4qUcAATpdR3LQUdad4hCBLTN/uHjeZ3nNzfhE3jk+g3xzCNHidjyoYelIy6t
 kj8x/+mlefTaBTPxmcDI25uelubrcP24nq1uHTOUiZSqreYOsypp+9Gqfytyre/lO8XpA7795r6
 AQeLJkgdRieW9A+j8UhOdQAPsDPoxS3/A
X-Received: by 2002:a05:600c:4e4c:b0:492:46c3:c7dc with SMTP id
 5b1f17b1804b1-493d11d6895mr80163925e9.14.1783262109407; 
 Sun, 05 Jul 2026 07:35:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4c:b0:492:46c3:c7dc with SMTP id
 5b1f17b1804b1-493d11d6895mr80163545e9.14.1783262108822; 
 Sun, 05 Jul 2026 07:35:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm16514324f8f.27.2026.07.05.07.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:07 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 11/44] tests/acpi: add empty expected blobs for sp-mem SRAT test
Message-ID: <54f0db2f592af764d329892bd85bd35fa03bde52.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Add empty SRAT.spmem and DSDT.spmem stubs and list them in
bios-tables-test-allowed-diff.h.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-7-FangSheng.Huang@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 tests/data/acpi/x86/q35/DSDT.spmem          | 0
 tests/data/acpi/x86/q35/SRAT.spmem          | 0
 3 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
 create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..188003fa90 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/DSDT.spmem",
+"tests/data/acpi/x86/q35/SRAT.spmem",
diff --git a/tests/data/acpi/x86/q35/DSDT.spmem b/tests/data/acpi/x86/q35/DSDT.spmem
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/SRAT.spmem b/tests/data/acpi/x86/q35/SRAT.spmem
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


