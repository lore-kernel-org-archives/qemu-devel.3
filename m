Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C4EC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sDk-0002im-5P; Tue, 29 Apr 2025 17:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9sDM-0002Wl-R5
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9sDK-0004Ot-EY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745961000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t0TkmPAJC++aOcwxNLPzRA5BSXAyu2A+z7pCcLdi/uk=;
 b=Rk7/JZVBbP1t4FM7JQNr+RqDABEEtwU6uWAnKgzHdC+nbawQkRktOyRwsLFaqo1oq7UV0X
 8Y8QaFpxqjcTB+g4TGgrrhmZRfVAxdu4H81ZUIi5O6JGv3FK998iEDqiJYILXeY7s9iEnR
 VB7g2Ttn++Xmze64ymlWSPGBeviRmdI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-kbzhuR-7OFOWC0wNeCJqSA-1; Tue, 29 Apr 2025 17:09:58 -0400
X-MC-Unique: kbzhuR-7OFOWC0wNeCJqSA-1
X-Mimecast-MFC-AGG-ID: kbzhuR-7OFOWC0wNeCJqSA_1745960998
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c53e316734so1029124585a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745960998; x=1746565798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0TkmPAJC++aOcwxNLPzRA5BSXAyu2A+z7pCcLdi/uk=;
 b=O68+BHRdMiAjl99NX+b8O9p0EFjjmlJYJoLpLEQcCBj1enQYzTZVTmDPLCafb/mQfx
 gPHXjFGnemEKQRwUsG2U8FAVwu8a8NIAd9Glc/xUTJgldG8s6bd6FCsI845Uenj6oHbM
 b/UAsFyEU+fADqyE/aPjHFBiIBnM7vEePvdXjPLMgz5A1edpdd/lN1NiWFTGkr7LHUse
 fo2tbRK/BTU2ePydj2VeqA1ttvMttub6P15mX5YHGhsUBWieMyUQNKhLRtAqDdzKQ+2j
 +iuRwjrRfJofJOOqvyauGzS20V6twP/oIwC2DmUppVIK4YRhoehVw/u/DGRR9kg/PG9C
 HamQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMw+M/sCD3COcnnC+Utwj4s1b82pAhyGIl9GDRfStmvKm5RMcxJDJ42BA37S5+ZsiF/v7bP0TI9dl/@nongnu.org
X-Gm-Message-State: AOJu0Yx5/X6AEYZUqrpS78AMXBf9xDTCJXHbSLxEbpDwWiEDaBi/znlo
 W3+f4iy97Y5ZViPNf3SHLBq/t21Epd5IiZak5quosnQ5shjSz4rafDJJRWN83sIEv5ZdS5JluTE
 Uijr65nb64cFsjNffeEMWDuUJwGbNeLH92+tJXX6qJ+Q38Meh3R3T
X-Gm-Gg: ASbGncuQECxZOZEnPBYkiGYkxFPlb/TnqNf8XKIiX6Tadilrg0ulQt2rMzy99eqDyWq
 KIRDYII88+JRBtx9sVzkAamae+g4UrqLiprlARL1MkJXJX12DdaGpYjP4KkOiGGJteQCM/tiHG1
 NNMoYMrBAbAJ7ITffw8GbhAWCvw63Dlf/4v1/ymfoUSE0m20g/FFGWvkB6rZ6m5r/vA6AozPOYV
 fzHsxObjknbRowya2ye4arMwaZVvCJVDcvXD+nH/QSmOVcVkIG39V6N/NKDTUIyEVyMnS9b/W51
 WY4=
X-Received: by 2002:a05:620a:4083:b0:7c5:5d32:2612 with SMTP id
 af79cd13be357-7cac76e342dmr90479185a.58.1745960998090; 
 Tue, 29 Apr 2025 14:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe9nUbuI+xVaXnvZCSir2MwMyuhGs+bBt8f9B9LpypYqTUIbuhxjS9rEqo4joe9Ms/tEyJPw==
