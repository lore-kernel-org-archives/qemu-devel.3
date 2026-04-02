Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A2D6AAE6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8KOO-0003P0-OI; Thu, 02 Apr 2026 11:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8KON-0003Oe-9o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8KOL-0004do-1h
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775145331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFC/aZGzTxLmM17Vi3pxXrjsia7yWz0IytizzMkqjfY=;
 b=Y1i3PZcaAOY6uaIm2LTHLonEX0wyTFuVg6KlIiqyfOT5nH0Yln19M6CyT9u7p2/WBNcpV+
 W6bhLWquG6RxuI6XvAnnAALrc31plO8qEA+wJg6UvlrpEctMLn4RsjfvMJx29G92RFYc2J
 hAh4whFi+DzQO9gj7qLLThAsnTplUNs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-RcughK9zPJCf6U94k_gQog-1; Thu, 02 Apr 2026 11:55:30 -0400
X-MC-Unique: RcughK9zPJCf6U94k_gQog-1
X-Mimecast-MFC-AGG-ID: RcughK9zPJCf6U94k_gQog_1775145328
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89f670976acso33085976d6.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775145328; x=1775750128; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NFC/aZGzTxLmM17Vi3pxXrjsia7yWz0IytizzMkqjfY=;
 b=DWeyQ7XqZaHdw4EJvqZm4+C0kTiGU4+QfNo78atr/3VExD2sliKtnKlb5Mdee6xCFg
 4adMdgVpTcGWmz8eGjt2ziGNxtQZS1jtk3io2kfqwtEbTOaDzFojfraWv/ocrmdZ7+ko
 XsyjT1KOE0yA59cGTyBMlPou/vP9y0mGFKMcfMRRE000SSu8RqR9lqSiO5IIcqDb0S8t
 2eVYZhs5pT3FBrdyiBg9ZZb/grjt/54gWyNpfpEoSHSSW3SebOnTfpfpBTqWCOZL1fsX
 ilkBHEPw3p+eYLL+l9r83yS94N4W/01rZBanpx0GAaR0pfXa6UuUFCs3Ez3SqCgjuL+2
 Xj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775145328; x=1775750128;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NFC/aZGzTxLmM17Vi3pxXrjsia7yWz0IytizzMkqjfY=;
 b=PHeSMJWmztut3oCBrgAPjb4CKiVP9GgJQuQ1PcY7gy1odR/1OvAEMn9NJvUwS4AMrO
 vjk4J/GLLGp7fhUmloreMp4JMea9r7hsAIggMgcsT0NY6GMffQ2oSyfySiwhsotCG0um
 GmiVTsATilopkouhm9Z0dAjoyPCOb7S8N+0KQrzXaHoxBsR4cN63HjKHUzz5ndEY9SQS
 +x2OqL0dxNJKAg64N948F5jEbe6wan5GokLeHM5FsmaPOubSaloMH1AX3QoLOIcs45XI
 YD/GLs+DAGExgdR9en7xchtAbS3H/uJuMx0Xiycks71hQi2wmlIZHnZKmBMLOiBQ6eWf
 4Scw==
X-Gm-Message-State: AOJu0Yyi7/9CV5Yumy+bseBZ3I6KHo2Xau1JADVhr94KJexOr+mi/eSf
 FmW2PTsnm1NePe/iDbBCbTF9jz+gTJGrYaQD9PZd8nWOxM7fTClf0z9SVvi796MPKHbQR+JJ2bj
 7B9NwBs4FwVukavqZfIME6dDonZTontGfv+ODwO1qChPJMuffMeM8+8u5399n2zcJ
X-Gm-Gg: AeBDietIZnkAqm3+4GlU82wEdWEXd4sj7sizO30jW6mX68gfoETQeMH63FYRFB8R0o+
 MXPLBzSVvdoxxnxRG2sTU9QDp2HPrMUycqqMwbifpLMubvjq8IIuiMjU08zd1ZpReda9IpQGq8y
 R3TMaufAXV4Tj1Pe5tFJvWk6vIOC2lqhLH8tX+F9nMpv9bGOgw1an8QbXdnGm+/QGockfT9oX0E
 PeK2m5UfrYUljDb6d62TUl+deMA7pkN6AEtxIaRMArNJsrfs5SVTkIhfaeJepx/3hwj8gQYPKdu
 9lIwip6ujXBG8qlAUWuIW0XnMpTY6/QJb+0xE38xSuhQe+Wa9vPcLIN2VEoAFGAZtexyZQBlyNr
 fJvhzqE3stylxJcwSe4Au+IdfbF5QfxhYDxhfi7PlCiPJsQ==
X-Received: by 2002:ad4:5c62:0:b0:89e:df5c:19f6 with SMTP id
 6a1803df08f44-8a439d90114mr113403526d6.42.1775145327953; 
 Thu, 02 Apr 2026 08:55:27 -0700 (PDT)
X-Received: by 2002:ad4:5c62:0:b0:89e:df5c:19f6 with SMTP id
 6a1803df08f44-8a439d90114mr113402996d6.42.1775145327492; 
 Thu, 02 Apr 2026 08:55:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a593908b47sm27851096d6.11.2026.04.02.08.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:55:27 -0700 (PDT)
Date: Thu, 2 Apr 2026 11:55:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 08/12] vfio/migration: Fix incorrect reporting for
 VFIO pending data
Message-ID: <ac6RbaA3V_jpfwJX@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-9-peterx@redhat.com>
 <e6a9aaf2-e2ab-4b25-a01d-b6093922668e@nvidia.com>
 <ac6LCWmVHl8fq81J@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac6LCWmVHl8fq81J@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Apr 02, 2026 at 11:28:09AM -0400, Peter Xu wrote:
> > Now that migration->stopcopy_size holds only the stopcopy size (and not
> > stopcopy+precopy), we should remove these lines from
> > vfio_update_estimated_pending_data():
> > 
> >     /* The total size remaining requires separate accounting */
> >     migration->stopcopy_size -= data_size;
> 
> Good point, I missed this part when changing the definition, I'll fix.

Instead of changing the definition, I found that it might be cleaner to
keep the definition of stopcopy cache variable for VFIO (considering the
other invokation during save setup), then just do one more step for math.

The new version should look like this:

===8<===

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 655ff7712a..5aff8de844 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -585,19 +585,27 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t remain;
+    uint64_t precopy_size, stopcopy_size;
 
     if (pending->exact) {
         vfio_state_pending_sync(vbasedev);
-        remain = migration->stopcopy_size;
     } else {
         if (!vfio_device_state_is_precopy(vbasedev)) {
             return;
         }
-        remain = migration->precopy_init_size + migration->precopy_dirty_size;
     }
 
-    pending->precopy_bytes += remain;
+    precopy_size =
+        migration->precopy_init_size + migration->precopy_dirty_size;
+
+    if (migration->stopcopy_size > precopy_size) {
+        stopcopy_size = migration->stopcopy_size - precopy_size;
+    } else {
+        stopcopy_size = 0;
+    }
+
+    pending->precopy_bytes += precopy_size;
+    pending->stopcopy_bytes += stopcopy_size;
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,

-- 
Peter Xu


