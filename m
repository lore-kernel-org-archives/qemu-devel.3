Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE4BC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 10:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUP04-0002BM-HV; Mon, 29 Jan 2024 05:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUOzq-00026d-4E
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:36:11 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUOzk-0004jX-0U
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 05:36:07 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55cca88b6a5so2182519a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 02:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706524561; x=1707129361; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E7ecJE8RRGGkgWTaJQO9tUMKfE9qiDrAmN7KCJ3GG0A=;
 b=sX1sHbv8dgaUMWWOIc1vGQ26PaiYi8xaU3wVL5PUoueU9EI0EmgxIqA9OzM1pYbKT3
 rIF5F9Cw6Un1X3zbikdYU7qahdyjM6yIVjOZ2BUNlzdC/aOtgaZXPoOT5EtFWI/sHrOC
 KZjdWvPnswE3G9dODbP6rqRQrVPEO1cGwz9b6wvAtzkRNh2B1rVv3DbXFmWaNjqvR3ZV
 /BSfjxcd0tdm55jPvd++TFMKeilvlV1acjgLTqrnxV+6vsKHdbKk1t/oYBXObv0LiFr8
 HO7kYJlFrKzaInkZ5GICkFAKLkTqTWkv52kk9FAhmx0k/tTCI/BX1ZIfMmNKqJr1WRGN
 bOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706524561; x=1707129361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7ecJE8RRGGkgWTaJQO9tUMKfE9qiDrAmN7KCJ3GG0A=;
 b=hNmVzK+Soxua7rYUWB/A8Z3E6fIBQk+mmpa5sUAkOFqeuFz6536axulJdvPiCJx+9d
 Qns5brPluyeebiIzsTOqf1GmzaUezWvDR/9rs+nXQNFV0tbLb9pz+s0lMjoodfJyHJoo
 gk/Q8UamUise8XCBRq7jP4ZOdRIXMkHFLubztQht8hIRi3mettbB5PbFIY4/s2sw7Kux
 1Ute3J7dvjfe0PTdc9DFnHfdPVl/G4bRjRb7Sp25XfNHTGsjuQx7JpSB/3e1zpfyc2l3
 CMq0Yef583zYmuH9CyBvhc8DQM5oP2ib2iB5VS/p9HujWVWMvQGXuIoi71p7V8c/+h/G
 L86g==
X-Gm-Message-State: AOJu0YxmgXDQgAJ4uTrwC/xNCOd5RxYCHKL2Dtdi9eqb5vKCAy/DHqAA
 CXuIl25VjSo4Xn8wOYRfyxYPasiqHQk6WyQ7MNmONi87YZ4ZNAgazricHfAJppffXdKX38hqxW2
 DHQCSzflru/9f33XfpOwYe1xpufs4nnVFZqwSuSEdvvPgUhfh
X-Google-Smtp-Source: AGHT+IHCslxT48N4Lq4eGNVNvA+KTxClc7eTAHNhNVEM5hFUbffAm8AptSO5QJM0vwq+lxFRiwP3AvukeaShIsYvbns=
X-Received: by 2002:a05:6402:430b:b0:55c:8ab7:9446 with SMTP id
 m11-20020a056402430b00b0055c8ab79446mr4272095edc.7.1706524560740; Mon, 29 Jan
 2024 02:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20240129081835.137726-1-thuth@redhat.com>
 <20240129081835.137726-2-thuth@redhat.com>
 <3e984769-f178-46b3-aaa8-1718b6fd49bf@redhat.com>
In-Reply-To: <3e984769-f178-46b3-aaa8-1718b6fd49bf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2024 10:35:49 +0000
Message-ID: <CAFEAcA8W6hRr31=HeyrxhsgBEmR-VbEEvV2wHB1Fhha0cc1p8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/arm: Move v7m-related code from cpu32.c
 into a separate file
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 29 Jan 2024 at 08:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 1/29/24 09:18, Thomas Huth wrote:
> > +static const ARMCPUInfo arm_v7m_cpus[] = {
> > +    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
> > +                             .class_init = arm_v7m_class_init },
> > +    { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
> > +                             .class_init = arm_v7m_class_init },
> > +    { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
> > +                             .class_init = arm_v7m_class_init },
> > +    { .name = "cortex-m7",   .initfn = cortex_m7_initfn,
> > +                             .class_init = arm_v7m_class_init },
> > +    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
> > +                             .class_init = arm_v7m_class_init },
> > +    { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
> > +                             .class_init = arm_v7m_class_init },
>
> I'm not sure these CPU models make sense for linux-user

They do -- Linux has M-profile support, and we also have users
for the linux-user emulation with M-profile CPUs (eg people run
the gcc test suite that way).

-- PMM

