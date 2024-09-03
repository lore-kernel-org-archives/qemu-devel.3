Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F3CD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUzm-0008Ca-DQ; Tue, 03 Sep 2024 10:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1slUzk-00082g-Av; Tue, 03 Sep 2024 10:59:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1slUzh-0007U3-8E; Tue, 03 Sep 2024 10:59:00 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WypZX66L3z6HJcx;
 Tue,  3 Sep 2024 22:55:16 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 2D30F1408FC;
 Tue,  3 Sep 2024 22:58:53 +0800 (CST)
Received: from localhost (10.47.29.115) by lhrpeml500006.china.huawei.com
 (7.191.161.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 15:58:52 +0100
Date: Tue, 3 Sep 2024 15:58:47 +0100
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <Jonathan.Cameron@Huawei.com>,
 <alex.bennee@linaro.org>, <jiangkunkun@huawei.com>
Subject: Re: [PATCH v4] target/arm/tcg: refine cache descriptions with a
 wrapper
Message-ID: <20240903155847.00000379@huawei.com>
In-Reply-To: <7fda2f7c-091f-4b8b-bd61-5f8fcbbcf8ba@linaro.org>
References: <20240903083520.209-1-alireza.sanaee@huawei.com>
 <7fda2f7c-091f-4b8b-bd61-5f8fcbbcf8ba@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.47.29.115]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 3 Sep 2024 15:18:41 +0200
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> On 3/9/24 10:35, Alireza Sanaee wrote:
> > This patch allows for easier manipulation of the cache description
> > register, CCSIDR. Which is helpful for testing as well. Currently,
> > numbers get hard-coded and might be prone to errors.
> >=20
> > Therefore, this patch adds a wrapper for different types of CPUs
> > available in tcg to decribe caches. One function `make_ccsidr`
> > supports two cases by carrying a parameter as FORMAT that can be
> > LEGACY and CCIDX which determines the specification of the register.
> >=20
> > For CCSIDR register, 32 bit version follows specification [1].
> > Conversely, 64 bit version follows specification [2]. =20
>=20
> This is the commit description,
>=20
> ---
>=20
> this part is not relevant in the git history and can go
> (hopefully the maintainer can do that for you),
>=20
> >=20
> > Changes from v2 [3] -> v3:
> >=20
> > 1) add only one function instead of ccsidr32 and ccsidr64
> > 2) use deposit32 and deposit64 in ccsidr function
> >=20
> > Chnages from v3 [4] -> v4:
> > 1) Use only one variable in the make_ccsidr function.
> > 2) Include qemu/host-utils.h to get is_power_of_2() declaration.
> >  =20
> ---
>=20
> keeping these references,
>=20
> > [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> > edition, https://developer.arm.com/documentation/ddi0406
> > [2] D23.2.29, ARM Architecture Reference Manual for A-profile
> > Architecture, https://developer.arm.com/documentation/ddi0487/latest/ =
=20
>=20
> ---
>=20
> and dropping these ones.
>=20
> > [3] https://lore.kernel.org/qemu-devel/20240830184713.224-1-alireza.san=
aee@huawei.com/
> > [4] https://lore.kernel.org/qemu-devel/20240902203211.270-1-alireza.san=
aee@huawei.com/
> >=20
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >   target/arm/cpu-features.h |  50 ++++++++++++++++++
> >   target/arm/cpu64.c        |  19 ++++---
> >   target/arm/tcg/cpu64.c    | 108
> > +++++++++++++++++++------------------- 3 files changed, 117
> > insertions(+), 60 deletions(-) =20
>=20
> Thanks for the iterations.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>=20

Thanks for the feedback.

v5 sent. hopefully that's OK.

