Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC028C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 21:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMnc-0000lN-Dk; Tue, 23 Jul 2024 17:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWMna-0000e2-J0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 17:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sWMnY-0001Nw-1a
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 17:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721769107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=spUAIA8kBSvWTegskpjZi51/E49uYpMwSrHWmRPJ6L4=;
 b=IINnZ4fuWc/6oV49Slvjw5g6wLRjIUI//DaZT47zn1HIcw9PmpzLVgKo2PBTuzsYr8l9yk
 kljoY0L/if2wgTDzwxdER2I9w2z8fQ4WEP1dER0MtDUuxoctG40RIhqCQhkSbHPhFddV1L
 Z+TJxgGM6TpRJj+qtx/yf9MaBgIMGdw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-AUOvae8lP9S0ZEi0UCFsXA-1; Tue, 23 Jul 2024 17:11:46 -0400
X-MC-Unique: AUOvae8lP9S0ZEi0UCFsXA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3d8ae3b69daso1308306b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 14:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721769105; x=1722373905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spUAIA8kBSvWTegskpjZi51/E49uYpMwSrHWmRPJ6L4=;
 b=w7DmOT0Ai4bauPiPTVnJ/8CnIrs8rxUXmXBYY5haVcqSm6GBWB73YF5swsNyhfZP/H
 riISVT8maR2BgkG99aCNmunfoT7ZXSi9L50m5ZiPdFI5WLMxwAOYmouo7kWiPbCLnMDG
 A+Km9fpSjJWccmAevPcaz+StnG5QgBXRyS9xMsh5+LImnfc4QnJYAj/iWHX9zAm8fPcp
 hXmCYR+fDfB/2gvubba+dTBzJHRbOz5VbTIxA/v2rLEyUfzu/wskhc0VELMgGEZjzWny
 9rnCyl9FRtccOaJsWL/ZJgAsCDl1rDKVTxn/6U2xu5RoxWiXMgtQRoL88pY0iV28wkJz
 BMZw==
X-Gm-Message-State: AOJu0YxssDLD13UcjUHFE9EdtOPXUH9RXJF70PAzlTUVRWrF0bn0AeDW
 kGMqwowixsyaDRT6oZJTOd+nybCih+DpHuBtYFDoxudYyF9/wYulTqyDNHm8M1Oc5DAygn1K3rP
 pOeaxDWzUGR/x5fLDUjhbH+yI2iMY1dNF3XTPKk7otFRsmACajpMQKCiXBFaa
X-Received: by 2002:a05:6870:f14f:b0:25f:401a:2ec3 with SMTP id
 586e51a60fabf-26121083befmr6800083fac.0.1721769105419; 
 Tue, 23 Jul 2024 14:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW2y+Cfjg1ZMjMdtPwku0dwsDxE6MSzfSOOZJFFhvTioZk7yoBdgl4jI68kRHqUY97dGeOLg==
X-Received: by 2002:a05:6870:f14f:b0:25f:401a:2ec3 with SMTP id
 586e51a60fabf-26121083befmr6800075fac.0.1721769105016; 
 Tue, 23 Jul 2024 14:11:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19909461bsm514694485a.129.2024.07.23.14.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 14:11:44 -0700 (PDT)
Date: Tue, 23 Jul 2024 17:11:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 0/9] migration/multifd: Remove
 multifd_send_state->pages
Message-ID: <ZqAcjYU-86NNbZZX@x1n>
References: <20240722175914.24022-1-farosas@suse.de> <Zp65zvb9oy9my-qY@x1n>
 <87msm9yy77.fsf@suse.de> <Zp7HH6-WeYKXQ-fy@x1n>
 <87a5i9yvhf.fsf@suse.de> <Zp7k4wF1W6Fzp7YW@x1n>
 <8734o0yp6n.fsf@suse.de> <Zp_0fFCJ3Ca2MvuV@x1n>
 <87zfq7ygrz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfq7ygrz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 23, 2024 at 05:50:24PM -0300, Fabiano Rosas wrote:
> The natural thing would be to put the hooks inside the data
> type. Something like this:
> 
> struct MultiFDRecvData {
>     MultiFDMethods *ops;  <---
>     void *opaque;
>     size_t size;
>     /* for preadv */
>     off_t file_offset;
> };
> 
> struct MultiFDSendData {
>     MultiFDPayloadType type;
>     MultiFDMethods *ops;   <---
>     union {
>         MultiFDPages_t ram;
>     } u;
> };
> 
> multifd_ram_save_setup()
> {
>     multifd_ram_send = multifd_send_data_alloc();
>     multifd_register_ops(multifd_ram_send, &multifd_ram_ops);
> }
> 
> void multifd_register_ops(MultiFDSendData *data, MultiFDMethods *ops)
> {
>     if (data->type == RAM) {
>         method = migrate_multifd_compression();
>         assert(0 < method && method < MULTIFD_COMPRESSION__MAX);
>         ops = multifd_ops[method];
>     }
> 
>     data->ops = ops;
> }
> 
> I'm just not sure whether we have some compiler cleverness optimizing
> these function pointer accesses due to multifd_send_state being static
> and multifd_send_state->ops being unchanged throughout the
> migration. But AFAICS, the proposal above is almost the same thing as we
> already have.

Right, this looks as pretty when you can put the ops inside, and iff the
perf goes as well. E.g., you'll need to register the Ops for each batch
too, besides the pointer jumps.  You'll also need to check the hooks one by
one, even if we know most of them will be noop at least for VFIO.

IMHO it's a matter of whether the Ops is useful to VFIO / other devices
first in the forseeable future.  My current gut feeling is they're mostly
not usable.. while supporting device state with an opaque buffer to send /
recv, plus a pretty static device state protocol seems relatively easy to
do.

-- 
Peter Xu


