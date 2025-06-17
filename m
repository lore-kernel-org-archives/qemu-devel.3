Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5F3C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJA-0002qZ-IX; Tue, 17 Jun 2025 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uRYI9-0000vN-HA
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uRXoa-0006iP-Ly
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750172489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZ/FNwPh0yNIGXKX7HbyExeNX/fl39clUsNyyBOmEfg=;
 b=DKYgx/MqezHsQXkiXfiyKArKZAqbQJPTx+BMytZCbmZKpo2+xcKNpW1JqVfR8OR4Avzrjc
 7aHdGrrb++TB+vnpj9rHAPL4oRuC6bNguF0/3GQ0NxraNuq5K+wUuB0CS2/HcY1EEs2lCA
 x5qZUw9gf5aEvS3rNZ2YdRf7Z/l3PaU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49--NW3NLsRM0qIwDcgZ-RAvg-1; Tue, 17 Jun 2025 11:01:27 -0400
X-MC-Unique: -NW3NLsRM0qIwDcgZ-RAvg-1
X-Mimecast-MFC-AGG-ID: -NW3NLsRM0qIwDcgZ-RAvg_1750172486
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d57a0641so41515655e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172485; x=1750777285;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZ/FNwPh0yNIGXKX7HbyExeNX/fl39clUsNyyBOmEfg=;
 b=LAhPs+uxeF3/9YtCqv7zShGEaJSj9X5RqheGhmLukCDFxZZWXifXQX5HaofqiCsRC1
 RyCOLyh6oWUcg8T1pAjaGbevbDK2242pB6oRDSghS1+OI2PQROgrQU9TXzPakmJ3dyn8
 /sOQepoWjIcnWUuGpOCFg5GyI9KmaZTtBNjEk4AE4cD9WZqCFmhg5pXvOo3UyGwJxhac
 1lSt8JGWRGRViBu5j0ZxdsSqgMJWqXwA1GejeDMyQS1VfWfyGReaZXADjx8mUE30GPWp
 jJn3DqtseJ0p1ikHCJj6ARRnh7IBo9EAlJE2uh2dkG4hzK5wAy96FMdcOUoX0IpTTWIU
 S94g==
X-Gm-Message-State: AOJu0YzJPDXbX2pBBcVvIS6fD50u+lIYCdoonzk5Gtwqnx4FxIKMSZMq
 sjibK83leqM0W8sW4LRxBdvX2wM/Ttc1MmVzd0Z/1ngweIfLV3J8UmlaYAKpbvG1nX0mP3Jo7Bm
 PdT9rYK/Jd2xd8IldKAB/wJJt9yrYnWt44VDawMqR0G/Ar/LDKuD2bVWmiA/FEeRNF+rtNo+InZ
 6vZ/JesgdjPVQ4vzFPNZ39oHKl7cThoHXHzB9BbcLE
X-Gm-Gg: ASbGnctfumlEKDpvOq6TxxjxfLI6Ajse57dy0eqzsTz9No+g7oFAbaLjSoKmYwt+PLG
 Q2G5jZbxGltE+F1nBgvtgvPsRuYPthDQnwpyvcRyN3ueKMc1Am9f+yXVk9VAaSHzoStjYVSmm5S
 8emQ7Gyt7cuiBuYgURMBMlwqGpe1hNrSIqRW7t38BZOdcp8QGDNe0C3Nu0GHZH+mere8ScIFiSE
 i2v2h7/pJCxUJXfYTtNCxtD8PoclTCYM3abEoqgEwlGFfl+ncK3jnN7sFC7m050zj7AJS5+fXWb
 cjTgK29M2GXCJs77VULcnLYntnjCDA==
X-Received: by 2002:a05:600c:5026:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-4533ca7790fmr137575245e9.14.1750172485124; 
 Tue, 17 Jun 2025 08:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXShLp4nzwV7kSci4ZucvrbBKmVFCbHTbN32Dbj5gmaLCy7gbWSmOpJkg9oyjWspCcHMS1TA==
X-Received: by 2002:a05:600c:5026:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-4533ca7790fmr137574365e9.14.1750172484469; 
 Tue, 17 Jun 2025 08:01:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b2f80asm14266211f8f.78.2025.06.17.08.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 08:01:23 -0700 (PDT)
Message-ID: <9ea6bc07-f2c6-4c05-909b-e7fad4c239fe@redhat.com>
Date: Tue, 17 Jun 2025 17:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/16] virtio: introduce support for GSO over UDP
 tunnel
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/21/25 1:33 PM, Paolo Abeni wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
> 
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, this series updates the virtio implementation to support
> such a feature.
> 
> One of the reasons for the RFC tag is that the kernel-side
> implementation has just been shared upstream and is not merged yet, but
> there are also other relevant reasons, see below.
> 
> Currently, the kernel virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically, the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 2-11) actually deals with
> the extended feature space.
> 
> I tried to minimize the otherwise very large code churn by limiting the
> extended features support to arches with native 128 integer support and
> introducing the extended features space support only in virtio/vhost
> core and in the relevant device driver.
> 
> The actual offload implementation is in patches 12-16 and boils down to
> propagating the new offload to the tun devices and the vhost backend.
> 
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support
> and vs snapshots creation and restore.
> 
> Notably this does not include (yet) any additional tests. Some guidance
> on such matter would be really appreciated, and any feedback about the
> features extension strategy would be more than welcome!

Some times has passed, and I haven't followed-up yet with a v2. The root
cause (beyond the usual ENOTIME ;) is that I'm focusing on the
kernel-side patches, which I almost co-posted with this RFC, and are
still under discussion.

Since the outcome of such discussion will influence also the userland,
I'll wait it to settle before sharing a new revision here.

It could take still some time, and the new revision will likely present
significant different from v1, especially WRT virtio feature space
expansion - as working on the kernel code showed a possibly better approach.

Thanks,

Paolo


