Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624ECC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGTU-0007GK-N0; Tue, 21 Jan 2025 10:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taGTS-0007Fd-Cr
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:47:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taGTQ-0000Yl-J4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737474446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pua/xHaxlZNyBjM1rG1Z4O+pGX8GF2uIul3GOSxD72s=;
 b=D5CgMvGkHdOzIjsLrJXdA30x+QI+xnSeeA8HyVNPMTR18NaxShCbWtjHUzYYhfhnh+6jLt
 CI8FYpGpXlbWZLeNBTXpc0fT91t6vVcyAxTSTP+q8ntAxhPzgHLan5CRJgkdT9t0IoI5nc
 T7eNSoiu11CFcyngodQX+j0cM5vYgJk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pIYdQT5IMsmHosgk9GLGjg-1; Tue, 21 Jan 2025 10:47:23 -0500
X-MC-Unique: pIYdQT5IMsmHosgk9GLGjg-1
X-Mimecast-MFC-AGG-ID: pIYdQT5IMsmHosgk9GLGjg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e9fb0436so1739917285a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474442; x=1738079242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pua/xHaxlZNyBjM1rG1Z4O+pGX8GF2uIul3GOSxD72s=;
 b=Ecjq00SxsseDpxf8F4RiiobDJX8lsv8c3LcJ50xHXlBOfRTHAseuM2OatM54bMoayY
 35WCq0Y0biEiV9UWfwaQcS+WPkRju1ZjUfU5sBjkmAHwGWEDx5y7GwiU4/tIU0baUaLp
 V8DNt3SZNvEzk9PkpkXSdqXihtCC4Gsrrco0RxienzJXCQbJhIjZt5DtTstzuWwkfAMa
 PkksrCBVKDoyve5TrS25GloOvrmqpgrhUJInBPaw7ujha9WAhNk0QLsJIR6HGfAOfCCi
 ZKPNI2RAB7SPdYRmRivYL/WHcwfFOigyDZiv808oyrOWMcosH0TydL8fuRKP0f84EiSy
 i7sA==
X-Gm-Message-State: AOJu0YwJ1Ql/6Na5sWFMyq/6CTisxDuaV3UCuH+QK+GnAJXGjt7BQDmq
 +yMLivJR/nP1z9VpPND4T5/LfC3iMv9qt6BqV/yYCzvf/wBTSPn0g3Qok/1cgtf9V0G6mak7Xll
 t53kmcZuveGlLi18f7WyZksNqGzbBBZ8kklB0xJ9izZp1Z7bT8IY+
X-Gm-Gg: ASbGncs31Bs/mDwL5HvC4y4B9cnI0xG9GM8h+RjZa2+BfDXiQCdTvgDfNV46Vk7YPI2
 dyOmZXd+PbzWf1mtQAedvkhfqeq1AM37n3VQNeCcyE5r37X2PicmtjXuqjJLpSBG2QZP3s3HRLh
 eZogG41aVzRPYA83iSNOTYye6D+fwELo6wH73yVmOr+nHUPdGhuNM5tyv3yYt1NFcpPK+lLOSdc
 NUef0pWUiVx7+pROmsZjUAZ9stCrVT2MURVU9RYN3awb6axgB8Qs1rcszTG+0id80WdCGP1fzOZ
 zAWEIHggxutYVWIlXuUZFmraaEGHuhk=
X-Received: by 2002:a05:620a:24c8:b0:7b6:eab3:cdd1 with SMTP id
 af79cd13be357-7be6325dc77mr3291818585a.49.1737474442678; 
 Tue, 21 Jan 2025 07:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN/uHodmUD9eeR+l2N4GC3CN0LIfUJWK8f7cfNze6QZYHDJHQ283N2jI6Ek1fc0atfzVtmWQ==
X-Received: by 2002:a05:620a:24c8:b0:7b6:eab3:cdd1 with SMTP id
 af79cd13be357-7be6325dc77mr3291816285a.49.1737474442415; 
 Tue, 21 Jan 2025 07:47:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be6148055bsm567396985a.43.2025.01.21.07.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 07:47:21 -0800 (PST)
Date: Tue, 21 Jan 2025 10:47:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
Message-ID: <Z4_Bh3ytv9REBero@x1n>
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121131032.1611245-5-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 21, 2025 at 06:40:32PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add a new postcopy test 'migration/postcopy/multifd'
> to run postcopy migration with multifd channels enabled.
> Add a boolean field 'multifd' to the MigrateCommon struct.
> It helps to enable multifd channels.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  tests/qtest/migration/framework.c      |  8 ++++++++
>  tests/qtest/migration/framework.h      |  3 +++
>  tests/qtest/migration/postcopy-tests.c | 10 ++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 4550cda129..7f5abd760e 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -427,6 +427,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>          migrate_set_capability(to, "postcopy-preempt", true);
>      }
>  
> +    if (args->multifd) {
> +        migrate_set_capability(from, "multifd", true);
> +        migrate_set_capability(to, "multifd", true);
> +
> +        migrate_set_parameter_int(from, "multifd-channels", 8);
> +        migrate_set_parameter_int(to, "multifd-channels", 8);
> +    }
> +
>      migrate_ensure_non_converge(from);
>  
>      migrate_prepare_for_dirty_mem(from);
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index 7991ee56b6..1b2320ebef 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -193,6 +193,9 @@ typedef struct {
>       */
>      bool live;
>  
> +    /* set multifd on */
> +    bool multifd;
> +
>      /* Postcopy specific fields */
>      void *postcopy_data;
>      bool postcopy_preempt;
> diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
> index daf7449f2c..6eada6ccbc 100644
> --- a/tests/qtest/migration/postcopy-tests.c
> +++ b/tests/qtest/migration/postcopy-tests.c
> @@ -27,6 +27,15 @@ static void test_postcopy(void)
>      test_postcopy_common(&args);
>  }
>  
> +static void test_postcopy_multifd(void)
> +{
> +    MigrateCommon args = {
> +        .multifd = true,
> +    };
> +
> +    test_postcopy_common(&args);
> +}
> +
>  static void test_postcopy_suspend(void)
>  {
>      MigrateCommon args = {
> @@ -83,6 +92,7 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
>  {
>      if (env->has_uffd) {
>          migration_test_add("/migration/postcopy/plain", test_postcopy);
> +        migration_test_add("/migration/postcopy/multifd", test_postcopy_multifd);
>          migration_test_add("/migration/postcopy/recovery/plain",
>                             test_postcopy_recovery);
>          migration_test_add("/migration/postcopy/preempt/plain",
> --
> 2.48.1
> 

This is only one test out of many I listed in the previous email:

https://lore.kernel.org/qemu-devel/ZykJBq7ME5jgSzCA@x1n/

Would you please add all the tests mentioned there?

Thanks,

-- 
Peter Xu


