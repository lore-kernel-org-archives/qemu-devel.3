Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6107B10A88FC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pH3-0006AC-ER; Thu, 26 Mar 2026 14:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5pGy-00069A-BN
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5pGw-0002x1-K0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774549052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IjmdZskmdj1/NAgge2xRFcfaj0TpXbjA61xYB0KBTa0=;
 b=RNJeXk4vwYQHnsqpobWIztvNGaR5aPASM5+6vva6ZaOrjTwAzc67ikfl67K0ltvbS1o2J4
 UKKg1CKrz6MkwdKKTW67zTmwmDcPTwgyP8xD/I82urWcV4lTNymjnnfRtowy2C/bPMcEhM
 NAVKdsta5IosnCssY7vPhfvqG63WJko=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-dgBzZS_VMVKjl9GUYIciWg-1; Thu, 26 Mar 2026 14:17:30 -0400
X-MC-Unique: dgBzZS_VMVKjl9GUYIciWg-1
X-Mimecast-MFC-AGG-ID: dgBzZS_VMVKjl9GUYIciWg_1774549050
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89ce5eec0f0so5140816d6.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774549050; x=1775153850; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IjmdZskmdj1/NAgge2xRFcfaj0TpXbjA61xYB0KBTa0=;
 b=rCzaXbJ58v5xot9/Yn08qDUbqnzyEdqKn6bNqY/Uyi5rGPqexijaB03KjDvrLlfv6A
 7Wa57ZNrSi9G9eixjDxPg1BRAtOUp3VzrwjK81Ky72pPhuh+gVlDPGQuxLFgneCG3Gxb
 tkHMXrEJqo44GjEI+cZIZEJTPYYTc6M0+0Nsn7cwA/sdYZAI4MIIMq2K+NXLwDHHkmUt
 YL498f2/0dI68PSRaUr33IcIOX30JNmh2RTGxMwNjbJLFqbkwI0lTiefGDKuK8ntCfRt
 70cCPAsAD0NSXkuYckHcL017qRASMmnr9deuvZC6hSED54JIFasEwFQ1B/44TzPYdM3x
 KDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549050; x=1775153850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjmdZskmdj1/NAgge2xRFcfaj0TpXbjA61xYB0KBTa0=;
 b=M4kExVUjTIBOA+NeJ8IeGXU5TUhN+7h+duZxoRBJd9irjVL+cm44wei0ZvxgPYzKLp
 mS7BX5c+GQHI6O2ecMgbuzLB7RzNS0t/IS1a5SfnG9wcMx7N6DAdqI4MtyNFgf/dpttb
 Bn1cJeRreyonvuoanD3PB3S3dxR47Wr5f1cMGajS+mE+GfcFAn8iiZzSnQ3mjblSVuVm
 RW4HxMYeZYxfxTb4KF/TdX76OjNm7wHaoIgV85igEeA+X33stAy8NHT8mLDWeCL1P8ic
 /PET5O5nQgBgmRL1FyIR45mJbfCO1Znfw2DF/NO498ZEeUajfvcTyekVSpc7U7UkGJY8
 hxUA==
X-Gm-Message-State: AOJu0Yythp3zqiiefUT/oAUweEKIkilI51+YzP5VFzW+6ikR2wKLutks
 D9gUtZyz30Cq7o6+sURjU3BFxAdPt0PQ+w4PX/5q/a7KTRdACIGysULKiJ9ilDQ8GbIVZKdNC8u
 6d2d3I7DVeGnVLSfDawvdLu1aprO1Lj/jc5YAnCaLBvPrEqMVs3+RzGKa
X-Gm-Gg: ATEYQzyzqDyP0ym/gNLT7iQLCK0ev7iW/Efa9e56KyXZz2jDAJ28BIRAxlptZQ6IMsp
 iArzziYbyPkk4zHhUChV3Tf57lCz/r/2sZ+l80n+tkYVtkp0YkJ+OH/f7cjVte//UOG148FPQsD
 A3/mBjtvGyIbOnrv/PEk3W6isjHkjwVP/6Z6BpkrY8+Ud33v9Y6bIRbWLL1Dj4H0bNbz0HXOLF9
 IGIh3f5lqDTa/NEuwYncExTolpqphKQdN72qcditTVQ5e0qoTk7C90yOkkIzw1xxWoi1OnJ0AoA
 sn0QWznkLfFYihScA1NAKfZN/Q7QaXxXCWGw09ldROo4/4Qk4z4wZPUDxlpRNqueDAq7ElbGfb6
 hTYaOTBUn1gEnRw==
X-Received: by 2002:a05:6214:5d0c:b0:89c:d931:62ee with SMTP id
 6a1803df08f44-89cd9316facmr51248276d6.34.1774549049855; 
 Thu, 26 Mar 2026 11:17:29 -0700 (PDT)
X-Received: by 2002:a05:6214:5d0c:b0:89c:d931:62ee with SMTP id
 6a1803df08f44-89cd9316facmr51247786d6.34.1774549049215; 
 Thu, 26 Mar 2026 11:17:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89cd589a25csm30479096d6.15.2026.03.26.11.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:17:28 -0700 (PDT)
Date: Thu, 26 Mar 2026 14:17:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix slow test dirty_limit
Message-ID: <acV4N7ENkELzx5V9@x1.local>
References: <20260326164405.1626-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326164405.1626-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Mar 26, 2026 at 01:44:05PM -0300, Fabiano Rosas wrote:
> After the referenced commit, the incoming side doesn't exit
> automatically after a failure. Tests that expect the destination to
> fail should use -incoming defer, issue QMP migrate-incoming, wait for
> the failure event and issue QMP quit.
> 
> Fix the dirty_limit test which wasn't updated properly.
> 
> Fixes: 4e8c4dda97 ("tests/qtest/migration: Force exit-on-error=false")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Highly likely I missed something, but could you remind me what is the
problem before the change, and why "defer" fixes it?

The current failure path in this test is:

    /* Now cancel migrate and wait for dirty limit throttle switch off */
    migrate_cancel(from);
    wait_for_migration_status(from, "cancelled", NULL);

    /* destination always fails after cancel */
    migration_event_wait(to, "failed");
    qtest_set_expected_status(to, EXIT_FAILURE);
    qtest_quit(to);

It waits for "failed", so IIUC after switching to exit-on-error it'll make
sure things got gracefully shutdown before qtest_quit().  So I'm a bit lost
on what we're fixing.

PS: a nitpick is if we could always attach a "Link:" to the commit message,
it might help a bit on knowing the original report too.

> ---
>  tests/qtest/migration/precopy-tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index c6c8ae3004..a0e3ff0547 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -1070,11 +1070,10 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
>      args->start.hide_stderr = true;
>      args->start.use_dirty_ring = true;
>  
> -    args->listen_uri = uri;
>      args->connect_uri = uri;
>  
>      /* Start src, dst vm */
> -    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> +    if (migrate_start(&from, &to, "defer", &args->start)) {
>          return;
>      }
>  
> @@ -1082,6 +1081,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
>      migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
>  
>      /* Start migrate */
> +    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
>      migrate_qmp(from, to, args->connect_uri, NULL, "{}");
>  
>      /* Wait for dirty limit throttle begin */
> -- 
> 2.51.0
> 

-- 
Peter Xu


