Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83316CD11DB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaV-0003DP-D3; Fri, 22 Mar 2024 10:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaT-0003Ch-IU
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaR-0003af-N3
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h++xHPlDfip5cmYx+i1JO+ppTMeDrZlDhdmAYT13zvY=;
 b=XD75vRJQamJXzMzAlGchEmuBkzBA9Oczcd2PFUFxxCk/SHVKPdhSfLEJeziBQITvbH6ssk
 KBsjnpuONs914DAoggDhFKYXGQ68aiXt5AFb8BqXMzQ67R9mNAUqTMYzjJi9GFw+kPIXol
 XjRgGHRCSFr+xl3/PM9PsP7Nw66aLDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-Wn36b7H7MyGg7pSEP1Rbhw-1; Fri, 22 Mar 2024 10:09:33 -0400
X-MC-Unique: Wn36b7H7MyGg7pSEP1Rbhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BBAD185A78E;
 Fri, 22 Mar 2024 14:09:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F026440C6CB5;
 Fri, 22 Mar 2024 14:09:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF45921E5D2C; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 06/12] qapi: Fix typo in request-ebpf documentation
Date: Fri, 22 Mar 2024 15:09:04 +0100
Message-ID: <20240322140910.328840-7-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ebpf.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index f413d00154..61359e1c0f 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -51,7 +51,7 @@
 # @request-ebpf:
 #
 # Retrieve an eBPF object that can be loaded with libbpf.  Management
-# applications (g.e. libvirt) may load it and pass file descriptors to
+# applications (e.g. libvirt) may load it and pass file descriptors to
 # QEMU, so they can run running QEMU without BPF capabilities.
 #
 # @id: The ID of the program to return.
-- 
2.44.0


