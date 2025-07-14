Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB20EC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSJz-0006C9-CD; Mon, 14 Jul 2025 19:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIM-0002lu-4M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIK-0005p5-Bq
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vkLKjSQD4q3ibgj4rK/BB/V8wVj/Bt38mK7Hzew+pao=;
 b=RgR+7CdG5qC4V5OvylliwM+zUYmAx9ILpWznh7pwCMLfLVo5Kn8vLCcyhn7ibgIkwxck3e
 /WKcEYP6mluunNRedLT77Uqe8tELpLE2u3Wx/TISjv57BHgx1npRD+fZ0UQsMt88T9km8i
 1Y+rFihu6m4pcrvL+hFCFWmYhfyljCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191--_6JxA4VPIW0iPfHL35EBQ-1; Mon, 14 Jul 2025 19:09:10 -0400
X-MC-Unique: -_6JxA4VPIW0iPfHL35EBQ-1
X-Mimecast-MFC-AGG-ID: -_6JxA4VPIW0iPfHL35EBQ_1752534549
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a579058758so1906076f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534549; x=1753139349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkLKjSQD4q3ibgj4rK/BB/V8wVj/Bt38mK7Hzew+pao=;
 b=F1u1uiD5LLLvKB4tkoccyW6T1bXX7dn0kJOb0p1L6uQ8iav8GwYco4AVbvrYtRojt5
 CK702GclayHz2WQ/X7toJWz39X9AkXuEKS2G/ENMplQvKcP8dtZ2tdm23cHbbtVIgF11
 Yp0FtrdsdGyTm396pWOvTNNPc3uSWw+9xrxkUS8WGM3Pid+8ev73JOUgmiVj4ekIKmZK
 g0m6lwYTJxKdPRlCsGR4rR2dzsH/+vrP2dRqVWP2lSCl/2f9jp8usDGoL3dQSlghP6aJ
 oK7Ly2iwvaEJRZOqFSFboud3JeJ2XM4jp73b0bbAm4fhsXdaAOUsocII9nO33ATivVGx
 ruzw==
X-Gm-Message-State: AOJu0YzM0c06wBw6+Kh1X97N/SFsxNNUVNOdRRu7npCp8QFigoI7+7nd
 mlIbS9jwwrOw7KE3nKih72P48zLlsNXdpFdI5bEWldOBIzjadReGEhj9z9din58r6c9jRGU87eQ
 tQeY4yOwt1nD50U9MeeT6Cf8QF9dfhvxFF0ASOnJ7MMuoPinl7/B225qBqZ3C9+6dHWnbj4u+xD
 aCT3gQwMTjYc+1pPX5CITG51pRedF/WE1mZw==
X-Gm-Gg: ASbGnct09Iq11cePJ6COju9P6OGgzmyfswkbE0t9IELfCL7PgjkDERjIgMGBnsULgOC
 ymOb3GWW4Yuyw60I1vtiTt5OkEZE+M/BpP3tJFaBB8QXabxSQNQ5ZkylKl4RWXLFOfgmb6HdXCk
 OLX8aXOg5mm6tju8/ja+oDUZYD7xMTznoZcSeLDDOmuQpHapICybXlhC3jb0v6BWZlHGx79JXW7
 oMCnieeFweXDs3y4egpXcSfN5uS//nguFD/9+B3HgqR8i18ewE0ogo9e/ENS7H7OtTvQ/Zx4X7v
 085YcH8Rn5rfDfFKdsBkKIR0zWsSBpbJ
X-Received: by 2002:a05:6000:2110:b0:3a5:39ee:2619 with SMTP id
 ffacd0b85a97d-3b5f18eb674mr9949845f8f.47.1752534548802; 
 Mon, 14 Jul 2025 16:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAt1O2/sCEjT+OkJeSHrZL4Ta8F85I7UbSKgoOB2S4oBnYybrmdYuG4xVtp+6wfTuBnjqQ+Q==
X-Received: by 2002:a05:6000:2110:b0:3a5:39ee:2619 with SMTP id
 ffacd0b85a97d-3b5f18eb674mr9949832f8f.47.1752534548420; 
 Mon, 14 Jul 2025 16:09:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1997sm13798384f8f.10.2025.07.14.16.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:07 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 66/97] tests/qtest/bios-tables-test: Prepare for changes in
 the arm virt DSDT table
Message-ID: <f3566c4c4995f2c7e6d32de0b540d47ea006eaff.1752534227.git.mst@redhat.com>
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

From: Gustavo Romero <gustavo.romero@linaro.org>

This commit adds DSDT blobs to the whilelist in the prospect to
allow changes in the arm virt DSDT method.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-21-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..023fbc6059 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
-- 
MST


