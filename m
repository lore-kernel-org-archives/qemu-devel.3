Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25562C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sizzQ-0007AP-6m; Tue, 27 Aug 2024 13:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sizzO-00078T-51; Tue, 27 Aug 2024 13:28:18 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sizzM-0007Hk-Ff; Tue, 27 Aug 2024 13:28:17 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2701a521f63so4546610fac.0; 
 Tue, 27 Aug 2024 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724779694; x=1725384494; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouAcN6pOEyahhQlHIVjQ7tRoM8V3SBXJcnWNXvoXdnQ=;
 b=GeIL5Nau0alhQf3OurGhrd4HsIt++TOjM6PhDrMWy7KKjwEqNI59P799u01h8qyFOn
 XaqDRiGDUKWIJUytRaGaF9YZbU0ecsOxzLAMx2SCAuoppBk29zscJiZEm8TxrauPR65f
 Vpo2XIU4Jg3ZGI1PxsC6VvxS8Rn9u1VUaM7OCkmNKsquhYg0vOrPbWVZjkrayAR675Bc
 gAcAFD25cS0F0k0hoMG9JxArtjC2qNmQK0vIhDs0uNTzwSOf4FMxPEOdanyU7iqIVv7d
 P/qYFqQoPl28oTEfXzMNjPuUcnYmwsjnaa9HstSaobA84vmX9+DeCbTBLe1FeTeKn40Z
 Ei5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724779694; x=1725384494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouAcN6pOEyahhQlHIVjQ7tRoM8V3SBXJcnWNXvoXdnQ=;
 b=v9XYXYRBHjSCN1RY/N+mLyjJ949rC2x4SltuhkBpERTHyQhYUuRiPQqXjuraN+JOpC
 hmYWHj1ltoq6rhlwLOC/rcJLAzw+XPpw+yYtVIqMe5l8n0WiEAb0rpKyKy+1YOCB+6gx
 Bbu4HZYPEaBcxn+9l/uP5n8zYFVOdZh+u2qtClbBToZmN997BsONEusNfscVh/1Ta++T
 EZPQEGm3/A9nPlibJ9fVOgUzRosF+tLqEpiOLH3+ZUqLxU/gKOQ3PHhQDTw+5TVHpE2R
 WvQypMi4K1YqiCaSn2sy7gYbk5ZWpJ/7HyKBfNF81awb/7J7HMQoi+hO9HcqQEEJ9GZV
 bqmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCITWiYYCMhFIGsbRlFnJZBh1+qLT/fHRenQG/ONOthpTBWxEnVlILHaog4cSi8gmn6KYrbyQX8YLGFA==@nongnu.org
X-Gm-Message-State: AOJu0Yw0db4qDcye+AUnU1kh0nmnlqmQQQxbxru0TexZT2dib8VOSnCE
 kxGm6V+e0pwFX1Zs35d8FfEWwON9rYifdG/1780K2EhzaFfp8JOnIz3Mq3zcXye3kcoowiWfNaL
 63CXLD+Pp4vqZkSdU2TrSvmyDCxA=
X-Google-Smtp-Source: AGHT+IEg6H9Ee9lTMwB5mCK2Pk1iaWi+9MJGhRzl1/cUTy/v/na7Fz5OFVBR8THOOZia/8QZF1Yw5wTLnHa0nNC/iLI=
X-Received: by 2002:a05:6871:5827:b0:260:ee93:f388 with SMTP id
 586e51a60fabf-2775a035ae7mr4080994fac.32.1724779694468; Tue, 27 Aug 2024
 10:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240827083715.257768-1-david@redhat.com>
 <CAJSP0QX+NiO7An468cKMFja3TGmgGzyNcPZjEtpPrfi3Q_1xgw@mail.gmail.com>
 <36402f8f-dc97-4eaf-8197-1df2bc01720b@redhat.com>
In-Reply-To: <36402f8f-dc97-4eaf-8197-1df2bc01720b@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 27 Aug 2024 13:28:02 -0400
Message-ID: <CAJSP0QWed1ZjRZ2pkUgx0j+9bepKg1hfaWXQLzP613xsiHtwyw@mail.gmail.com>
Subject: Re: [PATCH v1] softmmu/physmem: fix memory leak in
 dirty_memory_extend()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 27 Aug 2024 at 13:24, David Hildenbrand <david@redhat.com> wrote:
>
> On 27.08.24 18:52, Stefan Hajnoczi wrote:
> > On Tue, 27 Aug 2024 at 04:38, David Hildenbrand <david@redhat.com> wrot=
e:
> >>
> >> As reported by Peter, we might be leaking memory when removing the
> >> highest RAMBlock (in the weird ram_addr_t space), and adding a new one=
.
> >>
> >> We will fail to realize that we already allocated bitmaps for more
> >> dirty memory blocks, and effectively discard the pointers to them.
> >>
> >> Fix it by getting rid of last_ram_page() and simply storing the number
> >> of dirty memory blocks that have been allocated. We'll store the numbe=
r
> >> of blocks along with the actual pointer to keep it simple.
> >>
> >> Looks like this leak was introduced as we switched from using a single
> >> bitmap_zero_extend() to allocating multiple bitmaps:
> >> bitmap_zero_extend() relies on g_renew() which should have taken care =
of
> >> this.
> >>
> >> Resolves: https://lkml.kernel.org/r/CAFEAcA-k7a+VObGAfCFNygQNfCKL=3DAf=
X6A4kScq=3DVSSK0peqPg@mail.gmail.com
> >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >> Fixes: 5b82b703b69a ("memory: RCU ram_list.dirty_memory[] for safe RAM=
 hotplug")
> >> Cc: qemu-stable@nongnu.org
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>   include/exec/ramlist.h |  1 +
> >>   system/physmem.c       | 44 ++++++++++++++--------------------------=
--
> >>   2 files changed, 16 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> >> index 2ad2a81acc..f2a965f293 100644
> >> --- a/include/exec/ramlist.h
> >> +++ b/include/exec/ramlist.h
> >> @@ -41,6 +41,7 @@ typedef struct RAMBlockNotifier RAMBlockNotifier;
> >>   #define DIRTY_MEMORY_BLOCK_SIZE ((ram_addr_t)256 * 1024 * 8)
> >>   typedef struct {
> >>       struct rcu_head rcu;
> >> +    unsigned int num_blocks;
> >
> > The maximum amount of memory supported by unsigned int is:
> > (2 ^ 32 - 1) * 4KB * DIRTY_MEMORY_BLOCK_SIZE
> > =3D ~32 exabytes
> >
>
> True, should we simply use ram_addr_t ?

Sounds good to me. In practice scalability bottlenecks are likely with
those memory sizes and it will be necessary to change how guest memory
is organized anyway. But it doesn't hurt to make this counter
future-proof.

Stefan

