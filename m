Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kUF8ywGc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSR8-0000Pv-AG; Mon, 09 Nov 2026 11:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQSR3-0000PR-5h
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:41:34 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQSR1-0000QR-Cp
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:41:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e9995ce866so7443865ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794242490; x=1794847290; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/xtLUnNZFd1+dz1/zRdk+02LIm72Sp7IcLw4kNPC694=;
 b=kUF8ywGc/KjbSUGbubzurXM+wjp5tDIadK+++05Q41+qtqVxWA7cbC4l+gVQSOpwLo
 BrBe4Hl50p5qYhDLh6DRrau9FjTgdTmrVOFB/s+nxRFlLlxHu1hFrs4fytL5WRx27/By
 Knsf8ReL4osrgqoEV/XeiPjddPawSE6H4ejinjQhf3/Ye1urVbMzV2ItD2qaMvpY1SEW
 kfbxRarTMwXnAamdAN8wbgBuKkprAxw5Ud0f1ZBFtU/MmMVCVto6Db47tpcSVR5XFX4n
 GtjBNTHhblWkXQuGUD4Elu1GMNBFJ8h4G5E09UW0JHlRMEHIW56jMQaNR2NmbFyXaoWg
 RLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794242490; x=1794847290;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/xtLUnNZFd1+dz1/zRdk+02LIm72Sp7IcLw4kNPC694=;
 b=Xk66y8NwSRokJwQOH3lE/TkJSGBxjCuKa7+8AKpwJ2p+UzR+poJjnUMjuzZ5zqIAfJ
 TJtdRFp4VxZk9YDqOPm90Atb1ClYwZBrdNqIGi565ei2DH1AbO3vC5qoUJFvycYe624p
 3HUY3z1ktUD4NsFi/ItA4b6lXqWopxxbctsofDPatIwTvJu0DNqfdKK8swnETL02UyzY
 11qGuwP0MOLxikkTScJxULxOFpS0aykthUoGtfO5bkUg0w3Qj/Qdyclp85L0/a8HjczT
 EaOpjXlpcrrHk9Jr9PajS+mP4lv5wqMuGB2NiOlW26vocWwuUyOYsKmXbr/HA4ahk8vo
 kAlQ==
X-Gm-Message-State: APuU4Z+bWMvnY3yhxW06uJqs5Lfbix8OeFf38U+IrIrqDwey+wv5PG/7
 J6uHrn5+91+LW4nGJV2fFNAQLG242wfsNvLkaSCBceN8iBZOjybVpbfKFeAkm62eatuC0xPMjOJ
 F3k4A
X-Gm-Gg: AYBFou3wI/rE27nxQQ0C98aIDo2R4lEn80ezuBI39x9L+1wuCGAN0Gy5qx/Nf47yI7o
 MbrXCvpHcIZFWF3vjzh5dy5yKPBnNUtI5JNBzQjLJ6neFHZzJl2tPIkOY/AeP+FGsXH0EdBkPO8
 CaunwDqxYMHuSIJclqyMyFRCEaevzWH8HZFC+XQnYY15/lZZeY5xgTkmpYTfEPKGic9W5xeYdiG
 9EE9n9PJ7EIJFM6UKqozvVB4hFWqdYbDkJmXUeWzdkEU5jHbnJe5FPwcwDul7ipRb0xOmds2vYV
 dA7Ht6QXq3OnTRiUabKAGOpDjO+3ZiHn2xgDk895e5vz0099rDljDJN/tNpIoqoSID8DYtc+Zjl
 S4hB9btjN6GJBo1PRb2OzQynPUOKobgEulyi6zlB7UtxDus2J+qnkXAntOrEftrnNmHDYBodNSX
 s3zbOf9ZElUSJk4kwW8si/bByICWp4V/DypuOGFjzrB33GkN3t0XeHj7KkdiEBtz+y4riQ90eoh
 R8hekVkNLZ9RXtV2k76QASNhY6k0ve4ZGm8k97d4oL7CbQEO4l3CBIuF79iMwf0lsIx2gTFoP+K
 E8HH8Ts5v+oHPsiKs+ISRCmoA6G7tGLuD1Rx94T3ijtOGcAHZaRWeFI/PdyJi6IKo0lGWA==
