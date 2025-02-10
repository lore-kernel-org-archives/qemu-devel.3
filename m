Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51871C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thVC1-0002D2-Ug; Mon, 10 Feb 2025 09:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thVBz-0002CS-P5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thVBx-0003kT-K3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739199318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FpnWOWPEUPvBwbJvUaGay5WJ38UwPsGX1ZB/3JNKjuY=;
 b=XO6TrwHSry2eukz7IJ3FpLCOXSwpT9crnIFoD/jJfLm4sDHGxDpIUQAjt+3QkAInnASbsy
 q+RSmXzK2ts+QYUD0kEyL9DwMv49a2JU4JOTWUejs4kiV6OD7nK7BjB4XxvJMvhmi1g0Fm
 6Ex/nj0GNpBSaFZUXdPMb2zrMsvKkIY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-O20Kc5yiMJe4zNfqVG1M_Q-1; Mon, 10 Feb 2025 09:55:17 -0500
X-MC-Unique: O20Kc5yiMJe4zNfqVG1M_Q-1
X-Mimecast-MFC-AGG-ID: O20Kc5yiMJe4zNfqVG1M_Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so5941475e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739199316; x=1739804116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpnWOWPEUPvBwbJvUaGay5WJ38UwPsGX1ZB/3JNKjuY=;
 b=HsXPER4mOylExj1V8i1zFfzBpK4dmspdZk4XC/P7/amADsRIc2tIzi2BMDfOLT3iV7
 3GIu1sao2or9fhV5PkOyYxGExDHg9Yv8dFyZ/Gc3UzS1aiedHQM7ritTmivSul8OoZNm
 f5IiR/yThCFLKmAc/KvmZZiUkVUpQ7Q4P/xfdXb3eDqxBqgRRtCbrpU5nHjhQ0m7mnN8
 GDYWQbshmUbQKTNEVOxIQ1K3UjrMd2vNfprx6+z4HuQKaiR5oj715iX5bpRkyG4PyonC
 bxcbEW5a3RXPIOHdlC3ySDslSoX/Gcb6vE1hAt2lcWSGlwzdLf2JE9YDvoP3EChKlOkT
 zdUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUdZQhwjY07tDmmJUHRBoxbfJp7T5kZkWgp0QptqGW8PsLOFsopij9Rh8fktWrZov5o5y7c8LYOHKH@nongnu.org
X-Gm-Message-State: AOJu0Yz4TDBG85Ob6+DODIEQU6BelVpCi15aDoBO9j5uGmSyM+X39tze
 btx6KM/066Kpp8StoLWV7EXO1yhJX78hnXg2dNl1s6/izC3sufdYdP1AdyXseQGGopiF0hmR/ab
 zwbUIeNSscbWHDqFfdNjDJ/bdkOF0jKGsPmVtzRCyQUhxVqq4W3PH
X-Gm-Gg: ASbGnctkVc8vkSNb2DBo7m/zS0kUEbs/7VLhocHjJDiVOds9WiBTDATY2KqHbkbzTNx
 2rOSW3pVxEUdsEiyWxSVmLYayjnh0dbS2r6+RLkBy1ZKpMIDGVx7SYe5ueLfwTqV5AdQ+xTVEy7
 aaX2eokEELn2OC2pe2zCyRkay6LQY+bLIyaGMbLk0BtpRa5nM8CpLDlUmNOX/G9xNS21cKHAHZK
 JTc/7ez26SfzmZGwithjf24/rQE++6IzsEG27SP6tn7Zz4/tlCD26yMDRXoMy2HLEoxSRJ6AZDI
 upUFL0yjNrAO0sHduxoTTz1iZLuznn1sbiCq+DqoOTN+enLWJ+zUDg==
X-Received: by 2002:a05:600c:468e:b0:439:47dc:e383 with SMTP id
 5b1f17b1804b1-43947dce501mr26688215e9.12.1739199315992; 
 Mon, 10 Feb 2025 06:55:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHye52RagamrPb2qBwPmsx0NeC9lhy00tq28FyXcEeKzgvbmb9HS4KAS2R6WgeVH+4xIt3mDQ==
X-Received: by 2002:a05:600c:468e:b0:439:47dc:e383 with SMTP id
 5b1f17b1804b1-43947dce501mr26687745e9.12.1739199315220; 
 Mon, 10 Feb 2025 06:55:15 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394328fcb8sm38662665e9.32.2025.02.10.06.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:55:14 -0800 (PST)
Date: Mon, 10 Feb 2025 15:55:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, 
 German Maglione <gmaglione@redhat.com>
