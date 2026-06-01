Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F23FCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8OH-0004uw-35; Mon, 01 Jun 2026 15:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU8OF-0004ul-Tk
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wU8OE-0000dh-BW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780342410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQ/nkeGHXKePFiqL6c/rkxb80y7AZxogJIDvN8EYoe0=;
 b=In1cs4sWwsG0t1nQGbu7ymOQ3dz6haLbEksXiJixNynLJNeRahj3+36JEV6yT0RGF7t2H4
 lHKIQ3Nzv4NejrT7wgAcWEFWf8gsO7oGxls+UR8HT5Gqeo7EIw2bPHRpShuPUvnBF8iUXX
 FN2+CfJL33IN1nZmHWVmTcb5NhDPcG4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-yKIR-IHdN8StwlPaNX4npg-1; Mon, 01 Jun 2026 15:33:29 -0400
X-MC-Unique: yKIR-IHdN8StwlPaNX4npg-1
X-Mimecast-MFC-AGG-ID: yKIR-IHdN8StwlPaNX4npg_1780342409
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccd51bc2f5so111939096d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780342409; x=1780947209; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GQ/nkeGHXKePFiqL6c/rkxb80y7AZxogJIDvN8EYoe0=;
 b=if1SwIt5abIm1GUVLZm80MLt/592bvI96vb968xaVyJwsTVdN19MA6KNTUCi/GcqL3
 ktNi7XX41WMLUGWha275iWgt+4xtLkS+slJ0XRNlYINQ9AKS+W86XXJ/qioAKcAAc5ce
 JP54X2UFItQDKCJpggpC3y9tXxYqB+y9BBYUkij7kX5RjXd4OcREykVvCYFUCfwc9p2E
 FeESNJs1Ybxb745vGmTFzOh5Tw7KBK2upKH/QwQNBK4+vjRSp+oTQUzYkCHvf3DeFqzP
 YlnM0IdARsspPNO0UqlKq50atjtZSctZjYv8fWCuV8qZnJ3R1SRwgS6ClaNCDu4qttiL
 M8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780342409; x=1780947209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQ/nkeGHXKePFiqL6c/rkxb80y7AZxogJIDvN8EYoe0=;
 b=mhplaAkmkylIVxNAef81UaOJ78g87eQSEERKjEv6A0E244zMY640JDwJ04mFpBAaAU
 5UDX7isMOvunIZihmhkbHLLrjl+xDgpx1py5fHp3LP02TnRlU755u85BwsgYP+ODNr5N
 Nel0X8HdiNwdPdbLW1L5SEIwZR4yD4+mJ1lG+HPGJ8qOUjOlTr+6hq8J2WdF3xM45KXw
 I/BthoBP02mER9ixmlEnu6TSRbCtoGn7lbCQwHoV6a13d1XQW6EEICmhyxvPc1D1j8S6
 82VTZ2wwa7bqKopHJ/kEQU/0Y5oQoJ/0glPFK5i4R+l8tV32AeiWGCX81Me0bSIQDkoN
 vWKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F5AYZNVEi4k4fBhiTYTuP+SNQMrBguxtkFnoEUcA/YkbLQos1tmTB9zqJlMhVkPgI9Iwb2iIdBhnh@nongnu.org
X-Gm-Message-State: AOJu0YxqhXsTChlxoBqhoqKDHIIrMtEwJ9/7nyn0JUZL3JE68fl6HDba
 dxLb5iu5EIU170VHWrZlfkrAqET8EFAP2PpYvD+Vc9OUvhdt8RQyFnVmFo3MOdkn5JYde7+na/y
 74SdMwbjwSxDNBWXm56R4wSbiHMvl6LT0q+vTU441DaLN6XRxFOPzRAOd
X-Gm-Gg: Acq92OHdjQKiRx9TL59UV+GKCzKNaVHgloL293rq8oLLIug8aji6+ndsC03//b5mRo3
 E4Fo7tWjYm94sM3EoyFA7RjivjdAyvG6T2OYVAbk7ziRwTB/IOonx2BgCe/WKRCTz2filW1DLIM
 ieORQIyuHEHwEDh05QaC9QDTuqvtr74kTpslNzXaIUN7LDnO2v5BGNflcbDBEnQY8A208169/qD
 H6sevlm8JGn6RBQ+W/z1u4CTlfHfyWMZhHYI7SgC+45KsW5/PFpx0ahqNi6udWyyd/qZWJNnKWG
 Pf3w7lKwjNJDFmF52vfc69K/fhgEjFH8MkOXbhsGzQRewiauSOQFyCddJt6bJLSKWtSAtLmhXRM
 +mQZGdD2UpzaFqbMC5sLC4XbLFg==
X-Received: by 2002:a05:6214:c6b:b0:89c:806c:93 with SMTP id
 6a1803df08f44-8ccefd8d38cmr215343846d6.30.1780342408652; 
 Mon, 01 Jun 2026 12:33:28 -0700 (PDT)
X-Received: by 2002:a05:6214:c6b:b0:89c:806c:93 with SMTP id
 6a1803df08f44-8ccefd8d38cmr215343036d6.30.1780342408090; 
 Mon, 01 Jun 2026 12:33:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea202609sm100906816d6.36.2026.06.01.12.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 12:33:27 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:33:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <ah3eheRXN1QJAGj_@x1.local>
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
 <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
 <871peqtm5t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871peqtm5t.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 01, 2026 at 10:39:26AM -0300, Fabiano Rosas wrote:
> A bit idiosyncratic, but I don't have any better suggestions.

One thing I don't think proper with the current approach: if it's a real
"priority" it should be invoked always with high->low order, no matter if
running=true or not..  but that's not what will happen if we encode it with
the "depth" field.

That is an implication that we have two demands, and they aren't the same,
but this solution wrongly packed them together.

In 2023, VFIO already introduced VMChangeStateEntry.prepare_cb().  That is
a real impl of prority queues with only two: prepare_cb() always has higher
priority than the cb() itself.

Can VFIO simply leverage this existing interface, instead of hijacking
"depth" in an unwanted way?

I believe the _P2P states still need to happen first for all vfio devices,
then it can do the next step. Logically I think it can also be done
internally within VFIO by proper impl of these two callbacks, to achieve
both:

- Proper transition to P2P states first for all devices, meanwhile,
- Proper concurrency of all VFIO devices on device state transitions

Would that work in a cleaner way?

Thanks,

-- 
Peter Xu


