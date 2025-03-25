Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A68C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 10:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx1PP-000684-Kz; Tue, 25 Mar 2025 06:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1tx1P7-000653-5R; Tue, 25 Mar 2025 06:21:08 -0400
Received: from mail-gw02.astralinux.ru ([195.16.41.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1tx1P5-0004Uh-10; Tue, 25 Mar 2025 06:21:04 -0400
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw02.astralinux.ru (Postfix) with ESMTP id D80911F9E3;
 Tue, 25 Mar 2025 13:20:58 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru
 [10.177.185.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
 Tue, 25 Mar 2025 13:20:57 +0300 (MSK)
Received: from [10.177.20.126] (unknown [10.177.20.126])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4ZMQtK1k2lz1c0t9;
 Tue, 25 Mar 2025 13:20:57 +0300 (MSK)
Message-ID: <ff0788d7-9bfb-4dc4-b9e4-c55d813e709d@astralinux.ru>
Date: Tue, 25 Mar 2025 13:20:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target/arm: add bounding a->imm assertion
Content-Language: ru
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Anastasia Belova <nabelova31@gmail.com>, qemu-arm@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20250325101752.58825-1-abelova@astralinux.ru>
From: Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <20250325101752.58825-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398,
 {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1; 127.0.0.199:7.1.2;
 new-mail.astralinux.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192081 [Mar 25 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2025/03/25 08:37:00 #27838357
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=195.16.41.108; envelope-from=abelova@astralinux.ru;
 helo=mail-gw02.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Sorry for accidentaly sending this patch twice.

My mail system reports that it can't be delivered to Peter Maydell 
<peter.maydell@linaro.org>
and I am trying to solve it.

On 3/25/25 1:17 PM, Anastasia Belova wrote:
> From: Anastasia Belova <nabelova31@gmail.com>
>
> Add an assertion similar to that in the do_shr_narrow().
> This will make sure that functions from sshll_ops
> have correct arguments.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   target/arm/tcg/translate-sve.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index d23be477b4..47ada85c92 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -6250,6 +6250,7 @@ static bool do_shll_tb(DisasContext *s, arg_rri_esz *a,
>       if (a->esz < 0 || a->esz > 2) {
>           return false;
>       }
> +    assert(a->imm > 0 && a->imm <= (8 << a->esz));
>       if (sve_access_check(s)) {
>           unsigned vsz = vec_full_reg_size(s);
>           tcg_gen_gvec_2i(vec_full_reg_offset(s, a->rd),

