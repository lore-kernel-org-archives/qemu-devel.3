Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E959C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc418-0007EN-HB; Thu, 08 Aug 2024 10:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sc416-0007DR-As
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sc414-0004od-EZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723126881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGW9QHQJ8es8a1CWOa0SKU1Aa+JgBB9B9koZOeF6i6g=;
 b=BO8SG3NnbwjzELNchrcHSN9G/UXl/gU9buwFR0LYeaqRfAc+YCJpZYOCCxeJ6PKulmHLP5
 AIdCA1WqR7kvGag8p3i7tc7ith+uAK5a/YhqXN0Sfl+Kf3GLgiAr1DTHesdoHG9hXI0RfT
 whDJRWP6M1/OhI9eJNlYcgw964efsb8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-jxIDxH4mOsqYEj_-AEQ7gg-1; Thu, 08 Aug 2024 10:21:18 -0400
X-MC-Unique: jxIDxH4mOsqYEj_-AEQ7gg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-44fea369811so2368921cf.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723126877; x=1723731677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGW9QHQJ8es8a1CWOa0SKU1Aa+JgBB9B9koZOeF6i6g=;
 b=QAMMdB//70+ETYEmlizXGSILE7PMYUTS9QyBN0DMW5vtQUeg/wl9YH8+9ASnXJJSEX
 43LizQtofwZXQYr9w0sLvatG87XzyiUvcGl5BB7hfdal08hXy4+DotPAiIW52+6jKomr
 kcPZbFysVgUrpWDGgDnAYaR+IE6zskJGv7rzQTwyContelLU4zApjVf1jCZU/ruGEDEA
 z7f874NKQ21hB3N/0ooCOYyXLZYHNMZJSbfq6DjHiNgdA+rUtns1QGEyWWodLsRVD8qs
 F8GEtl83W86tdYGAz+5wG1WUkXa8XcgteAhdpsO+j3FbgyIkOejfozNBNaUkmRjzACIo
 mwdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdoHUpgiks5wJsQ1hsJW4O9loiF2UK+CYmLXKivmpVD0ScG591crxELvw/+8YyCfVeanVW83VME9koUuMOVWR6tYFHims=
X-Gm-Message-State: AOJu0YyLDEb5H+oujefTxYeAywm/pa/gGRyMYnvtbztGyWNkH2fgAh4d
 tETJq5V9aZuf/E2TC58YRL3ssx51GnjdJYBvaoWnlU7WUolbAVGK2Lr8WG07Ypt5a8/XAz1dWxv
 KEsbF6Qez6SoEbRliIIg+qrLUlx0ViaKdoM3Vsi+5BZ2b/2Lqumsp
X-Received: by 2002:a05:622a:110a:b0:44f:89e4:131f with SMTP id
 d75a77b69052e-451d42fe90amr13165761cf.12.1723126877221; 
 Thu, 08 Aug 2024 07:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy2kX62fLeP0bSdmX1mn3aFkmAWdkmsHQLRnM6U0zlROHCSgOTgqqF4EKI4ws3dU8H0oIOAw==
X-Received: by 2002:a05:622a:110a:b0:44f:89e4:131f with SMTP id
 d75a77b69052e-451d42fe90amr13165601cf.12.1723126876802; 
 Thu, 08 Aug 2024 07:21:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-451c86fb365sm13464201cf.10.2024.08.08.07.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:21:16 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:21:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZrTUWfbor7uA2J5V@x1n>
References: <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
 <770300ac-7ed3-4aba-addb-b3f987cc6376@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <770300ac-7ed3-4aba-addb-b3f987cc6376@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 08, 2024 at 08:32:58PM +0900, Akihiko Odaki wrote:
