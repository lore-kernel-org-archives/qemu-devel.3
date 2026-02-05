Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B45FECD9AF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7cL-0000iD-CE; Thu, 05 Feb 2026 17:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7cJ-0000hH-8g
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7cG-0001hE-Kx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770329663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gIeSFq899Jh5oIUCV0i8pGg8yLyPkEp+Drl86iBVQBs=;
 b=cxjiPyU3zp1QKnl27oVsl35xLGZa3jhy5BcTGyraO9vf0emHu9xWNxbzyQ7JeCZ0anAnxo
 YT+GjABzCxhE9p4ikAZ0le1M2KwDjXr+PedtzXU7z+DUzWdwJsrOn0s1DAppy8m5mDVCYC
 +UEjwciMgaa1BYgAY+qo6MCF99HORCI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-yFBua_zSP8KseN1JDQNFLw-1; Thu, 05 Feb 2026 17:14:21 -0500
X-MC-Unique: yFBua_zSP8KseN1JDQNFLw-1
X-Mimecast-MFC-AGG-ID: yFBua_zSP8KseN1JDQNFLw_1770329661
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6a2ef071dso22569885a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770329661; x=1770934461; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gIeSFq899Jh5oIUCV0i8pGg8yLyPkEp+Drl86iBVQBs=;
 b=qvTkGZb8wQOx5wxKI7HQvT/LX4/5mFuE0Gj+7IHz0vUScJt2gnZAuHlKbdGpXrBdYe
 ujJsOnMV1AKx5+TKXz3glYsscIJu64zuujpunDYyGdoLORkxmVAkDyolR6qtjKf0KP9Y
 DzWc6RTEwIRv831sPL0l26CwCU5I32V9XmBn6oXgJP3VgCaGTnHtrWbC0zQhwkTJS1uX
 F6js63yEvHlOP3EXi+bIYgg71Qywu3I9Y/Rmb6TGCl6aTNOY2CmtbBXrpvn79N92uF6M
 T0ryDtPQiTdwOJba4q95QjAeUBxLkPRgZWgsKqvKzwJyE9nE7miWVfIkz14j5DRcrGQV
 CTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770329661; x=1770934461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIeSFq899Jh5oIUCV0i8pGg8yLyPkEp+Drl86iBVQBs=;
 b=pJmcMZLHod4lp1rn5RJnZSjXWR4Hs7roNVETDHxkhqOgryi1EP5tH7wOcJHNx7PPR6
 P45Sxjk9GfHAEg3CTIeGBpxZ9K3IonFQ/rn1dnz26GUwhyrsdS9oSoyAMCmQk+VkbE47
 iVAUnXELvFd9eexBtISoKpL6uZ1bTheI9rxFonbc7u+erWZyCyArz3lt8eLVVEEVrMPH
 T1KixhJes/wCqQWvtqdoAaeIQ9HuOIOsjS+YveuTseLeIBOAnp+GSWpHDNkG7GvT8dJz
 JIp9ScX8pBo7hv5YxTX2MfKAPVzwXUT2L/LAoFqCy+nTJ4+HcdBcTa8MITRrFSG/s+9X
 gnrQ==
X-Gm-Message-State: AOJu0Yy++1biOwT2W9F1rqL0rNT+4GZp8DU0uusRoURqbK/KEEz2+LVH
 EZoDcCLSo6P7uhG8bf8udQyP311EXE15MTtplORTXogHIKsYv/10T6ChFVQ0kOvW8FEuUg2mBXO
 DirpldIG4ktP2RZUuNV/Guy6kLGcxw+eVNPNVZD/VJIoQe3PWhvcfxDG7
X-Gm-Gg: AZuq6aL/FcureNUlK/av+EXTWQqHgOVhJlNjFut9D0slSe5DN2v0XBK/P2LhpfyJdqD
 1bnvoD/uCX2BtWZYGfPwGS563C3gwtWAaHvUFHKD6nfhSA3PgMwn0pWBteSPOjn41HH9uNQSvAZ
 U7fwXEnt+WXNc/8/6U77UmuU+WA18yHpVB+iDjxsh7d1JReMaaiCdUW4tHY2DOLQM387InLZgrd
 I0sWCO3FXmtb47oHneZFyAjm5IqvyIpmTEz9sYYns7wd0og0DHxmAqLwuxMQJvlpyow/kEbPnWa
 H0dYekx8Xlrs4DJe3rsLzxup5u3/EqFhew/bIm/7gSji4fW7pw5F81x/T/sScpRgA7l2ThpR4P+
 YD5k=
X-Received: by 2002:a05:620a:7102:b0:8c9:e989:9d93 with SMTP id
 af79cd13be357-8caf1307f55mr88390485a.61.1770329661417; 
 Thu, 05 Feb 2026 14:14:21 -0800 (PST)
X-Received: by 2002:a05:620a:7102:b0:8c9:e989:9d93 with SMTP id
 af79cd13be357-8caf1307f55mr88386985a.61.1770329660898; 
 Thu, 05 Feb 2026 14:14:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9fdfa05sm26255185a.46.2026.02.05.14.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:14:20 -0800 (PST)
Date: Thu, 5 Feb 2026 17:14:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 7/9] migration/options: Open code migrate_params_apply
Message-ID: <aYUWOl9_w_m-TIqL@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 02, 2026 at 07:40:59PM -0300, Fabiano Rosas wrote:
> Remove migrate_params_apply so the logic of setting migration
> parameters is all in one spot.
> 
> Suggested-by: Prasad Pandit <ppandit@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 180ebed51c..733aae51a8 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1266,25 +1266,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>      return true;
>  }
>  
> -static void migrate_params_apply(MigrationParameters *params)
> -{
> -    MigrationState *s = migrate_get_current();
> -    MigrationParameters *cur = &s->parameters;
> -
> -    migrate_tls_opts_free(cur);
> -    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
> -    qapi_free_strList(cur->cpr_exec_command);
> -
> -    /* mark all present, so they're all copied */
> -    migrate_mark_all_params_present(params);
> -    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
> -}

I actually like these smaller functions when their name can represent what
it does (so I read less but know what it is doing faster)..  But yeah if
both of you like to drop it, I'm OK.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


