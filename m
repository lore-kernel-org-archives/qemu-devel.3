Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEC5D3F069
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 14:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl6EK-0006wk-V1; Wed, 28 Jan 2026 09:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl6EJ-0006tz-A0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vl6EH-0000RL-A2
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 09:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769609346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53qmsgHHhhtIZYmTeNk3CEN0Qa6qi3oEsven3Efny7M=;
 b=Hr5AS6pinxIK9YzWvwb7ujFJxXP0uVgdkRrKVtp8rPz8qH6NKWoawNlOx+5f38YqpfLAac
 9S9JxTQImI9zQaHE/SBqRP/Zw+7GJfTBI/btlwHRwEaJlu1oGjMjhuRV1zAqJFfueZxBXe
 fl4wRDvYKPlOnv4Ypz3C1YzySbDcpUQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-rb_IIGn_NUCVbMaPNbcfKQ-1; Wed, 28 Jan 2026 09:09:05 -0500
X-MC-Unique: rb_IIGn_NUCVbMaPNbcfKQ-1
X-Mimecast-MFC-AGG-ID: rb_IIGn_NUCVbMaPNbcfKQ_1769609344
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c277fe676eso1940715685a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 06:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769609344; x=1770214144; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=53qmsgHHhhtIZYmTeNk3CEN0Qa6qi3oEsven3Efny7M=;
 b=omb2GY7euUNG2R8e0w2YZeiNZYVm94nUTCq69TzLcrzfmJ4GciFxX+QuRBcF9i4TMn
 LOeDRnOmlCGr3VIDO7Lr3Vi0RZy9QYBCR4yMeIbv9t1yyTgQQJ6iH+l4c1AEUSgAFsEG
 xkRz5/aTKscrlkDyUmuq8Yj3UQRwWGm6AWc7USD7lUoN831jgBkH7b2zw1wwQD4Z//VH
 OWhaQP+rYbZGs9oPHaPPYqG/xs5VqfM0tQXK3iOfk5J1NpXw445poSuouniW8GmMr5qe
 mH98ZzEquXXlsL7SwPOz3D9V6Ug+nH+semKp5/oCguUOxxBEzNF/c0iZTNmL5uZbrPRA
 O13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769609344; x=1770214144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53qmsgHHhhtIZYmTeNk3CEN0Qa6qi3oEsven3Efny7M=;
 b=AScL5JhX7rljOoVDX/uhn6BOj2uMdYR9rwAMhcQvpN2kMpTrAnCUdj7ZvwS6pM29QF
 torQW8dVxpSlh2GK49z+r65/NtiQFAymzPuuJrTF2af9y1eYHT3Rpi6CBJrPjEVCp0I8
 PdM6+Qm8qhX7PP31LhysAKbfCTlitk63+gkU9/19xtfwyb4Ew4Pz9727EzYVUC4WNO6I
 9z9QMxAQHZTuG3E8hFJeXbI/Cn5HsSjIo66lm6VYLAGwM1AiX9RubMKx8WQXW9SfhALy
 2X4m70Tx69sXmWNflYnms7StaMHZ+4ArScTWqsxlFPmb4ICUHqEaZwoAEk1NHRi3eS3z
 j9iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvQ+HPfBw68+Aywoc0OCLf9bt/dWrdgQYLWNPJc/YkB59fI5kV2SPCnX1UqhF4sqTz6aZJR9SfUXeL@nongnu.org
X-Gm-Message-State: AOJu0Yy9SvDNDIEcEt7+If9PBguptROKn6nC/yg3DSZrEdob7gMiq0I5
 37tdFHPPfGQ7HQ/qSlNYTmubJcYUn3Wv6EW6heVLlD/0LsGmIDyGrB40hvhPa33c06/gZnxM3Do
 L6U5G4QkU1Zx5OitEJsRH7fySkmhJOiuzqrVtHoz9Y/R8u7llPI8zxAuq
