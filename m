Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCADC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAi-00026P-6y; Tue, 02 Jul 2024 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAg-00025V-Ip
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAf-0007yw-0S
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=StqfIEoytRTMs88a13vvQGWkPBqqakiO/vFUisCNyCJ6Q/CrvDbpbz3/Y8Y1oJYbmFNoiD
 Pk4VxURAAWDfI1NiEpSc/IrkB6w5UJum4Zdf5NvMqha0KekkZgB+3Dx2C+FjVzWJOdjDEW
 h22SgPDX5b/a2z1Jq9rlRIbfnxJy1VU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-tYT61iJlNJKmlTu79vm0aA-1; Tue, 02 Jul 2024 10:07:32 -0400
X-MC-Unique: tYT61iJlNJKmlTu79vm0aA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52cda76173dso3716300e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929247; x=1720534047;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=AKQrX13cfVtCv4EXmaukQr3BO2Xwx9gksUOOwlCf3lA065DVOUK+M/eoWJdArJCedw
 uW3I+iQNLjUhM+OHCZcEJWFQ786dfkkHMrh1oB7b9eD5GOQRqYMoWtzLiW3sFf+5o0HP
 tkeOJ0d2yHiKAaWoU86LsKcqrNuHtn47dZCIDh2mqGBW6l6SkSoctFjm73iOemnITymV
 2St6oBNv0etNWfeTgOKdOzEEYH5e+TyyB4m45izOjzPS5B+SSsYdADXVQQ2dMEd7MPJP
 kc5vz9dFVTwaE5D0QYnsuqJqkQUsgJrzgJUl7UBloR0Gaf9IdZip2o1/7+1uaFa60eGA
 z5vQ==
X-Gm-Message-State: AOJu0YzbLm3PG4LQR1hW71qsNx0O0YxRS0iV1Grrqosr6+ZsQfjOqk0T
 3HkiQ5Uo34A7/L8RxaafhJHIHJscgRrI4wHQ2Ch9WYe+vuaKUres0aSnaZSvNsD5a+iYOiAiNst
 gBjskehoNLXa519UvVDyfHcIlwxEbwVJ3cVGlDjigwSp2xnfyS9t+GoMhTB3e9liC/QmnKccizf
 v4p46fK6OPTiSDRvOsoy/Tvrlo32l/Ag==
X-Received: by 2002:a05:6512:3988:b0:52c:f2e0:db23 with SMTP id
 2adb3069b0e04-52e826886a0mr6373290e87.40.1719929247217; 
 Tue, 02 Jul 2024 07:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV4T/ToQk6mIYYr8cSy5YBs4Q65XdLd6jH0D0NHTgQIdXf9mfJ1tZvqlhOosLJA3Co87D+eA==
X-Received: by 2002:a05:6512:3988:b0:52c:f2e0:db23 with SMTP id
 2adb3069b0e04-52e826886a0mr6373259e87.40.1719929246595; 
 Tue, 02 Jul 2024 07:07:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b065316sm196782195e9.26.2024.07.02.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:25 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian =?utf-8?Q?P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PULL 09/91] Fix vhost user assertion when sending more than one fd
Message-ID: <5093bee0fa8a6c9712c96653da3a79bc37a4e45d.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


