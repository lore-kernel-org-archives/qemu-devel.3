Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49A9C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nZ-00011I-10; Wed, 03 Jul 2024 18:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nX-0000ap-4M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nU-0007Bj-KE
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q9nP82XxVIGsGRwJDQ3jJpLzlD/V4rH3MYQjc7zH+sg=;
 b=As3DU3TFfHnRfPTrKFOuwhd3jxqLXzZQGvHw0oFn6w2EaSaap5pSTJr9/KG6KVv3ZH617H
 gRwOYwvnQAgHoK2meuGH+1hiXpmN3hf18Ul/3s6q3pjrruzJMKuOUYgXlqqATqVLV5IDLG
 PrdTzbPRCyxNGm3anpUEe+P5I8KSZBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-xWGoHoW4M4aUKyNRuN2fsw-1; Wed, 03 Jul 2024 18:49:54 -0400
X-MC-Unique: xWGoHoW4M4aUKyNRuN2fsw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256849a9f4so965e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046993; x=1720651793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9nP82XxVIGsGRwJDQ3jJpLzlD/V4rH3MYQjc7zH+sg=;
 b=CWolMwfjx6ux0DiBOpbkM+i/KduzQOrbZNvWmIYsXREMEdL70jiJqoIZok+n1jzU/b
 /ZhyqZ1R0Ma2/FHDvb06UB18/Vmvp8s6Ka1gX8yrgmmdHedImx1cBWXKQ5mnVTeVYZ/7
 gC+HcVr6Ug4IslvymBpnYvJId0qJdUl5RYf8eU7yaMaoOMyQJGo7KIOrAkIb9ulLVSju
 6Wc2K72IZRLseXlwvLCSgjGGR26iW/OzdEQJ9wdG148hd5g0pNxAZq27JftLsR24bpd2
 HCl/Mnh+FkM5YXQNtErOb84/4pnlyFbk7NUeciz3kpTUucUVZm/ILssUDh4+Otlh0M1b
 7Arw==
X-Gm-Message-State: AOJu0YwWCiA7Q7tD0d2iydQk0VxZIgRgg+Zu/DWdWmLJ0kqMobyVepsT
 HytXwMFnJ33JoD28wlr9AAq6uaPw887G3ZDjvVaG59S+Eh4VDXE8GWq42jw0jUpvB/qwm3W/J7A
 I+t5QDSHEfOtpbwxwRFc2kq2cgXUVOuo+pRVLUaVaCE57yyu6LFiLzZ561eYGyMK2sjh6JAuSgv
 XVgU4+0SFCgNNX5q5iZKMKTCTdrnE02A==
X-Received: by 2002:a05:600c:4186:b0:425:7c99:eb59 with SMTP id
 5b1f17b1804b1-4264a4691e9mr280885e9.33.1720046993257; 
 Wed, 03 Jul 2024 15:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTDdCZgGlkZy3KakJjfhD8geH13pphOvEbUy3XMHmbRT/bhtbjFIiVyBn3km0P9XK0tt6gXw==
X-Received: by 2002:a05:600c:4186:b0:425:7c99:eb59 with SMTP id
 5b1f17b1804b1-4264a4691e9mr280705e9.33.1720046992618; 
 Wed, 03 Jul 2024 15:49:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a283551sm1137735e9.42.2024.07.03.15.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:51 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL v3 72/85] hw/cxl/events: Improve QMP interfaces and
 documentation for add/release dynamic capacity.
Message-ID: <efc4ad6f9901bbba08c0e11443ba89f18b1a28e9.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

New DCD command definitions updated in response to review comments
from Markus.

- Used CxlXXXX instead of CXLXXXXX for newly added types.
- Expanded some abreviations in type names to be easier to read.
- Additional documentation for some fields.
- Replace slightly vague cxl r3.1 references with
  "Compute Express Link (CXL) Specification, Revision 3.1, XXXX"
  to bring them inline with what it says on the specification cover.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240625170805.359278-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/cxl.json            | 144 ++++++++++++++++++++++++---------------
 hw/mem/cxl_type3.c       |  18 ++---
 hw/mem/cxl_type3_stubs.c |   8 +--
 3 files changed, 103 insertions(+), 67 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 57d9f82014..a38622a0d1 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -363,9 +363,11 @@
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
 
 ##
-# @CXLDynamicCapacityExtent:
+# @CxlDynamicCapacityExtent:
 #
-# A single dynamic capacity extent
+# A single dynamic capacity extent.  This is a contiguous allocation
+# of memory by Device Physical Address within a single Dynamic
+# Capacity Region on a CXL Type 3 Device.
 #
 # @offset: The offset (in bytes) to the start of the region
 #     where the extent belongs to.
@@ -374,7 +376,7 @@
 #
 # Since: 9.1
 ##
