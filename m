Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D32E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXmLS-0007v4-V6; Tue, 14 Jan 2025 14:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXmLB-0007pS-IM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:12:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXmL8-0005Db-Aj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2xWX/tyRAcCwNi8n0nPnKrPL6tFvuHaCqsagmjOjTo=;
 b=d+M07aRNWtzN0X6tMND6epzbb871Dt4zBGsTonkorqE5ZZ6WpUQWZR8K0gkQjKMmbkCCPX
 UHbJN/zzSgsrhGNNqNxkUH35GU/1jwAChqVhYiMyi3WW0PhD5CkTeBOwjH2327utURXQnf
 TD5ShaVQ8mVDm1iPQJI5xOsBus6l99o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-5bBdFVUaOja8lqCRbuS4Nw-1; Tue, 14 Jan 2025 14:12:32 -0500
X-MC-Unique: 5bBdFVUaOja8lqCRbuS4Nw-1
X-Mimecast-MFC-AGG-ID: 5bBdFVUaOja8lqCRbuS4Nw
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6df9ac8dcbeso199577216d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 11:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736881951; x=1737486751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2xWX/tyRAcCwNi8n0nPnKrPL6tFvuHaCqsagmjOjTo=;
 b=UvJQdlGAt18APNQ2LFj97EYSuyvZj7jIynvAPgVRVX3wrJqOGnIjH/pq212YoRwMs1
 knFDLOMBrHBDdAPIljdyNxqbMF28F7w7AusXq7erWgkccdeNriB87tRT4jm5gzyZwhlO
 GsevH5tTy4bN/Yn4xsnYGu1EhqYrxRBg+89Nlh2g0OFbIaYBO9fTnVzujq1LepnUDvlc
 3t6p1SsKKfxlKn2fTsEnWehUNhOFrSX9VTasc8NCGkF6Wv4XOTKKsVj+sa6BhW11Oot/
 2eoolzWQbswiJsqTIBlNSRxiagLFm9P2K5z6OS7hhLBMBSFBJBMcrfR4AC+K2UipubRa
 qAqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqAbdaCuEm9MynRkDoXfsizWwHLJTHR4I8ckG8l68n1H60fYbDoi7jKlEtymfdqjUJuKwjQEfODLs3@nongnu.org
X-Gm-Message-State: AOJu0Yy0RiMysNZE5hDR7GZfwbHwLVu8RTfJbOMJdM1eTutMWuEoOnMP
 GHxLmTSg7ylGvvfpaPSYsPnxLolH0M46Tbcqs5sMSvmqnEr8Ya+NwZz3xUCCmrjm31Kb+1YlYQ7
 eoDZh5TQUzfy9SYFr9uHS0jRv1YsuG0NTuiSlAkfbglx0VrN5eUHA
X-Gm-Gg: ASbGnctijga31/qb8PVfQbQbLjW0/rKYs4RcumqovyiWLRiCg9BsTi1JXSa/irILIbf
 PA+nHSsQlAnL7b+Omd/A8U3aveAokRmHRQOq5D/PfOX06C14VpC/k64Q4l4Gf2dk7gPitCGSO3r
 aYxcnTeezQ2pS5LLqqigFXNm5wEXFi4CjA/3QlGN6geiGHylHPzn+BKsndUvLduf9CyO7pK/lrm
 OX+UDePUZv8XzuqD10aMIvd5L5TXkBlOlmme4NyxhAHrIbOm0r262qL+1qfcnW7AZOIybQMmdqL
 18u7EHYplF+h4vxySA==
X-Received: by 2002:a05:6214:212b:b0:6d4:1ea3:981d with SMTP id
 6a1803df08f44-6df9b2ce4c6mr370486716d6.43.1736881951450; 
 Tue, 14 Jan 2025 11:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBCDxijBKtyfrC59nanNFb+diIJd92+BSgdXMQdK2j3SfW+gGqQewUCCcuRRoxouWOGHe6bw==
X-Received: by 2002:a05:6214:212b:b0:6d4:1ea3:981d with SMTP id
 6a1803df08f44-6df9b2ce4c6mr370486326d6.43.1736881951084; 
 Tue, 14 Jan 2025 11:12:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9b216csm55823686d6.65.2025.01.14.11.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 11:12:30 -0800 (PST)
Date: Tue, 14 Jan 2025 14:12:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4a3GxEbz1jjCDc5@x1n>
References: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 14, 2025 at 05:42:57PM +0000, Peter Maydell wrote:
> On Tue, 14 Jan 2025 at 17:02, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 05:43:09PM +0900, Akihiko Odaki wrote:
> > > memory_region_finalize() is not a function to tell the owner is leaving, but
> > > the memory region itself is being destroyed.
> >
> > It is when the lifecycle of the MR is the same as the owner.  That holds
> > true I suppose if without this patch, and that's why I don't prefer this
> > patch because it makes that part more complicated.
> >
> > > It should not happen when a container is still referencing it. That is
> > > also why it has memory_region_ref(subregion) in
> > > memory_region_update_container_subregions() and assert(!mr->container) in
> > > memory_region_finalize().
> >
> > Again, the line I added was sololy for what you said "automation" elsewhere
> > and only should work within MR-links within the same owner.  Otherwise
> > anyone referencing the MR would hold the owner ref then this finalize()
> > will never happen.
> >
> > Now, if I could go back to your original purpose of this work, quotting
> > from your cover letter:
> >
> > > I saw various sanitizer errors when running check-qtest-ppc64. While
> > > I could just turn off sanitizers, I decided to tackle them this time.
> > >
> > > Unfortunately, GLib versions older than 2.81.0 do not free test data in
> > > some cases so some sanitizer errors remain. All sanitizer errors will be
> > > gone with this patch series combined with the following change for GLib:
> > > https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
> >
> > Is check-qtest-ppc64 the only one that will trigger this issue?  Does it
> > mean that most of the devices will do proper removal of device-owned
> > subregions (hence, not prone to circular reference of owner refcount)
> > except some devices in ppc64?
> 
> There's at least one test in the arm qtests that will hit this.
> I suspect that you'll find that most architectures except x86
> (where we don't have models of complex SoCs and the few
> machines we do have tend to be old code that is less QOMified)
> will hit similar issues. I think there's a general issue here,
> this isn't just "some particular ppc device is wrongly coded".

I see.  Do you know how many of them would be important memory leaks that
we should fix immediately?

I mean, we have known memory leaks in QEMU in many places I assume.  I am
curious how important this problem is, and whether such would justify a
memory API change that is not reaching a quorum state (and, imho, add
complexity to memory core and of course that spreads to x86 too even if it
was not affected) to be merged.  Or perhaps we can fix the important ones
first from the device model directly instead.

It's not new to me that QEMU can leave some memory allocated for the whole
lifecycle of the process.  E.g. I just worked on something for migration
that we could have UAF on migration object.  I tried to provide a core fix
via QOM singleton but unfortunately that didn't yet got accepted, so
migration still face such UAF.  It was not accepted because of some reasons
and reviewer concerns, so I suppose that's fair that until we reach a
consensus on an acceptable and clean general solution, we leave that issue
be there if it's a corner case anyway - in migration that was the case.

For this specific case, my current understanding is the important leaks are
where it can e.g. get devices frequently plugged and unplugged with can
cause QEMU to bloat till host OOM.  For those cases I wonder whether (even
if we want to provide a global sulution... but while before it settles..)
we could fix them first by correctly detach the subregions just like what
x86 does.

Thanks,

-- 
Peter Xu


