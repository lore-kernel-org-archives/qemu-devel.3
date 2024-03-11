Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA8CC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngS-0000MY-AI; Mon, 11 Mar 2024 17:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngR-0000Ia-0l
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngP-0003zk-HN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuLmlhgoVqShMS6Vnf3dIC6HEgpMPj5YMMqJlGYRLLc=;
 b=jN8EGyeSyV/sUKUzPKi0pJoTv06jbL8vxEG+QEtbN14MaTACtS0qkdeGdWNmmiijWNI0By
 x+QlPwrG0piWWj/nOHo4UXKKndSDUCT1kOdGjJvbCdlON5v2LY/SyI0hj3YaAU5TFYt3Y6
 0fYqTnZ0SQwVhJhQYmdgviJP2XptZSY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-91rwVLG_OSKl7W1GJoTj2Q-1; Mon, 11 Mar 2024 17:59:42 -0400
X-MC-Unique: 91rwVLG_OSKl7W1GJoTj2Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so15043856d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194381; x=1710799181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuLmlhgoVqShMS6Vnf3dIC6HEgpMPj5YMMqJlGYRLLc=;
 b=LA5TXWkG/PRv4z5a1FU/2JjMqDVdzzW0TqnZB0CCLR2lEGX6MrtDEOh+1S6i0YbiWi
 6eyWEMNMsvoSCGAesT258vAebEV2pKjkEPsrt7mqZXgqMN3S3ClR38rmUPswxuunHHzV
 iADhl/VcIsly767d2FMVcNCDl7KT6HBrfFJ39kuWGWS3iI3OQPRGh5/+m7K62iP3hEX5
 oqxPbGX6UQh4roJXXkFZslTFWRUEZF4omWcJbg01DgXY4BhRgGFd/5NnTAR5PTyZnk+l
 Y0eHpMH/qrS/C5zNF2CWZxKc9sI3zdy7L+oMOY+wFm2lMRsdtqKYFSCmc5QhsSKBHcIE
 st+w==
X-Gm-Message-State: AOJu0YxmIrXvQ38jMQnZ7tMH2YsBxzLGxmTUWItIY9sOwIs3uT5FPs8A
 dqrXPd7euCrKrd/lk6StBorVXtyDsbs5NZlN+LdK8mrRwleO55UK3IZbny5i3u1zAkZJjhocfby
 VGDe52PS6Q3324jbx2BMvEvTpAdG2PX/E/tNplbfq7k6kMyAmVcxbMDkYcZ+nn6KiurK+koIePy
 3mBwLO5Z59ujzRhCRC+lMnQNKZncxieI2pTQ==
X-Received: by 2002:ad4:44af:0:b0:690:cdd5:ea47 with SMTP id
 n15-20020ad444af000000b00690cdd5ea47mr130720qvt.4.1710194381590; 
 Mon, 11 Mar 2024 14:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv8d12NTCRvvsNd9wzrQScou0t1spnOSAsponO2Hhy5fuiAC1GN9sG08iGDSGNcIwuXZPIhQ==
X-Received: by 2002:ad4:44af:0:b0:690:cdd5:ea47 with SMTP id
 n15-20020ad444af000000b00690cdd5ea47mr130701qvt.4.1710194381131; 
 Mon, 11 Mar 2024 14:59:41 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:40 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 qemu-stable <qemu-stable@nongnu.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 10/34] migration/rdma: Fix a memory issue for migration
Date: Mon, 11 Mar 2024 17:59:01 -0400
Message-ID: <20240311215925.40618-11-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Yu Zhang <yu.zhang@ionos.com>

In commit 3fa9642ff7 change was made to convert the RDMA backend to
accept MigrateAddress struct. However, the assignment of "host" leads
to data corruption on the target host and the failure of migration.

    isock->host = rdma->host;

By allocating the memory explicitly for it with g_strdup_printf(), the
issue is fixed and the migration doesn't fail any more.

Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept MigrateAddress")
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com
Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
[peterx: use g_strdup() instead of g_strdup_printf(), per Zhijian]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a355dcea89..855753c671 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3357,7 +3357,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }
 
-    isock->host = rdma->host;
+    isock->host = g_strdup(rdma->host);
     isock->port = g_strdup_printf("%d", rdma->port);
 
     /*
-- 
2.44.0


