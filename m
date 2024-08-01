Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA1DC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZY4u-0007At-9f; Thu, 01 Aug 2024 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZY4s-00073d-Hu
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZY4p-00073K-QY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722527450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vj9JKEPQGwZmn4NXzfYxNmsUbT6ZxMyU6uZhZnGs1Vo=;
 b=Vl46swSRIKZvyfP2vKymLrrBzO9MAMqrg22IggvEVlN3jhuYWFrCKaBzz0OA2yr5xk4KAG
 w21HeAehp6MHilXDGUTiF+xWE2QtlYNu+Y/MTh40OphVD0EaplyfxC3ajA5Xhl3ASdkhWD
 oGpoVQPd/47/Qbp94WXa68X5IEfxe6o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-qzcGhwyCMhOohc2I3sRZdA-1; Thu, 01 Aug 2024 11:50:49 -0400
X-MC-Unique: qzcGhwyCMhOohc2I3sRZdA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a3219fc565so4876353a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722527447; x=1723132247;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vj9JKEPQGwZmn4NXzfYxNmsUbT6ZxMyU6uZhZnGs1Vo=;
 b=pLMoD7w/rHy1nceAp7YVQlFoWcRH6b/sKYZGdSVZJp0jMn9HOmz20uJgmo5qF5lO8a
 tPsUfte3khh5REY6ebqVafr3xO9P7M/O+o7MJS4v5v4NZ9mkWRhlkQD5+BUIAkfk1Y1F
 c6cNl+BG9TxuSbdvjc2d1oZcafRf5BeBj5yPQnP9AtYGUGLG1i3kxJmYqrYDTIB3/OH3
 CgStjVfVzYMictQSKxWOqK6gCzRdcdwfJj9pDeG5W+GeWr4gdS9BRlpsUTTxpmvoAewF
 kP7d7K7fX6djM4oYUOT4coRQ9w9EYIsLVjwLJdvDXxImlPvcq5Wl/ipGgkHF5VmggNZf
 nwUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd8rGpluGlTlBwQVDXoszK7O6Pz2MvWw1zqb4BRW6pazhf2e/wcyRNsiC1g0lukuEq+5IbgoBd0y1RNhhH3fbxhgAyErU=
X-Gm-Message-State: AOJu0YzxRUnJ15831FIj063z9AIdxXDrh2ktBgk0IIRZUZAd6EuHoihW
 hYRWK1oPl4D+z727bscrg5ERgO3aSJPRbDzF58nzTxP7SRP8iRYlpFxS46wO/DMucBfH3yYvKNh
 Xf7BejM+XYPLrnpZFQfhRNyDUDFZQ469SEg9ArOXYkRIGAhv8cuhDY4wTRKDE
X-Received: by 2002:a05:6402:706:b0:57d:12c3:eca6 with SMTP id
 4fb4d7f45d1cf-5b7f40a8ed3mr536229a12.18.1722527447500; 
 Thu, 01 Aug 2024 08:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEwdUQat3ke2lgtER2TvAILbOSUxErGH0d9C+5g0kG1U0/kUtt0k4ll3Qu1waxa7LSZoJZaA==
X-Received: by 2002:a05:6402:706:b0:57d:12c3:eca6 with SMTP id
 4fb4d7f45d1cf-5b7f40a8ed3mr536192a12.18.1722527446578; 
 Thu, 01 Aug 2024 08:50:46 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af2f233be4sm9133700a12.41.2024.08.01.08.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:50:45 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:50:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801114900-mutt-send-email-mst@kernel.org>
References: <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
 <Zqo00Na1MZpksY9A@x1n>
 <20240801014222-mutt-send-email-mst@kernel.org>
 <ZqutjR8WH2Owm9q8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqutjR8WH2Owm9q8@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Thu, Aug 01, 2024 at 04:45:17PM +0100, Daniel P. Berrangé wrote:
> So to ensure a QEMU is started with migration compatible features
> will still require teaching libvirt about every single feature
> that has a host kernel dependancy, so libvirt (or the app using
> libvirt) knows to turn this off. This is alot more work for both
> libvirt & the mgmt app, than having QEMU provide the generic
> "platforms" concept which is extensible without needing further
> work outside QEMU.

I am just not sure it can all amount to selecting from a list.
For example, some resource can be limited on one host or another.
Thus we get a number. Or there could be a set of N flags, with 2^N
combinations.

-- 
MST


