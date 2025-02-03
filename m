Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66CCC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teu8Q-0003jX-K4; Mon, 03 Feb 2025 05:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1teu8O-0003iw-S6; Mon, 03 Feb 2025 05:56:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1teu8N-00027k-Bd; Mon, 03 Feb 2025 05:56:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymjzx2xtgz6L4xr;
 Mon,  3 Feb 2025 18:54:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1F2FB140B73;
 Mon,  3 Feb 2025 18:56:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 11:56:52 +0100
Date: Mon, 3 Feb 2025 10:56:51 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 14/14] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20250203105651.00001a4e@huawei.com>
In-Reply-To: <80858743b6fd67db3f48ac8cb466bbcde5b11132.1738345063.git.mchehab+huawei@kernel.org>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <80858743b6fd67db3f48ac8cb466bbcde5b11132.1738345063.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 31 Jan 2025 18:42:55 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
> 
> Add a helper script with subcommands to prepare such data.
> 
> Currently, only ARM Processor error CPER record is supported, by
> using:
> 	$ ghes_inject.py arm
> 
> which produces those warnings on Linux:
> 
> [  705.032426] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> [  774.866308] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [  774.866583] {4}[Hardware Error]: event severity: recoverable
> [  774.866738] {4}[Hardware Error]:  Error 0, type: recoverable
> [  774.866889] {4}[Hardware Error]:   section_type: ARM processor error
> [  774.867048] {4}[Hardware Error]:   MIDR: 0x00000000000f0510
> [  774.867189] {4}[Hardware Error]:   running state: 0x0
> [  774.867321] {4}[Hardware Error]:   Power State Coordination Interface state: 0
> [  774.867511] {4}[Hardware Error]:   Error info structure 0:
> [  774.867679] {4}[Hardware Error]:   num errors: 2
> [  774.867801] {4}[Hardware Error]:    error_type: 0x02: cache error
> [  774.867962] {4}[Hardware Error]:    error_info: 0x000000000091000f
> [  774.868124] {4}[Hardware Error]:     transaction type: Data Access
> [  774.868280] {4}[Hardware Error]:     cache error, operation type: Data write
> [  774.868465] {4}[Hardware Error]:     cache level: 2
> [  774.868592] {4}[Hardware Error]:     processor context not corrupted
> [  774.868774] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> 
> Such script allows customizing the error data, allowing to change
> all fields at the record. Please use:
> 
> 	$ ghes_inject.py arm -h
> 
> For more details about its usage.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks for examples.  Given my poor python skills take this one with
a pinch of salt.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

