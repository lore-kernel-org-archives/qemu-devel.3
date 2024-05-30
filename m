Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E29CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZjV-0003qD-U7; Thu, 30 May 2024 02:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCZjQ-0003oi-N2
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:57:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sCZjL-0002DL-SR
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:57:46 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VqcRK1GwxzwQmL;
 Thu, 30 May 2024 14:53:49 +0800 (CST)
Received: from dggems706-chm.china.huawei.com (unknown [10.3.19.183])
 by mail.maildlp.com (Postfix) with ESMTPS id B81AB180083;
 Thu, 30 May 2024 14:57:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:56:59 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2507.039; 
 Thu, 30 May 2024 07:56:56 +0100
To: Markus Armbruster <armbru@redhat.com>, Shameer Kolothum via
 <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "yuan1.liu@intel.com" <yuan1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>, "linwenkai (C)" <linwenkai6@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, huangchenghai
 <huangchenghai2@huawei.com>
Subject: RE: [PATCH 3/7] migration/multifd: add uadk compression framework
Thread-Topic: [PATCH 3/7] migration/multifd: add uadk compression framework
Thread-Index: AQHasbVUI6qjeZwvXUivd+IFiOHYYLGuDkzagAFLM6A=
Date: Thu, 30 May 2024 06:56:56 +0000
Message-ID: <05230dbf289a45dc9194535afef2e421@huawei.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-4-shameerali.kolothum.thodi@huawei.com>
 <874jagooux.fsf@pond.sub.org>
In-Reply-To: <874jagooux.fsf@pond.sub.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.28]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Wednesday, May 29, 2024 12:11 PM
> To: Shameer Kolothum via <qemu-devel@nongnu.org>
> Cc: peterx@redhat.com; farosas@suse.de; yuan1.liu@intel.com; Shameerali
> Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Linuxarm
> <linuxarm@huawei.com>; linwenkai (C) <linwenkai6@hisilicon.com>;
> zhangfei.gao@linaro.org; huangchenghai <huangchenghai2@huawei.com>
> Subject: Re: [PATCH 3/7] migration/multifd: add uadk compression
> framework
>=20
> Please cc: maintainers on patches.  You can use
> scripts/get_maintainer.pl to find them.

Sure. My bad.
>=20
> Shameer Kolothum via <qemu-devel@nongnu.org> writes:
>=20
> > Adds the skeleton to support uadk compression method.
> > Complete functionality will be added in subsequent patches.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
>=20
> [...]
>=20
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 854e8609bd..0eaea9b0c3 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -632,12 +632,15 @@
> >  #       the deflate compression algorithm and use the Intel In-Memory
> Analytics
> >  #       Accelerator(IAA) accelerated compression and decompression. (S=
ince
> 9.1)
> >  #
> > +# @uadk: use UADK library compression method. (Since 9.1)
>=20
> Two spaces after '.' for consistency, please.

Ok.

> > +#
> >  # Since: 5.0
> >  ##
> >  { 'enum': 'MultiFDCompression',
> >    'data': [ 'none', 'zlib',
> >              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> > -            { 'name': 'qpl', 'if': 'CONFIG_QPL' } ] }
> > +            { 'name': 'qpl', 'if': 'CONFIG_QPL' },
> > +            { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
> >
> >  ##
> >  # @MigMode:
>=20
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks,
Shameer

