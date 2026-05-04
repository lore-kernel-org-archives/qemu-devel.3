Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7033FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxKk-0000Ux-J7; Mon, 04 May 2026 13:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKi-0000IK-W7
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKh-0007tg-EK
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VmdzW2Ktc9GvX4B7qryoazx3tlfg/tkLQ4c/X+9ouxA=;
 b=fW2zlqkkFtH3fOLwTilX9TecKXxMmfvpjtctNW8DUyYxdPNWvdDiTy0jSl+9veRSDa8MTE
 JwiPlmbYKXDpYOo0VG/BktaL7GW4tFhHOxh8i30lgSj9YokND0X4HZbfOr+bB9gqUMsFml
 G4TfYDTR+Y7TYpc3S33FmnJlMFH5ksM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-A0RS74ahN_-RYBlRbObwdA-1; Mon, 04 May 2026 13:43:49 -0400
X-MC-Unique: A0RS74ahN_-RYBlRbObwdA-1
X-Mimecast-MFC-AGG-ID: A0RS74ahN_-RYBlRbObwdA_1777916628
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36514eb1194so4044343a91.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916628; x=1778521428; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VmdzW2Ktc9GvX4B7qryoazx3tlfg/tkLQ4c/X+9ouxA=;
 b=dQnp82I9Bxf2qsh4sW6/9nqIm/v5OWqiHBvFFC1wdBiTvsdgd1X+7mf+aIyxitOaLU
 c/KgmmHet+9cdBk02WbMS6lfv6a5NL8gcVcnsE2yFdpoNkKoIuCyEOvS6A7MbBBqBf1W
 /DLhjyRBqIrYsWPfHwmWqBz2Z9JKGqAC5r+mVh0v8Ss2GyOhpSaqtptGbK05dX/Kx7dk
 61Gl90wrJ0ayx/4VpvmELeSqN3ValgL3HmnE49LyMLHGdKyggsuK5o4VdxKlL2jZESZk
 9/0LnsQZhewEBXQLNVaw8G/55Vi+Fh/BY/RrEU3oceP43SorxdNqTpBHA0LvwhGHzJYM
 sDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916628; x=1778521428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmdzW2Ktc9GvX4B7qryoazx3tlfg/tkLQ4c/X+9ouxA=;
 b=X5CAkOaXbE8nW1eSFIanTF5taotB9XImV5aKpDDsn3EBjMIsRCX7FWBrrrfr7+0x5y
 oe2t+REP3Wm1dug1pp4t2Wuma09exOpexmtifhlUnzng/b6fziev4kNUbPzjpLmKN6an
 MTp/JZZb/LCY07jVEY/sM52nBV3klIlAklkNcq8eYRdDKv8rLRGC0UP0HiJTM0qYVkt6
 bobwPipLQumr8Z42fPz4yfIa9snpuUUho3IlawAQHqEaoyU17RcMmE71iPrek47zHTP3
 4K+5hQnUC5FXupQVKfgLzjcI+ImLwu/okQLuO2mT8NQpjGpcfn83ajQekFHFc4lmKv9S
 RP8Q==
X-Gm-Message-State: AOJu0Yw0IKF/tUy9Rfm34CtsgeSi6AauFM5yXuQgAAPpuEi3eBYFLmm9
 k4ZDqTjTBwoplDOmyqOdF11qS7uP/khH4aPTjuv8YqyF2sh9x/Iq9CNpFfQteMb82rYcCAIWDka
 MzxQx+5wC9XJIZt5+pLULIWhbphX5GvSICIfzecPCDtAvberHVC3gEQPv
X-Gm-Gg: AeBDieuCHOisYMBFTuBzDYBWF32eokj0O14EkiUIKZcWeZAGR7iFhKsVs3MYiCCN6yf
 Hpv4ocrf3BA+I1I834TMD5AUeaCQAeGwx5isdEAixpfYRCjeP7Cd+Sj3EXo69j3scFd4cpYROFd
 VaSdgWDimH6X3A2vm7p4FpgXKMnoFVmgL/0OSvtqWWKPUhuDY6yazkKKPk9hokPytHLz5aYnD+b
 Q9eLbKIFU4QoH5g794HQiOL4TjGrGwC28IZsU5uOtkxSkuK1Bqu+sPprxKDYv1UCtz2EcOj15Fl
 JbkmET9qoAFL73PzRzciPDRs+5xGFCLHVNvGeGhU1XyHUkM0mv/HHKwlw3UxDd5qgO6boP7VOb6
 tw4UZpHrKCNn3N/z+tKgokw==
X-Received: by 2002:a17:90b:17d0:b0:35f:9ab2:a5b4 with SMTP id
 98e67ed59e1d1-3650cda4881mr11191292a91.6.1777916628194; 
 Mon, 04 May 2026 10:43:48 -0700 (PDT)
X-Received: by 2002:a17:90b:17d0:b0:35f:9ab2:a5b4 with SMTP id
 98e67ed59e1d1-3650cda4881mr11191266a91.6.1777916627665; 
 Mon, 04 May 2026 10:43:47 -0700 (PDT)
Received: from fedora ([49.36.108.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caa7ee38sm107135075ad.16.2026.05.04.10.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:43:47 -0700 (PDT)
Date: Mon, 4 May 2026 23:13:38 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
Message-ID: <afjaysNSiES0mT3f@fedora>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
 <f0658044-a615-4255-b6a0-be8b67ba14f3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0658044-a615-4255-b6a0-be8b67ba14f3@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On Thu, Apr 30, 2026 at 03:49:47PM -0400, Stefan Berger wrote:
> 
> 
> On 4/22/26 6:30 AM, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > - Add subsection in VMState for TPM CRB with the newly introduced
> >    command and response buffer GByteArrays, along with a needed callback,
> >    so that newer QEMU only sends the buffers if it is necessary.
> > - Implement a migration blocker to prevent migration of the VM if the
> >    user manually enables chunking capability, cap-chunk, but the machine
> >    type does not support it, using a new hw_compat property called
> >    allow_chunk_migration.
> > - Add a post_load_errp hook so that during a migration, the buffers are
> >    validated before destination VM is started.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/core/machine.c |  1 +
> >   hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 72 insertions(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6d27cf69a2..b590af0125 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -40,6 +40,7 @@
> >   GlobalProperty hw_compat_11_0[] = {
> >       { "tpm-crb", "cap-chunk", "off"},
> > +    { "tpm-crb", "x-allow-chunk-migration", "off"},
> 
> Nit: A space after the "off". Also in previous patch that added "cap-chunk".

Thanks. Changed it in v6.

> 
> 

Regards,
Arun Menon


