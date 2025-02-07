Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2553C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOcD-0001vD-Pi; Fri, 07 Feb 2025 08:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgOcC-0001v2-0l
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:41:52 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgOc6-0006TX-Rp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:41:51 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so4016570a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 05:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738935705; x=1739540505; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yevD9LZYnC7jtqiNZe+XKae1FcHbKwHVm4Z/4ibfqk4=;
 b=jFrB4J84XjFTb+p5/EupWlhi7XXHkafjeO5Ik5nk+EZrk2iGt0xtflGWnx1ZXi4Y3B
 RIGVUCID1QSmmTCHHuNrxFGVwiGVDTirzjtDDwybGsdfheo34Pdv0GpSMVwmSWs4IdLp
 epjyJ0bqaCezxzrcV5HqTwgCFCC2C7EdWA93AEcyNQN1B5kqo5eue491rVK4T7uJ31PS
 4WZV83N7n/v+01+g+YZY7bCeL1wUkQOdfqVAF0ODUoHFXA+ZQmUVSuwTts+9nApqHSdU
 1/CBupZGcGkFMujW3mzTCWfOTjCz4AM7MNkiEdmm9HJIf/PzpBpWhvjbI++4DdbVLT2Y
 2Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738935705; x=1739540505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yevD9LZYnC7jtqiNZe+XKae1FcHbKwHVm4Z/4ibfqk4=;
 b=Xr/OVqWQAeqyJsYKxnJs63uBSH0RIkTsTKGQV36u5vzQz3RaWmja1+NROp2o+v4taK
 tgoh1eoYXAS9icMWQjce+ExlEOcFcKwNAAzEtA2YrZAD4QfJtsE7UqjM2xB6N253LvAD
 vxWGcW3LgUc6sdvKa1SwOxLVJKQBCj/8Rz6Q6cD43TtNJ3xp/zgdw8oH//JH4DKf8Gq0
 a3fHbEzD8RpRogbFMK/e8ZcEBCaUJhI/jHqf4QMGFjmXlt2wY4KaTLJ9V/oW2SHc9xJ/
 CGLN941q1eyKRtCjaD/VGpXq//8+vlhIJQLHDwINGaBpkjtuPp2Z++1kUGkOcVMrISMd
 f77w==
X-Gm-Message-State: AOJu0YynKB1AZNgdVyXwQdtMYF+EzNfZFy0hFP8MgyjUnYXz3FixZP1X
 MDQU8I0/y6Mg8EURCXGGRkplzlF8L4ZSAizVCGcbj2OICjxHi83WHtYW3byx8dhCAvSxQ9IirS5
 COz+4X6TBQrDPo5c7YPyNGpUGiO4=
X-Gm-Gg: ASbGncs+TNNiRv/xcb5QtR5HAWSNkheuBSzcDD3lx3coxNz6C/mYMZga+c2Sa5C1cFL
 xOQQZhnQ/hthjsFm+hBQLuvb2YJpfh7XMAOi269t5RRcGFk+8A1LCUxuIzZiIoIL3a6IGk80=
X-Google-Smtp-Source: AGHT+IH2B8/Fn6cb5AQQnDFCJMXfbJs5LBBUBoV7apHJflbGO/t6N9+a2MPeNrmbHXvaoogdv/LJnkWPUbqIbfqI2OA=
X-Received: by 2002:a05:6402:3491:b0:5d3:f1f7:c232 with SMTP id
 4fb4d7f45d1cf-5dcecd1703amr7897398a12.11.1738935704041; Fri, 07 Feb 2025
 05:41:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <f3639df5-05cf-4aef-adfc-8a39ed7767ce@redhat.com>
In-Reply-To: <f3639df5-05cf-4aef-adfc-8a39ed7767ce@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Feb 2025 08:41:31 -0500
X-Gm-Features: AWEUYZkawdYYeVMGzcyE7xtrfDTx0kuc1V3mY69xfNo6cCeH6NUX8nmwiAKSftM
Message-ID: <CAJSP0QUOzyqE16HL+QfXqQA3oZQ=4b=nt4_8JkoSSx5U_b7MsQ@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Fri, Feb 7, 2025 at 7:35=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 28.01.25 17:16, Stefan Hajnoczi wrote:
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code internship
> > program again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email by
> > February 7th.
> >
> > About Google Summer of Code
> > -----------------------------------------
> > GSoC (https://summerofcode.withgoogle.com/) offers paid open
> > source remote work internships to eligible people wishing to participat=
e
> > in open source development. QEMU has been doing internship for
> > many years. Our mentors have enjoyed helping talented interns make
> > their first open source contributions and some former interns continue
> > to participate today.
> >
> > Who can mentor
> > ----------------------
> > Regular contributors to QEMU and KVM can participate as mentors.
> > Mentorship involves about 5 hours of time commitment per week to
> > communicate with the intern, review their patches, etc. Time is also
> > required during the intern selection phase to communicate with
> > applicants. Being a mentor is an opportunity to help someone get
> > started in open source development, will give you experience with
> > managing a project in a low-stakes environment, and a chance to
> > explore interesting technical ideas that you may not have time to
> > develop yourself.
> >
> > How to propose your idea
> > ------------------------------
> > Reply to this email with the following project idea template filled in:
> >
> > =3D=3D=3D TITLE =3D=3D=3D
> >
> > '''Summary:''' Short description of the project
> >
> > Detailed description of the project that explains the general idea,
> > including a list of high-level tasks that will be completed by the
> > project, and provides enough background for someone unfamiliar with
> > the code base to research the idea. Typically 2 or 3 paragraphs.
> >
> > '''Links:'''
> > * Links to mailing lists threads, git repos, or web sites
> >
> > '''Details:'''
> > * Skill level: beginner or intermediate or advanced
> > * Language: C/Python/Rust/etc
>
> =3D=3D=3D Asynchronous request handling for virtiofsd =3D=3D=3D
>
> '''Summary:''' Make virtiofsd=E2=80=99s request handling asynchronous, al=
lowing
> single-threaded parallel request processing.
>
> virtiofsd is a virtio-fs device implementation, i.e. grants VM guests
> access to host directories. In its current state, it processes guest
> requests one by one, which means operations of long duration will block
> processing of others that could be processed more quickly.
>
> With asynchronous request processing, longer-lasting operations could
> continue in the background while other requests with lower latency are
> fetched and processed in parallel. This should improve performance
> especially for mixed workloads, i.e. one guest process executing
> longer-lasting filesystem operations, while another runs random small
> read requests on a single file.
>
> Your task is to:
> * Get familiar with a Linux AIO interface, preferably io_uring
> * Have virtiofsd make use of that interface for its operations
> * Make the virtiofsd request loop process requests asynchronously, so
> requests can be fetched and processed while others are continuing in the
> background
> * Evaluate the resulting performance with different workloads
>
> '''Links:'''
> * virtiofsd repository: https://gitlab.com/virtio-fs/virtiofsd
> * virtiofsd=E2=80=99s filesystem operations:
> https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/passthrough/mod.rs=
#L1490
> * virtiofsd=E2=80=99s request processing loop:
> https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/vhost_user.rs#L244
>
> '''Details:'''
> * Skill level: intermediate
> * Language: Rust
> * Mentors: Hanna Czenczek (hreitz@redhat.com), German Maglione
> (gmaglione@redhat.com)

Thanks, I have added your project idea to the list:
https://wiki.qemu.org/Google_Summer_of_Code_2025#Asynchronous_request_handl=
ing_for_virtiofsd

Do you want to give any guidance on which crate to use for
asynchronous I/O? Do you want async Rust (e.g. tokio) or not?

Stefan

