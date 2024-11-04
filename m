Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6EBD1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JA-0003P8-5p; Mon, 04 Nov 2024 16:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Iv-0002uZ-Jn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Iu-0005Rl-3W
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PWXbuaXLWsxhC+1PBbOQmp6i/5Hl2ASTF0Q1ZdpmUUk=;
 b=SmvK+zkPlqmquDV4mR0cOnFbuKsWDmynYwP841qiscd4XC0y8lsXOCMotywnfRoEM2B3mx
 0qzdkyS7T79GYeg4wW4p67uOVKmAJr/1achDvKwhOfGceppL9m8hVCxw/QMFQNcut0nmvi
 Z5QC82K/fklDbnekvE/AsqehLHSDZu4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-jtPZlLGSOnuHZM8vX2UfuA-1; Mon, 04 Nov 2024 16:08:02 -0500
X-MC-Unique: jtPZlLGSOnuHZM8vX2UfuA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4957317e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754478; x=1731359278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWXbuaXLWsxhC+1PBbOQmp6i/5Hl2ASTF0Q1ZdpmUUk=;
 b=aDg23AuzEUkK0cJOv+KJKl5iJah/S/NmNmAcr60rTa9p1zsahK/iF4Do5ScMe2Hd3c
 X3edD75U7yuDwRvuBpxyjTu62bGmIXLXxziGXSDJ7SLbnCIjFSDxrXHN1604LBnUgxTd
 bdsNUcfcXQusbDpTU2xbouuw3htx3z+zWWKkNFil6txtC90SSuEYYVB8KEA3734lYkKG
 BcV5ivcZgt1iwgFp6RPyr1FuSSqfWv6Yu1ByUe91Z96rTo50cbpmN+nBk7Tw5GbdPd3E
 pAvUIB65fO9wLNqic9Tk5xHE74lDKAUougGWWDnFcnGhHSE/lmJJFXv2FFkfOtsbdOA8
 UEmw==
X-Gm-Message-State: AOJu0YzEA7Gs/OrzN7YLB8MtsNzoPBBSIFUOSgO6mF3FtRE8/iSbKkFB
 heWfzrc7zI9VUWf2nLiN/+Uk7EtGIVljYRoDuXt2tEkD2EEFvdPHcsw4osiLNtdk1gg26PV7ReZ
 mv6Yupqencbdhpc1jLPSaVf1mQ75XhWF0p0z0Ik1kwKh+agGA+NHVqxRxcF5TLA/cphMz+l/x5d
 3UrXQBoWPmsriijNudUJpnAV2OZyNWdw==
X-Received: by 2002:a05:6512:1107:b0:539:f7ba:c982 with SMTP id
 2adb3069b0e04-53b348ee5c3mr16096512e87.33.1730754477967; 
 Mon, 04 Nov 2024 13:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY2/CcAbrmEEmarzllxlbzbd+M76HDi3y25SxQWP52VbzH04cyvDgvnGuCH9sLROeCBDEMtg==
X-Received: by 2002:a05:6512:1107:b0:539:f7ba:c982 with SMTP id
 2adb3069b0e04-53b348ee5c3mr16096491e87.33.1730754477400; 
 Mon, 04 Nov 2024 13:07:57 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e74casm14101459f8f.65.2024.11.04.13.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:56 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dmitry Frolov <frolov@swemel.ru>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 35/65] hw/cxl: Fix uint32 overflow cxl-mailbox-utils.c
Message-ID: <df66b85f357f9669457906ece865d6183cf12580.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dmitry Frolov <frolov@swemel.ru>

The sum offset + length may overflow uint32. Since this sum is
compared with uint64_t return value of get_lsa_size(), it makes
sense to choose uint64_t type for offset and length.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3ebe676a3463 ("hw/cxl/device: Implement get/set Label Storage Area (LSA)")
Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Link: https://lore.kernel.org/r/20240917080925.270597-2-frolov@swemel.ru
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9258e48f95..9f794e4655 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1445,7 +1445,7 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
     } QEMU_PACKED *get_lsa;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
-    uint32_t offset, length;
+    uint64_t offset, length;
 
     get_lsa = (void *)payload_in;
     offset = get_lsa->offset;
-- 
MST


