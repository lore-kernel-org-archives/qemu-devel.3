Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26443CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsnTl-0007D9-8v; Fri, 05 Apr 2024 13:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsnTj-0007Cw-PL
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:35:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rsnTe-0000GY-Iw
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:35:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB59w2zZSz6K8xl;
 Sat,  6 Apr 2024 01:31:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 51615140A79;
 Sat,  6 Apr 2024 01:35:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 18:35:40 +0100
Date: Fri, 5 Apr 2024 18:35:40 +0100
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 5/5] cxl/core: add poison injection event handler
Message-ID: <20240405183540.00003d5b@Huawei.com>
In-Reply-To: <48223415-8466-480d-86e1-8b9945782c0c@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
 <20240213165150.00006d9a@Huawei.com>
 <48223415-8466-480d-86e1-8b9945782c0c@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 15 Mar 2024 10:29:07 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> =E5=9C=A8 2024/2/14 0:51, Jonathan Cameron =E5=86=99=E9=81=93:
> >  =20
> >> +
> >> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> >> +			     enum cxl_event_log_type type,
> >> +			     enum cxl_event_type event_type,
> >> +			     const uuid_t *uuid, union cxl_event *evt)
> >> +{
> >> +	if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA) {
> >>   		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> >> -	else if (event_type =3D=3D CXL_CPER_EVENT_DRAM)
> >> +		/* handle poison event */
> >> +		if (type =3D=3D CXL_EVENT_TYPE_FAIL)
> >> +			cxl_event_handle_poison(cxlmd, &evt->gen_media); =20
> >=20
> > I'm not 100% convinced this is necessary poison causing.  Also
> > the text tells us we should see 'an appropriate event'.
> > DRAM one seems likely to be chosen by some vendors. =20
>=20
> I think it's right to use DRAM Event Record for volatile-memdev, but=20
> should poison on a persistent-memdev also use DRAM Event Record too?=20
> Though its 'Physical Address' feild has the 'Volatile' bit too, which is=
=20
> same as General Media Event Record.  I am a bit confused about this.

That is indeed 'novel' in a DRAM device, but maybe it could be battery
backed and have a path to say a flash device that isn't visible to CXL
and form which the DRAM is refilled on power restore?

Anyhow, doesn't make sense for persistent memory that doesn't correspond
to all the other stuff in the DRAM event.
>=20
> >=20
> > The fatal check maybe makes it a little more likely (maybe though
> > I'm not sure anything says a device must log it to the failure log)
> > but it might be Memory Event Type 1, which is the host tried to
> > access an invalid address.  Sure poison might be returned to that
> > error but what would the main kernel memory handling do with it?
> > Something is very wrong
> > but it's not corrupted device memory.  TE state violations are in there
> > as well. Sure poison is returned on reads (I think - haven't checked).
> >=20
> > IF the aim here is to say 'maybe there is poison, better check the
> > poison list'. Then that is reasonable but we should ensure things
> > like timer expiry are definitely ruled out and rename the function
> > to make it clear it might not find poison. =20
>=20
> I forgot to distinguish the 'Transaction Type' here. Host Inject Poison=20
> is 0x04h. And other types should also have their specific handle method.
Yes. If you can use transaction type that solves this issue I think.
>=20
>=20
> --
> Thanks,
> Ruan.
>=20
> >=20
> > Jonathan =20


