Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D576FC28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1try81-0000PB-EF; Tue, 11 Mar 2025 07:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1try7i-0000Bi-4A; Tue, 11 Mar 2025 07:50:15 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1try7b-00019B-51; Tue, 11 Mar 2025 07:50:13 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86d42f08135so1724944241.0; 
 Tue, 11 Mar 2025 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741693800; x=1742298600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAii/7V9yfv5p8IUjF1QCSi5NSkvZwAdZizeHwxs3LA=;
 b=Ipd+63mzbgziSUHETsRJQue4jccZbUHzJLwZfeampg7xGWcmpIFdMiDoT1RnJH1McM
 Q2Cma4zaLuQaERVT/ZE5KB4zaat48gVCZMdpARLVwYOLpLWJx6MOL3nWzxhhamO5OtHz
 GSe9y60SNE7g4zqSuSZzJzEk4+moNUipmTriPp/3abq9HyoLnX2BKtRPapTvZM9XW/77
 Wc3wWagmyXML+iNP5nFuTZ+zsXo9sTub2B2imDPHnd+KEtoFqCYDUkJTY/IcOiW29aoi
 H78XGdbOS8QfLSL8UO+KAcirpib/pQGvkVbZLZ9KPwFe3CZzldp3AyNSEsjOFLCUm986
 0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741693800; x=1742298600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xAii/7V9yfv5p8IUjF1QCSi5NSkvZwAdZizeHwxs3LA=;
 b=RwNmU3Dx/fR7I+vJZCel5RHUW8/tIu07sbEJlK4KREUfMbdijWGuX7vgKhOjPu5uaO
 q0rmk0BPeTUPjEKlc+LaEKQDvbw6t+aMzehRQsBZQZdodfrOvYNBWK+h5wD4p3Lu7z+G
 oPOcJ+9354muBMYM9octcZaCLoNDXjtAdOyjKaOiVcupycl9ev+6WhucP214Nkh+D1FH
 7D9jkTSuokpYZ5t3N4WSb87WlYsBI5+I9CDqnQ7eIX219mjaiIc6GglHdEOj/0yOqd/f
 2ZUM7ZL4eZZ5uU6zR5TSU+oz/xKq/GvnbegVxZz1ll9rjrZBBtVcU/xExxu/DcXuIYbN
 P8kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXop0q2pW6iTPVZP+rTfAbOfpwGJK8Rjwz22LSS9LKGNZzBuUNt88+iZk8pI+Cg08J1+/YeZQC9fRbs@nongnu.org
X-Gm-Message-State: AOJu0Yz8blburYFWiz+kjRff+SpnvV5XHIZlEBpjUrfm/aGGD/mF2n5r
 WVtJoQpAzCqLAwVBb2c6+TppRC5opatGQI+rXJOQHNrsPRCqes1c/hJSVn1sMVzWC+hRs57tveI
 F85ZjOtiyNX8/SZY3oki7eMidMjFw0FQPlaE=
X-Gm-Gg: ASbGncvKpFGMSSAXzVnnqcOPluYIO9sR6udGvRL0+MVFMccXr0Ab+25QxWBi9jNp/ZS
 sENPFiFV7jCRo1pnz7ttTTLVZOjSEqZZysUH9KbwXuVXRYYLWhdgd6e2EXcDsRkKNIDrWcxPh6Q
 Dx4YYXwj0oaHgnBuP2IAhigEdleYbrIwv7tq3BJs1ng+eijwPA77dc
X-Google-Smtp-Source: AGHT+IGkq6+7oLg9RJTIOs3wkdAFJhbugAgWXyuQsqlA51aWzg4QVam39/tkgzAhZq6GqKaFlNg7LzKiOKxVzaKm6ao=
X-Received: by 2002:a05:6102:578f:b0:4c1:90ee:ab2 with SMTP id
 ada2fe7eead31-4c30a5ecc5cmr10395829137.14.1741693800196; Tue, 11 Mar 2025
 04:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
In-Reply-To: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Date: Tue, 11 Mar 2025 12:49:49 +0100
X-Gm-Features: AQ5f1Jq_a8XrU3XTr18dDckDjZVVzypN3-GBt6EytgMlv_grnDi_NIW4Qxu-DLI
Message-ID: <CA+uc5a09t+55b1hQ_psj2K9=ohPASHB0fxSBNgU80X+fDa+D3A@mail.gmail.com>
Subject: Re: [PATCH v2] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, 
 Wen Congyang <wencongyang2@huawei.com>, Markus Armbruster <armbru@redhat.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Rovshan Pashayev <Rovshan.Pashayev@veeam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=raman.dzehtsiar@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Mar 4, 2025 at 10:17=E2=80=AFAM Raman Dzehtsiar
<raman.dzehtsiar@gmail.com> wrote:
>
> This patch extends the blockdev-backup QMP command to allow users to spec=
ify
> how to behave when IO errors occur during copy-before-write operations.
> Previously, the behavior was fixed and could not be controlled by the use=
r.
>
> The new 'on-cbw-error' option can be set to one of two values:
> - 'break-guest-write': Forwards the IO error to the guest and triggers
>   the on-source-error policy. This preserves snapshot integrity at the
>   expense of guest IO operations.
> - 'break-snapshot': Allows the guest OS to continue running normally,
>   but invalidates the snapshot and aborts related jobs. This prioritizes
>   guest operation over backup consistency.
>
> This enhancement provides more flexibility for backup operations in diffe=
rent
> environments where requirements for guest availability versus backup
> consistency may vary.
>
> The default behavior remains unchanged to maintain backward compatibility=
.
>
> Signed-off-by: Raman Dzehtsiar <Raman.Dzehtsiar@gmail.com>

Hi team,

Thank you for taking the time to review my changes. I would like to
clarify if there is
anything preventing this patch from being merged, as I am eager to
have it included
in the next release.

Thanks

