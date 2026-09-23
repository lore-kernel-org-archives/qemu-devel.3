Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5835FC982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9LRt-00046H-8S; Wed, 23 Sep 2026 07:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x9LRN-00044g-MN; Wed, 23 Sep 2026 07:47:11 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x9LRK-0002Ns-Oq; Wed, 23 Sep 2026 07:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=6GnjRlmf2e18XObWxLVlw/bfiPGdR7DecSb4FuWUfT4=; b=GVktuz/Ok8NJYgf
 03Qz4O0U5NK8WoKFDsavOlnvOkwHB3U4E+gMTznWPM9YXwBt9tZytMwIkCdadqhmuuoW7dAqjCF+/
 RTAkDGraNKPt2HN9fXz7NnfWUsVJmRwIiH2HqURVCjKATrsUaKdIo53faq/HiAERxI9VxifEineYu
 1I=;
Date: Wed, 23 Sep 2026 13:52:34 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, 
 alistair.francis@wdc.com, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v5 01/11] target/riscv: Replace TYPE_RISCV_CPU_BASE
Message-ID: <arO88UKvkxwKn28B@hive.localdomain>
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-1-f98c5a244636@rev.ng>
 <3c8a82f3-6f48-416a-94d7-64f4f65d12b5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c8a82f3-6f48-416a-94d7-64f4f65d12b5@oss.qualcomm.com>
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

On 21/09/26, Philippe Mathieu-Daudé wrote:
> On 2026-09-18 0:04, Anton Johansson wrote:
> > TYPE_RISCV_CPU_BASE is used only to initialize the correct default
> > machine for 2 machines. Replace it with a runtime check.
> > 
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > --
> > Note, this patch is to be replaced by: 20260526095731.63525-1-philmd@linaro.org
> 
> I don't remember, do we need the whole series or only
> https://lore.kernel.org/qemu-devel/20260526095731.63525-5-philmd@linaro.org/

We need the microblaze patch as well

  https://lore.kernel.org/qemu-devel/20260526095731.63525-4-philmd@linaro.org/

the only real change between the remaining patches in your series and
this one, is that in yours microblaze defaults to TYPE_RISCV_CPU_RV[32|64]I.

