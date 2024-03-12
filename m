Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A02FC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 23:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkBHC-0001v0-Pi; Tue, 12 Mar 2024 19:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rkBHB-0001uq-PY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 19:11:17 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rkBH9-0003es-Lg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 19:11:17 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d27184197cso79911141fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710285073; x=1710889873;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDc12UD/gFlaTF+z8O3YbbaOS5ioVNd6BYvQQVOmQx0=;
 b=NMhgJy+Hzfzhl5/g5WHD7GJMJlHKIsA2zZCH9iULqoWeG7fw42HvfM69MmDddXbnW3
 geRGWWIT+C6GPSlyf2hntKIpnvg7w0cLN8FJwXvra1PBetLisCI2/75YIp8rTJm0FqEf
 um6eycL15/mtquh7I7bg7tXFfI/G0rScA7jzTa/t+X2n5OUlY+T0m1Tok8dAU15+YDl9
 53f4oviNn480azEm7ItK19HzRtZ3AIRzA8SFSL6SI8Wvq3BzFeG5rPQwMKoRwtvVyiuA
 55RoqketG5T4xLfuFliSoD99K3K4SLKDT9HielCNpFh7mhyjdXVRjb8sI2C9DwMZcIFV
 eTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710285073; x=1710889873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDc12UD/gFlaTF+z8O3YbbaOS5ioVNd6BYvQQVOmQx0=;
 b=mJp9ZiZ2sPERNcL2jrg8UvQ2S0lAiFUwHSonfr29MhjRvxObGmbPxh2EpnWPlr35Ox
 aI5SE2K2jMdsxRG2lxZ5chjAZzJuPuciBum8LIrRCON5l/4P3Qo1hEtfXeDECQMk9O5+
 mUE+WxdyEe6GpP4DaJS/eZjKB9+uYqEjDTjgLxLGZea5tWkBRF2hoLLx95l4IFhcsNcV
 MReq9og7GuWXmJI6kCppK+MyKN7wX82HUW8Tt1/h8wAh3muFqajeXycM7aVziINqGF1x
 tLRThXn/0IjqO3XTAr8FvFFJIPi366OYDJCMy2w9QMMVY2Ofx/Lq3dZzf44SZEibzPrb
 AdPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+eeCnV/aCyTapfY3hppikkcJlbVBf7OybtZTNK9xGGbTwoRk0wpYZlND1aaY2V4YuCAg7x50Qfx7gwBNwH+8EglACjfA=
X-Gm-Message-State: AOJu0YzXRPlH/aVfYgPBmIJ8N5Jk29DjyHLgAtKR4PyoTGVbTie3tlRU
 FhwEaEz/UuNCWFT4bCic0DfPgk+5WNPG6FNn+POt9AUxxKPAToRNNnJnyzICOB58MnGTKQxfZaz
 apVpxX+OIyc2e2nYWgVcCR1ofxSXC1A9FkhksxQ==
X-Google-Smtp-Source: AGHT+IEwD7aS4Twe1jNbir9tSyMd8SKhXhCpry9YwHnKsRdOlnHrmeN009dXFd5VUeMQGqrAHMS5MQrIXVC9+QAJYeA=
X-Received: by 2002:a2e:99d0:0:b0:2d4:3044:9311 with SMTP id
 l16-20020a2e99d0000000b002d430449311mr6160255ljj.53.1710285073283; Tue, 12
 Mar 2024 16:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240205165437.1965981-1-andrew@daynix.com>
 <CABcq3pGy+Lp8YZnMZVC61wu6jDvE0BYj3kuuvuXCA+ewOtJVfg@mail.gmail.com>
 <CACGkMEs9B+7SEy1naQCQwXQDd7bzRZGjxv2h_QHx8g_az6E=Fg@mail.gmail.com>
 <CACGkMEvMoK+MZx7WkMzzVpyHw+agac38Td-aVq3Ygwb4jNhXmQ@mail.gmail.com>
In-Reply-To: <CACGkMEvMoK+MZx7WkMzzVpyHw+agac38Td-aVq3Ygwb4jNhXmQ@mail.gmail.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Wed, 13 Mar 2024 00:45:45 +0200
Message-ID: <CABcq3pEqCdha49FAs8knQDcp1RzA6MFxC3zwRU2oyvHcX_7EkA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] eBPF RSS through QMP support.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all,
Apparently, eBPF code from ebpf/* can't be a part of the 'common'
library - that breaks non-system/user build. I'll change it to be a
'system' library.

On Fri, Mar 8, 2024 at 10:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Mar 8, 2024 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Mon, Feb 26, 2024 at 6:23=E2=80=AFPM Andrew Melnichenko <andrew@dayn=
ix.com> wrote:
> > >
> > > Hi all,
> > > Jason, can you please review the patch set, thank you.
> >
> > Queued.
> >
> > Thanks
>
> This seems to fail CI at:
>
> https://gitlab.com/jasowang/qemu/-/jobs/6348725269
>
> Please fix this.
>
> Thanks
>

