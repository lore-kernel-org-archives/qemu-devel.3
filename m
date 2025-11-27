Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0616CD116E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 15:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOdY4-0002nS-TK; Thu, 27 Nov 2025 10:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOdXy-0002mK-5a
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:04:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOdXv-0001PR-5q
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 10:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764255873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d5JN4FPfoU2qtGRBHpTdrOxQCkOQwaUNSlaVGl5WoUw=;
 b=Of1xWcVXE810feJ+MCdxkpWtltK6oyFgKwglxiWjl11dgL5UoQ9BeKu7uu0QsECwYzQ/eS
 fJbecgWx4iq+72WkBVTmF0yEZ3s4cP/FAhPeSnibbzfo/vJoztSs2C8G7oWnhwoXMdsVQR
 nlFkuXprWUgooH6yazCYtMenfhdk0i4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-nHwxwVZaOeeHReWomCVrqA-1; Thu, 27 Nov 2025 10:04:31 -0500
X-MC-Unique: nHwxwVZaOeeHReWomCVrqA-1
X-Mimecast-MFC-AGG-ID: nHwxwVZaOeeHReWomCVrqA_1764255871
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ed69f9ce96so26901331cf.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764255871; x=1764860671; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d5JN4FPfoU2qtGRBHpTdrOxQCkOQwaUNSlaVGl5WoUw=;
 b=jbZCOcQJFhNRs8cXgcLwhr9AIeLqdYUHs/P/EPY+4pOKgSRd+vc8eOEsL181GTyt67
 r+EKmsAtwOpEeSX7+0PKP0hO6Ipmtmn3wp0oPL0j2M9QHXA3CkrFeYE36FP0X+zXxqeD
 JYYI1TTwLj09kE6rco6J+Ta9t+3L2SmiWqieVW+eLkkL0hj89u3Buo6cdUUUsoB7do7o
 1PtCkA7cjII27OdeZU0qqvFcll/5mWVJ1yrVVnzbNxfHfaNIQOyTW+7jjioR1hfAQzVr
 /KK6NrWm+meHrlRuNjccAiAbWq3YzQSlPe5vH64rKb0TPreiqo1f2CKPsNVWoRGfbqcS
 2bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764255871; x=1764860671;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5JN4FPfoU2qtGRBHpTdrOxQCkOQwaUNSlaVGl5WoUw=;
 b=SQ9dwguaamzW0o7QAVxILGjQi3hqye24MtMO355B1pbQNA1HCD/XCr1cT8wGsJ0Z1A
 gb8oNeTNV0dR1BPoewoFoWUvkCclML3JL5WjJF4cqqv8iWG8IN/yNM9UkkBHZD+yl+OG
 VKQ/frGviI+WF3LhezzG8jd0C8wciquuPNBoL3mJB5kYuAEPDO8UF+DDxBxSZ8yyqQWx
 95bs9iwwryo2U6MiREX5hgJjB6Az+DOFNfqVuyqLdbN9eMvH6XNlItAJDObb/W9gbM/d
 xufzbv2MaEReN6qkOILLSsiWnf0qpi8sN+E5zb5mXD0eiXMz7jN7zdUIEmtYSV8PD2OP
 Gn8A==
X-Gm-Message-State: AOJu0Yy80Aka4u7NpjpUjdcHKYEIpwPysJ1XFXfFI3L0CRBV5jv+Zfnu
 2b2LPCvot4o08/BS4YVn7vWh+7HfWIrC/2zyDhX7n0XB10WXhaPi1+YQwEG5TK/N7+fCXJU/j+x
 aLqETiOfeYQPBkM/Eg6ynYJ4VBAIEKnm3hRBRd7r8aVJaGrpoiqAhhCG7dPeNHFSE
