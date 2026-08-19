Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1789C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlQH-00059d-2W; Wed, 19 Aug 2026 14:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlQF-00057Z-7q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlQD-0007Lh-6g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787165635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6nyZDsKze7nixc5V2tki8I7wSHzFraR5EOj3ozViWDQ=;
 b=Hd+TEbkf/gYai8xdeni7TceKcwpOjpaoPTkMMO9rQuwWdCxyABK8UgNqcSdjPGqXavZFJT
 0QdDbfsE5EYCyBa4xVW5Hbo/jzr1VDKCNURtOWRvHucX5QgIrenewyElPE/jhUPCrYU7OE
 Uy49BorQcF5ELzcWomOLKdcvtEoqISE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-U_aNtXqXMJq0n8UioT6pNg-1; Wed, 19 Aug 2026 14:53:53 -0400
X-MC-Unique: U_aNtXqXMJq0n8UioT6pNg-1
X-Mimecast-MFC-AGG-ID: U_aNtXqXMJq0n8UioT6pNg_1787165633
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so147308285a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787165633; x=1787770433; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6nyZDsKze7nixc5V2tki8I7wSHzFraR5EOj3ozViWDQ=;
 b=bi7/6UKx+UfTXAdpZCfcN3LR+CL8/HLR7XlWuDpJeN04acdxsv1IgRvMMMAWUsiB6p
 uYx1WAC9agAXCicnB/Y19tUVZ+O7FW58i3qMDNMK8qKH2+1b23wmkLIh0bWopW92eCB3
 BV9kS9/grp8gZy2k+6DRoTUMvmEGs1ywD6RXkNlV4DFL//EThEQ0tXffXrP6lzMyL/hb
 0opMYHkmsXeHsfFicUqwMQkaED6tq+WeY3NvBbfaWntwm/Cwev9dgqBP0t2blNSRlrmS
 PPUEILjW369nIWWqM3elFO9i63hxbKCaFUApRf4tF2prPGN6N8+b8JlmdZXeMAXf0p2W
 E05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165633; x=1787770433;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6nyZDsKze7nixc5V2tki8I7wSHzFraR5EOj3ozViWDQ=;
 b=YP2wf2NXHSnKog2BAs0zPtF897u1k5jQipjy9zbqRXBNWXNK6qTOYO+1ZPZNHGMXIK
 dt9XaCtjGMiPpMw26ouALJID9IAEb4mzffBE6lwS0iaegM/QS/DW0lWCEA9cMKGhceVT
 SqT3GY9gqcPJGMUR2m1seqjdl4h5IArPwsUUJRtXRqVs2WqxNQ/qupeSMQWfZ0nnlPjW
 xgoxE14M9JZ9vH7l3a6VRps0uR7UpGGWRHLeYKf2FsgAZpgHje7+nkdSVw/tvva0SbHK
 PwliHxfPAO9HKt9Rl6OhL9JMIEHmKbmTpSN4EhdFtqB3bhiqEXaFG4/T2I9FoSvm0olF
 F99Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RocJcKxNn7o4kmhjnnJrExrtvSu9ieojh+5B/1qKICszI2OgNGz26QvmS2LaNnrMurjD5IT91cnXjco@nongnu.org
X-Gm-Message-State: AOJu0Yx/l894cIEN7JBIcZxJ+8/83nEE4wQlCPrQb8SZnplvq89+aHdD
 hD60SK/tvairApAWo+pqaO3ikg4T7cd9ebEcAbn4JWDPTXnHZ9Q5ycRJYRofsuI5RnJpYDzQw49
 mPOJkFsMZwThAY6x3B8q6qBbIJbnH4yiSFXPveFgw0Y657Wrzr8s7yDQ8
X-Gm-Gg: AR+sD12H8P6BikPnjCZqo+utHfof0S7yLEW59WJmZPeoyjT9y/dURFLfC+2fW5rNkXw
 TnhFHyJjMcAGEkvY4Aq/4wpVNQAmB5Wv1VXLc0Jsh6S5DArgm8tS95lhmr/7FVbyvI3ku41SVJF
 eWvgQxFUbbE6oKyjCcRHrLJULiQdPLVgW0IkcM3Pbvu26cGD0nhg1Zx8BmPGRSjWD5P2mHmjY+v
 dc13PFKdJ8fTm8LZNRyAGRBK4WBQAbl6b2RdGHfv4fBgo/9ZqjzB+xttcBZe8GGHCYHTARfrtYP
 pu79JjaSJ4Qd5kdhHBykQnOdr5c0vnPu+3psaO4q92hwhwy3ngAdToIuElqMRF2RCVBK
X-Received: by 2002:a05:620a:4728:b0:92e:59b0:df08 with SMTP id
 af79cd13be357-9371e20514amr625199985a.3.1787165632623; 
 Wed, 19 Aug 2026 11:53:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:92e:59b0:df08 with SMTP id
 af79cd13be357-9371e20514amr625193685a.3.1787165631966; 
 Wed, 19 Aug 2026 11:53:51 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720493f40sm200686985a.1.2026.08.19.11.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:53:51 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:53:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v21 10/16] migration/fd: fix fd leak when fd is not valid
 for migration
Message-ID: <aoX7vDHFIB9PHvsf@x1.local>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
 <20260819180201.1970193-11-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819180201.1970193-11-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 19, 2026 at 09:01:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Both fd_connect_outgoing() and fd_connect_incoming() own the file
> descriptor after resolving it from the monitor, but forget to close
> it when migration_fd_valid() check fails.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Oops.. thanks for fixing.

Reviewed-by: Peter Xu <peterx@redhat.com>

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: f1fcc1c101 ("migration: Remove fd: support on files")

> ---
>  migration/fd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/fd.c b/migration/fd.c
> index f05f95992f8..02b39b150eb 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -62,6 +62,7 @@ QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
>      if (!migration_fd_valid(fd)) {
>          error_setg(errp, "fd: migration to a file is not supported."
>                     " Use file: instead.");
> +        close(fd);
>          goto out;
>      }
>  
> @@ -97,6 +98,7 @@ void fd_connect_incoming(const char *fdname, Error **errp)
>      if (!migration_fd_valid(fd)) {
>          error_setg(errp, "fd: migration to a file is not supported."
>                     " Use file: instead.");
> +        close(fd);
>          return;
>      }
>  
> -- 
> 2.43.0
> 

-- 
Peter Xu


