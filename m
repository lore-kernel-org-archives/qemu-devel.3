Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C67CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 20:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7g3q-0007ZR-TR; Sat, 11 Oct 2025 16:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1v7g0M-0007Jh-M6; Sat, 11 Oct 2025 16:15:51 -0400
Received: from mlugg.co.uk ([2001:19f0:7401:8244:5400:ff:fe24:ff33]
 helo=mail.mlugg.co.uk) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1v7g0J-0000F6-Nb; Sat, 11 Oct 2025 16:15:50 -0400
Received: from [IPV6:2001:8b0:abc0:29bf:feb0:deff:fe18:2817]
 (7.1.8.2.8.1.e.f.f.f.e.d.0.b.e.f.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:feb0:deff:fe18:2817])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 7D65033564;
 Sat, 11 Oct 2025 20:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1760213742; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1CMY6vbH03QNRS3ZtCV5/P05DysaeO1JMz0KFBRlX0=;
 b=IGK63Sm0JYm3MD+y8kn7+ULb8BfQqWIb3YGhh0fcIHvgf8TSLPzE50FMvcj83ljFcs50f9
 61p2fapZ7WUoXsbsHV2U7Xr5dTBoesc486OeGytGOMnuoDgwvudOzeLTKp4Zh/NT/ypICH
 gfnAjOcPnsshyyxHTP/5wrRiARNMffQ=
Message-ID: <fd4df938-881f-4265-8132-31f414bd57f2@mlugg.co.uk>
Date: Sat, 11 Oct 2025 21:15:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests: add tcg coverage for fixed mremap bugs
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-stable@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-5-mlugg@mlugg.co.uk>
Content-Language: en-US
From: Matthew Lugg <mlugg@mlugg.co.uk>
In-Reply-To: <20251011200337.30258-5-mlugg@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:19f0:7401:8244:5400:ff:fe24:ff33;
 envelope-from=mlugg@mlugg.co.uk; helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Oct 2025 16:19:20 -0400
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

I only just noticed I accidentally changed a line in a macro at the top 
of this
file ("FAILED" -> " FAILED"); that was unintentional. I'll omit that 
change from
future versions of this patch.

On 10/11/25 21:03, Matthew Lugg wrote:
> These tests cover the first two fixes in this patch series. The final
> patch is not covered because the bug it fixes is not easily observable
> by the guest.
>
> Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
> ---
>   tests/tcg/multiarch/test-mmap.c | 47 +++++++++++++++++++++++++++++----
>   1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
> index 96257f8ebe..64df694d1a 100644
> --- a/tests/tcg/multiarch/test-mmap.c
> +++ b/tests/tcg/multiarch/test-mmap.c
> @@ -22,6 +22,7 @@
>    * along with this program; if not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#define _GNU_SOURCE
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <stdint.h>
> @@ -36,12 +37,12 @@
>   do                                                             \
>   {                                                              \
>     if (!(x)) {                                                  \
> -    fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
> +    fprintf(stderr, " FAILED at %s:%d\n", __FILE__, __LINE__); \
>       exit (EXIT_FAILURE);                                       \
>     }                                                            \
>   } while (0)
>   
> -unsigned char *dummybuf;
> +unsigned char *dummybuf; /* length is 2*pagesize */
>   static unsigned int pagesize;
>   static unsigned int pagemask;
>   int test_fd;
> @@ -439,21 +440,56 @@ void check_invalid_mmaps(void)
>   {
>       unsigned char *addr;
>   
> +    fprintf(stdout, "%s", __func__);
> +
>       /* Attempt to map a zero length page.  */
>       addr = mmap(NULL, 0, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
>       fail_unless(addr == MAP_FAILED);
>       fail_unless(errno == EINVAL);
>   
>       /* Attempt to map a over length page.  */
>       addr = mmap(NULL, -4, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
>       fail_unless(addr == MAP_FAILED);
>       fail_unless(errno == ENOMEM);
>   
> +    /* Attempt to remap a region which exceeds the bounds of memory. */
> +    addr = mremap((void *)((uintptr_t)pagesize * 10), SIZE_MAX & ~(size_t)pagemask, pagesize, 0);
> +    fail_unless(addr == MAP_FAILED);
> +    fail_unless(errno == EFAULT);
> +
>       fprintf(stdout, " passed\n");
>   }
>   
> +void check_shrink_mmaps(void)
> +{
> +    unsigned char *a, *b, *c;
> +    a = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    b = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    c = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +    fail_unless(a != MAP_FAILED);
> +    fail_unless(b != MAP_FAILED);
> +    fail_unless(c != MAP_FAILED);
> +
> +    /* Ensure we can read the full mappings */
> +    memcpy(dummybuf, a, 2 * pagesize);
> +    memcpy(dummybuf, b, 2 * pagesize);
> +    memcpy(dummybuf, c, 2 * pagesize);
> +
> +    /* Shrink the middle mapping in-place; the others should be unaffected */
> +    b = mremap(b, pagesize * 2, pagesize, 0);
> +    fail_unless(b != MAP_FAILED);
> +
> +    /* Ensure we can still access all valid mappings */
> +    memcpy(dummybuf, a, 2 * pagesize);
> +    memcpy(dummybuf, b, pagesize);
> +    memcpy(dummybuf, c, 2 * pagesize);
> +
> +    munmap(a, 2 * pagesize);
> +    munmap(b, pagesize);
> +    munmap(c, 2 * pagesize);
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	char tempname[] = "/tmp/.cmmapXXXXXX";
> @@ -468,7 +504,7 @@ int main(int argc, char **argv)
>   
>   	/* Assume pagesize is a power of two.  */
>   	pagemask = pagesize - 1;
> -	dummybuf = malloc (pagesize);
> +	dummybuf = malloc (pagesize * 2);
>   	printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
>   
>   	test_fd = mkstemp(tempname);
> @@ -496,6 +532,7 @@ int main(int argc, char **argv)
>   	check_file_fixed_eof_mmaps();
>   	check_file_unfixed_eof_mmaps();
>   	check_invalid_mmaps();
> +    check_shrink_mmaps();
>   
>   	/* Fails at the moment.  */
>   	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */

