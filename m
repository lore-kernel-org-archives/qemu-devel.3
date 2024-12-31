Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5184E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 12:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSbX2-0004Q3-Cn; Tue, 31 Dec 2024 07:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tSbX0-0004Pr-WC
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 07:39:31 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tSbWz-00017l-HK
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 07:39:30 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so17075498a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 04:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735648767; x=1736253567; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LPBTgfWc2yc0ucwaqWLSGBkE2a8LAPEaYR/wMovz65A=;
 b=OIxAf8KVcYHnxcK9u/uoPfJXZbqwMHb8doE37K5FD1EpOW6qCrFvSY3Yc3K6sTnZaP
 L9vbxC/r+niR8AyB9gmR8Icwps3YzoETbcQHYqpTdHGKfTKsH3pRprWisjSwOAuzyel7
 W1+VOTpEafCtFn3zRHbr6lEVql5nyOlYg2RHACa0dozLvadPykgj41Np6neoYRGSsAiM
 gsnsYIeHIh/SpN0BMVmialEzwTB9AnZS4dw8cOgK+GJa98vrjzx6khI87IHl6zs0Fwy+
 exiz+jO8YHEwQCi9ySDa5iDPDGMc8wEChZNng4ViAuSg+XURGQAL4vJzq828TEKHLRw2
 TSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735648767; x=1736253567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPBTgfWc2yc0ucwaqWLSGBkE2a8LAPEaYR/wMovz65A=;
 b=WYDTXgHw2xn+If7NObqxJS+zQWXpFYO2VhbdfHqDvnz33911mCgNYoWwu3jC1m+CSh
 XkTEGih5QPPwCIsDSuKJst5Th5STomiULWU95Bp9n9le5iZXyr2VOOrogRVMeJPesPzu
 UfbPZN4yhpMwsWsSjIl6l73jDxl4y0C87mCWFV9UtITsQ7+esQ0NAhKvLPSnUB+6k2ub
 MUmLWlI7Fuu1aPPs7sUOFdMEw6AV+Gc3n0HktNG+QDImOQfex1nkXNk8ty9gE1eTQ7iL
 BKfHOzI85Andx322DJY0deLS2iPELJ2D33BDeWvCVKGd7fV8G2K1+NFQHOX9ZQepL8dR
 ydaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1rWROSe4JwUSZr6JWrLNAjPM6ZzxDsv9CZvf8c0Ajrqj/iQSWh9xP6OgYsrcAs2CcY7RBe275hOol@nongnu.org
X-Gm-Message-State: AOJu0YwAji4UGNC12w6GoWwIA5S4nhslD8zeR7EphBr2zs3XWs1zc/gx
 WhmGEmm1EsPAIcj3vKf3KLoMFfQk6dkR8rdZKZ3ABBHKGaIDLOP5DFC+aZRXPD+KBteX/1J1IJs
 OA04R/Oaicc3+aQ0R5uCVQFdX0uE=
X-Gm-Gg: ASbGnctpcqBPEx42CqUBIlb3WmXgYgvyDSZPzwGeAtyDHyVx8h0GzjUnaG76zjefGx6
 GAjQ1I0KHhUmWXjZx1Q5y9ggQNQHZLuVpuVWD
X-Google-Smtp-Source: AGHT+IHclVvIpoCxnaRXwa4Yg+oQZOAZLD4lB5I51HH0LrC7cbIvwlZhChqMh2UmyXsGJFhorrUM9q8x0mF0dz2xuZQ=
X-Received: by 2002:a05:6402:348c:b0:5d2:7270:611f with SMTP id
 4fb4d7f45d1cf-5d81de48bc6mr33219783a12.22.1735648766437; Tue, 31 Dec 2024
 04:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20241218195247.5459-1-deller@kernel.org>
 <20241219200138.GA722208@fedora>
 <299f897a-e5a7-4055-86f6-2106a0aaec0d@gmx.de>
In-Reply-To: <299f897a-e5a7-4055-86f6-2106a0aaec0d@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 31 Dec 2024 07:39:14 -0500
Message-ID: <CAJSP0QWo5aNYxz3-aEGgCfJSsHhnt0h9Yh_friTicjmZ1FFoGA@mail.gmail.com>
Subject: Re: [PULL 0/6] Linux user fix gupnp patches
To: Laurent Vivier <laurent@vivier.eu>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, deller@kernel.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 19 Dec 2024 at 16:48, Helge Deller <deller@gmx.de> wrote:
>
> Hi Stefan,
>
> On 12/19/24 21:01, Stefan Hajnoczi wrote:
> > Will this go through Laurent or did you send a pull request to have it
> > merged into qemu.git/master directly?
>
> Actually, I'm fine with either one.
> I do understand that reviewing this patchset is somewhat
> challenging as this area is quite complex and rarely touched.
> That's probably why it didn't received much review yet, so
> I decided to send the direct pull request to not bother others too much :-)
>
> But if Laurent want to take it through his tree I'm fine with it,
> same if someone merges it directly into git head.

Hi Laurent,
Please reply with Acked-by if you want me to merge this directly.

Otherwise I will wait for you to take this through your tree.

Stefan

>
> Thanks!
> Helge
>

