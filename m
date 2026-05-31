Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3F6CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 17:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTkDD-00047J-S8; Sun, 31 May 2026 13:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTkD0-000468-K7
 for qemu-devel@nongnu.org; Sun, 31 May 2026 13:44:25 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTkCx-0000AO-HF
 for qemu-devel@nongnu.org; Sun, 31 May 2026 13:44:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84226d0f1d2so868387b3a.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780249458; x=1780854258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5D94qobGug3NM2PgDXHHcriGWQCf/PuWMdN2mfMzuo=;
 b=U6SpAd4HbjBaaYTA/cgHlZuC02fm8AAcXVpeskiIDuTgGXGTKYmvdGqB4YpTuLzsVB
 TK1s2EceEseg3xnVJ2ZN/ArKRYBUV1vaMO/aSVVdppXFMux5Ppx43LeIVru2RHmrX9sP
 okKPVYyv62ZvQdLjaU8j0FcIgx0XBHnuYw5zfxsto+YN0CsyUiv9EYZLvrEZQS9IBuM2
 RHhyLSkBjPHWFIm6tGxVUa3b+hi2etL6/Qdssz/trP0wYvsjFIMulV8NC2V28z2FH8rU
 E/hX7T2TrCYBKEUUJFmDS9xRN23oMNy6TCjfAXlKO3JJkZDDqpAYx0LqmHGaXmoXnbdK
 XQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780249458; x=1780854258;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5D94qobGug3NM2PgDXHHcriGWQCf/PuWMdN2mfMzuo=;
 b=QHKbJLFRiusY6/8ZGHIxajVZrE2lqSA1aZmNGdvTS6FoYkUtYmN7H7F2mo5y5IW2s1
 3hnQj4VzImrWumfNCqSPo9a6b4RB/xiJ4HB6ex15mvAeDCbwYpHav3it6HJSEJ9AACgO
 +ded6n5MvZD04uR9c/i0UiXeH+P2EJNdFcYTrAhJPY5WIr0WSNP3rXFn6gklRU4p8kOs
 Y9cpDCpDovt2vTK9e6SX9pXwAvZen9HIbn+ypr3ZEVu9EB/BAi7sPanWsr87h+EBeS2T
 eV0k3E04TgOQfRf821u6uUP2O2jUtCI+SUAc1DoN5iKQ3qf4N6yIhXD6298vL9DYNO+K
 pujQ==
X-Gm-Message-State: AOJu0YwO7GI4OaCD3imfDK4/B6XhqOtwrwOb73ailxjHQ14gWJzUbw1/
 gz/rUwYnzgJlupCF5mjtQCtDdaoU/+kGO842UDy+ezqOYEa6/qlFrkSwRPippGGa9H8=
X-Gm-Gg: Acq92OHT5I12FW34z3HdJz2Z3sfwU37J84RGPIHR6wvAY/xxs1B3Y5NaKLYmTPrNkRO
 O/sIwTHcWykWsBtktBoLf+bmu0AX4mkAv7e1Fm3ljx9na444yl3FL8h8QA54RGeqhynC7RpX6mh
 W+ZcIYIOfkWZiENRZ2baemfJ3ctZ1OdxWQIZEEphFMFNe8rrwi9M2OUD4xf18i10tnxwvxcyQyH
 pGDOiJXSepbdj1vVm7DCDQPiB0EHbQj4ZAL8oa+VstQ04Q8HTeTV0iUYxBbcki99PFl3OwCMYlS
 TmaTMFcycnZ27gZJyf8VNWI4OkDgq9DJYedbCOmfSTSyl7b10qf08qlQK1SGxKWHvrAkwdwXUzw
 jY+45SzpZcsKpMtGNnWZxfi/bw/Rdq+WR4f+ECl47Hv+ZBSiitT3oflrYnO4087WnaDC7Lhppff
 Pkp9ag2Uafy3Sv1uLCaf90KPsXwiVuqScWG1yR2GaFUqaKM9VrxdiAoixG9Q==
X-Received: by 2002:a05:6a00:1954:b0:835:45bf:9660 with SMTP id
 d2e1a72fcca58-842258ed8cfmr7146105b3a.42.1780249457635; 
 Sun, 31 May 2026 10:44:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe1dsm7784485b3a.1.2026.05.31.10.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 10:44:17 -0700 (PDT)
Message-ID: <49b8837e-52e0-4805-9b27-b3fcd2918061@linaro.org>
Date: Sun, 31 May 2026 10:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] common-user: Implement read_self_maps for FreeBSD
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, deller@gmx.de
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-11-richard.henderson@linaro.org>
 <CANCZdfqE=MWrQZeYtSLPs=B3FUW4xRL_ebLyXj4txQ92PzZDUw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CANCZdfqE=MWrQZeYtSLPs=B3FUW4xRL_ebLyXj4txQ92PzZDUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 5/30/26 21:36, Warner Losh wrote:
>     +    for (int i = 0; i < n; ++i) {
>     +        struct kinfo_vmentry *k = &entries[i];
>     +        size_t path_len = strnlen(k->kve_path, sizeof(k->kve_path)) + 1;
> 
> 
> This is shorter than what I had in blitz.

Shorter, but wrong, since it's never 0.

> 
>     +        MapInfo *e = g_malloc0(sizeof(*e) + path_len);
> 
> 
> My version did the following only if
>        if (kve->kve_type != KVME_TYPE_GUARD &&
>              kve->kve_type != KVME_TYPE_DEAD) {
> 
> though now I see my version would have been better with the
> contrapositive and continue.

You wouldn't want to skip GUARD, since for the purpose of probe_guest_base GUARD is 
reserved memory.  What does DEAD mean?  Is that the multithreaded thing?

>     +    free(entries);
> 
> 
> I had g_free() here, but I am a 'cargo cult' glib user...

I know they're the same these days, but I minded the man page which says 'free'.

>     +
>     +if host_os == 'freebsd'
>     +  libutil = cc.find_library('util', required: true)
>     +  user_ss.add(libutil)
>     +endif
> 
> 
> This dependency is likely fine, but as I said in my other mail using the sysctl obviates 
> the need for this.

I'm fine either way.  Perhaps this isn't worth pulling in the external dependency.

> And thank you so much for writing this, even though there's a small collision here. I do 
> very much appreciate it.

You're welcome.


r~