Cc: Rust-VMM Mailing List <rust-vmm@lists.opendev.org>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <CAGxU2F6mP7KfytKUQSoqvbmLyR2DRDVdmT1Gtyq=gOFv69CDXw@mail.gmail.com>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <CAGxU2F7oh+a7nZp9MLh67ghKtkwFvHRNqNvFqjgVhBhbe4HK2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F7oh+a7nZp9MLh67ghKtkwFvHRNqNvFqjgVhBhbe4HK2w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Stefan,
Sorry for the delay, I attach a proposal!

On Wed, 29 Jan 2025 at 18:44, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> +Cc rust-vmm ML, since in past years we have used QEMU as an umbrella
> project for rust-vmm ideas for GSoC.
>
> Thanks,
> Stefano
>
> On Tue, 28 Jan 2025 at 17:17, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code internship
> > program again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email by
> > February 7th.
> >
> > About Google Summer of Code
> > -----------------------------------------
> > GSoC (https://summerofcode.withgoogle.com/) offers paid open
> > source remote work internships to eligible people wishing to participate
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


=== vhost-user devices in Rust on macOS and *BSD ===

'''Summary:''' Extend rust-vmm crates to support vhost-user devices 
running on POSIX system like macOS and *BSD

VIRTIO devices can be emulated in an external process to QEMU thanks to 
the vhost-user protocol, which allows QEMU to offload the entire 
emulation to a daemon. This is done through an AF_UNIX socket used as a 
control path between the frontend (i.e. QEMU) and the backend (i.e. the 
vhost-user daemon). QEMU will share guest memory with the daemon, 
provide all the information for data path setup, and notification 
mechanisms.

Moving the emulation of VIRTIO devices to a separate process from QEMU 
offers significant advantages, primarily in terms of safety, if a device 
crashes, we can restart it without affecting QEMU. Additionally, this 
approach simplifies updating device implementations, allows development 
in other languages (such as Rust as we do in the rust-vmm community), 
and enhances isolation through seccomp, cgroups, and similar mechanisms.

The rust-vmm community already provides several crates (e.g. vhost, 
vhost-user-backend, etc.) to implement a vhost-user backend in an 
external daemon. For example, these crates are used by virtiofsd 
(virtio-fs vhost-user device) but also by all vhost-user devices 
maintained by the rust-vmm community in the rust-vmm/vhost-device 
workspace. These crates work great on Linux, but unfortunately they use 
some Linux-specific system calls such as epoll(7) and eventfd(2) that 
make them impossible to use on other POSIX systems.

The goal of this project is to make sure that we can use rust-vmm's 
vhost and vhost-user-backend crates on other POSIX systems besides 
Linux. If time permits, we could also fix up simple devices such as 
vhost-device-console or vhost-device-vsock to run on any POSIX systems.

'''Tasks:'''
* Becoming familiar with QEMU and vhost-user devices
* Run QEMU with a vhost-user device on macOS or FreeBSD/OpenBSD as 
covered in the FOSDEM 2025 talk
* Analyze rust-vmm crates (vmm-sys-util, vhost, vhost-user-backend) to 
understand which components are Linux-specific
* Replace epoll(7) with alternatives such as 
https://github.com/smol-rs/polling
* Automatic fallback to pipe()/pipe2() if eventfd(2) is not available as 
QEMU already does
* Handle any other cases discovered during the analysis
* Adapt a simple device such as vhost-device-console or 
vhost-device-vsock to test that everything works on macOS or 
FreeBSD/OpenBSD

'''Links:'''
* FOSDEM 2025 talk: [https://fosdem.org/2025/schedule/event/fosdem-2025-5100-can-qemu-and-vhost-user-devices-be-used-on-macos-and-bsd-/ Can QEMU and vhost-user devices be used on macOS and *BSD?]
* [https://qemu-project.gitlab.io/qemu/interop/vhost-user.html vhost-user spacification]
* [https://patchew.org/QEMU/20240618100043.144657-1-sgarzare@redhat.com/ QEMU series to support vhost-user on any POSIX]
* [https://gitlab.com/sgarzarella/qemu/-/tree/macos-vhost-user sgarzare's tree where to find some missing QEMU patches]
* [https://github.com/rust-vmm/vhost rust-vmm vhost & vhost-user-backend crates]
* [https://github.com/rust-vmm/vmm-sys-util rust-vmm vmm-sys-util crate]
* [https://github.com/rust-vmm/vhost-device rust-vmm vhost-device workspace]
* [https://gitlab.com/virtio-fs/virtiofsd virtio-fs vhost-user device]
* [https://github.com/rust-vmm/vhost/issues/110 Mac build support #110 - rust-vmm/vhost]
* [https://gitlab.com/virtio-fs/virtiofsd/-/issues/169 Add macOS support #169 - virtio-fs/virtiofsd]

'''Details:'''
* Project size: 350 hours
* Skill level: intermediate
* Language: Rust
* Mentors: Stefano Garzarella <sgarzare@redhat.com>, German Maglione 
<gmaglione@redhat.com>


Thanks,
Stefano


