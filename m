Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16E5C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 11:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbI8j-0005r9-T6; Tue, 06 Aug 2024 07:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1sbI8S-0005og-NL; Tue, 06 Aug 2024 07:13:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1sbI8G-00019L-3N; Tue, 06 Aug 2024 07:13:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WdVwL6TShz6K7Fc;
 Tue,  6 Aug 2024 19:10:42 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (unknown [7.191.163.213])
 by mail.maildlp.com (Postfix) with ESMTPS id 19489140B3C;
 Tue,  6 Aug 2024 19:13:26 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 12:13:25 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.039; 
 Tue, 6 Aug 2024 12:13:25 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Jonathan Cameron <jonathan.cameron@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v5 6/7] acpi/ghes: add support for generic error injection
 via QAPI
Thread-Topic: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Thread-Index: AQHa5SUqlFywcvx4lEKDYS91pOZMWrIaGOEQ
Date: Tue, 6 Aug 2024 11:13:25 +0000
Message-ID: <e41d0c8cc8b54643adc318c1bb7bd26c@huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
In-Reply-To: <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.150.120]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>-----Original Message-----
>From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>Sent: 02 August 2024 22:44
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>; Shiju Jose
><shiju.jose@huawei.com>; Mauro Carvalho Chehab
><mchehab+huawei@kernel.org>; Michael S. Tsirkin <mst@redhat.com>; Ani
>Sinha <anisinha@redhat.com>; Dongjiu Geng <gengdongjiu1@gmail.com>; Igor
>Mammedov <imammedo@redhat.com>; linux-kernel@vger.kernel.org; qemu-
>arm@nongnu.org; qemu-devel@nongnu.org
>Subject: [PATCH v5 6/7] acpi/ghes: add support for generic error injection=
 via
>QAPI
>
>Provide a generic interface for error injection via GHESv2.
>
>This patch is co-authored:
>    - original ghes logic to inject a simple ARM record by Shiju Jose;
>    - generic logic to handle block addresses by Jonathan Cameron;
>    - generic GHESv2 error inject by Mauro Carvalho Chehab;
>
>Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
>Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Shiju Jose <shiju.jose@huawei.com>
>Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

