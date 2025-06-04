Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6FAC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnuK-00025w-KW; Wed, 04 Jun 2025 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMnuJ-00025d-73
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:11:51 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMnuG-0002ZL-5G
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:11:50 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-604b9c53f6fso3041536a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749042704; x=1749647504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z/gNYpNj9bOP6fZHD3VN0jyaVmORhn6X2CEboAKjZs=;
 b=GjhCV9Ve0BncLS/i5uoMbAiLI/ENjI6NmryzQjagDD5ZaYKjKI60pzFHdN+q11nypz
 Eq+zrR6Hu1TkPGxCMglE5P3aX6tvJjZaxEiEEqJ05Xb8SaH20Qu55ZUgmfCIYP6Qk63z
 v5k9IbQkvQrLmbe/YvALhhVjo46jnBnzpH+Usiv0ExaHSNm2JF32s8H/aVv7ejZ+MdxW
 HlwdDz4hMLbbKmAuly4uVlPMqMC/392hn+Ux8iZHVcdxVFgmWuvHWNoEpr0V6no8FSDK
 m4HGCPvcmWs/P1LEqvEUvFz7zQ4cM5N+8E0CyM6C0pb7z8Wj3nK+hYeBp9KhZc+4a76K
 I4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749042704; x=1749647504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9z/gNYpNj9bOP6fZHD3VN0jyaVmORhn6X2CEboAKjZs=;
 b=mk/vDhjxFweKMJvuHBDawxGMvyrxyPLKP8WCZQpw55s8vZtpgyEYnRmJJNkk42Bgmu
 WkfkRCyX5ZqXeMKCmFvYa+QeBQmepDEHGXe2MbUfmAjUncZHzmQpcn8wuS0QYoXvriuG
 Vjmy+hTOTaOyBv3RUZBro6jDmhms6QVZ/jT/N4jWyJ25JKkb30tFL7yueuWmP55hg395
 +NT8COZahES5Uk5TE0PG6QpGMG9ozyQa0PHgOa2SjDuSf9p7Bk96Q45HmyRkEypjr8nJ
 zOJvaIhfrpKjDZ8znYUbYTcWYAOcWEzb/YuRt29oNxszBTWvZ/SjESYBpyWQvnM06Px9
 hEBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeVAFC0MbgSQPD6SdEo+aR+DAlxp20PoXzZwchVGafERzICXLYUa/sOp+/XblBgLMPdBsJOPJx27+n@nongnu.org
X-Gm-Message-State: AOJu0Yw2Kw90is1iG307YlI3GWSbvDjIsu5NoEqYBaNXxBun5gGOirYG
 m441aQRRwR/m9j15yspxhLSQ4YPzv4IOAnCUpIOjH1W57zudam7U6uhdkNp9vtROBuTurCIOZV5
 sbBa64xPPaq0K047FYX4mne0Y3B5smQtmxDA9
X-Gm-Gg: ASbGncvmVmOipPielbl3uh1tSwGjB0JUfDwRL7tyvnvE4SYBWHfhHB3mtxQ/67xm3WS
 PpefUvk6CPFxk1omDBDVkRseY5nlQo9PveWenmhrMGGDoWWH2w9hEhQnFTYfkvFBJwYYNm9xl5B
 xsEVQyAMcX3kvfef3n3c9lGASOk/hdwjo=
X-Google-Smtp-Source: AGHT+IGf8WmyHnsbcDSYV8bX6GWXfNCYCHORT9SjKvSTpEqDY/uZoYe94iFjSU50r7sMrPyK34YFQ4x8Efs5B8/LHNw=
X-Received: by 2002:a17:907:60ca:b0:ad8:89c7:2735 with SMTP id
 a640c23a62f3a-addf8fe2d0bmr265780466b.58.1749042703937; Wed, 04 Jun 2025
 06:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250528100507.313906-1-thuth@redhat.com>
 <CAJSP0QUpxsVEMEDT8opTZrhs6oFfFJk+jUqdR-dZL=TzQcYbWg@mail.gmail.com>
 <34256440-efd5-4395-8eab-49ca5bbe0377@redhat.com>
 <fa5f0538-9c66-46f1-b65d-d723d2006716@yandex-team.ru>
In-Reply-To: <fa5f0538-9c66-46f1-b65d-d723d2006716@yandex-team.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Jun 2025 09:11:31 -0400
X-Gm-Features: AX0GCFtVn7RnOFVOEQyZORhjM9GuMMu0buvY2toq1ZH9bs503MBFvWmTNbXdJSc
Message-ID: <CAJSP0QX8pXNE7SL8hAOHStJy+ZYdhF9bzWX95Qts9hk6vgKseg@mail.gmail.com>
Subject: Re: [PULL 00/27] Functional tests,
 Microblaze endianness & pc/q35 cleanups
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Jun 4, 2025 at 3:51=E2=80=AFAM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
>
> On 5/29/25 01:12, Thomas Huth wrote:
> > On 28/05/2025 21.23, Stefan Hajnoczi wrote:
> >> On Wed, May 28, 2025 at 6:12=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>>
> >>>   Hi!
> >>>
> >>> The following changes since commit
> >>> 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:
> >>>
> >>>    Merge tag 'pull-aspeed-20250526' of
> >>> https://github.com/legoater/qemu into staging (2025-05-26 10:16:59
> >>> -0400)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-28
> >>>
> >>> for you to fetch changes up to
> >>> 9c2da02e184fddfa7cd7d7813455c2306daae99a:
> >>>
> >>>    tests/unit/test-util-sockets: fix mem-leak on error object
> >>> (2025-05-28 11:59:47 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> * Functional tests improvements
> >>> * Endianness improvements/clean-ups for the Microblaze machines
> >>> * Remove obsolete -2.4 and -2.5 i440fx and q35 machine types and
> >>> related code
> >>>
> >>> ----------------------------------------------------------------
> >>> Alexandr Moshkov (2):
> >>>        tests/functional: add skipLockedMemoryTest decorator
> >>>        tests/functional: add memlock tests
> >>
> >> Hi Thomas and Alexandr,
> >> The memlock tests are failing:
> >> https://gitlab.com/qemu-project/qemu/-/jobs/10181084830#L5421
> >> https://gitlab.com/qemu-project/qemu/-/jobs/10181084865#L5476
> >>
> >> Please take a look and send a new pull request. Thanks!
> >
> Hello! I think Stefan forgot to CC me in his reply. Only now find this
> message)
>
>
> > According to the log:
> >
> >  Output: qemu-system-aarch64: No machine specified, and there is no
> > default
> >
> > I think it likely does not make sense to run this test with the
> > aarch64 target... Alexandr, would it make sense to limit this to x86
> > only?
>
> It looks like adding this lines to vm creation fixes all problems with
> other targets on memlock test:
>
> self.set_machine('none')
> self.vm.add_args('-nodefaults')
>
> What's the convenient way to fix it? Resend a new patch?

Hi Alexandr,
Sorry I forgot to CC you. Since the patch in question hasn't been
merged yet, you could send a new revision of the patch and Thomas
could include it in his next pull request. That way the fixed patch
will be introduced in one commit rather than a broken commit followed
by a fix.

Stefan

>
>
> Best regards,
>
> Alexandr
>

