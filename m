Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5032606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q5d451xq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=C4c/IB8U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryn-0006Th-4z; Mon, 19 Oct 2026 14:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryi-0006RR-PU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryh-0005q4-DK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DMCIM4SY6M+GNhaHaNHAs2jnIKCW5lF8AzgnG/Gl44=;
 b=Q5d451xqs2USq9ymPDD+klWZxC0pWEhiEvY4Q3R0jDnbcpqb1DZYuH/9pelxPNZzJOiMY6
 5XLYY9+QfAez++dhjGowqbqSgV7s8+24OgtpamJgsdnhLLxpFH+xswLCecUk+HX5awarZj
 Fpze+gocfuH70Q9D76xbGRxP62dRlIg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-kiO2A3lzMt6fGcRieRxQUA-1; Mon, 19 Oct 2026 18:20:53 +0000
X-MC-Unique: kiO2A3lzMt6fGcRieRxQUA-1
X-Mimecast-MFC-AGG-ID: kiO2A3lzMt6fGcRieRxQUA_1792434052
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1d1f26a63so16207265e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434052; x=1793038852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0DMCIM4SY6M+GNhaHaNHAs2jnIKCW5lF8AzgnG/Gl44=;
 b=C4c/IB8Uwr3qr2xe7iobj3pjBQO7Q30dWEuPDQa+U3T12y1ZHTvn5lTdaXC5PNev9c
 x6ZUBls25KgwhPE7nUpUzGZC+ViGfpf5tFqvSFhxZJMCICNqnhc6Rya9IeJbKWRl08gz
 Zk/DS1QL1CV5He6hDlcE7RfTkMVNsZVgfPcHmUfEy/2RNwslNymivneYfTlcwOiJ1Fhs
 F/OVg/9VdaBlr94RzAIvmo0LIvQHXo5ZHXM2qINswP0A/DlWA8kW7hng5cF5Ig57iyZG
 z9dagoORv7yGYqw+f4cY6IokYc6WErPLAsm3Z5uTMHP3MRUmrLumpBiCZfksZZNFTU3f
 4gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434052; x=1793038852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0DMCIM4SY6M+GNhaHaNHAs2jnIKCW5lF8AzgnG/Gl44=;
 b=YEeg48owzubO04R4MVJ8MISzjgxN9mhC5+Qh0bgikh72kH731kBa6ArYjPQ8hSFZDj
 X/krtB9gfY1rgYICbGbxcuesxGcw307d3iR3/vDjJ4Pk9iObiS7WSJAYgILV/iA5A119
 rtVxwxF0Nn1jOATvnMqfj6IHXmA9lpzJcqEXXxL2tJmKDWfbJeQJZdyY+YIj135+kD80
 4EXdzulc8C210loTgu/NkwWlCdGgIx/z/C9Oz5X8hRtTJ0sJcYMRLmdxNPNS8tTSk7Ef
 STrpdF8becRlwkbqi7QV7aPF1nf9aW5a8MfBkm2iz2w/2XqJQ63c+zhQWdXh+CbfD4ok
 SLHg==
X-Gm-Message-State: AFq9FYK4AyKBCQ7T+n7rvSqD4WTpSYJGGFb4zqdsxBNdjM5TPknA9NxW
 lzlqtdWQTJT5p3QbKBqv41uCCsY412irP9RLI2Ypqyrq/8Lt5vxCCAmFbk4qmvZxy30avVoQKqt
 uNV+v/5ZTWtEX08zh+7CfiudWA8691hr/UvvCB2Ra8ju0ljDmlXoG6po1
X-Gm-Gg: AYBFou3civAs5Rwh5m3c57V2CH/xKQj6BVFAOoKTDPX2SZBA29fjrLwvo26QnnWzzTf
 Dl6J5fBqpm1IPV8GC5VV1xtPFQEYmf+cn2sTqp3fTO798Wlilb+VPqAszCtaCQ70HkH+aJ9yw+E
 mbVh1zQ/2MhS6isVf024BAkvQJcU3Xy7GKioTyPL8RZm9WMbSE2ar+vrFEHK4VrGHsRo/Qcza33
 w/cBRn10tsP+twxqXlN5D9kIku7W5LamnRod2HIice9p79AGvou4npwvbh3R1SqxdwgJw98JM3y
 eP6YVFrFUVxQLxgOLEi3n7XHhEfl94rssVX17znHjJpXYco4bBvNyiX+eyepQwHCGp/fmQsi5mG
 5sRMyNKsh1boUF7TAUYwuCpm4V6IVb5O4V1fhILeLwOJJqIJTfyjWiUzNAw==
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id
 5b1f17b1804b1-4a1d75ab363mr192611025e9.4.1792434051895; 
 Mon, 19 Oct 2026 11:20:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id
 5b1f17b1804b1-4a1d75ab363mr192610655e9.4.1792434051559; 
 Mon, 19 Oct 2026 11:20:51 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cc809csm9811365e9.8.2026.10.19.11.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:50 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 07/12] qapi/block: Add BLOCK_IO_DONE event
Date: Mon, 19 Oct 2026 20:20:23 +0200
Message-ID: <20261019182028.45305-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This event is emitted when an operation completes, for which a
BLOCK_IO_DELAY event has previously been emitted.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block.json | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 5f9f5c28050..38f293dd32d 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -660,6 +660,9 @@
 # Note that delays deliberately incurred by throttling do count
 # towards the operation duration.
 #
+# This event will only be emitted once per request and action.  When
+# the operation does finish, a `BLOCK_IO_DONE` event is emitted.
+#
 # @qom-path: path to the block device object in the QOM tree
 #
 # @operation: I/O operation
@@ -686,3 +689,33 @@
       'action': 'BlockErrorAction',
       '*offset': 'uint64',
       'bytes': 'uint64' } }
+
+##
+# @BLOCK_IO_DONE:
+#
+# Emitted on completion for disk operations that previously emitted a
+# `BLOCK_IO_DELAY` event.
+#
+# @qom-path: path to the block device object in the QOM tree
+#
+# @operation: I/O operation
+#
+# @latency-ns: Full duration of the operation (in nanoseconds)
+#
+# @offset: Request offset in the guest disk (in bytes), if available
+#
+# @bytes: Request length
+#
+# @failed: If true, this request failed for any reason.  If false, the
+#     request succeeded.
+#
+# Since: 11.2
+##
+{ 'event': 'BLOCK_IO_DONE',
+  'data': {
+      'qom-path': 'str',
+      'operation': 'IoAccountingOperation',
+      'latency-ns': 'uint64',
+      '*offset': 'uint64',
+      'bytes': 'uint64',
+      'failed': 'bool' } }
-- 
2.55.0


