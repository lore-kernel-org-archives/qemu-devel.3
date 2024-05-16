Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C09C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 11:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Z7S-0006yv-Ga; Thu, 16 May 2024 07:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7Z7R-0006y8-0D; Thu, 16 May 2024 07:17:53 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s7Z7P-0004xW-27; Thu, 16 May 2024 07:17:52 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 28CA141989;
 Thu, 16 May 2024 13:17:48 +0200 (CEST)
Message-ID: <e613e65b-fc96-459f-bb5f-c2dcb9518086@proxmox.com>
Date: Thu, 16 May 2024 13:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] accel/tcg: Always call tcg_flush_jmp_cache() on
 reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
References: <20240503123456.28866-1-philmd@linaro.org>
 <20240503123456.28866-6-philmd@linaro.org>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240503123456.28866-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

Am 03.05.24 um 14:34 schrieb Philippe Mathieu-Daudé:
> In commit bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
> we unfortunately restricted the tcg_flush_jmp_cache() to system
> emulation. Move it to the common tcg_exec_cpu_reset_hold() handler
> so user emulation gets the jmp_cache initialized when threads
> are created.
> 
> Remove the NULL check in tcg_flush_jmp_cache() from commit 4e4fa6c12d
> ("accel/tcg: Complete cpu initialization before registration") which
> was a band-aid fix for incorrect commit bb6cf6f016.
> 

AFAICT, commit 4e4fa6c12d was already present in v7.2.0, while commit
bb6cf6f016 only later in v8.2.0. So is it really fine to remove the NULL
check?

Best Regards,
Fiona


