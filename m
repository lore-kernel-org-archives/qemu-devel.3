Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AC606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hb32G07f;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sg9G/and
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWErS-0006ax-RW; Wed, 25 Nov 2026 10:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xWErK-0006aV-G3
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xWErH-0006mq-BI
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795620269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VFhGHXs3HK61H3sSaR4Y0GrnbaGZzaMTg8a+/kDYAM=;
 b=Hb32G07fKLUq0cmkQVuQ8yJRaNpcrAuxfCy+I6JoDMDdsi6UEzFEkYDLOzcrRnLq9qtXg+
 DQUArWKq143M8aCauJlVXq4iXG1yeRQR2yBaFF1JIkUtpOXNTun1hE2bvAsh0saONgR82f
 TPrnQP1JzAZ5SmTl3BReFYWzLVYgD3A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-br-PsElSOSeVDWx7juwBsA-1; Wed, 25 Nov 2026 15:24:26 +0000
X-MC-Unique: br-PsElSOSeVDWx7juwBsA-1
X-Mimecast-MFC-AGG-ID: br-PsElSOSeVDWx7juwBsA_1795620266
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-490d2ac331bso5207807f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795620265; x=1796225065; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/VFhGHXs3HK61H3sSaR4Y0GrnbaGZzaMTg8a+/kDYAM=;
 b=Sg9G/and+Jf4oDNmeoYAgJQy61D2yOWHw4NPgZ47rFHBMxjhiB6TGeQINtzK6OwLNk
 qDo5Nj4u1CMqAiz9aokIiHuF0+QsuPGSTpRgk6ZkwG9fLdzmRhJscnkXvo3TCyZxcQ2V
 7O0g6P+yql79zU0Bi0AnHlZFS6JzmlcA5QZZVKAn0nUbK/0KbHRng3b5xY4P0agS3tiO
 OQWWL7imb8L0MU3XfJHYmFYD073A2KE8nfaZv09s2GlTSW1UnosXJbvLSugLDTYgduG2
 V1oE4gvZh1cKx0umgxlw86EGX6JSSTOA93rhPmPn+7WJjwU5L4lMMDm2NBLglOWrNf2q
 a8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795620265; x=1796225065;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/VFhGHXs3HK61H3sSaR4Y0GrnbaGZzaMTg8a+/kDYAM=;
 b=dSZ4rWQUeKH+OzpPD9J+i73mRyyWkUK6QsSxbfneMFeVdqBwffPJTWsRZMwxXmjKUl
 6dMgCVfnlKxVeQmqhqGaMGZCmZQ5Qqc7ACGElinJ6nSjX8hONoJYop05qHYV1mO/9WtO
 bCGyOgRvv7dNIJZftDGBuJAO3i/mJp286lMhRNqNYEF0ID9Vk8Ai//GN7MidQ13j5o0K
 1UmU/uPmYqmzAJGDpAd9g+BjH9N54rbT46jh+/6E47CeiCkH8632QJBiyysxONXLQQ97
 zsgNwkug2RabZEFErnC7TY8CwjlIxmWYIP3u1sJLR0e++ayC4UFORmfzxEYvPJnVNwxS
 lvJA==
X-Forwarded-Encrypted: i=1;
 AL+hErFS5fMN/+aFDupkcKwMWWDwfpW86Eun4KfPL69ZWflegbBnYD0iwmXewW/SY8nUqtyU6nXMV8oDcmio@nongnu.org
X-Gm-Message-State: APuU4Z+Bm8URSuEimweBdpq6FzdPZtBJz9pf3wQ0NXl5mvqxulJBlbCl
 q9nFtxKuO/whkCb+cO1rLiPtfU2iL1PrQg6/gS1dyRM3jkx3zntvXs1gazeneDhDvuGHHJly0Cj
 KgxvCyJq+PaC0ITg2tj4w0+9s8QoDZLvPDV7EoB2TSI5ByX4yA2Yz5gSn
