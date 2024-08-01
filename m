Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2A7C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXqy-000516-9m; Thu, 01 Aug 2024 11:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZXqw-00050V-9E
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sZXqt-0003KI-Qf
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722526585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uKwxJ656eK/MctdeVGWOKH+fcSc3qdz50M8hWts3hwc=;
 b=MYgGsRASauBOVbE3XEeMR8BztrDVqixtNHzbYRTtaiwFlWqjUToJiwyimTbJoXtwPAHlye
 Whm3LlnmN7dt0crdAByNfNE9S3yIikANuufqsdLQ5q3fujgIDqS9aawExrYR4oqTRnfPhM
 legvq6zNlj1Mv1hBen/Un0OgH2H28vM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Cr6rK0irONiKCXfgF9bqIA-1; Thu, 01 Aug 2024 11:36:24 -0400
X-MC-Unique: Cr6rK0irONiKCXfgF9bqIA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-44fed9796aeso6840911cf.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722526583; x=1723131383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKwxJ656eK/MctdeVGWOKH+fcSc3qdz50M8hWts3hwc=;
 b=Fl7P3bmZHsCpq9fa95wmpQcZ+FXmOg6lTNkEi33hz1igK3IwL3ic0TX81+iQtMg8Vf
 HgI4RkgUG6nlNmP4hMS37UYxU/O6x411kjH7xyOBcbEmuKHOAPkcFl/Gk5EgJjv+gOt0
 GBvpo0MaY8LBJQ0rDoZUpYH9jixhmJxZsni83+WkqCjALX08WH4RD4Npodg/81p3j2vG
 Ma15c2xCJwbt+5kFG6Ldw/CHNRfpIsKAzT7iSxhSIY4TvyX00KWZ4NhzhKR2x8jHkvq6
 xFcDNgNmTjZF1V+GDqGErotAAylvPBHBLsDoUu4n3m4GZ/qJ82sivUPw0jgw2k/zp3/f
 tN6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyFO/MwG6CyXENllZci+TmOyyA1knEWmIfJytyPrb3Lj+rNzmPzx6rDU15chmk/y6lMhUU/c9KNVXTCExzvoaH9YUjzc8=
X-Gm-Message-State: AOJu0Yx7r6QLyAB4rcnbJsBa1D+NTrw+QDuAzk3z5nO+NwK1lOBlbsIv
 mWVARyCZM0l3eN7KFmonj9ErVPsDkTSoFQtxYBLXqsN6Ykos4gI/HPAZjo2e7QnI6THrD0ala7Z
 L7igCEVztuw5WOpsQrZj2UqANlTtNq5bRXYTRe9nkgS4ssI833WjY
X-Received: by 2002:a05:622a:54b:b0:446:58f5:e6ff with SMTP id
 d75a77b69052e-45189206da2mr3067311cf.2.1722526583411; 
 Thu, 01 Aug 2024 08:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGntVaerKS0VZlDDLreioJ3NBc4K6to20nHdmCNFpnf61ixkuJG0Lj+8ggR2rBhoyuAdDLEIg==
X-Received: by 2002:a05:622a:54b:b0:446:58f5:e6ff with SMTP id
 d75a77b69052e-45189206da2mr3067051cf.2.1722526583050; 
 Thu, 01 Aug 2024 08:36:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44fe814603esm69543681cf.23.2024.08.01.08.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:36:22 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:36:19 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <Zqurc5m52YivhlYU@x1n>
References: <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
 <Zqo00Na1MZpksY9A@x1n>
 <20240801014222-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801014222-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 01:51:00AM -0400, Michael S. Tsirkin wrote:
> So I suggest a single command that dumps some description of host
> features, to be passed to qemu on destination. qemu then fails to
> start on destination if some of these do not work.
> The advantage is that this also helps things like -cpu host,
> and a bunch of other things like vdpa where we like to pass through
> config from kernel.

Something like that could work indeed.  I'm thinking whether it shouldn't
require a new QMP command; that sounds more work, and we also needs Libvirt
cooperations so QEMU migration will still fail.  I wonder whether we can
integrate it into migration handshake that I referred previously in our
TODO item here:

https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake

The "device handshake" part (in the previous plan) was that we at least can
verify VMSD fields matching on both sides - VMSDs are defined in both QEMU
binaries, so migration can do that already without device opt-in.

What we can do on top of that (or even, before that) is, maybe, allow
device to opt-in in such handshake besides an "VMSD check", so that there
can be something hooked to the VMSDs or similar structures, so the src
QEMU's device A can talk to dest QEMU's device A making sure everything is
good for migration.

Virtio can handshake on host feature lists and we can fail the whole
handshake there.  Same to -cpu, or vDPA, as long as opt-in hook is provided
on both sides.

The good side of it is it sounds natural to integrate this with a handshake
(when we can have it).  Meanwhile, we restrict everything within the device
scope, so neither QEMU nor migration needs to know what happened exactly.

Would that sound workable and better?

Besides, I also wonder what's our next step for this issue.  Should we fix
this on the safe side, and only set ON by default when we have the
handshake ready (in whatever form, either above, or a new QMP command)?

It's just that the handshake in general may still need some thoughts, so
I'm not sure how fast that can ready, considering our very limited
bandwidth so far.  Maybe that can be done separately, but I remember Dan
used to suggest we do handshake right in one shot, and I tend to agree
that'll be nicer.

Thanks,

-- 
Peter Xu