> On 2024/08/08 20:12, Michael S. Tsirkin wrote:
> > On Thu, Aug 08, 2024 at 08:03:25PM +0900, Akihiko Odaki wrote:
> > > On 2024/08/08 19:54, Michael S. Tsirkin wrote:
> > > > On Thu, Aug 08, 2024 at 07:52:37PM +0900, Akihiko Odaki wrote:
> > > > > On 2024/08/06 22:29, Michael S. Tsirkin wrote:
> > > > > > On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
> > > > > > > On 2024/08/05 19:08, Michael S. Tsirkin wrote:
> > > > > > > > On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
> > > > > > > > > If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
> > > > > > > > > and restart). QEMU can also migrate across hosts if the user ensures they
> > > > > > > > > are on the same platform.
> > > > > > > > 
> > > > > > > > What is so special about checkpoint/restart? I guess we hope that
> > > > > > > > downgrades are uncommon, but they are possible...
> > > > > > > 
> > > > > > > Downgrades will not work with cross-migrate=off. Users who want downgrades
> > > > > > > should use cross-migrate=on.
> > > > > > 
> > > > > > We also don't know that upgrades do not disable a feature:
> > > > > > can happen if e.g. there's a serious bug in the feature.
> > > > > > Basically, this makes the feature too fragile, in my opinion.
> > > > > 
> > > > > We can do nothing in such a case. Whether it is on a single host or multiple
> > > > > hosts, we cannot support migration if features once enabled disappear.
> > > > > 
> > > > > Regards,
> > > > > Akihiko Odaki
> > > > 
> > > > It does not follow that we have to do something, and this is something,
> > > > therefore that we have to do this.
> > > > 
> > > > This is just a reason not to handle checkpoint/restart any different
> > > > than any other migration.
> > > 
> > > Whethere it is checkpoint/restart or any other migration, I expect platform
> > > features won't disappear from the host(s); we can't readily support
> > > migration in such a situation.
> > 
> > 
> > We can if we mask the features from the guest before starting VM.
> > 
> > Or if we didn't, we can fail gracefully.
> > 
> > > When platform features won't disappear, for checkpoint/restart, we can
> > > enable all available features without disrupting migration;
> > > cross-migrate=off will instruct that.
> > > 
> > > However, if we are migrating a VM across hosts and the user doesn't ensure
> > > they are on the same platform, we cannot enable platform features even if we
> > > are sure that platform features already present on a host won't disappear
> > > because some hosts may not have features in the first place. We can set
> > > cross-migrate=on in such a case to disable optional platform features.
> > > 
> > > Regards,
> > > Akihiko Odaki
> > 
> > 
> > This is too big of a hammer. People already use what you call "cross
> > migrate" and have for years. We are not going to stop developing
> > features just because someone suddenly became aware of some such bit.
> > If you care, you will have to work to solve the problem properly -
> > nacking half baked hacks is the only tool maintainers have to make
> > people work on hard problems.
> 
> I think you meant cross-migrate=off, which is the current behavior.
> 
> I am not suggesting forcing cross-migrate=on or even making it default. I
> have shown four possible scenarios earlier[a]:
> 
> 1) Migration everywhere
> 2) Migration on specific machines
> 3) Migration on some known platforms
> 4) No migration (migration on nowhere)
> 
> Taking the discussion with Peter, I amend 4) as follows:
> 4*) Migration on one platform (checkpoint/restore)

Maybe we can avoid calling out "checkpoint/restore", but something like
"migration on identical hosts" or something.

AFAIU that's what we do with many arm64 systems on the vcpu models with KVM
(IIRC it's still about using "virt" machines), where we simply mostly
require it's the identical bare metal host or weird things can happen when
migration happens.

> 
> cross-migrate=on is a complete solution for 1).
> 2) is dealt with another proposal of mine.[b]
> 3) can be solved with the -platform proposal by Daniel.[c]
> 4*) is what QEMU currently implements.
> 
> [a]
> https://lore.kernel.org/all/39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com/
> [b]
> https://lore.kernel.org/all/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com/
> [c] https://lore.kernel.org/all/ZqO7cR-UiGpX2rk0@redhat.com/
> 
> Regards,
> Akihiko Odaki
> 

Thanks,

-- 
Peter Xu


