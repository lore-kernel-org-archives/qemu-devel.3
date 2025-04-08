Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E659DC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 09:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u24o0-0004Fh-Ux; Tue, 08 Apr 2025 04:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u24nr-0004EW-1J; Tue, 08 Apr 2025 04:59:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1u24no-0004AY-43; Tue, 08 Apr 2025 04:59:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZX0KK3ScZz6M4lS;
 Tue,  8 Apr 2025 16:55:33 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 76CA21400DB;
 Tue,  8 Apr 2025 16:59:20 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Apr
 2025 10:59:19 +0200
Date: Tue, 8 Apr 2025 09:59:14 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <zhao1.liu@intel.com>, <dapeng1.mi@linux.intel.com>, <armbru@redhat.com>,
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <mtosatti@redhat.com>,
 <berrange@redhat.com>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <jonathan.cameron@huawei.com>,
 <jiangkunkun@huawei.com>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v8 5/6] tests/qtest/bios-table-test: testing new ARM
 ACPI PPTT topology
Message-ID: <20250408095914.00003995.alireza.sanaee@huawei.com>
In-Reply-To: <03409a9d-fbee-4e08-9ca3-861bf8eddd55@redhat.com>
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
 <20250310162337.844-6-alireza.sanaee@huawei.com>
 <03409a9d-fbee-4e08-9ca3-861bf8eddd55@redhat.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 7 Apr 2025 19:30:47 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 3/10/25 5:23 PM, Alireza Sanaee via wrote:
> > Test new PPTT topolopy with cache representation.
> >
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  tests/qtest/bios-tables-test.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tests/qtest/bios-tables-test.c
> > b/tests/qtest/bios-tables-test.c index 0a333ec43536..6bdc25f4df1e
> > 100644 --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -2142,6 +2142,10 @@ static void
> > test_acpi_aarch64_virt_tcg_topology(void) };
> >  
> >      test_acpi_one("-cpu cortex-a57 "
> > +                  "-M
> > virt,smp-cache.0.cache=l1i,smp-cache.0.topology=cluster,"
> > +
> > "smp-cache.1.cache=l1d,smp-cache.1.topology=cluster,"
> > +
> > "smp-cache.2.cache=l2,smp-cache.2.topology=cluster,"
> > +
> > "smp-cache.3.cache=l3,smp-cache.3.topology=cluster "  
> In the coverletter you used different topologies: core, cluster,
> socket. Don't you want to test the same config here?

The reason I used this one is because it is a weird setup (everything
shared at Cluster) and if this one works, I can sorta say the rest of
the scenarios work fine too. I get that this differs from the cover
letter setup.

I could also add a single test for all combinations of caches. 
They are quite a few. But then I would be happy to do if I should.
> 
> Is it better to reuse the existing ".topology" variant or to create
> another one? (I have no strong opinion though)
I am not sure how to do variants and I just replaced the existing one, 
but happy to do either way.
> 
> Thanks
> 
> Eric
> >                    "-smp sockets=1,clusters=2,cores=2,threads=2",
> > &data); free_test_data(&data);
> >  }  
> 
> 


