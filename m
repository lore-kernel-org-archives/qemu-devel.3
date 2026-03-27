Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD010ED67F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68l4-0001fD-0z; Fri, 27 Mar 2026 11:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w68l1-0001ef-Is
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w68kz-00029r-OS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774623951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxopLo/uHrZh5GEQn2IrFpzMVG3R1PprO9Psjl1nDn4=;
 b=hPFhx4SY6IxwnfGo+RZt5JsnlWlsp/mA5rawONcj+a6mwTKIGyYZxhNzmz9mPFUxM+/T8F
 cPWU2uqbWTP+I7LUPjHykBx/V6Au7OXMIUhzdGEQQEOkGcohxiflZ9fDiFWlELKVzIHyUI
 ZjdvYu9spB3U+fyE29njMetmiRu91j4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-YI9K0fsvN9CLCMPjeGC0UQ-1; Fri, 27 Mar 2026 11:05:50 -0400
X-MC-Unique: YI9K0fsvN9CLCMPjeGC0UQ-1
X-Mimecast-MFC-AGG-ID: YI9K0fsvN9CLCMPjeGC0UQ_1774623949
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6696f04b765so2408053a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774623949; x=1775228749; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PxopLo/uHrZh5GEQn2IrFpzMVG3R1PprO9Psjl1nDn4=;
 b=dbqHyOJPEk7Twbz9JEXc93EkAbBKLLcZYFQnps3zNCOWFJ1mmgXdneMHuq7MEFcw9h
 auDIuNMg8dkld5b/uR2d8I5pAOwV0U/FdPbB5mfWeHjsmRRNC84+LI0dvOPmUCs5Kt2s
 4zd6QGx9aSTkMaSc0WKSvU7tWj6EIQqKSig77HbMg1c05lCFA4bzVZt95XbvpPYajbFM
 PBlbgYlnHYAec9vPxWsa7zEvnkQjg1Pnud3aF8xXhOsCPmrEk5wWimnP/mXjq2R39xl3
 DGJ2oYHQS5XyEwvT4J9y6bOoqhxnBUBTY5MjrGyylRT6K4UfuvUnvteBG+q+NFie2Tua
 kgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623949; x=1775228749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxopLo/uHrZh5GEQn2IrFpzMVG3R1PprO9Psjl1nDn4=;
 b=hnpzT8HT6UiDK8LXz7duqKYfXcHeEomm64OmZ0Oox8v00h+tMvp1J3jJZnqumlH16g
 N7W9efkjkMNeJOIRJsBzgsgjCim1dJ2UCVxZZCP3gOCszpkRNyXp8T6BO5nIiyw9Hc4C
 ZR3ryw99wXfM1ag9bOQ+AabNqmDFpoSJR6oh9UzuZ9aBhs9gLRMu7gCDWgvDYiSSYBIB
 2pvCFH/xNfj4F1Qj03fUoz7MtAxCaAc1+0tyS7YJAveEb0eohHr8titrsVpfV/0OW0cT
 rAIO6ysNKF+xpxYPEBWz5W021ttGMjefbx+zQVRLZCSOiQxEMxEfq+kBgXBJbYAvxDMe
 NqSw==
X-Gm-Message-State: AOJu0Yx9jLMR7aY32Kn7Ip9L0Gan2YEFHKlgy0O3W/33t7WF0/fAeMiA
 FAciSBCqLec9qz1ZxioNGd6XFpEZrgUAdw4rPhS1+HaWVznwfmBEFC1LXICE44v5KvgxdCC9zGH
 QqOs4fXu4aQQdeEuQSIPGTdw4PSLFlupGQMk0R72XSdtITQjrfKgaP0A9
X-Gm-Gg: ATEYQzy14TZeW2qvGY5U5bQdmK2HlbgYk7AWi0suH+JM64dGldEeRAWdcxui1SnjqUl
 9yaYqZTkmaQqvihIQjPIFMspWxaUjF7chtWg0fzAN7a6M6uYnvKTlZo3awxmbRuk51Rx7MzHzRF
 xmoYx5nh9h8zc0IKoBLUT1d9Hn9uuRMwp8wviN6WMORS1kfCZASE155ubAOB5chPWxzpBJImJ2x
 vaxDyeBUYkVBlC+w756Xgs2nfiwkJ68N9YpeMVfztjN1VrkbXVgM53nSgmNb/uT192uBSm5Hujy
 KcESwss77UwhuUIJIV3HC1Killf2iUmwMQzU3jUQLmhSdGQpTwQr3pE4i3WgYoBIk+I5kUJiMix
 ttw==
X-Received: by 2002:a05:6402:1d4e:b0:667:9545:18b4 with SMTP id
 4fb4d7f45d1cf-66b284660e8mr1812671a12.12.1774623948971; 
 Fri, 27 Mar 2026 08:05:48 -0700 (PDT)
X-Received: by 2002:a05:6402:1d4e:b0:667:9545:18b4 with SMTP id
 4fb4d7f45d1cf-66b284660e8mr1812644a12.12.1774623947988; 
 Fri, 27 Mar 2026 08:05:47 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad5f3fc5esm2464929a12.10.2026.03.27.08.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:05:47 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:05:45 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH RFC 01/12] migration: Fix low possibility downtime
 violation
Message-ID: <acacudaIfnuozMAH@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-2-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-03-19 19:12, Peter Xu wrote:
> When QEMU queried the estimated version of pending data and thinks it's
> ready to converge, it'll send another accurate query to make sure of it.
> It is needed to make sure we collect the latest reports and that equation
> still holds true.
> 
> However we missed one tiny little difference here on "<" v.s. "<=" when
> comparing pending_size (A) to threshold_size (B)..
> 
> QEMU src only re-query if A<B, but will kickoff switchover if A<=B.
> 
> I think it means it is possible to happen if A (as an estimate only so far)
> accidentally equals to B, then re-query won't happen and switchover will
> proceed without considering new dirtied data.
> 
> It turns out it was an accident in my commit 7aaa1fc072 when refactoring
> the code around.  Fix this by using the same equation in both places.
> 
> Fixes: 7aaa1fc072 ("migration: Rewrite the migration complete detect logic")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58..dfc60372cf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3242,7 +3242,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>           * postcopy started, so ESTIMATE should always match with EXACT
>           * during postcopy phase.
>           */
> -        if (pending_size < s->threshold_size) {
> +        if (pending_size <= s->threshold_size) {
>              qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
>              pending_size = must_precopy + can_postcopy;
>              trace_migrate_pending_exact(pending_size, must_precopy,
> -- 
> 2.50.1
> 

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


