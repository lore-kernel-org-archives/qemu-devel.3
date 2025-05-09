Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13226C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDR65-0003tA-Lf; Fri, 09 May 2025 13:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDR60-0003sQ-1l
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:01:12 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDR5w-0002gk-Tt
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:01:10 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c27166ab3so1701501a34.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746810067; x=1747414867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paY1xhpxxD3cgiMh4ZzgRlIuDgB0R+vrTXuDnfK0F3g=;
 b=No4jaG/Oc1p6OpURLXxXys6uCg/8sZ+jgPrxfF2oyG8xsMxuRiP9WXp7VpQLPk4oxi
 jjywpEjiHiTPhkZBRqYdVUN6IUSuDH1OZnx4f1Cu7WthIHbPe0Z8osQ0x+RXLoYQn9fu
 KXEaFJQAckcTQOcGoqMtDqzznlqkkSOBbJNxBPjuKlB/tc2BbaLj0NZyrJAjPkt3mmFr
 VFhoB29fzCQ1m9TRfxaADEUwvfr+nq78juCG9h1gl/Qaw9fMV1zk4qHGPciOy5Qv8Cb6
 MnPBOG1ycheXs97ZTuCL8ypOG7lHiPE9JTiQmmOaj2Ym5blADliFbTcP1Puz67ygqt52
 PTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746810067; x=1747414867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paY1xhpxxD3cgiMh4ZzgRlIuDgB0R+vrTXuDnfK0F3g=;
 b=RV1PEPM2ytjH46x00zLf8ks+A6tusGdU2JR4TyvUp02fE9xZBn45gyLzZ19B1+L/aV
 r20jHMyhZW7fGdT5DUWR3LMAfZNxB3goRZSbZ5dUBIZ41OuRTxT79gscLuEkvVknhob1
 +dpKbLVK1JhCtBnowiGH30xKQOPC74PZHw6KSyLKsGp80Afmh+K/YsCgvAmfm2pm/uYs
 IaECg0KWwdQCgu9G7meGB3LMwUbsYr3BaMmg9hOKuzRHrSBgfpihS2oSMqdrOOoi5GgI
 P9CXEv1Kcz9CmaL6z/s1zu/jaNmrBgH1PIj+xOZM8Kw1Ovjju5GCkX2WVNuLj6ee0tZf
 nRww==
X-Gm-Message-State: AOJu0YynjsJ+q16PzBjJg2hRr7+E5QcKeASgwGN4H1TB+T94Lp/hVhBW
 8lBMfqDhK/eMyH1flyz42PIw9yGTrQZdPe9xjVBgQZsbsO8log1jga0WojAOnpQyp0nYmjg0iyD
 p76Hylx3qidTQKFYLMXpbnPe0ZHeakH6u7RcJjg==
X-Gm-Gg: ASbGncsIFwv51GstqZQ4f6d4u2PhConjtgtbZK1t+e44drV+mGHsMVyOOdRx926+pVE
 VqbEg0t5i7qWWGHLAypfgnf3Km14ccpOcf02ZIebBnoTNziarFe931S5EnBXzKj67ZJ/HPh6pch
 9fsOELK0ODI/8Yk4j12VAFVYI=
X-Google-Smtp-Source: AGHT+IFY6Z2IXv2F7kxYSsMCI1o9M7twZQSLu4osy2USIA5Nz9oZ+9wUc+K/l/aTl4LMQFv/ZojWASsitN5myb9vuFo=
X-Received: by 2002:a05:6830:6e8a:b0:72b:87bd:ad47 with SMTP id
 46e09a7af769-732269bbca2mr3343436a34.3.1746810067306; Fri, 09 May 2025
 10:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANhBUQ0BVpgmB6+qd9X8ieiyDcg4pSUzLAvO33LQbpfeq3Be2Q@mail.gmail.com>
 <CANhBUQ0E0bpyL584ZN-4kcjknOtun-UT0Rd28LC=KXSJoLCALw@mail.gmail.com>
In-Reply-To: <CANhBUQ0E0bpyL584ZN-4kcjknOtun-UT0Rd28LC=KXSJoLCALw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 18:00:56 +0100
X-Gm-Features: ATxdqUH2T3aPgKU6X_O2RP0LrK3sv8JlpSXZ2xVErRRVL7LZdh_wpbZUzIcozkE
Message-ID: <CAFEAcA9wUCeRnyW+fjHDnb+WO+28QjWLBSkO1v6A6hAyig0GMg@mail.gmail.com>
Subject: Re: Out-of-bounds access in rx_fifo_push()
To: Chuhong Yuan <hslester96@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
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

On Sun, 4 May 2025 at 21:53, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Hello,
>
> This is a bug I reported to qemu-security, while I was suggested to
> forward it here
> because it doesn't align with the virtualization use case.
>
> Thanks,
> Chuhong
>
> ---------- Forwarded message ---------
> From: Chuhong Yuan <hslester96@gmail.com>
> Date: Sat, May 3, 2025 at 11:30=E2=80=AFPM
> Subject: Out-of-bounds access in rx_fifo_push()
> To: <qemu-security@nongnu.org>
>
>
> I detected an out-of-bounds access in rx_fifo_push() with the fuzzer.
> Run the fuzzer with:
> ```
> export QEMU_FUZZ_ARGS=3D"-display none -machine accel=3Dqtest, -m 512M
> -machine smdkc210"
> export QEMU_FUZZ_OBJECTS=3D"*lan9118-mmio*"
> ./qemu-fuzz-arm --fuzz-target=3Dgeneric-fuzz
> ```
> The error stack:
> ../hw/net/lan9118.c:455:5: runtime error: index -30 out of bounds for
> type 'uint32_t[3360]' (aka 'unsigned int[3360]')
>     #0 0x5db0345b2020 in rx_fifo_push qemu/build/../hw/net/lan9118.c:455:=
26

Hi; thanks for this bug report. Could you provide a standalone
reproducer, please? Something similar to the repro you give
in the (unrelated) https://gitlab.com/qemu-project/qemu/-/issues/1863
that has a set of commands to feed to qtest would be great.

If you could do that by filing a gitlab issue that
will give us something to refer to in the commit message for
the fix, so that would be the ideal.

(Many of these old ethernet device models are not great about
guarding against the guest doing invalid actions like
popping an empty FIFO. Luckily we don't use the devices
in machine types that support virtualization and that
therefore have a security boundary.)

thanks
-- PMM

