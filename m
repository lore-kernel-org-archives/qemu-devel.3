Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9E6ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfKg-000770-Re; Mon, 09 Sep 2024 10:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1snfKZ-0006jW-8H; Mon, 09 Sep 2024 10:25:28 -0400
Received: from mail-oa1-f47.google.com ([209.85.160.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1snfKW-0004Pc-1T; Mon, 09 Sep 2024 10:25:26 -0400
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-277f0540c3aso2672457fac.3; 
 Mon, 09 Sep 2024 07:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891922; x=1726496722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/8TNAj1b5bbzb6bH+G8TSVaYemeITL1DctHw8RR6vk=;
 b=EU9hp1hWZcZNu/kz3k0AduzFlXY7lK4rE8EdESGhJW98UcjG7+cJAAaG2enzPr/o7F
 6c7qCbk35Z/uNnK7nHNA8dKuWl3QWbUC4+2cRqW0YInhdIVYEeEuhqU7ifqNOtTdgBZs
 HZKis4qdh1IU4bEoxsq+rlv5DFkXwcqPcMA3Em/s3lhMeCogDWi2i5xvAnlTQZUiXswY
 AF2E+5mKTSyCPtx1/mAAv5JQ1le5DnmggKoEZCV+dw8m4q1IyvhJ3kzNpDQZdntW9iXm
 SsZD/2u02RwyQptkX+ftBJgaDRWr8J0YZbKdre6Fqn9Xa9XnC+LYY698RR7efjE0KoMA
 dU3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYXFSEoBZ06/6F//j/1LOnEnKZPqBWZkLrBdv4nbP0lCj1s3N7jQycEJ3RNDm3bi6LNAy7s0tlzB6d@nongnu.org,
 AJvYcCW+dwD/ISL3rjf24dac4LHvk4GpWFcEeKJi4eJayxWYgFi+5JMAIJiId2YrQeg8Jg2MNXGNc5FRGhkXow==@nongnu.org
X-Gm-Message-State: AOJu0Yx16mg9ic3v3na5DaSbPJYnX8lIXT/14p8LzN5/m6ZgaptALvEU
 w3ZndAHXTny8OcZJHvTpNtTxaV+wcOoiktpZHODIQGMioHGzbjHC4ZHGSQ==
X-Google-Smtp-Source: AGHT+IF/R7AvtDag6rcXNY5UqTi/6w4Gxgx6vZ3ksQDYnblavfN52+1551MvfQkdw5lRokKuCb6Cvw==
X-Received: by 2002:a05:6870:71c5:b0:260:faa1:4453 with SMTP id
 586e51a60fabf-27b82db975cmr12888912fac.8.1725891921654; 
 Mon, 09 Sep 2024 07:25:21 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com.
 [209.85.216.52]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e5982c8asm3701159b3a.145.2024.09.09.07.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 07:25:21 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2da55ea8163so3071375a91.1; 
 Mon, 09 Sep 2024 07:25:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUqiR5P6PPUEPndFU7HNbNt/CYLdilqJlEynkRGPATj1EPpyU1X+9smrMKFvc4+Qp5BpuU/6pVcsr4poQ==@nongnu.org,
 AJvYcCVAtPxNLxoGTWoy770/VSvDIB7PrUXdVnCoB68cYbAqi84KnkOmDLq6ohrtukzzJ6sHg/2vsfsNAUob@nongnu.org
X-Received: by 2002:a17:90b:274b:b0:2da:936c:e5ad with SMTP id
 98e67ed59e1d1-2dad5194281mr11429228a91.33.1725891921144; Mon, 09 Sep 2024
 07:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240909015847.40377-1-j@getutm.app> <Zt7GM1uLzE5Z176u@redhat.com>
In-Reply-To: <Zt7GM1uLzE5Z176u@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 9 Sep 2024 07:25:09 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCUQp4=9Xb_=E_L8fTyzjQvSScXNfROsUkfCP4TCcg9bg@mail.gmail.com>
Message-ID: <CA+E+eSCUQp4=9Xb_=E_L8fTyzjQvSScXNfROsUkfCP4TCcg9bg@mail.gmail.com>
Subject: Re: [PATCH] block: support locking on change medium
To: Kevin Wolf <kwolf@redhat.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.160.47; envelope-from=osy86dev@gmail.com;
 helo=mail-oa1-f47.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 9, 2024 at 2:56=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 09.09.2024 um 03:58 hat Joelle van Dyne geschrieben:
> > New optional argument for 'blockdev-change-medium' QAPI command to allo=
w
> > the caller to specify if they wish to enable file locking.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
>
> I feel once you need to control such details of the backend, you should
> really use a separate 'blockdev-add' commannd.
>
> If it feels a bit too cumbersome to send explicit commands to open the
> tray, remove the medium, insert the new medium referencing the node you
> added with 'blockdev-add' and then close the tray again, I can
> understand. Maybe what we should do is extend 'blockdev-change-medium'
> so that it doesn't only accept a filename to specify the new images, but
> alternatively also a node-name.
>
> > +    switch (file_locking_mode) {
> > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
> > +        break;
> > +
> > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
> > +        qdict_put_str(options, "file.locking", "off");
> > +        break;
> > +
> > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
> > +        qdict_put_str(options, "file.locking", "on");
> > +        break;
> > +
> > +    default:
> > +        abort();
> > +    }
>
> Using "file.locking" makes assumptions about what the passed filename
> string would result in. There is nothing that guarantees that the block
> driver even has a "file" child, or that the "file" child is referring
> to a file-posix driver rather than using a different protocol or being a
> filter driver above yet another node. It also doesn't consider backing
> files and other non-primary children of the opened node.
>
> So this is not correct, and I don't think there is any realistic way of
> making it correct with this approach.

The existence of "filename" already makes this assumption that the
input is a file child. While I agree with you that there are better
ways to solve this problem, ultimately "blockdev-change-medium" will
have to be deprecated when this hypothetical "better" way of
referencing a node added with blockdev-add is introduced. Meanwhile
this solves a very real problem on macOS which is that trying to
change medium with an ISO which the OS has already mounted will always
fail even when "read-only-mode" is set.

>
> Kevin
>

