Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E96CD5BB4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJURa-0003kb-IM; Thu, 13 Nov 2025 05:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJURF-0003VN-Id
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:20:25 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vJURA-0006Dr-KJ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:20:24 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 454C08395F;
 Thu, 13 Nov 2025 13:20:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:833::1:4] (unknown [2a02:6bf:8080:833::1:4])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FKNl9E0FQGk0-vVMyrF1o; Thu, 13 Nov 2025 13:20:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1763029215;
 bh=W5VrETnfWM5jZCUq0DjspkW1eRlxC2D6CIaNtt8COzo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wdKqdoGBSCK1tqmFhSQPAXcYQbpy25+mYpMusC2uVZqwDVZW+VLngRbDnNrTDA2rA
 q3ePHB0z9cpdlNLsHEneEGbLKs6FnM2b9BoLkNjZX5pPzr+XSA7sW6gyouZGheHP4f
 +hFsytHRsHrcYCZJ5sArsXG7PRngeEWharC62U8A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <84b8a084-d8f3-4515-a6f8-23aaca080b37@yandex-team.ru>
Date: Thu, 13 Nov 2025 13:20:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <aRWgdCWsEr3cCSNl@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aRWgdCWsEr3cCSNl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 13.11.25 12:10, Daniel P. Berrangé wrote:
> On Thu, Nov 13, 2025 at 09:49:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Test, that fix in previous commit make sense.
>>
>> To not break compilation when we build without
>> 'block', move hexdump.c out of "if have_block"
>> in meson.build.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> v3: change meson.build to compile hexdump.c always
>>
>>   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
>>   util/meson.build         |  2 +-
>>   2 files changed, 44 insertions(+), 1 deletion(-)
> 
>> +static void test_qemu_hexdump_alignment(void)
>> +{
>> +    /*
>> +     * Test that ASCII part is properly aligned for incomplete lines.
>> +     * This test catches the bug that was fixed in previous commit
>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>> +     *
>> +     * We use data that is not aligned to 16 bytes, so last line
>> +     * is incomplete.
>> +     */
>> +    const uint8_t data[] = {
>> +        /* First line: 16 bytes */
>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
>> +        /* Second line: 5 bytes (incomplete) */
>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
>> +    };
>> +    char *output = NULL;
> 
> Could be  g_autofree, and avoid the later 'free()' call.

I'm not sure that it's correct to replace free() by g_free()..

Documentation says "bad things can happen" https://docs.gtk.org/glib/memory.html

> 
>> +    size_t size;
>> +    FILE *stream = open_memstream(&output, &size);
>> +
>> +    g_assert_nonnull(stream);
>> +
>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>> +    fclose(stream);
>> +
>> +    g_assert_nonnull(output);
>> +
>> +    /* We expect proper alignment of "s is" part on the second line */
>> +    const char *expected =
>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   Hello World! Thi\n"
>> +        "test: 0010: 73 20 69 73  20                                      s is \n";
>> +
>> +    g_assert_cmpstr(output, ==, expected);
>> +
>> +    free(output);
>> +}
> 
> The above comment is trivial, so
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir

