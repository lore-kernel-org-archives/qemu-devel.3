Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB3BD262B2
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSbs-0005hV-Q6; Wed, 21 Jan 2026 02:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1viSbq-0005gU-Vp
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:26:35 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1viSbo-00009s-Mn
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:26:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A7A50C0205;
 Wed, 21 Jan 2026 10:26:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:96e::1:11] (unknown
 [2a02:6bf:8080:96e::1:11])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QQV7AD2BHqM0-2S1gErHh; Wed, 21 Jan 2026 10:26:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768980387;
 bh=UlHkwm6CvskLJ8NSzTmGTEMzx7kvRWjSIy385wjWeKg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=x5NEsApUgOwcVBfeOqbztFaw2hP3mW2zYseAQfFqoWRFVqd2e4gdqLDZR5pL5ZU93
 eNUGijVjARON4higHgvqEKbvGoKcnYGUTopfLrw3J8weme+yS42jivNRkr51W9VuKj
 AIGUJXUWUyWLv5yfjG8rZnpJsAVtt8a54+8voQDI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0d7945a4-3886-483b-8c78-63a4a4e6353d@yandex-team.ru>
Date: Wed, 21 Jan 2026 10:26:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/unit: add unit test for qemu_hexdump()
To: philmd@linaro.org
Cc: berrange@redhat.com, qemu-devel@nongnu.org
References: <20260120171848.455742-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260120171848.455742-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.01.26 20:18, Vladimir Sementsov-Ogievskiy wrote:
> Test, that fix in previous commit make sense.
> 
> To not break compilation when we build without
> 'block', move hexdump.c out of "if have_block"
> in meson.build.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/unit/test-cutils.c | 51 ++++++++++++++++++++++++++++++++++++++++
>   util/meson.build         |  2 +-
>   2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index 75fae29003..5f22b83564 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c
> @@ -3626,6 +3626,52 @@ static void test_si_prefix(void)
>       g_assert_cmpstr(si_prefix(18), ==, "E");
>   }
>   
> +static void test_qemu_hexdump_alignment(void)
> +{
> +    /*
> +     * Test that ASCII part is properly aligned for incomplete lines.
> +     * This test catches the bug that was fixed in previous commit
> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
> +     *
> +     * We use data that is not aligned to 16 bytes, so last line
> +     * is incomplete.
> +     */
> +    const uint8_t data[] = {
> +        /* First line: 16 bytes */
> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
> +        /* Second line: 5 bytes (incomplete) */
> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
> +    };
> +    g_autofree char *output = NULL;
> +    size_t size, bytes_read;
> +
> +#define TEST_FILE "test-qemu-hexdump-alignment.txt"
> +    FILE *f = fopen(TEST_FILE, "w+");
> +
> +    g_assert_nonnull(f);
> +
> +    qemu_hexdump(f, "test", data, sizeof(data));
> +
> +    size = ftell(f);
> +    fseek(f, 0, SEEK_SET);
> +
> +    output = g_malloc(size + 1);
> +    bytes_read = fread(output, 1, size, f);

CI fails for msys2-64bit:

# Start of qemu_hexdump tests
not ok /cutils/qemu_hexdump/alignment - ERROR:../tests/unit/test-cutils.c:3661:test_qemu_hexdump_alignment: assertion failed (bytes_read == size): (153 == 155)
Bail out!
----------------------------------- stderr -----------------------------------
**
ERROR:../tests/unit/test-cutils.c:3661:test_qemu_hexdump_alignment: assertion failed (bytes_read == size): (153 == 155)
(test program exited with status code 3)

will send v5...

> +    g_assert_cmpuint(bytes_read, ==, size);
> +    output[size] = '\0';
> +
> +    fclose(f);
> +    unlink(TEST_FILE);
> +
> +    /* We expect proper alignment of "s is" part on the second line */
> +    const char *expected =
> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   Hello World! Thi\n"
> +        "test: 0010: 73 20 69 73  20                                      s is \n";
> +
> +    g_assert_cmpstr(output, ==, expected);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> @@ -3995,5 +4041,10 @@ int main(int argc, char **argv)
>                       test_iec_binary_prefix);
>       g_test_add_func("/cutils/si_prefix",
>                       test_si_prefix);
> +
> +    /* qemu_hexdump() test */
> +    g_test_add_func("/cutils/qemu_hexdump/alignment",
> +                    test_qemu_hexdump_alignment);
> +
>       return g_test_run();
>   }
> diff --git a/util/meson.build b/util/meson.build
> index 59e835a8d3..1804399da0 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -33,6 +33,7 @@ endif
>   util_ss.add(files('defer-call.c'))
>   util_ss.add(files('envlist.c', 'path.c', 'module.c'))
>   util_ss.add(files('event.c'))
> +util_ss.add(files('hexdump.c'))
>   util_ss.add(files('host-utils.c'))
>   util_ss.add(files('bitmap.c', 'bitops.c'))
>   util_ss.add(files('fifo8.c'))
> @@ -92,7 +93,6 @@ if have_block
>     util_ss.add(files('buffer.c'))
>     util_ss.add(files('bufferiszero.c'))
>     util_ss.add(files('hbitmap.c'))
> -  util_ss.add(files('hexdump.c'))
>     util_ss.add(files('iova-tree.c'))
>     util_ss.add(files('iov.c'))
>     util_ss.add(files('nvdimm-utils.c'))


-- 
Best regards,
Vladimir

