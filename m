Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DB606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOr9S-0003AM-90; Thu, 05 Nov 2026 01:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xOr9P-0003AC-EF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:40:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xOr9L-0007nA-Ry
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:40:43 -0500
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8AxS_DeJOxqko4cAA--.17315S3;
 Thu, 05 Nov 2026 14:40:30 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxNs3dJOxqiYEyAA--.24447S2;
 Thu, 05 Nov 2026 14:40:29 +0800 (CST)
Subject: Re: [PATCH 0/2] target/loongarch: Set signed integer comparison with
 asrtle_d() helper
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@mailo.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20261029130109.185509-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <872ee641-14f3-87fb-1524-469b84f378cf@loongson.cn>
Date: Thu, 5 Nov 2026 14:38:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029130109.185509-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxNs3dJOxqiYEyAA--.24447S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF43urWUArW8WF1rXr4xGrX_yoWDXrg_XF
 4fKw1kur48Za17KFyY9Fs0vay5GFWvyrn8AFnFvF43Jry5JFZ8Ww1qqa93Aw1Sqr4Fkr15
 ArZ7JryI934xZosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>


> According to the LoongArch manual, ldle/ldgt/stle/stgt and
> fldle/fldgt/fstle/fstgt perform unsigned address comparison, while
> asrtle/asrtgt perform signed address comparison.
>
> Currently all of them use unsigned integer comparison. Add unsigned
> comparison helpers asrtle_du()/asrtgt_du() for the unsigned cases, and
> change asrtle_d()/asrtgt_d() to perform signed integer comparison.
>
> Bibo Mao (2):
>    target/loongarch: Add asrtle_du()/asrtgt_du() helpers
>    target/loongarch: Change asrtle_d()/asrtgt_d() for signed integer
>      comparison
>
>   target/loongarch/tcg/helper.h                 |  2 ++
>   .../tcg/insn_trans/trans_fmemory.c.inc        |  8 +++----
>   .../tcg/insn_trans/trans_memory.c.inc         |  8 +++----
>   target/loongarch/tcg/op_helper.c              | 22 ++++++++++++++++++-
>   4 files changed, 31 insertions(+), 9 deletions(-)
>
>
> base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b


