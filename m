Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D63FD172DC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnNo-0002EG-NT; Mon, 02 Feb 2026 01:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmnNm-0002E8-Ly
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 01:25:59 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmnNj-0004mw-EP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 01:25:58 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B9197C0281;
 Mon, 02 Feb 2026 09:25:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:435::1:2c] (unknown
 [2a02:6bf:8080:435::1:2c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oPgj9C6AgSw0-cr7fkBOL; Mon, 02 Feb 2026 09:25:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770013551;
 bh=YQV2GokAaDfZQq7242ZDP1r+R4vajhHFUXW1a01kH5A=;
 h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
 b=KWG/ivwcd68ytAeKAfYQS9dwCK34SWifrZpyKZ4q1eLQ9rx4MYxWnJqTPtGhN9ZSO
 OeDMDFKpB6L5JL9JW2FG2kKRGczLnY41ffalaATl6fsiNk4fXw1gaXhE9kvC8xOkrW
 h0QqTr0gm9DkGkqrS5l438YORPF/ZgzO9x4UY4Lc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d3bc7e0d-6c7e-4f0b-8778-61d49613278c@yandex-team.ru>
Date: Mon, 2 Feb 2026 09:25:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] tests/unit: add unit test for qemu_hexdump()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260201221328.72111-1-philmd@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260201221328.72111-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02.02.26 01:13, Philippe Mathieu-Daudé wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Test that the fix in commit 20aa05edc2c ("util/hexdump: fix
> QEMU_HEXDUMP_LINE_WIDTH logic") make sense.
> 
> To not break compilation when we build without 'block', move
> hexdump.c out of "if have_block" in meson.build.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v6:
> - mention commit 20aa05edc2c in desc
> - wrap long lines for checkpatch.pl
> - use g_file_open_tmp()
> ---
>   tests/unit/test-cutils.c | 67 ++++++++++++++++++++++++++++++++++++++++
>   util/meson.build         |  2 +-
>   2 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> index 75fae29003a..d70218ad1c1 100644
> --- a/tests/unit/test-cutils.c
> +++ b/tests/unit/test-cutils.c
> @@ -3626,6 +3626,68 @@ static void test_si_prefix(void)
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
> +    static const uint8_t data[] = {
> +        /* First line: 16 bytes */
> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
> +        /* Second line: 5 bytes (incomplete) */
> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
> +    };
> +    char *fname = NULL;
> +    int fd;
> +    g_autofree char *output = NULL;
> +    size_t size, bytes_read;
> +    FILE *f;
> +
> +    fd = g_file_open_tmp("test-qemu-hexdump-alignment-XXXXXX", &fname, NULL);
> +    g_assert(fd >= 0);
> +    g_assert_nonnull(fname);
> +    f = fdopen(fd, "w+");
> +
> +    g_assert_nonnull(f);
> +
> +    qemu_hexdump(f, "test", data, sizeof(data));
> +
> +    size = ftell(f);
> +    fseek(f, 0, SEEK_SET);
> +
> +    output = g_malloc(size + 1);
> +    bytes_read = 0;
> +    while (bytes_read < size) {
> +        size_t chunk = fread(output + bytes_read, 1, size - bytes_read, f);
> +        if (chunk == 0) {
> +            break;
> +        }
> +        bytes_read += chunk;
> +    }
> +    g_assert_cmpuint(bytes_read, ==, size);
> +    output[size] = '\0';
> +
> +    fclose(f);
> +    close(fd);

As I understand, fclose() is enough, documentation for fdopen() says that original
fd is closed on fclose().

Otherwise, no objections, thanks for resend.

> +    unlink(fname);
> +    g_free(fname);
> +
> +    /* We expect proper alignment of "s is" part on the second line */
> +    static const char *expected =
> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   "
> +            "Hello World! Thi\n"
> +        "test: 0010: 73 20 69 73  20                                      "
> +            "s is \n";
> +
> +    g_assert_cmpstr(output, ==, expected);
> +}
> +
>   int main(int argc, char **argv)
>   {
>       g_test_init(&argc, &argv, NULL);
> @@ -3995,5 +4057,10 @@ int main(int argc, char **argv)
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
> index a0cfdc30ba6..7c9445615d7 100644
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
> @@ -90,7 +91,6 @@ if have_block
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

