Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A4EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTBB-0003ZN-1a; Thu, 18 Jul 2024 11:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUTB8-0003Xa-RE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUTB6-00040r-TZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721316979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW/5YO1QNQUThUYfY6HZH2uk9BFMYXc7F6+cZ8N600M=;
 b=QYEsH0b8vAG+oAHiTN146e7Gt/4jY3ps/wc7dA3Rnj0FxMA2mpjBdObGLEEPBNpN+izppL
 eiE0P1GjdT8fx22AGG3qlPrmYztEoyTXmOitqoB8igqwlAMMXLZbBtD4SeY9ko+w457Nwo
 5hPhYlay9bVTEaiHSltGtaAWlDHOECM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443--V0XHB0HNaWdNHN-OkKz2A-1; Thu, 18 Jul 2024 11:36:17 -0400
X-MC-Unique: -V0XHB0HNaWdNHN-OkKz2A-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e035edb802aso172408276.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 08:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721316977; x=1721921777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW/5YO1QNQUThUYfY6HZH2uk9BFMYXc7F6+cZ8N600M=;
 b=clow18T/Nk0MCazXh60Se0RLQ4+RU1ZI7wdUZnJqKUvAhxOAQCqCT5DfkO18MYf34M
 4ZdeDAAWpIUcwpUNZ9HTHUz2lfJ+yipzKDrHlPkdRAQQo4PBxuJxhlCjzFQSOHiGjGqM
 K7pcciIuBdAFhLEV20ErnYelbtd4WsTNi4T30tX/GQdgSs5XO15QORzeNISx/nO6SWh/
 HMUI5QdTmOWGwMTLDYlkFQLSczhTGC8TFY8Ka2t0nYgvfQY84FGEsqxA04iurX4dKJTv
 JKWdliBydjkjBajMNOSOuZ7Qul5fMn5gXNbBhHUEDkEuCuynSK5Ddya2FSGM8Do00M22
 AOsQ==
X-Gm-Message-State: AOJu0Yw+L21JLJ3V2m1gkSXEWPGwXQbbahj2i7D38+4LVDuQ3o0aSIGw
 r4pd9Z6mqzw1H0bhrxNxSVF8wjJM8qftEmp0UglP54GMAnvPmLM3WqDPOqKUFUnmPWPt8h1EMpW
 NC3ddtheJYX3aktlCDa8TFApQmsAr124A+OCQeFIEfISZ0Bz+oPWM
X-Received: by 2002:a05:6902:2802:b0:e03:b665:da77 with SMTP id
 3f1490d57ef6-e05fec26656mr1558164276.3.1721316976764; 
 Thu, 18 Jul 2024 08:36:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5xu3vIlNTXvSn41FNNpFLp+9PdWuWZLTEQKrpNipGiURU2YxP6SHxBoSUEDVFdUB1fZau+w==
X-Received: by 2002:a05:6902:2802:b0:e03:b665:da77 with SMTP id
 3f1490d57ef6-e05fec26656mr1558148276.3.1721316976329; 
 Thu, 18 Jul 2024 08:36:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b79c4fb351sm9188166d6.46.2024.07.18.08.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 08:36:15 -0700 (PDT)
Date: Thu, 18 Jul 2024 11:36:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zpk2bfjS1Wu2QbcO@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jun 30, 2024 at 12:44:02PM -0700, Steve Sistare wrote:
> What?
> 
> This patch series adds the live migration cpr-transfer mode, which
> allows the user to transfer a guest to a new QEMU instance on the same
> host.  It is identical to cpr-exec in most respects, except as described
> below. 

I definitely prefer this one more than the exec solution, thanks for trying
this out.  It's a matter of whether we'll need both, my answer would be
no..

> 
> The new user-visible interfaces are:
>   * cpr-transfer (MigMode migration parameter)
>   * cpr-uri (migration parameter)

I wonder whether this parameter can be avoided already, maybe we can let
cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
in the same channel?

>   * cpr-uri (command-line argument)
> 
> In this mode, the user starts new QEMU on the same host as old QEMU, with
> the same arguments as old QEMU, plus the -incoming and the -cpr-uri options.
> The user issues the migrate command to old QEMU, which stops the VM, saves
> state to the migration channels, and enters the postmigrate state.  Execution
> resumes in new QEMU.
> 
> This mode requires a second migration channel, specified by the cpr-uri
> migration property on the outgoing side, and by the cpr-uri QEMU command-line
> option on the incoming side.  The channel must be a type, such as unix socket,
> that supports SCM_RIGHTS.
> 
> This series depends on the series "Live update: cpr-exec mode".
> 
> Why?
> 
> cpr-transfer offers the same benefits as cpr-exec mode, but with a model
> for launching new QEMU that may be more natural for some management packages.
> 
> How?
> 
> The file descriptors are kept open by sending them to new QEMU via the
> cpr-uri, which must support SCM_RIGHTS.
> 
> Example:
> 
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would use a new QEMU binary path in terminal 2.
> 
>   Terminal 1: start old QEMU
>   # qemu-kvm -monitor stdio -object
>   memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>   -m 4G -machine anon-alloc=memfd ...
> 
>   Terminal 2: start new QEMU
>   # qemu-kvm ... -incoming unix:vm.sock -cpr-uri unix:cpr.sock
> 
>   Terminal 1:
>   QEMU 9.1.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
>   (qemu) migrate_set_parameter mode cpr-transfer
>   (qemu) migrate_set_parameter cpr-uri unix:cpr.sock
>   (qemu) migrate -d unix:vm.sock
>   (qemu) info status
>   VM status: paused (postmigrate)
> 
>   Terminal 2:
>   QEMU 9.1.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
> 
> Steve Sistare (6):
>   migration: SCM_RIGHTS for QEMUFile
>   migration: VMSTATE_FD
>   migration: cpr-transfer save and load
>   migration: cpr-uri parameter
>   migration: cpr-uri option
>   migration: cpr-transfer mode
> 
>  include/migration/cpr.h        |  4 ++
>  include/migration/vmstate.h    |  9 +++++
>  migration/cpr-transfer.c       | 81 +++++++++++++++++++++++++++++++++++++++++
>  migration/cpr.c                | 16 +++++++-
>  migration/meson.build          |  1 +
>  migration/migration-hmp-cmds.c | 10 +++++
>  migration/migration.c          | 37 +++++++++++++++++++
>  migration/options.c            | 29 +++++++++++++++
>  migration/options.h            |  1 +
>  migration/qemu-file.c          | 83 ++++++++++++++++++++++++++++++++++++++++--
>  migration/qemu-file.h          |  2 +
>  migration/ram.c                |  1 +
>  migration/trace-events         |  2 +
>  migration/vmstate-types.c      | 33 +++++++++++++++++
>  qapi/migration.json            | 38 ++++++++++++++++++-
>  qemu-options.hx                |  8 ++++
>  stubs/vmstate.c                |  7 ++++
>  system/vl.c                    |  3 ++
>  18 files changed, 359 insertions(+), 6 deletions(-)
>  create mode 100644 migration/cpr-transfer.c
> 
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


