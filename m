Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224FCD58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaYd-0006Hr-L0; Mon, 25 Nov 2024 09:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tFaYc-0006CN-5p
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:59:22 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tFaYa-0005wh-I4
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:59:21 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85700f9cdd6so1032041241.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732546759; x=1733151559; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0gm2le7zvu5u0pVXa66HvQo8cjA/oxZHNSdfC4pDkk=;
 b=Ntbq/At66SVWoOxkqGoKoM9PPmOamETp21gDBxOW26JueLwO5nVMt91bQ1eQalEazm
 g10ugGkj8smcKTC+o+2NJVDAinP+6SSzQScMK7FlxrmKNYauesg7S9Y4rQSh3nWjYTvR
 u46C6tbvmr4CCQr13TAMr8JpuKFvPaXUa4PIKncDB9yF7rCtk+p5HrG7iJPt7aM8rp+m
 5KinrVmWMBpEM9PAbChY+EKsj0PuklBeESzelWtGptIJyu00XAv28JMzalh+00ouAT2I
 KqsIGWP2w4DpNbsFC3T7J0tXTLYK/sOFcGkoVXd7ExVmIVA+1kUkoJ7oUwhoonjz7Tcz
 nD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732546759; x=1733151559;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0gm2le7zvu5u0pVXa66HvQo8cjA/oxZHNSdfC4pDkk=;
 b=tfFTlFKQOB6mRT4mzQvYRkLD0ID6U6Qo+ZQFtNxtbARfXSFKqvJcSMNbFcqoJWahDD
 rkyU86suSjmzJxO/gBfriVFVVX3BU821NeXYwpqS2758W9NjZ3HXLfChQHuS945C7+pE
 vESdevzxYP+BEd3/rK7pa4PvPYaEhN80y/FEwPP8K7gmTJW+utns+VxfKiUfXYmidJar
 TXEIOWSmC8CLQVVr4jfvzNYKC5PVdFJZqdOH51t+Ogbi799ReIMQ/r1GdABWkpjRdodY
 DgiQnxnRfTu7TNxmlONhFcTduM33JjoAR0LSfz239G1e+r0fyGNnesjq38MBUuUtXnAW
 JzGw==
X-Gm-Message-State: AOJu0YwTKu+QMqC9Aroa4zhRlpSdl1bvl3UaVgbLbuCW8yIYbYJPhnQ7
 RnkVBVxtTzojAv5UWDxeqBBzzci28Uh1MGi629y35CptVO//w9dX2PImXVf9kGYJ2iwcsoat2AA
 7uj5aw1gcDLlggeyED+bKCdOqjfJqMfHT
X-Gm-Gg: ASbGncs0R7T75juU/VQ8VtjUAL4KM3hBbhvmhFoTEacuNfFQm3isFAmW2zDAjh5CEPq
 28000MtawXsLrG5gENoKQ6QQREovttCOu
X-Google-Smtp-Source: AGHT+IEvyQtBNiEku7CT1iIB+2x/HCl41vRw1JP7M8ArCZ4MS/thNlpFb4CYgsR2PZxJMYwn5qhx1pzms1LfPde8uRc=
X-Received: by 2002:a05:6122:3782:b0:507:9096:423a with SMTP id
 71dfb90a1353d-515009a85afmr12867633e0c.12.1732546758908; Mon, 25 Nov 2024
 06:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20241109122844.24057-1-dorjoychy111@gmail.com>
 <CAFfO_h7QxmXNGv2DM900hUvN7GG+WRTq6774it4VLq6FzmS6Aw@mail.gmail.com>
In-Reply-To: <CAFfO_h7QxmXNGv2DM900hUvN7GG+WRTq6774it4VLq6FzmS6Aw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 25 Nov 2024 20:59:25 +0600
Message-ID: <CAFfO_h7nMKUB1AhTHdEMf0w4Mj_M-UCqQsQ4c2TF2n-sQDJsYQ@mail.gmail.com>
Subject: Re: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
To: qemu-devel@nongnu.org, graf@amazon.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Nov 18, 2024 at 7:10=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Ping.
>

Ping...

This is a very small one that should fix the UI issue in
https://www.qemu.org/docs/master/system/i386/nitro-enclave.html . It
would be great if it could be reviewed and picked up for merging.
Thanks!

Regards,
Dorjoy

