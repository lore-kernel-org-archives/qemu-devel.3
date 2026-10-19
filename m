Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF2606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YUCj1SwF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kBFeF/R7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryd-0006Oc-8T; Mon, 19 Oct 2026 14:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryY-0006MX-5C
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryW-0005nG-1o
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tG2xuGtICVidqLJNjh8cG+5m/y22VnsOleBvhosc2g0=;
 b=YUCj1SwFT5k244PDJAWBKf6OnArIUcp9soAHgZXftwGFzQDbT6SPkGaJbG84ZGner/g++C
 LDpoHqPWhUokYCdwjaSTv3gMUg5lol2xF/rUknEtJTGXe434xSTZwlAx6wWykzN7F7sVCF
 ucr00pQFzcfX94AlY+I1FO8uHkaWheE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-OH6KYIxdNK21vvc6mHf4JQ-1; Mon, 19 Oct 2026 18:20:40 +0000
X-MC-Unique: OH6KYIxdNK21vvc6mHf4JQ-1
X-Mimecast-MFC-AGG-ID: OH6KYIxdNK21vvc6mHf4JQ_1792434040
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a01b112fa2so27867905e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434039; x=1793038839; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tG2xuGtICVidqLJNjh8cG+5m/y22VnsOleBvhosc2g0=;
 b=kBFeF/R7U2xIVLSHU2A9f8KJpivBs5PmhiaKnyBK50rwi88hJZ3unGCG3Z+sI8DcAT
 6ujMBF+WcUYQBfjsirIYlmTERqugfWiaY2CTHjWpxs+yCCt80y+GRdvNU0jIgp5VhDo7
 DLrXG50dlN5rvMhCIVAZGMWBf/RwhDyNPxl6MoEyzcw41mg8U2bte526n8T1C08i3S+1
 dGQ/qUyUr/HR9v/Mw4qHgwK8xWYQVnUC2G+rOr+WKKNOxuGI5MCsxzd2WWvcKEDuAyxc
 jY5W/b00AGWK4OUYkf9l1K+F4xSt4hoSfnGkO1YTgaBIK+VE8p7t7xuni1U/bzsHJqlC
 HUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434039; x=1793038839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tG2xuGtICVidqLJNjh8cG+5m/y22VnsOleBvhosc2g0=;
 b=aHyOMCib1aou8AEaxE+J/ALkoBCDtogZjO93AONLN0IWrHaWgILYF+9YNhn2nffE6o
 nhkrKUDEjo0wnE9BpWlv+UHBWInjRNKcBOZ+F3G6P4jtg0xcERYa6yEQk4u/CNIFsGLV
 ASdX8HyiKsRzqwSUa+r/UMidXLflzrWm7T7SJr7h1wRCvdo5NaGBXI7DAqMyoC1PeS/p
 uouETT70tYlCfXpF666Wv5i5/uSS12wP3zYxOTCcX07v5RufhrBhvwe2YXnGkerngFg8
 FPtYY7M90mU1mR4PInMDetCjGydN8wERU6iy5hCg4nAbYDJoZcxQa206H5On23IafC2z
 Jlpw==
X-Gm-Message-State: AFq9FYJP9xQw6g/OhtS0xzWI9oOqfE80wx3e4w9/rc+eHCb1Rz5FAjSh
 +T1nbC1/FSYkz1mSQTJFhTia+3EJBrf+q6lpFRFf6FNfnzuJEHE/tSYBluX69LoaWyzflQk9N/A
 nZv/HC0+TXXO/PIWBhFGwTzbt8q79fetZU+HrDDCXLyVnQnrOpjyAEs02
X-Gm-Gg: AYBFou1mYcqaaPhvqzrfZE0D/F+lK8VXWWCy++ePlR2IYagOOMSPWsJxZmyNAZ9Qp0N
 7tzcqm//NTgAkrzkMfUSji3D8BtGGG6v3bq0192fBTW1e1luRoq9D2sIS8tp6oavv8LU4FskBUg
 FNbI9Gzh7O7YHOa2d7EBy31S1vKKvPYoe4jZuZoP7ZZrNtW/nAxv/GF3nhxESOMdTvgiYLSYMS+
 L1Swsb70x2Nnl3l5nAoloqeJxYlyMppjpZIUe/TqtVJ6HqWG/1mzndmzwb4NoXQlLVcCaxF1ZLH
 vQ4OUC8TIilrp+MnRmqVn4mcgpgfOJD+xrNn+cs5mGNseD4urZeJJjG27jp2b7o3N9Tu8fH7grZ
 o16OXRdVmYCt8jUL6saavXXwtA34vhefoDduamW0P7dVtFhBMF6aMjZlSPw==
X-Received: by 2002:a05:600c:674f:b0:4a1:8efb:c9ae with SMTP id
 5b1f17b1804b1-4a1d760d2fcmr165205535e9.23.1792434039573; 
 Mon, 19 Oct 2026 11:20:39 -0700 (PDT)
X-Received: by 2002:a05:600c:674f:b0:4a1:8efb:c9ae with SMTP id
 5b1f17b1804b1-4a1d760d2fcmr165205115e9.23.1792434039180; 
 Mon, 19 Oct 2026 11:20:39 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d823ca7sm441048f8f.38.2026.10.19.11.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:38 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 01/12] qapi/common: Clarify what IoOperationType is for
Date: Mon, 19 Oct 2026 20:20:17 +0200
Message-ID: <20261019182028.45305-2-hreitz@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The documentation for this type is a bit sparse right now, and
specifically does not explain why it is limited to read/write only;
"I/O operation type" could well imply this should distinguish a much
broader range of operations like flushes, discards, etc., but it does
not.

Make a note why that is, which is that these types reflect the block
device on-error policy settings that we have, which are rerror for read
and werror for write.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/common.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/common.json b/qapi/common.json
index 1352e664b23..880eb87a9cb 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -9,7 +9,10 @@
 
 ##
 # @IoOperationType:
-#     An enumeration of the I/O operation types
+#     An enumeration of the I/O operation types, limited to the block
+#     device on-error policy settings we have (rerror and werror).
+#     For reference, the corresponding error policy values are set in
+#     `BlockdevOnError`.
 #
 # @read: read operation
 #
-- 
2.55.0


