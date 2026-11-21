Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D1606A333
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hGCBuVrU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUc9e-0000m3-NP; Fri, 20 Nov 2026 22:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xUc9c-0000l0-7Q
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 22:52:44 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1xUc9a-0004dO-2r
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 22:52:43 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso826649a91.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 19:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795233160; x=1795837960; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gPMPz95XHRn193S3M8qU2GOltb60Cn4ZvH5ddS5NAHU=;
 b=hGCBuVrUTJnffAjfCgNrIjeqODZzzHmGDwWwZdQ/DVnBNN216hplETRrdUSExEfH/9
 2V2Ps5s3ogank0O0VsyXc3lT9aIDa1mbiva6suEEUOy0FwaRE4TuUePaBJh53HDuweau
 6DefME5IjoWxhwBYexjpbS6iOmV/+PUpfkpWKV7nrovJDKJtWw9oDuWiP90LURDqdm05
 RuD3aNtU7TQyhjWEaZjKsEhfEE6xyvCOS2YR9ScDVO8L4kZGVQ5/nZe4jjDCLve456Yg
 7a+8y305eleHVKloOHfcjoWQfWV+HCuNwCi68+o5FJHaQqw55hc+6d19/owrblxq3Hrq
 ICaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795233160; x=1795837960;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gPMPz95XHRn193S3M8qU2GOltb60Cn4ZvH5ddS5NAHU=;
 b=eXbNNY7R4PosgHGjokSfRgexQ7fn2REnCjxkx1NRCCg8cW6uo8iTb87KtGck0Cvvjd
 YLhxE4YiOlOI1GX8Yv4WEvz+UG3PlQ3f/ilEC9ssdOBKHTIZ9BUFibel3uMayKX28E4V
 7vfVSVMJaWD1EmfOqhOna4HSt0Mz0wMmxubKo0o5eCtkdmtRV/gvwCiifcvB8cNjnvml
 Wvo0RZgPG+wcD4+IcpC6VzRtnOmdw3py0NCFYKPrOeIjkQGItUqA5WC1hSNBOhFCjohD
 DDQFi8NXXUv9X+0Y6Wu3PWiChxRAX5Ulscf4DHmN4yezABaQdVHZxYn/cbum/51NzHy7
 PapQ==
X-Gm-Message-State: APuU4Z/q0rPyBsxX1Q1b9g2KT45T71C6E7zC1mCPy9OCIMDKmJsaa0KV
 I/4QERuR3tlmi3KssmLmVpUY6vKgzVtY6e1DAgH5pLTfJUDWwyACS296
X-Gm-Gg: AZFdTZesxZ/ePOXjg4S6ZG1HIeD9rUGR9c707LrkiEi211/4bq/qjqGjmbxwzlGLaok
 CwoHX7uBMZACWqMl4ffWSxxCwNi8mgPW9ZFQa/T6EzuESbnroR5LRR/G2OtUIG608urSC+ITybk
 9OysGMw1CbthOj7QOSI7pBrkUBt0uB2T/DjspeJS7PJ2jpHVfXqyjpsWbXvWd7xe6Z+8c0Z/S3W
 YZ3R/3x/Rmjl+x7rYK2ZCKDE/ShaOtWlBpnrnk9tNCpQn/EGaAG63p4JKOQmiM1BEbiSvbw2fr7
 O0gE9CfZ3QHwvZNOsTcrm1XKYFV7DdeZ41tnLKxCJONlAQVKVloakNUqyDR13vGUIOyuz9anC/J
 3hWvAndg/hdePfnyyxMIBaSkdXr0+wLBZHeQ04eAftKkCsFTKP91wWwsvgu11NIyf6mT+jL/cck
 3r2j9CdmCdpZ2q5vfGJvF8caMKIxlv2zeClUuCdbDHzovyQauyl3v2tOCXbyIrbCcOZtwtgNB6L
 kBQjOTvrquFgQH4V9csfxSCFz98ItrzZEo11aRaf8HYfTXokgDAgfeloL//h4PtJ307cyR5UPfk
 CweWo+1z2SXYSpaF3lBKDDDbF7oOpTV4+abWuUlui//LR6veLA3oQ07HxpOOqDEMFAwAyYxUDHI
 E+qIrPnQP8g==
X-Received: by 2002:a17:90b:390c:b0:3a7:9e3d:b3 with SMTP id
 98e67ed59e1d1-3b41c9beafamr4541420a91.66.1795233160138; 
 Fri, 20 Nov 2026 19:52:40 -0800 (PST)
