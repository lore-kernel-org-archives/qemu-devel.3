Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB3BD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz0ZA-0006gB-0v; Thu, 10 Oct 2024 17:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sz0Z8-0006fg-6f
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sz0Z6-0001dS-Dg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728595159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r1+0bjN+c+gJXWQroT58CE5h+/mbW7yQEAOY691BDyg=;
 b=fWH+imsnWtl5uNImDN7JZTfl1204/JBl57lA5ordn6b5mQ9LzbhonpJM8ia3Qy7Zfh5FuU
 AhSzr0UX/Cyo5aOrsy5p19zqZSSEz2aAeUHsP/2tr7lwo2Mz1pssi0WIoNWrf5QGq6Ftl9
 MQJuR+rDJP7WkDdepYz0RYUJM3CDeAI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-26_k76rMNtSPLJWqww5vpg-1; Thu, 10 Oct 2024 17:19:18 -0400
X-MC-Unique: 26_k76rMNtSPLJWqww5vpg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a9951711adeso105466166b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728595157; x=1729199957;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1+0bjN+c+gJXWQroT58CE5h+/mbW7yQEAOY691BDyg=;
 b=pzBrUdxibjVLBT+uUt4LSsqtfzX0v2PEtDXR3XWtNpnshIWGUS8mj44+BhDKUsYAHe
 WX6cTSV23KfkB5uCjJczN6RLUUK3Iw36i0ddqi3ksaF8U1W+XcuT1XYtbCLyVchteTS6
 UsAL6+RLqztDOs64XbHWtqQbLvVVy3Vt6ICspuvwa/quhowSM75aKjWYrAgyP7jNRQjm
 /kATomRfEchvoGSED+ahuYULWvBfEhfJ/1Zy7oUic/KrEVlndESQcR0dZodMOjxxoTxG
 zz8jeRGXzDAHUFsX8dajJ3b5qDs95G0LtwgpecPq+mC+7J43MsobWGgdP454O8aGd7JF
 42TQ==
X-Gm-Message-State: AOJu0YypIaMU7gC4kNBLwgsKjiwhjXuXDtunAlTBUwlCxCX1BcNnVGZ6
 G3NQqUAE9FLId1o82r7nFscfgrTu7fLuY8gvl/EPIi5vKhZUyJLi9ZI+yK5jkyfVRvvp3dELlMI
 UzNAZjAuBYFOiCynAFPV6rR/qfjCWSB81ehOQV9dpG7LqSpRV8Bj9
X-Received: by 2002:a17:906:d7ea:b0:a86:789b:71fe with SMTP id
 a640c23a62f3a-a99b96ad091mr24916966b.48.1728595157080; 
 Thu, 10 Oct 2024 14:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcL4O2zDcyrSOpKTwgJMBscw4UN+nrORraM8pxAnDA+EnrsOyuEJrkSOKBr734mtxztpMc+Q==
X-Received: by 2002:a17:906:d7ea:b0:a86:789b:71fe with SMTP id
 a640c23a62f3a-a99b96ad091mr24915966b.48.1728595156646; 
 Thu, 10 Oct 2024 14:19:16 -0700 (PDT)
Received: from [192.168.10.3] ([151.81.124.37])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a99a80ef972sm136485166b.193.2024.10.10.14.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 14:19:16 -0700 (PDT)
Message-ID: <670f63b6-529d-42ca-9a9f-acc6f3f07c18@redhat.com>
Date: Thu, 10 Oct 2024 23:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: precreate phase
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
References: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/10/24 22:07, Steven Sistare wrote:
> Peter, Fabiano,
> 
> I have a nice solution that allows dest qemu configuration with cpr- 
> transfer.
> I define a new qemu initialization phase called 'precreate' which occurs
> before most backends or devices have been created.  The only exception
> is monitor devices and the qtest device and their chardevs, which are 
> created.
> I untangled dependencies so that that migration_object_init can be called
> before this phase.  The monitor accepts commands during this phase and can
> receive migration configuration commands.  qemu starts listening on the
> normal migration URI during this phase (which can come from either the
> qemu command line or from a migrate_incoming command) so the user can
> issue query-migrate to get the socket-address for dynamically allocated
> port numbers.

Can you provide an example of the commands?

Moving migration_object_init() earlier sounds like a good idea anyway!

Paolo

> qemu enters the phase if qemu is started with the -precreate option.
> The phase ends when the user sends a precreate-exit command.
> Qemu then calls cpr_load_state and reads from the normal migration 
> connection
> as in the existing design, including the HUP.
> 
> (This sounds like the preconfig phase, but that occurs too late, after
> backends have been created.)
> 
> I implemented this scheme for another reason but abandoned it, so I need
> a few days to rebase it and test.  It is not small, and requires approvals
> from additional maintainers.  Let me know if you think this is the right
> solution, and I will revive it.
> 
> Preview:
> 
>    0725d70 vl: precreate phase
>    edd2dee net: cleanup for precreate phase
>    4733c00 accel: encapsulate search state
>    6d26ea4 accel: accel preinit function
>    518e737 accel: split configure_accelerators
>    8ef936b accel: delete accelerator and machine props
>    b5c2a84 accel: set accelerator and machine props earlier
>    56890a0 migration: init early
>    76506b2 monitor: chardev name
>    e85111d qom: get properties
>    8356f7e qemu-option: filtered foreach
>    fb6cc98 qemu-options: pass object to filter
>    bdfec1b monitor: connect in precreate
>    8f2f292 qtest: connect in precreate
>    629cb50 migration: connect URI early
>    0ae530e migration: allow commands during precreate and preconfig
> 
>   accel/accel-system.c            |   2 -
>   accel/kvm/kvm-all.c             |  58 +++++---
>   accel/xen/xen-all.c             |  11 +-
>   hmp-commands.hx                 |  20 +++
>   include/migration/misc.h        |   2 +
>   include/monitor/hmp.h           |   1 +
>   include/monitor/monitor.h       |   1 +
>   include/qapi/visitor.h          |   1 +
>   include/qemu/accel.h            |   1 +
>   include/qemu/option.h           |   5 +
>   include/qom/object_interfaces.h |   2 +
>   include/sysemu/sysemu.h         |   3 +
>   migration/migration.c           |  31 +++++
>   monitor/hmp-cmds.c              |   8 ++
>   monitor/monitor.c               |  21 +++
>   net/net.c                       |   4 +-
>   qapi/migration.json             |  16 ++-
>   qapi/misc.json                  |  23 +++-
>   qemu-options.hx                 |  13 ++
>   qom/object_interfaces.c         |  27 ++--
>   system/vl.c                     | 291 ++++++++++++++++++++++++++++++ 
> +---------
>   target/i386/nvmm/nvmm-all.c     |  10 +-
>   target/i386/whpx/whpx-all.c     |  14 +-
>   util/qemu-option.c              |  25 ++++
>   24 files changed, 471 insertions(+), 119 deletions(-)
> 
> 
> 
> 


