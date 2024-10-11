Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B2D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4q-0001T5-U9; Fri, 11 Oct 2024 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4S-0000hu-Q7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHdm-0007Ee-Cq
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12ZrqILHoNHapIYh/fjV2N4++8zUJH9vpTOVv3PYXVk=;
 b=g2ywV1GsRkpgc5IVkudNdlYo3MKQnOs0lGJ65B8JBcxBuFr0EzK7oR43AWbZqGi2ycI+/H
 HFtS4N2nxr6CWMyHHTTc6d5Sr+f00TeLSLsc3T/vuaB4+XDdHkAx6sbaBqIj5ZD9rwC9/W
 tzneQX9B5F+JEoAyf8vYvXgSgiO8Fdg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-B-MANh1LPBWdOMK19suPVg-1; Fri, 11 Oct 2024 11:33:16 -0400
X-MC-Unique: B-MANh1LPBWdOMK19suPVg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4311a383111so8439285e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660793; x=1729265593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12ZrqILHoNHapIYh/fjV2N4++8zUJH9vpTOVv3PYXVk=;
 b=RY6E4yUxDsLP5O0F5WpSplJ1fw58OwHx1QFUjY7WcNVKKCOJchA62QuyBk3s1qTqWm
 2iSigqq8Av/5mAAwPs4TJJOHFXRhVQ9dv4BbT4nygL5dLUzIzjKsgiYK1GBUmCQLxhp1
 +wF/y6ik8hYn1KDseSXDr1/zM2aM8DL38In7bHbuqdbXxoPU9EQqU2N23b3r40xvZk12
 3jo+RXWccEinsaAmOjVCiaio6M0etr58iBRbznVeCzf5UpxvDS7xuXXsbbEcrcXGfqMr
 /CPocq8B/w46UHdd0L5R1VeTUe7yWizQU5ix3L/zFI+78+ItYVsxlEV1X360jrrxRhtj
 7FWA==
X-Gm-Message-State: AOJu0YwNodlLyPCJoa85gQgnNA0rrDhpLv/Skm5PNjv4wvD0s6HMHCmP
 jR+k1M7QObmP8adNuJOoZpVdYcHXMYiytZqzR7im3bEgkV6eOV6Qo6cJzuERBnUanbfF7XhVUsd
 hYlbTUGjOVrib1qaiCJIP4eQmMt/myR4rMPCTsVDFr3BAlZxyScdiq7Db9jdSt1ODmLonM2JbXq
 C+ljJ/XWWVkrs8mFu4zzj7/H11lJPK3/z1zKunKw==
X-Received: by 2002:a05:600c:45cd:b0:430:5406:a60d with SMTP id
 5b1f17b1804b1-4311df5a5c1mr22310125e9.23.1728660792681; 
 Fri, 11 Oct 2024 08:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuiOi8OuzuDho2ltmjaYVSrlSmanLXLQz9yRWUtAKMO5/y8MtULPX1gbpJcBIh5eZ56LFmc0AIGyn51yXYC9g=
X-Received: by 2002:a05:600c:45cd:b0:430:5406:a60d with SMTP id
 5b1f17b1804b1-4311df5a5c1mr22309975e9.23.1728660792375; Fri, 11 Oct 2024
 08:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241011111249.47530-1-pbonzini@redhat.com>
 <CAFEAcA-vwCaKhdmcPUubiFQe93z3=7Y3aLo4u6ZbessKzwNDKQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-vwCaKhdmcPUubiFQe93z3=7Y3aLo4u6ZbessKzwNDKQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Oct 2024 17:32:58 +0200
Message-ID: <CABgObfbUQ50S8hT2GEkqZySzfYv4adfVp4cS6rRUVY21yn2=JA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] docs: fix and cleanup footnotes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 11, 2024 at 2:27=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 11 Oct 2024 at 12:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Sphinx 8.1.0 got a lot better at detecting unreferenced footnotes, and
> > we have three of them---which causes the build to fail when the latest
> > version of sphinx is installed from Pip.
>
> In particular we hit this on the macos14 CI job now:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8054823697
>
> I'll give this a bit more time on-list for review from
> others if they want to, but I plan to apply this directly
> to fix that CI job on Monday.

Ok, I'll also include it in my pull request anyway.

Paolo


