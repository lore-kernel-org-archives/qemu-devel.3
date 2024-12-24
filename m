Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC84E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 19:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQAW0-00018Z-PM; Tue, 24 Dec 2024 14:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAVz-00018R-Lc
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAVx-0006eE-L5
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735068258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1q/JZcfF0DAYoMm/gDv7gMWmd9P6ZY9ZSDv/OrhafE=;
 b=bLXgXZ6jw+EDadAJEtwdufEs7vZ/+eZ/TvNzrhyoR8scSqj2sPI7w7kmUziS116LiuPp8F
 KwiBmsg6ytG0ZZ7VCa5xXNJxzdub5k0MhEZL4YjRaSYSJzLdEpSOYqb1dMXg4yta61VVxe
 6Z2eF7nvZTUcdg0100GpogV5ih1KqWo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-UqDjGBSKMSS2IeHhRw_bZg-1; Tue, 24 Dec 2024 14:24:17 -0500
X-MC-Unique: UqDjGBSKMSS2IeHhRw_bZg-1
X-Mimecast-MFC-AGG-ID: UqDjGBSKMSS2IeHhRw_bZg
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467919046fbso125317501cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 11:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735068257; x=1735673057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1q/JZcfF0DAYoMm/gDv7gMWmd9P6ZY9ZSDv/OrhafE=;
 b=qiO5kl8MyBUaAFLoqZlNbQGFSA3XCffdwLr9CLJtLQ2UQE2Y+i5WY8kS6Ec9c5I7Zw
 evQ5tI1yEPIvGywC7R0Sxoo0LXDO6su4tEDcnP3GtANt5zqlmxRnpc6EQsdWPmDKk0+x
 KFZ9FUUSx5Nj6vw8ehZrU//fem+ulq2IDXCH4uyGJvTGjSJHbzdcmaoFrnm2kuDlPR2+
 pDoDzGb8OLbk/iS+Tsc050eNpcprysFGeIukeI0M21PFEPN0wzKZbSoMlg1JqGV0meyz
 v1lOfpj77N9MfRqj2MTDa9ocFnKqdkeZjuWKrM0QBnM9okSYr/QSeTuHe3kq/JQRcEqn
 D3Gg==
X-Gm-Message-State: AOJu0YymLgEERa01LNj7Mfofg/ulxjXyCe3j45BHQzxiNFJrKS8kJbGK
 Edi2PdLjM+G02XtOB7/aUH+5zuA19VkXj8kd4iexTAtSmIXfwKi/tMyx0jwVzd/LAkvGxoBt9TX
 lrkIG7CNa1epxvyBv+pl/LEhllNTYHDIWDP1Tvc+SiHE99bPn3VGU
X-Gm-Gg: ASbGnct2ABHBTxThMHgEPZIpZMYe+Q6iHuD5tbymdiagCKluNY8sJCQ0McSCj8aznIS
 Qy/HVinqCFEfyNc1IlyKf9JmWOzTwSrSzo+Ea82p2ffU6VX9y0enVR8CYdSo+K8tNP1B3KWzep5
 8OjMN+8AhnZsQ2ylo/hvTLAr6ENwGRCqvUuALFbr1EO3DatxvIJOJAC4EnKLgThWNCcNSWoTvIN
 oUop6ZD6JfQWwy9g6FFssfy4tQADIBYTacvie0flTHaoG86hMoroB25gFivmeNGgMbPKrRTZEtC
 W++APmZ+Ighei5mbvw==
X-Received: by 2002:a05:622a:294:b0:469:c8e8:d529 with SMTP id
 d75a77b69052e-46a4b112175mr226807121cf.8.1735068256747; 
 Tue, 24 Dec 2024 11:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnIl4Bjeg+QAWgcjfBAI11CaVi10ivHrfUx+I0oUeEUAJz6FLxtkatvrm7imORRvgmKYsV6w==
X-Received: by 2002:a05:622a:294:b0:469:c8e8:d529 with SMTP id
 d75a77b69052e-46a4b112175mr226806861cf.8.1735068256440; 
 Tue, 24 Dec 2024 11:24:16 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb17a2dsm55821001cf.59.2024.12.24.11.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 11:24:15 -0800 (PST)
Date: Tue, 24 Dec 2024 14:24:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
Message-ID: <Z2sKXAgsUW3A8ajg@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Dec 24, 2024 at 08:17:00AM -0800, Steve Sistare wrote:
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
> adds a second -incoming option with channel type "cpr".  The CPR channel
> address must be a type, such as unix socket, that supports SCM_RIGHTS.
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

Feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

I still have a few trivial comments.

[...]

> diff --git a/migration/cpr.c b/migration/cpr.c
> index 87bcfdb..584b0b9 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -45,7 +45,7 @@ static const VMStateDescription vmstate_cpr_fd = {
>          VMSTATE_UINT32(namelen, CprFd),
>          VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>          VMSTATE_INT32(id, CprFd),

Could you remind me again on when id!=0 will start to be used?

> -        VMSTATE_INT32(fd, CprFd),
> +        VMSTATE_FD(fd, CprFd),
>          VMSTATE_END_OF_LIST()
>      }
>  };

[...]

> @@ -320,6 +328,7 @@ void migration_cancel(const Error *error)
>          qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
>      }
>      migrate_fd_cancel(current_migration);
> +    migrate_hup_delete(current_migration);

migrate_fd_cancel() has one of such, not sure whether it's needed here.

>  }

-- 
Peter Xu


