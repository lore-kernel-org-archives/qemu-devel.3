Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C372E88D6E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 23:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8oH3-0005pd-Bp; Fri, 03 Apr 2026 19:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8oH1-0005pU-AQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:49:59 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8oGz-0003kl-It
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 19:49:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c76c067bc51so863754a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775260196; x=1775864996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PT+6VtdXWb9kwXc+ggioafkKNFuE6ponkjTO2LDO2DY=;
 b=UJio3gSGZJz0ngTNzejIG06R03j3bUdQNN9ZQ03WLvRuyUCF8kqnOQYNJnlqIwOA9J
 Ws1+CNh1AkxWaZMhpEOoZt7bA3t0mjPzjh/Nqa56djIj0RG7+aArqHMNFOPpgZ24Gfur
 FMJZItcCISeXXjUqWlvwN4gV6ECGLA9e7CY/Jdqz432aJ6HHAC43JRKLBUYxBtLqV1Vf
 byVlhH47K3el1EaiFhGUoWt8cIqgsYeuXf7QyRMWAGBDVqgkHgFYl8Hj4qczsyIxfq8G
 JHWWj8KMULhdL7C9tmjHzqM9OLTvc8Xepxjm+OUa1DphW3KrVwRElbzX134bBu60K5B5
 oyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775260196; x=1775864996;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PT+6VtdXWb9kwXc+ggioafkKNFuE6ponkjTO2LDO2DY=;
 b=e4gpIYSeMlP2hwoOO+f8cIfK4YAwgb2693i7zduBy5E9iSsENHfBLYgs/ncH/5d/wA
 uVn6U4w5hp2q3193vDIl38wU3quD/VvjU2zPVA5RAh6JXWDhP/pn2NG4Z+qYeQItvdZ5
 QmffGEVNtelFb7lBtAJlvpPeTuPvBUne8gFMQF7iHlXZPlFzDJhYOeSXy62qJT9IMuh2
 HK9I5QnSzqHPXJYnkEW48skTWVsjmorQpFM7cAN9w8LuaiP4v6wBSz3B7fQ3+L1KnNgc
 uygS9age2cXKNANFVxNBnGu5MRzF/Py035NBfgxlPjDuwlUJb/5zMV/xbxmfTI8zGQno
 WcCQ==
X-Gm-Message-State: AOJu0YxtikJF9+c2MPxW0pT0hJl9BetPC0sgIBOhlzwW8C5GhX0YQ8FE
 7j8OJjwO9dcju+GoNWSxqoaZwzyySnuQ0b3iShM8rJVbTP2bb7H268GsH3IOun7bUg/Nqx1zSeX
 8M6oN3oY=
X-Gm-Gg: AeBDiesrGxwGYoR90wuylaboD97u98Dym0CtJu4iQ2Ij6slxZumEsVrz6zKIlh+yQTO
 B2Wrka0G4CvCMW6PKlP4vocNyBal/0ky/O57aR+Ii2atH7wOhxsUhyGgHnKisbckuYc9kZ4/FbI
 d3r/hXkDH8psktxCoPnwZHmfDahvc+JeLNXsdZo2FVegswsdwfEIcVxudmVIQDeYZUTLErQhuuW
 LEQa+vFUsKYXCODYCEG/S0pP+2Nrao02RQLHEagnmuvYC1RpKE4+h5/oEgkULa7B0FiztiYiYn6
 t/CF8iQvM0F/YZ1H8+3MFyNNJl1eKvGQIxmaiIaaO2cB651zSw1/hgKAMCKyrsxOgoIY1Q3iiPC
 /uQigZQss4ciR8FUdNMjO+2nE2jASWdrtyTlpCzDx6d97UmW6hhn9Ae0jhWUIDIvE6hVWwdt05E
 6xDHUFBAxi+sAS4ryrSbmrUUTAeUECyEfjv+GTAZ+iviUrQLXn3Nm9mi7JCeRoJb9X4xk=
X-Received: by 2002:a17:902:c943:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b2816e6c38mr47268905ad.22.1775260195641; 
 Fri, 03 Apr 2026 16:49:55 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd07sm62099565ad.72.2026.04.03.16.49.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 16:49:55 -0700 (PDT)
Message-ID: <eb9b80b4-78a9-4a0e-be63-aecfa8b426c5@linaro.org>
Date: Sat, 4 Apr 2026 09:49:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 6/6] RFC: Allow building qemu tools on 32-bit
 hosts
To: qemu-devel@nongnu.org
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-7-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260403104327.1163942-7-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 4/3/26 20:43, Michael Tokarev wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Qemu's tools like qemu-img are often needed on 32-bit platforms,
> although the actual qemu emulators have been discontinued on 32-bit.
> 
> To allow building the tools on 32-bit this patch implements two small
> changes:
> 
> a) The check in meson.build is changed to still error out if the user
> tries to build qemu-system or qemu-user on a 32-bit platform, but allows
> building tools (e.g. by "--enable-tools") alone.
> 
> b) Remove the compile time checks in atomic.h because:
> - for the qemu-system and qemu-user emulators this check is redundant
>    since we only allow 64-bit platforms anyway (see a)

Nack.

The assert is still useful on 64-bit hosts, because most but not all of our 64-bit hosts 
also have 128-bit atomics.  We *shouldn't* be attempting atomics on Int128 (or structures) 
but you never know what'll slip in.


> - it breaks those 32-bit platforms, which do provide (slower) 64-bit atomics
> - 32-bit platforms without 64-bit atomics will fail instead with linker errors
> - the runtime speed of the qemu tools aren't actually that important.
> 
> I've sucessfully tested building qemu tools on 32-bit hppa.

Well, i686, armv7, and m68k have 64-bit atomics in hardware.
I see from gcc that hppa-linux has 64-bit atomics via syscall.

I think testing got lucky.  Other hosts, e.g. riscv32, I would expect to fail to link, per 
the second point above.

Since the goal is tools, which do not have to interact atomically with guest emulation, we 
can fall back to libatomic.  But that requires that we make the meson.build changes to 
actually link with libatomic.


> -/*
> - * Sanity check that the size of an atomic operation isn't "overly large".
> - * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
> - * want to use them because we ought not need them, and this lets us do a
> - * bit of sanity checking that other 32-bit hosts might build.
> - */
> -#define ATOMIC_REG_SIZE  sizeof(void *)

I think we should retain ATOMIC_REG_SIZE but use uint64_t not void*, and update the 
comment, noting atomic128.h as well.


r~

