Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4733AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngI-0000Bn-Tt; Mon, 11 Mar 2024 17:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngG-0000Ah-Td
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngF-0003xu-BB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwyy8rtdLNCpslvbHPqDS/nmA49F1iWnhudQzO3o784=;
 b=gA+usf2zp6Ce6nXSuSqmlsCV7c0ZTcmk/XHA7EzxPEDivskidnKEA3akfs29m1oV5ooTfW
 hRAL/yWHnRA84WdltaqphrI4bupzP8sfT8dLxtfPrdUX+koh//gCQP/bUs+C8SXGfBDXP6
 bo+w4tDPWRaYDY21SxMedcpmvcRMMQ4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-Ucrsj4nwMPSON_aTYjAsXg-1; Mon, 11 Mar 2024 17:59:32 -0400
X-MC-Unique: Ucrsj4nwMPSON_aTYjAsXg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15026386d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194372; x=1710799172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwyy8rtdLNCpslvbHPqDS/nmA49F1iWnhudQzO3o784=;
 b=LqYqxJCkXdJOaE95wcOEq/DNGAGlPPHDIoL7yr/K0xQ8M9Hl621VNyihkuccCSAakG
 oz5N3jMm618kxtmJk24jDmHrOTsNOS++TpBObj7M2PsZGty3UR9O/EZoivkXwpbZElC9
 BgyGMU2WU62fIbKmBd8Sy4M6JNPj3wRBE4LzOvRcqSBKpYLEVV95vsrilkJan8h8GFnF
 vdFbcJGxwqmal0MPZsXj1ghUoExRMwVscxg4Ql9gnCHNcaoTVwPXqPycaEJB7auE/USD
 1BqHd5x2i4XTXOe9bqp/xpDRJIzAs/Ut+CytIugPYJJgrZmXwtZ/iPSH/uIycePUSc6T
 +ggQ==
X-Gm-Message-State: AOJu0YyaqEjBMnBWl+vVBGFMMSreG9zwP++BpGFlawVQjjWdD47HUsL+
 AAyetOVUhZozgq1P5pTlWVORYyoc41qe+o5Egd3EydYIzDC2khEu6jXukPN3JnHaeVC52Q+IQOh
 6wQJsbQseIFOm6Rs8+eiaROUuRFuZF7W6IWizsYRFOW6ol7SaV+8xbMq8huLJmyX6vrNp6c5Yaq
 vvKlHn48sABbGxRRzo80f02+Z1dnlFR/inUg==
X-Received: by 2002:a05:6214:b6a:b0:690:ca31:f070 with SMTP id
 ey10-20020a0562140b6a00b00690ca31f070mr5305036qvb.2.1710194372131; 
 Mon, 11 Mar 2024 14:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPtYvRgKglwS5jyZdSISMmu08wk8u4NUN8bEuMHipzZ9gx06K2n7D4LOqq8FHuw65pqRpjDg==
X-Received: by 2002:a05:6214:b6a:b0:690:ca31:f070 with SMTP id
 ey10-20020a0562140b6a00b00690ca31f070mr5305017qvb.2.1710194371727; 
 Mon, 11 Mar 2024 14:59:31 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:31 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 03/34] vfio/migration: Add a note about migration rate limiting
Date: Mon, 11 Mar 2024 17:58:54 -0400
Message-ID: <20240311215925.40618-4-peterx@redhat.com>
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

From: Avihai Horon <avihaih@nvidia.com>

VFIO migration buffer size is currently limited to 1MB. Therefore, there
is no need to check if migration rate exceeded, as in the worst case it
will exceed by only 1MB.

However, if the buffer size is later changed to a bigger value,
vfio_save_iterate() should enforce migration rate (similar to migration
RAM code).

Add a note about this in vfio_save_iterate() to serve as a reminder.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240304105339.20713-4-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 0af783a589..f82dcabc49 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -505,6 +505,12 @@ static bool vfio_is_active_iterate(void *opaque)
     return vfio_device_state_is_precopy(vbasedev);
 }
 
+/*
+ * Note about migration rate limiting: VFIO migration buffer size is currently
+ * limited to 1MB, so there is no need to check if migration rate exceeded (as
+ * in the worst case it will exceed by 1MB). However, if the buffer size is
+ * later changed to a bigger value, migration rate should be enforced here.
+ */
 static int vfio_save_iterate(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
-- 
2.44.0


