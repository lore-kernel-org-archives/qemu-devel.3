Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C5CC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9qR-0003gR-K3; Mon, 04 Mar 2024 10:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9q8-0003cb-AS
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:02:57 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9pv-00019Q-46
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:02:50 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5673f7b3196so1662321a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709564556; x=1710169356; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otbtgtUNVpwfIth7PNDoBPWCzPaH5tButK7oNpC0WYk=;
 b=Z7/K6HQ7yYhfp0z/EVQckfqasJWY7Cpj7c3o0r6i8r4OvtfldXXk82XgUcXZ1TwrAa
 C3KBapgYHPPVHUnc16WEPx57aknBu3p0lDV6LcDutNMaFUEYKo5plzkaeWSJqM0XsD7K
 D6tVKFxQW09tGF+2BtaspnPq3wySYaqTFPWyDTNPPB8pSSrWKilGIpO+F9jsSYxGtr0J
 3KdAs2CksbHd6enI0ozs26FL0wXClRk2Nmnepoct4TQzg3j5Qr31yVgeZ9CHBefqc2Zx
 s27+oB6v5MM/KGaCmCMcBV9qi4ZIInqDx3BcDfHwvkvRLMHqEeLsebjeZm2YolDZwgk8
 JQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709564556; x=1710169356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otbtgtUNVpwfIth7PNDoBPWCzPaH5tButK7oNpC0WYk=;
 b=uIXJJ1NxA97c8HdQUHkxj3p5eFXjsVE6k1PypgZffGu6qcj7XJnyAH84wogrbd5B1r
 /4XKFb2i7CK6bhRospiQx8tG+f7kPsC9EHd4VJHxx23QS9x9ls3GOY7yHw7B8J8SjEBK
 JGcR5in6WK3InKlGFq0MF7v5zWdHdzR5QzLZ/EoEMmwrYeBqL4s7f4nkiHcyRtv0zkxy
 y+qo9LIqqI3zIYN7tT9/dLETaSJw9Hx1YEPZlWwgFp2UwVlS2wAHJlNDWK6ySkIEt/X4
 m0wL51IVpe29VAbdzXVTnOnMsGC9c5txgW1pXzJpOrY2/Lt+4FfJ5325XBDNkIrxfB0u
 A+kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE9uWJ9uvqh/MoHb4uOLyCgyyy6SSjYjBF/IDMzPUuxTNCzrNb5K7fEEVvZl51H6n+Lu1xW2XTg+ABGtm2q+ZBqkhn6B0=
X-Gm-Message-State: AOJu0YxNhqbcLRaseomeWKfns+V+aSWaKMm5tJuEjFvGHRY/RJoqSFIM
 8R8H0Du/w52yhdF0UBUrrDK/eKocNgNJSjyhPtMUkxA9gbLY0gr7KhRVuclG1UnGr3qgrQSoS33
 jPpOmOZ5yJUMyjQRTyz16MWyCcVossi0xM5P5Gw==
X-Google-Smtp-Source: AGHT+IHpoMxunOka5Wmm9+DK54avExB6Nl5/p7pkdeChfvh46B34Gkfzwkp6D9mHoegsBdAjBFwyqUh8GcVXtfoYgEg=
X-Received: by 2002:aa7:d8cd:0:b0:567:56b5:8960 with SMTP id
 k13-20020aa7d8cd000000b0056756b58960mr1710862eds.13.1709564556606; Mon, 04
 Mar 2024 07:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20240227054855.44204-1-tong.ho@amd.com>
In-Reply-To: <20240227054855.44204-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 15:02:25 +0000
Message-ID: <CAFEAcA8EH1VLRPBb4gGCHotLbG6Gpnf3OqGM5Vy4GUX+2h_=_w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/pl011: Add support for loopback
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, francisco.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 27 Feb 2024 at 05:48, Tong Ho <tong.ho@amd.com> wrote:
>
> This patch adds loopback for sent characters, sent BREAK,
> and modem-control signals.
>
> Loopback of send and modem-control is often used for uart
> self tests in real hardware but missing from current pl011
> model, resulting in self-test failures when running in QEMU.
>
> This implementation matches what is observed in real pl011
> hardware placed in loopback mode:
> 1. Input characters and BREAK events from serial backend
>    are ignored, but
> 2. Both TX characters and BREAK events are still sent to
>    serial backend, in addition to be looped back to RX.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>



Applied to target-arm.next, thanks.

-- PMM

