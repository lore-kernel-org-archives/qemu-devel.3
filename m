Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DDDC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8tm-0000sb-PK; Thu, 20 Feb 2025 10:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl8tl-0000rs-Lw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tl8tj-00052D-Kq
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740066934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66eUIzmR3cxGzRiAlOdF6EvcimdFm8fP6kd0QfUx/xc=;
 b=e+xcWLXd/j7jAjNlUfNUaIF2WFiEFAlTL6FLY5p3AJFaW7Xw9TOKlupCJ8yhDXXROmsTfx
 kuGJ/YA7dGM5QtmykcCV2zlO9J7o4T9LsMgWaJL8R0hMcbnKWbpx54XPI+u7ekOlrIHTv9
 nN8+UZHi3XVVBy/1zM66JinPs1IZ3uo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-bkkeiVBwOoStCN1HgrNSHg-1; Thu, 20 Feb 2025 10:55:33 -0500
X-MC-Unique: bkkeiVBwOoStCN1HgrNSHg-1
X-Mimecast-MFC-AGG-ID: bkkeiVBwOoStCN1HgrNSHg_1740066933
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-471fc73b941so30057961cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740066933; x=1740671733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66eUIzmR3cxGzRiAlOdF6EvcimdFm8fP6kd0QfUx/xc=;
 b=VQ45xna+Sz7/kCGpkbwSoTwO+JnLvXTlPDD5pijd4ziAvrm53zmDDQq1I1kAQZlPWf
 95I0EHalXiJA9MAjjnWOJHv5qS8+gIYx3KS6fTtF82+ZXnEpyr3ALOftM+d2CEoHm+EO
 SFfbMxZGTF+6S5R5BY7evfHG1F5OquBPlIcUwa+HyUuyvXdxoHrgYyEnk9KxV4u9MleV
 F0MLDUcwcDHyzsjYQtYsrtKVg6d5b47fk1W9OfrJe1m97U+tY/t4MSonUGnfy3cjGRih
 EaO9nNv8d3k1rHC95v2JbzRl94B4JuZtpBkYxxm1TGdAUfP3KjPR++Q8pp6Kox3U7Dm/
 uWoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRrT8zb2yVKnpeRFMuBvCYl6v/mvRpGUS+I5Bv3xMzL3oqRSwfepvukJHnQONVdZXKv5VVK0VcZHhs@nongnu.org
X-Gm-Message-State: AOJu0YxLCaUPUgllJ29ArYWI5ORhjmBdt9NJzJpbZvX6g51x917EmB3p
 Ho00ByD/i8ZMsxzfjZX3YI1BGCYj+H4zQ+oqmNkq04STtc8kVSJrnuYrGJxAVIFMCqAp8B3whxx
 13N1UFAc3PeQdOPUA8Nv4dK9Y2HQnuGz9aZn7GY3MB/qml87wNYz3
X-Gm-Gg: ASbGncuRSLDQJlc0aaIsHVjhYhLeow0oMsTdxfx9WkjM8XNm/xKiKDLU+2S/IInm6pK
 Hv83LXMADWjowYWbzQ8qbPiRoFmKarGj/L6XohPtWnaIzwPXlTefEnPhEVnl98El6Ata7jXv+mK
 2DrTE3npCdfS2skFUPrUEuk4s8nW8rAQLn00tkxcfotwj/qGYBGTMA3nZ3VUuWATNTHIXWDd3XV
 uIXuA2tT68J2AQ/TQeg/Bcynyaa+Arsl3itH3Gj7dIN3sXhaASX1K/xhGo=
X-Received: by 2002:a05:622a:4086:b0:472:2df:6ff1 with SMTP id
 d75a77b69052e-47202df7487mr176804691cf.13.1740066932964; 
 Thu, 20 Feb 2025 07:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPPcbMLfJ4+ikA3CutzS+IsPYHcI5gUeQhc8D7FiSOZOR6WfUJ32bCHVK3cVVOS9iGg+LkMw==
