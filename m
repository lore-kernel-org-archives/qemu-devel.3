Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7553DC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 09:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVSu-0000Qz-OR; Tue, 18 Jun 2024 05:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJVSs-0000IW-5k
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:49:22 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sJVSq-0006pL-GC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 05:49:21 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57c68682d1aso6015061a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718704159; x=1719308959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDBgp+4Nhw00XJwwlTzLndXxNKYvrGM/hZMQ1hw2VO4=;
 b=qA9BFUD4GCH+kNbF+sgssQhJxs091on5IN7ABVbq2czNcY3oOo2KjtftRYMtwdnbTm
 IHrK5K/oSecqzrQvfjNZDbyopEhZLgzR8EkmhGz1MMPC44yhvkZwoRDJIvzg7dq9I5NI
 W6OCcnUXrU8DIKjK6RC9BB5lL0DeIzU7ibYODtPIray/219IjC2FjyJhPc5qYqEtt0Q4
 klDieUdUmk2flmvSntMeicdAzp3NheiexgsH9RUHLXxn5ZktNdMPTqQbayjNDBHz34Gc
 /c1rHeu6LhkWSj+W7cTPi3FVpvjvAQ2hKXPyA4pLiWR/VStxW6e+U3Zf0AxJ9+19Rfry
 ltQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718704159; x=1719308959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDBgp+4Nhw00XJwwlTzLndXxNKYvrGM/hZMQ1hw2VO4=;
 b=mlX1RTTz2Zmu9W9ikYIZPjRz3oggVL6HU9vBBr3wNNZhFKcdb79hnG1mr52MTAnqSI
 p+yd6YUOkqV1rwwp+26YtSElzROqYa5/4Ql0qhSOZB/ZgfEuIkJr7qeKtq4FqDuk669p
 RTMROVGIvDGYT7bnF2lRr1OzuQ39LrEujWQpG00kJGRu0/c6oc+uJyTzjni1WT6Mcs8H
 m5NFJqrXN+RJt8bel1cvdQxRQod5wZEFxjkqvl6S1lclQhB5iPZ6X4U0rTSQqSUdg82I
 nMqrCjMzTlvk5cIO515DH5jIPI1iVJ34DzzStY24any6FtBieUx5aI0aDCpGcbm2Vbwa
 ERiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf16KvhFZj80XiPGCvZlJmUNkaGuvf1NV/yvasSYCtM9m63W1pov/52HAT/6CTZvHRtPQjWn1xdzf+AXcLFy1QoqFhASw=
X-Gm-Message-State: AOJu0YyMBND8Rcr3aj4yWEmxkEAF3axi7Ys1RZNpg4tSVR1EekefOgCr
 fm5gmOHfxNbWItvXSqJ9SRefLYq/B5ZEQEV45SCXKhirVhuHabFgPW3bfL9AjX3jGAHF6AToj6Y
 /r3TQ8pI52Xig6fVVZ1zov3kB9mksX7NxHw3arA==
X-Google-Smtp-Source: AGHT+IH61bCi//aSsTgqJyuw2g5fXwy6pKaVMZZqoP6QVfPspU7F+FfG/APqHTGa8fx2IF13+Z7wWbrezC0byB1EZ5E=
X-Received: by 2002:a50:aa91:0:b0:57c:6955:41ea with SMTP id
 4fb4d7f45d1cf-57cbd6cb864mr6970722a12.38.1718704158524; Tue, 18 Jun 2024
 02:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
 <ZnFPwinlmxpgH3mV@redhat.com>
 <CABgObfaGHk=A1kCbvSYnCgepu4whk3VDjT=YgLwagxx4wEoYaw@mail.gmail.com>
In-Reply-To: <CABgObfaGHk=A1kCbvSYnCgepu4whk3VDjT=YgLwagxx4wEoYaw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2024 10:49:06 +0100
Message-ID: <CAFEAcA-PMcT1Kidmp+Hu3tcOAf74w-QwXdoaV1EWn51w=F69YA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 18 Jun 2024 at 10:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Tue, Jun 18, 2024 at 11:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > I wonder if starting with a device implementation is perhaps the
> > wrong idea, in terms of a practical yet simple first step.
> >
> > As devices go, the pl011 device is simple, but compared to other
> > QOM impls in QEMU, devices are still relatively complex things,
> > especially if we want to write against safe abstraction.
>
> It's true, but I think _some_ complexity provides a better guide as to
> what are the next step.
>
> I think it's clear that they are, not in this order:
> * calling QOM methods (Chardev)
> * implementing QOM objects
> * implementing QOM devices
> ** qdev properties
> ** MemoryRegion callbacks
> * implementing Chardev callbacks
> * general technique for bindings for C structs (Error, QAPI)

Right, this is why I suggested the pl011 as a device: I felt
it provided enough complexity in terms of where it interconnects
to the rest of QEMU to be a realistic way to find out where
the points of difficulty are, without being super complicated
simply as a device. We don't need to have fully worked out
solutions to these things in the first pass, but I agree with
Paolo that we do want to have a clear path forward that says
"this is what we're expecting the solutions to these points
of difficulty to end up looking like and how we plan to get there".

thanks
-- PMM

