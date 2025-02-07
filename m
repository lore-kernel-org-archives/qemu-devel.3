Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34260C0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPeR-00010n-0R; Fri, 07 Feb 2025 09:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgPeP-00010c-VB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:48:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tgPeO-0007qs-7Z
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:48:13 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5de4d4adac9so1036126a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738939690; x=1739544490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IO/n/UeTJDy3TKN2S+QXRJV3SgZ2hdcn+oKYE3xLXHI=;
 b=fj6xm0CHlOlCKCZTnDTbdq2w271jxHWa6GuO4PiEWq5uVHFP1RTwmiTaC/fEU4BkZp
 JLCBv9FT9krdkXirVjawsk6GAcIvBOccBfK7WnFKY5kCs2g6gEQrvd29JvGh/2k/C2mj
 46SC6Dgh/UwefWWQr1aCQGAfk8NM41zUunxfA8a2I6HI3EqYVw7rB33rVl3KyAhr5LAl
 ucahxTo1xbERbMiQzi5FrTIaCRnGyZuhyMIFKRUDUvV4D7u/7/OrSoyL24JGT0fWQuNT
 p/zijKI0iXXuvDUWE4HH5No8iO4aL6EGDx4m6j7YewOYQqgXLmfCiXUUrwXQfLpJ8kr6
 na8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939690; x=1739544490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IO/n/UeTJDy3TKN2S+QXRJV3SgZ2hdcn+oKYE3xLXHI=;
 b=AzP7E3vTYtyshrzdo7mA9LbJOKqWOXmTT1CdTQPtbPCJiadz/K3i5FcX8X1zBDFgiG
 STyHaPDdg06H4Ac/LcNGLF7npkzWVbgdxSI4/ck909nGzDmORylRBK6RaIUU/KnTbAMo
 1Giqc5CbzzyPmyVxFTeBcg/bueFLiygczcAZvqEKk0Dua2aKjRkN7K7NKXt5t22EN6Ce
 g2CIgEztpnvg7eVBW/H16XS8p4Rc62/UFaUW/ATVPpNV0jaZNWhNZkxqNEgqMMqP0uAg
 Gk+sG8RPNcK+7Z5iPNX+cmuwUDMR8gun+WH9zQfD+Z8n++cf/q5oGtula2xoLLloi8kP
 iqPQ==
X-Gm-Message-State: AOJu0YyMbz5LEqv7wsatZycvs3jOo4lju3T5dPN73GWGTriJxeudtCro
 MZhCpdiTf5r9PNSw7b3HxuRq+lGuhM0sRxreD7Hkh6f16A3TSg8rofHQuPiv6SdFsZnUngFz4GB
 8AB1Q2PI5+UHDwr0KV4rkBQTB2+E=
X-Gm-Gg: ASbGncvFsZG48lU5Ger5JKpcz2OugEgXgF4xxxINZhaJLsX+iyUYUUzYap6U1Q8lJDj
 robsT+k/SnFdFNCEFkpnygVnuzL7T2voJ79uxQ1/EBZYPTGdDi63YlOoF+Sap3HHF6b9/wiA=
X-Google-Smtp-Source: AGHT+IHteCUjECg01FzqXkpy+Cb9m5lXAUQKsZs/f+pqFkQ57BafQhtg+tOS6Jp3jxfFha5W4xD7meWPgJPxqFbdhWo=
X-Received: by 2002:a05:6402:3883:b0:5dc:752f:fa9f with SMTP id
 4fb4d7f45d1cf-5de45097e0bmr3752189a12.28.1738939690220; Fri, 07 Feb 2025
 06:48:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <74d703f3-b2c4-416a-805f-61859a5a4e70@gmx.de>
In-Reply-To: <74d703f3-b2c4-416a-805f-61859a5a4e70@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Feb 2025 09:47:58 -0500
X-Gm-Features: AWEUYZlDaVpcXiR_IUq6q5qgta2pY-ipQVQljl_DHjedUpraSoU1xwzHEzTR3qo
Message-ID: <CAJSP0QWfaW0Nk2hdAWyT7kr9bOY6FNC3FXMqsjVfzONfU5cU0g@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>
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

On Fri, Feb 7, 2025 at 9:39=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> Hi Stefan,
>
> On 1/28/25 17:16, Stefan Hajnoczi wrote:
> > How to propose your idea
> > ------------------------------
> > Reply to this email with the following project idea template filled in:
>
> Would something like this be acceptable?

Yes, it would be great to have an emulation project idea like this!

Please choose exactly which device you'd like them to implement.
Interns may not be knowledgeable in the field yet and you actually
help by setting limitations.

Link to the specific device's datasheet, existing open source driver
example, internal QEMU APIs needed to implement this type of device,
etc so that it's easy for an applicant to investigate the idea and
decide whether or not to apply.

Stefan

>
> =3D=3D=3D Develop a driver to emulate an existing network-, scsi- or grap=
hic-card in software =3D=3D=3D
>
> '''Summary:''' Develop a driver for Qemu to emulate an old network-, SCSI=
- or graphic card in software
>
> Qemu allows to emulate a lot of physical machines. Beside widely used
> x86 machines as used with KVM, this includes historic machines
> based on PowerPC, Alpha or HP PA-RISC CPUs too.
> To allow to emulate additional specific historic machine models,
> drivers to emulate specific hardware like network-, SCSI- or graphic
> cards need to be developed.
> This project is about to develop such a driver for the historic
> HP PA-RISC architecture, e.g. for the "LASI" network card, or
> a driver to emulate a "classic" first-generation NCR 710 SCSI controller.
>
> '''Links:'''
> * https://parisc.docs.kernel.org/en/latest/technical_documentation.html
> * existing Linux kernel drivers
>
> '''Details:'''
> * Skill level: advanced
> * Language: C

