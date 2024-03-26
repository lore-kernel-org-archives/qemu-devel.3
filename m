Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1108AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAFS-0004GH-I2; Tue, 26 Mar 2024 13:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rpAFP-0004F0-AN
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:06:04 -0400
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rpAFL-0005BG-Uq
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:06:03 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.148.223])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4V3x5Z6wzzz1HLG;
 Tue, 26 Mar 2024 17:05:54 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Mar
 2024 18:05:54 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004134405b4-7a29-45bc-9297-8bed83a68f15,
 3336A23CADED603188EFB840896199A906C9B3FB) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 26 Mar 2024 18:05:50 +0100
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: <qemu-devel@nongnu.org>, <thuth@redhat.com>, <alistair.francis@wdc.com>,
 <peter.maydell@linaro.org>, <qemu_oss@crudebyte.com>
Subject: Re: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create
 dir, file and symlink tests
Message-ID: <20240326180550.3072dd2d@bahia>
In-Reply-To: <20240326132606.686025-2-dbarboza@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <20240326132606.686025-2-dbarboza@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: ff2dfda9-a020-4ecd-998d-c70ccb317410
X-Ovh-Tracer-Id: 32088149783189798
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveekteettdekleekjeejfeeugffgtdeuuedtieegvdekleeuteevhefgheetveelnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddvpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggsrghrsghoiigrsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsseifuggtrdgtohhmpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhupghosh
 hssegtrhhuuggvsgihthgvrdgtohhmpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.37.156; envelope-from=groug@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 26 Mar 2024 10:26:04 -0300
Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:

> The local 9p driver in virtio-9p-test.c its temporary dir right at the
> start of qos-test (via virtio_9p_create_local_test_dir()) and only
> deletes it after qos-test is finished (via
> virtio_9p_remove_local_test_dir()).
> 
> This means that any qos-test machine that ends up running virtio-9p-test local
> tests more than once will end up re-using the same temp dir. This is
> what's happening in [1] after we introduced the riscv machine nodes: if
> we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
> this is what happens:
> 
> - a temp dir is created, e.g. qtest-9p-local-WZLDL2;
> 
> - virtio-9p-device tests will run virtio-9p-test successfully;
> 
> - virtio-9p-pci tests will run virtio-9p-test, and fail right at the
>   first slow test at fs_create_dir() because the "01" file was already
>   created by fs_create_dir() test when running with the virtio-9p-device.
> 
> We can fix it by making every test clean up their changes in the
> filesystem after they're done. But we don't need every test either:
> what fs_create_file() does is already exercised in fs_unlinkat_dir(),
> i.e. a dir is created, verified to be created, and then removed. Fixing
> fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
> both. The same theme follows every test in virtio-9p-test.c, where the
> 'unlikat' variant does the same thing the 'create' does but with some
> cleaning in the end.
> 
> Consolide some tests as follows:
> 
> - fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
>   fs_create_unlinkat_dir();
> 
> - fs_create_file() is removed. fs_unlinkat_file() is renamed to
>   fs_create_unlinkat_file(). The "04" dir it uses is now being removed;
> 
> - fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
>   fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
>   creates is now being removed.
> 

The  change looks good functionally but it breaks the legitimate assumption
that files "06/*" come from test #6 and so on... I think you should consider
renumbering to avoid confusion when debugging logs.

Since this will bring more hunks, please split this in enough reviewable
patches.

Cheers,

--
Greg

