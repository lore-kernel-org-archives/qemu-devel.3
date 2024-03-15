Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC662C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5T6-0000wY-NZ; Fri, 15 Mar 2024 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T5-0000vq-ED
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rl5T3-0006rH-Oi
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710501077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3J76+srI0y9x6WdENhqCOAiEhNSvhLsbyd+4+fGTwI=;
 b=SPwZmNrFAOLXUmW5k0nRl1MpKC8pkXIOPdDKhv8p5OL1n0xZF20F6/Q5T8W2QWf/+RkItz
 Srr8YBI/INGY1M9txk3l/OkH/n5wz60iTzGkpyKDNGHVZOEBesjWRWz9+38UyKNdsy8ezE
 yxoQr/1j5FIs9JveAZBnkKtQW+ucBwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-0B4upYqmM4OYfoNiilOWag-1; Fri, 15 Mar 2024 07:11:15 -0400
X-MC-Unique: 0B4upYqmM4OYfoNiilOWag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22EFF185A781;
 Fri, 15 Mar 2024 11:11:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19A372024517;
 Fri, 15 Mar 2024 11:11:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/9] tests/qemu-iotests: Restrict test 114 to the 'file'
 protocol
Date: Fri, 15 Mar 2024 12:11:02 +0100
Message-ID: <20240315111108.153201-4-thuth@redhat.com>
In-Reply-To: <20240315111108.153201-1-thuth@redhat.com>
References: <20240315111108.153201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

iotest 114 uses "truncate" and the qcow2.py script on the destination file,
which both cannot deal with URIs. Thus this test needs the "file" protocol,
otherwise it fails with an error message like this:

 truncate: cannot open 'ssh://127.0.0.1/tmp/qemu-build/tests/qemu-iotests/scratch/qcow2-ssh-114/t.qcow2.orig'
  for writing: No such file or directory

Thus mark this test for "file protocol only" accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/114 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index de6fd327ee..dccc71008b 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 # At least OpenBSD doesn't seem to have truncate
 _supported_os Linux
 # qcow2.py does not work too well with external data files
-- 
2.44.0


