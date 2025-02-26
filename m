Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63565C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOef-0000tl-ET; Wed, 26 Feb 2025 16:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tnOee-0000sf-6x
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tnOec-00041E-3m
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 16:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740604155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRUyxYPKije4hbhsOX++5Vel8YJvyKTxw8p++yWApw8=;
 b=ia684/GOTCjcmO8puroYAIqXGSIcKp/pKp1V3Sf2LsuymAd6pqwjL/MWmjYvToM7RLVfUF
 qhT9MAcnCdtMW+dDwPnB+Yg6TIEYUthFKM7nBxMzZwW7DY8s/LIzTtZP0fV3Dq4vvP9/5L
 wLT+A02J0DJSHdcwrU+A9syHTSWtjfw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-w1Tl8zUKOWeAcK2FyoOw0g-1; Wed, 26 Feb 2025 16:09:10 -0500
X-MC-Unique: w1Tl8zUKOWeAcK2FyoOw0g-1
X-Mimecast-MFC-AGG-ID: w1Tl8zUKOWeAcK2FyoOw0g_1740604150
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-47207b66f3eso4171621cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 13:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740604150; x=1741208950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CRUyxYPKije4hbhsOX++5Vel8YJvyKTxw8p++yWApw8=;
 b=SGeRciWLww7WBmLIRzL95laerPG4ubkCeV7rfhY9zIzhof888ib1SSsEL/h+HAtXb+
 tlUlyiTEWGhsR+70A816AtD/KMbnCzYH7v7JG+zqZtm4vIgNhqsVlugmyBG88XUGg8MK
 w/PMeaH2yhDmn+DTn52bsCkwYkoAJoUI0iIlb7pPVQFMMHWIddkXBCdYKiBG9c2yC0Ps
 9YbtqYx9Ck21LHZk8XBsks3zCjBB/luS2BFfTKNISppwku4eYfE0NiWMSkNZ73sS/lMG
 jxp7Ey6bxFhbv5fLH75/47wkFtWC5hEw4S0eRF2KmEqcjxRi1emxiNSjfsssg1lT+mue
 OXmQ==
X-Gm-Message-State: AOJu0YyUC6N5UcRcHOJxKWqKOFhiZxrgJEiJCUaikqF25jD5FZwudv7C
 zhWcy1YznLaNzZtfFBsWWWO1zL1lG1qI2XTmKKkX3q2f902liYdYkN6PCKoV/cxVqQ1DsCOm21D
 Pb0IGL5QrgdNvspzfAD/KbzpcNlCQaETR+A9f4kDAH0kmX7q3AtodkuiTL6FTxUSYFPY/Z9Kn8U
 Se+DkTdm1nfya4TrW+i/x6ejnYeM4=
X-Gm-Gg: ASbGnctO95UyyXdQaAnWLx9Fu7kBtTKzwjl3SrcCbYLBrL1GT9KLhiH3To7ES6/ROds
 5OjG2Vv9i9x78i7QPeOZ6fZ/2F80TdmAn2VXra6o3rcxNAj3V+srBrt7Ed/QIKjFo4ozjXMQ=
X-Received: by 2002:a05:6214:2422:b0:6e6:68df:6059 with SMTP id
 6a1803df08f44-6e6b01dcda8mr333600236d6.45.1740604150244; 
 Wed, 26 Feb 2025 13:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW+HaTzwcmqBxpUEC0XNEP9+87DENVPCqHD1hdmAzlL4ERds53u7T3+1JvsRKKK181NOL8cF+vo4Bx/9R5KFI=
X-Received: by 2002:a05:6214:2422:b0:6e6:68df:6059 with SMTP id
 6a1803df08f44-6e6b01dcda8mr333600046d6.45.1740604149932; Wed, 26 Feb 2025
 13:09:09 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Feb 2025 13:09:08 -0800
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Feb 2025 13:09:08 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-3-abologna@redhat.com>
 <CAKmqyKPJirY6YWOtTiKNwh7xM7kVuihVhnWe3UKWND1qX=p-gw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPJirY6YWOtTiKNwh7xM7kVuihVhnWe3UKWND1qX=p-gw@mail.gmail.com>
Date: Wed, 26 Feb 2025 13:09:08 -0800
X-Gm-Features: AQ5f1Jpl4LEltgBpJ00zzaD84KG-6KQPxDPa2a0ydHlgwhMK_2IiYLIoKE3A0uU
Message-ID: <CABJz62MmKwf-WVS3Hxbs3HEJdWR6hh3JNb50sxDGXgOr6F+UgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binfmt: Normalize host CPU architecture
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 24, 2025 at 11:39:46AM +1000, Alistair Francis wrote:
> On Tue, Jan 28, 2025 at 4:29=E2=80=AFAM Andrea Bolognani <abologna@redhat=
.com> wrote:
> > Right now information regarding the family each CPU type belongs
> > to is recorded in two places: the large data table at the top of
> > the script, and the qemu_host_family() function.
> >
> > We can make things better by mapping host CPU architecture to
> > QEMU target in the few cases where the two don't already match
> > and then using the data table to look up the family, same as
> > we're already doing for the guest CPU architecture.
> >
> > Being able to reason in terms of QEMU target regardless of
> > whether we're looking at the host or guest CPU architecture will
> > come in handy to implement upcoming changes.
> >
> > A couple of entries are dropped in the process: BePC and Power
> > Macintosh. I'm quite certain neither of those have ever been
> > reported as CPU architectures by Linux. I believe many more of
> > the entries that are carried forward could be dropped as well,
> > but I don't have the same level of confidence there so I
> > decided to play it safe just in case.
> >
> > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks Alistair. Are you planning to review patch 3/3 as well?

--=20
Andrea Bolognani / Red Hat / Virtualization


