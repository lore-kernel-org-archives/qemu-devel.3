Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C23C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkZF-0002MA-Fb; Sun, 01 Jun 2025 11:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZE-0002Lq-8z
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZC-0004eu-Rc
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCcFzUnshNhYktTkop8VCX4UTK6/NnsYDFGziFmlv1w=;
 b=NLBnEUmffBG0Qj63PJ9TLgT/rS9+RSF7a1WjqLW9RoINWJKVdV5cO1TP2UecT+ZklNrCXh
 EKWaKDPk7ijnHB4PwYIqRJJYgGZiZ8OqrdGFP/1dMkJhTruD3acXFvxJL4932eHZx+KXFe
 i3DmDwLG2gNYOdoKEik8LEDs4TZXUTE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-H8j0_FqxMMimrJH5NPm0ng-1; Sun, 01 Jun 2025 11:25:39 -0400
X-MC-Unique: H8j0_FqxMMimrJH5NPm0ng-1
X-Mimecast-MFC-AGG-ID: H8j0_FqxMMimrJH5NPm0ng_1748791538
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4517abcba41so6827645e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791537; x=1749396337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCcFzUnshNhYktTkop8VCX4UTK6/NnsYDFGziFmlv1w=;
 b=JD9DF9h+gFzSFQSeiMjvYewvx57+OO21GDp4hIluDiVVwxEEITaeBoAGB2/R1wj1G5
 qljt5ZQFySPHpMTkWojzANXVDmTeZu0M56DkExxQKPsjWWxm3p8aorIsbXTfoJODuGv4
 1jK+yv7BHUncO3bNAlao+QQn9LmX+EwJzOiJz1wPFV46zl3pJZiHHq8Rix+0Tvva1q32
 lqSfbVYvs+6PCtVXLrsdckoR8lM53r6Pjrn1Abx3XluqKMvqRVQcRczpwxNzeiaQuknn
 E6UOj3CplNlbyf1DMQJl8BskLBZ924v+/FEZNdAdDAahBJXqPMngGOigaz8cmV7wIPhx
 b68A==
X-Gm-Message-State: AOJu0Yx9wIO234ZfHNt+BhY92zjpCe1Ov2p4pfL/9ANQ/53Kt6IFz6cz
 LjK/2oqU2i6b/CwRumhkmRJw0M2cnhtC3NL4XNkymz7Dnm3aFTCw5GzH8Mluip23iX1gO8IqGYf
 pmcadzuJm7252B9BV48acdBUAmAgSSnWWOoC59aFi1rWoxe1JseqgzkKuRWeGwhCfrGqocm9Rt3
 QoW2s4hQ6jw8csoaDvIBbf99jRV36uPkxY9w==
X-Gm-Gg: ASbGncuCFsMvZnBi8irdJ4XyyeINwc0jIzdbphLX7/FYScC0CMloV8rUZgUm+RJ1JPV
 uIX19O4Okj+uFldrta3wpEqaEZx7ZwtfThd+9pK1DTwJz21ZCTH3CKUVPRp4ugC02uGh4btFqI4
 ygYxm99lkwMyft/nAXeprsCvYdWzwESslWtCApmAY8yG/ER18aCuLYANAFFcewsqwNVMslpNSu9
 uiQ1TCQzAHmiN9c4hdRTCDDadLr2UfcBFfR3dwdRGfK3fysv6JPoxRHpRWv0AJxVUiipOBdO9hn
 z8Vvag==
X-Received: by 2002:a05:600c:4fc8:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-450d882b1ebmr66486755e9.1.1748791537450; 
 Sun, 01 Jun 2025 08:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0JqPlPg8/OWHDaMlBOn7ob7cLeFFcYuoKjJfKUzk6TIBFkIvM7dWfMpLlJsQbDL+imYemaA==
X-Received: by 2002:a05:600c:4fc8:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-450d882b1ebmr66486575e9.1.1748791537009; 
 Sun, 01 Jun 2025 08:25:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f9efa3sm87656715e9.9.2025.06.01.08.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:25:36 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 20/31] rebuild-expected-aml.sh: Add support for LoongArch
Message-ID: <8e35af507ad97a43a350be4805ade2dea9c2a251.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Bibo Mao <maobibo@loongson.cn>

Update the list of supported architectures to include LoongArch.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250520130158.767083-7-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index c1092fb8ba..cbf9ffe0dd 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_arches="x86_64 aarch64 riscv64"
+qemu_arches="x86_64 aarch64 riscv64 loongarch64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -37,7 +37,7 @@ if [ -z "$qemu_bins" ]; then
     echo "Only the following architectures are currently supported: $qemu_arches"
     echo "None of these configured!"
     echo "To fix, run configure \
-         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
+         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu,loongarch64-softmmu"
     exit 1;
 fi
 
-- 
MST


