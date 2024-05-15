Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3C5C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 22:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Mhp-000718-S7; Wed, 15 May 2024 18:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7Mhf-0006zy-VW
 for qemu-devel@nongnu.org; Wed, 15 May 2024 18:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7Mhe-0007qM-CT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 18:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715810545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xElT5ZYqp5D7rh3ZWiAAfUyWXd6KJ/0bkqeudsbUmic=;
 b=Fstbz6nj+61iMR3uYOcLRgLn6kffq2qFlnQz/TMOhOKigR1AmWfT0Pr5kpuUYhELI8j7kw
 zG5FPDPkzBqG3iuGG+AmTHWUx5/3jvHjEd8CVXDZortRSVNRfScOLEtdG0lediypK8v9GX
 m/OV7h6/dGC2BxNt1FNKTM3J2II16Bc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-WVtb3F6_PuGmVkqrFDh_jg-1; Wed, 15 May 2024 18:02:14 -0400
X-MC-Unique: WVtb3F6_PuGmVkqrFDh_jg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-420122cf3eeso19389175e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 15:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810533; x=1716415333;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xElT5ZYqp5D7rh3ZWiAAfUyWXd6KJ/0bkqeudsbUmic=;
 b=W4Rt71rwSYXy9wUXfF1F08fNs6ukiwfYVaX/9TEMiHYnTKNNRikXqkTBjS5ZxlprmQ
 ubBFAIfrR0oxkbUhZ4EdhWwizx3sBNimdn4ZZxeZ1xnZi4UdfWSQXY9waL47iHyHDLS3
 cHdS4cx/tLSUSUwvBvb3xU7mpXrIawn0+zdTlym0EzYJ8x2KN2XsMpPA8aL5wudN4QAC
 xRf5O1PNmFZkErAxdVlwyiRozsnxtdhFYR30X20yz8xjmuB6c9FyRcgllNKx+4l4+WqP
 AXIadH97+/Izb1OM2wJIFUl4StlnWsQhEkLNA6R67aiWtcOoLTC120fAAyIX8XwIxFlt
 /wiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1w/xHBdsSVw5DEJ7QM8X3XNwo5URdF8xN+sgrzjkDwcHTzBZZXFrsSCAwRDLHchWj9OK1neSeOJEt1xn8ed6DG7gskA8=
X-Gm-Message-State: AOJu0Yy2gnNhcQ8NbwxKAGST/xAmvAC0dlRx8/IZavyVn3N1BkCWfkLG
 ezcdE5eiPxLw83K/c5oNDQPjlBseNOghsqSIdeXmZ7YyNXof9NTudRmy5Hp0RWwN3QF8h6T99PB
 XT0uBJ++gG2y5OSbIMKJxiPF9UDYiqC1bs5zlRLsy1XlpGozqpJ25
X-Received: by 2002:a05:600c:444c:b0:41c:83aa:18b7 with SMTP id
 5b1f17b1804b1-41fead6d1c8mr117537255e9.33.1715810533164; 
 Wed, 15 May 2024 15:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMRSqsvp83zMteV+md1QNenvx0bSrcyZxxf+WSJqDudikVy4RGGWgskPEZh/8wi9v9lQorgQ==
X-Received: by 2002:a05:600c:444c:b0:41c:83aa:18b7 with SMTP id
 5b1f17b1804b1-41fead6d1c8mr117537055e9.33.1715810532546; 
 Wed, 15 May 2024 15:02:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8f9bsm248654525e9.6.2024.05.15.15.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 15:02:11 -0700 (PDT)
Date: Wed, 15 May 2024 18:02:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 5/5] virtio-gpu: fix v2 migration
Message-ID: <20240515175905-mutt-send-email-mst@kernel.org>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <20240515141557.1277999-6-marcandre.lureau@redhat.com>
 <20240515120104-mutt-send-email-mst@kernel.org>
 <ZkTjZCTwIbkZIVZd@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTjZCTwIbkZIVZd@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 15, 2024 at 10:31:32AM -0600, Peter Xu wrote:
> On Wed, May 15, 2024 at 12:02:49PM -0400, Michael S. Tsirkin wrote:
> > On Wed, May 15, 2024 at 06:15:56PM +0400, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > 
> > > Commit dfcf74fa ("virtio-gpu: fix scanout migration post-load") broke
> > > forward/backward version migration. Versioning of nested VMSD structures
> > > is not straightforward, as the wire format doesn't have nested
> > > structures versions.
> > > 
> > > Use the previously introduced check_machine_version() function as a
> > > field test to ensure proper saving/loading based on the machine version.
> > > The VMSD.version is irrelevant now.
> > > 
> > > Fixes: dfcf74fa ("virtio-gpu: fix scanout migration post-load")
> > > Suggested-by: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > I don't get it. Our standard way to do it is:
> > - add a property (begin name with x- so we don't commit to an API)
> > - set from compat machinery
> > - test property value in VMSTATE macros
> > 
> > Big advantage is, it works well with any downstreams
> > which pick any properties they like.
> > Why is this not a good fit here?
> 
> I think it'll simplify upstream to avoid introducing one new field + one
> new property for each of such protocol change, which fundamentally are the
> same thing.  But it's indeed a good point that such helper can slightly
> complicate the backport a bit.. I assume a global replacement of versions
> over the helper will be needed after downstream settles on how to map
> downstream MCs to upstream's.
> 
> Thanks,

There's nothing special about this specific code. If we want to rework
how machine compat is handled we can do it, but I wouldn't start with
this virtio gpu bug.

It's a big if though, I don't like how this patch works at all.

-- 
MST


