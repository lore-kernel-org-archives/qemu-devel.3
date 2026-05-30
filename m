Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8DDCD6E4A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 06:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTDKY-0008MG-8H; Sat, 30 May 2026 02:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wTDKT-0008M2-NZ
 for qemu-devel@nongnu.org; Sat, 30 May 2026 02:37:54 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wTDKK-0008OG-Ti
 for qemu-devel@nongnu.org; Sat, 30 May 2026 02:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780123042; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=4W8HyUWoFHCcDQqi9J5++gkIKzc41My1fR5qX7OUQbI=;
 b=bbnQnlshLL5t1mvgR/CQxB7l4JPAlUH4lrJn9ilntuIBk7Io4o/Vc8SpPf6wpTF4G6JTrfEAIWO+nW7OsrcJTsw5i+VqZVDZarTu3J61NYCTYJ1+QGc1i5z7SqR+FFfqAobVb4xObHkDxNGzoFe+LxBUyxBYFtQyCy7tFOc2en0=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=2; SR=0;
 TI=SMTPD_---0X3r3AFh_1780123040; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3r3AFh_1780123040 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 30 May 2026 14:37:21 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] util/cutils: drop qemu_strnlen() in favor of strnlen()
Date: Sat, 30 May 2026 14:37:19 +0800
Message-ID: <20260530063719.62048-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cac90947-4f58-4fa4-aecf-44ead131c57c@linaro.org>
References: <cac90947-4f58-4fa4-aecf-44ead131c57c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 29 May 2026 08:02:41 +0200, Philippe Mathieu-Daudé wrote:
> Using size_t here and removing the line in docs/devel/style.rst:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Thanks!

Both suggestions have been applied in v2:

https://lore.kernel.org/qemu-devel/20260530062816.59206-1-guobin@linux.alibaba.com/