X-Gm-Gg: AZuq6aKzb9e3SB45dikvAHlBow6MSC3CzgcGVmQPsFuFdbTLTl/pICicNX1NGRylFVW
 MQIRZUbALwcaIxEMDA+Fr4sHohxbxA0cRRTqNSsPQ3dJFM8SFs0bczeh6EHrm/VvP3cor15w4na
 loSk01sfQL8CSu7Gz1541gYwasfXiHFYkViA6d+HCJz1M3PjveivfMaevwJIrU1423OSLiDTTCK
 0LW4r3m3XVk++2/fmbGEOwMEScGp4+pdPUgTd0fV0UUsya9xiDnGmiuvtbP7QX0dzV5vvhFLfG7
 hcoxvVt43flmrdFKeLG6Pa4qgn8Rl5APvqmcZ0yUqQA28FQr9jsuWJZB2QZahA6W65g2qCDJ6pq
 RyW8=
X-Received: by 2002:a05:620a:4b48:b0:8c7:fdc:e86c with SMTP id
 af79cd13be357-8c70fdce9a8mr364366785a.11.1769609344416; 
 Wed, 28 Jan 2026 06:09:04 -0800 (PST)
X-Received: by 2002:a05:620a:4b48:b0:8c7:fdc:e86c with SMTP id
 af79cd13be357-8c70fdce9a8mr364362985a.11.1769609343808; 
 Wed, 28 Jan 2026 06:09:03 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b95acbsm186136585a.12.2026.01.28.06.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:09:03 -0800 (PST)
Date: Wed, 28 Jan 2026 09:09:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Juan Quintela <quintela@trasno.org>
Subject: Re: [PATCH v3 04/10] multifd: Add COLO support
Message-ID: <aXoYfad-i-au-xpM@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-4-ae926ccd8eae@web.de>
 <87ms20h2ae.fsf@suse.de> <20260126203358.0f8dc224@penguin>
 <878qdkgin8.fsf@suse.de> <aXkh0Sy9WUqi_3Rr@x1.local>
 <87v7glgbrz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7glgbrz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 28, 2026 at 09:30:24AM -0300, Fabiano Rosas wrote:
> >> >> > @@ -294,6 +294,14 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
> >> >> >          p->zero[i] = offset;
> >> >> >      }
> >> >> >  
> >> >> > +    if (migrate_colo()) {
> >> >> > +        multifd_colo_prepare_recv(p);
> >> >> > +        assert(p->block->colo_cache);
> >> >> > +        p->host = p->block->colo_cache;  
> >> >> 
> >> >> Can't you just use p->block->colo_cache later? I don't see why p->host
> >> >> needs to be set beforehand even in the non-colo case.
> >> >
> >> > We should not touch the guest ram directly while in colo state, since
> >> > the incoming guest is running and we either want to receive and apply a
> >> > whole checkpoint with all ram into colo cache and all device state,
> >> > or if anything goes wrong during checkpointing, keep the currently
> >> > running guest on the incoming side in pristine state.
> >> >
> >> 
> >> I was asking about setting p->host at this specific point. I don't think
> >> any of this fits the unfill function. However, I see those were
> >> suggested by Peter so let's not go back and forth.
> >
> > Actually I don't know why p->host existed before this work; IIUC we could
> > have always used p->block->host.  Maybe when Juan was developing this Juan
> > kept COLO in mind; or maybe Juan wanted to avoid frequent p->block pointer
> > reference.
> >
> 
> Maybe p->block was being reset at some point and p->host was passed
> being the point where the (whatever) lock was release. I checked and
> today there's no such thing. The p->mutex seems to be there just to
> protect against this in multifd_recv_sync_main:
> 
> WITH_QEMU_LOCK_GUARD(&p->mutex) {
>     if (multifd_recv_state->packet_num < p->packet_num) {
>         multifd_recv_state->packet_num = p->packet_num;
>     }
> }

It should be protected by various checks over migration_is_running().

E.g., QMP device-add & device-del are forbidden so no new pc-dimm hotplug /
removal allowed.  Similarly, virtio_mem_is_busy() would return true during
migration too.

We should definitely make sure ramblock will not be reset during the whole
lifecycle of migration; I believe we're not ready for that..

-- 
Peter Xu