>---
> hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> hw/acpi/ghes_cper.c    |   2 +-
> include/hw/acpi/ghes.h |   3 +
> 3 files changed, 152 insertions(+), 12 deletions(-)
>
>diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c index
>a745dcc7be5e..e125c9475773 100644
>--- a/hw/acpi/ghes.c
>+++ b/hw/acpi/ghes.c
>@@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags,
>FWCfgState *s,
>     ags->present =3D true;
> }
>
>+static uint64_t ghes_get_state_start_address(void)
>+{
>+    AcpiGedState *acpi_ged_state =3D
>+        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
>+    AcpiGhesState *ags =3D &acpi_ged_state->ghes_state;
>+
>+    return le64_to_cpu(ags->ghes_addr_le); }
>+
> int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)=
  {
>     uint64_t error_block_addr, read_ack_register_addr, read_ack_register =
=3D 0;
>-    uint64_t start_addr;
>+    uint64_t start_addr =3D ghes_get_state_start_address();
>     bool ret =3D -1;
>-    AcpiGedState *acpi_ged_state;
>-    AcpiGhesState *ags;
>-
>     assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
>
>-    acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GE=
D,
>-                                                       NULL));
>-    g_assert(acpi_ged_state);
>-    ags =3D &acpi_ged_state->ghes_state;
>-
>-    start_addr =3D le64_to_cpu(ags->ghes_addr_le);
>-
>     if (physical_address) {
>         start_addr +=3D source_id * sizeof(uint64_t);
>
>@@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id,
>uint64_t physical_address)
>     return ret;
> }
>
>+/*
>+ * Error register block data layout
>+ *
>+ * | +---------------------+ ges.ghes_addr_le
>+ * | |error_block_address0 |
>+ * | +---------------------+
>+ * | |error_block_address1 |
>+ * | +---------------------+ --+--
>+ * | |    .............    | GHES_ADDRESS_SIZE
>+ * | +---------------------+ --+--
>+ * | |error_block_addressN |
>+ * | +---------------------+
>+ * | | read_ack0           |
>+ * | +---------------------+ --+--
>+ * | | read_ack1           | GHES_ADDRESS_SIZE
>+ * | +---------------------+ --+--
>+ * | |   .............     |
>+ * | +---------------------+
>+ * | | read_ackN           |
>+ * | +---------------------+ --+--
>+ * | |      CPER           |   |
>+ * | |      ....           | GHES_MAX_RAW_DATA_LENGT
>+ * | |      CPER           |   |
>+ * | +---------------------+ --+--
>+ * | |    ..........       |
>+ * | +---------------------+
>+ * | |      CPER           |
>+ * | |      ....           |
>+ * | |      CPER           |
>+ * | +---------------------+
>+ */
>+
>+/* Map from uint32_t notify to entry offset in GHES */ static const
>+uint8_t error_source_to_index[] =3D { 0xff, 0xff, 0xff, 0xff,
>+                                                 0xff, 0xff, 0xff, 1,
>+0};
>+
>+static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
>+                          uint64_t *read_ack_addr) {
>+    uint64_t base;
>+
>+    if (notify >=3D ACPI_GHES_NOTIFY_RESERVED) {
>+        return false;
>+    }
>+
>+    /* Find and check the source id for this new CPER */
>+    if (error_source_to_index[notify] =3D=3D 0xff) {
>+        return false;
>+    }
>+
>+    base =3D ghes_get_state_start_address();
>+
>+    *read_ack_addr =3D base +
>+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>+        error_source_to_index[notify] * sizeof(uint64_t);
>+
>+    /* Could also be read back from the error_block_address register */
>+    *error_block_addr =3D base +
>+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>+        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>+        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
>+
>+    return true;
>+}
>+
> NotifierList generic_error_notifiers =3D
>     NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>
>+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
>+                             uint32_t notify) {
>+    int read_ack =3D 0;
>+    uint32_t i;
>+    uint64_t read_ack_addr =3D 0;
>+    uint64_t error_block_addr =3D 0;
>+    uint32_t data_length;
>+    GArray *block;
>+
>+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_addr)) {
>+        error_setg(errp, "GHES: Invalid error block/ack address(es)");
>+        return;
>+    }
>+
>+    cpu_physical_memory_read(read_ack_addr,
>+                             &read_ack, sizeof(uint64_t));
>+
>+    /* zero means OSPM does not acknowledge the error */
>+    if (!read_ack) {
>+        error_setg(errp,
>+                   "Last CPER record was not acknowledged yet");
>+        read_ack =3D 1;
>+        cpu_physical_memory_write(read_ack_addr,
>+                                  &read_ack, sizeof(uint64_t));
>+        return;
>+    }
>+
>+    read_ack =3D cpu_to_le64(0);
>+    cpu_physical_memory_write(read_ack_addr,
>+                              &read_ack, sizeof(uint64_t));
>+
>+    /* Build CPER record */
>+
>+    /*
>+     * Invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>+     * Table 17-13 Generic Error Data Entry
>+     */
>+    QemuUUID fru_id =3D {};
>+
>+    block =3D g_array_new(false, true /* clear */, 1);
>+    data_length =3D ACPI_GHES_DATA_LENGTH + cper->data_len;
>+
>+    /*
>+        * It should not run out of the preallocated memory if
>+        * adding a new generic error data entry
>+        */
>+    assert((data_length + ACPI_GHES_GESB_SIZE) <=3D
>+            ACPI_GHES_MAX_RAW_DATA_LENGTH);
>+
>+    /* Build the new generic error status block header */
>+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
>+                                    0, 0, data_length,
>+                                    ACPI_CPER_SEV_RECOVERABLE);
>+
>+    /* Build this new generic error data entry header */
>+    acpi_ghes_generic_error_data(block, cper->guid,
>+                                ACPI_CPER_SEV_RECOVERABLE, 0, 0,
>+                                cper->data_len, fru_id, 0);
>+
>+    /* Add CPER data */
>+    for (i =3D 0; i < cper->data_len; i++) {
>+        build_append_int_noprefix(block, cper->data[i], 1);
>+    }
>+
>+    /* Write the generic error data entry into guest memory */
>+    cpu_physical_memory_write(error_block_addr, block->data,
>+ block->len);
>+
>+    g_array_free(block, true);
>+
>+    notifier_list_notify(&generic_error_notifiers, NULL); }
>+
> bool acpi_ghes_present(void)
> {
>     AcpiGedState *acpi_ged_state;
>diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c index
>7aa7e71e90dc..d7ff7debee74 100644
>--- a/hw/acpi/ghes_cper.c
>+++ b/hw/acpi/ghes_cper.c
>@@ -39,7 +39,7 @@ void qmp_ghes_cper(CommonPlatformErrorRecord
>*qmp_cper,
>         return;
>     }
>
>-    /* TODO: call a function at ghes */
>+    ghes_record_cper_errors(&cper, errp, ACPI_GHES_NOTIFY_GPIO);
>
>     g_free(cper.data);
> }
>diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h index
>06a5b8820cd5..ee6f6cd96911 100644
>--- a/include/hw/acpi/ghes.h
>+++ b/include/hw/acpi/ghes.h
>@@ -85,6 +85,9 @@ typedef struct AcpiGhesCper {
>     size_t data_len;
> } AcpiGhesCper;
>
>+void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
>+                             uint32_t notify);
>+
> /**
>  * acpi_ghes_present: Report whether ACPI GHES table is present
>  *
>--
>2.45.2


