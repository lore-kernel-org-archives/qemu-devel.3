Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC48CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9moK-0003ET-9k; Fri, 17 Oct 2025 11:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9moG-0003DR-Tq
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9moC-0004To-DB
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760716551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syK7eWmOhrAxwTy1DDdEa/5Z2/CCRj5xu3iY+rH1JEM=;
 b=agysOYBIZRJAGXxF638G0Uhjq/oRj0E4ceXOoZpT5pgWfhJEEXfis5B4prxSjXveopdIyw
 ml2M8/2Vihn2bkeiS1ZxYE+Cg6HWq8KU/OTJkuiY74sJFaQZjJXvPTO1u+8vBZtT0mxpwu
 STdsK9WHANf8wFbJTHOYwA8uFA22W8s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-geKGzzlIM_6IqPeiL2L_2w-1; Fri, 17 Oct 2025 11:55:48 -0400
X-MC-Unique: geKGzzlIM_6IqPeiL2L_2w-1
X-Mimecast-MFC-AGG-ID: geKGzzlIM_6IqPeiL2L_2w_1760716547
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-86b8db0e70dso108897206d6.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760716547; x=1761321347;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=syK7eWmOhrAxwTy1DDdEa/5Z2/CCRj5xu3iY+rH1JEM=;
 b=c3YoFlEi8ZbKMuSy2Y2rFW9FvLQjBlcVUzDW2KJv9Wae5oPatvY+hW+RWj+K/abxJD
 BTvUFRKqEPF6QijY4uucarD5ZjNMKhBJwUECv1xAlp4k3WppSFC1aWqjrug2fi0GVBn7
 hZylEezywU54UkGIEGS+/VHTsDcjysaCraM+XZwnCXTL8D1aSNYGkBOdEl/rFNGG2PkC
 qxJes+z1dE1z0zmKyGT+e42jxCoDmDsPAtoKfqXIny1VChMi2gthWFvTCUTcEE5Jyx8h
 21F6Q9ZWzomJfSsDEK/HE26ZKDYNmLktxD67NnNmr5FSe3fdUO06EsBP3OAT95bnYivz
 oNKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ60AfKqIhwo2rDRGE1l+mlyGX911spPWYHQ6QFMd7VvAPEPQGbRVa36dL8Z0bTm6rb8QwD72q3POv@nongnu.org
X-Gm-Message-State: AOJu0YzoRrs79Vs3E945pagzwnSskut9iZKNqht09xHvKn2/kxxz7ZcM
 RQqZtA9vSElH/wPXnhkfk/gB8PQzB6JFnED1VIBMybvKWJezCG0RMvg1GxsFtBJPFNOXQWxi194
 ojlQvN9yOb2FHL3mIBJVSZ5s1l6hDmUTjPpoKRxqE4yyvBibncwt0mNlf
X-Gm-Gg: ASbGncuh2CGRUuVpUbESu29JgzPVT7ylVl069ZkLNE/QjakPD6wlCKlEKPihbLAmKyg
 1qBx6ZJSDb+HpWS9oKmNpnWgnbZT5/D30q4EXPODtjpe3GOussNfuhaRpi9hKj4DIDfbOuLUnUV
 OD/SCgJt9wzC/n738owHvfqt8RUYlbCnJFUwgMiRtVIf9qpJbesEUuPcZVdSdZCBaAZQl8Ljjjt
 lQW9sj1Y4wCclORpG6TwBTetP9AHNbiY9h0c7QrsV6gcF53JMrvUYdzaGxWWMMhEbwewYqgpcIA
 4IiCTLG2e8UaIABXxkKDvS8kBSsmHIECoH06Vb2/0kcssU8whxH/fPtLsLBr5bPznfQ=
X-Received: by 2002:ad4:5f0e:0:b0:87c:8e1:d739 with SMTP id
 6a1803df08f44-87c202c8d38mr55561146d6.23.1760716547374; 
 Fri, 17 Oct 2025 08:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2KUihrUt88zOMw0c8qaUWieYca6qNjHyi5CIIz1mMcRAsAiVVgAL69Nn1PwmEyERP42kvLA==
X-Received: by 2002:ad4:5f0e:0:b0:87c:8e1:d739 with SMTP id
 6a1803df08f44-87c202c8d38mr55560636d6.23.1760716546824; 
 Fri, 17 Oct 2025 08:55:46 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf5237273sm1213676d6.26.2025.10.17.08.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:55:45 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:55:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPJm_vrlDTxSNzYR@x1.local>
References: <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local>
 <7995fd74-5f02-4cd6-94b5-f1b361298257@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7995fd74-5f02-4cd6-94b5-f1b361298257@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 17, 2025 at 09:51:26AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.10.25 23:28, Peter Xu wrote:
> > On Thu, Oct 16, 2025 at 08:57:18PM +0100, Daniel P. Berrangé wrote:
> > > Errm, machine types apply to devices, but this is about transferring
> > > backends which are outside the scope of machine types.
> > 
> > Ah.. I didn't notice that net backends are not inherited by default from
> > qdev, hence not applicable to machine type properties.
> > 
> > Is it possible we enable it somehow, so that backends can have compat
> > properties similarly to frontends?
> 
> But that would mean, that we can't reconfigure a backend during live migration.
> 
> In my understanding, machine type properties are visible to the guest,
> and that's why we can't change them for running vm, even during live
> migration.

IIUC machine type properties may or may not be visible to the guest.  It
should depend on whether it is relevant to a guest-visible behavior.  Here
a flag showing "whether TAP, as a backend, can migrate" shouldn't be
exposed to guest.

I was indeed expecting that one will need to qom-set it for each device if
you want to get rid of versioned machine types.  It's not ideal interfacing
as what Dan was looking for, but it should still work so far, and I think
it might still be fair if it's only needed without machine type versionings.

> 
> Bringing here another type of properties, which we _can_ change for
> running vm (even if changing is not very comfortable for admin), will
> be like tying ourselves hands.
> 
> And yes, there is a way to change any properties by qom-set. But it
> lays out of paradigm of machine types, and normally we can't change
> most of properties in flight.
> 
> 
> Or in other words: if we _can_ go on only with migration parameters,
> that actually shows, that what we are talking about is definitely
> property of migration, not property of device.
> 
> 
> And final note: if we can use one mechanism instead of two mechanisms,
> it makes the architecture twice simpler. Trying to go on with _only_
> device properties would mean run a bench of qom-set commands before
> every migration (as we have to distinguish local and remote migrations
> anyway), that looks bad. On the other hand, go on with _only_ migration
> parameter is feasible and looks better.
> 
> 
> And very final note: making global parameter + per-device parameters,
> actually, global parameter become a workaround to the fact that we
> don't want run a bench of qom-set commands. So, global parameter is
> an additional API to hide inconvenience of the main API.

IMHO it's not a workaround.  To me, it's a better way of abstraction,
because the migration side provides the capability of passing FDs, and
whatever is generic about that should be attached to the global knob.
Migration shouldn't care about behavior or attributes of a specific device.
Listing the devices in any way in migration's QAPI is a workaround instead.

But I agree I do not know whether it's easy to have net backends support
machine types properties.  I think it still makes sense logically that a
net backend is a TYPE_DEVICE, even if it's a backend device which is not
directly visible to the guest.

Thanks,

-- 
Peter Xu