Received: from google.com (61-230-61-116.dynamic-ip.hinet.net. [61.230.61.116])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d97356sm9568281a91.13.2026.11.20.19.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 19:52:39 -0800 (PST)
Date: Sat, 21 Nov 2026 11:52:30 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
Message-ID: <awEVfpG0U9p02nxm@google.com>
References: <20261112133320.418012-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112133320.418012-2-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 05:33:20PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> tuxboot rebuilds the 6.18.54 kernel images in place, so the URLs
> without a datestamp now serve content that does not match the recorded
> hashes and the tuxrun tests fail to fetch their assets. Point the
> x86_64, arm64 and s390 tests at the immutable 20260930 snapshots and
> keep the hashes that were recorded against them, instead of implicitly
> switching to the rebuilt images.
> 
> Do the same for the riscv64 6.11.9 kernel assets, which still used
> non-datestamped URLs; their recorded hashes already match the 20241122
> snapshot.
> 
> Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
> Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
> Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

> ---
>  tests/functional/aarch64/test_tuxrun.py      | 4 ++--
>  tests/functional/riscv64/test_milkv_duo.py   | 4 ++--
>  tests/functional/riscv64/test_tt_atlantis.py | 2 +-
>  tests/functional/riscv64/test_tuxrun.py      | 2 +-
>  tests/functional/s390x/test_tuxrun.py        | 4 ++--
>  tests/functional/x86_64/test_tuxrun.py       | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
> index 2ff321582d38..035984d8e3e5 100755
> --- a/tests/functional/aarch64/test_tuxrun.py
> +++ b/tests/functional/aarch64/test_tuxrun.py
> @@ -17,10 +17,10 @@
>  class TuxRunAarch64Test(TuxRunBaselineTest):
>  
>      ASSET_ARM64_KERNEL = Asset(
> -        'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
> +        'https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/Image.gz',
>          '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4e')
>      ASSET_ARM64_VMLINUX = Asset(
> -        'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
> +        'https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/vmlinux.xz',
>          '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b85')
>      ASSET_ARM64_ROOTFS = Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext4.zst',
> diff --git a/tests/functional/riscv64/test_milkv_duo.py b/tests/functional/riscv64/test_milkv_duo.py
> index 6a7e2a5d1967..fdc83d7c8284 100755
> --- a/tests/functional/riscv64/test_milkv_duo.py
> +++ b/tests/functional/riscv64/test_milkv_duo.py
> @@ -14,11 +14,11 @@ class MilkvDuoMachine(LinuxKernelTest):
>      timeout = 120
>  
>      ASSET_KERNEL = Asset(
> -        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
>          '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0'
>      )
>      ASSET_DTBS = Asset(
> -        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/dtbs.tar.xz',
> +        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/dtbs.tar.xz',
>          '97e5e65a7e6c68303e53486af120c0846ee8df572e9c15f0c4dccb831d0cef4b'
>      )
>      ASSET_ROOTFS = Asset(
> diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
> index 48abd5cd27c2..7cd5234432d9 100755
> --- a/tests/functional/riscv64/test_tt_atlantis.py
> +++ b/tests/functional/riscv64/test_tt_atlantis.py
> @@ -14,7 +14,7 @@
>  class TTAtlantis(LinuxKernelTest):
>  
>      ASSET_KERNEL = Asset(
> -        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
>          '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
>      ASSET_ROOTFS = Asset(
>          ('https://github.com/groeck/linux-build-test/raw/'
> diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
> index 6203a45060ce..b470c05300a7 100755
> --- a/tests/functional/riscv64/test_tuxrun.py
> +++ b/tests/functional/riscv64/test_tuxrun.py
> @@ -17,7 +17,7 @@
>  class TuxRunRiscV64Test(TuxRunBaselineTest):
>  
>      ASSET_RISCV64_KERNEL = Asset(
> -        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
> +        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
>          '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
>      ASSET_RISCV64_ROOTFS = Asset(
>          'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
> diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
> index 1dd662aaaf05..420e7146bb10 100755
> --- a/tests/functional/s390x/test_tuxrun.py
> +++ b/tests/functional/s390x/test_tuxrun.py
> @@ -17,10 +17,10 @@
>  class TuxRunS390xTest(TuxRunBaselineTest):
>  
>      ASSET_S390X_KERNEL = Asset(
> -        'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
> +        'https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/bzImage',
>          '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
>      ASSET_S390X_VMLINUX = Asset(
> -        'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
> +        'https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/vmlinux.xz',
>          '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
>      ASSET_S390X_ROOTFS = Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
> diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
> index 1a1138d16aea..d2e6008ae708 100755
> --- a/tests/functional/x86_64/test_tuxrun.py
> +++ b/tests/functional/x86_64/test_tuxrun.py
> @@ -17,10 +17,10 @@
>  class TuxRunX86Test(TuxRunBaselineTest):
>  
>      ASSET_X86_64_KERNEL = Asset(
> -        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
> +        'https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/bzImage',
>          '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
>      ASSET_X86_64_VMLINUX = Asset(
> -        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
> +        'https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/vmlinux.xz',
>          '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
>      ASSET_X86_64_ROOTFS = Asset(
>          'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
> -- 
> 2.56.0.116.g6de20f6092dc
> 

