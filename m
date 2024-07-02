Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADAEC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjtZ-0001tQ-Qz; Tue, 02 Jul 2024 16:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtW-0001sP-LG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtR-0007aX-9D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=h+wnhHcEKguUGsEM+mEDtBYs0xoUm9bv06GZhmdtYisVCbxC1dULieyCJj+Va1KjAuoyvi
 57nsAa1e/Ah9xilqcpTxcsnCk9Izm99k0LZckEvgH1mTr8h/esAGM83Rwn7Waua6th/vRX
 z+Z8XBs4BCzOiNuOjkKFZW+W9JI+Ni0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-70pRyePjOk25iA4KUDQ3XA-1; Tue, 02 Jul 2024 16:14:22 -0400
X-MC-Unique: 70pRyePjOk25iA4KUDQ3XA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52cd67cee83so4385730e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951260; x=1720556060;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=maE2hnHb9jZ9PeBRVwK74afEzyllBejv+gc2xMnQ0IzLzkAP2VGmW/Rf5ewLCrpO4e
 6ZO9zAqxEw7EnLgcNNyuYljVeO+pBP083NKDUanTpNs5gfMjCW8gjrQPOureN0f0QI9M
 KrjfLilic2eByAN+/lCPBRrC3hZ1L9pqODw55ao1OMXb/2xto+itqG4Nu85YPkk5eBzZ
 huxX2LIxyfPVKsM0bb80/C9pt1G2sADcCZbWFFvojAIV1Qd2RrJlYccEaHRawVu2PQcs
 wMjCf101BIUX/X/zPYLI5AJp3RbL9AXBeWX2g+aocWWBzRaBi8NcP4tmk5dDabmKVE3m
 +TEw==
X-Gm-Message-State: AOJu0YxNcevXiebuHJ27VJLO3xxpKS1SjUEEVmwoIz3jM2w6CRoPSn6E
 41QLHqfJaK6LI9k1yzd9DVFk5DTCY34jvZHA3/9SHPnk3QKsvR/w/q6Dyxt8HKGMw6u4+ihaPK0
 xQDnTyoQlb+r0saofz+VLdNLT8+fTfRxL3r35LhsOsLvwydqnk91OAtA6Y0D45Ql4GxVMjGvq+X
 ShfUJ+3hHe4nq7oEN/gNPDfeo9gQoVfQ==
X-Received: by 2002:a05:6512:6d5:b0:52c:e28f:4da6 with SMTP id
 2adb3069b0e04-52e82702d80mr6569585e87.51.1719951260352; 
 Tue, 02 Jul 2024 13:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1uIOYWOQz2tQ/h32Zwavh5OWKCTDQCVPctBYH5NqxCc+OeUz2HVWKl1wuKU6jCP1casqKtg==
X-Received: by 2002:a05:6512:6d5:b0:52c:e28f:4da6 with SMTP id
 2adb3069b0e04-52e82702d80mr6569561e87.51.1719951259649; 
 Tue, 02 Jul 2024 13:14:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c25esm210477015e9.9.2024.07.02.13.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:19 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian =?utf-8?Q?P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PULL v2 09/91] Fix vhost user assertion when sending more than one fd
Message-ID: <5093bee0fa8a6c9712c96653da3a79bc37a4e45d.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
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

From: Christian Pötzsch <christian.poetzsch@kernkonzept.com>

If the client sends more than one region this assert triggers. The
reason is that two fd's are 8 bytes and VHOST_MEMORY_BASELINE_NREGIONS
is exactly 8.

The assert is wrong because it should not test for the size of the fd
array, but for the numbers of regions.

Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
Message-Id: <20240426083313.3081272-1-christian.poetzsch@kernkonzept.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a879149fef..8adb277d54 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -568,7 +568,7 @@ vu_message_read_default(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
             fd_size = cmsg->cmsg_len - CMSG_LEN(0);
             vmsg->fd_num = fd_size / sizeof(int);
-            assert(fd_size < VHOST_MEMORY_BASELINE_NREGIONS);
+            assert(vmsg->fd_num <= VHOST_MEMORY_BASELINE_NREGIONS);
             memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
             break;
         }
-- 
MST


