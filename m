Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D185CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVeq-0003Ol-05; Thu, 28 May 2026 04:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVep-0003Ob-2H
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVee-0004YQ-Kd
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779955186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OV39SbiNA5cdQboSmfeYAwEeprknfEw1c88lwQYHs8U=;
 b=K06D6J+UvT9pGmMaSHobSYuhAbcJMQBsY2wTACwFNu17nT4B56K4w9Fb71xS7eneW0iyN5
 Kf9EJwc3uDHSp/+MRLvFALWhmFKT/CJJ9wKeBzztcOJL2kvgiWi240d60taGXCK2MxCp07
 T+raqqpaBkaAaNE6rrSFOIF1rQA7sBI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-6mog4aQYPIym8Up5YZ4_jw-1; Thu, 28 May 2026 03:59:43 -0400
X-MC-Unique: 6mog4aQYPIym8Up5YZ4_jw-1
X-Mimecast-MFC-AGG-ID: 6mog4aQYPIym8Up5YZ4_jw_1779955183
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4908af8d7f9so5314165e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779955183; x=1780559983; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OV39SbiNA5cdQboSmfeYAwEeprknfEw1c88lwQYHs8U=;
 b=f4TqgBS+D5sUUX+6Y2DoDXtxb061fNrkFrrsj3keeUf2kS0qPWxeCpWZuW5qzUiVrv
 HnUWwvbZaRy/mXlrCiuP28Y/a5j6l7fXe6ciOjDGgcIAqSrTBA8Pufpgf2Rf/I/RmGo6
 btGqupf03rrl8MaZXXGwZDPInbsV60a/vBsGwsgPtGKP9E10xCdRSZTQVR5zng/6Uaod
 i78prHh8NVJWc0dLcoK9XCWleScf4ydwpqVtpII/LD3fc3xbEWWlNj9wzH4BHlXLPkin
 42wzkqGOcbBJ7eDSi+tT3GjLU9rUTZ9HxJ/NEgHU2n4uLMSl08wk0N9pOEBcKprus6Os
 9pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779955183; x=1780559983;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OV39SbiNA5cdQboSmfeYAwEeprknfEw1c88lwQYHs8U=;
 b=MfqTDh5pePFTT9nUKYSWTPGAkOQfTXpzREg9UvF4APA+cvzWafY7DbFn5Yq+eO9FsH
 6uPrvzg5wG1sQd9vzoOpvK+tsOCcg0krMDZP3VuOhhjMDNfBcExPwWEyKdMxFxKGQusg
 0DYYAuDPMJImQ9bX0nQRFOrgZP5cUeUuZveZ+BE1ibYK+aSIw0fD8y8QkFDpHYpUfu8J
 CFB+lPuvq3vlEC5L+sPcGfg8DAqsdDaiu1m3qRsg0Jm5hVMB4hG4VmPvcyUncPm/CAHA
 CCbh2cGBt6AGZVRHXauRzmOSKUi0K4yzjncilrg1h4k8X+d0lKhq65VPnoaZnbVgql3I
 +sxw==
X-Gm-Message-State: AOJu0YzLFXuJTWu/Ve/h4rGxbfvJD9ekz9pExBXem03PRug3BoinbzHP
 4Z7jWO2qL8otRTYzgdJ3Y+UsItdaE5bi065g/5OBa9LeSmWFc+7VsuK8lKHSECZPvHiJ+tFP4QO
 iKDHNQLIL2tb5iABYdWJVth461zjXIiegCesM0G6YI4WHyDOUfztIIJ6A
X-Gm-Gg: Acq92OFZo/2BzYxMOUIdKpBwX9JviVi89klFhxJB+oMmsS3Vl3v3gsPu9uABijD3D6O
 /eHmcX/jnB9KhMgXABW+o1DM14jH4jck3Ci/j4rjsqsXkchqTd4/Z/kM+MQqQQNDf1Us8gYvUe0
 M4bcJsCUNFMvHOw/cNjp+AoF/VbHOqiTRlxwVOSgnWy3sOijGsu/QvRhbiXhHVobpq5QXRgREfn
 jH9p/fYKmXpoZlITfsE9ijPxheRMyE93wff8ILRJ5NhNyiLHEHekkR2FPOP4RXEI/uwrogTrGgN
 IPtXnc+VCXBIbeifTDot5G7PqQdOs7qd9gukUzV335c4D9muaN9jeiP6TMdyhnMfVcuuDylfCQR
 tHdDKZ8wdsR871k0l5SBdWkQ=
X-Received: by 2002:a05:600c:4ecc:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-490426d06c0mr438732525e9.18.1779955182496; 
 Thu, 28 May 2026 00:59:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-490426d06c0mr438731995e9.18.1779955181989; 
 Thu, 28 May 2026 00:59:41 -0700 (PDT)
Received: from redhat.com ([46.210.234.60]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490923613d0sm41452335e9.3.2026.05.28.00.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:59:41 -0700 (PDT)
Date: Thu, 28 May 2026 03:59:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260528035815-mutt-send-email-mst@kernel.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <20260528034301-mutt-send-email-mst@kernel.org>
 <CABgObfZwaiu4A2b2EFuFRA4dbWfHrDYEfiq5_-mf+zQpsYfTLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZwaiu4A2b2EFuFRA4dbWfHrDYEfiq5_-mf+zQpsYfTLQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 28, 2026 at 09:53:12AM +0200, Paolo Bonzini wrote:
> On Thu, May 28, 2026 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > -How contributors could comply with DCO terms (b) or (c) for the output of AI
> > > -content generators commonly available today is unclear.  The QEMU project is
> > > -not willing or able to accept the legal risks of non-compliance.
> > > +If you wish to send large amounts of AI-generated changes, or any other
> > > +contribution not in the above categories, please get in touch with the
> > > +maintainer beforehand.
> >
> > To be clear, the implication is that
> >         These can be accepted at the discretion of the maintainer
> 
> Yes.
> 
> > Maybe make it explicit.
> 
> Ok.
> 
> > > +     AI-used-for: tests, docs
> > > +     AI-used-for: code
> > > +     AI-used-for: code (refactoring)
> > > +     AI-used-for: code (prototype)
> > > +     AI-used-for: research

BTW: commit log ?

> > Why include research here when we also explicitly say:
> >
> >         > +These boundaries do not apply to other uses of AI, such as researching
> >         > +APIs or algorithms, static analysis, or debugging, provided the model's
> >         > +output is not included in contributions.
> 
> I suppose it can still be useful for traceability. I copied it from
> Kevin's proposal but I can remove it.
> 
> "Research" may also include using a script written by the LLM, which
> is encouraged in the first section.
> 
> Paolo

but again, if the script is not merged, then the boundaries do not
apply?

-- 
MST


