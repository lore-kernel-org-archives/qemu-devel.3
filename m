Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127AEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc14I-0001zt-Qo; Thu, 08 Aug 2024 07:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc14F-0001yZ-R7
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc14D-00031P-S3
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723115543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+QKzqtEl1JuFb+qFU55XVjRZDkH+I0kQzQ0lVEpdchg=;
 b=INIwXxxj7d2DonAUPENMDLjcysCD35wW4/JTZeirsC0cb9kHqlS1vsHXNe//UD+qVmmrqW
 XDMIqNNGffqVlWrmnwPXwtIJBrYZDaRhgtSOtIOEOtGpgNdGoRUKOSgnC8zqTEEqNMTcNU
 kuLaPw8S9Pgb1poh9vRpPhr4fgNP29c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-A8KT_k4JMqGBRab3P0CniQ-1; Thu, 08 Aug 2024 07:12:22 -0400
X-MC-Unique: A8KT_k4JMqGBRab3P0CniQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428207daff2so6026785e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 04:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723115541; x=1723720341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QKzqtEl1JuFb+qFU55XVjRZDkH+I0kQzQ0lVEpdchg=;
 b=NnldjpsxeS9iKW8kLI3kpWzHtmOCh5ddGe+f9OizQ+JoKqzvz9CZzZHIVld3/DB+HU
 maCqbsgOM/WHt6N5GHKKJc75s1PJT6ouTCtO8Y/L4qFsMu8oxjEoG55uS9ix/VXI8H+9
 V07hHAdvQeULiRJad/Zj1IwzIRD4YjD/Qf3py8JI9uzSJQJXasZtN+Q/1fVT3d6u4AGj
 4RQGQBg6XMQQMr59SAZvCq8bM6+Xe5UBqTIbHqkRl1L9dhoZa4V7/p7fi7rwwYGi6ZKX
 nxWN3O8G2O6Of6U0BAWLmBxv4SVw5uEcE1L9AsdULIT6jiDzw/s4FKrHiux4Bkc5zS62
 KZAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfvj034vWq/0iznlyk+v1mMuktrY6RijaFKGV6iFDCrAE/r22wUDxvYvo8BrOkCxUlqdWsb3QjjWWbk21pgJ8qiLNd2os=
X-Gm-Message-State: AOJu0YxijuE3RJpU+fDW6x9xa8nGfd4px9nGoRKNZuU4ii/lEpGBFbWF
 Sjtmhg1M9bxcRSQ+mNImuK1unabcGMqO5Ydc5tkp6O/TcTXVU/9l6z+XhtU948pvolkFcr4bn3x
 EKzVBxBnIxhqLztReLbtIBowL1v7rfqBu9f7DVaVbXJedlS1WsAGE
X-Received: by 2002:a05:600c:5488:b0:428:ea8e:b4a0 with SMTP id
 5b1f17b1804b1-4290aef24ebmr12107215e9.14.1723115541450; 
 Thu, 08 Aug 2024 04:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEf/JVO5M0Ai7TywbP1se/1TnBXL3qjCizyNKa4Emx6fAACN45K3mPcjXHXaYKiudkla4i+g==
X-Received: by 2002:a05:600c:5488:b0:428:ea8e:b4a0 with SMTP id
 5b1f17b1804b1-4290aef24ebmr12106745e9.14.1723115540176; 
 Thu, 08 Aug 2024 04:12:20 -0700 (PDT)
Received: from redhat.com ([2.55.14.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598f18asm69705395e9.27.2024.08.08.04.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 04:12:19 -0700 (PDT)
Date: Thu, 8 Aug 2024 07:12:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240808070912-mutt-send-email-mst@kernel.org>
References: <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Aug 08, 2024 at 08:03:25PM +0900, Akihiko Odaki wrote:
> On 2024/08/08 19:54, Michael S. Tsirkin wrote:
> > On Thu, Aug 08, 2024 at 07:52:37PM +0900, Akihiko Odaki wrote:
> > > On 2024/08/06 22:29, Michael S. Tsirkin wrote:
> > > > On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
> > > > > On 2024/08/05 19:08, Michael S. Tsirkin wrote:
> > > > > > On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
> > > > > > > If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
> > > > > > > and restart). QEMU can also migrate across hosts if the user ensures they
> > > > > > > are on the same platform.
> > > > > > 
> > > > > > What is so special about checkpoint/restart? I guess we hope that
> > > > > > downgrades are uncommon, but they are possible...
> > > > > 
> > > > > Downgrades will not work with cross-migrate=off. Users who want downgrades
> > > > > should use cross-migrate=on.
> > > > 
> > > > We also don't know that upgrades do not disable a feature:
> > > > can happen if e.g. there's a serious bug in the feature.
> > > > Basically, this makes the feature too fragile, in my opinion.
> > > 
> > > We can do nothing in such a case. Whether it is on a single host or multiple
> > > hosts, we cannot support migration if features once enabled disappear.
> > > 
> > > Regards,
> > > Akihiko Odaki
> > 
> > It does not follow that we have to do something, and this is something,
> > therefore that we have to do this.
> > 
> > This is just a reason not to handle checkpoint/restart any different
> > than any other migration.
> 
> Whethere it is checkpoint/restart or any other migration, I expect platform
> features won't disappear from the host(s); we can't readily support
> migration in such a situation.


We can if we mask the features from the guest before starting VM.

Or if we didn't, we can fail gracefully.

> When platform features won't disappear, for checkpoint/restart, we can
> enable all available features without disrupting migration;
> cross-migrate=off will instruct that.
> 
> However, if we are migrating a VM across hosts and the user doesn't ensure
> they are on the same platform, we cannot enable platform features even if we
> are sure that platform features already present on a host won't disappear
> because some hosts may not have features in the first place. We can set
> cross-migrate=on in such a case to disable optional platform features.
> 
> Regards,
> Akihiko Odaki


This is too big of a hammer. People already use what you call "cross
migrate" and have for years. We are not going to stop developing
features just because someone suddenly became aware of some such bit.
If you care, you will have to work to solve the problem properly -
nacking half baked hacks is the only tool maintainers have to make
people work on hard problems.


-- 
MST


