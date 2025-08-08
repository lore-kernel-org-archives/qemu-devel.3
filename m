Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02794C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUu6-0006NM-K0; Fri, 08 Aug 2025 17:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukUtx-0006LY-88
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukUtv-0003Ot-Dc
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754689521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f7N90XLCNBpPX3CxG4DhTvRs5pgKpXOx/DMTusFQfMA=;
 b=aZZvF26AY3XfMzctkVBPKF2N6ec3GzJTwlc1g5JYY2AkJJHMt2LzGyK0B8jPgOmjaFsV0z
 zmRf34gVBXp8itZuRX/h3CHyuQ3qpvgc+tc1MyPs4Wo3+qCtXq+nPMIJdlV08dgJU6aUZN
 yKr0DRFIv1aR4l1yCw8MzfeIsmgGB2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-1MUZqa8SPrCfsR7a6Ai9xw-1; Fri, 08 Aug 2025 17:45:20 -0400
X-MC-Unique: 1MUZqa8SPrCfsR7a6Ai9xw-1
X-Mimecast-MFC-AGG-ID: 1MUZqa8SPrCfsR7a6Ai9xw_1754689519
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45891629648so13280845e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754689519; x=1755294319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7N90XLCNBpPX3CxG4DhTvRs5pgKpXOx/DMTusFQfMA=;
 b=XjI/w8v6/2xIpK8OQuuQDp4F7FHuVM5QDHo/Ok/uEz7cPoyG/5XvAApZK1dMCG8vhr
 ka+3LZu7/FlLtnF9xmRkIRWk3qNSOK3hN/+zm6QdTe1ZBc0BXRWhLAUxtw8UUgzSAqWp
 lXpPG6dPd3vvIQvj7mWgQ3pVBiHJA78LWALmY1wJXtlxb9bn7FoTpT424d3ltfI0APxW
 9rLCewEGk1qJ3kq/SKmd1NxfNWu8yq3+lWMNmbQxGktKxv8u/rrwxFCUBLTIR4IhPm9e
 7o2/KIkG38IbkY2ngP9KGppqIkrkyxD/wKwY9DvBHJWDrufe1fe885QVUvoyoyOfFvJL
 9pog==
X-Gm-Message-State: AOJu0YwGDb2fZ4pS0cOvHhKYUPNj6JSq8GfJZIQcCsiFLub0WQgjA8Wh
 I0dUqtnjUIsfSl31ukjKpjv+RVL41Q4uTGhTy4fhLBFpH9u/2u/ag3h3AkhDlPPSioY8Sn0YEtQ
 Pe7I853a2AIYdIvGOUeJmdYOgIfEyzh9tEhd8yi0RoSZlXW7e/yuP+aCitodnTVKlo4eryCuGIX
 UgJnhViM4ZbsQ99bm2GRYIXe9O1snw7pU=
X-Gm-Gg: ASbGncujoKOs00gzMbPGTFqhY2RQ7CxdXM32YpczQHwa8f2/ktV85n8itgLxiqnO+Hr
 83tMKIMVt1/Umck9YEREJ4V6D3k0pFVPu5NMFcPnX9ZMUN4c/9g9CcJGQNphniYq/eG6Q6omhlx
 G4LBNrPxR8JWdeFO7278ewvw==
X-Received: by 2002:a05:600c:3b1b:b0:459:e39e:e5a5 with SMTP id
 5b1f17b1804b1-459f51a7fbamr40860455e9.5.1754689519037; 
 Fri, 08 Aug 2025 14:45:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKetMCn4T4QOTZHJ3vJ5UU9e7GdhVl5T1TJRiQWnVl1XUViL1KiJ167xfT/1xGZRGNQXpHv7Cl8JS5TKrLLHM=
X-Received: by 2002:a05:600c:3b1b:b0:459:e39e:e5a5 with SMTP id
 5b1f17b1804b1-459f51a7fbamr40860315e9.5.1754689518679; Fri, 08 Aug 2025
 14:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-8-pbonzini@redhat.com>
 <42480805-2aa0-456b-8b19-bf9b4265da06@linaro.org>
In-Reply-To: <42480805-2aa0-456b-8b19-bf9b4265da06@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Aug 2025 23:45:07 +0200
X-Gm-Features: Ac12FXyw-Ba64GLlc7wcw9J0s9S--oeokaogdvDJjzgQDBOu5cNp5zztV4n2fvE
Message-ID: <CABgObfaZW_MWJ2N-SZ_AWNO5jd6iTpRBkrLwrTQDiuiKiBMHFQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] tcg/user: do not set exit_request gratuitously
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, richard.henderson@linaro.org, 
 peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 8, 2025 at 11:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 1a973596d87..b9da2e3770e 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -750,6 +750,7 @@ static inline bool cpu_handle_exception(CPUState *c=
pu, int *ret)
> >
> >   void tcg_kick_vcpu_thread(CPUState *cpu)
> >   {
> > +#ifdef CONFIG_SYSTEM
> >       /*
> >        * Ensure cpu_exec will see the reason why the exit request was s=
et.
> >        * FIXME: this is not always needed.  Other accelerators instead
> > @@ -757,6 +758,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
> >        * CPU thread; see kvm_arch_pre_run() for example.
> >        */
> >       qatomic_store_release(&cpu->exit_request, 1);
> > +#endif
> >
> >       /* Ensure cpu_exec will see the exit request after TCG has exited=
.  */
> >       qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
>
> What about cpu_handle_interrupt()?

The point of this patch isn't that qemu-user never reads exit_request
(as you point out, it does). The point is that qemu-user always uses
cpu_exit() rather than qemu_cpu_kick(), and therefore it's already
always writing exit_request.

For system emulation, writing cpu->exit_request should be moved from
tcg_kick_vcpu_thread to tcg_ops->cpu_exec_interrupt.

Paolo
Paolo