X-Gm-Gg: ASbGncsXdnL+FRtD4olNOl0Dy/ft3D2B6rRAI2dpiUzkenVZRIkIXMXb1vccNQWSbPh
 JlCnwziM+Q99A6rsdbNRUSUtHqLNj4jv2oKCI4u55wgqjtfdmKaN8qj55fstF2VcyNQhclNgvdp
 zMesuBD2bSntK2sg3uft9a8TkdQLPSrHIuat70HIbq72rZJNKcAjZPMlX34nh+izQ4evEtrgK2k
 bSTe4PSuogqIrRdEVyuk2wyy4DAF1L94UN1uyh/stPq6ebZDsfPfJKsI44SNCOiTmWyZZJ491c8
 m7wkFmzW9Kb93ZUYdcvcHfWHP63yFQBEFz0AgMIDiT8ldK/NQW9+txFgX/XU2XLZQ9un5utF6je
 6LNw=
X-Received: by 2002:ac8:7d85:0:b0:4ee:1576:a75b with SMTP id
 d75a77b69052e-4ee58afa229mr321569721cf.78.1764255870818; 
 Thu, 27 Nov 2025 07:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0q+jG9hC7aC3Vz7k6tpz1VUndT7UiQuyQKmRF7Lbe9RLuTVjni63W2NQvWhkUuYV04UAaAg==
X-Received: by 2002:ac8:7d85:0:b0:4ee:1576:a75b with SMTP id
 d75a77b69052e-4ee58afa229mr321569111cf.78.1764255870386; 
 Thu, 27 Nov 2025 07:04:30 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd34324f9sm9629891cf.24.2025.11.27.07.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 07:04:29 -0800 (PST)
Date: Thu, 27 Nov 2025 10:04:27 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?B?UGF3ZcWCIFptYXJ6xYJ5?= <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: Fix writing mapped_ram + ignore_shared
 snapshots
Message-ID: <aShoe8cgDyFxbfOr@x1.local>
References: <20251126154734.940066-1-pzmarzly0@gmail.com>
 <aSd0ROg_3snWMuCB@x1.local>
 <CAEZNvsuV=++SxRhSXe__zSCO7ShyQheL8yHVsbeAH2J4ReJ08Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEZNvsuV=++SxRhSXe__zSCO7ShyQheL8yHVsbeAH2J4ReJ08Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 27, 2025 at 11:35:06AM +0000, Paweł Zmarzły wrote:
> On Wed, 26 Nov 2025 at 21:42, Peter Xu <peterx@redhat.com> wrote:
> > Now I start to question whether I should have that other fix of yours to be
> > for this release or next.
> >
> > If this use case is completely broken, we shouldn't need to rush -rc
> > window, now I plan to merge all these fixes later when 11.0 dev window
> > opens.  Let me know if you, or Fabiano, has any comments.
> 
> It is broken if you set ignore-shared and actually have any shared
> block, but what could work today is if you just toggle the
> ignore-shared flag on without setting up any shared blocks. In that
> case, writing will work fine, but reading will crash. That's how I

Yep, I suppose either side of reliable failure means it's completely
broken. :(

That's IMHO an important evaluation because we could modify the image
layout without worrying breaking others only if it's completely broken..

> stumbled upon this rabbithole in the first place: I forgot to unset
> the flag and was surprised by parsing error. Whether it is worth
> fixing now - I don't know, setting ignore-shared when there are no
> shared blocks doesn't really make sense, so most likely nobody does it
> on purpose.
> 
> In either case, I need to stop working on this for now, I thought this
> will be a tiny side project that'll help me get my first patches in
> (and get used to collaborating over email), but now it's growing in
> complexity and I have other things that I need to prioritize.
> Hopefully I'll come back to this within 11.x window. Thanks for all
> the help so far, Peter, Fabiano!

Don't worry, thanks for all the contributions even so far!

Your patch actually looks pretty good already and mergeable, I just
nitpicked things here and there as I want to double check on things I
stated, and make it slow to get thoroughly discussed.

Personally, I think it's ok we queue this one already into -next together
with the other one, then we clean things on top.

Fabiano, sounds good to you?  PS: take your time reading, as long as you
agree we put it in -next only, then there's no rush. :)

Thanks,

-- 
Peter Xu


