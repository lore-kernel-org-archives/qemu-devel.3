Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643BAC02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQoE-0000Po-TQ; Fri, 07 Feb 2025 11:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgQo1-0000Ne-6c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:02:23 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgQnz-0007Bc-Du
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:02:12 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-544ff74be63so436462e87.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738944129; x=1739548929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ws/hCOjjsYOBqMg3NpBqu06i8dgOTgFvePzpBfs4tU=;
 b=UnKS3VD0nmSXFyZHklDFxRdM2X2aJ7eKVlsZcUoIYD4+SqO8hb2fFb+Am+iuPqm7Db
 0dXnCEvLLs4MMY1RL8QnZCehodW3tYDpb/QRl8r5yeGoQMX9EkQT59xEL/iKcd06yc2s
 rQSLTawiPu6cneQoz+Q8VF5UclndeH8HLsrq+SOuJsfpIP1fMH/MF4vq6xcEh+VbsHD7
 SrIad0W69fPpRwL5ojh4NnYYYDw8RQXBjgGrtvB5oIlsXa/Y/8LeA/4n++ksztlnbE1W
 gma2PYJYC6/FTRXkDUyjsEAlk5tXvsBF07yLdTGfcC+/dI4X/QfZKPqwoPzudoHxCrDK
 vQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738944129; x=1739548929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ws/hCOjjsYOBqMg3NpBqu06i8dgOTgFvePzpBfs4tU=;
 b=Kdf1oEelkkgOU8lrboljSCLg1a95l4ed+GU78ARlRM5jN/5Xb0g8t3wd/RuDXznc25
 8f+SaezqLB9WCWNA4+wsa9al7EmnBA1O4zoKV8e/Nt0cjUhRr8o5ptmpKBNLpTEVlkpE
 cXztC3vUrMSBfNIEyFbfDrULJJLeBQVm/0P4KpxuXZ9I9urUAKIa9ePt5mnrH/grS+c6
 YFCjN03KzpWvGbONAsk8Q6fuc1KoJZic0JuelbqqEb7hmw6fRpvV8Qjm9yRoJIXCAX6u
 hqxaXciBys+XKg2pZccaCrC5sZKNraL+HfpudaD9vK96TfdlI+gkn6fPz8BpG/oY8lON
 WfBg==
X-Gm-Message-State: AOJu0YwYaBQXBLPbsT2JwWU3ZTcNWXfYA0PGNsggEkiQXHNlYqYQIoc9
 RrL4hT0ZyWz9PkI/DqftGw3oq+efhXjsM2cIS+NQFSUMt/cn1CcoW2I7UcwLjpRV/QQfyDDiKoV
 x1GnMPYmKyvWj7+uuukA9lRhdy55u0P2f
X-Gm-Gg: ASbGnctXCjUkZPmk95CHv3/oxlbcFIyChFyJorqyYq5mgqlI3CtdhuuPLBuRtIFoqOR
 yqyZx1QsxiW4UEY9ynD3cqs/8l/daCcv5Ip1sSNtr674mtgBWyZnmByDjaimY/FBpvmH9C7c=
X-Google-Smtp-Source: AGHT+IG8/rXq5lbeHqJetJfYLHaTfGMfbkwo8tcYRHcuoJamHmnKuAKWKbXcLFHd/oV9bwAPLX9s0s+PT0RVp4iCbGg=
X-Received: by 2002:a05:6512:2388:b0:542:2934:71a7 with SMTP id
 2adb3069b0e04-54414a9d01bmr1405363e87.15.1738944125184; Fri, 07 Feb 2025
 08:02:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <74d703f3-b2c4-416a-805f-61859a5a4e70@gmx.de>
 <CAJSP0QWfaW0Nk2hdAWyT7kr9bOY6FNC3FXMqsjVfzONfU5cU0g@mail.gmail.com>
 <a1bee9ff-f621-42c6-8ef8-c52432d735e7@gmx.de>
In-Reply-To: <a1bee9ff-f621-42c6-8ef8-c52432d735e7@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Feb 2025 11:01:53 -0500
X-Gm-Features: AWEUYZkgrcKF11WT8U0AaHTctcUQ-FF8IU1ZidhCacSVbWiUqi3yI39U0QLWbjs
Message-ID: <CAJSP0QU+NCDJhajgzotF_c8pMB_bxxpVwbvDpJjm3UasFApNSQ@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=stefanha@gmail.com; helo=mail-lf1-x129.google.com
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

On Fri, Feb 7, 2025 at 10:34=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 2/7/25 15:47, Stefan Hajnoczi wrote:
> > On Fri, Feb 7, 2025 at 9:39=E2=80=AFAM Helge Deller <deller@gmx.de> wro=
te:
> >>
> >> Hi Stefan,
> >>
> >> On 1/28/25 17:16, Stefan Hajnoczi wrote:
> >>> How to propose your idea
> >>> ------------------------------
> >>> Reply to this email with the following project idea template filled i=
n:
> >>
> >> Would something like this be acceptable?
> >
> > Yes, it would be great to have an emulation project idea like this!
> >
> > Please choose exactly which device you'd like them to implement.
> > Interns may not be knowledgeable in the field yet and you actually
> > help by setting limitations.
> >
> > Link to the specific device's datasheet, existing open source driver
> > example, internal QEMU APIs needed to implement this type of device,
> > etc so that it's easy for an applicant to investigate the idea and
> > decide whether or not to apply.
>
> Ok, here is an updated text:

Thanks, I have added it to the project ideas list with some edits:
https://wiki.qemu.org/Google_Summer_of_Code_2025#Implement_LASI_network_car=
d_and/or_NCR_710_SCSI_controller_device_models

Feel free to update the project description on the wiki!

Stefan

