Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C72C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLO3-0004tX-Kx; Tue, 04 Feb 2025 11:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfLNy-0004tG-BQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:02:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfLNw-0003Ho-7D
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738684965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHYlBMx7vk9cFFvWfO0Lhj3di4vJog50Rx057mtwD/Y=;
 b=g9kdHa7TPzc6Ig/qsNopbzc4xoJrpPD+Z8103klqpyAwjpn4Z9OP3mJGb5ORQ8e+M/dyUw
 Esy7SKZ4yeXbRWErTW7El9rh68GKFJ6xlQhPc7fjPGAvPQE0y7qw9xK0hLYShV4bV8/sUK
 giugZiChIjxvbWHCG67xSkmSU30hpmY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-IcHBqIJlOq2ZpuswvDk-_w-1; Tue, 04 Feb 2025 11:02:32 -0500
X-MC-Unique: IcHBqIJlOq2ZpuswvDk-_w-1
X-Mimecast-MFC-AGG-ID: IcHBqIJlOq2ZpuswvDk-_w
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6d0be4fb8so990412485a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684951; x=1739289751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHYlBMx7vk9cFFvWfO0Lhj3di4vJog50Rx057mtwD/Y=;
 b=NtvSqV8I+vvdUa4YSkimVWXQ3TjxYSbJGZTKazTWtvDquZ+aM5BiOC0vZ2kanN1T3w
 iNNbg5CsjMenI+96CQMq6ct5iqp3T40gW/kNTxA4LesnKJ432S+w525SZGPAZhiHJp46
 YzqYaQE9C/vlFDOwJxP7F7sM2siwB9tmriXImup60mL0RlqjvTFwKmuowfxZ2rhRyYyY
 3dXgDDpzuyZ5HurXUFEcUBNiH/7aSKBhr2YxdfUDuKQm5SeV8vfz44vZNlyLVnraXYex
 hFiOmdx3f49VJboSCi2oVy1yxDudb2bJ3cAYBlhsWA4vbQ7iGnGNsGAtXZgiF/rw7fV1
 lHXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV+FxiAkZmL/nIn7Q61kl0wDG9hOCYkGJtFWsCwANedAL5Sp5Ge/VkdbEtF680mNie8I7B62g0fn4E@nongnu.org
X-Gm-Message-State: AOJu0Yx8q3D9CqWjGSxQHhE5Ng+XTWUb8PMsqbPuU4USroHrNSjZrine
 FasUx9QoJAXukrxZ8KzjyMsxnM/7VdkMDYvy1Nr7XTLrLW1nGujXnSTLGui82SkkchUIq8jvkKA
 e5C3C9I5/IUD6kQiO1QA/t4L+F6tK/WXmGl/m76fjwLqLHoIaBCHu
X-Gm-Gg: ASbGncuBewHZRnzbKDTbzV7WZIH+ovNQa905f8oTn7gNJufmSyTvV+qCrBL2gdN7l7o
 roULJJJxwVMZTF7totH8qRPTNR7qi+7IFBqZ1In+Vnr6kO2ctW4iaPkyG5xQ8pyz1CfhQEXKjFZ
 uQVMnfwdL3LHidUxNe+n83w47xDAEAvS/7jR3edljXQveHLV+DPHiaD3sC7Jzg8p7tCJRp7yIxx
 M7ofDx17H0EWolU27/HTcDAwkWsYkGGlx80LSg8rIxhW0SMRkfkjWUsZgmFpshM60Q9rlnBqjor
 Kcp8NG2rXNj1hgChQavVPxvzgmvn1T3+y8Vt4Fpu3Svu44Uz
X-Received: by 2002:a05:620a:1921:b0:7b6:e8c3:4b5f with SMTP id
 af79cd13be357-7bffcce5398mr3390729885a.16.1738684951244; 
 Tue, 04 Feb 2025 08:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGc1Qy4b703xLL/dPclDfo4FumcZjUi08bmzuGPtBS4cHLiluNrGZdk2wGKf7p55N0bcKILmw==
X-Received: by 2002:a05:620a:1921:b0:7b6:e8c3:4b5f with SMTP id
 af79cd13be357-7bffcce5398mr3390724585a.16.1738684950873; 
 Tue, 04 Feb 2025 08:02:30 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90571csm648400485a.83.2025.02.04.08.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 08:02:30 -0800 (PST)
Date: Tue, 4 Feb 2025 11:02:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6I6FF_4r_uVUlWU@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local> <Z6ItUtb-NhKnn8hy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6ItUtb-NhKnn8hy@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 04, 2025 at 03:08:02PM +0000, Daniel P. Berrangé wrote:
> On Mon, Feb 03, 2025 at 01:20:01PM -0500, Peter Xu wrote:
> > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Multifd send channels are terminated by calling
> > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> > > multifd_send_terminate_threads(), which in the TLS case essentially
> > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> > > 
> > > Unfortunately, this does not terminate the TLS session properly and
> > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> > > 
> > > The only reason why this wasn't causing migration failures is because
> > > the current migration code apparently does not check for migration
> > > error being set after the end of the multifd receive process.
> > > 
> > > However, this will change soon so the multifd receive code has to be
> > > prepared to not return an error on such premature TLS session EOF.
> > > Use the newly introduced QIOChannelTLS method for that.
> > > 
> > > It's worth noting that even if the sender were to be changed to terminate
> > > the TLS connection properly the receive side still needs to remain
> > > compatible with older QEMU bit stream which does not do this.
> > 
> > If this is an existing bug, we could add a Fixes.
> > 
> > Two pure questions..
> > 
> >   - What is the correct way to terminate the TLS session without this flag?
> > 
> >   - Why this is only needed by multifd sessions?
> 
> Graceful TLS termination (via gnutls_bye()) should only be important to
> security if the QEMU protocol in question does not know how much data it
> is expecting to recieve. ie it cannot otherwise distinguish between an
> expected EOF, and a premature EOF triggered by an attacker.
> 
> If the migration protocol has sufficient info to know when a chanel is
> expected to see EOF, then we should stop trying to read from the TLS
> channel before seeing the underlying EOF.
> 
> Ignoring GNUTLS_E_PREMATURE_TERMINATION would be valid if we know that
> migration will still fail corretly in the case of a malicious attack
> causing premature termination.
> 
> If there's a risk that migration may succeed, but with incomplete data,
> then we would need the full gnutls_bye dance.

IIUC that's not required for migration then, because migration should know
exactly how much data to receive, and migration should need to verify that
and fail if the received data didn't match the expectation along the way.
We also have QEMU_VM_EOF as the end mark of stream.

Said that, are we sure any pre-mature termination will only happen after
all data read in the receive buffer that was sent?

To ask in another way: what happens if the source QEMU sends everything and
shutdown()/close() the channel, meanwhile the dest QEMU sees both (1) rest
data to read, and (2) a pre-mature terminatino of TLS session in a read()
syscall.  Would (2) be reported even before (1), or the order guaranteed
that read of the residue data in (1) always happen before (2) (considering
dest QEMU can be slow sometime on consuming the network buffers)?

Thanks,

-- 
Peter Xu


