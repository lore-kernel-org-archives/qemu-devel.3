Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D505FCD8CA7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 16:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJaKI-00052M-7N; Thu, 13 Nov 2025 11:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJaKG-00051Y-4Z
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJaKE-0004jR-C8
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763051852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=On6JZofhUkPNHYArOzq+yr8hKMj3t0AKWkSz0p32nas=;
 b=GORXH3q8by7m71c2xd4C2o6fTZFXgIEDGg5wyRMW1ecDDhLcW7CdNgXT0N6SnrV0lGNuwX
 28V3BesluY/inPWZK9lM+EsAs7Y/nmFmsVYQVDRjHpSyz2nOfIEOcyJ7QZwKg1XnXWybzN
 zwvMtMhC8Wd3Gj8NGq7MjjXBuyRN/WY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-F5Ey8R5GPnO5UVeFigMsuw-1; Thu, 13 Nov 2025 11:37:30 -0500
X-MC-Unique: F5Ey8R5GPnO5UVeFigMsuw-1
X-Mimecast-MFC-AGG-ID: F5Ey8R5GPnO5UVeFigMsuw_1763051850
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b24383b680so477264385a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763051850; x=1763656650; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=On6JZofhUkPNHYArOzq+yr8hKMj3t0AKWkSz0p32nas=;
 b=qubCkLLjMmoALEhTDd8bDldwRjR8auMd/kyRr5QObr5VJqgnH7Fyrh38xP2dNp8iTr
 /Jms+GaVSus61ULMQHgSrhsWpYbtbQR+780VeikCSGDOddqhmzENskVSmHYj8cCihvaW
 af123ozG42Ct8Ds/PHEP9mJXNpUYg1DRqSUrQy5XbUiYTClzLDx7iv/Pq92qG77cUx5e
 UigLeZbrp/pD7RE0Wtj9W/5x3LZ8sb9mRMC67TKs/3taa3MI0xSOoKJrCH/7wbsaP9/F
 CKX+xBLJ0trdD1sQb33sqw+slC3RjpVgahzYf8WegmjY0YJluH651TIRD7zHCiFwZwQE
 7Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763051850; x=1763656650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=On6JZofhUkPNHYArOzq+yr8hKMj3t0AKWkSz0p32nas=;
 b=VMZZfCddIRIMQzTdbMP9E8bFl/wEPW/kHVqp139v2JIo0X8U+ru7tvejgxzwhjoiP/
 LIRN6VMD1S8v/a092QH4d3Hk44V2DzrhcJ9OeZ8RR83NKfhlU6a66rUnCnHD314TWUSa
 0k+MtCa75gJygcM29exolQ/QuBqTOXBduZLWy9Fb/Q/DqERw4ZBXoqAA8msyEaFybtcO
 ldF81CM7wwiPYzLzpVq/RvspRuxVw6OFEKvsmyKcBmqRFO/uvsKvMMDQ/KGwBGCoaMsD
 gW5Q3od+07+FKYv0MCrN1W8RPJ0eWZLM21JpeqTWELtIDp8E2Fepvqotu6ERVImVtfxO
 Mfpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu5Q6ZiTj3qZiib1VBOmekGf31MI9nnhQK+B1d1bx+M90agoGms4ZrzcQt67JfSeFL3b/2ZzD7KbB4@nongnu.org
X-Gm-Message-State: AOJu0YwbnkLS14IcKFVH2b2Ag1m3BOaS0zCEm78p8Ghi9DV5CQ8m9cXj
 WMEuKpDwWQYX6RPqCuM4ZltfNXsUcK91tjoJjPScEOHQdCDgXJTvGQh79mC1k+SmbWVoBfmIFel
 KfdOqaGIZss+7il/HYX3AjvbeHce37jntQzqC12dw7iedEsZIp/hBAzgS
X-Gm-Gg: ASbGnctK0moJEWZQnvh4ArnmNSVIgUecDKrIYsOXAIQEcIoPjjlsGDDbT6yccEHgswg
 pJb138Z6IuaG9SoI3NGKhLyKFeOI/XDoT6SB/ZyHxf5vsTHhz7GuIhbqDgdDecBNmSnUhGzW/DY
 zSYDnA58uQkpH4W2Jbbtrmv9oaxVwcD8M/EZiP1z0XgADkmu1D5zSIk5eTTgobprb3pdCXc9n1A
 pas82IrB9l0C/qMshrZKBhImLuN9sbfEsG/lae1wmxKaf/8r0Vrr3LJh450XaAdZba9cwG7gkMw
 /xBB1Kf1kQnNWP7ZUMhx9ho8lViiwjSRE2ONVOk+COtq4bpcplB02h/6KqtRZ5H4HMBhWj3/MGa
 XJg==
X-Received: by 2002:a05:620a:2985:b0:8b2:6a47:f5ff with SMTP id
 af79cd13be357-8b29b82b8a5mr897246985a.86.1763051850226; 
 Thu, 13 Nov 2025 08:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw+RwkNx0l+R4dJHmNGdpBT+MqeCcZfXPktlVOrmgUuQmsiBbzLajBrAobS2r8sVWBMzaNYw==
X-Received: by 2002:a05:620a:2985:b0:8b2:6a47:f5ff with SMTP id
 af79cd13be357-8b29b82b8a5mr897241685a.86.1763051849610; 
 Thu, 13 Nov 2025 08:37:29 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aee9e210sm160922285a.4.2025.11.13.08.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:37:29 -0800 (PST)
Date: Thu, 13 Nov 2025 11:37:25 -0500
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRYJRZyNrDcDzTuG@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113110004-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > We used to clear features silently in virtio_net_get_features() even
> > if it is required. This complicates the live migration compatibility
> > as the management layer may think the feature is enabled but in fact
> > not.
> > 
> > Let's add a strict feature check to make sure if there's a mismatch
> > between the required feature and peer, fail the get_features()
> > immediately instead of waiting until the migration to fail. This
> > offload the migration compatibility completely to the management
> > layer.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> This is not really useful - how do users know how to tweak their
> command lines?
> We discussed this many times.
> To try and solve this you need a tool that will tell you how to start
> VM on X to make it migrateable to Y or Z.
> 
> 
> More importantly,
> migration is a niche thing and breaking booting perfectly good VMs 
> just for that seems wrong.

IMHO Jason's proposal is useful in that it now provides a way to provide
ABI stablility but allows auto-ON to exist.

If we think migration is optional, we could add a migration blocker where
strict check flag is set to OFF, as I mentioned in the email reply to Dan.
As that implies the VM ABI is not guaranteed.

Thanks,

> 
> 
> If you want to keep this off by default, and have management
> enable this if it knows what it's doing, then I don't really
> care.

-- 
Peter Xu


