Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68181C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgcm-0007d9-Mk; Fri, 21 Jun 2024 11:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKgch-0007Ts-9Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKgcf-0006eO-I9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718985379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qCVFnqO1tH//0CXREkWGX7cvKTBFtXygTZAp31h1JM=;
 b=jAezGZuAiaf6Se+FOupNrWQSfFZ85SkE1mwGcDv86SyaeqwvhosQDT2MNcPIAM/6YJ8EBy
 zi4saQdZNPBd/RGEtw/fttOItYrAxSLz/Hhk/BeIrSSD3jEPgxDoGOM6KIXKmRzxQSEjaG
 KZHc7O5QJChjyZcM8skq01xcC7/AaII=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-MSbUeGTCNI6LqCGB_t5dFw-1; Fri, 21 Jun 2024 11:56:18 -0400
X-MC-Unique: MSbUeGTCNI6LqCGB_t5dFw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79560b25fc4so16953885a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718985377; x=1719590177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qCVFnqO1tH//0CXREkWGX7cvKTBFtXygTZAp31h1JM=;
 b=RivnM5O0RdKQXoIJWA25ULwgNaQhpHQr4W3So69r3XuVub5NXmgEKWff0yFcq4FRsB
 Ele8606aB81FNcs2cRBGzKdB5lBuhYZQP+yfBMCAvWuDdBRhV+EG5TwNiV+y7MRJGHPG
 TGQSHA602GhRpnPm/kW7SsZwt6Mkl6GFWWnELEV1X0YWM7DaY+meCmPnolsnDVtUzZoN
 j8T0MAn0VVHPJ+hkZSqoYAqg1EKGFVXCAfdkDeSBXsdwmiBH5vP3Xl99sh+/pC5m2tJo
 1HlWChIsncPa8StWDShVz7WoKrxQI+bu+GbaGmmthpYQjeuv8kope0hafoU3DRYqOnwY
 dwBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTZcJISdyGxBBmcFPLpJeVe1oU58KRbZFIhTth1zPPaYtwkEJD1fmFwU8fs/UyoVlGokvrm4jDqmOmoOyhP5KuC56FrdM=
X-Gm-Message-State: AOJu0YykOXfMMgpjN45nu9ky6LnH7SjsKVYt0PmdwMGEMApgdv/UBipM
 caoRmz+uGJtk9l7qgy0Ln2BfXn+8pikI7xP9CHFdD2KWSBVg5k0O1M6F7iNeg+KdWamyoAYRp8t
 ol+VdC5v5gL+Hu1ud4v8/k7hwk9UlSgzV/0goZqGhtb9JTUsSAiNr
X-Received: by 2002:a05:6214:248f:b0:6b2:af3c:f710 with SMTP id
 6a1803df08f44-6b501e28ab3mr91561656d6.2.1718985377410; 
 Fri, 21 Jun 2024 08:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgTkwKBJEqHeXe3Av+DmHMPchheK16JKRwpMPmfyPrsY2Q/hhYEfSKPsU/4leZXLPEjzahA==
X-Received: by 2002:a05:6214:248f:b0:6b2:af3c:f710 with SMTP id
 6a1803df08f44-6b501e28ab3mr91561426d6.2.1718985376770; 
 Fri, 21 Jun 2024 08:56:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ed175fasm9784196d6.34.2024.06.21.08.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 08:56:16 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:56:12 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/7] migration/multifd: Introduce storage slots
Message-ID: <ZnWinGjeZGRGVOF-@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <f6f84518-530e-4332-8881-41a6219b8d4d@maciej.szmigiero.name>
 <87v822ibh8.fsf@suse.de>
 <dfe0384e-a765-4bfb-81c8-529329d76052@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfe0384e-a765-4bfb-81c8-529329d76052@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Jun 21, 2024 at 05:31:54PM +0200, Maciej S. Szmigiero wrote:
> On 21.06.2024 17:04, Fabiano Rosas wrote:
> > "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> > 
> > > Hi Fabiano,
> > > 
> > > On 20.06.2024 23:21, Fabiano Rosas wrote:
> > > > Hi folks,
> > > > 
> > > > First of all, apologies for the roughness of the series. I'm off for
> > > > the next couple of weeks and wanted to put something together early
> > > > for your consideration.
> > > > 
> > > > This series is a refactoring (based on an earlier, off-list
> > > > attempt[0]), aimed to remove the usage of the MultiFDPages_t type in
> > > > the multifd core. If we're going to add support for more data types to
> > > > multifd, we first need to clean that up.
> > > > 
> > > > This time around this work was prompted by Maciej's series[1]. I see
> > > > you're having to add a bunch of is_device_state checks to work around
> > > > the rigidity of the code.
> > > > 
> > > > Aside from the VFIO work, there is also the intent (coming back from
> > > > Juan's ideas) to make multifd the default code path for migration,
> > > > which will have to include the vmstate migration and anything else we
> > > > put on the stream via QEMUFile.
> > > > 
> > > > I have long since been bothered by having 'pages' sprinkled all over
> > > > the code, so I might be coming at this with a bit of a narrow focus,
> > > > but I believe in order to support more types of payloads in multifd,
> > > > we need to first allow the scheduling at multifd_send_pages() to be
> > > > independent of MultiFDPages_t. So here it is. Let me know what you
> > > > think.
> > > 
> > > Thanks for the patch set, I quickly glanced at these patches and they
> > > definitely make sense to me.
> > > 
> (..)
> > > > (as I said, I'll be off for a couple of weeks, so feel free to
> > > > incorporate any of this code if it's useful. Or to ignore it
> > > > completely).
> > > 
> > > I guess you are targeting QEMU 9.2 rather than 9.1 since 9.1 has
> > > feature freeze in about a month, correct?
> > > 
> > 
> > For general code improvements like this I'm not thinking about QEMU
> > releases at all. But this series is not super complex, so I could
> > imagine we merging it in time for 9.1 if we reach an agreement.
> > 
> > Are you thinking your series might miss the target? Or have concerns
> > over the stability of the refactoring? We can within reason merge code
> > based on the current framework and improve things on top, we already did
> > something similar when merging zero-page support. I don't have an issue
> > with that.
> 
> The reason that I asked whether you are targeting 9.1 is because my
> patch set is definitely targeting that release.
> 
> At the same time my patch set will need to be rebased/refactored on top
> of this patch set if it is supposed to be merged for 9.1 too.
> 
> If this patch set gets merged quickly that's not really a problem.
> 
> On the other hand, if another iteration(s) is/are needed AND you are
> not available in the coming weeks to work on them then there's a
> question whether we will make the required deadline.

I think it's a bit rush to merge the vfio series in this release.  I'm not
sure it has enough time to be properly reviewed, reposted, retested, etc.

I've already started looking at it, and so far I think I have doubt not
only on agreement with Fabiano on the device_state thing which I prefer to
avoid, but also I'm thinking of any possible way to at least make the
worker threads generic too: a direct impact could be vDPA in the near
future if anyone cared, while I don't want modules to create threads
randomly during migration.

Meanwhile I'm also thinking whether that "the thread needs to dump all
data, and during iteration we can't do that" is the good reason to not
support that during iterations.

I didn't yet reply because I don't think I think all things through, but
I'll get there.

So I'm not saying that the design is problematic, but IMHO it's just not
mature enough to assume it will land in 9.1, considering it's still a large
one, and the first non-rfc version just posted two days ago.

Thanks,

-- 
Peter Xu


