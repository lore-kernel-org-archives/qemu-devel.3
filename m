Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88CAD74960
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVY0-0005Ip-S9; Fri, 19 Dec 2025 03:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vWVXq-0005Hc-QM; Fri, 19 Dec 2025 03:09:08 -0500
Received: from out28-83.mail.aliyun.com ([115.124.28.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vWVXm-00041E-Ss; Fri, 19 Dec 2025 03:09:02 -0500
Received: from 127.0.0.1(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.foLEUmb_1766131725 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 19 Dec 2025 16:08:46 +0800
Message-ID: <0e543e10-970d-4a7c-aa79-d3a0a6358e72@zevorn.cn>
Date: Fri, 19 Dec 2025 16:08:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, alvinga@andestech.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, qemu-riscv@nongnu.org,
 vivahavey@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20251201014255.230069-1-alvinga@andestech.com>
Subject: Re: [PATCH v3 0/2] RISC-V: Initial support versioning of debug
 specification
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <20251201014255.230069-1-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.28.83; envelope-from=chao.liu@zevorn.cn;
 helo=out28-83.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 1 Dec 2025 09:42:53 +0800, Alvin Chang via wrote:
> This series try to support versioning of debug specification. The early debug
> implementation supports debug specification v0.13, and later new trigger types
> were added which are defined in debug specification v1.0 version. To support
> both v0.13 and v1.0, we add 'debug-1.0' as CPU property to let user choose
> debug specification v1.0 by specifying "debug-1.0=true". The default version
> is still v0.13 if 'debug-1.0' is not provided and set.
>
> For example, to enable debug specification v1.0 on max CPU:
> * -cpu max,debug-1.0=true
>
> Changes since v2:
> * Improve commit message and fix typo
> * Apply "Reviewed-by" tags
>
> Changes since v1:
> * Apply suggestions from Daniel. Using boolean property instead of string.

This is great work! Thanks to Alvin Chang for refining the sdext. It seems we
are one step closer to merging rvsp-ref into the mainline.

What are your thoughts on this, Daniel?

Thanks,
Chao

