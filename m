Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C692AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEQZL-0003kQ-3J; Mon, 12 May 2025 06:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEQZI-0003kD-QK
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEQZH-0006ey-0j
 for qemu-devel@nongnu.org; Mon, 12 May 2025 06:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747046369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTqSKD1MNTQiN5QRChBMtunMih7xZwtV1CX2sp29tE4=;
 b=VRVWo1tQQvJ+rNU9W10K7xhaJf2F74mHoW5WhaneqU2eo3ciKIkgTIl2l/X1a7g3BqQaBX
 FRE64G2J/bgithddfETzzMgy0I79L0u1vOCPYQjVDuwIEUDwBGSdVq7uw/OxknVpVh5Nf5
 ikYgIqHuxJixlOBEYVh7wpIQCoxeOQE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-GHPuAkk2MfiRI1FQmZWyvA-1; Mon, 12 May 2025 06:39:27 -0400
X-MC-Unique: GHPuAkk2MfiRI1FQmZWyvA-1
X-Mimecast-MFC-AGG-ID: GHPuAkk2MfiRI1FQmZWyvA_1747046366
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b394504cso2137742f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 03:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747046366; x=1747651166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTqSKD1MNTQiN5QRChBMtunMih7xZwtV1CX2sp29tE4=;
 b=WzvkTvhaWY+Iuz3B1L+0pTRCf0EY2hOayw0lU3Ct45L/r+T9rtcY8ZDjpxbHee7PTI
 BHJgRQgysxu1mzdy538E2IB3bcuP1w6bckR0IHDXyzWzFijWHG6Mvy2psoc+FFP0tbBe
 fst2WqZdvGbiI4fAw9rCXMzS0YNSEl+ZO1bY1z8MBswEz3F9c7mHh0LKBycxI6EN6lC5
 HPrU31hwhZK5NtADvcRFObjgEGh3G4WbWUUfQkZJjhj0AB1yWJuZMfN222EufX5ind8b
 26LQb0wLaD1dLP+2aQcpx5l4vjgdx1801W8DkVhDH9nFgCAdcqYshEWuv3I1il9v5DP/
 SVAw==
X-Gm-Message-State: AOJu0YybopPmjtjGNFFkdW6eRFf24yEdd4XY88bLOBVQyKfj4yGBpS8Y
 ZltZi4ISz5jKsBmv85hw66AON697xb5/Y37+xDCGa4COBDI7NPdAZZj93MZrR11eVAgw505ST8+
 Ix/XP2lGGJ2VveuYGyDwn/wzqVxTdsv6mhPieVL3q1xz1N1jxp+c8idaKfqJJnqpEuode++6CXu
 Jb29qqTPaZIf+Ouqt7fESIX+ETxHY=
X-Gm-Gg: ASbGnct7cRkNJYhAtfMHFZD8va1vDpaJRwC91x8OhCSQaStBfxEg/qdqeP9hhFAzP1K
 MN7WOu3XER0L1qNYPPWlOeVc0BSaMdZ+16GWccfFigUxGP0oJGGGYE+myQ9GOfd1iXgg=
X-Received: by 2002:a05:6000:1789:b0:3a0:8c01:d463 with SMTP id
 ffacd0b85a97d-3a1f6a1b3a7mr8965001f8f.9.1747046365841; 
 Mon, 12 May 2025 03:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMSR9IpkMyX/3/AMzXSzXxhc7eqeuGnGCb1FtUTiHNkO0dJ+aWLMnDfT94AZ/biC/Uxpdp+4zhsj/Whaf/Yz4=
X-Received: by 2002:a05:6000:1789:b0:3a0:8c01:d463 with SMTP id
 ffacd0b85a97d-3a1f6a1b3a7mr8964991f8f.9.1747046365583; Mon, 12 May 2025
 03:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-26-pbonzini@redhat.com>
 <3f774491-87eb-4a88-85b8-ab5e63eadb69@linaro.org>
In-Reply-To: <3f774491-87eb-4a88-85b8-ab5e63eadb69@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 May 2025 12:39:10 +0200
X-Gm-Features: AX0GCFuhx3W81CiPzkDOLHggRLVEQ60SGJOiHSsIkdlTelFGsSg0dGi5qmOEET0
Message-ID: <CABgObfbKxALn_timvFqY1RAcQb5SJpQO=+K2SCymbKaGBPstTA@mail.gmail.com>
Subject: Re: [PATCH 25/26] target/riscv: remove .instance_post_init
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, May 12, 2025 at 12:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Paolo,
>
> On 12/5/25 11:52, Paolo Bonzini wrote:
> > Unlike other uses of .instance_post_init, accel_cpu_instance_init()
> > *registers* properties, and therefore must be run before
> > device_post_init() which sets them to their values from -global.
>
> Does x86_cpu_post_initfn() suffer from the same problem?

No, in fact this whole patch series is motivated by fixing a bug in
target/i386: target/i386 *wants* the order of instance_post_init to be
what patch 26 provides. This info was present in the postings up to
v3, see for example
https://patchew.org/QEMU/20250228102747.867770-1-pbonzini@redhat.com/.

Paolo

> > In order to move all registration of properties to .instance_init,
> > call accel_cpu_instance_init() at the end of riscv_cpu_init().
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/riscv/cpu.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
>