X-Received: by 2002:a17:902:ea0c:b0:2e9:5c29:995e with SMTP id
 d9443c01a7336-2ed83ff168bmr44053095ad.41.1794242489784; 
 Mon, 09 Nov 2026 08:41:29 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a412acsm246405ad.4.2026.11.09.08.41.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 08:41:29 -0800 (PST)
Message-ID: <37a58cfc-93a6-41a4-a512-67c7f8bd9054@linaro.org>
Date: Mon, 9 Nov 2026 08:41:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] replay: Explicitly require round-robin TCG
To: qemu-devel@nongnu.org
References: <20261105131549.42175-1-philmd@oss.qualcomm.com>
 <20261105131549.42175-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105131549.42175-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 05:15, Philippe Mathieu-Daudé wrote:
> Record/replay needs a single deterministic instruction stream,
> which only round-robin TCG provides. This was enforced only
> implicitly, through icount being incompatible with MTTCG.
> 
> Reject thread=multi in tcg_set_thread() and tcg_init_machine()
> when record/replay is active, with a message mentioning record/replay,
> never auto-select MTTCG then, and add a final check in replay_start().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/tcg/tcg-all.c | 13 +++++++++++--
>   replay/replay.c     |  6 ++++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index bbc733a7070b..6ffe04649072 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -125,7 +125,8 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
>            * there is one remaining limitation to check:
>            *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>            */
> -        if (mttcg_supported && !icount_enabled()) {
> +        if (mttcg_supported && !icount_enabled()
> +                            && replay_mode == REPLAY_MODE_NONE) {
>               s->mttcg_enabled = ON_OFF_AUTO_ON;
>               max_threads = ms->smp.max_cpus;
>           } else {
> @@ -133,6 +134,11 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
>           }
>           break;
>       case ON_OFF_AUTO_ON:
> +        if (replay_mode != REPLAY_MODE_NONE) {
> +            error_report("MTTCG is not supported with record/replay, "
> +                         "use round-robin TCG (thread=single)");
> +            return -1;
> +        }
>           if (!mttcg_supported) {
>               warn_report("Guest not yet converted to MTTCG - "
>                           "you may get unexpected results");
> @@ -195,7 +201,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>       TCGState *s = TCG_STATE(obj);
>   
>       if (strcmp(value, "multi") == 0) {
> -        if (icount_enabled()) {
> +        if (replay_mode != REPLAY_MODE_NONE) {
> +            error_setg(errp, "No MTTCG with record/replay, "
> +                             "use round-robin TCG (thread=single)");
> +        } else if (icount_enabled()) {
>               error_setg(errp, "No MTTCG when icount is enabled");
>           } else {
>               s->mttcg_enabled = ON_OFF_AUTO_ON;

This part looks good.

> diff --git a/replay/replay.c b/replay/replay.c
> index 14437b32566b..d7d5ddc5a326 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -14,6 +14,7 @@
>   #include "exec/icount.h"
>   #include "system/replay.h"
>   #include "system/runstate.h"
> +#include "system/tcg.h"
>   #include "replay-internal.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/option.h"
> @@ -447,6 +448,11 @@ void replay_start(void)
>           error_report("Please enable icount to use record/replay");
>           exit(1);
>       }
> +    if (tcg_enabled() && qemu_tcg_mttcg_enabled()) {
> +        error_report("Record/replay requires round-robin TCG, "
> +                     "not MTTCG");
> +        exit(1);
> +    }
>   
>       /* Timer for snapshotting will be set up here. */
>   

This part looks redundant.
Surely all of replay_start is covered by the accel/tcg bits above.
I would expect this to be as simple as

{
     if (replay_mode == REPLAY_MODE_NONE) {
         return;
     }

     assert(tcg_enabled());

     if (replay_blockers) {
         error_reportf_err(replay_blockers->data, "Record/replay: ");
         exit(1);
     }

     /* Timer for snapshotting will be set up here. */

     replay_enable_events();
}


r~

