Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663AEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsAE-0000y3-4v; Fri, 02 Aug 2024 09:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZsAB-0000mG-6y
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZsA9-00076O-17
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722604657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7NeK4sv5AjBrzmr0WGfA6jrvyRWZG3TcLHeQXpfwEq8=;
 b=VE34ppJ/FsYOOURVpVBfBbhyfPtWxK8N0JUs2kvz+7KeVh/PBd+MnjR+9m/zGx604GLOO+
 bHtD6hNG0n0zjSJcSnVg4EthYqBOP/T6ZQyyvTlyEswGBk899sHQoia05XKY2yF6xAnNDC
 BJTYSQM5CzvvCkny402lg9Rg+EHnkEU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-vhFn5RekOWKgy_6DfxJMow-1; Fri, 02 Aug 2024 09:17:33 -0400
X-MC-Unique: vhFn5RekOWKgy_6DfxJMow-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280a434147so52624045e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604652; x=1723209452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NeK4sv5AjBrzmr0WGfA6jrvyRWZG3TcLHeQXpfwEq8=;
 b=R6Eb3ddMOY5fzWQAx3r7AhkSQFAykhkVfB1dz4aru5BmgtUQSfWw5jsgzPzrahIwfN
 CBAafZIorJcOcvVLvVNKsgYW3UWHIQizaizV2WhWMjOxpsBSpIwH0oqjk+p51wDNA/3F
 5zW6KFlAwgiDqq03Sb8okdFJdnmVv0jxP90IujECgH2RLvqHBK1qtgpxuxLOR/fjSR50
 WQz1Zt+E24ztRNFn+luOsM+DxcJ50/SnnyplDrm6YwgtVnjdekecLH0y9+RsDV48EBlw
 yXHRQXJge5BR7YP5b2Dx7qIulnxrA4SGDZRX2a23fTANQnxg/GwaFropE5BOMdc2Crfj
 A8CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdCbxWm/lPr9hyNtvA5xilQB3URKJE3N5hh/nTDJmu4XZlCdjfSGib3GqAVCO32CpKSEScqzafDQLJfeHoAfYoaGKSwl4=
X-Gm-Message-State: AOJu0Yw5NiG+ZeAptdHNdDG329CXvkGnr+g2ANVd5Xhlpq7e38ERTUUW
 DkpXjKoJ3mtTe7PQyUykXdpv2Xzvmhj/q/6SmbLoU1sMNpM+6neY6CIG3KPv4xJzKXZPnmVdq8B
 CuFZSBX43kS09zcWpZAzlZjFWl0cXl9BwWTmgswwPEQjTG+Q2EO8f
X-Received: by 2002:a05:600c:1c9a:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-428e6b78d94mr21804815e9.27.1722604652289; 
 Fri, 02 Aug 2024 06:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVFga+VmlGqVsjo4C2MLsNVaCBkin3MBfeEA8mxi7a1vO66IKQlh9M8anStRHH8udR1LT+Ew==
X-Received: by 2002:a05:600c:1c9a:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-428e6b78d94mr21804525e9.27.1722604651458; 
 Fri, 02 Aug 2024 06:17:31 -0700 (PDT)
Received: from redhat.com ([2.55.39.123]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7cbd2sm33088825e9.38.2024.08.02.06.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:17:29 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:17:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 sriram.yagnaraman@ericsson.com, sw@weilnetz.de, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost: Add VIRTIO_NET_F_RSC_EXT to vhost feature bits
Message-ID: <20240802091627-mutt-send-email-mst@kernel.org>
References: <20240802-rsc-v1-1-2b607bd2f555@daynix.com>
 <CAOEp5OfRw9DAryCM+Yfe_WceHOfe=A_vxnvZWN2hZBybj5NAeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEp5OfRw9DAryCM+Yfe_WceHOfe=A_vxnvZWN2hZBybj5NAeA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Aug 02, 2024 at 10:34:37AM +0300, Yuri Benditovich wrote:
> At the moment kernel (vhost) and vhost user backends do not support
> this feature (and IMO they do not need to)
> In order to support it they need to implement a) coalescing of
> segmented TCP packets and b) population of respective fields in
> host-to-guest packets (number of coalesced segments and counter of
> duplicated acks)
> Just to remind - this feature is intended to be used without vhost and
> without migration
> 
> Thanks
> Yuri

it is off ny default so no big deal ...
if it's incompatiblr with vhost/migration I guess it is a good idea
to make sure users do not enable it like this.