X-Received: by 2002:a05:622a:4086:b0:472:2df:6ff1 with SMTP id
 d75a77b69052e-47202df7487mr176804161cf.13.1740066932465; 
 Thu, 20 Feb 2025 07:55:32 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471eb3fac8dsm50404391cf.47.2025.02.20.07.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:55:32 -0800 (PST)
Date: Thu, 20 Feb 2025 10:55:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Message-ID: <Z7dQcBHIV0q6l4S6@x1.local>
References: <Z7Xmkq0nTmZ8TRXU@x1.local>
 <20250220094038.1382541-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220094038.1382541-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 20, 2025 at 05:40:38PM +0800, Li Zhijian wrote:
> On 19/02/2025 22:11, Peter Xu wrote:
> >>>>> then
> >>>>> in the test it tries to detect rdma link and fetch the ip only
> >>>> It should work without root permission if we just*detect*  and*fetch ip*.
> >>>>
> >>>> Do you also mean we can split new-rdma-link.sh to 2 separate scripts
> >>>> - add-rdma-link.sh # optionally, execute by user before the test (require root permission)
> >>>> - detect-fetch-rdma.sh # execute from the migration-test
> >>> Hmm indeed we still need a script to scan over all the ports..
> >>>
> >>> If having --rdma is a good idea, maybe we can further make it a parameter
> >>> to --rdma?
> >>>
> >>>    $ migration-test --rdma $RDMA_IP
> >>>
> >>> Or:
> >>>
> >>>    $ migration-test --rdma-ip $RDMA_IP
> >> I think --rdma only makes sense if it's going to do something
> >> special. The optmimal scenario is that it always runs the test when it
> >> can and sets up/tears down anything it needs.
> >>
> >> If it needs root, I'd prefer the test informs about this and does the
> >> work itself.
> >>
> >> It would also be good to have the add + detect separate so we have more
> >> flexibility, maybe we manage to enable this in CI even.
> >>
> >> So:
> >>
> >> ./add.sh
> >> migration-test
> >> (runs detect.sh + runs rdma test)
> >> (leaves stuff behind)
> >>
> >> migration-test
> >> (skips rdma test with message that it needs root)
> >>
> >> sudo migration-test
> >> (runs add.sh + detect.sh + runs rdma test)
> >> (cleans itself up)
> >>
> >> Does that make sense to you? I hope it's not too much work.
> > Looks good here.  We can also keep all the rdma stuff into one file, taking
> > parameters.
> > 
> > ./rdma-helper.sh setup
> > ./rdma-helper.sh detect-ip
> 
> Hi Peter and Fabiano
> 
> Many thanks for your kindly idea and suggestion.
> Please take another look at the changes below.
> - I don't copy script to the build dir, just execute the script like misc-tests.c
> - It will automatically create a new RXE if it doesn't exit when running in root

Thanks!  This is much better.  Comments below.

> 
> [PATCH] migration: Add qtest for migration over RDMA
> 
> This qtest requires there is RDMA(RoCE) link in the host.
> Introduce a scripts/rdma-migration-helper.sh to
> - setup a new RXE if it's root
> - detect existing RoCE link
> to make the qtest work smoothly.
> 
> Test will be skip if there is no available RoCE link.
>  # Start of rdma tests
>  # Running /x86_64/migration/precopy/rdma/plain
>  ok 1 /x86_64/migration/precopy/rdma/plain # SKIP There is no available rdma link in the host.
>  Maybe you are not running with the root permission
>  # End of rdma tests
> 
> Admin is able to remove the RXE by passing 'cleanup' to this script.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  scripts/rdma-migration-helper.sh      | 40 +++++++++++++++++++
>  tests/qtest/migration/precopy-tests.c | 57 +++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100755 scripts/rdma-migration-helper.sh
> 
> diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
> new file mode 100755
> index 0000000000..4ef62baf0f
> --- /dev/null
> +++ b/scripts/rdma-migration-helper.sh
> @@ -0,0 +1,40 @@
> +#!/bin/bash
> +
> +# Copied from blktests
> +get_ipv4_addr() {
> +    ip -4 -o addr show dev "$1" |
> +        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
> +        tr -d '\n'
> +}
> +
> +has_soft_rdma() {
> +    rdma link | grep -q " netdev $1[[:blank:]]*\$"
> +}
> +
> +rdma_rxe_setup_detect()
> +{
> +    (
> +        cd /sys/class/net &&
> +            for i in *; do
> +                [ -e "$i" ] || continue
> +                [ "$i" = "lo" ] && continue
> +                [ "$(<"$i/addr_len")" = 6 ] || continue
> +                [ "$(<"$i/carrier")" = 1 ] || continue
> +
> +                has_soft_rdma "$i" && break
> +                [ "$operation" = "setup" ] && rdma link add "${i}_rxe" type rxe netdev "$i" && break
> +            done
> +        has_soft_rdma "$i" || return
> +        get_ipv4_addr $i
> +    )
> +}
> +
> +operation=${1:-setup}
> +
> +if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
> +    rdma_rxe_setup_detect
> +elif [ "$operation" == "cleanup" ]; then
> +    modprobe -r rdma_rxe

