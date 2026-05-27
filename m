Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94010CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 17:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHhK-0003pY-HO; Wed, 27 May 2026 13:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHhE-0003pC-Sn
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHhB-000573-Q7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 13:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779901528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n7LK+jKpKLLYpAjVo+T3znI42mgNgn6TCwc3lCEQ2MU=;
 b=ankepbojwvLUa/oMP3mwKua2LT+WAVgcAwT4XtV+c9L10ZbN77LEAG6r4XgCYAW9U1U9O9
 WnLFQBpabn6jy3YwFxFV803tpNgybb+TrgHDkVHLsFuUoHqgdh5mdxcZeq/i/oMswaZBaR
 0HSCsgdGaK1WdNBr/vlEAdwJTXYJoSo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-fRXxXNhuMKa62AuVnGE8-A-1; Wed, 27 May 2026 13:05:21 -0400
X-MC-Unique: fRXxXNhuMKa62AuVnGE8-A-1
X-Mimecast-MFC-AGG-ID: fRXxXNhuMKa62AuVnGE8-A_1779901515
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fe6894f3fso73158005e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779901515; x=1780506315; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n7LK+jKpKLLYpAjVo+T3znI42mgNgn6TCwc3lCEQ2MU=;
 b=tIIijjl0ZLD0XmLIGu8P0OVY60GbUOOruTW9kkwJFmmBbMNS5qOungiUyHJflnB5JG
 g2me7DVqqJp2iW7WqSiBv7pD3d4gUifp9lE7V/+87FGgctnUYChjNJuQFXjE1eEY5yk2
 vHiTItF23SmqA91h3OGhaLk08yGfY99a72IK/lw2ao9dTalfkq9uMpshxbIBJvBVeak6
 Sqxy68EsenAJyXnJuGo5reeevdIiuZ9nzIRvaxwXsGvS0YHAELEf/nsA9zCZf6Dc0dOv
 GVwvhcl6ZmmB3YJ1/8+o+YgeytXG75V2mfP9VgSNo1fL1Zo58ixB341CimvGMWOv8X0Y
 CwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779901515; x=1780506315;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7LK+jKpKLLYpAjVo+T3znI42mgNgn6TCwc3lCEQ2MU=;
 b=flQ77eo3i0O4n8BV4lwnAhPkkPl4cNeNj3QDhH9XR70m3R2H4QV1AtWATJ3Ex7ytcx
 6V5abIMt5YBRGFdC63EyDpiSalkQ8yRGFt0TZDX2kP3V/JCyqaixnPM09K8njuGTofWs
 URFxGwbWpi2Q70RKp5c6Ff8kV2ibyF7IG2eq0OwXueYcN8AnpcCyqDCa5MiLRxpruf4J
 v30PPUglbq2aud1lIxCYKLZFJV2qjCWzVZPkdpIWqJ0cBnMhD+dhqYzWYUWaguZ0nKIg
 Uje8wRvSzeNZUbmg/YqcrGS0n6kKMFpnPFOAjbg+RbCDJgtulrsEBIOrzUwIe3zbN32x
 4z/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ov6fNRBlZbKvy6AvuZaFd0R/8AlYrMErbd5JvR3sVOMM4MqNrsikae8UYDDLkq3sENUfjNOUSL1u5@nongnu.org
X-Gm-Message-State: AOJu0YxfvJmmB88FCiQAiSIyMAftGKGxb4sBf1f2Jsm8UYfS/HqOM6eA
 J2LcuHcEseWgYPrMCmUEwPDbdRC/MOcrbJnlIZx+LoER92DrbGLxDAYUwsgIbKFo3Q0nlepHRQe
 GX3oFMDYHIn+h0kBY/0CLfSpQkLUkOJoYOY1Zk4KvQjX+rTmw4/ChzMQ8
X-Gm-Gg: Acq92OG6W3W1kty3MwMh5IdGcKFyTcsU04bB+21jR84npiE4PArZla7Ogs85pjxdDtI
 GU3nC3B9bQ0uVeXFBn2GAlBROdHzd41nvc0LvVenZSuS04iYjPdSJ2dVebZk+la7tvQopl9ARzi
 HSbJS6pkE1Lx0jR5XYf4GmLQ9q3c6DUdkSjRMkItVNO8OdZBE5L+552lfHTcAS8NLtclI9M/YDv
 0q14dLweyu7qnyq9e9nwCETi7ZAMPfun2Fyfgo3To1B9FWQpfZ2DDhWjF0WoiVGzdZphnPQjPFy
 NjGjAuVa28ZH0jXSOz5ICCxaoFquyU4R1FP4Jlv8y36Ve/GEi2Lf+CxNWK4SpWHp5r5d9nXSYm9
 O01GCJ9gk0E6E
X-Received: by 2002:a05:600c:6303:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-490426d7025mr405888615e9.22.1779901515141; 
 Wed, 27 May 2026 10:05:15 -0700 (PDT)
X-Received: by 2002:a05:600c:6303:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-490426d7025mr405887865e9.22.1779901514584; 
 Wed, 27 May 2026 10:05:14 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm606164435e9.7.2026.05.27.10.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 10:05:13 -0700 (PDT)
Date: Wed, 27 May 2026 13:05:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527130446-mutt-send-email-mst@kernel.org>
References: <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <8416cfdf-b9a6-427c-8118-fd2ed7661f2e@redhat.com>
 <20260527124115-mutt-send-email-mst@kernel.org>
 <CANCZdfqSEzhjE5Ts+B3hL3GSmT0vw_Q=t_-4BkYugOUNR4_+XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfqSEzhjE5Ts+B3hL3GSmT0vw_Q=t_-4BkYugOUNR4_+XA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 27, 2026 at 10:57:09AM -0600, Warner Losh wrote:
> 
> 
> On Wed, May 27, 2026 at 10:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Wed, May 27, 2026 at 06:05:47PM +0200, Paolo Bonzini wrote:
>     > On 5/27/26 16:14, Warner Losh wrote:
>     > > Why invent something new here when Assisted-by: is used elsewhere
>     > > and is likely more familiar to other users.
>     >
>     > Because Assisted-by was invented by AI companies to get free
>     advertisement.
> 
>     Jonathan Corbet is in the pocket of AI companies? Or Sasha Levin?
>     https://lore.kernel.org/lkml/20251223122110.2496946-1-sashal@kernel.org/
>     https://lore.kernel.org/lkml/877bqtlzug.fsf@trenco.lwn.net/
> 
> 
> Yea. Assisted-by was not invented by AI companies. That's just rubbish.
> 
> See https://github.com/anthropics/claude-code/issues/36105 for the open
> issue with Claude.
> 
> 
>     > (It's not just me; see
>     > https://akselmo.dev/posts/stop-advertising-in-your-commits/ for an
>     example).
> 
>     Does not impress me as being either super informed or super
>     professional.
> 
> 
> Yea, seems crazy.
>  
> 
>     > Also, it does not answer any interesting question.
> 
>     It does for me - I will learn which models are more likely to produce
>     bad slop.
> 
> 
> Same. I can tell the difference in the degree of slop between the different
> models
> and have sometimes selected the older one over the newer one because it does
> a better job.
>  
> 
>     > Not using it is also a good way to sieve people who didn't bother to read
>     > the policy, now that I think about it.
> 
>     In my experience, AI tools add "Co-developed-by:" tags by default. One
>     has to read the policy to add Assisted-by.
> 
> 
> Co-authored-by: you mean? That's what claude adds for me. I had to take
> extra effort to add the new Assisted-by: to my patch review. 
> 
> Warner

Right.


