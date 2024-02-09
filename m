Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00371C4829D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVS-0002dN-Rb; Fri, 09 Feb 2024 09:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVR-0002ct-Df
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVQ-0004Hb-2D
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UxxEopDNL4uBq4ENEkrUuGPqSNijZf7vnEWasyP4K0=;
 b=f4WzS5UhCjaOmHfyCRPKdn9I7mCtkA/mtiLxc6IlJHufexAq7JksEbPVyCChXFXwL3+JtR
 Vr6/pD6h+qm0Xe24uAtZvS1YiJEsd27JmQ98AIOe+khKsvcchGJl6LoE1TnQ+l47FlRok5
 QWDH6fbpHdrNwIWa9YMkCQGxiCip12s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-n4nqjXgtNFCA_fDztAByJg-1; Fri,
 09 Feb 2024 09:05:24 -0500
X-MC-Unique: n4nqjXgtNFCA_fDztAByJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75D6329AA3B7;
 Fri,  9 Feb 2024 14:05:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED37112A1;
 Fri,  9 Feb 2024 14:05:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/17] softmmu: remove obsolete comment about libvirt timeouts
Date: Fri,  9 Feb 2024 14:04:53 +0000
Message-ID: <20240209140505.2536635-6-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For a long time now, libvirt has pre-created the monitor connection
socket and passed the pre-opened FD into QEMU during startup. Thus
libvirt does not have any timeouts waiting for the monitor socket
to appear, it is immediately connected.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 95cd2d91c4..a82555ae15 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1914,7 +1914,6 @@ static bool object_create_early(const char *type)
      * Allocation of large amounts of memory may delay
      * chardev initialization for too long, and trigger timeouts
      * on software that waits for a monitor socket to be created
-     * (e.g. libvirt).
      */
     if (g_str_has_prefix(type, "memory-backend-")) {
         return false;
-- 
2.43.0


