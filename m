Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A437C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHt-0000Te-7y; Mon, 14 Jul 2025 19:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGo-0004gj-P5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGn-0005ZC-7O
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wPt6vb4NOguzLj5ZSl/5mm8TsvLvcr6KKJ0kJGd7+D8=;
 b=TjIoCOE1jdhTWQ6GbzROhiUKIcBt91fS+KhPdJeRddOImm33Ht8c4En3TMiSPM8NTcLIgW
 zN1RsD3R174vYjnLIn4rwEYn/ZHJg5d9oFwMSqRh1P59UVFD35InWJuoRS2YeVJhn6/xNJ
 T4RAVo9yFgM2/XHeLwXIYJh2yqEearI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-jh4mwPQRN-Wq6FGr6Ow5qQ-1; Mon, 14 Jul 2025 19:07:35 -0400
X-MC-Unique: jh4mwPQRN-Wq6FGr6Ow5qQ-1
X-Mimecast-MFC-AGG-ID: jh4mwPQRN-Wq6FGr6Ow5qQ_1752534454
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455ea9cb0beso26553885e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534454; x=1753139254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPt6vb4NOguzLj5ZSl/5mm8TsvLvcr6KKJ0kJGd7+D8=;
 b=Q1Teqr1V5xcX8yaQNR9c0P9RKY3M/KrtKpL699bqJG4PdlnYq9WG0Ry9B9qhuMuY40
 hSPY48MvWGk+dKcEyObVE4YsMNvpMM1aPV5HFdZDCmGp2lV7J5wfj+eRofuwPfo8Vhdk
 2jaR023u7sLd/iTNauuGbJfBwCYV+8TOUOEkROAOsrnDdfRqiboWzHDoQkbObUkLnmjc
 hEuyM+j5YXngSRvvB2UKYb6rLgXUBRzO7B59VLcMqU40nBa6wqctJeXfMqHT3Ff0YlLJ
 JB3z/UUbtdvpobNrPr4aVXadA7qr6sJf8vTYc2A79CK9iVpAKbWJw+5q08XmVPcvfaAC
 DC1w==
X-Gm-Message-State: AOJu0Yxxwu6pDjRiBHoX8NNnZNBSwrlpppJ4us5VnKw9UoRSni3rHkZr
 8If59bV0jgHwyDkHIkKkwfVYOAmJg/BlVqF21Vy9alx67WUTy3SIa9MIUT84h6QtvIrj/fP+VXe
 hwDVOJ4xCbodNC5eUCbbmltsZ262ghoD7vZFax0KKZaJ7o3XPvr9xMuk/Lqf6WPyZd58jV+Ie1b
 z2M1FdMsJu+wWt6H4tAH+ydLUNm3oSxcUNtw==
X-Gm-Gg: ASbGncucIydQWwPjan7k0gxNLT5wI50o0MbbPth7pWWAlEbydpbFED/aalqLj+EadNe
 P2+Ja+6akTgz9z5davjFDAGbzDfL1GsjK2labAm+WiYjeGRWi/jPRjtTeIqh4mUbzMOUMu+x+zX
 trViWPOUQS6m2N77k9628bL9TpqDcvekUz8GE/lN9QFPZbvx4js9Ux+X3+u9xtzRANIDAZAc3lZ
 F+qo2h6152h8cDI/C+QQk8hab0V6LlToZge0tUpWO58+0msfh/zhp0uywmMZFb6Y4Ziy/ONqgTW
 Xp2s+b39eXhWANZsvlXLb+YfR+eIU1PI
X-Received: by 2002:a05:600c:350f:b0:456:11a6:a511 with SMTP id
 5b1f17b1804b1-45611a6a7e3mr58872465e9.20.1752534453792; 
 Mon, 14 Jul 2025 16:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeOnn0D2d5TgSXbI8ldCKzoxgB9X5VfRRbvOro2/Ha8vVbqDigC/JTCBEBmqNWxzXhDYNiPQ==
X-Received: by 2002:a05:600c:350f:b0:456:11a6:a511 with SMTP id
 5b1f17b1804b1-45611a6a7e3mr58872295e9.20.1752534453379; 
 Mon, 14 Jul 2025 16:07:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560f22cd14sm74606775e9.30.2025.07.14.16.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:32 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/97] memory: Allow to store the PASID in IOMMUTLBEntry
Message-ID: <d900327d4b094e23b445498dd432762f27ae7b2a.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

This will be useful for devices that support ATS
and need to store entries in an ATC (device IOTLB).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-4-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/system/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1672622d70..d6d069fd50 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -144,6 +144,7 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff = 4k translation */
     IOMMUAccessFlags perm;
+    uint32_t         pasid;
 };
 
 /*
-- 
MST


