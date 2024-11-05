Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7047D12692
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8I9a-0006j0-0V; Tue, 05 Nov 2024 06:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8I9X-0006bF-IR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8I9V-0002El-Qw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730807716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dto1+gW9spVc4gv3xZ+9ARIZVBH0ZC+z4twzEMn4FNg=;
 b=QfJdAqX0d192YT1WM1Y/zvVeHA/EEbmthPzCXaJVRcQR7tCtTxtWPOl9BIxT6QvQiehI0A
 f47KQXZUFW1aVgJ7ApoLboPZFLFA5SF4HbK3juiIvKod0jbOAVN9tc5SGZUJ1nIj7cA7V+
 8PERGc0tlRlWUbblCD9+4H3EjOIWWD4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-9VkcflEPOxKi6DssKppDYA-1; Tue, 05 Nov 2024 06:55:14 -0500
X-MC-Unique: 9VkcflEPOxKi6DssKppDYA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43159c07193so45705425e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730807713; x=1731412513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dto1+gW9spVc4gv3xZ+9ARIZVBH0ZC+z4twzEMn4FNg=;
 b=nwA1SDKdg5kcctof2UlttrygOJ7NfK543UuRzhwfDYfr6I5YoY9Gkv9a2r7h5VUE0J
 ZKEUXRbbuO8wOH2tJdPZss0dpGztFIyjCv1mOB/6LXo2feNCMrLIGDwlBzilT1fBLlaK
 Bn+d+v5iQMLPEjn6oR25K+apLeysw+2S+QM4tJI7CUXbz7lA7m6cjMywZ333qYrHQ+M5
 hpVD2Cv/8MGDdpmA9nemoMpTiMcwMN/1yISViFVrEg1bcoq7DvfEvqtQQ4ckeKjOTAYx
 AIJVfvsRfOz/Z+hIE2rnBdcp15yzwyadr98b7cuEBgmMUB+TyXO4KX/w1PhrFoP2TbB/
 CH1Q==
X-Gm-Message-State: AOJu0Yx0wHDnZJSske2qL3rreDEp6Xjqu3aFzBUsRxK+0V5YPfthSYe4
 wzS3t3TnE5029jR55bdwQ2ogdpDSdH8N59di6q5xNmm/gWua7HJVVuUa8z6KlmTKobAI3v4o+V0
 jzFDnnbc/ltHANxh93VPgROICIXMwYIwDUqYzb1HNx4yC4KSKEAk8cMfQdFVD2CZ/PhNdgsaBTR
 o7kRgnx7w3HP7MnETQNlQ2Jn+otIg=
X-Received: by 2002:a05:600c:3b22:b0:42c:a387:6a6f with SMTP id
 5b1f17b1804b1-4328325638emr158089155e9.20.1730807712010; 
 Tue, 05 Nov 2024 03:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQlNE25hee9ekdJATgfgcSId0kVgwS4bKMELJIxJU4/fz+up4jzfmDi8lntBc0K/DsuJ1LyrMX+dnBSzYCA3A=
X-Received: by 2002:a05:600c:3b22:b0:42c:a387:6a6f with SMTP id
 5b1f17b1804b1-4328325638emr158089005e9.20.1730807711663; Tue, 05 Nov 2024
 03:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-6-ppandit@redhat.com>
 <ZykJBq7ME5jgSzCA@x1n>
In-Reply-To: <ZykJBq7ME5jgSzCA@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Nov 2024 17:24:55 +0530
Message-ID: <CAE8KmOyz9gWfKZmVkXLvj-NMo_=QB42sZhTyVGLqkOjU1GCXfg@mail.gmail.com>
Subject: Re: [PATCH 5/5] migration: enable multifd and postcopy together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, 4 Nov 2024 at 23:19, Peter Xu <peterx@redhat.com> wrote:
> Precopy keeps sending data even during postcopy, that's the background
> stream (with/without preempt feature enabled).  May need some amendment
> when repost here.

