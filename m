Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618AC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 18:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRcPK-0008Dq-0J; Wed, 10 Jul 2024 14:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRcPH-0008DF-Vt
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRcPF-000404-0v
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 14:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720637467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7C37G9fIfUCiEohFj0/PJaNeS2xhaIdHpXvfa7FIuw=;
 b=TN00dcXchrqBC0dUlvXEgYPjB658jaLfxhPUDs0zp3uyEjwt2g0EUUuemkcwIyKaHvLgbS
 cCwoZpnooEu7RGmtzCtKUTIA28Gz6Nd2LnLE66Z1uTfKleTAQ/dXBOzKEpXv9RixHFKwXR
 DOTxGAmnDRu/0My7hOg14J7cf2e7pDk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-8DvBlCYCPymp8mqfIQsJwA-1; Wed, 10 Jul 2024 14:51:05 -0400
X-MC-Unique: 8DvBlCYCPymp8mqfIQsJwA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3d9db343109so26196b6e.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 11:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720637465; x=1721242265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7C37G9fIfUCiEohFj0/PJaNeS2xhaIdHpXvfa7FIuw=;
 b=UGq+q7Rge9qDX2U8ua+IqKApCWNtjIj/8C1oHjWUryb1HL1oeTFbh4P9AwuZm+cDDQ
 rRo/9hkqLK4Bt/9JD/b2ABgt8abtj4C25tp9/a6fQjOr4rzEKkfB8FBannmgqjbWCCcO
 z04quAXG2XepH/9t3+HkrEXMKldcS9Yx01E8aEPo4/HjpKizJOdiCPUWBqHL4vY2IJpu
 DhJRZu/Q/M7FY0d+Z0iDBGP+t2bE6eDVPqqDHgSU8JYRI45/r1SvGBBVByemFLzQJ3PG
 oWn3wlShdz68LXkb5A+vtcb8UjLS+CgD3GjRr9vEPciddXq71VYUkejfMabGbC2VNsow
 2lYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWt0Tcnu5QmXoeQyJvILoJZXZI54qQORUK16giDXg+Sou3GMVA2TGFMpDzv+OxwCI5AH+oImg4dvTGz1PoM4P9GEuEPcU=
X-Gm-Message-State: AOJu0YzumvQFfn1qfFFGRMHT0Dm79hgIwZCdPI44UNwP00I1zMlRaHv8
 sK5Sb79sjUCBjZSI+IAz5kXp/H8yaJHAJQTCep6xNk6CfBpN1MyK0QeuuT0GUuThbD1XcG7kG/W
 4ajMSCG2Fzkc/X06eYsMjRncGwJLID9if8jFV78SPRHsCckFvOT3p
X-Received: by 2002:a05:6808:1416:b0:3d9:33c1:29ef with SMTP id
 5614622812f47-3daa0cc5a13mr160961b6e.3.1720637464938; 
 Wed, 10 Jul 2024 11:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHywB7E+4FcqgyDuy5jjeN8jDEIRAivaUqhC5XVPSJ9OHQeE2hUDj57p+KkmyWlJQqqJmjerQ==
X-Received: by 2002:a05:6808:1416:b0:3d9:33c1:29ef with SMTP id
 5614622812f47-3daa0cc5a13mr160950b6e.3.1720637464599; 
 Wed, 10 Jul 2024 11:51:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f19087255sm218684485a.79.2024.07.10.11.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 11:51:04 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:51:01 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Message-ID: <Zo7YFZOFDFHW1FrW@x1n>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <PH7PR11MB5941B008DD622227FB46E95EA3DB2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zo2EsEqAY5KnkO1V@x1n>
 <PH7PR11MB594133AD3E08A6E35D07DD97A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zo6mWzuxFET1q81j@x1n>
 <PH7PR11MB5941A602FCA617659E0105A9A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5941A602FCA617659E0105A9A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, Jul 10, 2024 at 03:39:43PM +0000, Liu, Yuan1 wrote:
> > I don't think postcopy will trigger timeout failures - postcopy should use
> > constant time to complete a migration, that is guest memsize / bw.
> 
> Yes, the migration total time is predictable, failure due to timeout is incorrect, 
> migration taking a long time may be more accurate.

It shouldn't: postcopy is run always together with precopy, so if you start
postcopy after one round of precopy, the total migration time should
alwways be smaller than if you run the precopy two rounds.

With postcopy after that migration completes, but for precopy two rounds of
migration will follow with a dirty sync which may say "there's unforunately
more dirty pages, let's move on with the 3rd round and more".

> 
> > The challenge is normally on the delay of page requests higher than
> > precopy, but in this case it might not be a big deal. And I wonder if on
> > 100G*2 cards it can also perform pretty well, as the delay might be
> > minimal
> > even if bandwidth is throttled.
> 
> I got your point, I don't have much experience in this area.
> So you mean to reserve a small amount of bandwidth on a NIC for postcopy 
> migration, and compare the migration performance with and without traffic
> on the NIC? Will data plane traffic affect page request delays in postcopy?

I'm not sure what's the "data plane" you're describing here, but logically
VMs should be migrated using mgmt networks, and should be somehow separate
from IOs within the VMs.

I'm not really asking for another test, sorry to cause confusions; it's
only about some pure discussions.  I just feel like postcopy wasn't really
seriously considered even for many valid cases, some of them postcopy can
play pretty well even without any modern hardwares requested.  There's no
need to prove which is better for this series.

Thanks,

-- 
Peter Xu


