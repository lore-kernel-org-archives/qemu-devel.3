Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9951CC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYsRZ-00026R-FT; Tue, 30 Jul 2024 15:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYsRW-00025t-Vt
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 15:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYsRU-00027d-0q
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 15:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722367406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Xrf+C/x3nq2A6y+ohMlgWZv+goVq4vWILNt8A2nCOM=;
 b=JnPe0b/utcUSUcLdlZBlCa1l+d3V+XIG7msB1ON2W0IzwedVs/mWPGKgXfJXWiQsvoLVL5
 rkD4UVPvQz9vU6dd5z7TVbUgQe/zoEk84Q+o9YcjjkUsH54icTgRFkpBzKGpGDhc9+XWS4
 RzFWDhtcV99sLjBae3Tyq/JJjCFUavU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-jidkUvXNPkSX25FufDvv4Q-1; Tue, 30 Jul 2024 15:23:24 -0400
X-MC-Unique: jidkUvXNPkSX25FufDvv4Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7aaef3fdafso21819366b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 12:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722367403; x=1722972203;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Xrf+C/x3nq2A6y+ohMlgWZv+goVq4vWILNt8A2nCOM=;
 b=jYzmrHq1J7X00MmiNYzNcioARvRDUN50TzMaR01gDlmJHC6+i5AwxkD7dfj6hALnEx
 APmnjFZRjXfPvXlDY3YSGV3g2BoBWLVvEvz/sXK9PFjPBFvORcAS4m47TG5GNyLjnkNr
 TBNWlk1WzgaNfCHkAQLhBjHEUwrr6loVcewBe0xMP/L8n6Xq1hTgtIpCR9B8iLEfwZ1T
 I99O8J4c9QRtf5QJFYeVQnGNSFUWGyC/2ouCkT07wwoqsCUkx6l4C2ayoIoSzz+sNz63
 3HInKGlxDveBNs3YWP8OyV9Xq6/3hAl10Sg4Gox5zwUaudjP6W3DBgk8rCxVBO+AF3Q+
 EWzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV99aIJC4jRw9Uu37qUKeEMsNaeXhvA2jtE4dgjEeape1lDjUx2IndWIYA+Kzc31VMxwK8g/xF7yUfg2ZJu1usXAlS5L4o=
X-Gm-Message-State: AOJu0Yw5u4NkyaZkPSdOnobLnuNYos5T8F3tPflvZI21eR0foQv7kNQz
 5VZUNnzddwRqUlbtUgzuasR7WmjxPooy3wtNsINKPuUxFaBtkuaUo2cWZRB1ZxwMv1I4ywR12wq
 RTv4f64e8su8d8Ews3Q++42+KxKFxNMpEcaAMvQrvu4MD78zxkQJD
X-Received: by 2002:a17:906:c10f:b0:a77:ca9d:1d46 with SMTP id
 a640c23a62f3a-a7d85abb7e7mr340430266b.33.1722367403041; 
 Tue, 30 Jul 2024 12:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWcqFYhPXu1/HAHEUp+EFvaL1xt8u94lUlmr64xPmN+COL2kaXSdLWmWqfDjBQS3nMfSwpEQ==
X-Received: by 2002:a17:906:c10f:b0:a77:ca9d:1d46 with SMTP id
 a640c23a62f3a-a7d85abb7e7mr340426666b.33.1722367402327; 
 Tue, 30 Jul 2024 12:23:22 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:ce53:abb9:7fe9:ef80:6a78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb9f60sm677691666b.223.2024.07.30.12.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 12:23:21 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:22:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240730151746-mutt-send-email-mst@kernel.org>
