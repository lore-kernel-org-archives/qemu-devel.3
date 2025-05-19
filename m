Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580C2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH016-0006ei-Dc; Mon, 19 May 2025 08:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uH00z-0006di-0A; Mon, 19 May 2025 08:54:45 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uH00u-0000eS-AM; Mon, 19 May 2025 08:54:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1HZG6vTnz6M55B;
 Mon, 19 May 2025 20:49:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5BE351400E3;
 Mon, 19 May 2025 20:54:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 May
 2025 14:54:14 +0200
Date: Mon, 19 May 2025 13:54:13 +0100
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v13 5/5] qtest/cxl: Add aarch64 virt test for CXL
Message-ID: <20250519135413.000026b4@huawei.com>
In-Reply-To: <D9E503CC-1271-4008-9975-9BAEC7A33376@linux.dev>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-6-Jonathan.Cameron@huawei.com>
 <D9E503CC-1271-4008-9975-9BAEC7A33376@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

On Thu, 15 May 2025 18:04:18 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> > On May 13, 2025, at 20:14, Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > Add a single complex case for aarch64 virt machine.
> > Given existing much more comprehensive tests for x86 cover the
> > common functionality, a single test should be enough to verify
> > that the aarch64 part continue to work.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > tests/qtest/cxl-test.c  | 59 ++++++++++++++++++++++++++++++++---------
> > tests/qtest/meson.build |  1 +
> > 2 files changed, 47 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index a600331843..c7189d6222 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -19,6 +19,12 @@
> >     "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> >     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > 
> > +#define QEMU_VIRT_2PXB_CMD \
> > +    "-machine virt,cxl=on -cpu max " \
> > +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> > +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> > +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> > +
> > #define QEMU_RP \
> >     "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
> > 
> > @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
> >     qtest_end();
> >     rmdir(tmpfs);
> > }
> > +
> > +static void cxl_virt_2pxb_4rp_4t3d(void)
> > +{
> > +    g_autoptr(GString) cmdline = g_string_new(NULL);
> > +    char template[] = "/tmp/cxl-test-XXXXXX";
> > +    const char *tmpfs;
> > +
> > +    tmpfs = mkdtemp(template);
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
> > 
> > int main(int argc, char **argv)
> > {
> > -    g_test_init(&argc, &argv, NULL);
> > +    const char *arch = qtest_get_arch();
> > 
> > -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> > -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> > -    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> > -    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> > -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> > -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> > +    g_test_init(&argc, &argv, NULL);
> > +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> > +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> > +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> > +        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> > +        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> > +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
> > +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> > #ifdef CONFIG_POSIX
> > -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> > -    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> > -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> > -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> > -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> > -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
> > +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> > +        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> > +        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> > +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> > +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> > +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
> > +                       cxl_2pxb_4rp_4t3d);
> > #endif
> > +    } else if (strcmp(arch, "aarch64") == 0) {
> > +#ifdef CONFIG_POSIX
> > +        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
> > +                       cxl_virt_2pxb_4rp_4t3d);
> > +#endif
> > +    }
> > +
> >     return g_test_run();
> > }
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 7daf619845..361000267a 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -258,6 +258,7 @@ qtests_aarch64 = \
> >   (config_all_accel.has_key('CONFIG_TCG') and                                            \
> >    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> >   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
> > +  qtests_cxl +                                                                                  \
> >   ['arm-cpu-features',
> >    'numa-test',
> >    'boot-serial-test',
> > -- 
> > 2.43.0
> >   
> 
> ~/projects/qemu/build$ meson test qtest-aarch64/cxl-test
> ninja: Entering directory `/home/realm/projects/qemu/build'
> [1/8] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
> 1/1 qemu:qtest+qtest-aarch64 / qtest-aarch64/cxl-test        OK              0.17s   1 subtests passed
> 
> Ok:                 1
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            0
> Timeout:            0
> 
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>>
> 
> Jonathan, would you push your branch this series applied? I manually applied your series no issues though. 

I'm reluctant to push a 'normal' staging CXL tree whilst we have the TCG
issue outstanding (which is in mainline).
I can probably push one with a name that makes it clear we know it will
crash under some circumstances though. I'll aim to get that done later this week.

After talking to Richard Henderson I'm going to spin some images etc to
make it easier for him to replicate that TCG issue.

Thanks for reviews.

Jonathan

> 
> 


