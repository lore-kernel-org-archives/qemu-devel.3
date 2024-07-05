Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FEC3814E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfR3-0007yk-LG; Fri, 05 Jul 2024 05:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPfR1-0007yU-JG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:40:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPfQw-0001I2-2h
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:40:55 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFpQS5W5Zz6JBSv;
 Fri,  5 Jul 2024 17:40:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9F9BE140B38;
 Fri,  5 Jul 2024 17:40:44 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 10:40:44 +0100
Date: Fri, 5 Jul 2024 10:40:43 +0100
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Zhao Liu <zhao1.liu@intel.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>, "Zhao
 Liu" <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/3] hw/cxl: Get rid of unused cfmw_list
Message-ID: <20240705104043.000023fb@Huawei.com>
In-Reply-To: <eb397f41-9a81-4b1f-a1ed-7f0b99b42b30@fujitsu.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
 <20240702143425.717452-2-Jonathan.Cameron@huawei.com>
 <5ffea576-0b87-46c1-b4dc-e09bd253805e@fujitsu.com>
 <ZodXMPef9bIROG5u@intel.com>
 <eb397f41-9a81-4b1f-a1ed-7f0b99b42b30@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 5 Jul 2024 02:29:34 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 05/07/2024 10:15, Zhao Liu wrote:
> >> There is a new user for cfmw_list now
> >> https://lore.kernel.org/qemu-devel/20240704093404.1848132-1-zhao1.liu@=
linux.intel.com/
> >>
> >> So I think we should drop this patch. =20
>=20
> > Hi Zhijian,
> >=20
> > I'm not a "real" user and that bug was originally found by code reading.
> >=20
> > So that fix won't block your drop. =F0=9F=99=82 =20
>=20
>=20
> "hw/cxl: Get rid of unused cfmw_list" is no longer needed.
>=20
>=20
>=20
> >=20
> > And I think the fix is worth being laned before cfmw_list gets dropped,
> > for being able to port backwards to stable QEMU. =20
>=20
> Your fix[0] requires CXLState.cfmw_list, and I think CXLState.cfmw_list w=
as designed for *get* purpose
> but got mistake at that time.
>=20
> [0] https://lore.kernel.org/qemu-devel/20240704093404.1848132-1-zhao1.liu=
@linux.intel.com/
Ok.  Michael, please ignore this one as the lack of use is result of anothe=
r bug.=20
I hadn't gotten to that fix yet, so missed the connection.

The rest of this series is unrelated.

Jonathan

>=20
>=20
> >    =20
> >> On 02/07/2024 22:34, Jonathan Cameron wrote: =20
> >>> From: Li Zhijian<lizhijian@fujitsu.com>
> >>>
> >>> There is no user for this member. All '-M cxl-fmw.N' options have
> >>> been parsed and saved to CXLState.fixed_windows.
> >>>
> >>> Signed-off-by: Li Zhijian<lizhijian@fujitsu.com>
> >>> Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> >>> ---
> >>>    include/hw/cxl/cxl.h | 1 -
> >>>    hw/cxl/cxl-host.c    | 1 -
> >>>    2 files changed, 2 deletions(-)
> >>>
> >>> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> >>> index 75e47b6864..e3ecbef038 100644
> >>> --- a/include/hw/cxl/cxl.h
> >>> +++ b/include/hw/cxl/cxl.h
> >>> @@ -43,7 +43,6 @@ typedef struct CXLState {
> >>>        MemoryRegion host_mr;
> >>>        unsigned int next_mr_idx;
> >>>        GList *fixed_windows;
> >>> -    CXLFixedMemoryWindowOptionsList *cfmw_list;
> >>>    } CXLState;
> >>>    =20


