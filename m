Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C71CEF177
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAlk-0000Ol-2T; Tue, 08 Oct 2024 10:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syAlf-0000OS-4r
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syAlc-00059h-Mu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728396047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OKtbADzD5Hmos3eQgEh6vs+fETwc/yqRFULp6XQGik=;
 b=fY1LRhSG65N0Jbu669z8UAgWQuy5+sZoiMQoKgP01sqLHROzsTBDNjm1zpEZJ1MECqaqFr
 LbpTrR25kYCNVbUfqxZBBoIUBk8jVynUQ6N8AVxTYKBFRNincypiBN9uRR8BJ5NL5aDeTU
 Y1MkKQqceKjnzkdoEiXoTi9nli5Su7s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yhEowjKONPKZkB2p6HA7qA-1; Tue, 08 Oct 2024 10:00:44 -0400
X-MC-Unique: yhEowjKONPKZkB2p6HA7qA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82aa9477f54so462193539f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396044; x=1729000844;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9OKtbADzD5Hmos3eQgEh6vs+fETwc/yqRFULp6XQGik=;
 b=wyi5FmCsjCmsfg4OANTBE7RUz+GwAexvAw7nbqInvJj4TRwNN1p+Vu0B7MXBAADL6g
 sKcwzxYrhU8A79w5AFVYRcM3WOBBuagAtB0vfTqGoFTZwsO1/wCGf2/E9J8S+Ajz5GDN
 YOVkTtL1VwrEy6uREDQM/fNygQIQn5I9Rd1/ogBBbO97ieb06V7IY8XsZBPIxtYMBW6a
 /2PPxQB1NpEpy9Tmjx/jLZawQYcanUEywsTArx+g8uUx8SgluAhzbqs/KpUwbeRPcFjP
 kch5sOZm/fUZtKCmE6Tb3OE9tlZMJXCKiQvaufq+XmfvVUREAWfgN5HGL7PQBkgPqkQ4
 qgnQ==
X-Gm-Message-State: AOJu0YwdFwB3z44zMzCLs7q+MciJu1/OSEqZCMH/AXL3eiWbv1zsP4ig
 tzQnjflAN+zwKKc1zlmXeTLKA5oijvOzGKGLOK+5M/yBapZR3gOSAa9HZhQTOjYFGPI3hxvy5QN
 TomZ/ieKaIUsFxbDClPuV5HUWbo6AubrA+DG682yJZHNvXevAo3Gr
X-Received: by 2002:a5e:dd03:0:b0:832:4396:cdc8 with SMTP id
 ca18e2360f4ac-8352cd0671dmr279520339f.0.1728396043603; 
 Tue, 08 Oct 2024 07:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8WrIUMMcxc1Pu4Vo1ohQnDvJiZnnqyBd3SJ6mmQ212AEfjRjqAsR3PqTm+fSn2TSX6axkgw==
X-Received: by 2002:a5e:dd03:0:b0:832:4396:cdc8 with SMTP id
 ca18e2360f4ac-8352cd0671dmr279513139f.0.1728396042990; 
 Tue, 08 Oct 2024 07:00:42 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503b153a2sm180788839f.44.2024.10.08.07.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 07:00:42 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:00:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH] Use multifd state to determine if multifd cleanup is
 needed
Message-ID: <ZwU7B8O3GgPnKf5S@x1n>
References: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
 <ZwQLzf8mGHCr1Itg@x1n>
 <EF62F9C3-322E-4478-B985-65FDD794B3D2@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EF62F9C3-322E-4478-B985-65FDD794B3D2@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

On Tue, Oct 08, 2024 at 12:09:03PM +0000, Shivam Kumar wrote:
> 
> 
> On 7 Oct 2024, at 9:56 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On Mon, Oct 07, 2024 at 03:44:51PM +0000, Shivam Kumar wrote:
> If the client calls the QMP command to reset the migration
> capabilities after the migration status is set to failed or cancelled
> 
> Is cancelled ok?
> 
> Asked because I think migrate_fd_cleanup() should still be in CANCELLING
> stage there, so no one can disable multifd capability before that, it
> should fail the QMP command.
> I meant CANCELLED but I can see that currently, CANCELLED is only possible
> after migrate_fd_cleanup is called. So, you are right. We won’t have a problem
> in that path at least.
> 
> But FAILED indeed looks problematic.
> 
> IIUC it's not only to multifd alone - is it a race condition that
> migrate_fd_cleanup() can be invoked without migration_is_running() keeps
> being true?  Then I wonder what happens if a concurrent QMP "migrate"
> happens together with migrate_fd_cleanup(), even with multifd always off.
> 
> Do we perhaps need to cleanup everything before the state changes to
> FAILED?
> Tried calling migrate_fd_cleanup before (and just after) setting the status to
> failed. The migration thread gets stuck in close_return_path_on_source trying
> to join rp_thread.

I am guessing it's because the new rp thread is created before cleanup of
the previous one in this case, so the join() will hang forever.

In this case, below change might not be enough I guess, as I discussed
above.

We may need to postpone setting FAILED status after everything cleaned up
just like what we do with CANCELLING.. maybe we don't need a FAILING state
if we have migrate_set/has_error() - we can use migrate_has/set_error() for
whatever we used to do (set/check) with FAILED, then we set FAILED at last
in the BH like CANCELLED.

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
> migration/multifd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 9b200f4ad9..427c9a7956 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -487,7 +487,7 @@ void multifd_send_shutdown(void)
> {
>     int i;
> 
> -    if (!migrate_multifd()) {
> +    if (!multifd_send_state) {
>         return;
>     }
> 
> --
> 2.22.3
> 
> 
> --
> Peter Xu
> 

-- 
Peter Xu


