Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ECEC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 20:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk7dF-0000kW-1f; Thu, 07 Aug 2025 16:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk7dC-0000he-Ug
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk7dA-00081n-GN
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 16:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754600071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5i27LNpLfMJrfODKprIHuYONA+YTgOyXhwgwSCEYYA=;
 b=ixQtbMQ+6M9SS1w8R+5U5U/7sx6UkuiV2k/ajzG1d/Ntp/ACBFZebHycxlb/cihkCYhN2Y
 J+CYXH0TKfzQpqzC5rp6R8lPrpjh0q9S8n3Y19vnmztMZPMSFhCvx3zPgRWnjpABWDcbNg
 +oyN1+4svScL8B4FxSqeFtt+gptKiKw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-8f8tlDtNPB2mXiccstcUMg-1; Thu, 07 Aug 2025 16:54:30 -0400
X-MC-Unique: 8f8tlDtNPB2mXiccstcUMg-1
X-Mimecast-MFC-AGG-ID: 8f8tlDtNPB2mXiccstcUMg_1754600069
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b06908ccacso32586381cf.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 13:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754600069; x=1755204869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5i27LNpLfMJrfODKprIHuYONA+YTgOyXhwgwSCEYYA=;
 b=wCcDlNxIUNw5if7ehWmKojrc8GSZ+VnABQPhWCp6ycuiFuxLNxZVGfh+gXPjpXYwTW
 aJoW8OHC5Om8tHXrv3q/E2NhhSTkBYoVTUtB0m6QdoSQEB/bYtVyKj6ti3dGrVzAGQH+
 xVhSTgJP+EPAxAu6iCstza3novSARNUCi4xNX5tyEO6zxQ7OFFZwFAf8tsDH3aeE9k3J
 oFZHygxvLsCqnvGsZixvRbAnSsl9ZwoLVyVYJVidJeHHHws8S3KjoukuydOiZiWysnRc
 3TDnLnw88WaIA5pedUwbdaT+ly9S7MqSqvqoFr49sVTOKtugcoXyjCuWMrOxWXegyPo+
 OxmQ==
X-Gm-Message-State: AOJu0YxjrHQx8KxJYmjpMwGMJT/x8ZZXoJlMdtNjcRHd6MccIyiPSDWI
 /BzmUvgfMR0EkuKwjRViDmzrAQ7ovmNwEnO3eTi4bIm8y4iD3DDNaQ+MVsbL5VwGdAhtAbmAUH6
 seDhJ9xJo09MAzJSnoB3hMUUaCEIFjobooMpi1Wnt4lrha6jcoasvwYBP
X-Gm-Gg: ASbGncup69BMidmgq011mHXb//hjEVDib6pNUUm48Zfyui6DOPmHEpb0mCQrUpI1rvw
 brQTkAx6/c3qlfceYNhWBPK4HkOjttAff3oRNh0JvwYvWJ65i0DS5MAKajZ4u3r+NQmPEzquFWn
 7eLm2XMd4vQhJ7VodhsA9H5AniIRJjgs4dtiRyxWOlUz/lj0ldK2q1rXpOxuc8KOd7hMDJI7s21
 tgpVT8HsJw+dpXunR5AlDVTinuW3HGKAyzGAVLQFHdZ0wYelr2D0UHkmNbPug4mY1PyIfdSo5nA
 /kNN+XzIVm8A+sBMJQoWZmNKr5IU4rto
X-Received: by 2002:a05:622a:1a10:b0:4b0:73db:f81b with SMTP id
 d75a77b69052e-4b0aecfc8c6mr11413381cf.10.1754600069338; 
 Thu, 07 Aug 2025 13:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFFjyIhz6dKUXaB70gZJ1O7szu5mVentBPB6K/4hlJawlhcelg4C8tymBC4EhgS75B8JREIQ==
X-Received: by 2002:a05:622a:1a10:b0:4b0:73db:f81b with SMTP id
 d75a77b69052e-4b0aecfc8c6mr11413071cf.10.1754600068872; 
 Thu, 07 Aug 2025 13:54:28 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b0867b7b70sm36623261cf.9.2025.08.07.13.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 13:54:28 -0700 (PDT)
Date: Thu, 7 Aug 2025 16:54:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 2/4] migration: Fix state transition in
 postcopy_start() error handling
Message-ID: <aJUSeOIKfQ47uliY@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-3-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807114922.1013286-3-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 01:49:10PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Depending on where an error during postcopy_start() happens, the state
> can be either "active", "device" or "cancelling", but never
> "postcopy-active". Migration state is transitioned to "postcopy-active"
> only just before a successful return from the function.
> 
> Accept any state except "cancelling" when transitioning to "failed"
> state.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..e5ce2940d5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>  fail_closefb:
>      qemu_fclose(fb);
>  fail:
> -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +    if ( ms->state != MIGRATION_STATUS_CANCELLING) {
> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +    }

Hmm, this might have been overlooked from my commit 48814111366b.  Maybe
worth a Fixes and copy stable?

For example, I would expect the old code (prior of 48814111366b) still be
able to fail postcopy and resume src QEMU if qemu_savevm_send_packaged()
failed.  Now, looks like it'll be stuck at "device" state..

The other thing is it also looks like a common pattern to set FAILED
meanwhile not messing with a CANCELLING stage.  It's not easy to always
remember this, so maybe we should consider having a helper function?

  migrate_set_failure(MigrationState *, Error *err);

Which could set err with migrate_set_error() (likely we could also
error_report() the error), and update FAILED iff it's not CANCELLING.

I saw three of such occurances that such helper may apply, but worth double
check:

postcopy_start[2725]           if (ms->state != MIGRATION_STATUS_CANCELLING) {
migration_completion[3069]     if (s->state != MIGRATION_STATUS_CANCELLING) {
igration_connect[4064]        if (s->state != MIGRATION_STATUS_CANCELLING) {

If the cleanup looks worthwhile, and if the Fixes apply, we could have the
cleanup patch on top of the fixes patch so patch 1 is easier to backport.

Thanks,

>      migration_block_activate(NULL);
>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
>      bql_unlock();
> -- 
> 2.50.1
> 

-- 
Peter Xu