* Okay.

> > +    if (channel == CH_POSTCOPY) {
> > +        return false;
> > +    }
>
> Please see my other reply, I think here it should never be POSTCOPY
> channel, because postcopy (aka, preempt) channel is only created after the
> main channel.. So I wonder whether this "if" will hit at all.

* It does. migration_ioc_process_incoming() is called for each
incoming connection. And every time it calls
migration_should_start_incoming() to check if it should proceed with
the migration or should wait for further connections, because multifd
does not start until all its connections are established.

* Similarly when the Postcopy channel is initiated towards the end of
Precopy migration, migration_should_start_incoming() gets called, and
returns 'false' because we don't want to start a new incoming
migration at that time. Earlier it was receiving boolean value
'default_channel' as parameter, which was set to false while accepting
'postcopy' connection via => default_channel = !mis->from_src_file;

> > +
> >      /* Multifd doesn't start unless all channels are established */
> >      if (migrate_multifd()) {
> > -        return migration_has_all_channels();
> > -    }
> > -
> > -    /* Preempt channel only starts when the main channel is created */
> > -    if (migrate_postcopy_preempt()) {
> > -        return main_channel;
> > +        return multifd_recv_all_channels_created();
>
> I think this is incorrect.. We should also need to check main channel is
> established before start incoming.  The old code uses
> migration_has_all_channels() which checks that.

* Okay, will try to fix it better.  But calling
migration_has_all_channels() after checking migrate_multifd() does not
seem/read right.

> I don't yet see how you manage the multifd threads, etc, on both sides.  Or
> any logic to make sure multifd will properly flush the pages before
> postcopy starts.  IOW, any guarantee that all the pages will only be
> installed using UFFDIO_COPY as long as vcpu starts on dest.  Any comments?

* There are no changes related to that. As this series only tries to
enable the multifd and postcopy options together.

> The most complicated part of this work would be testing, to make sure it
> works in all previous cases, and that's majorly why we disabled it before:
> it was because it randomly crashes, but not always; fundamentally it's
> because when multifd was designed there wasn't enough consideration on
> working together with postcopy.  We didn't clearly know what's missing at
> that time.

* Right. I have tested this series with the following migration
commands to confirm that migration works as expected and there were no
crash(es) observed.
===
[Precopy]
# virsh migrate --verbose --live --auto-converge f39vm
qemu+ssh://<destination-host-name>/system

[Precopy + Multifd]
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 02 \
     f39vm  qemu+ssh://<destination-host-name>/system
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 04 \
     f39vm  qemu+ssh://<destination-host-name>/system
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 08 \
     f39vm  qemu+ssh://<destination-host-name>/system
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 16 \
     f39vm  qemu+ssh://<destination-host-name>/system

[Postcopy]
# virsh migrate --verbose --live --auto-converge \
    --postcopy --postcopy-after-precopy f39vm
qemu+ssh://<destination-host-name>/system

[Postcopy + Multifd]
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 02 \
    --postcopy --postcopy-after-precopy f39vm
qemu+ssh://<destination-host-name>/system
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 04 \
    --postcopy --postcopy-after-precopy f39vm
qemu+ssh://<destination-host-name>/system
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 08 \
    --postcopy --postcopy-after-precopy f39vm
qemu+ssh://<destination-host-name>/system
# virsh migrate --verbose --live --auto-converge --parallel
--parallel-connections 16 \
    --postcopy --postcopy-after-precopy f39vm
qemu+ssh://<destination-host-name>/system
===

> So we would definitely need to add test cases, just like whoever adds new
> features to migration, to make sure at least it works for existing multifd
> / postcopy test cases, but when both features enabled.
...
> It will add quite a few tests to run here, but I don't see a good way
> otherwise when we want to enable the two features, because it is indeed a
> challenge to enable the two major features together here.
>

* Thank you for the hints about the tests, will surely look into them
and try to learn about how to add new test cases.

Thank you.
---
  - Prasad


