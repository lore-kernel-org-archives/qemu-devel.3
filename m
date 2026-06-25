Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EEECDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wck3R-0005sY-Vd; Thu, 25 Jun 2026 09:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wck3M-0005s2-JF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wck3K-0003Si-EA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782393813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wMY9lMDBnjSffkY0dB2lI6teviTlM5DqXq9Zm4u/Fio=;
 b=XYLHLWAz2C4XNimNXNHu3eSIhFR+Agg3+jGV16rbTKcB5akCOsLeD7weR+NDKRhzDFVZQJ
 Q6JpE/45XLq0sD0bHscuXGVY2YmqGti+fnj/P6cnFrXX4CgeugPfcZgUvdc55HwxAvMJdB
 zdB2g2aI7r+Ejim/D4gTXWw3DDPiAP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-MYApQFWGN624tIqQ8s4qyA-1; Thu, 25 Jun 2026 09:23:32 -0400
X-MC-Unique: MYApQFWGN624tIqQ8s4qyA-1
X-Mimecast-MFC-AGG-ID: MYApQFWGN624tIqQ8s4qyA_1782393811
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4639f122c38so1941292f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782393811; x=1782998611; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wMY9lMDBnjSffkY0dB2lI6teviTlM5DqXq9Zm4u/Fio=;
 b=bg+sENqXQ7sB/ZGkciKVbimyoImUIZFgdz1NblMC/GYzIPSjXQ7VT8n3+pa1W7vkvK
 hdxGB9dbgwQuox3ZrJEJuSR84VL/9Ur19ZFoK99WN8bfyk+myR6/LIZ5wtODXgXysYgS
 WsjMqIEKrzRw9GgiECrxLcEAUb3QTroMKosnwehBBo9Jl3EPngS4SB6+S7JZ+V9qrhEH
 RB2KSP3gZOawFNcANMBiGPsQZ2/ghBpDUIMA8KfK2nbKYaV7g0KCniCtI5oFJP2MO7mI
 QSUGq6RCIW1gO3MTLFdgV+DOli8w8YGLGotSj5yhmJKx8cxXEMwORp7fLvfzw6jxX9WX
 7kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393811; x=1782998611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMY9lMDBnjSffkY0dB2lI6teviTlM5DqXq9Zm4u/Fio=;
 b=YtQZM7JIpswMh4c+vp5RSQ2ly6bg3ToBM7e87NDgT0w6wDipuSwMMwDsIgJYplE74c
 qdMvqcG2LErK5InEHEjRI7DbN8H4lS4QGRkU8o5Nea8guPRM5DUMHwVgmoJrDT1SNiWI
 cQvN1CAK8tmdeH+RTONRpeyQ9CDSeFq6r2vVSKJPi2qy5jXxo4oBiIzv+B89nfkBmVBQ
 znZdQTtme83mLxUUG9wWZFHTf45t76sl5TwVsc7SQDFA2KlmImv1t86PtTH5uaXBPR7V
 L5nvwjzPUIDdUaeRKcMuaMotprNjbVfhwOImb7w5ZSz2tazESADoYME9luvP6HP5RO6W
 sDSg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rol3Oc5V1hUSvM108VJwch1bBSH+cs+6YDG/Fy3cu3yCZvsGEhsHrEWAgnFEk6n7d4gjSULSull6ZjO@nongnu.org
X-Gm-Message-State: AOJu0YxtLF88qDUSC/MqHufZFBtIo0ewzGhYYacduP1Kb2LcxU0afmMt
 XM2CWzUD3qVqtmfaj2kMfzMfjmQl0mOlWtjFQeOeKVqzSsCuwFO+M5umIFUzWVGy2GmfgNqzCzM
 UO7OK7vuuCyCPcPTPM4+ORM1qR9uu9eQcUPtYk4Pe0ecQV4Ha1Sg8KChk
X-Gm-Gg: AfdE7cmmpgROCVMHiX/jOpJCbjRyVOrSLzbw4fYZvXFuPEXIgH93XmQxWeM1LPTgaaB
 otO7kw+MubSPo5X15jpyxeSKn7xMjUyBmQOpCfU90M6gPWg+zGSyGjVdV+jf7UgAqqBFbrA+oNO
 rsgaCtbZiBgSLJovrE1FaXtFP37AdkuMjaEnryVrVpuwMxmc08cvJ/H7beMwhDT6uZ1xY7gckTg
 eMevBex3Lz28daCPvi5IXVxhRGUY8UyXtR9p8wOEuGCuMgmUUjHmcR7BfnyCd6B2joz8XZe+tln
 6MSIyN6UpcsyE7ActvxK0TFXfLSww3PKrRYPR/EIE3fmEOTa5WCcrJo5UWCoazCbqP3a5Us0Om0
 pYZpVOdrPD4b2vJCSJWNXOBOKFwgbwjMr
X-Received: by 2002:a5d:5f56:0:b0:460:3a90:b2b6 with SMTP id
 ffacd0b85a97d-46dbf1199e5mr4556870f8f.11.1782393811105; 
 Thu, 25 Jun 2026 06:23:31 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:460:3a90:b2b6 with SMTP id
 ffacd0b85a97d-46dbf1199e5mr4556811f8f.11.1782393810507; 
 Thu, 25 Jun 2026 06:23:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c68239sm18940073f8f.36.2026.06.25.06.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:23:29 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:23:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260625091334-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 25, 2026 at 01:48:11PM +0100, Peter Maydell wrote:
> On Thu, 25 Jun 2026 at 12:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 11:09:26AM +0100, Peter Maydell wrote:
> > > This is still wrong. We should not have "x86 magically works
> > > and all other hosts do something different" ifdefs. Define what
> > > semantics you need and then we can figure out how to
> > > implement them.
> > >
> > > My current thought is that we need to handle accesses of
> > > 1, 2, 4 and 8 bytes that are naturally aligned by ensuring that we
> > > do exactly one host load/store of that type, and that anything else
> > > is "the guest isn't relying on specific semantics here, we can just
> > > assume it's plain old RAM and do whatever". That would not
> > > require any architecture specific ifdefs.
> 
> > Well. X86 is special, as usual. It allows unaligned mmio so
> > we really have no way to know an x86 guest does not intend
> > just that. That can only be emulated perfectly on x86
> > which is sad but I see no reason to actively break it.
> 
> What actual hardware will rely on unaligned accesses
> appearing to it as single unaligned accesses?

/me shrugs
any hardware that was only tested under windows?

> And if we do need this, we need to specify:
> - what are the semantics we need to provide?

match what happens on bare metal

> - what is the use case that relies on these?
> Then we can see how closely we can match that.

passhtrough of weird devices, first of all.

> 
> There's a lot of extra complexity added in here for
> something it I don't think is ever going to matter,
> and having the most common host architecture take a
> totally different codepath from everything else is
> a recipe for that other codepath breaking.
> 
> -- PMM

Not sure we have to be pedantic. We have arch specific code and the
world did not end.  It's not a lot of code, it's just for unaligned
accesses on MMIO, which might or might not be broken anyway.
And it worked already, so it's more about going back to what we
did earlier.

-- 
MST


