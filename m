Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF6C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUc-00067A-FC; Tue, 04 Jun 2024 15:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUZ-00060i-8s
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUX-0000oV-NO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=X0htI3c3S9ddjcHw/5rJWjFtawIzyLaF/y17bdx1OdutGcwRrpRU7RTgLJh4Wq2YuOFtnS
 T4RW/s9gQk/dtLcJhsELl9hFqIsz8avLNXHx9Cq9vvA+x21a/wxR6LGtIRIFrnmxOVsyph
 W3wpx7ultQVQJimnJ9LWXgmXEvAtx+k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-XYug-GCzPqWRbSBiab-4YA-1; Tue, 04 Jun 2024 15:06:39 -0400
X-MC-Unique: XYug-GCzPqWRbSBiab-4YA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dbf83bb20so3575873f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717527997; x=1718132797;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=gKFYwkluTPo/cJIa3cLk76gsYf0/wlVgf8hE2k2jX8AK7K3tVxw+3GaiOugWTGM7WJ
 IJj5KONN2bGxSIueXR+RuqipH85XzjQ2YRMDayBIs+fJq4Rmg5DRyqWY5jpZPJWBadw5
 on00ZgguXi/4pY/+efUlw7MCIBthG7yvFCQfvTXg9GWRJNHHy75nTCEw6k5A4xBtXCm8
 vsXlJVGspakMIkf9F56zZfafQ8EJ4Q8Ql+p0GSUccCu2KP95hpjmQ8zyJpHrVEMkmIKK
 zvIweqpfGJM7SaaYb/zjkbIicIX2FXYHgWDMJNtym3oQosv3qy+vIgGClOnvqxIKFFsf
 tpEg==
X-Gm-Message-State: AOJu0YwvuL53jGarwHRVjIxEVP+4v7Ds4884epc1dQW00vX1F6bfyn6I
 XDIfhSy3afbDdQVttDsVzDsqS5tOj2742NTeZpSOuoMirYLrDGwcd3bMzoUE0gWV7BXYKAsw8ma
 PpHaeAciXcDh+F1H4sv23hnfzcGzc/B/OYSFakaGiMwNLvaFXL9BoNIDgSpPsRbrUT+fKxR9rjB
 +dlfvvKQjHf7NetzbpAkqaKAvkoTKxMg==
X-Received: by 2002:adf:9bd8:0:b0:354:fb1f:8b5e with SMTP id
 ffacd0b85a97d-35e89835ae4mr237419f8f.33.1717527997480; 
 Tue, 04 Jun 2024 12:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgnPbP9kEvZBHOfBML5qv5TFA8fs0/jSRaXkQbhBSUohua/5VHBE2ascE0uXHv7Llb5gB7rQ==
X-Received: by 2002:adf:9bd8:0:b0:354:fb1f:8b5e with SMTP id
 ffacd0b85a97d-35e89835ae4mr237399f8f.33.1717527996892; 
 Tue, 04 Jun 2024 12:06:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0d98sm12348319f8f.24.2024.06.04.12.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:36 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian =?utf-8?Q?P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PULL 10/46] Fix vhost user assertion when sending more than one fd
Message-ID: <1fc2bf2d1fc50c78515b1484b4d578bfb373df54.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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


