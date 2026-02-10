Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816F3EA3F3E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplXb-0006YK-IF; Tue, 10 Feb 2026 06:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vplXZ-0006Xm-O3
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:04:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vplXX-0003Cg-Tg
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:04:21 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43770c94dfaso747920f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770721457; x=1771326257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GaKZR6uF6fNkUQmkQLKD9V7rr0Bslq16OS5fFN8NbSI=;
 b=RiNE5Z/bFe/G7LuI3MUgoWvWxUpQKoRNANGvlNsZVhjP9PvL4bzCLu8XBUvBAeh1Fr
 E52OtHyCZeRBMheYgrzn6n8ouXy8H1piAyN1QFnSEAbDK+YYd7NI2+66p0SnvxGhQvcl
 Ts0mYrpbUEW+a0OQPcUbcSjXYQqyhDOBgx4cpTVW432QyXMy1lL/P/2Mi6z0BsuTEgiv
 NgbwBHBESh5ENv58LRj/+lX/XBgpHr+j3OkbvoxqU6ys0YQcXChr4vxWKbnq+sS7vZU6
 A9zyg+RM9UzfQ7ekv+xjAPjOGiNOqm3e299leZ2UpzRJVcGWOHq9OZhJ9az1IEVQd4Hg
 7MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770721457; x=1771326257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GaKZR6uF6fNkUQmkQLKD9V7rr0Bslq16OS5fFN8NbSI=;
 b=B+Xg9Y+x1JO9pa+r4ieEZoMtkt0EjOJbG+RjysMRVdAQV/FfvK8cFz1D7Kk7XuawaE
 vPVg90weiXAh0E9Y47G7tkFcF7X0PVtYpDEEajguikuV3f5fw8KuvNAbJjf04K7xdNtU
 Scd55VYYXzXDAz18n4LAhq0i4LiypcNwcpN82IpPI8wPiNqqbSX1t+p9LbVCNdJzSZiL
 31WD9f+LXbktzRIZPwB2ag2Ilg5bvZwFQHXqIfGbcVVienQfPxroJlLYV+RSxzBxnRJs
 tLRXRHBnGBHXnbc+ubKSzL4TmB/R2vufaRf5ccFaaZQVt7E8x0dlokBKHb902nzeLm3O
 gBoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyw0WpYN9Hs2JBKTJ4ejWvolTeSSyM85xf9vRTPf4bE0udNbF/n1ieTalxaPXvaVKuUHX/OBAYWtgf@nongnu.org
X-Gm-Message-State: AOJu0Yyn/Qlee4zo9VzYEyr/qELev8KgBm7SXyE4qE9AoQcmMDDbtOqT
 XTOam57xo7SBH5zZzOLsrZ1KjoIhVHvD8zsBppZYU69kxAi2E0xMjK5z30x/8dYn2vbFNhkjwQE
 cwxBw
X-Gm-Gg: AZuq6aJN/FYZrVKWE7G1kHmFiwl0/4Q+QQTkIB8hA27t9IEAiRy+EMA9r8qQwcd0Gpp
 YxrNWwOsMHP69BBNrQZvQEo+Kynkq9Bk5Ql5N8ysJpwQt4ms7Te+jRjlAMTps94bQA32ZIJfQ9h
 4zhSWl1PZrI/42jTdMfJ0OO2jypWY8n8f1Z4nWJSvzpdfnz+fNFfp4o5Q35z8onOOSBdPUwgCHb
 PywVii09KZYY0ud75RwQCHsZw4uo1UmLhRDl9VoD42zu3p4a1rfmtltqgC/6b2Zpk2D3LeWTrot
 nHIlYrqmAfJUAzFmZ8uUaMoXlv24D4QULXtCImzMeylrnVA3elteFPBj0KQxoVhAyUNUh5Mz5RR
 774reeCMYtz8LY3LYgNPGSMj4aTgHTyO2IIKBF6/NtBusp6RAHGpxi1jdIkJEcX2ztCai6O194V
 ObvNCwtRHUBxjvJpShLBnfE6C9E44rqC+yWCfGhKFDvZ2G7thz7kYWFr3J/UBMzl5yGCeA
X-Received: by 2002:a05:6000:420f:b0:437:4872:fc83 with SMTP id
 ffacd0b85a97d-4374873007fmr14384247f8f.33.1770721456992; 
 Tue, 10 Feb 2026 03:04:16 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:958a:f639:6b0e:89ba?
 ([2a10:d582:31e:0:958a:f639:6b0e:89ba])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bcdfcsm35682258f8f.10.2026.02.10.03.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 03:04:16 -0800 (PST)
Message-ID: <0e63016c-2ca3-4074-8a5e-db46f22d8eda@linaro.org>
Date: Tue, 10 Feb 2026 11:04:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "rcu: Unify force quiescent state"
To: Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260209120336.41454-1-thuth@redhat.com>
Content-Language: en-US
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <20260209120336.41454-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/9/26 12:03, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.
>
> The commit introduced a regression in the replay functional test
> on alpha (tests/functional/alpha/test_replay.py), that causes CI
> failures regularly. Thus revert this change until someone has
> figured out what is going wrong here.
>
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3197
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   I just hit this again in the CI:
>   https://gitlab.com/thuth/qemu/-/jobs/13018713844
>   ... it's annoying, so I'd like to suggest to revert the offending
>   patch 'til someone fixed this.
>
>   

Hi Thomas,

I am actively investigating this problem, but haven't made any important 
progress so far. It's looking like a timing bug which is annoying to 
track down. All I know for certain at the moment is that faking some of 
the values returned by qemu_clock_get_ns to be deterministic improves 
the failure rate, but does not remove it entirely. I'm fine with this 
being reverted for now; we can add it back in once we figure out what 
the true cause is.

Jim


