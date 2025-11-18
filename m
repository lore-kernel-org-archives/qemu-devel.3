Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFFBCEDD98
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 20:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLSYs-0004a3-Ej; Tue, 18 Nov 2025 15:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLSYq-0004Zh-Iw
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLSYo-0004F3-Jw
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 15:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763498660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHqv7BsW/MIyirWs5IOYx1z6yVOcYy36JAsSU6/5S1o=;
 b=ViVmMKbJN7+OsgrFUChxFm6kbmNyJl78AkzajZ7eNwLTwI+iHYQVPqtb+iew//lC5pR92L
 YK/XoeL4THidkyZFvLJG1Va29FEWLilhbV/RI2lYVW/WrI4a5M/R7q76qMbNUgZRX4B7IW
 iecBgpZlxy7qoPoiv0KqOG+/loCN+HQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-SrhXhgJ9M3eR5XIB8oofHQ-1; Tue, 18 Nov 2025 15:44:19 -0500
X-MC-Unique: SrhXhgJ9M3eR5XIB8oofHQ-1
X-Mimecast-MFC-AGG-ID: SrhXhgJ9M3eR5XIB8oofHQ_1763498659
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ee19028ae6so36631421cf.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 12:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763498658; x=1764103458; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AHqv7BsW/MIyirWs5IOYx1z6yVOcYy36JAsSU6/5S1o=;
 b=N4vW9nJAgZNO/NwDcLUAJOK1DZ6VpVvmq+KOQnjzH4kI3NXXkbpjRdw2E8kXvjrebN
 tp6HLIsNazQGgbTVzTE7+/VoQDAl+XaGxw5fh/4/S3v/HJDDQO3xBKdnHCPy2l74Qvoq
 5w4ZockdB+nQodb3adIFefruI3jgmh/FdpxdB4gN3b7xx9cfX+bPT3RypqgqcrR8PsuW
 4r5DsIRCZrDMe7sFIgEwcSd5d5nS7ub6yIrRdHX+XYL2aFIVxxXGQvpJMK1KfrCjF7tt
 gBguC7J4AjegievHr58+mrbBqyGn6F98Tll21+XmRDN1acAeniQZ2p6XMuQg6j2/vkEv
 SEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763498658; x=1764103458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHqv7BsW/MIyirWs5IOYx1z6yVOcYy36JAsSU6/5S1o=;
 b=Zlp0aVQQd11vobhK8EEFq3Aw08/yOt9qLBj6BPeVfwt+ZtgPN3b1SUR8VBYWYRNV4t
 nCqK0ApVgyks8+c77q9V45f5rOBcStv02cr46D9x79MORf3gVn34iEGjOYbf8p/TtEca
 eapJ1xJtZJtrIxLb2PsSAXDBrv1GvQDOh5oGb1etQpuBWCOttZwY0d+rBLJo2S38OHxR
 EOL4FXLuwsHvR/rqvCT+FzIirUsZtFyT35I3DLtEZw5QWowqYgohIOZOJGQIwYeLtiMg
 xYWBndN6hJMeDLFr1/S9zb2sxGG0O1yUMJYt30xr+95YX+4nOSf/w+926ONOXCJjUs7E
 i8dQ==
X-Gm-Message-State: AOJu0Yw4ph9F0xv5QV6Fnrozr4I7i5tviEeMW+m154G7s0nXofaAhCmo
 NAY73/l34wWxwgVQthGteow2NmN9i4wRimYjnYtEr8+KFOl0KY4z/+kd3vsCJ4NoHZ7QNB9C1Wc
 4DLKaYtfeXYZ71I7RGsiVKwnGmHRnslcnKuOgHE7Ve+CBm4zw+2d+owYGiyxV+EQIECebe+r5jh
 qvfNPxN+D9Zi3M2RGvhU2uT3DgB0y+e1xoetGUCw==
X-Gm-Gg: ASbGnctiXcyX1RzMKtAZhC9CM5I7pwArFg97uhory//l91gx7QsSIiC9FPaWNLR3Ge/
 Tba2nLEnBUjiwtHRjBTpJsLmIQZlNG3hO21Gx4iJzulRi8vOF4XBqUB3VH1Dawa/7zr9d1KF4E9
 Fc0KArQ/PuNUw8ZWIGREpM2wPu+NAk1Pm3tz08fwTM6YsbKGuM6+PCU9AyBjfM7TH7+NmMYkCBg
 30bbagoe3EOnyObkjiHU1oBw9e8qSH7UjjC366kfP25NTIeF66OYGfTZ+xUlKIlGOOaECXIt/HM
 PQ3RAnPegh/y6zXwUO0nhfQqJEp2e9OslR3dCgTLUzQPg8mpUCsW8nuiHgsxdZB/AwuwwGDr6ZK
 /vQ==
X-Received: by 2002:a05:622a:12:b0:4ed:b47d:8f68 with SMTP id
 d75a77b69052e-4edf20463admr217460301cf.15.1763498658256; 
 Tue, 18 Nov 2025 12:44:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiZbSN5m5YecCN1JmZBnF0zE18BUjBZeywcpH0wjhTpqrXFyWSpxN1yJP7q4AfUHbQD9RwKg==
X-Received: by 2002:a05:622a:12:b0:4ed:b47d:8f68 with SMTP id
 d75a77b69052e-4edf20463admr217459901cf.15.1763498657670; 
 Tue, 18 Nov 2025 12:44:17 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee16389879sm67640491cf.24.2025.11.18.12.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 12:44:17 -0800 (PST)
Date: Tue, 18 Nov 2025 15:44:15 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] tests/migration-test: Check error-desc after pre-switch
 cancel tests
Message-ID: <aRzanwndYP4NJVt5@x1.local>
References: <20251031164956.3409661-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031164956.3409661-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 31, 2025 at 12:49:56PM -0400, Peter Xu wrote:
> error-desc should present on dest QEMU after migration failed on dest when
> exit-on-error is set to FALSE.  Check the error message.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/precopy-tests.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 57ca623de5..5f02e35324 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -759,6 +759,14 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
>      wait_for_migration_complete(to);
>  }
>  
> +static void assert_migration_error(QTestState *vm)
> +{
> +    QDict *rep = migrate_query(vm);
> +
> +    g_assert(qdict_get_str(rep, "error-desc"));
> +    qobject_unref(rep);
> +}
> +
>  static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
>                                             const char *uri, const char *phase)
>  {
> @@ -784,6 +792,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
>  
>      wait_for_migration_status(to, "failed",
>                                (const char * []) { "completed", NULL });
> +    assert_migration_error(to);

While I was running more tests I found this assertion might still trigger
but only randomly.  I think it might be caused by some migration failure
path not setting the error string even if it'll fail the migration.  I'll
unqueuing this one for now and put this into backlog as of now..

-- 
Peter Xu


