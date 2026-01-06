Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6548BCE9D42
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 14:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd8RD-0004P9-Kt; Tue, 06 Jan 2026 09:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vd8RB-0004Na-Bx
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 09:53:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vd8R9-0005Cf-36
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 09:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767711208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxv5xdbr9yhpZgQ1UqAIxwXI3WoGY8f5RkmcSflmVSE=;
 b=OQ+I5YxfasAn1U1f2srcNhAipJ3D2T5dnpWxWMaTlqB4FfjJ3zyoP0Rf75SIsm0t+iJAwm
 kBzgdJvig0hukAOHuHT+Q95IeSLV9rC+DiJl7kIPNNYWJ9rrgoBqlBGOkj/oF2hpQhaPBI
 1AkKsLLY0h6YOsSKpGgGzvjGwae/4Zw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-xJ5M-PoxPTyZfI2kMhafzw-1; Tue, 06 Jan 2026 09:53:25 -0500
X-MC-Unique: xJ5M-PoxPTyZfI2kMhafzw-1
X-Mimecast-MFC-AGG-ID: xJ5M-PoxPTyZfI2kMhafzw_1767711204
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b17194d321so150715185a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 06:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767711204; x=1768316004; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dxv5xdbr9yhpZgQ1UqAIxwXI3WoGY8f5RkmcSflmVSE=;
 b=e5d6h5jsYacb/BUcz8Vm+A6P79FOGqeH3zNsudQjCgqie4sFvwOgmBAYqad4AMGBU1
 y01b9XnOccurz8Zpoh5fuJfxUd9dLywpP/nrpEcQJWz8XezWCMpdN6x6yuO5XltxywbR
 C5P8pysjdv3a+T2uZG3fe/8/yC0UVI0Z9Uk30Yx1tNb8Us2u2daPQk04yYMdaJspNiUy
 quWxA4U/xlep3Q6iNmk0/7ytuImjJUbE1XixcY4gom5i3o0jlkESSm3yC5VaYi0rLZji
 Y6GK1MomcPdhUKzn+k6kNyYSJ6fPVHW/fdvjTWGjYX27jpYm93HD6BCnt9VgWY1y074k
 dW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767711204; x=1768316004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dxv5xdbr9yhpZgQ1UqAIxwXI3WoGY8f5RkmcSflmVSE=;
 b=ZTwsDnjpuEJvdtDu0wn7Xwp8j7oRCUbpm6dTmuPJ0zqoa/WAzJtoAcLMftNnI3aLo8
 icjJbrB3Jby6GTls83YtRHt7p52QHUELDiiFf401GgR4l2VewflFf54N6QwCIPMlEBpv
 NlOWpLK+EHilyiabh3HK520pBjQSufJBdW4zzyt2PNFYVHcul3USM5Sua0u4vBE2T/o/
 NWMd1B6+XAEhRFlstb0oRURDd6K2rf9AGVp/e9NZ3XTTyDJkj2RbfsXOU5hKvsXYT8pQ
 hgmQCg3JF+3bqojI1vJsXWR0n8SzFgJDd5ALgV+sX7ZreOefa9j+N3XNRepq610qC9Zf
 vq+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJFl+s+XWDEFtLAAZ0sMIOzpwvzUy35WkPa98miVXZm77GkOK4YeRyX+pFox/W2mkRazuNIyW9fNlP@nongnu.org
X-Gm-Message-State: AOJu0Yy/fizgm433xp+ttdo9anrJAOJOhB+6aI2TKzklK9gJ5EuTCN3J
 l/H/W8lCpfwkj1FasYWj1ITss6WBvvMjdaC9OPOBeWjaFvIYkcDV6TWIusElXbnhc4E8C38J/58
 Tmlog44f+tUxrsbpqfMkjGBtX/HHcsf0uzqor9hy/d970fiiaIP6pEdxb
X-Gm-Gg: AY/fxX7erbxLFNtAqGrhNgIrFmbx5b4oTx+EG9AkhZXfY7YtzmpE5CCyt9MuMxxBOEk
 sO769BYGGitonBktmVBg1l+1RhAA9/senPvrbf2DDAQfLx+pJymbSSGsNabKBXoNhWaeYMIsfCp
 pacMbiaZFnniCOh7HjhRpILs3cYWhvmiR+2h7wKOj4Q/oOSs2L2EXAGRyrAKfFO2KcnlknxKYz+
 CZM531b3bz37Blrh/C4bwln1fN3N2AuTeGRIMJcsdwAzIah51KDqyILcX53GOpqAGRwLZozytVZ
 MfjF/2/2r0uXkHIwE5Jr6woecN6Pnz+f4YVM+zq8c/jR8K7AQ5+L6j3dWkUJeU+AkdOCe5EuQyP
 y9hI=
X-Received: by 2002:a05:620a:46ac:b0:89f:52d:8560 with SMTP id
 af79cd13be357-8c37ebc0c34mr476645785a.47.1767711204526; 
 Tue, 06 Jan 2026 06:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFElmLnGDpmW8owymTNFodkqBVw2WkMvn2z9YTcPbrt/HWQOppT8+1ZXTLqBdW/b5OvQitzWw==
X-Received: by 2002:a05:620a:46ac:b0:89f:52d:8560 with SMTP id
 af79cd13be357-8c37ebc0c34mr476641685a.47.1767711203984; 
 Tue, 06 Jan 2026 06:53:23 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b8b40sm180248185a.14.2026.01.06.06.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 06:53:23 -0800 (PST)
Date: Tue, 6 Jan 2026 09:53:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
Message-ID: <aV0h4siUlTSqJHaG@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de>
 <CAE8KmOweak15R4Ji6F50b_za67q=un_GDSEMGCRTYeQKod7zQA@mail.gmail.com>
 <87cy45kzo2.fsf@suse.de>
 <CAE8KmOwgDboiN-q=jt0Jic4Gqdsp49nyRC7iwKrQokdP3h9yVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOwgDboiN-q=jt0Jic4Gqdsp49nyRC7iwKrQokdP3h9yVg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jan 06, 2026 at 04:24:23PM +0530, Prasad Pandit wrote:
> Hi,
> 
> On Tue, 23 Dec 2025 at 20:34, Fabiano Rosas <farosas@suse.de> wrote:
> > Yep, 10 years from now someone will look at the code and the commit
> > message and be confused when they don't match. Also, for anyone
> > backporting or searching for bug fixes, it's good to keep things tight.
> >
> 
> * Looking at how we are changing function names, I think it is best to
> avoid stack traces in commit messages.

Please always attach a backtrace when available.  One can always checkout
the specific commit with all the correct function names.  Renaming is never
an issue.

Thanks,

-- 
Peter Xu