References: <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqk6x2nd3Twz--75@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 03:11:03PM -0400, Peter Xu wrote:
> On Tue, Jul 30, 2024 at 07:46:12PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Jul 30, 2024 at 02:13:51PM -0400, Peter Xu wrote:
> > > On Mon, Jul 29, 2024 at 06:26:41PM +0100, Daniel P. Berrangé wrote:
> > > > On Mon, Jul 29, 2024 at 01:00:30PM -0400, Peter Xu wrote:
> > > > > On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
> > > > > > 
> > > > > > We've got two mutually conflicting goals with the machine type
> > > > > > definitions.
> > > > > > 
> > > > > > Primarily we use them to ensure stable ABI, but an important
> > > > > > secondary goal is to enable new tunables to have new defaults
> > > > > > set, without having to update every mgmt app.  The latter
> > > > > > works very well when the defaults have no dependancy on the
> > > > > > platform kernel/OS, but breaks migration when they do have a
> > > > > > platform dependancy.
> > > > > > 
> > > > > > >   - Firstly, never quietly flipping any bit that affects the ABI...
> > > > > > > 
> > > > > > >   - Have a default value of off, then QEMU will always allow the VM to boot
> > > > > > >     by default, while advanced users can opt-in on new features.  We can't
> > > > > > >     make this ON by default otherwise some VMs can already fail to boot,
> > > > > > > 
> > > > > > >   - If the host doesn't support the feature while the cmdline enabled it,
> > > > > > >     it needs to fail QEMU boot rather than flipping, so that it says "hey,
> > > > > > >     this host does not support running such VM specified, due to XXX
> > > > > > >     feature missing".
> > > > > > > 
> > > > > > > That's the only way an user could understand what happened, and IMHO that's
> > > > > > > a clean way that we stick with QEMU cmdline on defining the guest ABI,
> > > > > > > while in which the machine type is the fundation of such definition, as the
> > > > > > > machine type can decides many of the rest compat properties.  And that's
> > > > > > > the whole point of the compat properties too (to make sure the guest ABI is
> > > > > > > stable).
> > > > > > > 
> > > > > > > If kernel breaks it easily, all compat property things that we maintain can
> > > > > > > already stop making sense in general, because it didn't define the whole
> > > > > > > guest ABI..
> > > > > > > 
> > > > > > > So AFAIU that's really what we used for years, I hope I didn't overlook
> > > > > > > somehting.  And maybe we don't yet need the "-platform" layer if we can
> > > > > > > keep up with this rule?
> > > > > > 
> > > > > > We've failed at this for years wrt enabling use of new defaults that have
> > > > > > a platform depedancy, so historical practice isn't a good reference.
> > > > > > 
> > > > > > There are 100's (possibly 1000's) of tunables set implicitly as part of
> > > > > > the machine type, and of those, libvirt likely only exposes a few 10's
> > > > > > of tunables. The vast majority are low level details that no mgmt app
> > > > > > wants to know about, they just want to accept QEMU's new defaults,
> > > > > > while preserving machine ABI. This is a good thing. No one wants the
> > > > > > burden of wiring up every single tunable into libvirt and mgmt apps.
> > > > > > 
> > > > > > This is what the "-platform" concept would be intended to preserve. It
> > > > > > would allow a way to enable groups of settings that have a platform level
> > > > > > dependancy, without ever having to teach either libvirt or the mgmt apps
> > > > > > about the individual tunables.
> > > > > 
> > > > > Do you think we can achieve similar goal by simply turning the feature to
> > > > > ON only after a few QEMU releases?  I also mentioned that idea below.
> > > > > 
> > > > > https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
> > > > > 
> > > > > So far it really sounds like the right thing to do to me to fix all similar
> > > > > issues, even without introducing anything new we need to maintain.
> > > > 
> > > > Turning a feature with a platform dependency to "on" implies that
> > > > the machine type will cease to work out of the box for platforms
> > > > which lack the feature. IMHO that's not acceptable behaviour for
> > > > any of our supported platforms.
> > > 
> > > Right, that's why I was thinking whether we should just always be on the
> > > safe side, even if I just replied in the other email to Akihiko, that we do
> > > have the option to make this more aggresive by turning those to ON after
> > > even 1-2 years or even less.. and we have control of how aggressive this
> > > can be.
> > > 
> > > > 
> > > > IOW, "after a few QEMU releases" implies a delay of as much as
> > > > 5 years, while we wait for platforms which don't support the
> > > > feature to drop out of our supported targets list.  I don't
> > > > think that'll satisfy the desire to get the new feature
> > > > available to users as soon as practical for their particular
> > > > platform.
> > > 
> > > The feature is always available since the 1st day, right?  We just need the
> > > user to opt-in, by specifying ON in the cmdline.
> > > 
> > > That'll be my take on this that QEMU's default VM setup should be always
> > > bootable, migratable, and so on.  Then user opt-in on stuff like this one,
> > > where there's implication on the ABIs.  The "user" can also include
> > > Libvirt.  I mean when something is really important, Libvirt should, IMHO,
> > > opt-in by treating that similarly like many cpu properties, and by probing
> > > the host first.
> > > 
> > > IIUC there aren't a lot of things like that (part of guest ABI & host
> > > kernel / HW dependent), am I right?  Otherwise I would expect more failures
> > > like this one, but it isn't as much as that yet.  IIUC it means the efforts
> > > to make Libvirt get involved should be hopefully under control too.  The
> > > worst case is Libvirt doesn't auto-on it, but again the user should always
> > > have the option to turn it on when it's necessary.
> > 
> > If it is left to libvirt, then it would very likely end up being a user
> > opt-in, not auto-enabled.
> 
> Not sure whether there's other opinions, but that's definitely fine by me.
> 
> I think it even makes more sense, as even if Libvirt probed the host and
> auto-on the feature, it also means Libvirt made a decision for the user,
> saying "having a better performance" is more important than "being able to
> migrate this VM everywhere".
> 
> I don't see a way that can make such fair decision besides requesting the
> user to opt-in always for those, then the user is fully aware what is
> enabled, with the hope that when a migration fails later with "target host
> doesn't support feature XXX" the user is crystal clear on what happened.
> 
> Thanks,
> 
> -- 
> Peter Xu


This is not what we did historically. Why should we start now?

-- 
MST