-{ 'struct': 'CXLDynamicCapacityExtent',
+{ 'struct': 'CxlDynamicCapacityExtent',
   'data': {
       'offset':'uint64',
       'len': 'uint64'
@@ -382,22 +384,40 @@
 }
 
 ##
-# @CXLExtSelPolicy:
+# @CxlExtentSelectionPolicy:
 #
 # The policy to use for selecting which extents comprise the added
-# capacity, as defined in cxl spec r3.1 Table 7-70.
+# capacity, as defined in Compute Express Link (CXL) Specification,
+# Revision 3.1, Table 7-70.
 #
-# @free: 0h = Free
+# @free: Device is responsible for allocating the requested memory
+#     capacity and is free to do this using any combination of
+#     supported extents.
 #
-# @contiguous: 1h = Continuous
+# @contiguous: Device is responsible for allocating the requested
+#     memory capacity but must do so as a single contiguous
+#     extent.
 #
-# @prescriptive: 2h = Prescriptive
+# @prescriptive: The precise set of extents to be allocated is
+#     specified by the command.  Thus allocation is being managed
+#     by the issuer of the allocation command, not the device.
 #
-# @enable-shared-access: 3h = Enable Shared Access
+# @enable-shared-access: Capacity has already been allocated to a
+#     different host using free, contiguous or prescriptive policy
+#     with a known tag.  This policy then instructs the device to
+#     make the capacity with the specified tag available to an
+#     additional host.  Capacity is implicit as it matches that
+#     already associated with the tag.  Note that the extent list
+#     (and hence Device Physical Addresses) used are per host, so
+#     a device may use different representations on each host.
+#     The ordering of the extents provided to each host is indicated
+#     to the host using per extent sequence numbers generated by
+#     the device.  Has a similar meaning for temporal sharing, but
+#     in that case there may be only one host involved.
 #
 # Since: 9.1
 ##
-{ 'enum': 'CXLExtSelPolicy',
+{ 'enum': 'CxlExtentSelectionPolicy',
   'data': ['free',
            'contiguous',
            'prescriptive',
@@ -407,54 +427,60 @@
 ##
 # @cxl-add-dynamic-capacity:
 #
-# Command to initiate to add dynamic capacity extents to a host.  It
-# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
+# Initiate adding dynamic capacity extents to a host.  This simulates
+# operations defined in Compute Express Link (CXL) Specification,
+# Revision 3.1, Section 7.6.7.6.5. Note that, currently, establishing
+# success or failure of the full Add Dynamic Capacity flow requires
+# out of band communication with the OS of the CXL host.
 #
-# @path: CXL DCD canonical QOM path.
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-# @host-id: The "Host ID" field as defined in cxl spec r3.1
-#     Table 7-70.
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-70.
 #
 # @selection-policy: The "Selection Policy" bits as defined in
-#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
-#     selecting which extents comprise the added capacity.
+#     Compute Express Link (CXL) Specification, Revision 3.1,
+#     Table 7-70.  It specifies the policy to use for selecting
+#     which extents comprise the added capacity.
 #
-# @region: The "Region Number" field as defined in cxl spec r3.1
-#     Table 7-70.  The dynamic capacity region where the capacity
-#     is being added.  Valid range is from 0-7.
+# @region: The "Region Number" field as defined in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-70.  Valid
+#     range is from 0-7.
 #
-# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-70.
 #
-# @extents: The "Extent List" field as defined in cxl spec r3.1
-#     Table 7-70.
+# @extents: The "Extent List" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-70.
 #
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
   'data': { 'path': 'str',
             'host-id': 'uint16',
-            'selection-policy': 'CXLExtSelPolicy',
+            'selection-policy': 'CxlExtentSelectionPolicy',
             'region': 'uint8',
             '*tag': 'str',
-            'extents': [ 'CXLDynamicCapacityExtent' ]
+            'extents': [ 'CxlDynamicCapacityExtent' ]
            }
 }
 
 ##
-# @CXLExtRemovalPolicy:
+# @CxlExtentRemovalPolicy:
 #
 # The policy to use for selecting which extents comprise the released
-# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
+# capacity, defined in the "Flags" field in Compute Express Link (CXL)
+# Specification, Revision 3.1, Table 7-71.
 #
-# @tag-based: value = 0h.  Extents are selected by the device based
-#     on tag, with no requirement for contiguous extents.
+# @tag-based: Extents are selected by the device based on tag, with
+#     no requirement for contiguous extents.
 #
-# @prescriptive: value = 1h.  Extent list of capacity to release is
-#     included in the request payload.
+# @prescriptive: Extent list of capacity to release is included in
+#     the request payload.
 #
 # Since: 9.1
 ##
-{ 'enum': 'CXLExtRemovalPolicy',
+{ 'enum': 'CxlExtentRemovalPolicy',
   'data': ['tag-based',
            'prescriptive']
 }
@@ -462,45 +488,55 @@
 ##
 # @cxl-release-dynamic-capacity:
 #
-# Command to initiate to release dynamic capacity extents from a
-# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
+# Initiate release of dynamic capacity extents from a host.  This
+# simulates operations defined in Compute Express Link (CXL)
+# Specification, Revision 3.1, Section 7.6.7.6.6. Note that,
+# currently, success or failure of the full Release Dynamic Capacity
+# flow requires out of band communication with the OS of the CXL host.
 #
-# @path: CXL DCD canonical QOM path.
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-# @host-id: The "Host ID" field as defined in cxl spec r3.1
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-71.
+#
+# @removal-policy: Bit[3:0] of the "Flags" field as defined in
+#     Compute Express Link (CXL) Specification, Revision 3.1,
 #     Table 7-71.
 #
-# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
-#     spec r3.1 Table 7-71.
+# @forced-removal: Bit[4] of the "Flags" field in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.  When set,
+#     the device does not wait for a Release Dynamic Capacity command
+#     from the host.  Instead, the host immediately looses access to
+#     the released capacity.
 #
-# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
-#     Table 7-71.  When set, device does not wait for a Release
-#     Dynamic Capacity command from the host.  Host immediately
-#     loses access to released capacity.
+# @sanitize-on-release: Bit[5] of the "Flags" field in Compute
+#     Express Link (CXL) Specification, Revision 3.1, Table 7-71.
+#     When set, the device should sanitize all released capacity as
+#     a result of this request. This ensures that all user data
+#     and metadata is made permanently unavailable by whatever
+#     means is appropriate for the media type. Note that changing
+#     encryption keys is not sufficient.
 #
-# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
-#     Table 7-71.  When set, device should sanitize all released
-#     capacity as a result of this request.
+# @region: The "Region Number" field as defined in Compute Express
+#     Link Specification, Revision 3.1, Table 7-71.  Valid range
+#     is from 0-7.
 #
-# @region: The "Region Number" field as defined in cxl spec r3.1
-#     Table 7-71.  The dynamic capacity region where the capacity
-#     is being added.  Valid range is from 0-7.
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-71.
 #
-# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
-#
-# @extents: The "Extent List" field as defined in cxl spec r3.1
-#     Table 7-71.
+# @extents: The "Extent List" field as defined in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
   'data': { 'path': 'str',
             'host-id': 'uint16',
-            'removal-policy': 'CXLExtRemovalPolicy',
+            'removal-policy': 'CxlExtentRemovalPolicy',
             '*forced-removal': 'bool',
             '*sanitize-on-release': 'bool',
             'region': 'uint8',
             '*tag': 'str',
-            'extents': [ 'CXLDynamicCapacityExtent' ]
+            'extents': [ 'CxlDynamicCapacityExtent' ]
            }
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3274e5dcbb..35ac59883a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1874,7 +1874,7 @@ static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
  */
 static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         uint16_t hid, CXLDCEventType type, uint8_t rid,
-        CXLDynamicCapacityExtentList *records, Error **errp)
+        CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
     CXLEventDynamicCapacity dCap = {};
@@ -1882,7 +1882,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CXLType3Dev *dcd;
     uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
-    CXLDynamicCapacityExtentList *list;
+    CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
     uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
@@ -2032,13 +2032,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
-                                  CXLExtSelPolicy sel_policy, uint8_t region,
-                                  const char *tag,
-                                  CXLDynamicCapacityExtentList  *extents,
+                                  CxlExtentSelectionPolicy sel_policy,
+                                  uint8_t region, const char *tag,
+                                  CxlDynamicCapacityExtentList  *extents,
                                   Error **errp)
 {
     switch (sel_policy) {
-    case CXL_EXT_SEL_POLICY_PRESCRIPTIVE:
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id,
                                                       DC_EVENT_ADD_CAPACITY,
                                                       region, extents, errp);
@@ -2050,14 +2050,14 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
 }
 
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
-                                      CXLExtRemovalPolicy removal_policy,
+                                      CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
                                       bool forced_removal,
                                       bool has_sanitize_on_release,
                                       bool sanitize_on_release,
                                       uint8_t region,
                                       const char *tag,
-                                      CXLDynamicCapacityExtentList  *extents,
+                                      CxlDynamicCapacityExtentList  *extents,
                                       Error **errp)
 {
     CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
@@ -2070,7 +2070,7 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     }
 
     switch (removal_policy) {
-    case CXL_EXT_REMOVAL_POLICY_PRESCRIPTIVE:
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id, type,
                                                       region, extents, errp);
         return;
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 45419bbefe..c1a5e4a7c1 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -70,24 +70,24 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 void qmp_cxl_add_dynamic_capacity(const char *path,
                                   uint16_t host_id,
-                                  CXLExtSelPolicy sel_policy,
+                                  CxlExtentSelectionPolicy sel_policy,
                                   uint8_t region,
                                   const char *tag,
-                                  CXLDynamicCapacityExtentList *extents,
+                                  CxlDynamicCapacityExtentList *extents,
                                   Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
-                                      CXLExtRemovalPolicy removal_policy,
+                                      CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
                                       bool forced_removal,
                                       bool has_sanitize_on_release,
                                       bool sanitize_on_release,
                                       uint8_t region,
                                       const char *tag,
-                                      CXLDynamicCapacityExtentList *extents,
+                                      CxlDynamicCapacityExtentList *extents,
                                       Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
-- 
MST


