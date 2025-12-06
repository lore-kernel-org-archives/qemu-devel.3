Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378C3D3B7E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 18:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRxCE-0005wr-2S; Sat, 06 Dec 2025 13:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1vRxCB-0005wZ-C7
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 13:39:51 -0500
Received: from mail.xen0n.name ([115.28.160.31] helo=mailbox.box.xen0n.name)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1vRxC6-0003TG-OO
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 13:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1765046373; bh=pMRCgNHwqhT0LeJo22YEdxqttlNq0bny2cHcITE3YYU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M0vLLdNQxuLhRwET9KM4s/GhVyb6JBEFzwyEZk2zr8llZdz77ed0p6OOzlfoJLHhm
 6pygjYo0B4+6e7PDOYfn3ZR+S/AbFa88Aht+nfjqXBMubHsf6xJeuGscyZIboZjFQ1
 DGVtPXCcqCik+taJc6FbaCUjc8Nna4LR/wuKY7uE=
Received: from [IPV6:240e:b8f:939d:bb00::8c0] (unknown
 [IPv6:240e:b8f:939d:bb00::8c0])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id ABF0760150;
 Sun,  7 Dec 2025 02:39:33 +0800 (CST)
Message-ID: <da02f3b5-3b5c-45fe-91db-545e73df8a0f@xen0n.name>
Date: Sun, 7 Dec 2025 02:39:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add LoongArch v1.1 instructions
To: gaosong <gaosong@loongson.cn>, Jiajie Chen <c@jia.je>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, git@xen0n.name,
 bibo mao <maobibo@loongson.cn>
References: <20251119122822.1513788-1-c@jia.je>
 <613a7dfa-c3f4-092b-3938-dc41f6fd3812@loongson.cn>
Content-Language: en-US
From: WANG Xuerui <i.qemu@xen0n.name>
In-Reply-To: <613a7dfa-c3f4-092b-3938-dc41f6fd3812@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.28.160.31; envelope-from=i.qemu@xen0n.name;
 helo=mailbox.box.xen0n.name
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 11/26/25 11:50, gaosong wrote:
> [snip]
> I run this test with qemu on x86  and loongarch machine.
> but the results is not same.
> on x86
> gaosong@fedora:/home1/gaosong/work/clean/qemu$ ./build/qemu-loongarch64 
> -cpu max test
>   frecip: 0.333333
> frecipe: 0.333333
> frsqrt: 0.577350
> frsqrte: 0.577350
> SC.Q passed
> 
> on Loongson-3C6000/D
> [root@localhost gs]# ./test
> frecip: 0.333333
> frecipe: 0.333332
> frsqrt: 0.577350
> frsqrte: 0.577345
> test: test.c:49: test_sc_q: Assertion `res == 0' failed.
> Aborted (core dumped)
> 
> 1. The results from frecipe/frsqrte differ from those on the physical 
> machine. Is this due to precision issues?
>     Should we align with the physical precision? Or can we disregard 
> this discrepancy?

The problem is that Loongson never published the exact algorithm used in 
LA664 micro-architecture regarding frecipe/frsqrte. Of course it's plain 
impossible to match hardware behavior without the info. I remember 
trying the famous fast inverse square root algorithm in Quake III but 
the results didn't match frsqrte behavior, and I didn't investigate further.

I just googled again and found [1] though, where someone has figured out 
the operations of x86 RSQRTSS; I don't have time to test it against 
LoongArch myself, unfortunately, but anyone interested can have a try...

[1]: 
https://stackoverflow.com/questions/58614226/is-there-a-c-function-that-returns-exactly-the-value-of-the-built-in-cpu-opera

