Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169EDC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxxS-0004UP-It; Tue, 11 Aug 2026 21:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wtxxR-0004Tn-BN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 21:40:41 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wtxxP-0002De-GB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 21:40:41 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81e8fa1b8d6so5185637b3.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786498837; cv=none;
 d=google.com; s=arc-20260327;
 b=kU0hZvg02We43KviafYC7y9H/WSH1HQJb+BmMnamLBe5KqvhGytu+WIAmoiDNPWcbc
 rZfgfuGp+vB0bdm5H3OFdqUv+mPM4c2cZZxStHBTKTaaOThiouYH4IGDQ2aZz++7C0fV
 F9LGfw4P/TRXFWw3i+zbg1YjPv+1pEMB61exdABqOABgtaIrak1JlmJM9evTDJZXmqcv
 yw0aYXNgEz6o/Oh0Zx4l1fSKcC209JpkSbqsOluo06Hz6nMF/XZPxcU3/5aYOKOPMRE4
 5XcO6Zd0SVAXZKxiFSsylyUd4xp8SwpJLThWA2K0P7EcfgGTlWGsSxsSJZ/jg35JbaO3
 Te7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7CK5EL2q7FRD0qSNGTtW140g77P1y7vgP3Vek3jHAU8=;
 fh=KE3wEp9BzDHz6wDa2zPlp0X2UcazmsfwKriOK7opl3U=;
 b=fyuSnYEpQwq7PygxfnUeVumaeBzHwgWN0kofFr6H2ROH/0XEYx406AAjC8qhLTnvDw
 XBpdAG7bikrIinF4GVvXZCjW6fELgDWXKMCh4LbQPflqefxrCtr6Y6gHyoFAZ+FqBDbP
 1nTgE8S2pREnBhCI4B01zLgtnblRW2WL9L/XInKRpxWiZzCA4lOqoM4JhoQAXZhs9shF
 2Xrh16xuNSQACAnHXoVFbBD5I1ym25lu7Shv3YKnCzUrItRcHISHPd6NTqUf0rrbpFmi
 byrRVnN1QVDtDpwo2+o1AtXfmffuQeU0hGcrDDq0BFLIdtmwknV9rJLJTQ20OFn1E7rV
 bSMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786498837; x=1787103637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7CK5EL2q7FRD0qSNGTtW140g77P1y7vgP3Vek3jHAU8=;
 b=lMJSPlJxElC0MXvbcmD6UPsGs7vG4SyvlBRXmU7jTGAfR5Py+S78RIjmHlCkuk2aZ4
 RzaHOkpr7CemhEhAbC+sRL2PJ64RTj9Y1GCDuuhBNQzH4QPuE+X5TZ7iXeBTcEt6obhD
 D+qDZhjJMVEp1HEE8KIx2aF373iCOCiXzGXnbF7+FoVFrRpk+qcNzSpRCnTbw57f2RY4
 cSIR9iUOkLxSrQa/5L9TevhXfSEZe6w92hm8HQcPANWm3jdLmbwMu488PLOMcuJAXxNT
 6kGM/1WqexWbb+yEVzmXtkCenrJE9Lz6REqLOHv6xX+v0iJMyiYtnNC2yebXOgvjoRHx
 RSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786498837; x=1787103637;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7CK5EL2q7FRD0qSNGTtW140g77P1y7vgP3Vek3jHAU8=;
 b=hSb5llZF0AwDP/aRLiGvvmIPycu6sfsFYcfNe99rDvI1lyyYeaJWvoo5VbAJm9OafA
 RlYJBwAGdXRV6GKXXaGsBNGi612oBXVerrfeuBZPlrYXLac2u6PNMPAEBglidLTFHeio
 pKkrqMAn0iSWHp2KwAU9e/9ZFeWX/fDq2hRF5EzXFYxsIl8GAGBvQw2bx/A+lrbjteX2
 Fojlk2GhdESY6D7NPQDh5SLDkSz0bO+b1TMOJ6vM6lBjGfVlVFUZyOvsyMnLHYQd/3ZF
 JAA8mUFHV0CW9ggH2fqkKpKIy1sgzdqdiM7NzjdDKACFCkPQ6RwxgEraKAjIwsrEqtSM
 tA6Q==
X-Gm-Message-State: AOJu0Yz8Vi7S7E7xsDcvDOQ0IlnbJDbrfX1EZSxhs+srx/tvMk9GEQcM
 1qeD9BmtiFTB8e7dbOG85WTOn7075zCbRdTeJLfHZvsA9x36ZWHmwXYAG02n7hIeHTx0J5wYQ3w
 t5eWXJiCl4u6FrXVkz5oNHy6RAcoPOWo=
