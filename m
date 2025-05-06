Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B37C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEPv-0008D5-JW; Tue, 06 May 2025 05:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uCEPr-0008Bi-38
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uCEPm-0002WP-2W
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746522996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7FIB23mvbtYnFGNFnK8BC0WEahE4E9a/GHcIYRUObXE=;
 b=MwSZUrhGwiBYUc4tij8NBSIZgsKnhnBzehO1zsWCogvSLWkpfd5r4iIqeSw+l/P2x0YogN
 PPluNLT0L4eaYCPvqMIAxbe1ZMjlZ1OZk3KakukVoQFUKcbH+uafpmDnkUD744YNZFCXE/
 l7EWi0+ZrmGPyGH/cl2HfhSpU2JrfMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-UpVHCG4nPMSivhQuo1k0kg-1; Tue, 06 May 2025 05:16:35 -0400
X-MC-Unique: UpVHCG4nPMSivhQuo1k0kg-1
X-Mimecast-MFC-AGG-ID: UpVHCG4nPMSivhQuo1k0kg_1746522994
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0af6219a5so147556f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 02:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746522994; x=1747127794;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7FIB23mvbtYnFGNFnK8BC0WEahE4E9a/GHcIYRUObXE=;
 b=fSM4lfjC3lAGC3g65YJLyVVKPX2ts69Nu+u6Za7b8jCK0awWuU5Yhx7hDSlluOOq7F
 ePRO8a78FRKaC65hrdBs5VttgviGq063ZK0u54uBV5X8YRVxrCI7CrZqB2yIPb3kpwtg
 C/p9bq7qvDmvhy5UvpHR4R+2kLUx2LSfC8edxPyJChOyMRnGHJkBC0dkyDFq2CCJgpwc
 E4hEqM8pGMQQ2pBry9x7qoeWxGguXd7D/A3Bk3rAPIOmH6OalrRT5v+HNmxj1lSgwMZr
 dyW+1u1iTqzfvsYssj0AgC/PzSYVKCATcNqrYNL0UwSUdzDbuGtYVXRZKO/bNzw6YZkU
 Tkbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQFfGMEd+5jp3V/2TcgyxpOvvu/oaGblZP7zd4mvMkAYkobHn2onXcbTeEwx8JI6kIMCGjcIRD1kIp@nongnu.org
X-Gm-Message-State: AOJu0Yw7cn5aSg/JbMmUxAOIxXGQrb6lLXI8Kf6HzV7IYKmkrcjdqKwl
 27XNihZz0pmBkOtR1U9cWUvOOaqaczbRlN9LgYHwtAfakuEofL9KtGiY3g7cLMCCTxN/9QOO28+
 iLFqd/PY4S7hKnAwsoNGjHuxwsazHJq0mw6KSvKZ9i+6VeDGpgirX
X-Gm-Gg: ASbGncvOGfUgr929iyDd5KugjhVumhiakpwhIjZE7wnr6FVc313XoT7PK28Eg2aOmfQ
 eX1qtoGzqlQ9b8b0NC67FZSJJZePy4b93z5D2DgBXEiTGgmp3FZMjE2uEy7PK/rP+/5GqHDIZw1
 /JSamu962TwsjhyimcgtLSXyFvdE/GSLCICZQ2nkycJVgbPX2PfpPS4TbfDmKjPTZsdiN2daim5
 /jeOne48r5HBCp88NBhMmzf4r0Vd5jDpF7XkXvMYtt5qxjbUEMyJBG+hFi20k9E3zl0Z3R0AI3c
 MiCZdg==
X-Received: by 2002:a05:6000:1843:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a0ab58f3camr1826758f8f.18.1746522994402; 
 Tue, 06 May 2025 02:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3AmmiSUjKPZ1cUnEPXpLCYmWW9uQ8GAIwGfxbd9IoxVrigFZ6KykE0POMwpFUld9qbrcQg==
X-Received: by 2002:a05:6000:1843:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a0ab58f3camr1826742f8f.18.1746522994012; 
 Tue, 06 May 2025 02:16:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0d3csm12772869f8f.3.2025.05.06.02.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 02:16:33 -0700 (PDT)
