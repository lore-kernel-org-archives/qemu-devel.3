Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AD7C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC7G-0001xZ-Mt; Wed, 29 Jan 2025 12:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tdC7F-0001xQ-RX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:44:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tdC7C-0004GY-LM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738172674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AvgUszk41nkDWz7o/qDLFKe7j0Xtk/wXXBraGwlaMug=;
 b=br/+EJxr7Y5Mu1ZkKYHW+0a0n68ZqS20OJ51iD4zpUBWlaEAqh/I9yPnNsiptqBlp1iRIb
 dLF0KqbpTv/7tDPMZ/Dmm2ucvCPznJ++T388+xWG+JrqbhA3bKc5q5CEIFsB2hTQ+Ci3GG
 glyqgr9UmsbqgP1ppScE1rRkIrJKK78=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-0V8ZsTg1OdurHNiy0AoPEg-1; Wed, 29 Jan 2025 12:44:32 -0500
X-MC-Unique: 0V8ZsTg1OdurHNiy0AoPEg-1
X-Mimecast-MFC-AGG-ID: 0V8ZsTg1OdurHNiy0AoPEg
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e549c458692so18306394276.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172672; x=1738777472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AvgUszk41nkDWz7o/qDLFKe7j0Xtk/wXXBraGwlaMug=;
 b=FUtmD6b0vKHzqRiJOe93nDmYv2gMvrMDBBKePvG0Z1UZMP9MCQkqXkBI75QLAWK3Is
 ygsN+M69QuKSI0qxzXpy1S+c7JgT0jIHfmb2jDjWlxTjM7ZfeU6btblW/MDV0vsOkTQD
 hseL5NQ4CWC/eRWSw7d45Ou101okc4qzxpGDjBjCvY3Msev1Ziku3bwf54WH3fB3sswT
 2Z0qh1RVf1gH5VAmei7Y23skn/FbYhHTNSERibCyM6S9oQ+bumrnND6jt2HdvvGmawDe
 6RRVzmddmyUhY+9ayN1D4Ou/atgmpndP1sJZFkO6651ri/Hr7839I5rFjdthIJr+MRhJ
 m9og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe1283t37cxmpGwCV9dx7Rxx8So2ZndkT7wBOCNFKjSYw62/pgpuMvJdr9P4PJpD/hUVoivS5HJoDL@nongnu.org
X-Gm-Message-State: AOJu0Yz6kQ4qpABDhM1W9soTQkIIb1iOsY3nVKROHnkaxSd/EaLBNGp3
 XEBxtoJPTPJSIbv5yOqnNyOhJsharIp0yU1Rch4RuVIjtDv0xA7x1/8kEKhpiJKov22Pfq0mFRj
 m2gPnd8QAornSGrRx9cJKT2SMD4wQX7yFCeo/VVIlKhh1B4zfgmMflmYmnMi68VPW2AYcMLVxnw
 /7rxZ+/vujeCaMPxqYeSGdVsfi35U=
X-Gm-Gg: ASbGncvgxHP/zstyXWHWCDhfFAAvOzlMZFAfOL04PiTKgmrgIbPnSiU26tbwYacTkaA
 r6adaBcX6P3jOX32o4vVxcOoiXm/7T3dIZZqg7daIyif07tIqI3t3oLTt4SDcZIk=
X-Received: by 2002:a05:690c:6f85:b0:6f5:3944:c726 with SMTP id
 00721157ae682-6f7a834bbd3mr33241837b3.11.1738172672114; 
 Wed, 29 Jan 2025 09:44:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1ZgqO2ZYFZL0AUNRkowurFyg6L8O18hZ1EdDCylfT9QJU5trPnIGHCxiksuW62fCR2brpmmfhIDBezbc1nPY=
X-Received: by 2002:a05:690c:6f85:b0:6f5:3944:c726 with SMTP id
 00721157ae682-6f7a834bbd3mr33241397b3.11.1738172671648; Wed, 29 Jan 2025
 09:44:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
In-Reply-To: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 29 Jan 2025 18:44:20 +0100
X-Gm-Features: AWEUYZkcXPafEx1u8FOKvY918kij3TPHmMPR0ZoE_pAFlRUBOw1ltp8b0p_yirg
Message-ID: <CAGxU2F7oh+a7nZp9MLh67ghKtkwFvHRNqNvFqjgVhBhbe4HK2w@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Rust-VMM Mailing List <rust-vmm@lists.opendev.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>, 
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
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

+Cc rust-vmm ML, since in past years we have used QEMU as an umbrella
project for rust-vmm ideas for GSoC.

Thanks,
Stefano

On Tue, 28 Jan 2025 at 17:17, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code internship
> program again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email by
> February 7th.
>
> About Google Summer of Code
> -----------------------------------------
> GSoC (https://summerofcode.withgoogle.com/) offers paid open
> source remote work internships to eligible people wishing to participate
> in open source development. QEMU has been doing internship for
> many years. Our mentors have enjoyed helping talented interns make
> their first open source contributions and some former interns continue
> to participate today.
>
> Who can mentor
> ----------------------
> Regular contributors to QEMU and KVM can participate as mentors.
> Mentorship involves about 5 hours of time commitment per week to
> communicate with the intern, review their patches, etc. Time is also
> required during the intern selection phase to communicate with
> applicants. Being a mentor is an opportunity to help someone get
> started in open source development, will give you experience with
> managing a project in a low-stakes environment, and a chance to
> explore interesting technical ideas that you may not have time to
> develop yourself.
>
> How to propose your idea
> ------------------------------
> Reply to this email with the following project idea template filled in:
>
> === TITLE ===
>
> '''Summary:''' Short description of the project
>
> Detailed description of the project that explains the general idea,
> including a list of high-level tasks that will be completed by the
> project, and provides enough background for someone unfamiliar with
> the code base to research the idea. Typically 2 or 3 paragraphs.
>
> '''Links:'''
> * Links to mailing lists threads, git repos, or web sites
>
> '''Details:'''
> * Skill level: beginner or intermediate or advanced
> * Language: C/Python/Rust/etc
>
> More information
> ----------------------
> You can find out about the process we follow here:
> Video: https://www.youtube.com/watch?v=xNVCX7YMUL8
> Slides (PDF): https://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
>
> The QEMU wiki page for GSoC 2024 is now available:
> https://wiki.qemu.org/Google_Summer_of_Code_2025
>
> What about Outreachy?
> -------------------------------
> We have struggled to find sponsors for the Outreachy internship
> program (https://www.outreachy.org/) in recent years. If you or your
> organization would like to sponsor an Outreachy internship, please get
> in touch.
>
> Thanks,
> Stefan
>


