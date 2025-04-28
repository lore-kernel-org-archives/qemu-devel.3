Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3533C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NnA-0007NA-5b; Mon, 28 Apr 2025 08:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9Nmf-0007AF-PN
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:40:31 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9Nma-00014y-TQ
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:40:26 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6febbd3b75cso44338927b3.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745844021; x=1746448821; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pirX8cpyg6mVMtG1862TELtx0K1OBQ8PpeZW5fiTkRk=;
 b=LV/pe8JfezP8XvgB19bx5nKVL8GrNNAQYRS9Y3MrbzYjUowjgABF9H9nd1rXsPAxhM
 qRWNYNBUV9W7EutpnDQ1VPDVeYpJ9qo1EF2qR0TkOoJgfgeUAr36BEhl8MF6OY6Aqmho
 BU4PpWjIdNmS9VoXTXbecUBX+Mdtf4OFkE/Oh1Tpv6SlfFP5o2O3rjtFRot09yDVsaqb
 eDkM0fo1hxCDsyFhn5o16E/QCprcxBSa56c0AL3m7exxj8tJUMEDy+jRuVfJTSgFzrgd
 pANr8q75XMyAhj3DaCgURtMYVh9pBKkAaOwXcpHDyBPNu43bknXsLrvtqd6S/n6ZPS2L
 7HGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745844021; x=1746448821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pirX8cpyg6mVMtG1862TELtx0K1OBQ8PpeZW5fiTkRk=;
 b=Kbw1CXUxeZGyShaUo9OCgnyO4O5AhEbAwQZNsJSR0QcM7VtTMQipLFfWoaO2LXnS0h
 0uxcJNdCWJsJMzGI5vbH1HHvfPzWVbnUK11a4mmtgJPSI55cvhda6YRLNs3rWhkuKoWL
 SWy6OuALN2+5XAGqzOcrNE0Mzwk4iIPZ4Rf0uQuBg7HHv+lSKlxVJOoVIFL6TKzjvH6O
 62jsjU8NYhVqXnIWYNLLcYfHjNEL7uDjhxpNHITP6X1mBf5M03NPzz9Ulf1aao958LZa
 hJcyo/vi3jFZNfpBtbjG1OHU3BT1N2DOcGr1+SfidplFRFjimhkBvVyXPOtj9TMtqBlR
 hXlg==
X-Gm-Message-State: AOJu0YyXuTNAmfyngUGUkULBIV7swNPM5Au6EGiSi70N9uJCec9PobIR
 vWrZ72g4kCWAru6xwfIl5YUhF/p9p0G3Mnnixq5MBV9wTjA4X1CJgyaGKh7hX5GjenwB0yFVUHJ
 OLdWkx7k+YhCkjGhCRWC3rdhqUEgnKjNBwkyeQA==
X-Gm-Gg: ASbGncuwro/bzkgD2WcTtWt4DWGTMNujMdVScHoG23Wx2gnPNaHpg3Y92UYRThFZPt7
 eYCmD/7sAYDeemxMesS54+9pT0FWf9Gqs/ziEPeLMFekJ5SmY9rxc+a2OpUMF9Qj1KIdIAUZaea
 /PtjP5psz01gSLkfb9z4EnFg8=
X-Google-Smtp-Source: AGHT+IF/HoMfSAzVy4Q8umhuBjc35j9vJuCCbncxnt6uREJ59g5AC+rPUfYRIp/cekpwmffLqGKCoDquA8ArGOwKjcU=
X-Received: by 2002:a05:690c:f8a:b0:703:b92c:7170 with SMTP id
 00721157ae682-7085f16b2d9mr122474177b3.12.1745844020890; Mon, 28 Apr 2025
 05:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_6CC3332A93DC02BE2030AB5BC0E63B10B808@qq.com>
In-Reply-To: <tencent_6CC3332A93DC02BE2030AB5BC0E63B10B808@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Apr 2025 13:40:09 +0100
X-Gm-Features: ATxdqUHfsmhsjODmLNyCijkZR0EhR3kNVWgbRpnaDsvyJtxpTzuIO40OBOKSAa8
Message-ID: <CAFEAcA_kekj7L9a1TwQ__WCyhgFd8P+32pB+dQGO570tEoNZMw@mail.gmail.com>
Subject: Re: Whether the qemu mps2-an385 model support getchar?
To: =?UTF-8?B?5bCP6ams6am5?= <1353455048@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 23 Apr 2025 at 14:06, =E5=B0=8F=E9=A9=AC=E9=A9=B9 <1353455048@qq.co=
m> wrote:
>
> When I use mps2-an385 model on qemu, I found that it seems not support ge=
tchar. I used the FreeRTOS official demo(mps2-an385-GCC-QEMU), then I tried=
 to use UART  to receive input strings from QEMU terminal, so I tried to us=
e getchar() function. However, some errors occurred in QEMU as shown below:
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> Is it means there are something wrong in the emulated board? And how to s=
olve the problem?

The UARTs on that board work fine. The error message means your
guest code took a fatal exception (i.e. it crashed). You should
start by debugging to find out why the crash happened, which
might or might not be related to the UARTs specifically.

thanks
-- PMM