Date: Tue, 6 May 2025 05:16:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
Message-ID: <20250506051530-mutt-send-email-mst@kernel.org>
References: <20250502132441.64723-1-philmd@linaro.org>
 <aBnCk2WE_SNkRgSH@redhat.com>
 <20250506040903-mutt-send-email-mst@kernel.org>
 <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c4d557-2f73-4b56-8650-f16ed3cd7bb2@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, May 06, 2025 at 10:55:34AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/5/25 10:12, Michael S. Tsirkin wrote:
> > On Tue, May 06, 2025 at 09:04:50AM +0100, Daniel P. Berrangé wrote:
> > > On Fri, May 02, 2025 at 03:24:41PM +0200, Philippe Mathieu-Daudé wrote:
> > > > Legacy VirtIO devices don't have their endianness clearly defined.
> > > > QEMU infers it taking the endianness of the (target) binary, or,
> > > > when a target support switching endianness at runtime, taking the
> > > > endianness of the vCPU accessing the device.
> > > > 
> > > > Devices modelling shouldn't really change depending on a property
> > > > of a CPU accessing it.
> > > > 
> > > > For heterogeneous systems, it is simpler to break such dev <-> cpu
> 
>         ^^^^^^^^^^^^^
> 
> > > > dependency, only allowing generic device models, with no knowledge
> > > > of CPU (or DMA controller) accesses.
> > > > 
> > > > Therefore we introduce the VIRTIO_LEGACY Kconfig key. We keep the
> > > > current default (enabled).
> > > > New binaries can set CONFIG_VIRTIO_LEGACY=n to restrict models to
> > > > the VirtIO version 1 spec.
> > > 
> > > IMHO that isn't acceptable. In order to be able to provide an
> > > upgrade path from the old binaries, we need the need the new
> > > binaries to be able to serve the same use cases & disabling
> > > virtio 0.9 support prevents that.
> 
> This isn't for the single binary effort, there we are taking a
> lot of care to not introduce any change.
> 
> This is for after it; once we have a single binary (one architecture
> run by an instance) we can start testing heterogeneous emulation
> (different architectures in the same instance).
> 
> > > I don't see a compelling
> > > technical reason why we can't support virtio 0.9 from this
> > > endian point.
> 
> VirtIO 0.9 needs knowledge of the vCPU architecture to get its
> endianness. So we need to somehow propagate that at creation
> time, guarantying which vCPU (or set of vCPUs) will access a
> virtio device.
> 
> The use case I'd like to figure out is how should we model
> plugging a virtio 0.9 device in into a fully emulated
> ZynqMP machine, which has little-endian ARM cores and big
> endian MicroBlaze cores.
> 
> Alex said this is unlikely to happen, and better is to
> ignore this case by not allowing virtio pre-1.0 devices in
> our future heterogeneous emulator.

Indeed. I just do not think this can be done with a kconfig knob,
it's a machine property.

> In this same thread Pierrick pointed me to the reference in
> the spec: '2.4.3 Legacy Interfaces: A Note on Virtqueue Endianness',
> "It is assumed that the host is already aware of the guest endian."
> 
> I suppose this means a pre-1.0 virtio device expect to be used by
> a single guest OS, but it is not clear the guest OS as fixed
> endianness, because the code path checks vCPU endianness at
> runtime, so passing guest endianness as a property to pre-1.0
> devices isn't really an option.
> 
> Anyway I think 1/ I posted this too early, "speculating" as Pierrick
> noticed, and confuse the community w.r.t. "single binary" and
> 2/ I don' t understand legacy virtio and its endianness handling
> enough to figure a clever idea to keep using it heterogeneous
> setup, so I'll let this task to someone more familiar with that tech.
> 
> > > Yes may be more ugly/messy than we would like, but that's par
> > > for the course with QEMU emulating arbitrary device models.
> > > If the new binaries can't cope with messy devices then I think
> > > we are doing something wrong.
> 
> > 
> > To be more specific, having a kconfig knob modifying the device
> > without regards for machine types, means it is no longer
> > enough to inspect the command line to figure out the
> > compatiblity. That's a problem.
> > 
> 
> OK. I won't pursue in this direction. I apologize for mentioning
> this topic again too early.
> 
> Regards,
> 
> Phil.


