Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5515C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJAd-0003EY-Ff; Tue, 04 Feb 2025 08:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJAa-0003Cf-Ju
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:40:53 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJAX-0001uR-EV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:40:52 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5b1c4d14f2so411245276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738676447; x=1739281247; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rudjwNQeYPUWERrrMB/LNEAE0nfdBbuoEYusxtBz6Hk=;
 b=qbrdEbwA9HvSTzknY6mwlWIFD3PFpIPyDFFZQfmb255vCobtAA7RjetIHYoCJeoRJM
 KC1WU3OSGkg5ZeUkb9dYacFW4MIORaPURQfDRXdNTQ8rHHg/zhHJfZuRHWJtOgxKNOff
 8MMv39abtPXuMvHe8TxDO80PD3yHM7nipfNMvui+XwggCo797h8JIGDcCpPB80YFnjlb
 Mo1Myv0n74COgoTkAFvtVev9Py82lzQoGdlItnhuNzCbef5EbRnOnL+kNCaB/jx/hroB
 H32yLBhVDbIyYdxTMujYVE4JjAAZn756aDdTd6C/O5RWs2Ss+Ec3XAU/eLsByE9pCgg3
 OC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738676447; x=1739281247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rudjwNQeYPUWERrrMB/LNEAE0nfdBbuoEYusxtBz6Hk=;
 b=tn5FtCqUdGD7dFOZGAjaA9AOI6PX9gAhnvABMhC+aSXXAA/sE4FIHZWL+jvl6JF1hJ
 rrnwZZXa378QPAFT1Xy3TPI9Pv5cNpEsYNx66mZpDp4prKD0R6LrmNBJ5rs9qnf/UBRI
 uWgBIBvEC5z3Be3/pugYijmlKlZxiZtca9h+4q+gWki/dDq3ULDyCRwXSrumGaawN8x7
 yfwQ/twE4a71KJkem7DAkBU9yHwHHOhNXqE9/56kXpfOT6IO1O/nfdRs3MtHHDm+SZyS
 rlG4URDZsbeaznIxjsH0a6dnSxNvK5gzTWYL9qIZ9qajRzgFAllx0PrvvLNy5ljzWL3I
 vm1g==
X-Gm-Message-State: AOJu0YzqyUXdDGSyLIqZS1d+7LC7NqfGbM4eTK5FhQdQXT1jqorquFl4
 AB1zQtn7HV2/Z9NOa9/K1mYVZNAVygg1ZXcLA1Ze8V/Ei7H6tGky1l9ipFAV4NV7D2iKuNADTAN
 b2aWmPNuFBeXfwGIGXlWdxG0sZaklf4oWJvJ2UA==
X-Gm-Gg: ASbGncvO4zlanYp2K9IUhqLmBaNNrXvXAy7F6cj0lXlKEuqYJ3E71fDh70DnuDzrQJy
 xzr6geoSRTi9QSrVx3zzdHNJtPCbGD/zTnXpb3dQJA7DZPHC2a6gBGXIj+zGyMW8I6OfJpNbx0w
 ==
X-Google-Smtp-Source: AGHT+IHeHRYxr+Swa+BwCou+cErm/FptXK49eojgCJiQUdrsLbWFfnerhYfiOQG6XLkuk+ZFF4/Av/vgoftCdwpFQZ0=
X-Received: by 2002:a05:6902:2088:b0:e57:2ff6:945a with SMTP id
 3f1490d57ef6-e58a4936160mr18704318276.0.1738676445825; Tue, 04 Feb 2025
 05:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20250129160059.6987-1-farosas@suse.de>
 <20250129160059.6987-18-farosas@suse.de>
