Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F4C3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 07:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXFKl-0007lb-9J; Fri, 26 Jul 2024 03:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXFKj-0007kz-Dr
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXFKh-0006Dn-4D
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 03:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721978741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a10z7OOKlps1dKjKjZLZqTIsG1sy26J5I6Inq5zH4Z0=;
 b=R2d5eCgheiwNzpzXPwBh//QdHSG2IhQFitrkR9V8iTbUAUqjiYBm1UruQYAo11yihm+Dy5
 s6bMv8zAsRV9be+RqWpOFWWN7WnqWCjykVihf4FB4sN0ahM9dMAbt4vSVsbEyjiH2QM08V
 5EDr/ohSyplGyBo7ZJpH4qUcnrdMiiE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-SnKQoLKPNEGWn_frDusY6Q-1; Fri, 26 Jul 2024 03:25:39 -0400
X-MC-Unique: SnKQoLKPNEGWn_frDusY6Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3685a5a765fso992492f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 00:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721978738; x=1722583538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a10z7OOKlps1dKjKjZLZqTIsG1sy26J5I6Inq5zH4Z0=;
 b=e7EgGIU7NMCoOa6ueGsmLq7i3L1LRZSugkDxSUIalwFlOvfcyAViLrmsWJycTKhTam
 dEKNQiyjZ1jGLTY1a3cBUaV+lO/zMnp6BohSBCDJKkHyRanRdzuVRcCsVr2kfLRPu5MR
 ziM0qGF/bFTnL3W6HIVO5f+pUx1U/7P0DYR0XIhMiEb3kuAMS1MPIFV/PJA0/qkIRcCZ
 3wK2VzmOTUDFpvGiMs2fEEa7PYfwtvelulzBr+tvOdXXpNnHKxscILwTTrSJxK5gV4oI
 My+xzigJhxbitNxQYZOrj2jk6Zrv5MSYU47repSID/TvT2L1T05OuMuKDzyvLUehmu97
 TEyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ8CfirMA9PwxlYzcajrRGDPQACfoTIUAarTJawHfgJbTbXf1x6CzqZ7K3GJv/Hg1TO8OOOly4ZPLWpWLPqULYu8IIw+g=
X-Gm-Message-State: AOJu0YxgPPZ+bV2lc/WDX+LF5+3BbvWK/qHQNrEF7f7SqsJZCKTFXCuu
 lQXO2sp4PPitEM1/Tn0oW2z3f4yRKQ2GFkLQkzzTT08DFBRlEIpPxh3ghY181re2Rw2Phva0X3Y
 8k8MNhioknHj+feNm5CiiBAMHVY5zo6MGmbiKDkBde4zfl9getyBV
X-Received: by 2002:a05:6000:1a43:b0:368:4ee0:3c65 with SMTP id
 ffacd0b85a97d-36b319ed3a1mr3011135f8f.37.1721978737954; 
 Fri, 26 Jul 2024 00:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8H0ddhrO3tbRfHxljyEiiKF7BBZJDFN5KFpoAU3HF6ASmStZL92EwfRwiaY3UO8EVash3tg==
X-Received: by 2002:a05:6000:1a43:b0:368:4ee0:3c65 with SMTP id
 ffacd0b85a97d-36b319ed3a1mr3011107f8f.37.1721978737235; 
 Fri, 26 Jul 2024 00:25:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c093bsm4300080f8f.18.2024.07.26.00.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 00:25:36 -0700 (PDT)
Date: Fri, 26 Jul 2024 03:25:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240726032520-mutt-send-email-mst@kernel.org>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > USO features of virtio-net device depend on kernel ability
> > > > to support them, for backward compatibility by default the
> > > > features are disabled on 8.0 and earlier.
> > > > 
> > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > 
> > > Looks like this patch broke migration when the VM starts on a host that has
> > > USO supported, to another host that doesn't..
> > 
> > This was always the case with all offloads. The answer at the moment is,
> > don't do this.
> 
> May I ask for my understanding:
> "don't do this" = don't automatically enable/disable virtio features in QEMU
> depending on host kernel features, or "don't do this" = don't try to migrate
> between machines that have different host kernel features?

The later.

> > Long term, we need to start exposing management APIs
> > to discover this, and management has to disable unsupported features.
> 
> Ack, this likely needs some treatments from the libvirt side, too.
> 
>  Thomas


