Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9940C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOnd-0005rd-Kr; Fri, 07 Feb 2025 08:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgOnc-0005rT-5M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:53:40 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgOna-0000B6-2Y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:53:39 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dcd3454922so4337355a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 05:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738936416; x=1739541216; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtalgheXKmmwKmBzYHbvxnL6JBWnZc1Jj7kO28s2paA=;
 b=G3v1tpdlo2MeFwONwAz4KI7mB3Wx36GckG55e/Q7IrQu6EfTSkhkJgaGapcK/LaPaW
 gWcWALDOFrut4HWxcTjSmiJF8ewYnX8aSYXf3Ip4pVIvrzwQuV4SJ3KQdOo5S9Z6G071
 j+x9UNgQaVoJCspFXTcu5ApHPaAqysadS/gJlo4z5073dGYOSSddLYg6h3qhycI7OsDQ
 RzjV1FOzJ4hNJF7CGWm9JU3n3fte+29JpNUjtR2dL4bWe2mfieg/emimGg/j3SCZ7MEO
 rwCH3OscjWwR/DJvVtJCEk8+oc5lPZTMCjIZNKVnr5E92nfxlfhqMKAfI3K6biDnuUdK
 O3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738936416; x=1739541216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YtalgheXKmmwKmBzYHbvxnL6JBWnZc1Jj7kO28s2paA=;
 b=DL3a+ECXc/wsqXelbZEwaP+Y8q0hwD+PD5cs6M9IGyd3Fy8AGODJHmeeAFkMItx4cB
 wf+hkWxXhRm7Snm/ae1V02WhpoUTXtVRMM2/m6+87CJWgq2aTYNJWA4W08vAdjnc2eP2
 HYk8oVo0D24uiFEMU60mlHxXO7VxdfiS7hozeCQS1rNhvr+idH+HOfc+uZq4ooLizKYM
 VVzdMRVl++37EP1zyLteFYH3SwXz9j4f8VKLcIrYKmwOnRn8Z6juzdtkz8mX3bmqjWSB
 eiJpf1z+h55q6etRlA2UYiPqBBAOhVP87T28cCAe9FrCOHdXrr8bNyV30Ayij7IW1I9r
 mq9g==
X-Gm-Message-State: AOJu0YzcQNvzuItkDjYI7qtR0DfK8ZijvSAOhCXySDp6k/D6HnEm6SOE
 BAWGp2U2Vagz3R+jddu9a+pw2yd7yF0K2NChb8+cE64VTuoJi8fD/zGhLBBgf4SvMiQ/HkUyQDr
 AmpCLP5bf4Cxjp05L2KdivDyv558=
X-Gm-Gg: ASbGncs7vv5sbbRwf5f9M7hKdcs4dEBZPqSAik3u8t9+8kfzO/uXm7Z2KJFl5Qz3qc5
 0qpi+ecYzk4ZFM6TcyunCPBtqfClywADWDsDcf9PqSGqJFzNgfFMttWCpgIUcMNSYblZwm2U=
X-Google-Smtp-Source: AGHT+IHhJ6EufNqZ9kksKQN32e85opCmp2dsk4tK7kNAAYdhEh4dZtkiAHMYtw76NJ5+s84Ws020zRy2m3FOAjkovQc=
X-Received: by 2002:a05:6402:27d1:b0:5de:4add:d52f with SMTP id
 4fb4d7f45d1cf-5de4adddbcemr2328072a12.32.1738936415541; Fri, 07 Feb 2025
 05:53:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <f3639df5-05cf-4aef-adfc-8a39ed7767ce@redhat.com>
 <CAJSP0QUOzyqE16HL+QfXqQA3oZQ=4b=nt4_8JkoSSx5U_b7MsQ@mail.gmail.com>
 <0a85b381-35c4-424f-9052-7b321b1afe02@redhat.com>
In-Reply-To: <0a85b381-35c4-424f-9052-7b321b1afe02@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Feb 2025 08:53:23 -0500
X-Gm-Features: AWEUYZmF04St9t2npau9CLpQvjQMuUNUa8P7KuOMPJcLIWtuOHWKqydUmhuez3A
Message-ID: <CAJSP0QWS5AVd=mDMqGkd__eNhh3pSaKu+_Hemc_Kis+b8E_veQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