In-Reply-To: <20250129160059.6987-18-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 13:40:34 +0000
X-Gm-Features: AWEUYZntsz34b6Zq9iRaewdxvbQ6HhMaOXxOBH-KR6OgjfLmqqOuqkuFDQm7f5Y
Message-ID: <CAFEAcA9q+QLJnyVZDAKLsB0i2iBohNwkTXmycpV5CUsWYWZmFw@mail.gmail.com>
Subject: Re: [PULL 17/42] migration: cpr-transfer mode
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 29 Jan 2025 at 16:11, Fabiano Rosas <farosas@suse.de> wrote:
>
> From: Steve Sistare <steven.sistare@oracle.com>
>
> Add the cpr-transfer migration mode, which allows the user to transfer
> a guest to a new QEMU instance on the same host with minimal guest pause
> time, by preserving guest RAM in place, albeit with new virtual addresses
> in new QEMU, and by preserving device file descriptors.  Pages that were
> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
> descriptor of the device that locked them remains open.
>
> cpr-transfer preserves memory and devices descriptors by sending them to
> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
> be sent over the normal migration channel, because devices and backends
> are created prior to reading the channel, so this mode sends CPR state
> over a second "cpr" migration channel.  New QEMU reads the cpr channel
> prior to creating devices or backends.  The user specifies the cpr channel
> in the channel arguments on the outgoing side, and in a second -incoming
> command-line parameter on the incoming side.
>
> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
> which allows anonymous memory to be transferred in place to the new process
> by transferring a memory descriptor for each ram block.  Memory-backend
> objects must have the share=on attribute, but memory-backend-epc is not
> supported.
>
> The user starts new QEMU on the same host as old QEMU, with command-line
> arguments to create the same machine, plus the -incoming option for the
> main migration channel, like normal live migration.  In addition, the user
> adds a second -incoming option with channel type "cpr".  This CPR channel
> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
> UNIX domain socket.
>
> To initiate CPR, the user issues a migrate command to old QEMU, adding
> a second migration channel of type "cpr" in the channels argument.
> Old QEMU stops the VM, saves state to the migration channels, and enters
> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
> resumes.
>
> The implementation splits qmp_migrate into start and finish functions.
> Start sends CPR state to new QEMU, which responds by closing the CPR
> channel.  Old QEMU detects the HUP then calls finish, which connects the
> main migration channel.
>
> In summary, the usage is:
>
>   qemu-system-$arch -machine aux-ram-share=on ...
>
>   start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>
>   Issue commands to old QEMU:
>     migrate_set_parameter mode cpr-transfer
>
>     {"execute": "migrate", ...
>         {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Link: https://lore.kernel.org/r/1736967650-129648-17-git-send-email-steven.sistare@oracle.com
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Hi; this commit includes some code that has confused
Coverity (CID 1590980) and it also confused me, so maybe
it could be usefully made clearer?


>  void qmp_migrate(const char *uri, bool has_channels,
>                   MigrationChannelList *channels, bool has_detach, bool detach,
>                   bool has_resume, bool resume, Error **errp)
> @@ -2056,6 +2118,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>      g_autoptr(MigrationChannel) channel = NULL;
>      MigrationAddress *addr = NULL;
>      MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
> +    MigrationChannel *cpr_channel = NULL;
>
>      /*
>       * Having preliminary checks for uri and channel
> @@ -2076,6 +2139,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>              }
>              channelv[type] = channels->value;
>          }
> +        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
>          addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
>          if (!addr) {
>              error_setg(errp, "Channel list has no main entry");
> @@ -2096,12 +2160,52 @@ void qmp_migrate(const char *uri, bool has_channels,
>          return;
>      }
>
> +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
> +        error_setg(errp, "missing 'cpr' migration channel");
> +        return;
> +    }

Here in qmp_migrate() we bail out if cpr_channel is NULL,
provided that s->parameters.mode is MIG_MODE_CPR_TRANSFER...

> +
>      resume_requested = has_resume && resume;
>      if (!migrate_prepare(s, resume_requested, errp)) {
>          /* Error detected, put into errp */
>          return;
>      }
>
> +    if (cpr_state_save(cpr_channel, &local_err)) {

...but in cpr_state_save() when we decide whether to dereference
cpr_channel or not, we aren't checking s->parameters.mode,
we call migrate_mode() and check the result of that.
And migrate_mode() isn't completely trivial: it calls
cpr_get_incoming_mode(), so it's not obvious that it's
necessarily going to be the same value as s->parameters.mode.
So Coverity complains that it sees a code path where we
might dereference cpr_channel even when it's NULL.

Could this be made a bit clearer somehow, do you think?

thanks
-- PMM

