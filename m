Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B3107BCC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15AO-0006m8-3p; Fri, 13 Mar 2026 12:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w15A3-0006lG-5D
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:14:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w159z-0005Ai-ID
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:14:50 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXV181Fg3zHnGfl;
 Sat, 14 Mar 2026 00:14:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B2AC40086;
 Sat, 14 Mar 2026 00:14:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 16:14:31 +0000
Date: Fri, 13 Mar 2026 16:14:29 +0000
To: Gregory Price <gourry@gourry.net>
CC: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 <qemu-devel@nongnu.org>, <apopple@nvidia.com>, <dan.j.williams@intel.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <david@redhat.com>,
 <imammedo@redhat.com>
Subject: Re: [PATCH v7 0/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <20260313161429.00003ace@huawei.com>
In-Reply-To: <abQquiWHPoVgw-jt@gourry-fedora-PF4VCD3F>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <4609b0dc-4510-48c7-8190-e8fd5c53b658@amd.com>
 <abQquiWHPoVgw-jt@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Mar 2026 11:18:18 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Mar 13, 2026 at 04:30:20PM +0800, Huang, FangSheng (Jerry) wrote:
> > Hi Gregory,
> >=20
> > Thanks again for the thorough review on v6 and for catching the hardcod=
ed
> > address issue =E2=80=94 v7 has that fixed, now using x86ms->above_4g_me=
m_start as
> > you suggested.
> >=20
> > Just wanted to follow up and check if your Reviewed-by still applies to=
 v7,
> > since it's a minimal change from v6 (only the one-line fix you identifi=
ed).
> >  =20
>=20
> Yes sorry, we're good to go
>=20
> Reviewed-by: Gregory Price <gourry@gourry.net>
>=20
> Thank you for this, this will be very helpful for testing
>=20
> Jonathan would be able to answer more questions re: upstream

Can provide general details, but specifics of this patch is probably
something for Igor as it's not CXL specific.

Soft freeze for 11.0 has passed, so this will be a 11.1 feature.
https://wiki.qemu.org/Planning/11.0
Is the 11.0 timeline. (11.1 will go up around time of 11.0 release).

Jonathan

