Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3FDC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsu0-00011y-Kt; Wed, 05 Jun 2024 11:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEsts-00010N-Fy
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:50:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEstp-0004ku-OT
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:50:08 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvX1r0JLmz6D97l;
 Wed,  5 Jun 2024 23:48:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 378B21400DB;
 Wed,  5 Jun 2024 23:49:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 16:49:58 +0100
Date: Wed, 5 Jun 2024 16:49:57 +0100
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PULL 36/46] bios-tables-test: Add data for complex numa test
 (GI, GP etc)
Message-ID: <20240605164957.00005656@Huawei.com>
In-Reply-To: <20240605162733.00007d8d@Huawei.com>
References: <cover.1717527933.git.mst@redhat.com>
 <61cbf56ef1c5dd9dbe6bd6625f6c8d2a82c5697f.1717527933.git.mst@redhat.com>
 <2eefcbdb-ad41-465a-9c14-1dc15bfff94a@linaro.org>
 <20240605162733.00007d8d@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 5 Jun 2024 16:27:33 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Wed, 5 Jun 2024 07:39:53 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
> > On 6/4/24 14:08, Michael S. Tsirkin wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Given this is a new configuration, there are affects on APIC, CEDT
> > > and DSDT, but the key elements are in SRAT (plus related data in
> > > HMAT).  The configuration has node to exercise many different combinations.
> > > 
> > > 0) CPUs + Memory
> > > 1) GI only
> > > 2) GP only
> > > 3) CPUS only
> > > 4) Memory only
> > > 5) CPUs + HP memory
> > > 
> > > GI node, GP Node, Memory only node, hotplug memory
> > > only node, latency and bandwidth such that in Linux Access0
> > > (any initiator) and Access1 (CPU initiators only) given different
> > > answers.  Following cropped to remove details of each entry.    
> > 
> > 
> > This fails testing:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/7021105504
> > 
> > acpi-test: Warning! SRAT binary file mismatch. Actual [aml:/tmp/aml-GHR6O2], Expected 
> > [aml:tests/data/acpi/q35/SRAT.acpihmat-generic-x].
> > See source file tests/qtest/bios-tables-test.c for instructions on how to update expected 
> > files.
> > to see ASL diff between mismatched files install IASL, rebuild QEMU from scratch and 
> > re-run tests with V=1 environment variable set**
> > ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: assertion failed: 
> > (all_tables_match)
> > Bail out! ERROR:../alt/tests/qtest/bios-tables-test.c:550:test_acpi_asl: assertion failed: 
> > (all_tables_match)
> > Aborted (core dumped)
> >   
> 
> s390 and passes on an x86 host, so I guess an endian bug - any chance of a table dump
> from someone with access to an s390 host?
> 
> This test covers some stuff that was previously missing tests
> so may be non trivial to spot.
> 
> I'll play guess in the meantime. So far I'm not seeing anything that differs
> from existing ACPI table building code.

Ok. I think it a bug earlier in this patch set. A table dump would confirm.

One item that looks dodgy is the filling in of the ACPI HID.

It's messy in the ACPI spec as it's defined as both an integer
and a string.
 
Need to take a 4 character string and get it into hid of

struct {
   uint64_t hid;
   uint32_t uid;
}
which id done with an 8 byte memcpy.
that is then written to SRAT wtih
build_append_int_noprefix(table_data, handle->hid, 8);

So I need to byte swap it if host doesn't match guest endian.

I'll put together a patch, but perhaps best plan is if Michael
drops generic ports and we go around again :(

At least I don't have much backed up behind this one.

Jonathan

> 
> Jonathan
> 
> 
> > 
> > r~  
> 
> 


