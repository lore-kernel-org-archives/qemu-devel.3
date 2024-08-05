Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21E2C52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xk-0001yd-NL; Mon, 05 Aug 2024 17:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xQ-00018k-6Y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xO-00005N-9Q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ15q8CYPj6PTN7hDi0BIfIjd8VlCM6ctQu3O7D8jso=;
 b=HJcMEJPHvfFyqGQvt04xH3MBeBqEBcQYRQ1dNyQaq++mzPWfzt21ADutAS75lftu9glBjb
 FyxIrwQSaZY9oPiVnsyEFX8ZVxB+kYtqxhBhHOCgrE9oeR+LObXMQ0M596ApC+aroqtqyC
 XbhWiQh+AniiCjtnKRJMDsGAHlcvgAM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-WVYWbzNNN6S7Sqcvf7mejg-1; Mon,
 05 Aug 2024 17:09:25 -0400
X-MC-Unique: WVYWbzNNN6S7Sqcvf7mejg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8940B19560B3; Mon,  5 Aug 2024 21:09:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 626D130001B4; Mon,  5 Aug 2024 21:09:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/13] iotests/024: exclude 'backing file format' field from
 the output
Date: Mon,  5 Aug 2024 23:08:51 +0200
Message-ID: <20240805210851.314076-14-kwolf@redhat.com>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
References: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Apparently 'qemu-img info' doesn't report the backing file format field
for qed (as it does for qcow2):

$ qemu-img create -f qed base.qed 1M && qemu-img create -f qed -b base.qed -F qed top.qed 1M
$ qemu-img create -f qcow2 base.qcow2 1M && qemu-img create -f qcow2 -b base.qcow2 -F qcow2 top.qcow2 1M
$ qemu-img info top.qed | grep 'backing file format'
$ qemu-img info top.qcow2 | grep 'backing file format'
backing file format: qcow2

This leads to the 024 test failure with -qed.  Let's just filter the
field out and exclude it from the output.

This is a fixup for the commit f93e65ee51 ("iotests/{024, 271}: add
testcases for qemu-img rebase").

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20240730094701.790624-1-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/024     | 2 +-
 tests/qemu-iotests/024.out | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 285f17e79f..b29c76e161 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -283,7 +283,7 @@ TEST_IMG=$BASE_OLD _make_test_img -b "$BASE_NEW" -F $IMGFMT \
 CLUSTER_SIZE=$(( CLUSTER_SIZE * 2 )) TEST_IMG=$OVERLAY \
     _make_test_img -b "$BASE_OLD" -F $IMGFMT $(( CLUSTER_SIZE * 6 ))
 
-TEST_IMG=$OVERLAY _img_info
+TEST_IMG=$OVERLAY _img_info | grep -v '^backing file format:'
 
 echo
 echo "Fill backing files with data"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index e1e8eea863..3d1e31927a 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -214,7 +214,6 @@ file format: IMGFMT
 virtual size: 384 KiB (393216 bytes)
 cluster_size: 131072
 backing file: TEST_DIR/subdir/t.IMGFMT.base_old
-backing file format: IMGFMT
 
 Fill backing files with data
 
-- 
2.45.2


