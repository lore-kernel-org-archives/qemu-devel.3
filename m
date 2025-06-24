Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2B2C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU5m3-0008BP-DS; Tue, 24 Jun 2025 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uU5m1-0008B9-To
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uU5lv-0008UP-Tl
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750779677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zms4lYr3gLm2bfCf5P7l0DILcGn6mjg2lFvZPoz6Iuo=;
 b=UubjOkuepl8DuHMNuUQyWUj8Y7m/EIN5pSF6YSmGx12QQykG4g7h7DwESDVg7m+jIaGbVb
 Hur8SXy7Y68BKsDLsC/1ONAvYjPuJ6PeCETBZzHd2ZBAE7qyrtPjA3OxHbuMWVEJs5hBgX
 R06s44TCJLyv2BfLDhF3gwOx8HsgHH0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-DQy8ZvQlMX-Jx--HUYk5PA-1; Tue, 24 Jun 2025 11:41:16 -0400
X-MC-Unique: DQy8ZvQlMX-Jx--HUYk5PA-1
X-Mimecast-MFC-AGG-ID: DQy8ZvQlMX-Jx--HUYk5PA_1750779675
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7d38f565974so939706485a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750779675; x=1751384475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zms4lYr3gLm2bfCf5P7l0DILcGn6mjg2lFvZPoz6Iuo=;
 b=ZpJA+lAz/0ocY8VpO96qZSx3bUL1qqSrqaZJgXENJYJkCGF966demfd+Jf+JoPw6pk
 J1bOLZ05BgQ30HrTQT0UnNaMHvtqkR/dcI45W9tgw8/0VZGK/Z1MqDQE/UOsEtMs/fv8
 oc5ShWohsdRsCelcgWYzbzG7rzxGPnZQ5nlz02qKkLVX88ABx70Y2u7K++4BN9V6cq/Y
 sHkbp/UNv2skCPrXSh70ZfWfjwMTGpWh8AxIuhO8wu4wypElZ7VXyZmoJ6+Ov2090QOf
 ++HlIBgHD1/vghK3fQkMEkGR0ehNU1K5daFNFB2n/uQv8+kffEmExvonf4YV26qiM02y
 m4lw==
X-Gm-Message-State: AOJu0YxS+nQMxX4SXjgU5EkzG9LfMyDCjaTgxUgPM6X0ARtUzaowfXbs
 hz2Qd9ywjAtO3Bb58JiZ7CLADgWCakazTxzwuh6hjxHVKS3MgNSOKjyWHYdsZOTKhcadhtJNpsX
 SA8n4TSQJ+A0BeN379C89WTds4k6PDoawJBBM/naLdJDHHTHUIUUScq6m
X-Gm-Gg: ASbGncuhrH5sqE3l09TUp2aF6+AOx7xcUewKYACBjNWpH5p2uesOadvbPLz4IwdyUvc
 yG9JMIfO0QB/UsaweYFwOWujFkzS1kQwFRPO8lRCmw8aUXmBTIg0weOQ3el5BdPfji9bBV45a3e
 iM0oVVLPGuOsxhrKWtqHx3FZEKrthAtCUO+ajp5UvAXm8xY1O22ZmMXk/lOnMdPoxAARVAWxe0g
 oGGe3CiBSDXoFPYHCG4zT7pjZlQ8vrGTXlKkWXbya78FRefYGN9ryuaV3lTBJsKBjlv8dzhff2A
 odo+xd/BV6Memw==
X-Received: by 2002:a05:620a:a1d9:20b0:7d4:1e7a:d17e with SMTP id
 af79cd13be357-7d41ec19eedmr406001985a.8.1750779675604; 
 Tue, 24 Jun 2025 08:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt4iyfj8l2ZJB2Uqy0/Un4w445ub7AfyafOEty8MumxPTeWBsA387dolwo6ot7novbIp4liw==
X-Received: by 2002:a05:620a:a1d9:20b0:7d4:1e7a:d17e with SMTP id
 af79cd13be357-7d41ec19eedmr405999785a.8.1750779675168; 
 Tue, 24 Jun 2025 08:41:15 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3f999c07bsm520816485a.4.2025.06.24.08.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 08:41:14 -0700 (PDT)
