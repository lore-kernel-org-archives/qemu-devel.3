Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77575C44521
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXJw-0001qF-Dd; Wed, 21 Jan 2026 07:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viXIy-0007Hu-6W
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:27:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1viXIv-0002YU-H5
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:27:22 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx3N614qBzHnGfT;
 Wed, 21 Jan 2026 20:26:46 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id D31F840569;
 Wed, 21 Jan 2026 20:27:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 12:27:19 +0000
Date: Wed, 21 Jan 2026 12:27:18 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 03/13] scripts/qmp_helper: add support for FRU Memory
 Poison
Message-ID: <20260121122718.000015a5@huawei.com>
In-Reply-To: <e9c9d9562bc9c71623f39c2b78eb4efcdb1679cc.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <e9c9d9562bc9c71623f39c2b78eb4efcdb1679cc.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
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

On Wed, 21 Jan 2026 12:25:11 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This GUID record descriptor was added on UEFI 2.11.
> Add support for it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Matches the spec.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  scripts/qmp_helper.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> index 7e786c4adfd9..19bf641a13ce 100755
> --- a/scripts/qmp_helper.py
> +++ b/scripts/qmp_helper.py
> @@ -736,3 +736,7 @@ class cper_guid:
>      CPER_CXL_EVT_DYNA_CAP = guid(0xCA95AFA7, 0xF183, 0x4018,
>                                   [0x8C, 0x2F, 0x95, 0x26,
>                                    0x8E, 0x10, 0x1A, 0x2A])
> +
> +    CPER_FRU_MEM_POISON = guid(0x5E4706C1, 0x5356, 0x48C6,
> +                               [0x93, 0x0B, 0x52, 0xF2,
> +                                0x12, 0x0A, 0x44, 0x58])