X-Gm-Gg: AR+sD13ckUyz/tZPR+lbDcfR5zea57uJxUUdeXguD/gqYaItSnnRhDCAUu7e4zJkBzY
 UzCpWMOTebeum4UGinEjVfUacesBP010Z0REO07xDR/B0mFN+0y/Gw59DdHVTT1NxC/zrf15BuJ
 T0WnSddVHABVmdscLH+MASolQ2vKAQQDbUyR/niZJKLrREJKMIMwL7Tbklhfm9Hg8e/M5QeLWFe
 Vy2KGOCa/SJXjkrOt5ZvgHV/tjsONKSFQggoiTgWgsqy2TJj5Q9CZNOGD+PFCGzOldwhLy6rlD1
 x0wE5hLZdftpbUuAjKxWuNwpp1pdP47Tvl9od3saE5Bs
X-Received: by 2002:a05:690c:6e12:b0:823:2ad3:d39a with SMTP id
 00721157ae682-8310be1c8d4mr10083877b3.32.1786498837269; Tue, 11 Aug 2026
 18:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260804081459.8007-1-wafgo01@gmail.com>
 <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
 <20260805080540.323431-1-wafgo01@gmail.com>
 <CAEUhbmVE4j_+havPFTLgHs26FiqWPyRmeU1bjrVpPD0ZQ-Rtaw@mail.gmail.com>
 <20260810124519.34501-1-wafgo01@gmail.com>
In-Reply-To: <20260810124519.34501-1-wafgo01@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 12 Aug 2026 09:40:24 +0800
X-Gm-Features: AUfX_myFKCh2GQn8TS4MgPF-WcNveEZT4DW8tEiVXIJwupB5wIBURECKJbRSjzU
Message-ID: <CAEUhbmX=azsPMmxipdeChe8imyFBwKvS4KRy5Qu-phaUBodOeg@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
To: Wadim Mueller <wafgo01@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Wadim,

On Mon, Aug 10, 2026 at 8:45=E2=80=AFPM Wadim Mueller <wafgo01@gmail.com> w=
rote:
>
> Hi Bin,
>
> Thanks for the 513930 pointer -- that was exactly the missing piece, and
> it changes my earlier result, so let me correct the record first.
>
> With "hw/sd: sdhci: Fix SDMA boundary bug" (513930) applied first, series
> 515264 builds on my tree (I applied 513930 patch 1 + 515264 patches
> 07-12; I dropped 13/26 "keep high-capacity memory blocks at 512" -- it
> didn't apply on my older hw/sd/sd.c and is orthogonal to the ADMA path).
> Re-running the same AM64x reproducer, 15 hands-off boots each:
>
>   baseline (before either change):              7/15 time out
>   your series (513930 + 515264 07-12):          0/15
>   my patch (complete non-INT chains in a pass): 0/15
>
> So your series *does* fix the AM64x case -- my earlier "10/15" number was
> from my crude hand-approximation of patch 12 alone on the old base, which
> (as I feared) simply wasn't representative. Apologies for the noise; the
> real series resolves it here, same as my patch.

That's good to hear. Thanks for the update!

>
> As promised, the reproducer -- I kept it free of any proprietary bits:
>
>  - The machine is public in my QEMU fork:
>      https://github.com/wafgo/qemu  branch cmblu/corenode
>    (an "am64-virt" TI AM64x board). Build qemu-system-aarch64 from it;
>    to observe the original failure, revert my fix commit cad8b499
>    ("fix(sdhci): complete non-int adma chains in one pass").
>
>  - A small image-free qtest on that branch,
>    tests/qtest/am64-adma-pacing-test.c, drives an ADMA2 read on am64-virt
>    and counts how many SDHC_TRANSFER_DELAY virtual-clock steps the chain
>    takes to complete: 0 with either fix in place, >0 (the sliced,
>    timer-paced transfer) without. It reproduces the *mechanism*
>    deterministically, no guest image needed.
>
> Since your series fixes this, my standalone patch is effectively
> superseded -- please feel free to drop it in favour of 515264, I don't
> think a separate fix is needed.
>
> The one thing possibly worth keeping is the pacing regression test. As
> written it targets my fork's am64-virt, so it isn't directly
> mainline-able; if a test that catches this ADMA virtual-clock pacing
> would be useful upstream, I'd be glad to port it to an in-tree SDHCI
> machine -- e.g. the Icicle Kit where you hit the same "Timeout for
> status update", or the xilinx-zynq SDHCI you just added a test for in
> 513930. Would that be worthwhile, and which board would you prefer?
>

Agree that a dedicated qtest for catching ADMA virtual-clock pacing is
useful. You can use the Icicle Kit as the test machine.

Regards,
Bin

