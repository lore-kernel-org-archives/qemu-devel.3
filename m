Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB9BC5321E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 14:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siDw2-0001Pm-Oy; Sun, 25 Aug 2024 10:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siDw0-0001P1-ER
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:09:36 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siDvy-0007i3-Pj
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:09:36 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so3982539a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724594972; x=1725199772; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eX4OavJ4oGDwdN8mZewGGsJTmlPE+5lOMh3QkcwhuW0=;
 b=iUxPuA6rviYImw1j6JAHLpAgn6jlZWYIw+pXODFCg53vk5N9yPxJFRCwcQ6tSOIGc4
 /6LFiizsrDByFtXbz7biV9EDLp7KQNGA2lhSn6A+Geioeg8uidGJd9iRRo98vatW5Oei
 urMJc3aZ2oVxuasX/8eWaY/P5ytYhqcJp1JHdO9v4WoNi2eScS3W6NWHc7EJ4voktSd5
 INsC4b8t1cw1YJqEiwsvUQZw29U8Edo7OiztrFMmI3vthm2mO5owL4XwfQJj+neB7xvm
 56Mj+vQKHnYNtVjnDpyxqT2AkwpALPU3udCv4sLAduzyuRexvRvMgWanNIEt/JKZcjk8
 UyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724594972; x=1725199772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eX4OavJ4oGDwdN8mZewGGsJTmlPE+5lOMh3QkcwhuW0=;
 b=fe8mLbj4qS5gzKa+3MQ6wK2CLE9slaVoIjxuZ/9qu0aR1nTl1ZFiJk3/Zcen8jxvrW
 dfFtbvAz1FL68XgTyt32YFOIHamjx/DF3FZjAHks3IHWNvOF12fCaKr1f8u6790yXkRi
 Dw0NJQlkLbLc/ti9pcc++tx1PSDnSji+E/+EKJS2TfhMB3K3NWRQjETNiuO1u2+KYRmt
 8jjJpWfOjGdHtxDVSsGuLKUA5XeDeMGUT79sqmFePr52AyGLxGp494y+MWIy9dUE8R1o
 f3lSEdB0o1uCdpPma9ZBCeqY+YfH/VSOtmN5CHLV029O/qFgHRQC//vfGxaWIA3IO20i
 TptA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAUq9Ick7Ddx1XIZWDTXuagZra9yfYf1BRWqe+wTrQEaKP3DLlnkpvkx9zHeIsHo93aXB24MX43gbO@nongnu.org
X-Gm-Message-State: AOJu0Yxdp9VM09Ay9LYgcZQcd/8F1SAZfc+L8bH8O+RzAnYskj6lcCE8
 WULpLe6yDN3jp2sS7ciAeyapgUoSz2/Qiql900dJh6tV72PsBtzRUqH9fYYRKQnNXTeHZtntDrk
 Kj49PWzzqw8+wcJbxSPGk1n8OWshJHZ3mGdqgiQ==
X-Google-Smtp-Source: AGHT+IErEySF0fLDAFf/rjT0GerAmOdt7ftslWzM7CAZQAwpxER2/l1ILPMCXYSTS1J9HlElUfIiWS7Iaom7CiLn068=
X-Received: by 2002:a05:6402:51ca:b0:5c0:a8d0:8782 with SMTP id
 4fb4d7f45d1cf-5c0a8d0880bmr735037a12.28.1724594971650; Sun, 25 Aug 2024
 07:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240822163838.3722764-1-a.fatoum@pengutronix.de>
 <ZsgsG_WL7TNcM1_l@antec> <ZssWudpcVotQWr45@zx2c4.com>
In-Reply-To: <ZssWudpcVotQWr45@zx2c4.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2024 15:09:20 +0100
Message-ID: <CAFEAcA95TEA-5Mq9n9+Mva0r-W040A-nt9doCmPg7xW+dU3E2w@mail.gmail.com>
Subject: Re: [PATCH RESEND] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Stafford Horne <shorne@gmail.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 qemu-devel@nongnu.org, openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sun, 25 Aug 2024 at 12:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Fri, Aug 23, 2024 at 07:28:43AM +0100, Stafford Horne wrote:
> > Also, I will wait to see if Jason has anything to say.
>
> So long as this doesn't change the assignment of the serial ports to
> device nodes in Linux, I don't think this should interfere with much.
> You might want to try it, though.

It looks like this board already creates the fdt /aliases/
node and puts uart0, uart1, etc, so that part should be OK.

However I notice that the openrisc_sim_serial_init() code
will always set the /chosen/stdout-path, so this means
(unless I'm misreading the code -- I haven't tested) that
the last UART we create will be the stdout-path one. Before
this patch, that would be serial_hd(0), but after this it
will not be. So I think we probably need to fix this too
in the same patch, so that we only set stdout-path for uart0,
rather than setting it and then overwriting it on all the
subsequent calls. This patch on its own will change the
stdout-path value I think.

-- PMM

