Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E013CEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 19:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so6qU-0005hk-6b; Tue, 10 Sep 2024 15:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so6qR-0005h2-Ry
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:48:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so6qO-0001GT-Q2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725997687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/uPNjEZ3cgB3E2obYzWtkwLhzYthyLtMFusyYoQ9Oyo=;
 b=T/aXdKtWuluKr/1w49TqQm4aghyHnsyh9BZaZGpgowN/amhyWI7mQfMOXXlxl+fvhfPY0P
 jp9nt/PVUWfYwIGTKeANGeAOwreD7AUcTylya5QPHVMrMYenfCploZ7e99wPwIcq+jPN4a
 k2EVg1R1K9Fe/2O5M2PtuU4xghuTeJA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-qwO2EdwBO5OSfO09WoiltA-1; Tue, 10 Sep 2024 15:48:06 -0400
X-MC-Unique: qwO2EdwBO5OSfO09WoiltA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c17f1a7011so103052196d6.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 12:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725997686; x=1726602486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uPNjEZ3cgB3E2obYzWtkwLhzYthyLtMFusyYoQ9Oyo=;
 b=dfOIjnHfcBi9X+QpYmddG+6gIo2uARPV4xYc2Flt6wDPsNeVcWmONkWpe0QXEaNRub
 AHySc3disb3M5fT8k57UISNHvBpHcMlcHngDVib/29IwPZWZjZrUDrX3BfPQ076oBuVb
 1PvOmB6O+XsftHcKB3N2kU/G8fK1oVByyaV5Zrs5qGldD18F1aTYVofULW3cd58+Pg/l
 dbERa7wAElT9hzTWQPITWF1qFujySxv2GEX0UuxpD5MBFYGIa+jnicw/t0zysnywV13K
 TVObnTDPCMXlgn0xgtf1eREsOw8yek4VhRca6XfpUZnoFS7P60dCtwwW2IeOXtKJ1sHD
 J32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwPBtq8qkLjSxRiNUm/ujBxZVohVaVz6MgT2l6Phcfn4YWtM+LVtWK/UOPU1ksv/7ROkD+7Fku9tVL@nongnu.org
X-Gm-Message-State: AOJu0YxxzXkUh52XEOLH6RtthmCl8X3LXPXwKxr/IQrSIX2E4/3WZW+3
 xTfW8iJvIJt5Io+sYjQu0/j55kGRJ0TZjDD7HrB24szagvEuJ65+rM5rYdkYipN9NyhhJmo0Kq3
 K4ek5gPaGGBTXDVgqpzlrlDfJ3N6Zvo8Awk6Stx/1kbCaqvjs2WxA
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id
 6a1803df08f44-6c5283fcaa9mr240912226d6.20.1725997685965; 
 Tue, 10 Sep 2024 12:48:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3gOSfMKCLV9JWWgLF9zArMAF6IDlKbnkhsllR6GYew3lgo99oHGMbm97rHfXzYlJBUorZSQ==
X-Received: by 2002:a05:6214:4888:b0:6c3:6e6f:794a with SMTP id
 6a1803df08f44-6c5283fcaa9mr240911866d6.20.1725997685558; 
 Tue, 10 Sep 2024 12:48:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534260969sm33227696d6.0.2024.09.10.12.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 12:48:04 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:48:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, mail@maciej.szmigiero.name
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZuCickYhs3nf2ERC@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6b4nosy.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 28, 2024 at 09:41:17PM -0300, Fabiano Rosas wrote:
> > +size_t multifd_device_state_payload_size(void)
> > +{
> > +    return sizeof(MultiFDDeviceState_t);
> > +}
> 
> This will not be necessary because the payload size is the same as the
> data type. We only need it for the special case where the MultiFDPages_t
> is smaller than the total ram payload size.

Today I was thinking maybe we should really clean this up, as the current
multifd_send_data_alloc() is indeed too tricky (blame me.. who requested
that more or less).  Knowing that VFIO can use dynamic buffers with ->idstr
and ->buf (I was thinking it could be buf[1M].. but I was wrong...) made
that feeling stronger.

I think we should change it now perhaps, otherwise we'll need to introduce
other helpers to e.g. reset the device buffers, and that's not only slow
but also not good looking, IMO.

So I went ahead with the idea in previous discussion, that I managed to
change the SendData union into struct; the memory consumption is not super
important yet, IMHO, but we should still stick with the object model where
multifd enqueue thread switch buffer with multifd, as it still sounds a
sane way to do.

