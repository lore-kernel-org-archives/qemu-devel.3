Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E300DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjYX-00032G-UP; Wed, 05 Nov 2025 14:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGjYW-000325-Ld
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGjYU-0008Lu-Ig
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762372348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xT31G+VtBwjotY7JhJBcOLI2zPc5gCVMHjIcDcGeHpY=;
 b=WiyT2ROa0OQFcDIf6YKRl/Rj4YYVjUpwKF0P52dGUIRAF0OC0wLZbvXTAtdZc1ogrnEGRq
 L68VLIh1jrVO5k8lyIZTXd9QcDCl/cYoC3fqILH1ApYqw/VWw+S/xrz+GPSH+wBcq3pfS4
 GvHyjEEP6YYWco3UsZn9ESRA9GjZ+SM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-4YdKilMSPDiVjdJ0YVuvsg-1; Wed, 05 Nov 2025 14:52:27 -0500
X-MC-Unique: 4YdKilMSPDiVjdJ0YVuvsg-1
X-Mimecast-MFC-AGG-ID: 4YdKilMSPDiVjdJ0YVuvsg_1762372347
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b228c484d8so55962085a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 11:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762372347; x=1762977147; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xT31G+VtBwjotY7JhJBcOLI2zPc5gCVMHjIcDcGeHpY=;
 b=opUKNsY+NjZ3tPQDWtrLnrRw2rBWFW0xGPEC8DasGeeQ5f/MtkuSRk4N+TaFVX+0I0
 HgV39sR0yD765Lri+L2R5LQnZ2s6bmQD9qBznwFs6VBvUbqpn3VkHDRbhx3DYBiZUoii
 4iGTBJqttfXaqIYAG23rSXDZJLrciyxuGzO/M3eLrpncq6StGJL2AH09lNIwFm6U7BHA
 efD77vvaSAP7ghbJ8aqJn/4MsqmXqItjGOvr17u6GBNV85AK3rcv3L0XVkaWSE11eNcQ
 /xBsXvEC/SeOP5bIOpmFwpmtHDiM3esMTdVBQCXserOUsxXsRMuNGJG/XDqvf8bUgGgr
 MvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762372347; x=1762977147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xT31G+VtBwjotY7JhJBcOLI2zPc5gCVMHjIcDcGeHpY=;
 b=oTOUgwgUorZairdu6tTEKO3krVkyNmpu21B9U8bvq66fJ3iIkMsA/QRh7rdQoNaSKg
 tqOda7KBKgUK/RiVQoxfe7KNfJgFx44zNUDQrOoWxNbVUHaiscmW2cbHXTnvmLGGZ+41
 LfRx43pHdgdk45YZz5wlpFCwQJvsoYto5hgSyaCSiv/EAHWiBCxg5OruaNEoXIaun6fg
 tA+p/SXZ0DGpS5SXiaBdxwPVJ+7S76tPWO/o2l+Kd3ke38ENUveQSGw1IorFdJYnBzQ5
 UtM/lYuLjP7w+hYUFwRQkVwkDcCa1iEcLKBKbn8HXbi75t4HDKrghgP9XOnINn6Um0iZ
 nnHw==
X-Gm-Message-State: AOJu0YzSROQ7q9t4esgSUFAEdzAFMyOQ9KKyxsVpUaSy8gi5wjEgAeJh
 KH/ftFLayRT4E9oLeJnNDn+joO0ZWzEH5QFO7q0RbnKWKrklx1b15GG0YK23GelUA1tRqj/ZaNg
 o+mqVmw54/MvY1QP+SZXs2PizGGiMKnny5CEkmVHWhzZyTCv9IM2oAeEhF1W/vqYH
