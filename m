Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468AAC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8SF-00044x-Vh; Fri, 14 Mar 2025 13:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tt8SB-00040E-Mh
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:04:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tt8S9-0004Qp-4F
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:04:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDrHK6F6Xz6JB7X;
 Sat, 15 Mar 2025 01:01:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 340CE140D26;
 Sat, 15 Mar 2025 01:03:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 18:03:58 +0100
Date: Fri, 14 Mar 2025 17:03:57 +0000
To: Dan Williams <dan.j.williams@intel.com>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <20250314170357.00000de3@huawei.com>
In-Reply-To: <67d44ec5a79c1_12e31294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
 <20250221065509-mutt-send-email-mst@kernel.org>
 <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
 <20250305141359.00001288@huawei.com>
 <4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
 <20250312181035.00006e32@huawei.com>
 <67d44ec5a79c1_12e31294ea@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Fri, 14 Mar 2025 08:44:05 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 5 Mar 2025 18:35:40 +0800
> > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> >  =20
> > > >=20
> > > > On Tue, 4 Mar 2025 14:22:48 +0800
> > > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > > >    =20
> > > > > >=20
> > > > > > On Thu, Feb 20, 2025 at 04:12:13PM +0000, Jonathan Cameron wrot=
e:     =20
> > > > > > > On Mon, 17 Feb 2025 19:20:39 +0800
> > > > > > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > > > > > >      =20
> > > > > > > > Add serial number parameter in the cxl persistent examples.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn> =
    =20
> > > > > > > Looks good.  I've queued it up on my gitlab staging tree, but
> > > > > > > Michael if you want to pick this one directly that's fine as =
well.     =20
> > > > > >=20
> > > > > > See no reason to, I was not even CC'd.     =20
> > > > >=20
> > > > > Hi, Michael
> > > > >=20
> > > > > I'm sorry, this is my fault. I used "get_maintainer.pl" to check =
this
> > > > > patch's maintainers but it shows "No maintainers found, printing =
recent
> > > > > contributors".=20
> > > > >    =20
> > > > I usually stage up multiple series together and send on to Michael.
> > > > So it was be being lazy for a minor change rather than anything much
> > > > that you did wrong.
> > > >=20
> > > > If I get time I'll post a series with this a few other patches
> > > > later today. =20
> > > >=20
> > > > Jonathan
> > > >    =20
> > > Thank you!
> > >=20
> > > BTW, I found a corner case in CXL numa node creation.
> > >=20
> > > Condition:=20
> > > 1) A UMA/NUMA system without SRAT, but with CEDT.CFMWS
> > > 2=EF=BC=89Enable CONFIG_ACPI_NUMA
> > >=20
> > > Results:
> > > 1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmw=
s()
> > > 2=EF=BC=89If dynamically create cxl ram region, the cxl memory would =
be assigned
> > > to node0 rather than a new node
> > >=20
> > > Confusions:
> > > 1) Is a numa system a requirement for CXL memory usage? =20
> >=20
> > Obviously discussion has gone on elsewhere, but I'd say in general it
> > would be a bad idea to not have an SRAT because the moment we add CXL
> > it is definitely a NUMA system and we want the Generic Port entry to
> > allow us to get perf information.
> >=20
> > So I wouldn't mind if we fail CXL init in this case, but maybe
> > it is worth papering over things. =20
>=20
> I think that is too severe. If a driver has a path to advertise
> resources, even in a less than ideal way, it should make every effort to
> do that. There are plenty of ways for the NUMA information to fail, that
> does not mean the memory needs to be prevented from coming online. Let
> the end user decide if lack of performance information is fatal.

You are too nice to those firmware folk ;)  How will they learn!

Everything in default node is fine.  I don't much like the having
broken normal numa setup combined with CXL trying to carry on with
its node. I suspect that will be fragile in the long run.

numa_off and other things set in that path tend to spread there wings
into surprising places and broken / missing SRAT + CXL is something
that isn't likely to get much testing.

Jonathan


>=20


