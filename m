Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E32D3943A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8K4n-0005iZ-Rx; Thu, 02 Apr 2026 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8K4l-0005iL-61
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w8K4h-0000QM-8x
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775144109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ/If0t1Q4No35SOkkaO/KUUsRqOV3KKCfibOvnk8k0=;
 b=XZjkvMcfaD/vmtjH250gzIIO5orOEtmAqAMXbQojJI1tWe2RvyktmfahWtG3um+mSLpMWI
 lgUgbmGhToN4zW7tdIhZr5oZMfL/zGJ4p4/gl4KIwFy9bqmDme0ZKLHMAVr/+0eE9kWUny
 5PIjTQSeHNfhVXqLpi1vrVZj4O/yv4s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-qwn7yGW5MFGgmIcX-3H0Pw-1; Thu, 02 Apr 2026 11:35:08 -0400
X-MC-Unique: qwn7yGW5MFGgmIcX-3H0Pw-1
X-Mimecast-MFC-AGG-ID: qwn7yGW5MFGgmIcX-3H0Pw_1775144108
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso27544741cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775144108; x=1775748908; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pZ/If0t1Q4No35SOkkaO/KUUsRqOV3KKCfibOvnk8k0=;
 b=iJlgwW9/mTWmym2Uf9jbshkjb+uwHMF4KeJjVk54bdnWsQ5JFD2Rx7WxSoDJrEpv8L
 phQ4wktN7a1JkuMxkCEmbL51hWUuxoKLRZkapEKm4heQTSwcmt2AZafpMBdeHyrj4O95
 MoooYx4AoCnL3qy59FvKPBX6DjUDLNEe/efqormiclHi/42hho9+C9gWz6zS+Ty82jgh
 /IgztpfsUccKjbeZgLxiuJrKTBeRSBkCSjRRt+mDOId2silU5hoXOq5CDbZgfcqJdU3E
 k+/bCG+Lr+6GwvARehjmN6Lc8iVyEOfVHtbAzvJZ7QwJGTe3Xe0TosIfrFL7mItvsTa4
 mP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775144108; x=1775748908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZ/If0t1Q4No35SOkkaO/KUUsRqOV3KKCfibOvnk8k0=;
 b=CyEToy8miFwvb7xq3LMyhydyiWtBqaFAaNfLK/CGluGK5kiY/4AfW17qVc+xlRM3LD
 ggnCa5OrHUXGCe9CVpW5urm+ZjjngsqbxAag2t7r3+LJ/cEolefv3IJUc/Cn3gN301K6
 K+gdozBCJ1+ohc9YHIUNldWc/Aw4jo/BbYhm2DCIkwf4R19Z/jDP9vvG/GXYRB/6CMKt
 al49najgDLKtgXe4SMToRjRJgdmsBg2W7EN7farNk3TW6KvZ7IzZAo403spzMXOWqz2K
 NHjLPchdiyxX7FiMcSAW85jWupjB881EtJsYpc3fEpq/AIlGucmb8Jxbb8xF+hAVLAZs
 A4EA==
X-Gm-Message-State: AOJu0YwpTsq8nosNQUm4sc7dlmV2u7ojdzT5X+XuPSR6/Bs1yxaWKxS6
 AaXOJYQOdfbODDyuzj9gSehgRNIe7egoxh8r4mdqX6wVvjtgnJ3CawGn696IvW1de8D8PTAQXAE
 qVTTx5WIlgvHSxOuEnUvbLnBTjefQvWxJNKcyvMFvyhByOGzfA43TPWAu
X-Gm-Gg: ATEYQzxWytwqVAypyqKs2UrBlxJLZY2oFn2et7TSqONG/kdXPd+2KH80NOUBG6w5hu2
 q4rV1+dDEzXpGL7BRtVB9Sl+/OgSW9611MV0Sc0LQZjKqPqu5X0gxkZc5nDafcGWFGvZ4fDr/iV
 OiYqvs059OkAsuyYwenSBBhIzyo8vEiA24fZftPI8AM4MXsxjXWrzeYMZoNqNOgaTz/odyk9ILd
 BeaHk8oXo0bZBbV7GNGcGhf6HumtghjD//ogT3974hAKZ7A2NBzjFYxBIcyTdrPKeCY/2YdX0ky
 wUR7NLhYEJJQQCAvDwOQlXErxsoO24l2/SMn3KF7MvX7zXo0SEU/bH/m+G2MrNIofArm7/TDO/s
 IJibiBXfZVsBZSGJozM5/7/PD8jpmgsK8bycMCHb0TrR0eQ==
X-Received: by 2002:ac8:5887:0:b0:50b:5286:f768 with SMTP id
 d75a77b69052e-50d3bcec088mr108108841cf.48.1775144107650; 
 Thu, 02 Apr 2026 08:35:07 -0700 (PDT)
X-Received: by 2002:ac8:5887:0:b0:50b:5286:f768 with SMTP id
 d75a77b69052e-50d3bcec088mr108107981cf.48.1775144106863; 
 Thu, 02 Apr 2026 08:35:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b8a8f38sm23900331cf.24.2026.04.02.08.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:35:06 -0700 (PDT)
Date: Thu, 2 Apr 2026 11:35:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yong Huang <yong.huang@smartx.com>
Subject: Re: [PATCH RFC 09/12] migration: Make iteration counter out of RAM
Message-ID: <ac6MqMLErjou_3nj@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-10-peterx@redhat.com>
 <CAE8KmOzqJzdez1xuXOsPyq2ewrCohg+a0VfgmbkPkzTS6nr9Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzqJzdez1xuXOsPyq2ewrCohg+a0VfgmbkPkzTS6nr9Wg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Mar 20, 2026 at 03:19:17PM +0530, Prasad Pandit wrote:
> > Said that, we have code (not only QEMU, but likely mgmt too) assuming the
> > 1st iteration will always shows dirty count to 1.
> 
> * Where do we make this assumption? I mostly see 'dirty_sync_count'
> read/used as is, only cpu_throttle_dirty_sync_timer_tick() seems to
> skip one *_bitmap_sync_precopy() call when sync_cnt <= 1. This'd works
> for zero(0) as well.

That is one reason, the stronger reason is mgmt like libvirt can also read
this value from QMP queries, and it can matter on mgmt decisions on
migration operations. Changing definition of this value is an ABI break.

-- 
Peter Xu


