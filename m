Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC9C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfFFj-0002b1-AP; Tue, 04 Feb 2025 04:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfFFh-0002aD-FY; Tue, 04 Feb 2025 04:29:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tfFFe-0006j3-ES; Tue, 04 Feb 2025 04:29:53 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnJ0v3Pbpz6L4tw;
 Tue,  4 Feb 2025 17:27:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 3309414011B;
 Tue,  4 Feb 2025 17:29:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 10:29:45 +0100
Date: Tue, 4 Feb 2025 09:29:44 +0000
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH v12 qemu 2/2] qtest/cxl: Add aarch64 virt test for CXL
Message-ID: <20250204092944.00004d3c@huawei.com>
In-Reply-To: <4AEA1355-C6E8-4A9D-8652-607FEBD7EE03@linux.dev>
References: <20250203173040.145763-1-Jonathan.Cameron@huawei.com>
 <20250203173040.145763-3-Jonathan.Cameron@huawei.com>
 <4AEA1355-C6E8-4A9D-8652-607FEBD7EE03@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 4 Feb 2025 14:16:19 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> Jonathan,
>=20
> > On Feb 4, 2025, at 2:30, Jonathan Cameron <Jonathan.Cameron@huawei.com>=
 wrote:
> >=20
> > Add a single complex case for aarch64 virt machine.
> > Given existing much more comprehensive tests for x86 cover the
> > common functionality, a single test should be enough to verify
> > that the aarch64 part continue to work.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > tests/qtest/cxl-test.c  | 59 ++++++++++++++++++++++++++++++++---------
> > tests/qtest/meson.build |  1 +
> > 2 files changed, 47 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index a600331843..c7189d6222 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -19,6 +19,12 @@
> >     "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 " \
> >     "-M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw=
.0.size=3D4G "
> >=20
> > +#define QEMU_VIRT_2PXB_CMD \
> > +    "-machine virt,cxl=3Don -cpu max " \
> > +    "-device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D52 " \
> > +    "-device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 " \
> > +    "-M cxl-fmw.0.targets.0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fm=
w.0.size=3D4G "
> > +
> > #define QEMU_RP \
> >     "-device cxl-rp,id=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D0 "
> >=20
> > @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
> >     qtest_end();
> >     rmdir(tmpfs);
> > }
> > +
> > +static void cxl_virt_2pxb_4rp_4t3d(void)
> > +{
> > +    g_autoptr(GString) cmdline =3D g_string_new(NULL);
> > +    char template[] =3D "/tmp/cxl-test-XXXXXX";
> > +    const char *tmpfs;
> > +
> > +    tmpfs =3D mkdtemp(template);
> > +
> > +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> > +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> > +                    tmpfs, tmpfs);
> > +
> > +    qtest_start(cmdline->str);
> > +    qtest_end();
> > +    rmdir(tmpfs);
> > +}
> > #endif /* CONFIG_POSIX */
> >=20
> > int main(int argc, char **argv)
> > {
> > -    g_test_init(&argc, &argv, NULL);
> > +    const char *arch =3D qtest_get_arch();
> >=20
> > -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> > -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> > -    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> > -    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window=
);
> > -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> > -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> > +    g_test_init(&argc, &argv, NULL);
> > +    if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
> > +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> > +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> > +        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window=
);
> > +        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_wi=
ndow);
> > +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
> > +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> > #ifdef CONFIG_POSIX
> > -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> > -    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> > -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> > -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_=
lsa);
> > -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> > -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4=
rp_4t3d);
> > +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> > +        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persisten=
t);
> > +        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> > +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volat=
ile_lsa);
> > +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> > +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
> > +                       cxl_2pxb_4rp_4t3d);
> > #endif
> > +    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
> > +#ifdef CONFIG_POSIX
> > +        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
> > +                       cxl_virt_2pxb_4rp_4t3d);
> > +#endif
> > +    }
> > +
> >     return g_test_run();
> > }
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index e60e92fe9d..f5e7fb060e 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -257,6 +257,7 @@ qtests_aarch64 =3D \
> >   (config_all_accel.has_key('CONFIG_TCG') and                          =
                  \
> >    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-tes=
t'] : []) + \
> >   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : =
[]) + \
> > +  qtests_cxl +                                                        =
                          \