X-Gm-Gg: ASbGncsDkkDkjDM5WREVqMH3pQwBMF5//scmoLwwlQWew9F9r8hD6APRShL2za9sBNH
 Qjr6agIbiKhBGlOwyRVn/no673DmTT8UoK/p7xnq/RNAiKYZ1kYud7Vz23uGCIcKw8hRUPuBuKu
 bBwHegrZwjMrv6iD2mlO7S/sqaG4ElHDfESLmLBFjm8HvMntmiK9156avRYXGKwVvuRnSu2qDTc
 4rQUn3dMs0MAuw0ipmbviX/QBb6n6o41FpOwfw7LE15IWlnnG66z3g2+g942rtmPZ/yRKAGuMtJ
 AQwDPhp2Zgi3kSvm1o+kltaEPNu1nXO+nYfr4Zx8xRSlSIPaLo+eTMtgqiEnP+o33GI=
X-Received: by 2002:a05:620a:3947:b0:8a9:135e:d2e0 with SMTP id
 af79cd13be357-8b220ac0750mr609913485a.41.1762372346786; 
 Wed, 05 Nov 2025 11:52:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcqdFnCqOPQArsjorNlOXQxEYj9UZaJ1JZcife3w05eEJ79Kbon3tiQHkacsgGebFQwQYSSw==
X-Received: by 2002:a05:620a:3947:b0:8a9:135e:d2e0 with SMTP id
 af79cd13be357-8b220ac0750mr609909885a.41.1762372346245; 
 Wed, 05 Nov 2025 11:52:26 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2358224d2sm30661785a.49.2025.11.05.11.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:52:25 -0800 (PST)
Date: Wed, 5 Nov 2025 14:52:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] tests/migration-test: Check error-desc after pre-switch
 cancel tests
Message-ID: <aQuq-ONNdEEJKmId@x1.local>
References: <20251031164956.3409661-1-peterx@redhat.com>
 <4r5wbhkkk346usjdgvnc3epcom3he3y547p3smxbkvvnk677tz@e4hsizwn5sfp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4r5wbhkkk346usjdgvnc3epcom3he3y547p3smxbkvvnk677tz@e4hsizwn5sfp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

On Tue, Nov 04, 2025 at 01:35:53PM +0100, Juraj Marcin wrote:
> Hi Peter,
> 
> On 2025-10-31 12:49, Peter Xu wrote:
> > error-desc should present on dest QEMU after migration failed on dest when
> > exit-on-error is set to FALSE.  Check the error message.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration/precopy-tests.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> > index 57ca623de5..5f02e35324 100644
> > --- a/tests/qtest/migration/precopy-tests.c
> > +++ b/tests/qtest/migration/precopy-tests.c
> > @@ -759,6 +759,14 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
> >      wait_for_migration_complete(to);
> >  }
> >  
> > +static void assert_migration_error(QTestState *vm)
> > +{
> > +    QDict *rep = migrate_query(vm);
> > +
> > +    g_assert(qdict_get_str(rep, "error-desc"));
> 
> I think it would be beneficial to also check if there even is
> "error-desc". That way if the "error-desc" is missing, it fails on
> assert with SIGABRT instead of SIGSEGV inside qdict_get_str().

IMHO it doesn't matter on how the test would crash.

> 
> With this change you can add my:
> 
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

I would go ahead and merge a test patch if it had both lines, definitely
not a huge deal.

However strictly speaking, qdict_get_str() is actually pretty efficient to
make sure both that exists && is_string when used in testings. Would you
agree?

I definitely still want your R-b one way or another!

> 
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 5f02e35324..87e33b8965 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -763,6 +763,7 @@ static void assert_migration_error(QTestState *vm)
>  {
>      QDict *rep = migrate_query(vm);
> 
> +    g_assert(qdict_get(rep, "error-desc"));
>      g_assert(qdict_get_str(rep, "error-desc"));
>      qobject_unref(rep);
>  }
> 
> 
> > +    qobject_unref(rep);
> > +}
> > +
> >  static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
> >                                             const char *uri, const char *phase)
> >  {
> > @@ -784,6 +792,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
> >  
> >      wait_for_migration_status(to, "failed",
> >                                (const char * []) { "completed", NULL });
> > +    assert_migration_error(to);
> >  }
> >  
> >  static void test_cancel_src_after_status(void *opaque)
> > -- 
> > 2.50.1
> > 
> 

-- 
Peter Xu


