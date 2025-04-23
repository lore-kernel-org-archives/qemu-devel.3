Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0F8C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 15:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cK9-0002Xw-6R; Wed, 23 Apr 2025 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7cK2-0002Q6-Io
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:47:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7cK0-0005Ne-2m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 11:47:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjNfm4m5jz6M4jP;
 Wed, 23 Apr 2025 23:43:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4BB701402ED;
 Wed, 23 Apr 2025 23:47:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 17:47:21 +0200
Date: Wed, 23 Apr 2025 16:47:20 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Yicong Yang <yangyicong@huawei.com>, Alireza Sanaee
 <alireza.sanaee@huawei.com>, <yangyicong@hisilicon.com>,
 <qemu-devel@nongnu.org>, <anisinha@redhat.com>, <imammedo@redhat.com>,
 <linuxarm@huawei.com>, <peter.maydell@linaro.org>,
 <prime.zeng@hisilicon.com>, <shameerali.kolothum.thodi@huawei.com>,
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v3 4/5] hw/acpi/aml-build: Update the revision of PPTT
 table
Message-ID: <20250423164720.000070b9@huawei.com>
In-Reply-To: <20250423113447-mutt-send-email-mst@kernel.org>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-5-alireza.sanaee@huawei.com>
 <20250423083909-mutt-send-email-mst@kernel.org>
 <6b783651-e952-ffe9-6c49-7ee9459741c8@huawei.com>
 <20250423113447-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 23 Apr 2025 11:35:46 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 23, 2025 at 10:15:42PM +0800, Yicong Yang wrote:
> > On 2025/4/23 20:39, Michael S. Tsirkin wrote:  
> > > On Wed, Apr 23, 2025 at 12:41:29PM +0100, Alireza Sanaee wrote:  
> > >> From: Yicong Yang <yangyicong@hisilicon.com>
> > >>
> > >> The lastest ACPI spec 6.5 support PPTT revision 3. Update it
> > >> by handy. This is compatible with previous revision.
> > >>
> > >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>  
> > > 
> > > 
> > > I don't get it. Why are you updating it? Which features
> > > from the new one are you using?
> > >   
> > 
> > no new features for this patchset. considered updating it to the latest ACPI
> > spec since we're going to touch the PPTT table and tested data.  
> 
> it's best to wait until there are actual features you need.
> don't make changes for the sake of changes, there's always
> some risk.

Once we add the cache description (Ali's other set) can we make
sure we arbitrary decide to have separate cache structures.  The
earlier table version allowed sharing of the entrees in the table
which then became not allowed in the newer spec. That will smooth
the path quite a bit and is a valid way to interpret the earlier spec.

If we do that, we can bring the IDs + the version update as a
precursor to MPAM support series. I don't think we need them until
that series (which is a way off being ready to merge yet!)

Jonathan

> 
> > >> ---
> > >>  hw/acpi/aml-build.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > >> index 3010325ca423..e5401dfdb1a8 100644
> > >> --- a/hw/acpi/aml-build.c
> > >> +++ b/hw/acpi/aml-build.c
> > >> @@ -2155,7 +2155,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > >>      uint32_t pptt_start = table_data->len;
> > >>      uint32_t root_offset;
> > >>      int n;
> > >> -    AcpiTable table = { .sig = "PPTT", .rev = 2,
> > >> +    AcpiTable table = { .sig = "PPTT", .rev = 3,
> > >>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> > >>  
> > >>      acpi_table_begin(&table, table_data);
> > >> -- 
> > >> 2.34.1  
> > > 
> > > 
> > > .
> > >   
> 
> 


