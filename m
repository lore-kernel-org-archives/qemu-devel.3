Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBBBCCD185
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFK-00022y-5Z; Sun, 05 Oct 2025 15:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UER-0007yQ-5P
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEN-0006Tx-2t
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnDfxrNxACMbmdDqRpMpScz5AxDAbZ6usd6ALPkfGkQ=;
 b=NgOBKs/9oPJTZrYba9p+Zx2fMkkxebwwge/Ic1+Z0zyHSMNjRqUFbLYRzYJiSfe+CKVTWi
 LF8Igyq+CCNgRa3YNLdBmRu+VivjQ66U7h9ebhqZ5Y1cJ2ec0FSW4BTXF795vUSSEvZErb
 PSp/SmA6X4uH3Yad3OSllbqqRWxpIU0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-YFcK4520NjWG-K9V2jcfJA-1; Sun, 05 Oct 2025 15:17:12 -0400
X-MC-Unique: YFcK4520NjWG-K9V2jcfJA-1
X-Mimecast-MFC-AGG-ID: YFcK4520NjWG-K9V2jcfJA_1759691831
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so2461279f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691831; x=1760296631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnDfxrNxACMbmdDqRpMpScz5AxDAbZ6usd6ALPkfGkQ=;
 b=j5rHl0SnJ8MFgi8ZHvTnmcmUGhiq5Q/nQZgHwnuf4NuEzjLjgP+sxSAaMyvhsmuDhR
 4VcEKsyNqAhaVpbx5rsNMJ1Y9jt7cDQcf4ZSmR7ODCIMjM56hToZMsWLkA707daBuDxp
 obsNaobvzWcOJ5+paCF27VsIUF3Tki3groExx0HP445Z2GKfGqiEUaYjVWHZZ6xbFbJn
 FcdzPPVQgeizOHBdKi3drza2X2JOWoWiE3PrSs6euwf06FbOukTPAaPQimbzw17FDo/d
 6UQVbhqa4UXAHiUZqpl68rpwGC3LAUnUWoncAs3Gx3C8QVobmoFtvkMar5gMsR6EO+4w
 LNYQ==
X-Gm-Message-State: AOJu0YwNxC3QNUVJ/Xafx5s9X99cLy8h2SCeLVzi3bh6qwcuteh8B9P/
 QYhdMCcj4kxCM63c7YQz6NAbWCNTjc+vXhjKbt026NhNxfFP0qO49r/2MDK0vjmHusFNMH5+SDZ
 aFwkHsI8QwzTOADKOTF+0kfaMcO1CNj8AISctyPnG7wf6r+Q6mgAJhAmJU8acAKp5A6ACrh7Kpi
 wOeVWinHWVCg5WckZUD+c4o3CgwzfRCPBg7A==
X-Gm-Gg: ASbGnct1GqZAvkLPe68zfYApIFqaKKn4+3nse2QnBHXDUOzu9Xowa+VQuHfi0lFnMkd
 4nBGiLuun9Iyieysh+RVV6ZlUl01rJeaoGTcp1AyAip6Nx4weA44+Jo3gvMYwxICvC4h389N72R
 sPE615bG6gBtTGrU9ccMLP2Jj8n/caUz03TlAmqD7X4lm6WdEBHsXU6QZ+vWS+M2RaxqEpmORBG
 lEWzWNylgZTkwoeNyxKR3ASYNrRzxITyhtxLjq1gMosiawMxO5CnUYytQ8GnFzwvUTcNLHkZKWj
 IPOUCXhL1F5MOfDDNmg+u+WQT7w78lKliRIQgxw=
X-Received: by 2002:a05:600d:420d:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-46e71172104mr65548765e9.36.1759691830828; 
 Sun, 05 Oct 2025 12:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9KHgQKdExKVBqM1EG7cJqjJT/Waixo/3fiECA9mcAeyF3g2gDVdnVPPHr8FrKC3uk1qB7Lw==
X-Received: by 2002:a05:600d:420d:b0:45b:47e1:ef6d with SMTP id
 5b1f17b1804b1-46e71172104mr65548595e9.36.1759691830274; 
 Sun, 05 Oct 2025 12:17:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723432c9sm124149855e9.1.2025.10.05.12.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:09 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 30/75] docs: hest: add new "etc/acpi_table_hest_addr" and
 update workflow
Message-ID: <92aad3fc4a0f511819a18a443797069aff77b9ba.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While the HEST layout didn't change, there are some internal
changes related to how offsets are calculated and how memory error
events are triggered.

Update specs to reflect such changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <e3e8bd92ce40d997c67ac1d4d973c0041b8f59fc.1758610789.git.mchehab+huawei@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_hest_ghes.rst | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index c3e9f8d9a7..aaf7b1ad11 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -89,12 +89,21 @@ Design Details
     addresses in the "error_block_address" fields with a pointer to the
     respective "Error Status Data Block" in the "etc/hardware_errors" blob.
 
-(8) QEMU defines a third and write-only fw_cfg blob which is called
-    "etc/hardware_errors_addr". Through that blob, the firmware can send back
-    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
-    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
-    for the firmware. The firmware will write back the start address of
-    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
+(8) QEMU defines a third and write-only fw_cfg blob to store the location
+    where the error block offsets, read ack registers and CPER records are
+    stored.
+
+    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
+    contains a GPA for the beginning of "etc/hardware_errors".
+
+    Newer versions place the location at "etc/acpi_table_hest_addr",
+    pointing to the GPA of the HEST table.
+
+    Using above mentioned 'fw_cfg' files, the firmware can send back the
+    guest-side allocation addresses to QEMU. They contain a 8-byte entry.
+    QEMU generates a single WRITE_POINTER command for the firmware. The
+    firmware will write back the start address of either "etc/hardware_errors"
+    or HEST table at the corresponding fw_cfg file.
 
 (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
     "Error Status Data Block", guest memory, and then injects platform specific
@@ -105,8 +114,5 @@ Design Details
      kernel, on receiving notification, guest APEI driver could read the CPER error
      and take appropriate action.
 
-(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
-     find out "Error Status Data Block" entry corresponding to error source. So supported
-     source_id values should be assigned here and not be changed afterwards to make sure
-     that guest will write error into expected "Error Status Data Block" even if guest was
-     migrated to a newer QEMU.
+(11) kvm_arch_on_sigbus_vcpu() reports RAS errors via a SEA notifications,
+     when a SIGBUS event is triggered.
-- 
MST