> We're still missing the 'hardlink' tests. We'll do it in the next patch
> since it's less trivial to consolidate than these.
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  tests/qtest/virtio-9p-test.c | 97 +++++++++++-------------------------
>  1 file changed, 29 insertions(+), 68 deletions(-)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 65e69491e5..cdbe3e78ea 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -506,26 +506,8 @@ static void fs_readdir_split_512(void *obj, void *data,
>  
>  /* tests using the 9pfs 'local' fs driver */
>  
> -static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
> -{
> -    QVirtio9P *v9p = obj;
> -    v9fs_set_allocator(t_alloc);
> -    struct stat st;
> -    g_autofree char *root_path = virtio_9p_test_path("");
> -    g_autofree char *new_dir = virtio_9p_test_path("01");
> -
> -    g_assert(root_path != NULL);
> -
> -    tattach({ .client = v9p });
> -    tmkdir({ .client = v9p, .atPath = "/", .name = "01" });
> -
> -    /* check if created directory really exists now ... */
> -    g_assert(stat(new_dir, &st) == 0);
> -    /* ... and is actually a directory */
> -    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
> -}
> -
> -static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
> +static void fs_create_unlinkat_dir(void *obj, void *data,
> +                                   QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
>      v9fs_set_allocator(t_alloc);
> @@ -551,28 +533,13 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_assert(stat(new_dir, &st) != 0);
>  }
>  
> -static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
> -{
> -    QVirtio9P *v9p = obj;
> -    v9fs_set_allocator(t_alloc);
> -    struct stat st;
> -    g_autofree char *new_file = virtio_9p_test_path("03/1st_file");
> -
> -    tattach({ .client = v9p });
> -    tmkdir({ .client = v9p, .atPath = "/", .name = "03" });
> -    tlcreate({ .client = v9p, .atPath = "03", .name = "1st_file" });
> -
> -    /* check if created file exists now ... */
> -    g_assert(stat(new_file, &st) == 0);
> -    /* ... and is a regular file */
> -    g_assert((st.st_mode & S_IFMT) == S_IFREG);
> -}
> -
> -static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
> +static void fs_create_unlinkat_file(void *obj, void *data,
> +                                    QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
>      v9fs_set_allocator(t_alloc);
>      struct stat st;
> +    g_autofree char *new_dir = virtio_9p_test_path("04");
>      g_autofree char *new_file = virtio_9p_test_path("04/doa_file");
>  
>      tattach({ .client = v9p });
> @@ -587,37 +554,22 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
>      tunlinkat({ .client = v9p, .atPath = "04", .name = "doa_file" });
>      /* file should be gone now */
>      g_assert(stat(new_file, &st) != 0);
> -}
> -
> -static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
> -{
> -    QVirtio9P *v9p = obj;
> -    v9fs_set_allocator(t_alloc);
> -    struct stat st;
> -    g_autofree char *real_file = virtio_9p_test_path("05/real_file");
> -    g_autofree char *symlink_file = virtio_9p_test_path("05/symlink_file");
>  
> -    tattach({ .client = v9p });
> -    tmkdir({ .client = v9p, .atPath = "/", .name = "05" });
> -    tlcreate({ .client = v9p, .atPath = "05", .name = "real_file" });
> -    g_assert(stat(real_file, &st) == 0);
> -    g_assert((st.st_mode & S_IFMT) == S_IFREG);
> -
> -    tsymlink({
> -        .client = v9p, .atPath = "05", .name = "symlink_file",
> -        .symtgt = "real_file"
> +    /* also cleanup dir*/
> +    tunlinkat({
> +        .client = v9p, .atPath = "/", .name = "04",
> +        .flags = P9_DOTL_AT_REMOVEDIR
>      });
> -
> -    /* check if created link exists now */
> -    g_assert(stat(symlink_file, &st) == 0);
> +    g_assert(stat(new_dir, &st) != 0);
>  }
>  
> -static void fs_unlinkat_symlink(void *obj, void *data,
> -                                QGuestAllocator *t_alloc)
> +static void fs_create_unlinkat_symlink(void *obj, void *data,
> +                                       QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
>      v9fs_set_allocator(t_alloc);
>      struct stat st;
> +    g_autofree char *new_dir = virtio_9p_test_path("06");
>      g_autofree char *real_file = virtio_9p_test_path("06/real_file");
>      g_autofree char *symlink_file = virtio_9p_test_path("06/symlink_file");
>  
> @@ -636,6 +588,16 @@ static void fs_unlinkat_symlink(void *obj, void *data,
>      tunlinkat({ .client = v9p, .atPath = "06", .name = "symlink_file" });
>      /* symlink should be gone now */
>      g_assert(stat(symlink_file, &st) != 0);
> +
> +    /* remove real file and dir */
> +    tunlinkat({ .client = v9p, .atPath = "06", .name = "real_file" });
> +    g_assert(stat(real_file, &st) != 0);
> +
> +    tunlinkat({
> +        .client = v9p, .atPath = "/", .name = "06",
> +        .flags = P9_DOTL_AT_REMOVEDIR
> +    });
> +    g_assert(stat(new_dir, &st) != 0);
>  }
>  
>  static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
> @@ -746,13 +708,12 @@ static void register_virtio_9p_test(void)
>  
>      opts.before = assign_9p_local_driver;
>      qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
> -    qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
> -    qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
> -    qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
> -    qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
> -    qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
> -    qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
> -                 &opts);
> +    qos_add_test("local/create_unlinkat_dir", "virtio-9p",
> +                 fs_create_unlinkat_dir, &opts);
> +    qos_add_test("local/create_unlinkat_file", "virtio-9p",
> +                 fs_create_unlinkat_file, &opts);
> +    qos_add_test("local/create_unlinkat_symlink", "virtio-9p",
> +                 fs_create_unlinkat_symlink, &opts);
>      qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
>      qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
>                   &opts);



-- 
Greg

