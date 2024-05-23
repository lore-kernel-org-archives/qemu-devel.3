Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06945C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 13:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8ZR-00087c-PQ; Thu, 23 May 2024 09:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA8ZG-00084s-Tl
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA8ZE-00037D-EH
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716471190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=L06W4+rp4bkZNAQDpDimpwNX4jiUGU7n0RPt7dhyjjM=;
 b=ReHT3o3XbyDKGnPmvf64iHBDHYk31wuw0HRPx6xHm5qz+fepHtBuvA+mtmswPxhUtd0Rmk
 vMnkhV9QsyIulrnkYMcFMRaNE3uwaaqIc4OP/il6iGKTxDWFOa5ZtGU77h3UKcRnL3f2nd
 /z2dNXKFSV22ILfe/dwXbXknXPz4lIc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-34kdeUGzNMalR29DREj-mQ-1; Thu, 23 May 2024 09:33:08 -0400
X-MC-Unique: 34kdeUGzNMalR29DREj-mQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c9a9449072so1344678b6e.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 06:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716471187; x=1717075987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L06W4+rp4bkZNAQDpDimpwNX4jiUGU7n0RPt7dhyjjM=;
 b=MjicEizdgsYaT10mpQpdFox95HIekHDRs0VcZP/WPGIKiFg6GLroy1GuGRHvO8cqNu
 nVtAB9FP5RDiVHHZ4lIJ/CQvIdO25drr9CbeDMCFUm1+ResLq+MbBKe3cg4ssDAILDwl
 JD2sdatMkNOr8juax/vE9bIi3fxwudLwy4itTVIL8/vcbwcHZUb98e73JeX1FCEyQ9qd
 p55GOZyTzV/Lq5jCk3EgOBrt0ClANh9+X2juTQ359K9aT/gafM7vHuOZO2DlySc4TeIn
 PcL4geTlWldqESIvDy+wNUFLd86o9EOsLzY5R+gvUR9Q6Fqtfr4sE2HQM7BFN58s5LTY
 ykFQ==
X-Gm-Message-State: AOJu0YxcAoLswZ0+uCXb3d0qsEfHi+V/OMEzDy6SAvya5E+x1rRFccyx
 VBNJ+iJaF93BMn3EPjwUlDXVgLXcLUt6pa+WOVj8TFDN7OyN6FPV1zK+3yKClb/AuP6OiWxlcbz
 LuFV3HN51X+5YHtDMIiPxiIcm+urQnA6VdOe2zOARuJEKI7OiO81ax1woIVT+Ot2v00wTdgtA0+
 Q6xgRFbuiE40Ps1J8pHb9/2ZXNOP5SdswuU/Pn
X-Received: by 2002:a05:6808:1247:b0:3c9:956f:889 with SMTP id
 5614622812f47-3cdbb150913mr6048491b6e.51.1716471187604; 
 Thu, 23 May 2024 06:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfam8oJbcF7hZO02XeqrFRPdVckEiWDWS3iGCIqn3QuXXkbMaGDq29z4eVjSnHv24UoP7oCw==
X-Received: by 2002:a05:6808:1247:b0:3c9:956f:889 with SMTP id
 5614622812f47-3cdbb150913mr6048448b6e.51.1716471187221; 
 Thu, 23 May 2024 06:33:07 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf340b32sm1499254685a.126.2024.05.23.06.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 06:33:05 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] qapi: clarify that the default is backend dependent
Date: Thu, 23 May 2024 15:33:02 +0200
Message-ID: <20240523133302.103858-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The default value of the @share option of the @MemoryBackendProperties
eally depends on the backend type, so let's document it explicitly and
add the default value where it was missing.

Cc: David Hildenbrand <david@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
I followed how we document @share in memfd and epc, but I don't like it
very much, I just can't think of a better way, so if you have a suggestion
I can change them in all of them.

Thanks,
Stefano
---
 qapi/qom.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785..8463bd32a2 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -600,7 +600,7 @@
 #     preallocation threads (default: none) (since 7.2)
 #
 # @share: if false, the memory is private to QEMU; if true, it is
-#     shared (default: false)
+#     shared (default depends on the backend type)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -639,6 +639,8 @@
 #
 # Properties for memory-backend-file objects.
 #
+# The @share boolean option is false by default with file.
+#
 # @align: the base address alignment when QEMU mmap(2)s @mem-path.
 #     Some backend stores specified by @mem-path require an alignment
 #     different than the default one used by QEMU, e.g. the device DAX
-- 
2.45.1


