Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD716E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEAv-00042a-SO; Fri, 10 Jan 2025 07:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tWEAr-00042M-Ns
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:31:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tWEAp-0006VV-HB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:31:37 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV1Fh1Dc8z6L4tL
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 20:30:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 62139140C98
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 20:31:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 13:31:30 +0100
Date: Fri, 10 Jan 2025 12:31:28 +0000
To: "Zhijian Li (Fujitsu)\" via <qemu-devel@nongnu.org>"@domain.invalid
CC: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>
Subject: Re: CXL emulation on aarch64
Message-ID: <20250110123128.00004a5b@huawei.com>
In-Reply-To: <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
References: <0C019F50-9020-42ED-B051-998F03BFB709@linux.dev>
 <483e8037-3c72-4560-b4b8-2437d37ca8c4@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Fri, 10 Jan 2025 09:20:54 +0000
"Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org> wrote:

> On 10/01/2025 13:29, Itaru Kitayama wrote:
> > Hi,
> > Is anybody working on the CXL emulation on aarch64? =20
>=20
> I'm not currently working on the CXL emulation on aarch64.
>=20
> However, IIRC the CXL maintainer's tree should work.
> https://gitlab.com/jic23/qemu/

Pick up latest branch from there. I'm prepping a rebased version
with some new stuff but might take a few more days.

Note my main development work is on arm64 so that tends to work
more reliably than x86 which I only lightly test for stuff that
isn't ready for upstream yet.

Give me a shout if you run into any problems.

The main blocker on upstreaming this is resolving the missing device tree
support for PCI expander bridges.  I've not made any progress on this since
talk at Linaro connect in 2023.

Jonathan


>=20
>=20
> Thanks
> Zhijian
>=20
> > If there=E2=80=99s a WIP branch, a pointer would be appreciated.
> >=20
> > Itaru =20


