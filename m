Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4665FCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEF74-0000fW-UL; Wed, 29 Oct 2025 18:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEF72-0000fN-TQ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEF6r-0007To-R6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761778654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SdgkwiGaU8EFrj4Lkzku0YsGCZPUjxutDY7b057+EYA=;
 b=BKqwA5Tem7CmRXhjZw1LDY9P1iMArLoTvNGDK0e7R3QuFWxYfCa0qsIW0usCx6fKf61xPp
 ZNgymSrPUp5M3P+9FXNRWPL2kUgxZgBI7MuG9e6ijRXtd0cq4KPeyTUpKoVP5rbcKnWNbj
 9+ApjFmpcqUL8aW67g8gK65RDF1lKm0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-vurisJAzNsOj6feXpkYmSg-1; Wed, 29 Oct 2025 18:57:32 -0400
X-MC-Unique: vurisJAzNsOj6feXpkYmSg-1
X-Mimecast-MFC-AGG-ID: vurisJAzNsOj6feXpkYmSg_1761778652
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4e8a89c9750so9267691cf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 15:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761778652; x=1762383452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdgkwiGaU8EFrj4Lkzku0YsGCZPUjxutDY7b057+EYA=;
 b=aODkErLLHKPw3R41jIMZClfivnMr2NXdjZkDQdzOYacUTB2xheCFowG1rNfO675pEN
 wzb/djwSohGYjxiZ2FwFWhWS6ab8PktPZZPJtVvxpHgtQi6Aet0kIdZT9WP4cMxpSU6y
 XQP+AF7+ad6gM9uUxEWdus3C9oq8xljf3bpcIQI+xaIUeyIn+dI6VhKrTCNYMW0jgSyk
 uw5BNHVR+BUqACFir3mQeYOjvj4SvnoBfAtKJ8UUfTKBimjonJph9fd5fkuVGLoy0cM0
 yyXzpcMc5OOGqSwQWc+OP71E4DkU2JFCCU3jKCwkzMfp4jG81NiwmL5excs2sm2crl05
 d8EQ==
X-Gm-Message-State: AOJu0YyxSe9mbLLaTzEabxVIBnqEm1owczBVr0lTe/II7OC9ppbIcjmv
 PqOjVOab4FVWm6500bZzdqXL+yVoevneCuXT1QpTv8xuJ+Yf5DhLBHXke7t1FMYV5xdgMz9sXED
 8WRhqLAORW8X/1KR7CyvV+xkJtKx1HsqUelY6MbnwxzD7ygUefnQJ4Eql
X-Gm-Gg: ASbGncv4wElnR66D+OzpDuspSgYUwpRK+JJGvl68tcQ58SUHApU/J+gsefoG+z6fPhn
 Khe9BUHet31ahg15WNqI82lkcmroYZD+rEjqUFE0UpzeDmlfzJSzSdTbUxD3Gb48VtMl8Be9qtP
 7HkcsfgrFh8pG5ZgIv5LB/NbGMvJ24I7iCvXnTNUw2/GWd7SEy7Ulx7qTRQPFFt3T42ujWsBU6o
 rllrdJkMsQC9qGpNyczWKkgZnLxU4Si28GuemNpuz+meu3Z3A809DPN+qy0EQmPfdIXs0etOd25
 uwYz4vMJpSChNJrD+/EYIfk2fk8jf0zTdy628p4W0ZawMiPLgTqtvAEJ8GnkdgVXB7M=
X-Received: by 2002:a05:622a:2993:b0:4eb:77f5:394c with SMTP id
 d75a77b69052e-4ed15c19907mr64838601cf.48.1761778652019; 
 Wed, 29 Oct 2025 15:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqbujT7U+iHWKMr5L2HO3BsIaL1B8N/CljnWLEa1u8ThODLplyLww6ljufpZJftuhmfkO6eA==
X-Received: by 2002:a05:622a:2993:b0:4eb:77f5:394c with SMTP id
 d75a77b69052e-4ed15c19907mr64838351cf.48.1761778651611; 
 Wed, 29 Oct 2025 15:57:31 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba384086csm100938601cf.26.2025.10.29.15.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 15:57:30 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:57:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aQKb2BSvMBNKrbXZ@x1.local>
References: <20251027154115.4138677-1-jmarcin@redhat.com>
 <20251027154115.4138677-5-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027154115.4138677-5-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Oct 27, 2025 at 04:41:11PM +0100, Juraj Marcin wrote:

[...]

> @@ -1752,6 +1756,7 @@ bool migration_in_postcopy(void)
>      MigrationState *s = migrate_get_current();
>  
>      switch (s->state) {
> +    case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
> @@ -1853,6 +1858,8 @@ int migrate_init(MigrationState *s, Error **errp)
>      memset(&mig_stats, 0, sizeof(mig_stats));
>      migration_reset_vfio_bytes_transferred();
>  
> +    s->postcopy_package_loaded = false;

Better reset postcopy_package_loaded_event (in case of continuous
postcopy-device failures)?

Other than that, looks all good, thanks!

Reviewed-by: Peter Xu <peterx@redhat.com>

> +
>      return 0;
>  }

-- 
Peter Xu


