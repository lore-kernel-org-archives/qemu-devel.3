Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557F1C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxr-0005jk-Us; Tue, 02 Jul 2024 16:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxd-0005Mb-AA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxa-0000hF-BI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxEb4qxo9i3miZ1US5mo9RXgQJuGwUKVIRe5VRPOVeg=;
 b=GyNageGbPNFoP0J+2lTbyHI0HAMcKjxCD83vGAzlmfjj0PDIpJd9eUvyf+LYzTv9TF3i2d
 OkuK/j04kmBAF/BWGjDN1TwXQiR8tPQ13s0lc4BXmB8mXrVKyKxiYxFNCG0gwvpbUiTRbL
 g/39oU+XlX/Axn0jqkkeFkHQhabG+QI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-UHZYd7lqPcyOPllvLXfkYw-1; Tue, 02 Jul 2024 16:18:35 -0400
X-MC-Unique: UHZYd7lqPcyOPllvLXfkYw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256667ebf9so32012185e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951512; x=1720556312;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SxEb4qxo9i3miZ1US5mo9RXgQJuGwUKVIRe5VRPOVeg=;
 b=HDj2mAdx2BX146MULBk3+/hFh6njwCdZYwtOvYSyz8CJue7eziaxPA0ghAJ3NPV8z5
 8IL7jjD/6m6I2YKzaWuYwG186yJbHjJEoOTNKGiFv6Pt7eocRnbhBCVxV2hgf68aR3TH
 47DjhDaExOVWS2nCj8fnh8F7NzaskpNcz0+sCIEPFG0CfvDEk5fCjePf0ap1PZ+6RDV2
 0CmMoMkclSO+R8cuhpGtepKDwKTPEU0ZiWVEyK8H+EV0pPAO95WH3Ot7VPe8b694O3Mw
 SBqJTK6uCtE8U9dHpUqD/blA/aGb5BQCPeqcNbrWE2VYw99pKASflvoMouAWb1l4NAL+
 uBQA==
X-Gm-Message-State: AOJu0Yw/DFwUKq14M2ZRK232AZBpVFvXnNtsvdsWdrXVP/IAD+i/RGNL
 Y7uOhqDH4KP7cyDKHGkeElaoqHk4bJfPd4+BQhUz9zJ3tF/P+LHRtoA6iNo8V0v+2LVeVduxFFR
 iMBzMJbHHgYhwgJ4JMaNxm7O2/QeDPKtadtkE6B6Zf+dPWtPzKGtyLCWL4hoUmY5Ty1cNv2UEtm
 CWvLhEsM9vdBP+VrzHaNNaVyGLyxQ8zw==
X-Received: by 2002:a05:6000:1fae:b0:360:7c4b:58c3 with SMTP id
 ffacd0b85a97d-3677572154amr7511313f8f.54.1719951512418; 
 Tue, 02 Jul 2024 13:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJg2Tw/qFcEC1g+98lHMUL43/Q8Rc8f6r0DszyUOXFWC3xW4tz1iFcq9nU603OncAhy2FD2Q==
X-Received: by 2002:a05:6000:1fae:b0:360:7c4b:58c3 with SMTP id
 ffacd0b85a97d-3677572154amr7511291f8f.54.1719951511837; 
 Tue, 02 Jul 2024 13:18:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1481sm14117913f8f.55.2024.07.02.13.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:31 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>
Subject: [PULL v2 50/88] vhost-user-server: do not set memory fd non-blocking
Message-ID: <4c58843e5d3192c67394b28a3330144ea56eefac.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

In vhost-user-server we set all fd received from the other peer
in non-blocking mode. For some of them (e.g. memfd, shm_open, etc.)
it's not really needed, because we don't use these fd with blocking
operations, but only to map memory.

In addition, in some systems this operation can fail (e.g. in macOS
setting an fd returned by shm_open() non-blocking fails with errno
= ENOTTY).

So, let's avoid setting fd non-blocking for those messages that we
know carry memory fd (e.g. VHOST_USER_ADD_MEM_REG,
VHOST_USER_SET_MEM_TABLE).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-6-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 util/vhost-user-server.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 3bfb1ad3ec..b19229074a 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -65,6 +65,18 @@ static void vmsg_close_fds(VhostUserMsg *vmsg)
 static void vmsg_unblock_fds(VhostUserMsg *vmsg)
 {
     int i;
+
+    /*
+     * These messages carry fd used to map memory, not to send/receive messages,
+     * so this operation is useless. In addition, in some systems this
+     * operation can fail (e.g. in macOS setting an fd returned by shm_open()
+     * non-blocking fails with errno = ENOTTY)
+     */
+    if (vmsg->request == VHOST_USER_ADD_MEM_REG ||
+        vmsg->request == VHOST_USER_SET_MEM_TABLE) {
+        return;
+    }
+
     for (i = 0; i < vmsg->fd_num; i++) {
         qemu_socket_set_nonblock(vmsg->fds[i]);
     }
-- 
MST