Then when that patch is ready, I further tried to make VFIO reuse multifd
buffers just like what we do with MultiFDPages_t->offset[]: in RAM code we
don't allocate it every time we enqueue.

I hope it'll also work for VFIO.  VFIO has a specialty on being able to
dump the config space so it's more complex (and I noticed Maciej's current
design requires the final chunk of VFIO config data be migrated in one
packet.. that is also part of the complexity there).  So I allowed that
part to allocate a buffer but only that.  IOW, I made some API (see below)
that can either reuse preallocated buffer, or use a separate one only for
the final bulk.

In short, could both of you have a look at what I came up with below?  I
did that in patches because I think it's too much to comment, so patches
may work better.  No concern if any of below could be good changes to you,
then either Maciej can squash whatever into existing patches (and I feel
like some existing patches in this series can go away with below design),
or I can post pre-requisite patch but only if any of you prefer that.

Anyway, let me know, the patches apply on top of this whole series applied
first.

I also wonder whether there can be any perf difference already (I tested
all multifd qtest with below, but no VFIO I can run), perhaps not that
much, but just to mention below should avoid both buffer allocations and
one round of copy (so VFIO read() directly writes to the multifd buffers
now).

Thanks,

==========8<==========
From a6cbcf692b2376e72cc053219d67bb32eabfb7a6 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Sep 2024 12:10:59 -0400
Subject: [PATCH 1/3] migration/multifd: Make MultiFDSendData a struct

The newly introduced device state buffer can be used for either storing
VFIO's read() raw data, but already also possible to store generic device
states.  After noticing that device states may not easily provide a max
buffer size (also the fact that RAM MultiFDPages_t after all also want to
have flexibility on managing offset[] array), it may not be a good idea to
stick with union on MultiFDSendData.. as it won't play well with such
flexibility.

Switch MultiFDSendData to a struct.

It won't consume a lot more space in reality, after all the real buffers
were already dynamically allocated, so it's so far only about the two
structs (pages, device_state) that will be duplicated, but they're small.

