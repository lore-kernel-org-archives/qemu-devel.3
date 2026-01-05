Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF40CD0412
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcsQp-0002R6-GP; Mon, 05 Jan 2026 16:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vcsQP-0002NU-46
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:47:54 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vcsQN-0005KD-3b
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:47:40 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so600073a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767649655; x=1768254455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xwq/+u1snyOM2qlXuEWFVd7bVZejAJMruGaE8Htw3t4=;
 b=QufII6KHv+LKZKCxrCcjYNC3wEiDR0LUBA9wExqQgO+ZZ4tllDw9Kb66BsHlSYVfXy
 82/saSr9xQ++9yCPoZVUi4DJluizViDSa0ERYZSmEpDS9vcQcfLYC7b4Jm1+mkZXq4+B
 ii4wS1uW4uVohWtuamI1Rs6dnRa2Yg3jgnZeYnFQucft+wIBdxOH8dt10GFgS9qmWVQg
 Ptz8e+WVUfChGFz3V3zHHfJfc9Hqu91qjjYc4yyLexoK6ezqfWYEEWYMsG5WqUxcZFgT
 6U5xEBfXTW2x+RpQ23efv64z9p0F9s36+7h/bLzWAge1FYWMwXyTj5qzLidmb5MdNbvK
 l7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767649655; x=1768254455;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwq/+u1snyOM2qlXuEWFVd7bVZejAJMruGaE8Htw3t4=;
 b=h38kyi9cAyzJrRWTlLdpb/vUSzO2+I/WnX5h4y86LBGAKNj86MmaWgScKwaXKjs6lr
 IcluJleR1z2rBEWrCikQt7mE+n81fW/+chFSm76T+L3kSQXN2Bd7+Nr1R+Pmi4ebbW8X
 uCxa560CvgxxpjRzlZIMM7NgS/EEi2/ZursEutK4XlU+TXffsEG3dXoVX2oCxkwWY1FC
 l+1DuVtkk5JeHPFjlPNNYI+6YrnYGhA9Fc0iTdIfN2Z2q6X3Z/LM31Twz0r+dKirsN93
 7+Z4ra9GPJbGSOCCIJbw9Q6EMW9eKRwJ8LkXQpn8xZrY9h6xNTW7Zik/6pFwepwjQY+G
 ijsw==
X-Gm-Message-State: AOJu0Ywpu6uE4y+FTZgOArNYi7JCTpCgA4QrOGPnaEbdE9oc//0QqCbY
 FrBl4CLSy+9su/juKWUOzSVIlIt6yc1HRDK0OYhwum6BkDWkac7PvOxzvXk5cMgT+7TUdUHm05o
 UqceoL0pM7Dagmrz0uUOz+S7KAH8Y5kqoVA==
X-Gm-Gg: AY/fxX4CX6YhaxE3gYOJdtqoH3oYOvoGcr3mJhDyaXfJ35OIJFhANGL+qIh37A8l6oH
 bqNf2yglfLd4PCOdZVaywYsFewE5UCMkV7HNTpHCuGzgJksZCt6dBvVPdC2HyHbBWzMmu3YwS+3
 725vYYLwUXAWmrg+lWshK6TcI/eBz8r/Dkz0uhhyu0Zbvgb4hqroIofp/TkalOPIeVU+5EdBZOC
 btCBpdZ4t+VmlvKBwhfmSmqG7d4wDbv9FLVDv7BSfUFr/WiL3WUwNyfJt/0FPvROeNGPw==
X-Google-Smtp-Source: AGHT+IGzqMPIvjpm/BPRALlmRdcbNGNJ9j3aeCDnc9DqBiLhI9CAlWRiqsR+98pXwIxsqy5E6mdSnJ1nvl71RajfhBE=
X-Received: by 2002:a05:6402:2792:b0:641:2cf3:ec3e with SMTP id
 4fb4d7f45d1cf-6507931fd53mr740163a12.11.1767649654614; Mon, 05 Jan 2026
 13:47:34 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 5 Jan 2026 16:47:22 -0500
X-Gm-Features: AQt7F2rKVguptLS0_HGBM_cWisOO9Z59HcS_ZCk33hJtwl63lB_QQNWyrYq4Wfo
Message-ID: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
Subject: Call for GSoC internship project ideas
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

Dear QEMU and KVM communities,
QEMU will apply for the Google Summer of Code internship
program again this year. Regular contributors can submit project
ideas that they'd like to mentor by replying to this email by
January 30th.

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

The QEMU wiki page for GSoC 2026 is now available:
https://wiki.qemu.org/Google_Summer_of_Code_2026

Thanks,
Stefan

