Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D62CF34AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLiBz-0007Sr-UT; Wed, 19 Nov 2025 08:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vLiBp-0007SS-Nb
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:25:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vLiBm-0007EQ-UI
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:25:40 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBMds38QGzJ46DJ;
 Wed, 19 Nov 2025 21:24:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 5ADD0140371;
 Wed, 19 Nov 2025 21:25:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Nov
 2025 13:25:16 +0000
Date: Wed, 19 Nov 2025 13:25:15 +0000
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC: <qemu-devel@nongnu.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 2/9] contrib/gitdm: add group-map for Huawei
Message-ID: <20251119132515.00006f16@huawei.com>
In-Reply-To: <20251119113953.1432303-3-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-3-alex.bennee@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 19 Nov 2025 11:39:45 +0000
Alex Benn=E9e <alex.bennee@linaro.org> wrote:

> While we do see contributions from the top-level domain some
> contributors also post via other addresses.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
>  contrib/gitdm/group-map-huawei | 5 +++++
>  gitdm.config                   | 1 +
>  2 files changed, 6 insertions(+)
>  create mode 100644 contrib/gitdm/group-map-huawei
>=20
> diff --git a/contrib/gitdm/group-map-huawei b/contrib/gitdm/group-map-hua=
wei
> new file mode 100644
> index 00000000000..c287dd5d2b3
> --- /dev/null
> +++ b/contrib/gitdm/group-map-huawei
> @@ -0,0 +1,5 @@
> +#
> +# Some Huawei contributors submit via another domain
> +#
> +
> +mchehab+huawei@kernel.org
> diff --git a/gitdm.config b/gitdm.config
> index 06ac729c7bc..2d75dd4deee 100644
> --- a/gitdm.config
> +++ b/gitdm.config
> @@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-amd AMD
>  GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
>  GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
>  GroupMap contrib/gitdm/group-map-facebook Facebook
> +GroupMap contrib/gitdm/group-map-huawei Huawei
>  GroupMap contrib/gitdm/group-map-ibm IBM
>  GroupMap contrib/gitdm/group-map-janustech Janus Technologies
>  GroupMap contrib/gitdm/group-map-netflix Netflix