With this, we can remove the pretty hard to understand alloc size logic.
Because now we can allocate offset[] together with the SendData, and
properly free it when the SendData is freed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h              | 16 +++++++++++-----
 migration/multifd-device-state.c |  8 ++++++--
 migration/multifd-nocomp.c       | 13 ++++++-------
 migration/multifd.c              | 25 ++++++-------------------
 4 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index c15c83104c..47203334b9 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -98,9 +98,13 @@ typedef struct {
     uint32_t num;
     /* number of normal pages */
     uint32_t normal_num;
+    /*
+     * Pointer to the ramblock.  NOTE: it's caller's responsibility to make
+     * sure the pointer is always valid!
+     */
     RAMBlock *block;
-    /* offset of each page */
-    ram_addr_t offset[];
+    /* offset array of each page, managed by multifd */
+    ram_addr_t *offset;
 } MultiFDPages_t;
 
 struct MultiFDRecvData {
@@ -123,7 +127,7 @@ typedef enum {
     MULTIFD_PAYLOAD_DEVICE_STATE,
 } MultiFDPayloadType;
 
-typedef union MultiFDPayload {
+typedef struct MultiFDPayload {
     MultiFDPages_t ram;
     MultiFDDeviceState_t device_state;
 } MultiFDPayload;
@@ -323,11 +327,13 @@ static inline uint32_t multifd_ram_page_count(void)
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
 int multifd_ram_flush_and_sync(void);
-size_t multifd_ram_payload_size(void);
+void multifd_ram_payload_alloc(MultiFDPages_t *pages);
+void multifd_ram_payload_free(MultiFDPages_t *pages);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
 
-size_t multifd_device_state_payload_size(void);
+void multifd_device_state_payload_alloc(MultiFDDeviceState_t *device_state);
+void multifd_device_state_payload_free(MultiFDDeviceState_t *device_state);
 void multifd_device_state_save_setup(void);
 void multifd_device_state_clear(MultiFDDeviceState_t *device_state);
 void multifd_device_state_save_cleanup(void);
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 9b364e8ef3..72b72b6e62 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -22,9 +22,13 @@ bool send_threads_abort;
 
 static MultiFDSendData *device_state_send;
 
-size_t multifd_device_state_payload_size(void)
+/* TODO: use static buffers for idstr and buf */
+void multifd_device_state_payload_alloc(MultiFDDeviceState_t *device_state)
+{
+}
+
+void multifd_device_state_payload_free(MultiFDDeviceState_t *device_state)
 {
-    return sizeof(MultiFDDeviceState_t);
 }
 
 void multifd_device_state_save_setup(void)
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 0b7b543f44..c1b95fee0d 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -22,15 +22,14 @@
 
 static MultiFDSendData *multifd_ram_send;
 
-size_t multifd_ram_payload_size(void)
+void multifd_ram_payload_alloc(MultiFDPages_t *pages)
 {
-    uint32_t n = multifd_ram_page_count();
+    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
+}
 
-    /*
-     * We keep an array of page offsets at the end of MultiFDPages_t,
-     * add space for it in the allocation.
-     */
-    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
+void multifd_ram_payload_free(MultiFDPages_t *pages)
+{
+    g_clear_pointer(&pages->offset, g_free);
 }
 
 void multifd_ram_save_setup(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index bebe5b5a9b..5a20b831cf 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -101,26 +101,12 @@ struct {
 
 MultiFDSendData *multifd_send_data_alloc(void)
 {
-    size_t max_payload_size, size_minus_payload;
+    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
 
-    /*
-     * MultiFDPages_t has a flexible array at the end, account for it
-     * when allocating MultiFDSendData. Use max() in case other types
-     * added to the union in the future are larger than
-     * (MultiFDPages_t + flex array).
-     */
-    max_payload_size = MAX(multifd_ram_payload_size(),
-                           multifd_device_state_payload_size());
-    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
-
-    /*
-     * Account for any holes the compiler might insert. We can't pack
-     * the structure because that misaligns the members and triggers
-     * Waddress-of-packed-member.
-     */
-    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
+    multifd_ram_payload_alloc(&new->u.ram);
+    multifd_device_state_payload_alloc(&new->u.device_state);
 
-    return g_malloc0(size_minus_payload + max_payload_size);
+    return new;
 }
 
 void multifd_send_data_clear(MultiFDSendData *data)
@@ -147,7 +133,8 @@ void multifd_send_data_free(MultiFDSendData *data)
         return;
     }
 
-    multifd_send_data_clear(data);
+    multifd_ram_payload_free(&data->u.ram);
+    multifd_device_state_payload_free(&data->u.device_state);
 
     g_free(data);
 }
-- 
2.45.0



From 6695d134c0818f42183f5ea03c21e6d56e7b57ea Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Sep 2024 12:24:14 -0400
Subject: [PATCH 2/3] migration/multifd: Optimize device_state->idstr updates

The duplication / allocation of idstr for each VFIO blob is an overkill, as
idstr isn't something that changes frequently.  Also, the idstr always came
from the upper layer of se->idstr so it's always guaranteed to
exist (e.g. no device unplug allowed during migration).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h              |  4 ++++
 migration/multifd-device-state.c | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 47203334b9..1eaa5d4496 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -115,6 +115,10 @@ struct MultiFDRecvData {
 };
 
 typedef struct {
+    /*
+     * Name of the owner device.  NOTE: it's caller's responsibility to
+     * make sure the pointer is always valid!
+     */
     char *idstr;
     uint32_t instance_id;
     char *buf;
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index 72b72b6e62..cfd0465bac 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -44,7 +44,7 @@ void multifd_device_state_save_setup(void)
 
 void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
 {
-    g_clear_pointer(&device_state->idstr, g_free);
+    device_state->idstr = NULL;
     g_clear_pointer(&device_state->buf, g_free);
 }
 
@@ -100,7 +100,12 @@ bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
 
     multifd_set_payload_type(device_state_send, MULTIFD_PAYLOAD_DEVICE_STATE);
     device_state = &device_state_send->u.device_state;
-    device_state->idstr = g_strdup(idstr);
+    /*
+     * NOTE: here we must use a static idstr (e.g. of a savevm state
+     * entry) rather than any dynamically allocated buffer, because multifd
+     * assumes this pointer is always valid!
+     */
+    device_state->idstr = idstr;
     device_state->instance_id = instance_id;
     device_state->buf = g_memdup2(data, len);
     device_state->buf_len = len;
@@ -137,7 +142,6 @@ static void multifd_device_state_save_thread_data_free(void *opaque)
 {
     struct MultiFDDSSaveThreadData *data = opaque;
 
-    g_clear_pointer(&data->idstr, g_free);
     g_free(data);
 }
 
-- 
2.45.0


From abfea9698ff46ad0e0175e1dcc6e005e0b2ece2a Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Sep 2024 12:27:49 -0400
Subject: [PATCH 3/3] migration/multifd: Optimize device_state buffer
 allocations

Provide a device_state->buf_prealloc so that the buffers can be reused if
possible.  Provide a set of APIs to use it right.  Please see the
documentation for the API in the code.

The default buffer size came from VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE as of
now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/vfio/vfio-common.h    |  9 ++++
 include/migration/misc.h         | 12 ++++-
 migration/multifd.h              | 11 +++-
 hw/vfio/migration.c              | 43 ++++++++-------
 migration/multifd-device-state.c | 93 +++++++++++++++++++++++++-------
 migration/multifd.c              |  9 ----
 6 files changed, 126 insertions(+), 51 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4578a0ca6a..c1f2f4ae55 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -61,6 +61,13 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+typedef struct VFIODeviceStatePacket {
+    uint32_t version;
+    uint32_t idx;
+    uint32_t flags;
+    uint8_t data[0];
+} QEMU_PACKED VFIODeviceStatePacket;
+
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
@@ -168,6 +175,8 @@ typedef struct VFIODevice {
     int devid;
     IOMMUFDBackend *iommufd;
     VFIOIOASHwpt *hwpt;
+    /* Only used on sender side when multifd is enabled */
+    VFIODeviceStatePacket *multifd_packet;
     QLIST_ENTRY(VFIODevice) hwpt_next;
 } VFIODevice;
 
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 26f7f3140f..1a8676ed3d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -112,8 +112,16 @@ bool migration_in_bg_snapshot(void);
 void dirty_bitmap_mig_init(void);
 
 /* migration/multifd-device-state.c */
-bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
-                                char *data, size_t len);
+struct MultiFDDeviceState_t;
+typedef struct MultiFDDeviceState_t MultiFDDeviceState_t;
+
+MultiFDDeviceState_t *
+multifd_device_state_prepare(char *idstr, uint32_t instance_id);
+void *multifd_device_state_get_buffer(MultiFDDeviceState_t *s,
+                                      int64_t *buf_len);
+bool multifd_device_state_finish(MultiFDDeviceState_t *state,
+                                 void *buf, int64_t buf_len);
+
 bool migration_has_device_state_support(void);
 
 void
diff --git a/migration/multifd.h b/migration/multifd.h
index 1eaa5d4496..1ccdeeb8c5 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -15,6 +15,7 @@
 
 #include "exec/target_page.h"
 #include "ram.h"
+#include "migration/misc.h"
 
 typedef struct MultiFDRecvData MultiFDRecvData;
 typedef struct MultiFDSendData MultiFDSendData;
@@ -114,16 +115,22 @@ struct MultiFDRecvData {
     off_t file_offset;
 };
 
-typedef struct {
+struct MultiFDDeviceState_t {
     /*
      * Name of the owner device.  NOTE: it's caller's responsibility to
      * make sure the pointer is always valid!
      */
     char *idstr;
     uint32_t instance_id;
+    /*
+     * Points to the buffer to send via multifd.  Normally it's the same as
+     * buf_prealloc, otherwise the caller needs to make sure the buffer is
+     * avaliable through multifd running.
+     */
     char *buf;
+    char *buf_prealloc;
     size_t buf_len;
-} MultiFDDeviceState_t;
+};
 
 typedef enum {
     MULTIFD_PAYLOAD_NONE,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 67996aa2df..e36422b7c5 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -59,13 +59,6 @@
 
 #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
 
-typedef struct VFIODeviceStatePacket {
-    uint32_t version;
-    uint32_t idx;
-    uint32_t flags;
-    uint8_t data[0];
-} QEMU_PACKED VFIODeviceStatePacket;
-
 static int64_t bytes_transferred;
 
 static const char *mig_state_to_str(enum vfio_device_mig_state state)
@@ -741,6 +734,9 @@ static void vfio_save_cleanup(void *opaque)
     migration->initial_data_sent = false;
     vfio_migration_cleanup(vbasedev);
     trace_vfio_save_cleanup(vbasedev->name);
+    if (vbasedev->multifd_packet) {
+        g_clear_pointer(&vbasedev->multifd_packet, g_free);
+    }
 }
 
 static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
@@ -892,7 +888,8 @@ static int vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbas
     g_autoptr(QIOChannelBuffer) bioc = NULL;
     QEMUFile *f = NULL;
     int ret;
-    g_autofree VFIODeviceStatePacket *packet = NULL;
+    VFIODeviceStatePacket *packet;
+    MultiFDDeviceState_t *state;
     size_t packet_len;
 
     bioc = qio_channel_buffer_new(0);
@@ -911,13 +908,19 @@ static int vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbas
     }
 
     packet_len = sizeof(*packet) + bioc->usage;
-    packet = g_malloc0(packet_len);
+
+    state = multifd_device_state_prepare(idstr, instance_id);
+    /*
+     * Do not reuse multifd buffer, but use our own due to random size.
+     * The buffer will be freed only when save cleanup.
+     */
+    vbasedev->multifd_packet = g_malloc0(packet_len);
+    packet = vbasedev->multifd_packet;
     packet->idx = idx;
     packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
     memcpy(&packet->data, bioc->data, bioc->usage);
 
-    if (!multifd_queue_device_state(idstr, instance_id,
-                                    (char *)packet, packet_len)) {
+    if (!multifd_device_state_finish(state, packet, packet_len)) {
         ret = -1;
     }
 
@@ -936,7 +939,6 @@ static int vfio_save_complete_precopy_thread(char *idstr,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     int ret;
-    g_autofree VFIODeviceStatePacket *packet = NULL;
     uint32_t idx;
 
     if (!migration->multifd_transfer) {
@@ -954,21 +956,25 @@ static int vfio_save_complete_precopy_thread(char *idstr,
         goto ret_finish;
     }
 
-    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
-
     for (idx = 0; ; idx++) {
+        VFIODeviceStatePacket *packet;
+        MultiFDDeviceState_t *state;
         ssize_t data_size;
         size_t packet_size;
+        int64_t buf_size;
 
         if (qatomic_read(abort_flag)) {
             ret = -ECANCELED;
             goto ret_finish;
         }
 
+        state = multifd_device_state_prepare(idstr, instance_id);
+        packet = multifd_device_state_get_buffer(state, &buf_size);
         data_size = read(migration->data_fd, &packet->data,
-                         migration->data_buffer_size);
+                         buf_size - sizeof(*packet));
         if (data_size < 0) {
             if (errno != ENOMSG) {
+                multifd_device_state_finish(state, NULL, 0);
                 ret = -errno;
                 goto ret_finish;
             }
@@ -980,14 +986,15 @@ static int vfio_save_complete_precopy_thread(char *idstr,
             data_size = 0;
         }
 
-        if (data_size == 0)
+        if (data_size == 0) {
+            multifd_device_state_finish(state, NULL, 0);
             break;
+        }
 
         packet->idx = idx;
         packet_size = sizeof(*packet) + data_size;
 
-        if (!multifd_queue_device_state(idstr, instance_id,
-                                        (char *)packet, packet_size)) {
+        if (!multifd_device_state_finish(state, packet, packet_size)) {
             ret = -1;
             goto ret_finish;
         }
diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index cfd0465bac..6f0259426d 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -20,15 +20,18 @@ ThreadPool *send_threads;
 int send_threads_ret;
 bool send_threads_abort;
 
+#define  MULTIFD_DEVICE_STATE_BUFLEN  (1UL << 20)
+
 static MultiFDSendData *device_state_send;
 
-/* TODO: use static buffers for idstr and buf */
 void multifd_device_state_payload_alloc(MultiFDDeviceState_t *device_state)
 {
+    device_state->buf_prealloc = g_malloc0(MULTIFD_DEVICE_STATE_BUFLEN);
 }
 
 void multifd_device_state_payload_free(MultiFDDeviceState_t *device_state)
 {
+    g_clear_pointer(&device_state->buf_prealloc, g_free);
 }
 
 void multifd_device_state_save_setup(void)
@@ -42,12 +45,6 @@ void multifd_device_state_save_setup(void)
     send_threads_abort = false;
 }
 
-void multifd_device_state_clear(MultiFDDeviceState_t *device_state)
-{
-    device_state->idstr = NULL;
-    g_clear_pointer(&device_state->buf, g_free);
-}
-
 void multifd_device_state_save_cleanup(void)
 {
     g_clear_pointer(&send_threads, thread_pool_free);
@@ -89,33 +86,89 @@ void multifd_device_state_send_prepare(MultiFDSendParams *p)
     multifd_device_state_fill_packet(p);
 }
 
-bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
-                                char *data, size_t len)
+/*
+ * Prepare to send some device state via multifd.  Returns the current idle
+ * MultiFDDeviceState_t*.
+ *
+ * As a follow up, the caller must call multifd_device_state_finish() to
+ * release the resources.
+ *
+ * One example usage of the API:
+ *
+ *   // Fetch a free multifd device state object
+ *   state = multifd_device_state_prepare(idstr, instance_id);
+ *
+ *   // Optional: fetch the buffer to reuse
+ *   buf = multifd_device_state_get_buffer(state, &buf_size);
+ *
+ *   // Here len>0 means success, otherwise failure
+ *   len = buffer_fill(buf, buf_size);
+ *
+ *   // Finish the transaction, either enqueue or cancel the request.  Here
+ *   // len>0 will enqueue, <=0 will cancel.
+ *   multifd_device_state_finish(state, buf, len);
+ */
+MultiFDDeviceState_t *
+multifd_device_state_prepare(char *idstr, uint32_t instance_id)
 {
-    /* Device state submissions can come from multiple threads */
-    QEMU_LOCK_GUARD(&queue_job_mutex);
     MultiFDDeviceState_t *device_state;
 
     assert(multifd_payload_empty(device_state_send));
 
-    multifd_set_payload_type(device_state_send, MULTIFD_PAYLOAD_DEVICE_STATE);
+    /*
+     * TODO: The lock name may need change, but I'm reusing just for
+     * simplicity.
+     */
+    qemu_mutex_lock(&queue_job_mutex);
+
     device_state = &device_state_send->u.device_state;
     /*
-     * NOTE: here we must use a static idstr (e.g. of a savevm state
-     * entry) rather than any dynamically allocated buffer, because multifd
+     * NOTE: here we must use a static idstr (e.g. of a savevm state entry)
+     * rather than any dynamically allocated buffer, because multifd
      * assumes this pointer is always valid!
      */
     device_state->idstr = idstr;
     device_state->instance_id = instance_id;
-    device_state->buf = g_memdup2(data, len);
-    device_state->buf_len = len;
 
-    if (!multifd_send(&device_state_send)) {
-        multifd_send_data_clear(device_state_send);
-        return false;
+    return &device_state_send->u.device_state;
+}
+
+/*
+ * Need to be used after a previous call to multifd_device_state_prepare(),
+ * the buffer must not be used after invoke multifd_device_state_finish().
+ */
+void *multifd_device_state_get_buffer(MultiFDDeviceState_t *s,
+                                      int64_t *buf_len)
+{
+    *buf_len = MULTIFD_DEVICE_STATE_BUFLEN;
+    return s->buf_prealloc;
+}
+
+/*
+ * Need to be used only in pair with a previous call to
+ * multifd_device_state_prepare().  Returns true if enqueue successful,
+ * false otherwise.
+ */
+bool multifd_device_state_finish(MultiFDDeviceState_t *state,
+                                 void *buf, int64_t buf_len)
+{
+    bool result = false;
+
+    /* Currently we only have one global free buffer */
+    assert(state == &device_state_send->u.device_state);
+
+    if (buf_len < 0) {
+        goto out;
     }
 
-    return true;
+    multifd_set_payload_type(device_state_send, MULTIFD_PAYLOAD_DEVICE_STATE);
+    /* This normally will be the state->buf_prealloc, but not required */
+    state->buf = buf;
+    state->buf_len = buf_len;
+    result = multifd_send(&device_state_send);
+out:
+    qemu_mutex_unlock(&queue_job_mutex);
+    return result;
 }
 
 bool migration_has_device_state_support(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index 5a20b831cf..2b5185e298 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -115,15 +115,6 @@ void multifd_send_data_clear(MultiFDSendData *data)
         return;
     }
 
-    switch (data->type) {
-    case MULTIFD_PAYLOAD_DEVICE_STATE:
-        multifd_device_state_clear(&data->u.device_state);
-        break;
-    default:
-        /* Nothing to do */
-        break;
-    }
-
     data->type = MULTIFD_PAYLOAD_NONE;
 }
 
-- 
2.45.0


-- 
Peter Xu


