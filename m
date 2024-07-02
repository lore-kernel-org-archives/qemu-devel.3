Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71F8C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjy0-0006rD-Oj; Tue, 02 Jul 2024 16:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxU-0005MH-Nb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxM-0000Su-RZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yh+r83dQTqjKVESuK/txPttml/pXNBlxCl8GGxw4h4=;
 b=AJN5KIDUB6WAC11Q1MZ4GZdfDzDtJQWpjmoJ1+kmlfq1F3Z9mrR/FnOE3hXv2dG+NMZ4x5
 O+SwFM+eUgq3xyZbbF5hZDBiPAIcdBqNB6Qvv1fIKyvAUTMXH6A08pazUGA/RpyithI0VN
 b0cLT6CuItV1u+DUwvM0BA8RkNENYPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-KjrB5SWlPomJpSuVJFjn4g-1; Tue, 02 Jul 2024 16:18:23 -0400
X-MC-Unique: KjrB5SWlPomJpSuVJFjn4g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678e523e32so574008f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951501; x=1720556301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Yh+r83dQTqjKVESuK/txPttml/pXNBlxCl8GGxw4h4=;
 b=ohznV+V2DykWKapzvVN+fyILGkEVrY742S6nXeoplL9hvu10PbPgG3sh07DlwUZT9l
 Fizx/FTMh2iGasX5mkv+by1edG5v5Ql7cALJ1QIvekcdFeUI9f4Ef88+97IjnDaZLMBY
 +Lt8+6vFTnyXgZ+6OT1AKLWiDnys9OBlCBDmIc1eDtUnvDDfrhZLUkw2A4V0yVxPdg1G
 D9a8dhLa9XR6HwRkeFK9uUtjmRsoUO2LJKEOmiildP4RBkw7brs3Uf2zXXR4fHku9t0I
 eZWZG2Jwu4S5lSRTqx8ATFO/VF6VBVEs2xbQBNdFHgtLP7XN2uwfng5V6gl+J+9rwJQ1
 0IxA==
X-Gm-Message-State: AOJu0Yz0AS6azap4xgvIasucQ6Zl83fUseFX2BmjYRAPEXOIaNaT/nxW
 ZhSijEmCigMm95xM06atm6TWUnkRmQLty41Oxiev/JLKd0oUzggFlYcLPtV2admdEU84nrLobPq
 /E1lnfrRmufO7wqz0+ri6Z10gEtAWXTrtGKB3rA0WcCn/Lyp5xdqWEvuy1Ar0aw6+aFzr1+HBn4
 nYC7aI4gz/LP6V8VZaRVRfduGF+qDXlg==
X-Received: by 2002:a5d:64a4:0:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-367756995cdmr9176948f8f.12.1719951501713; 
 Tue, 02 Jul 2024 13:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7UBxhW2TxVTEqd2vC7nLde9ITubvl7loyKAPaGhzwTaHELng1P2HPPffKCSV7CAz5SK3hfg==
X-Received: by 2002:a5d:64a4:0:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-367756995cdmr9176919f8f.12.1719951501205; 
 Tue, 02 Jul 2024 13:18:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09890dsm211129655e9.36.2024.07.02.13.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:20 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 47/88] libvhost-user: set msg.msg_control to NULL when it
 is empty
Message-ID: <516dfbb783484959cf33f051864f2e44cbed45ca.1719951168.git.mst@redhat.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-3-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8adb277d54..53bf1adda6 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -632,6 +632,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
     } else {
         msg.msg_controllen = 0;
+        msg.msg_control = NULL;
     }
 
     do {
-- 
MST


