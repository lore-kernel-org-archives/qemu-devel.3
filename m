Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029CCCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNQt-000732-Fl; Thu, 04 Apr 2024 09:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsNQq-00072o-Pj
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:47:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsNQo-0001fU-90
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:47:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9NDK1n4nz6G9wD;
 Thu,  4 Apr 2024 21:45:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F64E140A77;
 Thu,  4 Apr 2024 21:46:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:46:56 +0100
Date: Thu, 4 Apr 2024 14:46:55 +0100
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: Dan Williams <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <ira.weiny@intel.com>, <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/6] cxl/core: add report option for
 cxl_mem_get_poison()
Message-ID: <20240404144655.0000679c@Huawei.com>
In-Reply-To: <7c8e36f1-4c16-43cd-a39b-fe02fa1756cd@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
 <66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7c8e36f1-4c16-43cd-a39b-fe02fa1756cd@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 3 Apr 2024 22:56:58 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> =E5=9C=A8 2024/3/30 9:50, Dan Williams =E5=86=99=E9=81=93:
> > Shiyang Ruan wrote: =20
> >> The GMER only has "Physical Address" field, no such one indicates leng=
th.
> >> So, when a poison event is received, we could use GET_POISON_LIST comm=
and
> >> to get the poison list.  Now driver has cxl_mem_get_poison(), so
> >> reuse it and add a parameter 'bool report', report poison record to MCE
> >> if set true. =20
> >=20
> > I am not sure I agree with the rationale here because there is no
> > correlation between the event being signaled and the current state of
> > the poison list. It also establishes race between multiple GMER events,
> > i.e. imagine the hardware sends 4 GMER events to communicate a 256B
> > poison discovery event. Does the driver need logic to support GMER event
> > 2, 3, and 4 if it already say all 256B of poison after processing GMER
> > event 1? =20
>=20
> Yes, I didn't thought about that.
>=20
> >=20
> > I think the best the driver can do is assume at least 64B of poison
> > per-event and depend on multiple notifications to handle larger poison
> > lengths. =20
>=20
> Agree.  This also makes things easier.
>=20
> And for qemu, I'm thinking of making a patch to limit the length of a=20
> poison record when injecting.  The length should between 64B to 4KiB per=
=20
> GMER. And emit many GMERs if length > 4KiB.

I'm not keen on such a restriction in QEMU.
QEMU is injecting lengths allowed by the specification.  That facility is
useful for testing the kernel and the QEMU modeling should not be based
on what the kernel supports.

When you said this I wondered if we had a clever implementation that fused
entries in the list, but we don't (I thought about doing so a long time
ago but seems I never bothered :)  So if you are using QEMU for testing
and you don't want to exceed the kernel supported poison lengths, don't
inject poison that big.

Jonathan

>=20
> >=20
> > Otherwise, the poison list is really only useful for pre-populating
> > pages to offline after a reboot, i.e. to catch the kernel up with the
> > state of poison pages after a reboot. =20
>=20
> Got it.
>=20
>=20
> --
> Thanks,
> Ruan.


