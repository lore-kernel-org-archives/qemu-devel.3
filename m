Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA04CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkr8-0003Rq-Lq; Wed, 20 May 2026 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPkr3-0003RT-Js
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPkr1-0007HZ-UJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779298629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVSPNdA8t+4+MQ2CNcHxWF57tfg2oIGxgJw0mgUs0eA=;
 b=A9ULsci9D16ppEh1d/oEd4gNLwBRCAyg/45qGTOw9ANzJ242QO/X1JprCdXdfx5ntPk5AP
 FnwmX/G3IoPO74CbMnuyerD/nR60V8xZ4RJj/0g+o3B5XohmwDV5Ts0Noa42cYbTV0cHIX
 6sAT90U9gsLPIn36HuullRYVahiW6DE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-1bvw8pQEMlunR5PIBZu-8A-1; Wed, 20 May 2026 13:37:08 -0400
X-MC-Unique: 1bvw8pQEMlunR5PIBZu-8A-1
X-Mimecast-MFC-AGG-ID: 1bvw8pQEMlunR5PIBZu-8A_1779298628
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-910304978f3so1019192285a.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779298627; x=1779903427; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kVSPNdA8t+4+MQ2CNcHxWF57tfg2oIGxgJw0mgUs0eA=;
 b=bS+RtFv5enYd+jEqvrpWoyhbcRgl2qDu6hqu3LwWHIwYqPczQkN80Qb5DjuwYiP6H0
 6vZMm/t/UJeG2DFUzfjeHYAoZk7HbjeS1GN3et1gIqL2wBGl3f3x6ZkXIX/tRwoKzkXt
 tGJG3VgdyiNx1e1jx2R3oZXCgXV4HuJ3rpA+0KnmgHwpkZ7mluqFI/Evbcfa2vbCwxUu
 Y3HhmzyxoFQnEJLd5/+JMteEXfwKlDuDKqNOLxuKEObiI41pSlI2uVjU72f5bNqXuL/y
 aGgk8N2i+QO/TpMWWspac9Lq6K6aOq7Q4taWBuWBHgeCSclYU4aZSWE/rbcT3Mpmc19Y
 iwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298627; x=1779903427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVSPNdA8t+4+MQ2CNcHxWF57tfg2oIGxgJw0mgUs0eA=;
 b=FoZrgYPidxEOdFIuFcJXatyZ7ARK33elJLJPqBHLTzIg9gr16EVGCILvo3wUyAa6TV
 +ZxMDXXXWL8AXpvPaLib8M20y9KD6Q8sHi/zceDzbvtVDWsbwSPc5SvL5sNN3KfGe0O8
 PoTKYYMoIUMOj+j5LptgxPpeMO2nLmNJSfZXLddheK3HItqVR7SvKslL6eOjRMWgPI5u
 SKf/QTKK+sd0QS/SmDBs2od+S3E1OnTXcHxZojyeX1G6dfJ5gdQPyagYVAkkNRy8nOIF
 U4mDgRSo8BOqj9cmjrEyZcXbPAneb2PRoNDRdgCZCT/1D8b/w+Psi8M7DNEkQl1s9esq
 P7zQ==
X-Gm-Message-State: AOJu0Ywf7f9Wn2EvfpL6HOG77QEEeNEaMShRgqkAzguCa3RNlAm++7jS
 kYCg5K+v4toSXc3p1r/YjyQWD6vm9yGKxKP5F/+APg4rQkUPfn7Byt4Zx6SHYZ1/oi+oAO1kQXE
 +9mWSg5cLB/njLMWAfIY0bpQi8tmt7O6a9CiTvNTiYAfvLoHIikeMLnVi
