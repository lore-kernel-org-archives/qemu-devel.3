Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9D6C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 05:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXaTi-0000kz-LP; Wed, 07 Feb 2024 00:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXaTg-0000kV-7y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:28:08 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXaTe-0005x4-MP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 00:28:08 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5600c43caddso206325a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 21:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707283685; x=1707888485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UFdNumxh09HXVXsWxvCyd5EjBDi2kHPQddlAMmekB20=;
 b=yB+HBcMTZ7zzwXdssGy0t24HlAICIpzjgpsWNnIjpd1I/pal4N5+2MfXCksHgZqU08
 dn4ZlF454qtgoJkMhrKPYVD2ldEI4v5sfJVtDRV/XFy8vIdbNal7zHk5h+UZuMWgISvk
 oJ1EDvjRKRFqwb2KEFYrQ2DRZip9+vPDIUMcwaN9ICGTGjVakgspk59gg7kU5rxPPYIs
 ujUBecRA9lnx/KsCgxJIoW6T3hkaePJhg/1cz8yy4TvN8GG3cnaEN3oibvaVsyGQVUYX
 ERURPunQiSpJ190L58qNiIF8PNNx2BkyczK6g8a/8LmKoh6fa+wWjKX2zvOFOR3o1dnd
 indw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707283685; x=1707888485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFdNumxh09HXVXsWxvCyd5EjBDi2kHPQddlAMmekB20=;
 b=ws4e1f/4+gueTpG0lFWETNe/jVjZ+I7qC6qNu9f1wsGV5gFNJ4s0mgJT6dBLSHSEZo
 YdVH7ji1D4EUBWwOX3Ml7BF9bghXia7O1tuGbu3F1M/0WrPL5q3+YHo2cySYq7wX6Hai
 nasRMCLm22/M2wa+n/5+RQK+rPmVcyYzlib5R3L9XJsMXsfGtkq2EVjYrYRlppXIyKNK
 1I0Rd/x2HqYeiir0iLVC3lQfykYlNp5eKO+zI5lVDD9gsCg3pA4yYV6lHBaYOZ7mq1V8
 5+3bi0ZN9P3Q9HKgddZhrecC9hg+OSCOHlr7GoVwVCWM/+YjLtJaLH4FDrgjzgjaY4bD
 xEBg==
X-Gm-Message-State: AOJu0YxvNXbS/Aw6EXUJc0gs0/Ldg3SilbYz69nLE6Ul9OoatlmKcRFm
 q4T4qFZm9Fy3Z2orXe3rhqSOPO7HgRRJU+mkgURn4djKz9QdouHKeyUGshMavkA=
X-Google-Smtp-Source: AGHT+IHKH3KU7a7j7vL6RSGS+X7Uvq1tdMFrxZjKjixD5B4K4rTv+2vJ7CQliUmEnUDFTMS5o9OD1Q==
X-Received: by 2002:aa7:d846:0:b0:55f:e147:2524 with SMTP id
 f6-20020aa7d846000000b0055fe1472524mr3145374eds.38.1707283684913; 
 Tue, 06 Feb 2024 21:28:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXvHT2XDcZvMiApi+BDs/QizXkLAgPn/sAM+5w9RO2npcv0DOg3VO4vBsCmoxr8gOZKxR5vsv/vMK960ZJ8X4FLfCJPVeOeInerUbbsqqFmq4oabQnpOT4XeuubYboz7H9qe+wLn0VHWtCWtLg+jgfyoX53+BDDeA5ido+RgDGZ0L+pAaVjpwNjRPcMvx5Hu7CAZLFnX2Uu942oO8woWhkEnvEjee0b8tPxSmfVPKvr+drbs+QTG4huDaRMnqWwJKvXkM11649qRe+X0cINoQG810LdElWLC9PK1a+6z/qvr6C9EbJXdrisDzE=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 et6-20020a056402378600b0055d37af4d20sm268309edb.74.2024.02.06.21.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 21:28:04 -0800 (PST)
Message-ID: <683557e9-fa84-4384-961f-7c29daafe860@linaro.org>
Date: Wed, 7 Feb 2024 06:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com> <87r0hqyw8k.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87r0hqyw8k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/2/24 06:53, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Mon, Feb 05, 2024 at 12:18:19PM -0500, Stefan Hajnoczi wrote:
>>> C99 mixed declarations support interleaving of local variable
>>> declarations and code.
>>>
>>> The coding style "generally" forbids C99 mixed declarations with some
>>> exceptions to the rule. This rule is not checked by checkpatch.pl and
>>> naturally there are violations in the source tree.
>>>
>>> While contemplating adding another exception, I came to the conclusion
>>> that the best location for declarations depends on context. Let the
>>> programmer declare variables where it is best for legibility. Don't try
>>> to define all possible scenarios/exceptions.
...

>> Even if the compiler does reliably warn, I think the code pattern
>> remains misleading to contributors, as the flow control flaw is
>> very non-obvious.
> 
> Yup.  Strong dislike.
> 
>> Rather than accept the status quo and remove the coding guideline,
>> I think we should strengthen the guidelines, such that it is
>> explicitly forbidden in any method that uses 'goto'. Personally
>> I'd go all the way to -Werror=declaration-after-statement, as
> 
> I support this.
> 
>> while C99 mixed decl is appealing,
> 
> Not to me.
> 
> I much prefer declarations and statements to be visually distinct.
> Putting declarations first and separating from statements them with a
> blank line accomplishes that.  Less necessary in languages where
> declarations are syntactically obvious.

But we already implicitly suggest C99, see commit ae7c80a7bd
("error: New macro ERRP_GUARD()"):

  * To use ERRP_GUARD(), add it right at the beginning of the function.
  * @errp can then be used without worrying about the argument being
  * NULL or &error_fatal.

  #define ERRP_GUARD()                                           \
     g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};   \
     do {                                                        \
         if (!errp || errp == &error_fatal) {                    \
             errp = &_auto_errp_prop.local_err;                  \
         }                                                       \
     } while (0)

Or commit 5626f8c6d4 ("rcu: Add automatically released rcu_read_lock
variants") with WITH_RCU_READ*:

util/aio-posix.c:540:5: error: mixing declarations and code is 
incompatible with standards before C99 
[-Werror,-Wdeclaration-after-statement]
     RCU_READ_LOCK_GUARD();
     ^
include/qemu/rcu.h:189:28: note: expanded from macro 'RCU_READ_LOCK_GUARD'
     g_autoptr(RCUReadAuto) _rcu_read_auto __attribute__((unused)) = 
rcu_read_auto_lock()
                            ^


