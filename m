Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E3D3399B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SQj-0000B7-EY; Mon, 28 Oct 2024 12:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5SQZ-00009f-GV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:17:11 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5SQH-0006oV-FW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:17:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso6993598a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730132204; x=1730737004; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wqc0Mytncd4ocb+4kmZP30a/3t9yuKUeJQBreLTvPE=;
 b=q9grr5nPu2m+5BMejm3PAv/Z9HU0UqSNZMYWDhDwVQsgBMDz7RbF8oXXAAY8fzwCHt
 J2eALhsE+G9tbuZJ7z53g+TCXhF0tSP6LOYrJ70X3mXgpT8LflhfZ8ExacIwQ12JziE2
 N3vwrHFtFBJNtlbOikMXAJ9N7B3KPAZC4RwV/498nqqkfHq/AscEBM3HV5mxuFZCkSwX
 yiAChqEivICxWx5FoUiV/hcHAm4reDgBbA+yyGPvFoL+n6TgsMBo21JDRKBzmqFK7Qvt
 HFmx8w3hMqG+BeMrdXfxuZsaAUmcoOpLE/H/+K3meAULxZxgfkMSsTXbofVT721CVO50
 6FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730132204; x=1730737004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wqc0Mytncd4ocb+4kmZP30a/3t9yuKUeJQBreLTvPE=;
 b=LqZ+a8mew05Ka1u+0ROHNssQgnbWzOy2LWYO5jYFfpCTXtbYBoM8JzF5G/Q1HTil5i
 cEsMJGqE6ywIkBi9cqe5uOr/a2c2QUFshNUIBDeB/zmJzShUJcBAlwUVitGjeiDCcrrb
 fkErXBUMl50jchvO56jNr6Jqm/7UcehCrNCcuCj8kLJHknJnFRogOqOkhk6VlO0OJvZw
 kBq5Oy+FW9u9J7I8rQuJ8Omh3KOuW7VMcS98Vo1XNsdti4KE7Vh7VLPVm/1RXWtqX148
 M2d1XgiqjK9Ibeg70EH3daBNjA0OF0IbBsKhaBXoHQgUOLpaLInhc8xWnYcuC76WUrVR
 8jUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkVS534qKYn2/fQMCUi2NT4ILGIdRpRbCC4VX7lAVKsHY24XQb/AHTsTSg3fnDW81697m880/WVvAc@nongnu.org
X-Gm-Message-State: AOJu0Ywj5myR2YPJTTJbUxQVZr2iCwV2kgBiAeuHEa8dUDGduW+xSF+S
 MEgq/Ze0v5FooQ242wCk4cr/FAY10RX2ctIEQtAAqfj4g8rHGME93xf1CWzgU8wfI63ndQSWPAA
 DD7IJFuEmzFWkSobhbsCBE2xEMZLNkvUw2S3dSg==
X-Google-Smtp-Source: AGHT+IFSr9SWfgXnn1VX0OvmWu0cAtcZmGcuumJXCuQuyg7HC2Kje6V2twZXQfCfvpGcOd/Llmg2R9DBtIU36NHY3sQ=
X-Received: by 2002:a05:6402:d08:b0:5cb:77d1:fd7f with SMTP id
 4fb4d7f45d1cf-5cc196360f8mr133123a12.7.1730132203869; Mon, 28 Oct 2024
 09:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com> <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
In-Reply-To: <Zxub7ol4p8P_sWF8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2024 16:16:31 +0000
Message-ID: <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 cohuck@redhat.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com, 
 philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
> > On 10/25/24 15:06, Daniel P. Berrang=C3=A9 wrote:
> > > Also, is this naming convention really the same one that users
> > > will see when they look at /proc/cpuinfo to view features ? It
> > No it is not. I do agree that the custom cpu model is very low level. I=
t
> > is very well suited to test all series turning ID regs as writable but
> > this would require an extra layer that adapts /proc/cpuinfo feature
> > level to this regid/field abstraction.
> >
> > In /cpu/proc you will see somethink like:
> >  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
> > asimdhp cpuid asimdrdm lrcpc dcpop asimddp
>
> Right, IMHO, this is the terminology that QEMU must use in user
> facing APIs.

/proc/cpuinfo's naming is rather weird for historical
reasons (for instance there is only one FEAT_FP16 feature
but cpuinfo lists "fphp" and "asimdhp" separately).
Currently QEMU only has to care about cpuinfo name tags
in linux-user/elfload.c where there's a bunch of data
structures for "what hwcaps do we need to advertise
given what the CPU has?". I would definitely prefer it if
we could use architectural feature names...

On other architectures do we do anything to forbid
invalid combinations? For Arm there are architectural
rules about feature X requiring features Y and Z.
Are we going to just let the user create a CPU that
the guest OS will barf on if they want to? (The
user-experience for that is potentially not very nice,
because something like "-cpu cortex-a57,+sve" seems like
something you might want to do but isn't actually valid;
even listing the direct required dependency of FEAT_SVE
like "-cpu cortex-a57,+sve,+fp16" isn't sufficient
because SVE is optional-from-v8.2 and so a guest could
in theory assume the presence of anything mandatory in
v8.1 and v8.2. But even merely diagnosing invalid
combinations is a huge pain, and automagically pulling
in every mandatory implicit or explicit dependency
seems like it might be surprising to users, as well as
being annoying to implement. Currently we sidestep
all of these problems by (a) only allowing the command
line to disable a feature, not to enable it where it
didn't previously exist and (b) mostly not providing
command line flags for individual features...)

thanks
-- PMM

