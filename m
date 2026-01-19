Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15B1D29C39
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrPE-0005mK-W7; Mon, 19 Jan 2026 10:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhrPD-0005lm-II
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:43:03 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhrPA-0003QY-9H
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:43:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CA239C01AC;
 Mon, 19 Jan 2026 18:42:55 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:934::1:38] (unknown
 [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tgbj4X1BDW20-DqFybLBv; Mon, 19 Jan 2026 18:42:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768837375;
 bh=pedr2zCdO5Jx+reEJm0E5dHCsVot+MDVlLoTI2oMMew=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cI7Sgtr0/Qjow2zs8YO74zE9fxcB1uFLC52qpJasijPg3eW1wl8/hDpQ0BUyWIqJG
 e3gZwqsQnvXWcGpl1hSBW434yvjsdVWogLt1WQ/YZcgn7ssFr/0deo0ATsWTfhRhDD
 v4FP/XEsmrrW2UpENdtVO8SdBLwBqiTqVJKrAY9w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8259d920-32bc-41a7-94b9-cd1af9783b6e@yandex-team.ru>
Date: Mon, 19 Jan 2026 18:42:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/unit: add unit test for qemu_hexdump()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com
Cc: qemu-devel@nongnu.org
References: <20251113064935.342018-1-vsementsov@yandex-team.ru>
 <a40731d0-7add-4d09-9a89-902f75e2eede@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <a40731d0-7add-4d09-9a89-902f75e2eede@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi! Isn't this patch lost?

On 14.11.25 00:01, Philippe Mathieu-Daudé wrote:
> On 13/11/25 07:49, Vladimir Sementsov-Ogievskiy wrote:
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
>>   tests/unit/test-cutils.c | 43 ++++++++++++++++++++++++++++++++++++++++
>>   util/meson.build         |  2 +-
>>   2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
>> index 227acc5995..24fef16a7f 100644
>> --- a/tests/unit/test-cutils.c
>> +++ b/tests/unit/test-cutils.c
>> @@ -3626,6 +3626,44 @@ static void test_si_prefix(void)
>>       g_assert_cmpstr(si_prefix(18), ==, "E");
>>   }
>> +static void test_qemu_hexdump_alignment(void)
>> +{
>> +    /*
>> +     * Test that ASCII part is properly aligned for incomplete lines.
>> +     * This test catches the bug that was fixed in previous commit
>> +     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
>> +     *
>> +     * We use data that is not aligned to 16 bytes, so last line
>> +     * is incomplete.
>> +     */
>> +    const uint8_t data[] = {
>> +        /* First line: 16 bytes */
>> +        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
>> +        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
>> +        /* Second line: 5 bytes (incomplete) */
>> +        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
>> +    };
>> +    char *output = NULL;
>> +    size_t size;
>> +    FILE *stream = open_memstream(&output, &size);
>> +
>> +    g_assert_nonnull(stream);
>> +
>> +    qemu_hexdump(stream, "test", data, sizeof(data));
>> +    fclose(stream);
>> +
>> +    g_assert_nonnull(output);
>> +
>> +    /* We expect proper alignment of "s is" part on the second line */
>> +    const char *expected =
>> +        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   Hello World! Thi\n"
>> +        "test: 0010: 73 20 69 73  20                                      s is \n";
> 
> Thanks, queued wrapping the long lines to pass checkpatch.pl,
> as in:
> https://lore.kernel.org/qemu-devel/20251031211518.38503-9-philmd@linaro.org/


-- 
Best regards,
Vladimir

