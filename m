Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D013CC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 20:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro8Rd-0002LG-Uj; Sat, 23 Mar 2024 16:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ro8Rc-0002L1-AO
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 16:58:24 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1ro8RS-0002u1-Eq
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711227490; x=1711832290; i=deller@gmx.de;
 bh=rsDntOjpYtwHqJUDF6Aaw2EW15fCP9z6VOPH2OZ7oGE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=msvV1H8FwLpfTo903uPSuY0lsomXHVDv/2I/oxK7iLgmryPSgxMP//A2hLAz2bm2
 uhBC2OhtslzWT0p8ezQy7ymFNrstseEz0gi7amQ+TBKVSDX5L8aksxcot4uCm15Mc
 tcRAdX8bmz99dCn9+SM1hfkpbwCpLgtz/792YFjdgCNV8XWG0ApbvNs+Yzs4BG/mp
 Yj16MyOL+yxJnuAMJ3lKx7i9kHuxpHDKeSHk0I5bcPk9CjmwzVHlksmYIyASdNeL0
 tRjJwrLp7eN2TSgJqWpaGahgTaJ86SOsD8hlfCqoLaZ765zK+GjmBT9ZEsv3M8Ic1
 CAHVikjnwX+eg4HRtw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.187.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1rSd121QWk-00LXfL; Sat, 23
 Mar 2024 21:58:10 +0100
Message-ID: <99f4456f-51b7-452e-9eb0-bfea402a90b6@gmx.de>
Date: Sat, 23 Mar 2024 21:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/hppa: Mark interval timer write as io
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: svens@stackframe.org
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
 <20240323172954.1041480-6-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240323172954.1041480-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQZdBAekbM6XNAgD3XoF5W2KGD6VBrigvc+3UEHTv46WpOEvU7R
 fj9oughMdL3h1YXtn3rBlprivMjcGnoH+YsUVtZVUfrP6V7eJCsSDz/szThb7T9e0+O4kKy
 sXWjYSaodAplp+Eh95FLrSrDlbL9OeIamyDr3LZQ7z7P9NDxMaFO8BJU470XmiUYbfxmVQv
 pJrA6jmkR1j7WgyIGVZcw==
UI-OutboundReport: notjunk:1;M01:P0:1GzH6zCOvEY=;f5mnXz0JZkXdj6TGwkEcoIwTQyf
 APd/tPHD5o4kReenPJBUs6GSimCO/KM6vzJNbH+WQ68RT6zpg4yaunFLUVwjV9Ln+xIWX4mm+
 UMV0YmHoLUNUXTIxavg4hbsEG5+4iUvM8GYHwZY8tNSI/KaPKFYzkFMXiQNz3tUoe1P7ZmqDd
 D65uSK/Ucjn2RhiRGGumGIic2Iys2PZvpOzNQpuBky3gyM8zYKK99J5/EF1ZGqJQ1i70LJDk5
 JmgovHm7zO8hDVRwnqmWqk6Ctg0Jhua2Bgm26QWupuLQXCZjZOG/LFWL7jv93DQB214fGOkNf
 veAV+h+qksxc4DJO//eclronSHssZfmfeXBCOyA19xE+3AUSpCxWMeKzR70ORKi5ZAm6WZS0B
 Kj54WjASxeDeslduP7Tqn/dbXp8oaxRKg/hVNaW8vLHcCdE0ONiB5kK5GPA2T/k5jwjXG7kLf
 h27vDl6LR1owdRSDypyOyTdkOKMGC4moSM1eEHk20xfJpPAuyhy1KbGm8GdXadUVtAOdhQsYm
 KUxy4UElNeuOlcq1g7v0Km5hgcqxDaLRTcYt7+VjOmAxsn0OBy2q6PfGXYHfijUZiqbwlagBF
 +8gH6Unh8gAi0sUZ5jpyHN4k3wA9PolMcIBjaMJHfGNYrxvt+YWaNVY+pspVnVtAvzmwKpMU+
 dzCBYLu7s5eC8JhnlHN1hLka9QW94dJWN7pj12Kc2fkmFu5jrCX6zwqNT+X/trVr/zmJhrXLQ
 m617utYYfTMcIfXZk816UuqUlEghg6a0iIHTT5ZeFbjYKJTRscSbzxAP2mxTGLhCkKdBsRz1o
 cBG1ZqvSzoH6I58OyvRq8hpKZ8ehEPNec7YE9gAm2MJ84=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 3/23/24 18:29, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>   target/hppa/translate.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index ceb739c54a..8c1a564c5d 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2162,6 +2162,9 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtc=
tl *a)
>
>       switch (ctl) {
>       case CR_IT:
> +        if (translator_io_start(&ctx->base)) {
> +            ctx->base.is_jmp =3D DISAS_IAQ_N_STALE;
> +        }
>           gen_helper_write_interval_timer(tcg_env, reg);
>           break;
>       case CR_EIRR:


