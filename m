Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76311C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOkL-00040S-8i; Fri, 09 May 2025 10:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDOkJ-00040C-7T
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDOkG-0008G3-98
 for qemu-devel@nongnu.org; Fri, 09 May 2025 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746801034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGJkDB+Xusre0fRrlKKP4zypgHXYZ/QTEwlego3IiSQ=;
 b=eSjaO8BSAjRRCPxNy134KP9VSUcXNQr/35ZOJOc2dXx+2eu99W6IU4Ox5drujtBJjOnYPW
 6OcPNCJkwvW9gshBApyZMekcsbVsKVDJI39/ZOQ3lbj/48l2StT1d0RP9S5Sz6Z+wGJkLi
 O3qATv/bsJIg2+86C6ZQRCtdHF2NswA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-hXcbN9bCMd-qvf1H3KHNOg-1; Fri, 09 May 2025 10:30:32 -0400
X-MC-Unique: hXcbN9bCMd-qvf1H3KHNOg-1
X-Mimecast-MFC-AGG-ID: hXcbN9bCMd-qvf1H3KHNOg_1746801032
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5d608e703so417021385a.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 07:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746801032; x=1747405832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGJkDB+Xusre0fRrlKKP4zypgHXYZ/QTEwlego3IiSQ=;
 b=khdpBvOPzJRh/OgQpwXaikWW8la44pCfAfZiForhkQHsxA5W2LEvze2lWkwGvl0P/S
 Ki7IPHn0w04AmJz4iuvTlXo+Dj9ETJJPAqJJ2KwbacTeJihuUO8dnHLfkr9rh2jJZXgI
 KvwfIC9a6xDhAVdZ9tmKcVXz5/F9Qxumk44IWRTlq1m60USGOcLiV98U3KCvismukFIp
 rdRKFcWQ2GCSfbs62a9tt0WJnmItgki1PieVyRXBeV/BtvMLicGbQy1UGFSHOfTNPOBv
 FcCVnqh8rpYSeU4YqEe9m4M5HPE+hlKUXxN6tJX6QhBAqoV+UtXUH4eatd2qLnGYFeGU
 q3yg==
X-Gm-Message-State: AOJu0YyvUUeKzAsk+alPzAOSkMng7hC7eXYivHsF41Q7y9P2ZY1LpPpg
 t/cw3nrr2YXy6gkona9/2GfZNlDWnULSjI7cVEyioQmh31V2V0i3w4ixQwKy9mwFMr/628ilfWi
 s4fGSnbdBcGGJM/uU0QEkMQAl41VUW293zOGsvhiH2Lmosgxk3IyT
X-Gm-Gg: ASbGncugMHtTm6WK4PMKhUoBjqKCS1XGSaTCL5cKxdP2Q+Ie5qUxONVpeD0dkBNZM9F
 EfdZCNCr/StnCG7H+//HTUL8D3ZM8Ghnk3bZGaV1YeACA9v4Yc8XHFbLHrpiYljS4iTcx0EGpHl
 4S06AdOJ6JvtnI5Vb5P5W3k6/MkGCxJ0W7Qf7rlLTOQ9f0cZL+nQ/uoYOmJ06jy5JNpfYsC0oF3
 4KjFI6jJ6YGSPWOfNL3RrtavelVWp5kXkj7zbeJCU+b8jaUJUKqE7bZqf46lRPAxttWJaNd2uWg
 +Nw=
X-Received: by 2002:a05:620a:2585:b0:7cc:9245:9ec3 with SMTP id
 af79cd13be357-7cd010d0093mr602603185a.8.1746801031995; 
 Fri, 09 May 2025 07:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUK3mYehZzeDuoiwHuzWzRClB1R4dKm0Jg4XvVhkAijX6r9Ye6j2j1diEh3cKIVDQ6pvoy4w==
X-Received: by 2002:a05:620a:2585:b0:7cc:9245:9ec3 with SMTP id
 af79cd13be357-7cd010d0093mr602597885a.8.1746801031450; 
 Fri, 09 May 2025 07:30:31 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00fe703esm145246185a.111.2025.05.09.07.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 07:30:30 -0700 (PDT)
Date: Fri, 9 May 2025 10:30:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v10 2/3] tests/qtest/migration: add postcopy tests with
 multifd
Message-ID: <aB4Rgj5nghklODSq@x1.local>
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-3-ppandit@redhat.com>
 <aB0AMQdPbcdNy_bS@x1.local>
 <CAE8KmOx_7EXXNQa0q0gKvZmWMT-0hYcKH6wRFiUEs_-KANf1Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOx_7EXXNQa0q0gKvZmWMT-0hYcKH6wRFiUEs_-KANf1Ow@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, May 09, 2025 at 10:56:05AM +0530, Prasad Pandit wrote:
> On Fri, 9 May 2025 at 00:34, Peter Xu <peterx@redhat.com> wrote:
> > I may not have followed the whole discussions, but have you tried to avoid
> > this global?
> 
>     -> https://lore.kernel.org/qemu-devel/875xkyyxyy.fsf@suse.de/
> 
> * Yes, it was discussed, passing it as a parameter would change the
> function prototype and entail changing functions at many places.

Would this work?

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a575791c72..441a65bcf5 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -34,7 +34,6 @@
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 static char *tmpfs;
-static bool postcopy_ram = false;
 
 static void test_precopy_unix_plain(void)
 {
@@ -525,7 +524,7 @@ static void test_multifd_tcp_channels_none(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel(bool postcopy_ram)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -612,11 +611,14 @@ static void test_multifd_tcp_cancel(void)
     migrate_end(from, to2, true);
 }
 
+static void test_multifd_precopy_tcp_cancel(void)
+{
+    test_multifd_tcp_cancel(false);
+}
+
 static void test_multifd_postcopy_tcp_cancel(void)
 {
-    postcopy_ram = true;
-    test_multifd_tcp_cancel();
-    postcopy_ram = false;
+    test_multifd_tcp_cancel(true);
 }
 
 static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
@@ -1205,7 +1207,7 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
     migration_test_add("/migration/multifd/tcp/uri/plain/none",
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
+                       test_multifd_precopy_tcp_cancel);
     if (env->has_uffd) {
         migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
                            test_multifd_postcopy_tcp_cancel);

-- 
Peter Xu


