Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83058C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 03:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdhy8-0002qr-NT; Mon, 12 Aug 2024 23:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sdhy5-0002pk-Jo
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 23:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sdhy3-0005AN-H1
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 23:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723518781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+MOyerQ6LGBbtNiKWN/Sfz4ev/ifIHnxwK7saf6D60U=;
 b=UHRWgv6bwuXzDvv4ITyFoW+0o7JLcvgu2Wg6axBgnwNfo+NLEcQIHFfRsi6I4Q3EFf80On
 OIO+hvUxWivEozGgAJqymUWp4v7+Sh+3cdOExJDiST4EOOVRPVb9sbkhnapk+VqVBWoWst
 rDOEqEO86tQl+4/GYu4N5J3Z++19+kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-tRIzk0RhM4G2AXcX0FgIoA-1; Mon,
 12 Aug 2024 23:11:27 -0400
X-MC-Unique: tRIzk0RhM4G2AXcX0FgIoA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41D681955F3D
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:11:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D23E19560AA; Tue, 13 Aug 2024 03:11:20 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: mrezanin@redhat.com,
	demeng@redhat.com,
	kkostiuk@redhat.com
Subject: [PATCH] qemu-guest-agent: Update the logfile path of
 qga-fsfreeze-hook.log
Date: Tue, 13 Aug 2024 11:11:15 +0800
Message-Id: <20240813031115.129000-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Since '/var/log/qga-fsfreeze-hook.log' is not included to proper
selinux context 'system_u:object_r:virt_qemu_ga_log_t:s0', it
should be changed to '/var/log/qemu-ga/qga-fsfreeze-hook.log'

Jira: https://issues.redhat.com/browse/RHEL-52250
Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-agent/fsfreeze-hook
index 13aafd4845..98aad5e18b 100755
--- a/scripts/qemu-guest-agent/fsfreeze-hook
+++ b/scripts/qemu-guest-agent/fsfreeze-hook
@@ -7,7 +7,7 @@
 # "freeze" argument before the filesystem is frozen. And for fsfreeze-thaw
 # request, it is issued with "thaw" argument after filesystem is thawed.
 
-LOGFILE=/var/log/qga-fsfreeze-hook.log
+LOGFILE=/var/log/qemu-ga/qga-fsfreeze-hook.log
 FSFREEZE_D=$(dirname -- "$0")/fsfreeze-hook.d
 
 # Check whether file $1 is a backup or rpm-generated file and should be ignored
-- 
2.40.1


