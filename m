Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12573D172B0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmofF-0002m8-V1; Mon, 02 Feb 2026 02:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmofB-0002lP-FY
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:48:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vmof8-000584-Ur
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770018477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oxAKzva2eSOWImboICQe28giQkBgHp5j/9c16XKDLE=;
 b=EQFEyQZrm5pNeoqH/lAlidABFvBexypA243fAIbkzwNDQoZ2eFJN4t5UYD4aZQhJexxUV2
 posQ/vsLB1z+qL7szKV8yFTFXz31pP90W08R3xliw8wumtDmr2R6rz1c/O/dmqCUAT5srZ
 5YHJHUbELxPuj4eKGji/0wcZmURE5KM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-_Qitm7TIPtWKV-IUJCobzA-1; Mon, 02 Feb 2026 02:47:56 -0500
X-MC-Unique: _Qitm7TIPtWKV-IUJCobzA-1
X-Mimecast-MFC-AGG-ID: _Qitm7TIPtWKV-IUJCobzA_1770018475
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso2644299f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770018475; x=1770623275; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1oxAKzva2eSOWImboICQe28giQkBgHp5j/9c16XKDLE=;
 b=nuSpv8jAJv4SIji0yV/xzSHtBguUeF/4ePD9Lu4VlNRrIb5H3ZiCw1jb5iboAQ+al+
 nEHW4ld9/jCjuxq6K/FPsRbVg6QDBpqW1iKdBWckYwv1DPFVMj/pZPSzzabJkYp/N4Qu
 L/dQpH/hpA43weNEfvGvSdwcTM2btudMqNn2oPnfQEOFzsB9EqqOYtM/aN+/HpM/hw21
 rMbDcAlYlLhgBmOxSKOwvmwmlq2i59rNgfxD7YgPdDPGm6rtL5vQkDMCpkhUuEt5HWOF
 CnIgz89sxBoad+ydbAwIs/o6p4DQP+zXTqAhoCeK2/CT4zuSP+1nFoiICe/8cYzihYVl
 qhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018475; x=1770623275;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oxAKzva2eSOWImboICQe28giQkBgHp5j/9c16XKDLE=;
 b=jBhImy3M9qXDrxPiaVmTrDINixJ3gPaIZscXeMZhqP4cK9zVwaISFLlTcfBohUCPL6
 3FOLN35qWzmSATMKikeKCNIx3ZGfmS1x5JKnb0hJtcsbJBgkF8PWXfF0IYkDEypUpiTE
 87P+1bVe4hHmhmokLDcJbJ8YQpMyycDZjwpA9pnCtYWWlFeegrHCH8HlQvujZM3kq7f2
 3JsuWED1JRALT0isSI0OWGUDlUlMSNpzhoODDFZg/bC40Jdzfp5QSz3jw0i3JANnh5n/
 KkRzdz6HSS9fD7yPl9PN2r0OoLyBd6VfKgY+5Svt0Ci5+4ouInG7dscVlpSJHbP6jDC4
 eDPw==
X-Gm-Message-State: AOJu0YxFDvX7PDvUTGkvSO6M4QJboHMoNslzpi056X5QRTV1n+b0zYfD
 f81uWyBnglVfaRE/ogE8qLmuGYmf2PMnFWODIH89jvPMZ85qRiVbHoWwqKz3gVK4j3sFhlJpjwE
 +L75hY/pdsrnoquuP+Zps5HUA4StUNMDY/0tznwUW1FIeLW74mQhK6jBj
X-Gm-Gg: AZuq6aKNWaldStT4K+wH5rMdPqcbPc39aa22F91PBkp3r4onOySCSMgSa/RvfnCdZg8
 KmcTHTf/N9PSm//0VEYBDJIdJyP3BIT+X4gSxKQjp5khswhu71jX2DwQbjT74NOB+82JRk4mCs3
 MdeK93NjEWauYigWITeZ9i5ETwrNX9ZMkJ4/ed1PtGIaek9xlL8sLIxVARsMafyah/o3cyB+S1D
 aGkbZm/dU+Gb46oSmg/2LG6Wj+63CVEggMwBBOcHm0+yN0YLFHFNwIM8lF9CRzUwRzcWnh98mNS
 yP5In+F9lOGMhlVEy/PphUai8h1oQwZs3dPFhO8OAO7/XGWiBeP3uxRZ9FFJCCyvQEfFVbUIGPq
 HuDUgtVy8SXBY4CAGQfDvXrUJ4v470cev0w==
X-Received: by 2002:a5d:5d0c:0:b0:435:e433:4ca with SMTP id
 ffacd0b85a97d-435f3ab531amr14076219f8f.48.1770018475073; 
 Sun, 01 Feb 2026 23:47:55 -0800 (PST)
X-Received: by 2002:a5d:5d0c:0:b0:435:e433:4ca with SMTP id
 ffacd0b85a97d-435f3ab531amr14076201f8f.48.1770018474716; 
 Sun, 01 Feb 2026 23:47:54 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm41458866f8f.14.2026.02.01.23.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 23:47:54 -0800 (PST)
Date: Mon, 2 Feb 2026 02:47:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 00/11] single-binary: hw/virtio
Message-ID: <20260202024608-mutt-send-email-mst@kernel.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 02, 2026 at 12:29:12AM +0100, Philippe Mathieu-Daudé wrote:
> This series eliminates target specifics in hw/virtio and replace them
> with runtime functions where needed.


This is not bad at all. I feel we do need to have the performance impact
tested, however, just to be sure, since it's probably the hottest path
for I/O.


> v3:
> - include missing SPAPR_MAX_RAM_SLOTS patch
> v2:
> - Reduce runtime calls for performance
> v1:
> https://lore.kernel.org/qemu-devel/20260131020100.1115203-1-pierrick.bouvier@linaro.org/
> 
> Philippe Mathieu-Daudé (6):
>   hw/virtio: Constify virtio_is_big_endian() argument
>   hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
>   hw/virtio: Use VirtIODevice::access_is_big_endian field
>   hw/virtio: Reduce virtio_access_is_big_endian() scope
>   hw/virtio: Check target supports legacy bi-endianness at runtime
>   hw/virtio: Replace TARGET_BIG_ENDIAN -> target_big_endian()
> 
> Pierrick Bouvier (5):
>   target-info: add target_base_ppc, target_ppc and target_ppc64
>   hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
>   hw/virtio/vhost-user: make compilation unit common
>   hw/virtio/virtio-qmp: make compilation unit common
>   hw/virtio: make all compilation units common
> 
>  include/hw/ppc/spapr.h            |  8 +---
>  include/hw/ppc/spapr_common.h     | 17 ++++++++
>  include/hw/virtio/virtio-access.h | 46 ++++++--------------
>  include/hw/virtio/virtio.h        |  7 +++-
>  include/qemu/target-info.h        | 21 ++++++++++
>  hw/virtio/vhost-user.c            | 11 ++---
>  hw/virtio/virtio-qmp.c            | 70 -------------------------------
>  hw/virtio/virtio.c                | 25 ++++++++++-
>  target-info.c                     | 21 ++++++++++
>  hw/virtio/meson.build             | 17 ++++----
>  10 files changed, 113 insertions(+), 130 deletions(-)
>  create mode 100644 include/hw/ppc/spapr_common.h
> 
> -- 
> 2.52.0


