Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E1EC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5IC-00060y-3F; Thu, 22 Feb 2024 04:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5I9-00060k-8p
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:22:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5I4-00028B-BI
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708593770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVsZscbCBZmdHksZO1pddkEO3JQCt8go1PJ2oOhmt6U=;
 b=QzBBu1eOQmcPJQAVm7JdOo/edrmI/nmFWlNsgPaofLVWgLgUeG7b+gOSt90oX+wECZ8DkL
 TVCJ8jwQEMF5Vngmb71rj7Da4biQ4r2nfNB6Rhxt+U4pNut5IzVPsAt8sLarYXulRfYVsE
 E+wQr53Xmp0LYyu+ckLUhhJoZzqx6XQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-Z2duMHxVMo-I6ypHqTRY8w-1; Thu, 22 Feb 2024 04:22:48 -0500
X-MC-Unique: Z2duMHxVMo-I6ypHqTRY8w-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1da0dd1dec4so27155955ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 01:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708593768; x=1709198568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVsZscbCBZmdHksZO1pddkEO3JQCt8go1PJ2oOhmt6U=;
 b=FHkBj1/WH/QG8bZuqIh6EiZSD09OhgQ6ydQnJw2vDQiTS+SPgydqtWuv1urUwMNHzt
 2X3pOOOkfrukqDqd13Y5JZv+Zf2LFyJF6V80GxIuxgXt+gg+z+NUEEr7l+c0H8cBFMT/
 JpAiky9xJZ3aFNyKQLUL9Y8qbybfJbn6LsGPIJXcvPsHaFqk3O/9ixNHXXk+3QsAJ6lN
 kPDGkPk8QFyqs+eU2u8Nx3yD20qB+mDCbgUPyqzPGf2Da8OQbq7Y9pbWbIqFAQi3a81w
 VOTyBDg/xm7LnaZc/gGS+E7havrbVanSFNy2bHnilaniLEUo36FmjtWS2IpdDUIfOduT
 D4Lg==
X-Gm-Message-State: AOJu0YwgYlDIIjRdY+1GsRfP1/BSq2UMM/cDw9yNIlEavQd1Tsez0GaP
 yquTEB5CDG9grGUmBvw17WurRZQrk3O840YVXGKhD9v/42SX5ONAeiQqsnOEgJ44Vg42YGAZ4al
 /WilzpS02SQ4dc4Z1thYLJ+1EJEqeGl3i68Q7xstJB/qm0Wv/5vjv
X-Received: by 2002:a17:902:b113:b0:1dc:e32:d0b7 with SMTP id
 q19-20020a170902b11300b001dc0e32d0b7mr8773552plr.0.1708593767915; 
 Thu, 22 Feb 2024 01:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXJlrGLAyNg7CTFYJLJkvNaNX8u+e6nfySE//IY8Thjd0gLIEVkHGwkRzWk29ZPlDMhspaSg==
X-Received: by 2002:a17:902:b113:b0:1dc:e32:d0b7 with SMTP id
 q19-20020a170902b11300b001dc0e32d0b7mr8773534plr.0.1708593767440; 
 Thu, 22 Feb 2024 01:22:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o7-20020a170902778700b001dc391cc28fsm2209959pll.121.2024.02.22.01.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 01:22:47 -0800 (PST)
Date: Thu, 22 Feb 2024 17:22:40 +0800
From: Peter Xu <peterx@redhat.com>
To: Roman Khapov <rkhapov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, yc-core@yandex-team.ru
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
Message-ID: <ZdcSYEtQe8M69Uza@x1n>
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru>
 <ZdQ7C5dHIQsTVQE8@x1n>
 <a804edf0-67d4-4752-b79f-c3e1ef3d72ff@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a804edf0-67d4-4752-b79f-c3e1ef3d72ff@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 21, 2024 at 06:47:47PM +0500, Roman Khapov wrote:
> If I understood you right, you suggest to improve migrate_generate_event to
> accept MigrationState* instead of int* state (which is pointing to field
> MigrationState.state in all usages), and get error reason from
> MigrationState.error, if the new state is MIGRATION_STATE_FAILED, is it?

migrate_generate_event() is a migration internal function, it can directly
reference s->error with error_mutex held.

> 
> That sounds reasonable, thanks!
> 
> But I'm not sure if I got the idea of changing migrate_set_error correctly,
> can you explain in more details, please?

I fat-fingered.. sorry.  I wanted to say migrate_set_state() below, and I
think migrate_set_state() can be kept untouched.

But please consider the other reviewer's comment first: if query-migrate
(or HMP "info migrate") works for you, then this interface is not needed.

> 
> On 2/20/24 10:39, Peter Xu wrote:
> > On Thu, Feb 15, 2024 at 05:27:58PM +0500, Roman Khapov wrote:
> > >       migrate_set_state(&mis->state, MIGRATION_STATUS_COLO,
> > > -                      MIGRATION_STATUS_COMPLETED);
> > > +                      MIGRATION_STATUS_COMPLETED, NULL);
> > Instead of enforcing migrate_set_error() to always pass an error, maybe we
> > can allow migrate_generate_event() to fetch s->error in FAILED state, if
> > that hint ever existed?
> > 
> -- 
> Best regards,
> Roman Khapov
> 

-- 
Peter Xu


