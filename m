Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20447C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8l-0001m7-DJ; Fri, 11 Sep 2026 05:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8a-0001cf-FI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8Y-00081R-KW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cK0jKLb9Y25sWTW+STMCp41/svnDlrpZe9udpBmpYJc=;
 b=JuOLgIVG4d/gZbEdK/Zrkk6+9EmY+B75yqDYhEPy4ZjxidyKD5EEEW7MU1iPd4TOYjbLEt
 IfBL5uliwnofkFm1mqKmAA1murfMM1bXxkuaaepJeMhf84l+I1tzAITxY/PU16/NuuCxyn
 qkfiaDInWZC4ot9N/EYqeiOLcNanU2Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-p0CVLyvtNeupMD86e1zGdQ-1; Fri, 11 Sep 2026 05:01:32 -0400
X-MC-Unique: p0CVLyvtNeupMD86e1zGdQ-1
X-Mimecast-MFC-AGG-ID: p0CVLyvtNeupMD86e1zGdQ_1789117291
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a98570af94so1915015a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117291; x=1789722091; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cK0jKLb9Y25sWTW+STMCp41/svnDlrpZe9udpBmpYJc=;
 b=PPTmO4Av2682/TAuMzMcCarLOLQZeVzyASfBibJn5FEcdi17C5WUNUG8llmOHY7JNn
 1VQXjMdGmNhk9jzRfr10FdmhGZiuZJ76K/gL8bgxCR5lR+vIPA/UH6kNhit5Vs/MABFM
 DvGF7XINZxncnLn5n/FZVSaiBIwLmGY9B1JINHJULqU04LktWCRZ3H9U0+YAtpif9syN
 ovgcrN7T2ZNSXf7mgDuVMdeObEtWlPOTpHxNxnDTaj7v85zihHWbu+YSmkGITaGXF0B3
 AvsCEP1c7hH/xj/+Lf1D+T8tJAyIqv3LvOfhose1ppYNZ5Ez/tvtl/SrKCZsDSSrbkie
 z3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117291; x=1789722091;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cK0jKLb9Y25sWTW+STMCp41/svnDlrpZe9udpBmpYJc=;
 b=DbtZsshwNjmjqnRYbsyKf0Qeg4hMJXx+uPU1tiEabqunQRVDepmhzSY9K+e9DRlQKk
 Gt9dzTMMzzaXo0qfAHY18AHNvSrVt6PVupwvEnovjmYkgeLTDpOgEEyikm5W2u1L6mJV
 fVZae2gtCP1Pzfr5i9h2FYjes4lnzrcPoWP/AZqi/8BkVX2uW+7PtfsZUdn0FLCcJGai
 DdSgGMzLfgGT/e+RkDACAHDppKOZw9bH+p61hmWlBOJy48WyDXXNPGPa4t3+IyhvkFw9
 9Mu1D2x/d7z+WvQQcs9ZA09zdSz/NTSmPW6uRn0TodqhEDoK8jrbs1CP6TwV1SEOFKqG
 wztg==
X-Gm-Message-State: AFuF++nTTAODtgPYkTy03w6gkUgiXs2bOo3y+w4uuLY8DUQoI6xhqCJs
 vvHthYhGvs7ocn7fkER0SgMnrLUsROorFs8GkCQqovgRXUFW0jwhQkJIwdArh88+NXfW6JMyXl5
 ckOHhirrp3w9Uz374zdpP74Oe8SnQ1gBBR9615rq42AzVo31TiuotcHVMgr04volXyncFqwuAcV
 yEuI18Yq5tGC9tKI3lD6BKSW3MYJFgqArS0g==
X-Gm-Gg: AYBFou2n+XCH0ZKyujX/BaoCwCKMclc1lxfuZqZ+M8SlWH+eiWJ4xQi92ovITiOEaU0
 yzVlatFrEbV36VB7ESoappwSg4w2W4NVTZIRTtyN6sENycIJvFuSrVSuwaOGUNK3HhnKjy/+np3
 GYihmSf4z9YSH8tUG8u9E/RW3qB/weiUNOF3UPVwUH2SFClfjZaGdFqx6CVgzSXW8Vtp06lhz0y
 fuacF62iVF76hSu5k8YkKEgMUaanKAGJM0OQ7wed6IYkGgIOxvPjn/zsk2y4uFHbX2JXJWCjka9
 DQfTgqTcwIjT3KEZt4DLdJvpweb1YA6gN4q19kVQSAQ9ouBS5WNyPGIgydL0YbLP4MS7XN99OQi
 SMw6BTuEEU+DWPdZwImuQvhs=
X-Received: by 2002:a17:907:3e0f:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c2945db2ce7mr402583366b.6.1789117290812; 
 Fri, 11 Sep 2026 02:01:30 -0700 (PDT)
X-Received: by 2002:a17:907:3e0f:b0:c25:5159:6a25 with SMTP id
 a640c23a62f3a-c2945db2ce7mr402578366b.6.1789117289954; 
 Fri, 11 Sep 2026 02:01:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966021d0dsm58249166b.10.2026.09.11.02.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:29 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 05/75] linux-headers: add VIRTIO_ID_MEDIA
Message-ID: <90cb8b107339ae32360e954bd26357ea6e5fe3de.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Albert Esteve <aesteve@redhat.com>

The ID was added in Linux commit 2187be212179 ("virtio: Add ID for
virtio media") and is included in v7.3-rc1.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Dorinda Bassey <dbassey@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260901-virtio-media-v2-1-bd3cc9347ab9@redhat.com>
---
 include/standard-headers/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 6c12db16fa..f9056af0c6 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -69,6 +69,7 @@
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
+#define VIRTIO_ID_MEDIA			48 /* virtio media */
 
 /*
  * Virtio Transitional IDs
-- 
MST


