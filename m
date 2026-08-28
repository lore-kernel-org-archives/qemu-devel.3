Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D65C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvBr-0001lk-Cd; Fri, 28 Aug 2026 07:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liliang2057@phytium.com.cn>)
 id 1wztWD-00074P-Vg; Fri, 28 Aug 2026 06:09:05 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liliang2057@phytium.com.cn>)
 id 1wztWB-0008W1-Lo; Fri, 28 Aug 2026 06:09:05 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwD37aUzXpFqDjQeAQ--.29551S2; 
 Fri, 28 Aug 2026 18:08:51 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8Dwj3IwXpFqpJSUAA--.16708S3;
 Fri, 28 Aug 2026 18:08:50 +0800 (CST)
From: Liang Li <liliang2057@phytium.com.cn>
To: qemu-devel@nongnu.org
Cc: Liang Li <liliang2057@phytium.com.cn>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, joel@jms.id.au
Subject: Re: [RFC PATCH 0/1] RISC-V vector fault-only-first vl truncation
 under plugin memory callbacks
Date: Fri, 28 Aug 2026 18:05:26 +0800
Message-ID: <20260828100741.3920085-1-liliang2057@phytium.com.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <CAN7m+mAFT2Cm2yvHb9KKRe6GH=Rg-S+8NXYSjkFhXEJS0wtD7g@mail.gmail.com>
References: <CAN7m+mAFT2Cm2yvHb9KKRe6GH=Rg-S+8NXYSjkFhXEJS0wtD7g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dwj3IwXpFqpJSUAA--.16708S3
X-CM-SenderInfo: 5oloxttqjsikux6sx5pwlxzhxfrphubq/1tbiAQABAGqQkEkGAQAAsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=liliang205
 7@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=liliang2057@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:56:03 -0400
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

Hi Anton,

Thanks for confirming -- good to know it's not just us. We hit the
same thing on 500.perlbench_r, also at a vectorized strlen.

The RFC below carries a prototype fix: the probes inside vext_ldff()
now go through probe_access_full_mmu() (check_mem_cbs=false), while
real loads and stores stay instrumented. With it, our reproducer
reports identical instruction counts with and without memory
callbacks.

If you have a tree where the xalancbmk case reproduces, feel free to
give it a try; I'd also be curious whether you had a fix direction
in mind.

Thanks,
Liang