On Fri, Feb 7, 2025 at 8:48=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 07.02.25 14:41, Stefan Hajnoczi wrote:
> > On Fri, Feb 7, 2025 at 7:35=E2=80=AFAM Hanna Czenczek <hreitz@redhat.co=
m> wrote:
> >> On 28.01.25 17:16, Stefan Hajnoczi wrote:
> >>> Dear QEMU and KVM communities,
> >>> QEMU will apply for the Google Summer of Code internship
> >>> program again this year. Regular contributors can submit project
> >>> ideas that they'd like to mentor by replying to this email by
> >>> February 7th.
> >>>
> >>> About Google Summer of Code
> >>> -----------------------------------------
> >>> GSoC (https://summerofcode.withgoogle.com/) offers paid open
> >>> source remote work internships to eligible people wishing to particip=
ate
> >>> in open source development. QEMU has been doing internship for
> >>> many years. Our mentors have enjoyed helping talented interns make
> >>> their first open source contributions and some former interns continu=
e
> >>> to participate today.
> >>>
> >>> Who can mentor
> >>> ----------------------
> >>> Regular contributors to QEMU and KVM can participate as mentors.
> >>> Mentorship involves about 5 hours of time commitment per week to
> >>> communicate with the intern, review their patches, etc. Time is also
> >>> required during the intern selection phase to communicate with
> >>> applicants. Being a mentor is an opportunity to help someone get
> >>> started in open source development, will give you experience with
> >>> managing a project in a low-stakes environment, and a chance to
> >>> explore interesting technical ideas that you may not have time to
> >>> develop yourself.
> >>>
> >>> How to propose your idea
> >>> ------------------------------
> >>> Reply to this email with the following project idea template filled i=
n:
> >>>
> >>> =3D=3D=3D TITLE =3D=3D=3D
> >>>
> >>> '''Summary:''' Short description of the project
> >>>
> >>> Detailed description of the project that explains the general idea,
> >>> including a list of high-level tasks that will be completed by the
> >>> project, and provides enough background for someone unfamiliar with
> >>> the code base to research the idea. Typically 2 or 3 paragraphs.
> >>>
> >>> '''Links:'''
> >>> * Links to mailing lists threads, git repos, or web sites
> >>>
> >>> '''Details:'''
> >>> * Skill level: beginner or intermediate or advanced
> >>> * Language: C/Python/Rust/etc
> >> =3D=3D=3D Asynchronous request handling for virtiofsd =3D=3D=3D
> >>
> >> '''Summary:''' Make virtiofsd=E2=80=99s request handling asynchronous,=
 allowing
> >> single-threaded parallel request processing.
> >>
> >> virtiofsd is a virtio-fs device implementation, i.e. grants VM guests
> >> access to host directories. In its current state, it processes guest
> >> requests one by one, which means operations of long duration will bloc=
k
> >> processing of others that could be processed more quickly.
> >>
> >> With asynchronous request processing, longer-lasting operations could
> >> continue in the background while other requests with lower latency are
> >> fetched and processed in parallel. This should improve performance
> >> especially for mixed workloads, i.e. one guest process executing
> >> longer-lasting filesystem operations, while another runs random small
> >> read requests on a single file.
> >>
> >> Your task is to:
> >> * Get familiar with a Linux AIO interface, preferably io_uring
> >> * Have virtiofsd make use of that interface for its operations
> >> * Make the virtiofsd request loop process requests asynchronously, so
> >> requests can be fetched and processed while others are continuing in t=
he
> >> background
> >> * Evaluate the resulting performance with different workloads
> >>
> >> '''Links:'''
> >> * virtiofsd repository: https://gitlab.com/virtio-fs/virtiofsd
> >> * virtiofsd=E2=80=99s filesystem operations:
> >> https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/passthrough/mod=
.rs#L1490
> >> * virtiofsd=E2=80=99s request processing loop:
> >> https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/vhost_user.rs#L=
244
> >>
> >> '''Details:'''
> >> * Skill level: intermediate
> >> * Language: Rust
> >> * Mentors: Hanna Czenczek (hreitz@redhat.com), German Maglione
> >> (gmaglione@redhat.com)
> > Thanks, I have added your project idea to the list:
> > https://wiki.qemu.org/Google_Summer_of_Code_2025#Asynchronous_request_h=
andling_for_virtiofsd
>
> Thanks!
>
> > Do you want to give any guidance on which crate to use for
> > asynchronous I/O? Do you want async Rust (e.g. tokio) or not?
>
> That would depend entirely on the student.  I=E2=80=99m open for async Ru=
st
> (tokio or even homegrown), but they could also decide they=E2=80=99d rath=
er do
> it in some different manner (e.g. with callbacks that would return
> descriptors to the guest).  I=E2=80=99ll add that info, if that=E2=80=99s=
 OK.

Sounds good.

Stefan