> >   ['arm-cpu-features',
> >    'numa-test',
> >    'boot-serial-test',
> > --=20
> > 2.43.0
> >  =20
>=20
> In Ubuntu 22.04 LTS, cxl-test applied on top of today=E2=80=99s QEMU upst=
ream master branch cxl-test fails:
>=20
> $ ./tests/qtest/cxl-test
> # random seed: R02S2a8b02df7b32b79d086ce22f7f8ebeab
> 1..1
> # Start of aarch64 tests
> # Start of pci tests
> # Start of cxl tests
> # Start of virt tests
> # starting QEMU: exec qemu-system-aarch64 -qtest unix:/tmp/qtest-568421.s=
ock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-568421.qmp,id=3D=
char0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -machin=
e virt,cxl=3Don -cpu max -device pxb-cxl,id=3Dcxl.0,bus=3Dpcie.0,bus_nr=3D5=
2 -device pxb-cxl,id=3Dcxl.1,bus=3Dpcie.0,bus_nr=3D53 -M cxl-fmw.0.targets.=
0=3Dcxl.0,cxl-fmw.0.targets.1=3Dcxl.1,cxl-fmw.0.size=3D4G -device cxl-rp,id=
=3Drp0,bus=3Dcxl.0,chassis=3D0,slot=3D0 -device cxl-rp,id=3Drp1,bus=3Dcxl.0=
,chassis=3D0,slot=3D1 -device cxl-rp,id=3Drp2,bus=3Dcxl.1,chassis=3D0,slot=
=3D2 -device cxl-rp,id=3Drp3,bus=3Dcxl.1,chassis=3D0,slot=3D3 -object memor=
y-backend-file,id=3Dcxl-mem0,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M -o=
bject memory-backend-file,id=3Dlsa0,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D=
256M -device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0,id=
=3Dpmem0 -object memory-backend-file,id=3Dcxl-mem1,mem-path=3D/tmp/cxl-test=
-WdBn4X,size=3D256M -object memory-backend-file,id=3Dlsa1,mem-path=3D/tmp/c=
xl-test-WdBn4X,size=3D256M -device cxl-type3,bus=3Drp1,persistent-memdev=3D=
cxl-mem1,lsa=3Dlsa1,id=3Dpmem1 -object memory-backend-file,id=3Dcxl-mem2,me=
m-path=3D/tmp/cxl-test-WdBn4X,size=3D256M -object memory-backend-file,id=3D=
lsa2,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M -device cxl-type3,bus=3Drp=
2,persistent-memdev=3Dcxl-mem2,lsa=3Dlsa2,id=3Dpmem2 -object memory-backend=
-file,id=3Dcxl-mem3,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M -object mem=
ory-backend-file,id=3Dlsa3,mem-path=3D/tmp/cxl-test-WdBn4X,size=3D256M -dev=
ice cxl-type3,bus=3Drp3,persistent-memdev=3Dcxl-mem3,lsa=3Dlsa3,id=3Dpmem3 =
 -accel qtest
> qemu-system-aarch64: -audio: invalid option
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:../tests/qtest/libqtest.c:550:qtest_connect: assertion failed: (s->=
fd >=3D 0 && s->qmp_fd >=3D 0)
> Bail out! ERROR:../tests/qtest/libqtest.c:550:qtest_connect: assertion fa=
iled: (s->fd >=3D 0 && s->qmp_fd >=3D 0)
> ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU proces=
s but encountered exit status 1 (expected 0)
> Aborted (core dumped)
>=20
> Do I need set env vars when execute this test?

I've just been running it with make check-qtest and not seeing anything sim=
ilar.

I'm not sure what infrastructure qtest puts round these but I guess it sets
up that socket.

Jonathan



>=20
> Itaru.

