Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD2EC4452E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYUv-0001Kh-Ms; Wed, 21 Jan 2026 08:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viYUm-00011b-9L
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:43:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viYUk-0001gZ-NV
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:43:39 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx54G6PP5zJ469G;
 Wed, 21 Jan 2026 21:43:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 113AD40569;
 Wed, 21 Jan 2026 21:43:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 13:43:36 +0000
Date: Wed, 21 Jan 2026 13:43:35 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 13/13] scripts/ghes_inject: improve help message
Message-ID: <20260121134335.00001c2b@huawei.com>
In-Reply-To: <5b4efacb92c898d5b345e6df1579756a79b586dc.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <5b4efacb92c898d5b345e6df1579756a79b586dc.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
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

On Wed, 21 Jan 2026 12:25:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Add a one-liner help message for each type of error inject
> command, and use raw formatter to keep line breaks.
>=20
> While here, use a more uniform language.
>=20
> With that, "ghes_inject -h" will now show:
>=20
>   usage: ghes_inject.py [options]
>=20
>   Handles ACPI GHESv2 error injection via the QEMU QMP interface.
>=20
>   It uses UEFI=E2=80=AFBIOS=E2=80=AFAPEI features to generate GHES record=
s, which helps to
>   test CPER and GHES drivers on the guest OS and see how user=E2=80=91spa=
ce
>   applications on that guest handle such errors.
>=20
>   positional arguments:
>     {arm,pcie-bus,fuzzy-test,fuzzy,raw-error,raw}
>       arm                 Inject an ARM processor error CPER, compatible =
with
>                           UEFI 2.9A Errata.
>       pcie-bus            Inject a PCIe bus error CPER
>       fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
>       raw-error (raw)     Inject CPER records from previously recorded on=
es.
>=20
>   options:
>     -h, --help            show this help message and exit
>=20
>   QEMU QMP socket options:
>     -H, --host HOST       host name (default: localhost)
>     -P, --port PORT       TCP port number (default: 4445)
>     -d, --debug           enable debug output (default: False)
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



