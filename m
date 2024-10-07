Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC7CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqZa-0004xI-Fm; Mon, 07 Oct 2024 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqZZ-0004x8-J6
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqZY-0007Tf-2x
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728318418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UTY1mlwU6WbXeF5OqYqeFphjvbXR90wyPybdu//WD3c=;
 b=QMOFlAiYY+4Yrvbp8S33GirdMhPRP4xfx21ALhYGQTlUOzbapHHSoA1kxmFuiQ+UQennOs
 Nx1B7bxqTwj9BIwe08tIsB57UlFZ12bslGFlc28dwRrVPwBTonmlF6gXHsGALnB3V2c6NC
 qvHMH2SK6rjGUgsUviCjW/Hk8Us0TpA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-k0vRwe8TOjSMO_uHktqJpA-1; Mon, 07 Oct 2024 12:26:57 -0400
X-MC-Unique: k0vRwe8TOjSMO_uHktqJpA-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a19665ed40so34485815ab.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728318417; x=1728923217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTY1mlwU6WbXeF5OqYqeFphjvbXR90wyPybdu//WD3c=;
 b=bw864Mgf+TxTNvfkbw/7diZcCNv5zMXrb9Eg4De1L4NslmSTV0x8Y5VYT5q1Tlqwn2
 Xo5VxrKjMnxja7/XWwfqPMVfpVCEINLsZ8zGebHqXN5BZgD+AfNKVQBmMWS3Rz+u2JC4
 ELvkUcjb7WWZBnaFVi+aOXP1qSz/2pqksydjh1pr+jnw0IZwDW6WNmCjfBwD57sT+9oH
 +Dgkyyk+IHxjQFId4vVcXf62xt5nlhrqRBNPF6Q2Goiepm7+x2t1fZuoU/UK9ofOZTao
 6Ju1Ilfq68zNvi7dEm4ilRYXtcinTkPUY6Sk8/0Lu0Kts1iVJp15/o+1XzXxgF5YlaR6
 dihA==
X-Gm-Message-State: AOJu0YwoBpURpOstqPonoRUMEqIQ7gN5ImLsU/JR/JqUZzJOhTDJSL9O
 x5VjbS37fo/jKg8aH1drqJ0/f3fucDQC2N5e0utG9zFr0pd7t2HqgAO0Hr1wdg1Nd7dHLdWUTnC
 ZrkwoWgLwaBxxulAP3wlanxVMbSMcUJ//Jc0RGv4pmmkby8d6kace
X-Received: by 2002:a05:6e02:1d84:b0:3a3:637f:1012 with SMTP id
 e9e14a558f8ab-3a38af7899bmr1382135ab.12.1728318416699; 
 Mon, 07 Oct 2024 09:26:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV4H3TH7bCNHhbNx6uMRM8w7fShx3AZJbLhKwhfZbKX3do5JUVdsm+BGHkCXn8RI7ObGFiPQ==
X-Received: by 2002:a05:6e02:1d84:b0:3a3:637f:1012 with SMTP id
 e9e14a558f8ab-3a38af7899bmr1382065ab.12.1728318416357; 
 Mon, 07 Oct 2024 09:26:56 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db8d6484c7sm267298173.140.2024.10.07.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:26:56 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:26:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] Use multifd state to determine if multifd cleanup is
 needed
Message-ID: <ZwQLzf8mGHCr1Itg@x1n>
References: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 07, 2024 at 03:44:51PM +0000, Shivam Kumar wrote:
> If the client calls the QMP command to reset the migration
> capabilities after the migration status is set to failed or cancelled

Is cancelled ok?

Asked because I think migrate_fd_cleanup() should still be in CANCELLING
stage there, so no one can disable multifd capability before that, it
should fail the QMP command.

But FAILED indeed looks problematic.

IIUC it's not only to multifd alone - is it a race condition that
migrate_fd_cleanup() can be invoked without migration_is_running() keeps
being true?  Then I wonder what happens if a concurrent QMP "migrate"
happens together with migrate_fd_cleanup(), even with multifd always off.

Do we perhaps need to cleanup everything before the state changes to
FAILED?

> but before multifd cleanup starts, multifd cleanup can be skipped as
> it will falsely assume that multifd was not used for migration. This
> will eventually lead to source QEMU crashing due to the following
> assertion failure:
> 
> yank_unregister_instance: Assertion `QLIST_EMPTY(&entry->yankfns)`
> failed
> 
> Check multifd state to determine whether multifd was used or not for
> the migration rather than checking the state of multifd migration
> capability.
> 
> Signed-off-by: Shivam Kumar <shivam.kumar1@nutanix.com>
> ---
>  migration/multifd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 9b200f4ad9..427c9a7956 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -487,7 +487,7 @@ void multifd_send_shutdown(void)
>  {
>      int i;
>  
> -    if (!migrate_multifd()) {
> +    if (!multifd_send_state) {
>          return;
>      }
>  
> -- 
> 2.22.3
> 

-- 
Peter Xu


