Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72123C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4Qi-0004qH-56; Thu, 08 Aug 2024 10:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc4Qf-0004fC-Al
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sc4Qd-0008IX-NG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723128467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ds8IK0umKYhnxlKO1uHl2oBOX4Dz1vmyItbXCFLB8s=;
 b=V4LfhC+rOoosGp8tcaURtEJlyAZrCLx+Pr7FzPdvBcjk6BkMmWZI5WNDhIAT3F/0yIYoHK
 sglP/E4B9ak10MU5AqAuSh7OM/MgQi1ACHwcJp3MuRwc87tzsysYl3exuMECTadyVOH27S
 dSqUW1SEDWKBuoXZ/5QTJXbFKU1zhuA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-x0fwqI9hMwGxT1pvjtjCZQ-1; Thu, 08 Aug 2024 10:47:45 -0400
X-MC-Unique: x0fwqI9hMwGxT1pvjtjCZQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5bb88479be6so803003a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723128465; x=1723733265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ds8IK0umKYhnxlKO1uHl2oBOX4Dz1vmyItbXCFLB8s=;
 b=URMoC+ipRJmbn+Ya2+T8AJg0HLvuJYFbQxCpY9DU7y6VBEfOMtpwwfbAzbNYAbMoLx
 sbmbZ18C43EZA6ugNPn41R0zK9UmrZHERimr39WF8C8g7dIXxytBAEno49ZBmsbjQDWO
 vxj5+LNIeR6xC+0B/3pXWE7M3xJOv8c+djVJ8IyR1G+rmQtb71V69t8/m/5kuQCr+lmj
 Xn3RVCAtIicyeaRuJs2D/ZYROn2EaWIrv6xESzI2DiPYptv7DBLz9UD5yIOy45N9tYSV
 QAC6r43OMhskvjIOjWNMQjheCQbgDpCR28p1FNiW/LogXgzztHyV7l5TE0in4MwEG/rk
 Mm4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQbrncTWEFGWlRCoKBpvOl+XmyVTd0iFU76QivpWLVeRaVA2XiQXgalDYwfnzLNADVU9ByBdYinSzoHEuhUxQpLx3gOhs=
X-Gm-Message-State: AOJu0Yy+/grdj9krMEc9S91xq0GLY1w8Y6RXhw4MqbbbP82xwVbX3Alb
 0T1uvW1d/ChGNNW4mvuzaeaCyhTgJVqRRYWXbwKT0pNuhrQsaezoTVa42OD8WDZ+d6cD0ZgGtKR
 cvyONmIUjHMTBFsiPXoN8UwnBNp5jxTkIL29uRUCyKaanoGvQnz4f
X-Received: by 2002:a05:6402:210f:b0:5a2:f154:95f4 with SMTP id
 4fb4d7f45d1cf-5bbb21d08d1mr1810883a12.22.1723128464564; 
 Thu, 08 Aug 2024 07:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6N1RTiDI1FBdsuG8XC4Iw2HSQ7YPzQrepQnJiRJzAiCdqI72T1UmRKa68Qblrx40bIQRyiw==
X-Received: by 2002:a05:6402:210f:b0:5a2:f154:95f4 with SMTP id
 4fb4d7f45d1cf-5bbb21d08d1mr1810823a12.22.1723128463387; 
 Thu, 08 Aug 2024 07:47:43 -0700 (PDT)
Received: from redhat.com ([2.55.14.119]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2bf813bsm695308a12.20.2024.08.08.07.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:47:42 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:47:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240808104559-mutt-send-email-mst@kernel.org>
References: <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
 <ZrTTCIpXLmW8c5Kv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrTTCIpXLmW8c5Kv@x1n>
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

On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
> On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
> > This is too big of a hammer. People already use what you call "cross
> > migrate" and have for years. We are not going to stop developing
> > features just because someone suddenly became aware of some such bit.
> > If you care, you will have to work to solve the problem properly -
> > nacking half baked hacks is the only tool maintainers have to make
> > people work on hard problems.
> 
> IMHO this is totally different thing.  It's not about proposing a new
> feature yet so far, it's about how we should fix a breakage first.
> 
> And that's why I think we should fix it even in the simple way first, then
> we consider anything more benefitial from perf side without breaking
> anything, which should be on top of that.
> 
> Thanks,

As I said, once the quick hack is merged people stop caring.
Mixing different kernel versions in migration is esoteric enough for
this not to matter to most people. There's no rush I think, address
it properly.

-- 
MST


