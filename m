Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D0FC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0A8-0002wV-M1; Wed, 05 Jun 2024 19:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0A6-0002w7-Qg
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0A4-00056U-SI
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=GOHtIc2ujqNx/z9GfFcL80P/MDubX57e25/1z52AfeT3EnUSPVBg4qc4pe715Cg080nnXw
 u2RmMRRN2RSghiq923IRif+dxStYU/XTncz1t796OZw+0JlN1+Y97jAKpbsVADO2xpN8Qm
 83Tx4ylgfE+vAVQ8MYUleQsYKYOmVVc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-5AbZ8ib_Pxyo78TN08rAAg-1; Wed, 05 Jun 2024 19:35:18 -0400
X-MC-Unique: 5AbZ8ib_Pxyo78TN08rAAg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68b4937c43so16638566b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630517; x=1718235317;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=KUuEAYdDXHV7KNu326aA0AQquuDVY/3Oev9ly++ftQQX+6r+rPvaq48AE1abMd6N6f
 d1eSB9ccd0PoJUDtZid1/S+Y1fvF3QD44xVz44otbtyPiH22xnlQkHzdCn2OExjdYoCw
 uwvl/KnKVZH8hlK4SlnRcDDVAQLcXvfCRfB1Np8rjm/HPhEQuMxq7e30DINpVT+JwZ8y
 udlqVpc7fBmcCEsl1FhUoZd6Xa/iWGXZZHxn3rJLyng17h3wGrk/tRZgMrokGtYGO6AB
 Y/FolZmYTPzFWuco2R/k5OQve7E1rVxTOHFGB0you75eiZ/YImf9wJJj5MJV8zB0J0eY
 2+AA==
X-Gm-Message-State: AOJu0YweC9HjgFsq7DehZqzR1HsnKv82JkPomgE+BiQQJ8my9OiP/4nx
 wI0fwFxlYW+yDpCKdhGx83gnWh4hnHNYSjOHRicLf0R620CAqXsb+dXAspomxN7g2BvStFemSkq
 YbWAQzkdveIqHTmPDttTGnKjhEYyukIg2LroCN2IES8X2Ci5t10OcYgAugihRHgJPfgkpJDggGB
 lOlmcHUKFifKo0yvxpbiSpGzvULFscEg==
X-Received: by 2002:a17:906:2bd0:b0:a68:ece7:8db5 with SMTP id
 a640c23a62f3a-a699f562d6cmr224212666b.31.1717630517048; 
 Wed, 05 Jun 2024 16:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGahZNBgxL1fwV0i1PzqjyC48R5iFl9fpV7OW4dJf8ZYZw1lm8ehkIRBh1PXle/lKomOuayEg==
X-Received: by 2002:a17:906:2bd0:b0:a68:ece7:8db5 with SMTP id
 a640c23a62f3a-a699f562d6cmr224211866b.31.1717630516599; 
 Wed, 05 Jun 2024 16:35:16 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80728d18sm6312466b.198.2024.06.05.16.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:15 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian =?utf-8?Q?P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PULL v3 09/41] Fix vhost user assertion when sending more than one fd
Message-ID: <a0aa3161408213dacc3318c92fcadb6d4f42e426.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


