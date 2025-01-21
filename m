Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD8C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBd8-000154-3n; Tue, 21 Jan 2025 05:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBd5-00014g-TE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:37:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBd3-0002US-H3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737455824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VQChVu75/3ZQaqIgYWZRr2JIP1bFgv7t4cXvNk/i71k=;
 b=WBplcP8fAP0ndbsyDy1J6gBMN9PKlwYeE/RwxW8jA152AfumKE15wfickvntNVNOnhbmCS
 wz7xN9QLDDceqljYYMRsOcwfwi+fw5zYCN7hfMuoO+CZPAOCnZue1zdUVyd2vRaKV38aZl
 F8c/Dv2oioQ+1gMSP5Qg1xFiL0ktGzg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-kx7CzkljMDqWEDaIB4_evA-1; Tue,
 21 Jan 2025 05:37:01 -0500
X-MC-Unique: kx7CzkljMDqWEDaIB4_evA-1
X-Mimecast-MFC-AGG-ID: kx7CzkljMDqWEDaIB4_evA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 621661955DD0; Tue, 21 Jan 2025 10:36:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0E3E195608E; Tue, 21 Jan 2025 10:36:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] mips: Mark the "mipssim" machine as deprecated
Date: Tue, 21 Jan 2025 11:36:55 +0100
Message-ID: <20250121103655.1285596-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

We are not aware of anybody still using this machine, support for it
has been withdrawn from the Linux kernel (i.e. there also won't be
any future development anymore), and we are not aware of any binaries
online that could be used for regression testing to avoid that the
machine bitrots ... thus let's mark it as deprecated now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 If anybody is still using this machine, please speak up now!

 docs/about/deprecated.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..133c8bab93 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
 Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
 CPUs. Big endian support is not tested.
 
+Mips ``mipssim`` machine (since 10.0)
+'''''''''''''''''''''''''''''''''''''
+
+Linux dropped support for this virtual machine type in kernel v3.7, and
+there does not seem to be anybody around who is still using this board
+in QEMU: Most former MIPS-related people are working on other architectures
+in their everyday job nowadays, and we are also not aware of anybody still
+using old binaries with this board (i.e. there is also no binary available
+online to check that this board did not completely bitrot yet). It is
+recommended to use another MIPS machine for future MIPS code development
+instead.
+
+
 Backend options
 ---------------
 
-- 
2.48.1