X-Received: by 2002:a05:620a:4083:b0:7c5:5d32:2612 with SMTP id
 af79cd13be357-7cac76e342dmr90476185a.58.1745960997751; 
 Tue, 29 Apr 2025 14:09:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958cbfb1bsm775469885a.44.2025.04.29.14.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 14:09:57 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:09:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Message-ID: <aBFAIflmJns_nVIm@x1.local>
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327021234.264161-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Thu, Mar 27, 2025 at 10:12:34AM +0800, Li Zhijian wrote:
> Recently, we removed ipv6 restriction[0] from RDMA migration, add a
> test for it.
> 
> [0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@ionos.com/
> 
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> 
> This test is added based on [1]

Hmm, this cannot apply cleanly on top of your rdma test + Jake's ipv6 fix.
Did I made it wrong somewhere?

At the meantime, I found that the current rdma unit test failing if I did
the "setup" phase then run this test without root:

stderr:
qemu-system-x86_64: cannot get rkey
qemu-system-x86_64: error while loading state section id 2(ram)
qemu-system-x86_64: load of migration failed: Operation not permitted
qemu-system-x86_64: rdma migration: recv polling control error!
qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
qemu-system-x86_64: failed to save SaveStateEntry with id(name): 2(ram): -1
qemu-system-x86_64: Channel error: Operation not permitted
**
ERROR:../tests/qtest/migration/migration-qmp.c:200:check_migration_status: assertion failed (current_status != "failed"): ("failed" != "failed")
qemu-system-x86_64: warning: Early error. Sending error.
qemu-system-x86_64: warning: rdma migration: send polling control error
../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

So running the test also needs root?  Is it possible we fix the test so it
can also be smart enough to skip if it knows it'll hit the "cannot get
rkey" error (even if it sees the rdma link setup)?  Not something urgent
but definitely good to have.

OTOH, running the test using root always works for me.

> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  scripts/rdma-migration-helper.sh      | 26 +++++++++++++++++++++++---
>  tests/qtest/migration/precopy-tests.c | 21 +++++++++++++++++----
>  2 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
> index 019b9ad932..c358392b72 100755
> --- a/scripts/rdma-migration-helper.sh
> +++ b/scripts/rdma-migration-helper.sh
> @@ -8,6 +8,15 @@ get_ipv4_addr()
>          head -1 | tr -d '\n'
>  }
>  
> +get_ipv6_addr() {
> +    ipv6=$(ip -6 -o addr show dev "$1" |
> +        sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
> +        head -1 | tr -d '\n')
> +
> +    [ $? -eq 0 ] || return
> +    echo -n ["$ipv6"%$1]
> +}
> +
>  # existing rdma interfaces
>  rdma_interfaces()
>  {
> @@ -20,11 +29,16 @@ ipv4_interfaces()
>      ip -o addr show | awk '/inet / {print $2}' | sort -u | grep -v -w lo
>  }
>  
> +ipv6_interfaces()
> +{
> +    ip -o addr show | awk '/inet6 / {print $2}' | sort -u | grep -v -w lo
> +}
> +
>  rdma_rxe_detect()
>  {
>      for r in $(rdma_interfaces)
>      do
> -        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
> +        "$IP_FAMILY"_interfaces | grep -qw $r && get_"$IP_FAMILY"_addr $r && return
>      done
>  
>      return 1
> @@ -32,11 +46,11 @@ rdma_rxe_detect()
>  
>  rdma_rxe_setup()
>  {
> -    for i in $(ipv4_interfaces)
> +    for i in $("$IP_FAMILY"_interfaces)
>      do
>          rdma_interfaces | grep -qw $i && continue
>          rdma link add "${i}_rxe" type rxe netdev "$i" && {
> -            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
> +            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_"$IP_FAMILY"_addr $i)"
>              return
>          }
>      done
> @@ -50,6 +64,12 @@ rdma_rxe_clean()
>      modprobe -r rdma_rxe
>  }
>  
> +IP_FAMILY=${IP_FAMILY:-ipv4}
> +if [ "$IP_FAMILY" != "ipv6" ] && [ "$IP_FAMILY" != "ipv4" ]; then
> +    echo "Unknown ip family '$IP_FAMILY', only ipv4 or ipv6 is supported," >&2
> +    exit 1
> +fi
> +
>  operation=${1:-detect}
>  
>  command -v rdma >/dev/null || {
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index a137ea9f2c..9f7236dc59 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -102,12 +102,13 @@ static void test_precopy_unix_dirty_ring(void)
>  #ifdef CONFIG_RDMA
>  
>  #define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
> -static int new_rdma_link(char *buffer)
> +static int new_rdma_link(char *buffer, bool ipv6)
>  {
>      char cmd[256];
>      bool verbose = g_getenv("QTEST_LOG");
>  
> -    snprintf(cmd, sizeof(cmd), "%s detect %s", RDMA_MIGRATION_HELPER,
> +    snprintf(cmd, sizeof(cmd), "IP_FAMILY=%s %s detect %s",
> +             ipv6 ? "ipv6" : "ipv4", RDMA_MIGRATION_HELPER,
>               verbose ? "" : "2>/dev/null");
>  
>      FILE *pipe = popen(cmd, "r");
> @@ -132,11 +133,11 @@ static int new_rdma_link(char *buffer)
>      return -1;
>  }
>  
> -static void test_precopy_rdma_plain(void)
> +static void test_precopy_rdma_plain_ip(bool ipv6)
>  {
>      char buffer[128] = {};
>  
> -    if (new_rdma_link(buffer)) {
> +    if (new_rdma_link(buffer, ipv6)) {
>          g_test_skip("No rdma link available\n"
>                      "# To enable the test:\n"
>                      "# Run \'" RDMA_MIGRATION_HELPER " setup\' with root to setup"
> @@ -159,6 +160,16 @@ static void test_precopy_rdma_plain(void)
>  
>      test_precopy_common(&args);
>  }
> +
> +static void test_precopy_rdma_plain(void)
> +{
> +    test_precopy_rdma_plain_ip(0);
> +}
> +
> +static void test_precopy_rdma_plain_ipv6(void)
> +{
> +    test_precopy_rdma_plain_ip(1);
> +}
>  #endif
>  
>  static void test_precopy_tcp_plain(void)
> @@ -1189,6 +1200,8 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>  #ifdef CONFIG_RDMA
>      migration_test_add("/migration/precopy/rdma/plain",
>                         test_precopy_rdma_plain);
> +    migration_test_add("/migration/precopy/rdma/plain/ipv6",
> +                       test_precopy_rdma_plain_ipv6);
>  #endif
>  }
>  
> -- 
> 2.41.0
> 

-- 
Peter Xu