Date: Tue, 24 Jun 2025 11:41:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Message-ID: <aFrHF4hKTdAgRpfs@x1.local>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-7-peterx@redhat.com>
 <oo4t2s5rz4uaivfm3vejlum5c7efsjiysbavtt24rinoefs2tk@ihtornpsiz5q>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oo4t2s5rz4uaivfm3vejlum5c7efsjiysbavtt24rinoefs2tk@ihtornpsiz5q>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 24, 2025 at 04:36:39PM +0200, Juraj Marcin wrote:

[...]

> There are still mentions of 'save_live_complete_precopy' in:
> 
>     include/migration/register.h:100
>         * parallel with @save_live_complete_precopy handlers.
>     docs/devel/migration/vfio.rst:78
>         * A ``save_live_complete_precopy`` function that sets the VFIO device in
>     docs/devel/migration/vfio.rst:198
>         .save_live_complete_precopy() is called for each active device
>     docs/devel/migration/vfio.rst:200
>         .save_live_complete_precopy() until
>     docs/devel/migration/main.rst:511
>         - A ``save_live_complete_precopy`` function that must transmit the

Good catch.  If I prepare this fixup to be squashed, can I get your R-b?

From 58147b11276fa193c25f35e63f41a8e34d444dd9 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 24 Jun 2025 11:38:17 -0400
Subject: [PATCH] fixup! migration: Rename save_live_complete_precopy to
 save_complete

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/main.rst |  4 ++--
 docs/devel/migration/vfio.rst | 12 ++++++------
 include/migration/register.h  |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index cdd4f4a6d7..6493c1d2bc 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -508,8 +508,8 @@ An iterative device must provide:
     the point that stream bandwidth limits tell it to stop.  Each call
     generates one section.
 
-  - A ``save_live_complete_precopy`` function that must transmit the
-    last section for the device containing any remaining data.
+  - A ``save_complete`` function that must transmit the last section for
+    the device containing any remaining data.
 
   - A ``load_state`` function used to load sections generated by
     any of the save functions that generate sections.
diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 673e354754..8ff5ab0c74 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -75,10 +75,10 @@ VFIO implements the device hooks for the iterative approach as follows:
   in the non-multifd mode.
   In the multifd mode it just emits either a dummy EOS marker.
 
-* A ``save_live_complete_precopy`` function that sets the VFIO device in
-  _STOP_COPY state and iteratively copies the data for the VFIO device until
-  the vendor driver indicates that no data remains.
-  In the multifd mode it just emits a dummy EOS marker.
+* A ``save_complete`` function that sets the VFIO device in _STOP_COPY
+  state and iteratively copies the data for the VFIO device until the
+  vendor driver indicates that no data remains.  In the multifd mode it
+  just emits a dummy EOS marker.
 
 * A ``save_live_complete_precopy_thread`` function that in the multifd mode
   provides thread handler performing multifd device state transfer.
@@ -195,9 +195,9 @@ Live migration save path
                                       |
                 Then the VFIO device is put in _STOP_COPY state
                      (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
-         .save_live_complete_precopy() is called for each active device
+               .save_complete() is called for each active device
               For the VFIO device: in the non-multifd mode iterate in
-                        .save_live_complete_precopy() until
+                             .save_complete() until
                                pending data is 0
 	          In the multifd mode this iteration is done in
 	          .save_live_complete_precopy_thread() instead.
diff --git a/include/migration/register.h b/include/migration/register.h
index 0510534515..2a26e76a68 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -103,7 +103,7 @@ typedef struct SaveVMHandlers {
      * Called at the end of a precopy phase from a separate worker thread
      * in configurations where multifd device state transfer is supported
      * in order to perform asynchronous transmission of the remaining data in
-     * parallel with @save_live_complete_precopy handlers.
+     * parallel with @save_complete handlers.
      * When postcopy is enabled, devices that support postcopy will skip this
      * step.
      *
-- 
2.49.0


> 
> Also, should we also drop "live" from
> 'save_live_complete_precopy_thread' as well? IIUC they are called
> together with (now) 'save_complete()' during precopy.

Agreed, though it's better done in a separate one.

If so, wanna send a patch? :)

PS: would be nice if on top of this series, then I can collect them together.

Thanks!

-- 
Peter Xu