X-Gm-Gg: AZFdTZd422LrkK5+Zphc5APYxS2UIJQSlOVVqCG+a+mDqYCijWWMcTlI6qc1gIQwYWs
 3VDw9f2qqGiJkZZTt9euJVoRuW0dhkqJ35WUlZknD18KFqwWSVUuUKvHyJBhmUy19QL5R+MiOWW
 HMzk1rodcK0iOKwqBt3uFmYxQSietO0etuoRLmzDYmiFykX4htF4S7y0jSK1baLh+WuCHuEfN8k
 SzPHy1EHuyNuOowb1zgUxaIU9v/xXZ37oXEYwjsjIkY78z4dcteLuagX3dVLek7bnJY4xzAKDei
 BC9CaFBtuj+FFoL82niZXtWW20ZjL/x6W26i+5f6kDmZwvUFu40/owqRZzrbR/gU7pd/8/VWpVZ
 2CbnGuHT4+NgtQ0SA4+Q4ax/S5QFIjEkBB8cC3yrxYkDodlPa6NJ4Nw==
X-Received: by 2002:a05:6000:2506:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-4abb47b0f64mr43710640f8f.37.1795620265612; 
 Wed, 25 Nov 2026 07:24:25 -0800 (PST)
X-Received: by 2002:a05:6000:2506:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-4abb47b0f64mr43710577f8f.37.1795620265031; 
 Wed, 25 Nov 2026 07:24:25 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm32767245f8f.34.2026.11.25.07.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 07:24:23 -0800 (PST)
Date: Wed, 25 Nov 2026 16:24:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, 
 Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
Message-ID: <awb8b6woM0vqRpow@sgarzare-redhat>
References: <20261123231319.377104-1-connorkite@gmail.com>
 <e271405f-b7fe-48fa-bca2-964945c38994@oss.qualcomm.com>
 <awakcwEP6eYCeb-A@sgarzare-redhat>
 <CAJaqyWcUpP2c-B70OLeWyBpkZjVPsN3Vm5iyAUVeZG=DaR6+Hw@mail.gmail.com>
 <54c83094-e441-49ba-ba89-d4ef7bc40e78@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54c83094-e441-49ba-ba89-d4ef7bc40e78@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 10:42:32AM +0100, Philippe Mathieu-Daudé wrote:
> On 25/11/26 10:16, Eugenio Perez Martin wrote:
> > On Wed, Nov 25, 2026 at 10:05 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > On Tue, Nov 24, 2026 at 08:41:04AM +0100, Philippe Mathieu-Daudé wrote:
> > > > Hi Connor,
> > > > 
> > > > On 24/11/26 00:13, Connor Kite wrote:
> > > > > When a shadow virtqueue detaches the buffer associated with a used element,
> > > > > it adds the descriptor chain to the head of the free-elements list. However,
> > > > > this currently happens after svq->desc_state[last_used].ndescs is set to 0
> > > > > in vhost_svq_get_buf, introducing a bug.  Only the first element in the used
> > > > > descriptor chain is added back into the free-elements list, with subsequent
> > > > > elements being potentially orphaned.
> > > > 
> > > > Not really added to the 'head of the free-elements list', but the former
> > > > chain tail to free_head, then makes id the new head. Suggested reword:
> > > > 
> > > >    vhost_svq_detach_buf() uses the head descriptor's ndescs to find the
> > > >    last descriptor of the chain and reinsert the whole chain into the
> > > >    free list. vhost_svq_get_buf() currently clears ndescs before calling
> > > >    it, so multi-descriptor buffers are recycled as single descriptors and
> > > >    the remaining descriptors are orphaned.
> 
> What about that suggestion?

Yes, I agree that your suggestion is better.

@Connor, please can you send a v2 updating the commit message, adding 
the fixes tag and CCing stable?

Thanks,
Stefano


