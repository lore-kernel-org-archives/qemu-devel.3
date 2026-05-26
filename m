Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51A4CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 16:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRuZx-0008Ma-Vb; Tue, 26 May 2026 12:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wRuZu-0008M8-8n; Tue, 26 May 2026 12:24:26 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wRuZs-0001uB-3f; Tue, 26 May 2026 12:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=1vyQbfPr+QRb9ArTr6w+/4dsSlA1tvex1+7TUXSa8Ak=; b=mzRVXzJ7SQSkDGz
 p/MBJLh0qb5SdzrZPLzOWIW1ejAw8noUOdVhC58S3cSGDU5Bi4ukOpy3U3R3JvLW4jN4fht1U8rrc
 ENgbsPUzLStAJeWth9kp9L478X6m7ILzwOBS2hB53WJKEI9H8xk8cV5ph5H4hiWqQMuKQX6uIULe8
 4o=;
Date: Tue, 26 May 2026 18:28:59 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 0/4] hw/riscv: Inline TYPE_RISCV_CPU_BASE definition
Message-ID: <ahXKPDYTK13e0R7m@hive.localdomain>
References: <20260526095731.63525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526095731.63525-1-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/05/26, Philippe Mathieu-Daudé wrote:
> Inline TYPE_RISCV_CPU_BASE in preparation of "single-binary:
> Compile hw/riscv once":
> https://lore.kernel.org/qemu-devel/20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng/
> 
> Anton Johansson (1):
>   target-info: Add target_riscv64()
> 
> Philippe Mathieu-Daudé (3):
>   hw/riscv/spike: Use 'max' CPU type by default
>   hw/riscv/microblaze-v: Use RV32I / RV64I CPU type by default
>   hw/riscv/virt: Inline TYPE_RISCV_CPU_BASE definition
> 
>  include/qemu/target-info.h      | 7 +++++++
>  target/riscv/cpu.h              | 6 ------
>  hw/riscv/microblaze-v-generic.c | 4 +++-
>  hw/riscv/spike.c                | 2 +-
>  hw/riscv/virt.c                 | 4 +++-
>  target-info.c                   | 5 +++++
>  6 files changed, 19 insertions(+), 9 deletions(-)
> 
> -- 
> 2.53.0
> 

Series:

  Reviewed-by: Anton Johansson <anjo@rev.ng>

