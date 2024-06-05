Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89652C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtEl-0000Bx-Mb; Wed, 05 Jun 2024 12:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEtEk-0000BW-Ct
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:11:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEtEh-0001yp-ON
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:11:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvXQr29tqz6K6Pk;
 Thu,  6 Jun 2024 00:07:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3F1101400C8;
 Thu,  6 Jun 2024 00:11:37 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 17:11:36 +0100
Date: Wed, 5 Jun 2024 17:11:36 +0100
To: Richard Henderson <richard.henderson@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, "Peter
 Maydell" <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PULL 36/46] bios-tables-test: Add data for complex numa test
 (GI, GP etc)
Message-ID: <20240605171136.00003879@huawei.com>
In-Reply-To: <20240605170845.000000dc@huawei.com>
References: <cover.1717527933.git.mst@redhat.com>
 <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
 <2eefcbdb-ad41-465a-9c14-1dc15bfff94a@linaro.org>
 <20240605162733.00007d8d@Huawei.com>
 <3a1c870c-f708-482d-802a-d3230b398c28@linaro.org>
 <20240605170845.000000dc@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 5 Jun 2024 17:08:45 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 5 Jun 2024 09:01:37 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
>=20
> > On 6/5/24 10:27, Jonathan Cameron wrote: =20
> > >> This fails testing:
> > >>
> > >> https://gitlab.com/qemu-project/qemu/-/jobs/7021105504
> > >>
> > >> acpi-test: Warning! SRAT binary file mismatch. Actual [aml:/tmp/aml-=
GHR6O2], Expected
> > >> [aml:tests/data/acpi/q35/SRAT.acpihmat-generic-x].
> > >> See source file tests/qtest/bios-tables-test.c for instructions on h=
ow to update expected
> > >> files.
> > >> to see ASL diff between mismatched files install IASL, rebuild QEMU =
from scratch and
> > >> re-run tests with V=3D1 environment variable set**
> > >> ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: asser=
tion failed:
> > >> (all_tables_match)
> > >> Bail out! ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_=
asl: assertion failed:
> > >> (all_tables_match)
> > >> Aborted (core dumped)
> > >>   =20
> > >=20
> > > s390 and passes on an x86 host, so I guess an endian bug - any chance=
 of a table dump
> > > from someone with access to an s390 host?   =20
> >=20
> > Sure.  By what incantation do I produce a dump? =20
>=20
> If you still have the /mnt/aml-GHR602 above then either upload that somew=
here or
> iasl -d /mnt/aml-GHR602
> should generate you a suitable text file.  However generic ports are fair=
ly recent
> so you may need a newer iasl from acpica-tools to decode.
> It will moan if it doesn't understand the content.
>=20
make check-qtest-x86_64 is how I get the test to run in the first place.

Alternatively, this 'might' be sufficient if my guess for the problem
is correct. Thanks!

=46rom 956df037f024783f19b6b00e5e280484380227a0 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 5 Jun 2024 17:01:36 +0100
Subject: [PATCH] hw/acpi: Fix big endian host creation of Generic Port
 Affinity Structures

Treating the HID as an integer caused it to get bit reversed
on big endian hosts running little endian guests.  Treat it
as a character array instead.

Fixes hw/acpi: Generic Port Affinity Structure Support
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Maybe this is the only problem?  I don't have a setup to test
so any help would be appreciated.
---
 include/hw/acpi/acpi_generic_initiator.h | 2 +-
 hw/acpi/acpi_generic_initiator.c         | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acp=
i_generic_initiator.h
index 1a899af30f..5baefda33a 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
             uint16_t bdf;
         };
         struct {
-            uint64_t hid;
+            char hid[8];
             uint32_t uid;
         };
     };
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initia=
tor.c
index 78b80dcf08..c2fb5ab2ef 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -150,8 +150,12 @@ build_srat_generic_node_affinity(GArray *table_data, i=
nt node,
         build_append_int_noprefix(table_data, handle->bdf, 2);
         build_append_int_noprefix(table_data, 0, 12);
     } else {
+        int i;
+
         /* Device Handle - ACPI */
-        build_append_int_noprefix(table_data, handle->hid, 8);
+        for (i =3D 0; i < sizeof(handle->hid); i++) {
+            build_append_int_noprefix(table_data, handle->hid[i], 1);
+        }
         build_append_int_noprefix(table_data, handle->uid, 4);
         build_append_int_noprefix(table_data, 0, 4);
     }
--=20
2.39.2


> Jonathan
>=20
> >=20
> >=20
> > r~ =20
>=20


