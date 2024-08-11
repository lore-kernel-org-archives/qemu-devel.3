Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A45C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 15:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdAdC-00057b-Qq; Sun, 11 Aug 2024 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sdAdB-000570-9D
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 11:37:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sdAd9-0000WA-Oh
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 11:37:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7105043330aso2930775b3a.0
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723390634; x=1723995434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1YSlAmnAAD+cZuGHXOKwjKc+zDTmLLffH035nNu2BU=;
 b=jUmzqudG+0Mq0VBBizskqLdn+mXXWTHQQLgpbO+d6/FVw9O5HBh07rM6teWO6eKz04
 tM7kEJoTKzQaryPIumH+efkw3iSytLrllkLZDtJivCix7dQABw6VVCY/wvxZ1EJkFf6D
 RyomcHnxiKq+jqWvVfopf+xUhwMbzNDIr3sSL9NIHJnEmRwVKBif9RrQdjP2LhrnYqyV
 wFBZE383VenhEmg/8HH8ykaR3sh3Jd9bwtPyXSwX1Gww0ZTkFMZK+eMXsmcqse7MmEIL
 Y3FEn6PGYwjSQ/O4E0Ymiew0rTuzngM28Bd7Ohpz4/mZmJ1ezv+eA/9lRNkNMYMb+xZJ
 Xt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723390634; x=1723995434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1YSlAmnAAD+cZuGHXOKwjKc+zDTmLLffH035nNu2BU=;
 b=eTscrrzkSPr5iV5wXcSIkyoH9O+EUS3hFPWbESFCRNewAvgnjLsUQybnGW4lANuuSv
 8D6FQ9b0W8CpuG95RScEEWJwe3otmj0cxOt4k3nA1XoIOS/RmSYJ54YcbfJdS9aSwW9E
 mYhGDIDRzOdhmiyq3RRvEiOWC9jtOXVcqhBpR7QcguGJY1ka9j+EM4gKco2l6N1ECR8C
 v8CHxadEv24FDszXdE2NImngZDQVfhp2pVhFcEWgFaCgjGXb5ZbAbEOG+LEjLoFIi/4v
 LVn2fvteiORuFqcv+/8jQ/xpTXKIJp5+4Xon1+hqPX5ODG/3gS2S58ZdsttrtBP0jupA
 nWdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpmvbP0G4NM4prCaGRurWgZqwcu+AQfEU/WMYwLryDRfWBtGbfES450VzOcjFbmnVgUIgFa8qVq2cPURD51yQ3Ej0TPWU=
X-Gm-Message-State: AOJu0YzaFWTvaLUkOMMfM8AtXAjomBYmBwYnUL625rPfsMEfVI4/9GAp
 y6ybfviMHJo49eUKc5BAZplvN4WCZJ4ZVoPbPEqSWbVX45pvvaIO
X-Google-Smtp-Source: AGHT+IG1k+eSUXof1df5VRJG4hoNeMD8BQLis2kc6EnzpzpxoXOHAyZ8sHER5RJaJ3IJjvjOk1YtcQ==
X-Received: by 2002:a05:6a20:9e4a:b0:1c4:a1f4:3490 with SMTP id
 adf61e73a8af0-1c8a00af35emr6420331637.39.1723390633600; 
 Sun, 11 Aug 2024 08:37:13 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.106])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb9fa774sm23776175ad.191.2024.08.11.08.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 08:37:13 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Sun, 11 Aug 2024 21:07:08 +0530
Message-ID: <2380422.ElGaqSPkdT@valdaarhun>
In-Reply-To: <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-4-sahilcdq@proton.me>
 <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

Thank you for your reply.

On Wednesday, August 7, 2024 10:11:52=E2=80=AFPM GMT+5:30 you wrote:
> On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
> [...]
> > I'll also test these changes out by following the
> > suggestions given in response to v1. I'll have more
> > confidence once I know these changes work.
>=20
> Please let me know if you need help with the testing!
>=20

Sure, I'll let you know if I run into any issues.

On Wednesday, August 7, 2024 10:10:51=E2=80=AFPM GMT+5:30 you wrote:
> On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
> [...]
> As a suggestion, we can split it into:
> 1) Refactor in vhost_svq_translate_addr to support out_num+in_num. No
> functional change.
> 2) Refactor vhost_svq_add_split to extract common code into
> vhost_svq_add. No functional change.
> 3) Adding packed code.
>=20
> How to split or merge the patches is not a well-defined thing, so I'm
> happy with this patch if you think the reactor is not worth it.

I think your suggestion will make the changeset neater. If feasible,
I'll refactor it after testing my changes and clearing up the page
mapping issue.

Thanks,
Sahil



