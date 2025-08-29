Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE2CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjJ-0006aA-7S; Sat, 30 Aug 2025 11:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us7SW-0001UC-94
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us7SS-0001dl-Iz
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756506027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/CCFPyH0dGcMXSfRt1wQ2VDyryFvhni+oktsJKv6oY=;
 b=REA/lWfFzE7+BDV3zRoTY2UHOHqsVnpafb+qOrSzr1VyJgGPLxsGJIfvlXoiZgRZejYhce
 os/uDBEPC85pNBHsdmh9sQvQunLnIhBK7io3yz5n3POjRmUf0igIZJFlCU4qj8VrwugqRn
 E8qa3nvpmSMWJm+ytnqrn4QIXvE+/CI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-OSVCCgE4OPCzJSUYy9TE3w-1; Fri, 29 Aug 2025 18:20:25 -0400
X-MC-Unique: OSVCCgE4OPCzJSUYy9TE3w-1
X-Mimecast-MFC-AGG-ID: OSVCCgE4OPCzJSUYy9TE3w_1756506024
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3d17731ab27so333501f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506024; x=1757110824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/CCFPyH0dGcMXSfRt1wQ2VDyryFvhni+oktsJKv6oY=;
 b=f/Fb/LWvs2qipjGj52c+IRFhNHQLv38O19E+c5AQx5DWCxJoxZODYmnaSIvgQ7jwVn
 MaFfenhUVk0NLu3dRvlwUT6Vt3rl+m0I0qZWg0T/LgtzaT7XTpaMhLDorFX9mpVH7h6c
 Y7ziK83F1mcv9EtvFkH7o0xi4lelDsbuXC5UZ2o1fUcFTQpErwf9Aar1+myXF0EsClFL
 8L6UMjxNKHyVN6yls5MbLJeop4y8J7a6YoVdcVjJkmNx4nNHSwnC+Gu1QDp+l6iKWNXX
 sHrn+Heotx4WPjwxkzvUxUaLZPHTyM/3P/jVyc0cjIcNIzm9vMmK16AWh/kf0ziPMBxX
 gHwg==
X-Gm-Message-State: AOJu0YznZiIL0xjzsjZuN1M3OU+3FRbFiiwiHEyr8099/e53nrx2RtmE
 CLU5pnOligQIbLr4O7Jim82N3fspkp99D4ATNC2oVinacGzJ4w5jZfYoeB9qj8QzT675UhG7FlJ
 QOHlk7zZAcRyzLFon6S+s3Q21oCQ8odtIgbfIBcVg814MfvvrcSd5IFU8Yj4yRNTSUUTvj57sJT
 fCwnmuxDf/O0sTz+sMr7piGYczTvi30aU=
X-Gm-Gg: ASbGncsr4YpH3PmkwMsh1WP8if0rNZwDOcFwCqam6O8btth9FczRJKroPI9rk5EUFgd
 sBfshht95GeP0sAjRieA6peZyHXCgaPTm820O2loVdRfVKOzF/Vwvm+MtXfU2NKEK0Rba/bzoa5
 kGvX387UcgdqfSDG+Vw1Th8g5rez2e3/s508QWsXPFJUhY0ZwVGO1JVejYb/n9zbBu4D2DyaLJO
 4TGv4MBWobK/UnLbxXOB711
X-Received: by 2002:a05:6000:1a8c:b0:3d1:2163:ccb3 with SMTP id
 ffacd0b85a97d-3d1def66e7bmr118218f8f.42.1756506024368; 
 Fri, 29 Aug 2025 15:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz+S86pLNK2KCZVzgajemsILgPM6DTg1/5YY5Yb3z1ZryrxKoE3lyy+ECXqC9QK7L+9Bc+TmHI7+FqlDtoks8=
X-Received: by 2002:a05:6000:1a8c:b0:3d1:2163:ccb3 with SMTP id
 ffacd0b85a97d-3d1def66e7bmr118214f8f.42.1756506024019; Fri, 29 Aug 2025
 15:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-12-pbonzini@redhat.com>
 <da327e5f-69a1-4480-bb7b-14bd78ec69c7@linaro.org>
In-Reply-To: <da327e5f-69a1-4480-bb7b-14bd78ec69c7@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Aug 2025 00:19:44 +0200
X-Gm-Features: Ac12FXxHvcUbiJ13l_CmO2oSGcROjEf64TuLWqZAARF5tnkeLHEiw7N3UJQMUbY
Message-ID: <CABgObfasWhcL6MjJdAvDfaKG9sczqUccE9YYm-A+hE=xfaKoEw@mail.gmail.com>
Subject: Re: [PATCH 16/18] cpus: clear exit_request in qemu_wait_io_event
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, imammedo@redhat.com
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Aug 30, 2025 at 12:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > (b) cpu_exit(): store-release cpu->exit_request, or
> > (b) cpu_interrupt(): store-release cpu->interrupt_request
>
> Mm.  This is the reason we want the seq_cst of the qatomic_or.
> Perhaps comments in patch 7 should be expanded to document this?

Not entirely.  There are cases in which a relaxed RMW atomic would
also work, for example this one in the CPU thread:

    if (ctl_has_irq(env)) {
        cpu_set_interrupt(cs, CPU_INTERRUPT_VIRQ);
    }

and there are cases in which store-release is needed but atomicity
isn't (the ones under the BQL). It's putting the two requirements
together that requires patch 7.

And to be honest I am not sure there are other cases than the one
above, where cpu_set_interrupt()/cpu_reset_interrupt() is called
outside the BQL. But it's really a matter of time. Sooner or later
someone will move the APIC or GIC under its own lock, therefore we
might as well keep things clean already. "Written only under lock X"
is handy but I prefer to use it with moderation - like it's okay if
it's a primitive but not if there are dozens of calls across the code
base.

Thanks for the speedy review!

Paolo


