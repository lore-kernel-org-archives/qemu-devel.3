Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B7D1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JA-0003OM-67; Mon, 04 Nov 2024 16:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84J1-00032z-Kz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84J0-0005SF-59
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nT3RwUShqklMf6vVLxi4TD1IukIVKoXxtFA87gOIq4=;
 b=KOfZmtot3STsyQfOvkU3lBuHRFHVdBKOr3G/fMnfcu7Uri9KexiRY9/6cOgUspAfbiHRg8
 xkxLN32WUG7wVQ+TxoRdBs9p9VY43OHWBS6BEf/sXaCVSr2wjqqIQKmOMVDLo84ZgCu6K/
 MIV5LzNuHxy5H/0Udy/5EOvDAUCXaz8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-h_XsvyQuOvKattbkcjWi_A-1; Mon, 04 Nov 2024 16:08:07 -0500
X-MC-Unique: h_XsvyQuOvKattbkcjWi_A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539e5f9df25so2788947e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754485; x=1731359285;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nT3RwUShqklMf6vVLxi4TD1IukIVKoXxtFA87gOIq4=;
 b=WayC5HSGtBFBLw3IBp7uQHmW/PDlUDRKlBwCgUDMSnVCd1OZ0NhTDKEWRMtPAH8wdg
 lZwEYRBfSS4K4xA3ySOBCG0Y/6VPJLOr4SGI3daznlJbLzBORkOs+6VFg+GnOt0OHXY9
 2rCdR9Bsh0rb1dQjNX4wG72313N5ZnFsI6B0Y+L5Bk2m/aVUkOxId6M9cfHEDes8aZ1P
 EVaSXhzr4vWJYavAMkDbMskj2m17aBFxplgw0IiVa+KqZqRg4E7TptKB63UM0a2QaLiA
 RHuDLrSk8qk5BEbaqG84apQ1bn9kDXzlKG3JPUOZQ1WpPVAKBo+7/osLbfTDMX82uJqd
 5jpg==
X-Gm-Message-State: AOJu0YyVbDnLvvkxnw55/UqMm/x+8fupE2RbyjmrAFrNBuE5I9USNHqM
 vBLyeke12arKo7XK4IcBItaaH1JkmDI+PqUmy/aPuxufCQmqT80owypnFjkC3btYzew3Ywfo4JR
 l7uS/d2QANXtFEFFlY+hC+8l6/27k32OpbxeQLvvRy5upwj4KUmc4uIERq7E7XGSfEojUYxo09B
 JSMzJoMRQmpLQnD9eTVzhpc3Rjq/6QVg==
X-Received: by 2002:a05:6512:3b0f:b0:539:fc42:e5ee with SMTP id
 2adb3069b0e04-53b348e3390mr16101841e87.29.1730754485491; 
 Mon, 04 Nov 2024 13:08:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEilcxosWM0mlnAh0+AD78EJERO2PbJL0ASfxlRCYYw92bt1r6Wnj6zVx5798PeU6VPMDzLfQ==
X-Received: by 2002:a05:6512:3b0f:b0:539:fc42:e5ee with SMTP id
 2adb3069b0e04-53b348e3390mr16101823e87.29.1730754485002; 
 Mon, 04 Nov 2024 13:08:05 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b65sm14428401f8f.4.2024.11.04.13.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:04 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 37/65] mem/cxl_type3: Fix overlapping region validation error
Message-ID: <5eabca7ec0a92032c7dd5188f1708344c225a385.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

When injecting a new poisoned region through qmp_cxl_inject_poison(),
the newly injected region should not overlap with existing poisoned
regions.

The current validation method does not consider the following
overlapping region:
┌───┬───────┬───┐
│a  │  b(a) │a  │
└───┴───────┴───┘
(a is a newly added region, b is an existing region, and b is a
 subregion of a)

Fixes: 9547754f40ee ("hw/cxl: QMP based poison injection support")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 44d491d8f6..16c60b9b0d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1381,9 +1381,7 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
     ct3d = CXL_TYPE3(obj);
 
     QLIST_FOREACH(p, &ct3d->poison_list, node) {
-        if (((start >= p->start) && (start < p->start + p->length)) ||
-            ((start + length > p->start) &&
-             (start + length <= p->start + p->length))) {
+        if ((start < p->start + p->length) && (start + length > p->start)) {
             error_setg(errp,
                        "Overlap with existing poisoned region not supported");
             return;
-- 
MST


