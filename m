Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E76BCAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuHi-0001BL-Dw; Wed, 17 Sep 2025 11:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1uyuHd-000182-LS; Wed, 17 Sep 2025 11:41:28 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1uyuHF-0004Ho-8E; Wed, 17 Sep 2025 11:41:22 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MEmtx-1v9ehN2WJn-004gwj; Wed, 17 Sep 2025 17:40:34 +0200
Message-ID: <13a10abd-00a9-4c70-84e5-f62409e73215@vivier.eu>
Date: Wed, 17 Sep 2025 17:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] vhost-user-test: remove trailing newlines in
 g_test_message() calls
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20250917142919.928244-1-mjt@tls.msk.ru>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250917142919.928244-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NtO23hB4oy8kLq0V4rdlYphgX6r9W2ZPzY5tpByImG/Sp9KIy2n
 idXLcQ16jl++68DfbHgy+igeaZ/9T6OrId5dZ4LunfZ6cCsIWMMQaP7RNGO7tR1A/uYNANV
 0sYXA/H15rjOOdr3mj2VPnpK342F/KwCGxHUhrEA9+xPT6Z8MIV4ns0ocOxGyJDoh0ctguu
 u+HIeUSaIVncNShGXobyQ==
UI-OutboundReport: notjunk:1;M01:P0:V6xMKL9y9G0=;FvW/8TZGQWkZBedU/8YoTBNtqO/
 MY2lsDVN/e52dC5QIbnF9jl8IuInRwexSfkiwEV2XVhI/1FE376gO5zwJVnegwDZ8UY0illRX
 VTW2jDEw9COq1Iam7PYXTTONS4qY2BNz2qKMBKIQ4S99M0HJgERrQy9rRVtGuNo3/4fQixNd1
 8pdtVO8MDjEPqA0pvNOL+6lqUbV1VG/x1BgzixTmD8F3nOBNEmzj2zJTd/tHGc9rUUQ0JcdGB
 fz6ZLFOCUoMuyp8A9zwVThioYKgEzlAhBuwMtrquGO0qKcSoSo0x8sqAzeiXgk2jqDgb2XKW9
 gQQu1kteJSrb05eI0hTJVNwqL2BbeTpB5IVT+kVSOGmO+nfPX4nNXh2d/opxJtJr6OlX8Vhk4
 3jTB+UdL416fWxLdFu70nU5180UknGqAsOX05sdaz6ecLzl3qPA/Uxu5TF2KBtkBjD9Up1LEa
 JtSG3hDKUqLkRCrAjdf43bOaWgmtC4MRj644+gkxornMKntMZEv15EHXMoXck+CbUtVkAuWxy
 /2rBjviTHBlzcvha/9VysElP1edeXt4YBxi4zhNDFL/TUbfVfGwvSyHd84M+FzIVxK7nIqNO4
 /7DBFThCTFkwqa9WjwNA5MiF7HIVlPUW+Pa0GoAGG4e+tjp0XvUYxtdtdzubHkpRqGjw1DPIl
 iSW3XgcK/DEb4pC3W7ZmB793u4DcLS5DzSRQRKRnf+CZMPh13T++9CmSaYLvnhm26LsYatv7E
 Lps35qkzTNR/H6HYXi9msT3Et2fCtse37vismkzetC6CEiFOd68r9yjsq/XO0b2ClW4rjKALw
 xkZT8CwfBA7Z4GF6U3Ni1zn+IFBaO1pGgg43KguQNOkI7CBJoWcy5lmq2SBnTLEyCmXIHBits
 lgR1RwmXsNgLvylXaLw5h4g1c8Yo8OL/6hbSFQahBDTqrk2/BisIIcVftw6jzDeevounXrnIG
 bBMpIRjzQyqpfJISCYoZqj2QoKuk/xeJHXvZxbcWpKm8LiEOo6YwBlNs0lAyVZ46HVsenKSm1
 724QPH8emgDlLGYrJ4CzRLUOKjR2wgvg1djl9387D6iXB+0kTBvMddF04yOx01HjwCePGkaTw
 mGjT5gwaBZDIN/euy/5iBbgqBOxOGbCb/X0InFUxpmWTTT9hRV7WJbv19VrhGQKovFslXA5hU
 nNQ/ubZSiQA8ChQNYofOA7HfuobgWLvasHA7sa2kT1FPppxuWvseWL0KRvOW0vtxfnFOD9mzl
 0EXJhXOE0gUmO77s9XVY9kbgCzbWYdsmhHLiZEcwOf0hp8+riplFNx9dQTMWxNXMNQT05C77u
 dKkw1ax6Kn1/sLYCmv4PX4dF2EjqQ+QU7B3mv8XaNunogSyQegfUXsTpUV7MyANsdiuO2fh6y
 4n9z/Bo3BKQSmp8gQIwjg+SSkhy6ZPd8FFy2khHG1RTlmLpYi1KQArGNZhIGYTSuh4oykrsbX
 oS2dxK3DTYQPQVyiQ9M00DNiD6unkVnEwTYSwcoJo76eQj4znKHLUhEEAznt7IHq4AEvcy/Gs
 hycVkO8uzLLmBqeh2XnLOjIF/yylWlKvvYPq8CukFuwz+i+VrbBvf/i/72LXK5iVJaALDxNec
 XQSXt6nexsMCdQDgvgMTDgsZA5WvWxqBr9932LpwUXucb2BVYNwyu9Gu4fsySGrJnWvr0InIa
 P5TphH6wNr2c27ck5MUGJ5y1Dc2+Ii6YrhpDXr6BlCWtOCSqfuRSxUnfSFUyMZ0CKza38ruZN
 sHF6sYM5cALzGMTYH9DVZpYDoKaQ0jLu0OQ==
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Le 17/09/2025 à 16:29, Michael Tokarev a écrit :
> Fixes: c9a1ea9c52 Revert "tests/qtest: use qos_printf instead of g_test_message"
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   tests/qtest/vhost-user-test.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

