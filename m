Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE16606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g/cS5MbC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JSryDfmh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryn-0006Tl-C5; Mon, 19 Oct 2026 14:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryh-0006Qd-15
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryf-0005pe-EZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enixiR+tTsUCI6UXWKu3g61lIiahEj28V+vTeL2j0sU=;
 b=g/cS5MbC/poGTEeFP5iPt/mJoXkf/XLg5CGUL5MTFVLAv+E/YA41wKpqma3+nv3tAgMBM9
 8CXNkq1CfgbOlB7myb/KkI5UvSCji9IJCxRH70+hImXvS+DSDI7Nl9GXewamnvLnClkbDd
 t6vWFW1wAtxB3Cz6PTGWT9Ra2s6cfN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-N9Hs-31ZOR2tVE3b_aGdww-1; Mon, 19 Oct 2026 18:20:51 +0000
X-MC-Unique: N9Hs-31ZOR2tVE3b_aGdww-1
X-Mimecast-MFC-AGG-ID: N9Hs-31ZOR2tVE3b_aGdww_1792434050
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1e6ae710bso9159455e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434050; x=1793038850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=enixiR+tTsUCI6UXWKu3g61lIiahEj28V+vTeL2j0sU=;
 b=JSryDfmh7d1wNKwKi6gGOQ0/8bO3nfEF9rcamxdhof7fXfKDDR+cJmFPuA+XRQaZwU
 XoHnlBdLXBgR+f25ANstrV73vgcTH+zd4Fw5En8C2Rt2nbhOamMOpfcqFL+hPkz2hzXr
 qqSTVSlmJB3RchYNzQ52BRXGNfyiKxYQydvAE6qBBAgeicm1jfRs2wR4gZSILlIOcMef
 x4cpm/oJGTqhpPHaU9a7tYJde8oSuLn0MkZ7LYfJ8+i652lEF1ynfkbgwqhzE5rqzMzo
 kAdY+pEhHK1mnLPZiNB23VjXrkHHUbSt/rSNyrL+6202OBfPvyIWgQhAD2xhC/77UNt6
 28pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434050; x=1793038850;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=enixiR+tTsUCI6UXWKu3g61lIiahEj28V+vTeL2j0sU=;
 b=vdEZLWP3ot7PIkzWKbT6Ga3HPVBn5+D4TfrlaiCophQo8Y+6eHRs0LjINYNtfn+UqO
 9e9d1p9+C2TUMkjVbvQIOrn/aaWeOt4F5Mjax0P2lk7Dt7JWSoVaH1G6eXyHoQC0aTuP
 8g7j7GwEMw1s6mCf9KynrJpZjI42Hsas1arSJLi3Pz6dkyPRi7HSpcaLQFb0pLCZq/+g
 yg9j8Vz5vGvnCV4dF++tZf6U1HWAMCqXYY4IZrz2a2jBYQ2E9ss1wVDc2kWa6hu2WeXJ
 Z9GtkriQ68DEKiKqKNhnq0lBz8/zNGjFRDV4Cd7c5B/fDFGS458aOn9YkaiYx5fO3MPX
 a9Bw==
X-Gm-Message-State: AFq9FYIt5bM5FJue7GmNoBf2BobN/UIVATUWv5V3353aCTTzdNYS18Gr
 rukFGPXIDEpJzjwwYsc2FkRYcKrBVwJjI+UvH9FUacpHPSJv4aJzpnwSCN4tHl6BRKAVqWdgGHK
 7e5pjmeRFCBJ+wwoU3y6fZOmESKzP2WI9DKZyOOtkSaORo8bWx3+r4ST3
X-Gm-Gg: AYBFou3W7WoqzTE+7Tgd3GUfccwSYdl2hTTTcy/6hVbxAZoeTCN+bylfchFpQdX9D6J
 BrG1Nd+3y9V5j/hO8TY50Ffn9Wk5HS/CBaV+BdywAt2aVR2FTvhULs+aCj+ua/Ul4Q9MYbQAxVp
 uDACzpMr5sQWvtL3IPoYN6ApmymtCBkcRqoK9+18FqUWwugnxjZg7XcVpCUtOq3hC2+itGxt76x
 Re8I+SUJ2hiypwHtVzhbFk799IWlcyH1oSxJ0kRSq8q7ADP5AbGCBACpTTYrZo0GiIrCX0EHdMi
 YvWrHC26Tv0uLKC9Ccfw+AYdgiDVIQ/VYI6FT5nVFdpn8DmbMaqwI3ZcHJTtrjouqCgtCerdPeq
 NlZFmJ6YxiEUW204PC4+pBTMIYpNUwm4VrceqiQ2rp3ZEItZCicul6y28yw==
X-Received: by 2002:a05:600c:a46:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a1d7603dd1mr194475315e9.21.1792434049882; 
 Mon, 19 Oct 2026 11:20:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a46:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a1d7603dd1mr194474895e9.21.1792434049558; 
 Mon, 19 Oct 2026 11:20:49 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8185ddsm500557f8f.29.2026.10.19.11.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:48 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 06/12] qapi/block: Add BLOCK_IO_DELAY event
Date: Mon, 19 Oct 2026 20:20:22 +0200
Message-ID: <20261019182028.45305-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This event will be emitted when a disk operation takes longer than a
pre-defined threshold (as set on the block device).

Note that the description refers to the "delay-report-ns" and
"delay-stop-ns" block device properties, which are not yet available.
A future commit in this series will add them.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block.json | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 8f4a71733c1..5f9f5c28050 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -649,3 +649,40 @@
 ##
 { 'enum': 'IoAccountingOperation',
   'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
+
+##
+# @BLOCK_IO_DELAY:
+#
+# Emitted when a disk operation takes longer than the pre-defined
+# threshold (as set via the "delay-report-ns" / "delay-stop-ns"
+# properties on the block device).
+#
+# Note that delays deliberately incurred by throttling do count
+# towards the operation duration.
+#
+# @qom-path: path to the block device object in the QOM tree
+#
+# @operation: I/O operation
+#
+# @latency-ns: Ongoing duration of the operation (in nanoseconds)
+#
+# @action: Action that has been taken ("report" for "delay-report-ns"
+#     or "stop" for "delay-stop-ns").  A "stop" action means the VM
+#     will be stopped with the "io-hang" `RunState`, which does not
+#     drain the block devices attached to the VM, because draining
+#     would be counterproductive in case of a hanging I/O request.
+#
+# @offset: Request offset in the guest disk (in bytes), if available
+#
+# @bytes: Request length
+#
+# Since: 11.2
+##
+{ 'event': 'BLOCK_IO_DELAY',
+  'data': {
+      'qom-path': 'str',
+      'operation': 'IoAccountingOperation',
+      'latency-ns': 'uint64',
+      'action': 'BlockErrorAction',
+      '*offset': 'uint64',
+      'bytes': 'uint64' } }
-- 
2.55.0


