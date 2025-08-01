Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE55C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqng-0007nQ-Qn; Fri, 01 Aug 2025 10:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhh-0005nI-Iq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhc-0002sA-Gl
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLPixtjK29bcXJWoF2tbZlGmeP/UpkFHfHcFk7aYjP8=;
 b=KeVHrHA0XKZePqv0kGHlWoPvNELW1HgpOlCRzk0V8eoOA4Ftf9jn4pVEAxlXJh0PJZx2Qn
 ff9MmrsSGe9YtpLztxweErLti0t9/x5Xod6AAm8UWB/rqcwRum++g6YjcKKQGe4p314lys
 UwrNRtRbzaKaoypcQrr1jkto9ZkFLWM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-5QFrZUfRNp6h24pl4WyP0A-1; Fri, 01 Aug 2025 10:25:41 -0400
X-MC-Unique: 5QFrZUfRNp6h24pl4WyP0A-1
X-Mimecast-MFC-AGG-ID: 5QFrZUfRNp6h24pl4WyP0A_1754058340
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4560a30a793so3202925e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058340; x=1754663140;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLPixtjK29bcXJWoF2tbZlGmeP/UpkFHfHcFk7aYjP8=;
 b=UxCr1MObOd1wkbY3IKMGBm1efD1+YAl/Pq1WZ/4lhBmb6usL2Bi4CQigeKhVfYEQu8
 mguHQowezjCtcOSCdU7L7OEEjCSN3HIaQ2YVdJLBKoyPnmzmtSpyWApwuAN2w+GFI5a4
 7by8sgiVcBV7foZSZ9plk+RhwQmPDf/xVurYCRYEC00TGmTE53jxXLYGMgKGHYzIDnBy
 UdnpOixmUJXxSXp8Eodkx7MSAho97XEOocUTH2kcFFNjnjToqL25nXMgmPspbKfJgKHr
 wdpaZMdBewU6VFmTq+y37zJ/dCFQh6ZEIeGeKTIMp3SGrxho3DVL2p0PVCXT7g/fxs7J
 b1Sw==
X-Gm-Message-State: AOJu0YzHFVooJgXB2XtWk6Klaob2VcZqIJpD0ci+RbAT9sLfOCiTzxPA
 gasRsbPgFDWRdCG/35wAmjWT/VC2Y7OXxa/OcoQXdK/VBuaFX/I1Bfpicwkb4svnspv2A0Osx9a
 PVEycKyXrCHq4ebkbKGBWUS6/rv8/OwgYwpQSmk4hPAMRPoqLIRipC/QSsHxaykzjvahfuE5FFW
 4vj2AhXPyHjOShICpDi/nagUpijFm9OeLceQ==
X-Gm-Gg: ASbGncucoZmo0BThAXPBB82SnD6bBi5vCi64OzovjtLwcpra0J+oJD5gOINz4jQAiXq
 BPoPVPclw7lKqlBZtWKQnFD85JONJ5fA9dW6OCNKmA6vF/sTkTvRNQkWVv6fOuVcbB1QZFK2S3M
 GDicqvEh7BVJ9wKXXp8TGj/xTtw5GH19b87Iu4StWfa6Mkpfx7mlI7rZ/gRZ4G5RfMm6Wxv1N/6
 67eEF9PTgb3YZwChuqICgVWlXkEaS6pk4Ml2WHoVQIMBIEAJ67cDD78VVcYU7nMwfGJmLHVVze7
 7w9SPyaiES58jg7E4FHd0bCg6TxeD/1J
X-Received: by 2002:a05:600c:c0d1:20b0:456:161c:3d77 with SMTP id
 5b1f17b1804b1-4589301f9famr80232915e9.16.1754058339984; 
 Fri, 01 Aug 2025 07:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC8/Dfw+kQSVwFEgr1jSxtfOH0jvtrc6GBpwprP+AFUE9ifcVddq2sWhwfuZTL3IiUsJ+tyQ==
X-Received: by 2002:a05:600c:c0d1:20b0:456:161c:3d77 with SMTP id
 5b1f17b1804b1-4589301f9famr80232705e9.16.1754058339485; 
 Fri, 01 Aug 2025 07:25:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edfc930sm67169475e9.8.2025.08.01.07.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:38 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 16/17] MAINTAINERS: add net/vhost* files under `vhost`
Message-ID: <4164adc476d85d46ef4901c05a9807b24473b00d.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

net/vhost* files should be interesting for vhost maintainers/reviewers.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250714102626.34431-1-sgarzare@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 069d77f2f8..28cea34271 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2322,6 +2322,7 @@ F: include/*/vhost*
 F: subprojects/libvhost-user/
 F: block/export/vhost-user*
 F: util/vhost-user-server.c
+F: net/vhost*
 
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
-- 
MST


