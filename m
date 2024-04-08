Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A8C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsaT-0002dz-OA; Mon, 08 Apr 2024 13:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtsaR-0002dd-9M
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtsaM-0006gg-Bi
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712596508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+AGk7G8Cl6WLT2CHBTlDFDkUZnuXOa04t/zvJtIwT4=;
 b=eAcIgD8yuuewljmQrIUJQoBpwL51HiUlwEnjEMElREPKxGCCg56Qy2IitGF3TCqXDpaAKF
 X+2u8huQluTGY//Eb2V4Di3WTBAhxJ3xx5QY3fzWJMt+ynsLtUQN32+6CQwOaFAL4hBm45
 cVfZ9dkDlm9HCieqRPmavGiQRWBSkyU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-fliwi9oINcqcMCDOxkGxhA-1; Mon, 08 Apr 2024 13:15:06 -0400
X-MC-Unique: fliwi9oINcqcMCDOxkGxhA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed489edcaso2777513f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712596505; x=1713201305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+AGk7G8Cl6WLT2CHBTlDFDkUZnuXOa04t/zvJtIwT4=;
 b=DPBCrgW8PEJ6jsWRSNDGhzdXTW65u+gSwc/iHjjQV9mZe4ovuQcp81+RPMmcHO2Zfb
 FWNMBexVI0/n1EKVckGFS9IAjFgLb/ZG0LC238zlHKtbto1S+aW+uogYTH9kHIzCAD4A
 pbpiSWszQRV0BVeQ759KQT6u8aNdNfklL/NcyW0cbEbj1EKo8azPhL3i2t5+rEu66vHG
 zC+X0VXolUPKRsmrZSZVYRBp9Yj0u6/aPZX30+rRiPtLUWBxWX3ipfZF1GFkzMnQfp7M
 RmRtQBiL7UhhXoiLgcBEtn25RcBKr5sgEQ7ZsB9yEWVI+BGrKTMkEsBhmGt6W81wifAl
 EdcQ==
X-Gm-Message-State: AOJu0YxJWwqaKAkOg59uEMCedXtWE4waphfGN73Xw/Dm5OwYn9DizMZz
 elWDav9KqV8czh1e4gb3Bm9ftnWDmgQa8vg5WPGHl7rpNSLgDth2AsDABLkY2wShBa/dMEGidje
 wGhfaItvWC5ahZAlBWSLrRT+a2VZo0/XB4fn1T46Mi+wButPmM8SiaXJXa29HS0nIF7BsgHTxhz
 q7xJwrDbcaStTaZKRNS9m1knCHOyc=
X-Received: by 2002:a5d:4d4d:0:b0:33e:34aa:d78a with SMTP id
 a13-20020a5d4d4d000000b0033e34aad78amr6196304wru.8.1712596505449; 
 Mon, 08 Apr 2024 10:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9UQNiFsSx4U02d+t9OqmrybPpAAlHGhniRh5971L3BDHn9qLQI3DWVYnGemE9i3xEZ+ceVe9BI65fNh0QmlI=
X-Received: by 2002:a5d:4d4d:0:b0:33e:34aa:d78a with SMTP id
 a13-20020a5d4d4d000000b0033e34aad78amr6196292wru.8.1712596505100; Mon, 08 Apr
 2024 10:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-17-pbonzini@redhat.com>
 <c47df7e1-e6f1-4170-a024-045eae850c3e@linaro.org>
In-Reply-To: <c47df7e1-e6f1-4170-a024-045eae850c3e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 19:14:53 +0200
Message-ID: <CABgObfZFEJ1N5sXg0Q0D_80HKOXYw_ikyoo2+TsCME_hnVdVzw@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] stubs: split record/replay stubs further
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 8, 2024 at 6:59=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/8/24 05:53, Paolo Bonzini wrote:
> > replay.c symbols are only needed by user mode emulation, with the
> > exception of replay_mode that is needed by both user mode emulation
> > (by way of qemu_guest_getrandom) and block layer tools (by way of
> > util/qemu-timer.c).
> >
> > Since it is needed by libqemuutil rather than specific files that
> > are part of the tools and emulators, split the replay_mode stub
> > into its own file.
>
> I don't see how this helps.
>
> With qemu_guest_getrandom you still pull in replay_read_random and replay=
_save_random.
> With timerlist_run_timers you still pull in replay_checkpoint.
>
> So both stubs files are still used in the same cases.

But user-mode emulation does not use timerlist_run_timers, and block
layer tools do not use qemu_guest_getrandom. In fact the next patch
wouldn't compile if that wasn't the case.

Paolo