X-Gm-Gg: Acq92OGVS9nUdXGlS9vgactmGH23e6ogLDIZa0JvPgCBjgi4i9NtnoaPQi9437DXfwB
 jQ/0ZxEaDtZ0Qa6SZwZgM3Ad+o0Nt7wi6WD3RAs8Rqp/0ZgzqoLry/DJJrE38J3bUKH8sNZxmKP
 JMpEc+pg2SxSH3ItyHt0K1QAJoLNmBiXmfgTAdKrDfRYjPbAqcpGB/x+LTunOFzDNOk1bL4Z7jr
 jf8XrFgWyG/bFRXC2UNLGH2xEGVG2jUtV3rgbQONMRrmmLhC3lBf+n7+LtrAHNPi8beyEpFk/yS
 V7zx8JSgArD6wC7LBiQWpBND6cetVMdyenxvwvPwNKXgNhoBq/BJ9N4uBT744VNcZ0cy+5xXkT6
 SettlmiGTLJsoWRz0AewSn6HkhH40aDlN8uX+BvL0URZB1ZZk6/fiCmCbzw==
X-Received: by 2002:a05:620a:f0b:b0:8cd:c152:ee6b with SMTP id
 af79cd13be357-914a01ffbb2mr78186685a.8.1779298627424; 
 Wed, 20 May 2026 10:37:07 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:8cd:c152:ee6b with SMTP id
 af79cd13be357-914a01ffbb2mr78180285a.8.1779298626863; 
 Wed, 20 May 2026 10:37:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910baf2236fsm2206668285a.20.2026.05.20.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:37:06 -0700 (PDT)
Date: Wed, 20 May 2026 13:37:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 11/15] tests/qtest/migration: Use defer for cpr-tests
Message-ID: <ag3xQBVVv74srgKo@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 01:09:10PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/cpr-tests.c | 21 ++++++++++++---------

Reviewed-by: Peter Xu <peterx@redhat.com>

Only one thing to double check:

>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 18217f0460..9091a84213 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -60,7 +60,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
>      obj = migrate_str_to_channel(cpr_channel);
>      qlist_append(channels_list, obj);
>  
> -    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
> +    if (migrate_start(&from, &to, "defer", &args->start)) {
>          return -1;
>      }
>  
> @@ -128,11 +128,17 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
>      int cpr_sockfd = qtest_socket_server(cpr_path);
>      g_assert(cpr_sockfd >= 0);
>  
> -    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
> -                                  "addr.type=fd,addr.str=%d %s",
> -                                  cpr_sockfd, opts);
> +    if (incoming_defer) {
> +        opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
> +                                      "addr.type=fd,addr.str=%d %s",
> +                                      cpr_sockfd, opts);
> +    } else {
> +        opts_target = g_strdup_printf("-incoming %s "
> +                                      "-incoming cpr,addr.transport=socket,"
> +                                      "addr.type=fd,addr.str=%d %s",
> +                                      uri, cpr_sockfd, opts);

IIUC now in this path qtest will ultimately generate cmdline like this for
dest:

  -incoming defer \
  -incoming unix:... \
  -incoming cpr,addr...

I am not sure if this is the intention, but it looks working indeed where
the 1st defer will be an no-op, and "-incoming" allows overwrites.

We'll just need to remember this and be careful in the future on the order
of these parameters. Say, if we accidentally move the first "-incoming
defer" parameter to be after opts_target, then it might break, because then
it's not no-op anymore but freeing the main channel we just set.

But I think it's ok for now.

> +    }
>  
> -    args->listen_uri = incoming_defer ? "defer" : uri;
>      args->connect_channels = connect_channels;
>  
>      args->start.opts_source = opts;
> @@ -224,7 +230,7 @@ static void test_cpr_exec(MigrateCommon *args)
>      g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
>                                                  FILE_TEST_FILENAME);
>  
> -    if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
> +    if (migrate_start(&from, NULL, "defer", &args->start)) {
>          return;
>      }
>  
> @@ -274,10 +280,7 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>  {
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>                                             FILE_TEST_FILENAME);
> -    g_autofree char *listen_uri = g_strdup_printf("defer");
> -
>      args->connect_uri = uri;
> -    args->listen_uri = listen_uri;
>      args->start_hook = test_mode_exec_start;
>  
>      args->start.only_source = true;
> -- 
> 2.51.0
> 

-- 
Peter Xu


