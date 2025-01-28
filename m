Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5054C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoH1-0001I9-1f; Tue, 28 Jan 2025 11:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tcoGv-0001Gf-OZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:17:05 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tcoGo-0003Gv-Lq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:17:05 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6274015so10854726a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738081016; x=1738685816; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3LQ/ClTRLQHNt4BKzJFSQ1S6KMu6e4COGZ7nkXwwF2I=;
 b=jY5HeY/5QaVwC+EWTmI1JZhoJsuRilePsC3TaU09BuTBgVb585kk5MZ2sKjSzWsXlx
 wMp0/1J+gloU9tRa8AFqFMm0hehh9xC722pCMrsJvm0nr8HKHEUqpysT6BOWqK869oSq
 ghQ7c0I48adNk69dNbVYql+rDEYJtFrIYbvDtqY/tr2gX0jZAHCFxy5WHELmOtlshcM3
 eWCpMgnlwfjZ49Dl0NGj1Mh9t7kELeISkJSdo/x2by2imFUvJFaal6MxCCO/sfuhzJlX
 btIvR51eK8yI5mrj1L1xN9XbzW9xJ1EmxQf6Ildtt0moaLC9HcsgW03xfdY12vVgwQEE
 6PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738081016; x=1738685816;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3LQ/ClTRLQHNt4BKzJFSQ1S6KMu6e4COGZ7nkXwwF2I=;
 b=sLSkd2j8Wf4g6/29EbMUQKhCFY+DYzY2DXyQiBSNxcZD8y5dXGWrDa98O08olkY9Qk
 gDZYEO3wxxPYbLpwQaZF0H3dd6kMrjWwtl1MmnR1DK9HXYm6F+K2Qpo22OrhmAWYBKDw
 lYWdmiIAm2+a1jJwjSrhc0rVSd7pSSlsrd4cB9RaDUb8Brp0n8uuPMZ8OKQ48mODlWdr
 P0CCQPFpuFUqOb5o5+x2y9+Id6T+1coXVVFtctdAeaTc2PwgOO1oKF8B9O0ABy+nERhh
 sQukrst/sOoDUiVpbDIDNNxZyNF772+YSlxdU5sC7uUmqx+ibK5ne7HA2Wjw1Uf6A1rP
 Zk4w==
X-Gm-Message-State: AOJu0YyaLhTY6WVGa7yLUD1f302bRGvqGQtIP8x3meoU6ttdwIQvrz48
 SGWqbQ+MmnK7ILCRZ1OlRGLRObwB907zP/1u2PbrEkMlzUFScXGPZB50UghVk9cP+dJZVtgSzLO
 Sr4RcbOeEPnn3ESSOrkeU1jS9xUxByo97
X-Gm-Gg: ASbGncuViC2NoJi2U3Zrss1UMrj1MYsy6nLiDUWIowa4vy8yeg/YtZ/8o5gw6+eCbjl
 i+S8CMRgXWkDnfi+xCFHA57wBNdcUqHTSZX2LyXohP9QBFMlUiIyrHzTH5aT8vgorTcJ4+ao=
X-Google-Smtp-Source: AGHT+IGngLilCkICpFdFa6Vm437XBCWWwcasw+Elf7wFv6/VQJdMbOLWzcjCVg/H+uh/2YDurB3D04hfy2p3poSvAJE=
X-Received: by 2002:a05:6402:51d3:b0:5d1:22c2:6c56 with SMTP id
 4fb4d7f45d1cf-5db7d318a90mr41206988a12.17.1738081016306; Tue, 28 Jan 2025
 08:16:56 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Jan 2025 11:16:43 -0500
X-Gm-Features: AWEUYZkrZf4SPzQFoSAMMjj0I90DjwDlrKYXqyZ3YgDtCPyHRXPw_rrlon-LEvY
Message-ID: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
Subject: Call for GSoC internship project ideas
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
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
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Dear QEMU and KVM communities,
QEMU will apply for the Google Summer of Code internship
program again this year. Regular contributors can submit project
ideas that they'd like to mentor by replying to this email by
February 7th.

About Google Summer of Code
-----------------------------------------
GSoC (https://summerofcode.withgoogle.com/) offers paid open
source remote work internships to eligible people wishing to participate
in open source development. QEMU has been doing internship for
many years. Our mentors have enjoyed helping talented interns make
their first open source contributions and some former interns continue
to participate today.

Who can mentor
----------------------
Regular contributors to QEMU and KVM can participate as mentors.
Mentorship involves about 5 hours of time commitment per week to
communicate with the intern, review their patches, etc. Time is also
required during the intern selection phase to communicate with
applicants. Being a mentor is an opportunity to help someone get
started in open source development, will give you experience with
managing a project in a low-stakes environment, and a chance to
explore interesting technical ideas that you may not have time to
develop yourself.

How to propose your idea
------------------------------
Reply to this email with the following project idea template filled in:

=== TITLE ===

'''Summary:''' Short description of the project

Detailed description of the project that explains the general idea,
including a list of high-level tasks that will be completed by the
project, and provides enough background for someone unfamiliar with
the code base to research the idea. Typically 2 or 3 paragraphs.

'''Links:'''
* Links to mailing lists threads, git repos, or web sites

'''Details:'''
* Skill level: beginner or intermediate or advanced
* Language: C/Python/Rust/etc

More information
----------------------
You can find out about the process we follow here:
Video: https://www.youtube.com/watch?v=xNVCX7YMUL8
Slides (PDF): https://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf

The QEMU wiki page for GSoC 2024 is now available:
https://wiki.qemu.org/Google_Summer_of_Code_2025

What about Outreachy?
-------------------------------
We have struggled to find sponsors for the Outreachy internship
program (https://www.outreachy.org/) in recent years. If you or your
organization would like to sponsor an Outreachy internship, please get
in touch.

Thanks,
Stefan

