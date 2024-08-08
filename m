Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D180C52D71
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0nO-0001r9-Tc; Thu, 08 Aug 2024 06:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc0nM-0001jV-Pe
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc0nK-0008Ak-Uk
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723114496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zjyDMI9ogR47NxvfhuQjhsZ9/6yxTvf3cZ+Uw8+lVl0=;
 b=KjceCyIN6oxDRVX/uuha2wivuBHDDJfIQocubPdwZqNRpbxgzBUQySWpttn0Q/rhW9HXcg
 VPE4prTMqDSPtwkwB3ZI2E/XYYEgoFn8lXbgx5sn100yFY7sXNvd5WjSBaP7eHzPZcaL9j
 0bb/VGNoinYtnL67PjHoKF4jcNNVkZk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Tq2EsGtANxSjkRKK9c8dvQ-1; Thu, 08 Aug 2024 06:54:55 -0400
X-MC-Unique: Tq2EsGtANxSjkRKK9c8dvQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7a9447efcbso24986666b.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 03:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723114494; x=1723719294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjyDMI9ogR47NxvfhuQjhsZ9/6yxTvf3cZ+Uw8+lVl0=;
 b=OMUSw2eZbjMguOEudnazNYEVpbAnNhu7oUfcwOv/jP4Sre28/EbzKAgBMyi66U1/kO
 ZBLD6pBuwsy/Jzhgw+RSiF8lhX/oNywXnJw727TuYGEZ6gikGn3BJHZ5TZt+bnD3s1OD
 LypVcozn6ckJALcKwlAV6I0KDw9Mgc0jey3R4oGIicfRQ4OdkqguES0QOd52MZLAcHNw
 SxJm0an7wkQdWVQ2cMXVJoqOQffmu5sRRf7puwXkPQPAbQQ+ZMXNLBblPrsHMB8pcEb3
 XFwpWcSsY66pgwHlbm5VXICZ0/BMEs5QK0qhRH3vBq1+iY6AtUMFT4x1QmX50d5FpgvB
 Y5fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5j3l/72Oq6T3O41oHdqA67DDpTm6Qv6gknd2m2fFx8saNFhCb/upZFrdRmPQxnE2rBod/YI7SrhuDqr1+OQqVTledNR8=
X-Gm-Message-State: AOJu0Ywiyu7EW25mMHBw0NjxbWHCpt+mOAb62Zoi8J+8pX0cYiIF+Ycj
 i3TtpGBQglr6DkdlEhIsWLPCh+HMTb5SDMOmKITEa82YNIFHw0w3sDy3fZ0ROiVp0MdO9DtEU86
 aJJRHhChooLekBQaJ9CC/Woa++gIlCedXBikAGxjsATtRl3pd2ngo
X-Received: by 2002:a05:6402:5191:b0:5b9:462d:c53c with SMTP id
 4fb4d7f45d1cf-5bbb2239773mr1606699a12.6.1723114493943; 
 Thu, 08 Aug 2024 03:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX3R3jJSuExDIf/RpYZgZUuW1OzX+jfFk2nzcI4GmlYsCufcKKaakhbukRmJ48j8LYPjDsxw==
X-Received: by 2002:a05:6402:5191:b0:5b9:462d:c53c with SMTP id
 4fb4d7f45d1cf-5bbb2239773mr1606645a12.6.1723114493127; 
 Thu, 08 Aug 2024 03:54:53 -0700 (PDT)
Received: from redhat.com ([2.55.34.111]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2d34ccfsm531729a12.77.2024.08.08.03.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 03:54:51 -0700 (PDT)
Date: Thu, 8 Aug 2024 06:54:46 -0400
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
Message-ID: <20240808065339-mutt-send-email-mst@kernel.org>
References: <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Aug 08, 2024 at 07:52:37PM +0900, Akihiko Odaki wrote:
> On 2024/08/06 22:29, Michael S. Tsirkin wrote:
> > On Tue, Aug 06, 2024 at 04:35:44PM +0900, Akihiko Odaki wrote:
> > > On 2024/08/05 19:08, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
> > > > > If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
> > > > > and restart). QEMU can also migrate across hosts if the user ensures they
> > > > > are on the same platform.
> > > > 
> > > > What is so special about checkpoint/restart? I guess we hope that
> > > > downgrades are uncommon, but they are possible...
> > > 
> > > Downgrades will not work with cross-migrate=off. Users who want downgrades
> > > should use cross-migrate=on.
> > 
> > We also don't know that upgrades do not disable a feature:
> > can happen if e.g. there's a serious bug in the feature.
> > Basically, this makes the feature too fragile, in my opinion.
> 
> We can do nothing in such a case. Whether it is on a single host or multiple
> hosts, we cannot support migration if features once enabled disappear.
> 
> Regards,
> Akihiko Odaki

It does not follow that we have to do something, and this is something,
therefore that we have to do this.

This is just a reason not to handle checkpoint/restart any different
than any other migration.

-- 
MST


