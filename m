Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A492EC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjv7-0006CG-CL; Tue, 02 Jul 2024 16:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjus-0005j3-Cx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjuq-00086o-DC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=finLhCXoeqQfSf0Ztpm4oVsGsmHM89aE/BcLGo+hJHJuo7toUhijtlTurbU92GUOf/Y6nO
 Y6/E6oXecXpmgrukOeknv4wy8sQ5SxkTSdOfSPIY4XJbxoQ4WlUTRNiLsT5Aux8tkB2vcl
 yQ1cXLIT01dtRmDyiEwUhM40uf1w1yg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-QwS1oQpsOWCXMYTGtiByDA-1; Tue, 02 Jul 2024 16:15:48 -0400
X-MC-Unique: QwS1oQpsOWCXMYTGtiByDA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so397677f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951346; x=1720556146;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0Pfb548kulwNGCVafgBGSBiO4uWmp/hiUtG94za6C8=;
 b=FXsYuEk4cuqV7jzWenpkAVRCUpaHhLFsKcKd1aNAjPQ51Xe4HoecmQ6F3JuQ93XDU+
 Ka5H1w2tkTtTnM6UcCGv9teUkHEcsboXevnHV9QW3XaMgQM0Jc/HuRb/rpScJqJcD2Yc
 swXJ7e7ONPrud5uKd52p+UGtBTGcyTa3ERqu4Ux6fYnV0qLh5TxnUPGZi7yX0Zgeb9kD
 FE0AQVVqQ63ulOKxeq1kTHR+4wBwenGGTt7KmoAcmriytkwFDT2Ps2podwmgZr6mHjL+
 iBkpqr1w8/tECOduMjvKZsIIA1oz6WgJADYzgQ1OaWm2gQ0KBVwnjB2IXnDeRsOOmzvs
 ++Zg==
X-Gm-Message-State: AOJu0YwFR1QyOLXmAX1Dd0laQi5K4ut9j+EQblWV6T3K+5Gtc5PpTiq0
 /jDfuED1TfiW3o1tdrwHi5LXGVaKV52S/pELYklCmXwFCcgPIRr/jAktGlopmp+F58XVf468+Ml
 Cf10sr2TRtH1OpxwMWxPThcGFRTQ9tSwkhW2wZiBW3sj4PO5MQH36GT8drveRzBCK9JkCFDuXKK
 kFZsrqNnIKa74LUoRfB6BBrBfyomcb+A==
X-Received: by 2002:adf:e948:0:b0:367:900c:c098 with SMTP id
 ffacd0b85a97d-367900cc129mr620624f8f.39.1719951346706; 
 Tue, 02 Jul 2024 13:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkCM7X2B0H0bOHPxIyrMAd+8YGIR7jCyOK8joKTFfyv8e0jQA0jJjhtQFXgsSwe3XZMLzSDg==
X-Received: by 2002:adf:e948:0:b0:367:900c:c098 with SMTP id
 ffacd0b85a97d-367900cc129mr620611f8f.39.1719951346145; 
 Tue, 02 Jul 2024 13:15:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e13d4sm14397297f8f.56.2024.07.02.13.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:45 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian =?utf-8?Q?P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PULL v2 09/88] Fix vhost user assertion when sending more than one fd
Message-ID: <5093bee0fa8a6c9712c96653da3a79bc37a4e45d.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