Would this affects host when there's existing user of rdma_rxe (or fail
with -EBUSY)?  If there's no major side effect of leftover rdma link, we
could also drop the "cleanup" for now and start from simple.

> +else
> +    echo "Usage: $0 [setup | cleanup | detect]"
> +fi
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index ba273d10b9..8c72eb699b 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -99,6 +99,59 @@ static void test_precopy_unix_dirty_ring(void)
>      test_precopy_common(&args);
>  }
>  
> +#ifdef CONFIG_RDMA
> +
> +#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
> +static int new_rdma_link(char *buffer) {

Nit: newline before "{".

> +    const char *argument = (geteuid() == 0) ? "setup" : "detect";
> +    char command[1024];
> +
> +    snprintf(command, sizeof(command), "%s %s", RDMA_MIGRATION_HELPER, argument);
> +
> +    FILE *pipe = popen(command, "r");
> +    if (pipe == NULL) {
> +        perror("Failed to run script");
> +        return -1;
> +    }
> +
> +    int idx = 0;
> +    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
> +        idx += strlen(buffer);
> +    }
> +
> +    int status = pclose(pipe);
> +    if (status == -1) {
> +        perror("Error reported by pclose()");
> +        return -1;
> +    } else if (WIFEXITED(status)) {
> +        return WEXITSTATUS(status);
> +    }
> +
> +    return -1;
> +}
> +
> +static void test_precopy_rdma_plain(void)
> +{
> +    char buffer[128] = {};
> +
> +    if (new_rdma_link(buffer)) {
> +        g_test_skip("There is no available rdma link in the host.\n"
> +                    "Maybe you are not running with the root permission");

Nit: can be slightly more verbose?

           g_test_skip("\nThere is no available rdma link to run RDMA
                       migration test.  To enable the test:\n"
                       "(1) Run \'%s setup\' with root and rerun the test\n"
                       "(2) Run the test with root privilege\n",
                       RDMA_MIGRATION_HELPER);


> +        return;
> +    }
> +
> +    /* FIXME: query a free port instead of hard code. */
> +    g_autofree char *uri = g_strdup_printf("rdma:%s:7777", buffer);
> +
> +    MigrateCommon args = {
> +        .listen_uri = uri,
> +        .connect_uri = uri,
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +#endif
> +
>  static void test_precopy_tcp_plain(void)
>  {
>      MigrateCommon args = {
> @@ -1124,6 +1177,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>                         test_multifd_tcp_uri_none);
>      migration_test_add("/migration/multifd/tcp/plain/cancel",
>                         test_multifd_tcp_cancel);
> +#ifdef CONFIG_RDMA
> +    migration_test_add("/migration/precopy/rdma/plain",
> +                       test_precopy_rdma_plain);
> +#endif
>  }
>  
>  void migration_test_add_precopy(MigrationTestEnv *env)
> -- 
> 2.41.0
> 

-- 
Peter Xu


