Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2C9C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEA1-0000R7-3k; Tue, 06 May 2025 05:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fu8x=XW=kaod.org=clg@ozlabs.org>)
 id 1uCE9v-0000PI-Q6; Tue, 06 May 2025 05:00:16 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fu8x=XW=kaod.org=clg@ozlabs.org>)
 id 1uCE9r-0008KQ-PW; Tue, 06 May 2025 05:00:15 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZsC5b17Swz4xMv;
 Tue,  6 May 2025 19:00:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZsC5V5805z4x8f;
 Tue,  6 May 2025 18:59:55 +1000 (AEST)
Message-ID: <bcb2d862-da59-44d4-9697-c252a6d453da@kaod.org>
Date: Tue, 6 May 2025 10:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/22] test/qtest/hace: Add SHA-384 test cases for
 ASPEED HACE model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-16-jamin_lin@aspeedtech.com>
 <901e092f-4aef-4b31-810b-3ae418905f7f@kaod.org>
 <SI2PR06MB5041C7E5A6BF5D51BCD41451FC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB50419F51A1B8C55BC2E1A9EEFC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB50419F51A1B8C55BC2E1A9EEFC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fu8x=XW=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/25 08:51, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: RE: [PATCH v1 15/22] test/qtest/hace: Add SHA-384 test cases for
>> ASPEED HACE model
>>
>> Hi Cédric,
>>
>>> Subject: Re: [PATCH v1 15/22] test/qtest/hace: Add SHA-384 test cases
>>> for ASPEED HACE model
>>>
>>> On 3/21/25 10:26, Jamin Lin wrote:
>>>> Introduced SHA-384 test functions to verify hashing operations.
>>>> Extended support for scatter-gather (`_sg`) and accumulation
>>>> (`_accum`)
>>> tests.
>>>> Updated test result vectors for SHA-384 validation.
>>>>
>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>> ---
>>>>    tests/qtest/aspeed-hace-utils.h |   6 ++
>>>>    tests/qtest/aspeed-hace-utils.c | 168
>>> +++++++++++++++++++++++++++++++-
>>>>    2 files changed, 171 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tests/qtest/aspeed-hace-utils.h
>>>> b/tests/qtest/aspeed-hace-utils.h index 598577c69b..f4440561de
>>>> 100644
>>>> --- a/tests/qtest/aspeed-hace-utils.h
>>>> +++ b/tests/qtest/aspeed-hace-utils.h
>>>> @@ -54,14 +54,20 @@ void aspeed_test_md5(const char *machine, const
>>> uint32_t base,
>>>>                         const uint32_t src_addr);
>>>>    void aspeed_test_sha256(const char *machine, const uint32_t base,
>>>>                            const uint32_t src_addr);
>>>> +void aspeed_test_sha384(const char *machine, const uint32_t base,
>>>> +                        const uint32_t src_addr);
>>>>    void aspeed_test_sha512(const char *machine, const uint32_t base,
>>>>                            const uint32_t src_addr);
>>>>    void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
>>>>                               const uint32_t src_addr);
>>>> +void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
>>>> +                           const uint32_t src_addr);
>>>>    void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
>>>>                               const uint32_t src_addr);
>>>>    void aspeed_test_sha256_accum(const char *machine, const uint32_t
>>> base,
>>>>                                  const uint32_t src_addr);
>>>> +void aspeed_test_sha384_accum(const char *machine, const uint32_t
>> base,
>>>> +                              const uint32_t src_addr);
>>>>    void aspeed_test_sha512_accum(const char *machine, const uint32_t
>>> base,
>>>>                                  const uint32_t src_addr);
>>>>    void aspeed_test_addresses(const char *machine, const uint32_t
>>>> base, diff --git a/tests/qtest/aspeed-hace-utils.c
>>>> b/tests/qtest/aspeed-hace-utils.c index 8fbbba49c1..d3146898c2
>>>> 100644
>>>> --- a/tests/qtest/aspeed-hace-utils.c
>>>> +++ b/tests/qtest/aspeed-hace-utils.c
>>>> @@ -16,7 +16,7 @@
>>>>     * Expected results were generated using command line utitiles:
>>>>     *
>>>>     *  echo -n -e 'abc' | dd of=/tmp/test
>>>> - *  for hash in sha512sum sha256sum md5sum; do $hash /tmp/test;
>>>> done
>>>> + *  for hash in sha512sum sha384sum sha256sum md5sum; do $hash
>>>> + /tmp/test; done
>>>>     *
>>>>     */
>>>>    static const uint8_t test_vector[] = {0x61, 0x62, 0x63}; @@ -29,6
>>>> +29,12 @@ static const uint8_t test_result_sha512[] = {
>>>>        0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a,
>>>> 0xc9,
>>> 0x4f,
>>>>        0xa5, 0x4c, 0xa4, 0x9f};
>>>>
>>>> +static const uint8_t test_result_sha384[] = {
>>>> +    0xcb, 0x00, 0x75, 0x3f, 0x45, 0xa3, 0x5e, 0x8b, 0xb5, 0xa0, 0x3d,
>> 0x69,
>>>> +    0x9a, 0xc6, 0x50, 0x07, 0x27, 0x2c, 0x32, 0xab, 0x0e, 0xde,
>>>> +0xd1,
>>> 0x63,
>>>> +    0x1a, 0x8b, 0x60, 0x5a, 0x43, 0xff, 0x5b, 0xed, 0x80, 0x86, 0x07,
>> 0x2b,
>>>> +    0xa1, 0xe7, 0xcc, 0x23, 0x58, 0xba, 0xec, 0xa1, 0x34, 0xc8,
>>>> +0x25, 0xa7};
>>>> +
>>>>    static const uint8_t test_result_sha256[] = {
>>>>        0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41,
>>>> 0x40,
>>> 0xde,
>>>>        0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17,
>>>> 0x7a, 0x9c, @@ -45,7 +51,7 @@ static const uint8_t test_result_md5[] = {
>>>>     * Expected results were generated using command line utitiles:
>>>>     *
>>>>     *  echo -n -e 'abcdefghijkl' | dd of=/tmp/test
>>>> - *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
>>>> + *  for hash in sha512sum sha384sum sha256sum; do $hash /tmp/test;
>>>> + done
>>>>     *
>>>>     */
>>>>    static const uint8_t test_vector_sg1[] = {0x61, 0x62, 0x63, 0x64,
>>>> 0x65, 0x66}; @@ -60,6 +66,12 @@ static const uint8_t
>>> test_result_sg_sha512[] = {
>>>>        0x84, 0x25, 0x7c, 0x32, 0xc8, 0xf6, 0xd0, 0x85, 0x4a, 0xe6,
>>>> 0xb5,
>>> 0x40,
>>>>        0xf8, 0x6d, 0xda, 0x2e};
>>>>
>>>> +static const uint8_t test_result_sg_sha384[] = {
>>>> +    0x10, 0x3c, 0xa9, 0x6c, 0x06, 0xa1, 0xce, 0x79, 0x8f, 0x08, 0xf8,
>> 0xef,
>>>> +    0xf0, 0xdf, 0xb0, 0xcc, 0xdb, 0x56, 0x7d, 0x48, 0xb2, 0x85, 0xb2,
>> 0x3d,
>>>> +    0x0c, 0xd7, 0x73, 0x45, 0x46, 0x67, 0xa3, 0xc2, 0xfa, 0x5f, 0x1b,
>> 0x58,
>>>> +    0xd9, 0xcd, 0xf2, 0x32, 0x9b, 0xd9, 0x97, 0x97, 0x30, 0xbf,
>>>> +0xaa, 0xff};
>>>> +
>>>>    static const uint8_t test_result_sg_sha256[] = {
>>>>        0xd6, 0x82, 0xed, 0x4c, 0xa4, 0xd9, 0x89, 0xc1, 0x34, 0xec,
>>>> 0x94,
>>> 0xf1,
>>>>        0x55, 0x1e, 0x1e, 0xc5, 0x80, 0xdd, 0x6d, 0x5a, 0x6e, 0xcd,
>>>> 0xe9, 0xf3, @@ -74,7 +86,7 @@ static const uint8_t
>>>> test_result_sg_sha256[]
>>> = {
>>>>     * Expected results were generated using command line utitiles:
>>>>     *
>>>>     *  echo -n -e 'abc' | dd of=/tmp/test
>>>> - *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
>>>> + *  for hash in sha512sum sha384sum sha256sum; do $hash /tmp/test;
>>>> + done
>>>>     */
>>>>    static const uint8_t test_vector_accum_512[] = {
>>>>        0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00, @@ -94,6
>>>> +106,24 @@ static const uint8_t test_vector_accum_512[] = {
>>>>        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>>        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
>>>>
>>>> +static const uint8_t test_vector_accum_384[] = {
>>>> +    0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
>>>> +
>>>>    static const uint8_t test_vector_accum_256[] = {
>>>>        0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
>>>>        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, @@ -112,6
>>>> +142,12 @@ static const uint8_t test_result_accum_sha512[] = {
>>>>        0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a,
>>>> 0xc9,
>>> 0x4f,
>>>>        0xa5, 0x4c, 0xa4, 0x9f};
>>>>
>>>> +static const uint8_t test_result_accum_sha384[] = {
>>>> +    0xcb, 0x00, 0x75, 0x3f, 0x45, 0xa3, 0x5e, 0x8b, 0xb5, 0xa0, 0x3d,
>> 0x69,
>>>> +    0x9a, 0xc6, 0x50, 0x07, 0x27, 0x2c, 0x32, 0xab, 0x0e, 0xde,
>>>> +0xd1,
>>> 0x63,
>>>> +    0x1a, 0x8b, 0x60, 0x5a, 0x43, 0xff, 0x5b, 0xed, 0x80, 0x86, 0x07,
>> 0x2b,
>>>> +    0xa1, 0xe7, 0xcc, 0x23, 0x58, 0xba, 0xec, 0xa1, 0x34, 0xc8,
>>>> +0x25, 0xa7};
>>>> +
>>>>    static const uint8_t test_result_accum_sha256[] = {
>>>>        0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41,
>>>> 0x40,
>>> 0xde,
>>>>        0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17,
>>>> 0x7a, 0x9c, @@ -195,6 +231,40 @@ void aspeed_test_sha256(const char
>>> *machine, const uint32_t base,
>>>>        qtest_quit(s);
>>>>    }
>>>>
>>>> +void aspeed_test_sha384(const char *machine, const uint32_t base,
>>>> +                        const uint32_t src_addr) {
>>>> +    QTestState *s = qtest_init(machine);
>>>> +
>>>> +    const uint32_t digest_addr = src_addr + 0x10000;
>>>> +    uint8_t digest[32] = {0};
>>>> +
>>>> +    /* Check engine is idle, no busy or irq bits set */
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
>>>> +
>>>> +    /* Write test vector into memory */
>>>> +    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
>>>> +
>>>> +    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr,
>>>> +               HACE_ALGO_SHA384);
>>>> +
>>>> +    /* Check hash IRQ status is asserted */
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==,
>>>> + 0x00000200);
>>>> +
>>>> +    /* Clear IRQ status and check status is deasserted */
>>>> +    qtest_writel(s, base + HACE_STS, 0x00000200);
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
>>>> +
>>>> +    /* Read computed digest from memory */
>>>> +    qtest_memread(s, digest_addr, digest, sizeof(digest));
>>>> +
>>>> +    /* Check result of computation */
>>>> +    g_assert_cmpmem(digest, sizeof(digest),
>>>> +                    test_result_sha384, sizeof(digest));
>>>> +
>>>> +    qtest_quit(s);
>>>> +}
>>>> +
>>>>    void aspeed_test_sha512(const char *machine, const uint32_t base,
>>>>                            const uint32_t src_addr)
>>>>    {
>>>> @@ -280,6 +350,57 @@ void aspeed_test_sha256_sg(const char
>> *machine,
>>> const uint32_t base,
>>>>        qtest_quit(s);
>>>>    }
>>>>
>>>> +void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
>>>> +                           const uint32_t src_addr) {
>>>> +    QTestState *s = qtest_init(machine);
>>>> +
>>>> +    const uint32_t src_addr_1 = src_addr + 0x10000;
>>>> +    const uint32_t src_addr_2 = src_addr + 0x20000;
>>>> +    const uint32_t src_addr_3 = src_addr + 0x30000;
>>>> +    const uint32_t digest_addr = src_addr + 0x40000;
>>>> +    uint8_t digest[64] = {0};
>>>
>>> This does not compile (gcc version 14.2.1)
>>>
>>>
>>> ../tests/qtest/aspeed-hace-utils.c: In function ‘aspeed_test_sha384_sg’:
>>> /usr/include/glib-2.0/glib/gtestutils.h:93:84: error: ‘__builtin_memcmp_eq’
>>> specified bound 64 exceeds the size 48 of unterminated array
>>> [-Werror=stringop-overread]
>>>      93 |                                              else if
>>> (__l1 != 0 && __m2 != NULL && memcmp (__m1, __m2, __l1) != 0) \
>>>         |
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../tests/qtest/aspeed-hace-utils.c:399:5: note: in expansion of macro
>>> ‘g_assert_cmpmem’
>>>     399 |     g_assert_cmpmem(digest, sizeof(digest),
>>>         |     ^~~~~~~~~~~~~~~
>>> ../tests/qtest/aspeed-hace-utils.c:69:22: note: referenced argument
>>> declared here
>>>      69 | static const uint8_t test_result_sg_sha384[] = {
>>>         |                      ^~~~~~~~~~~~~~~~~~~~~
>>>
>>
> 
> Sorry, the root cause is that I mistakenly set the digest size to 64 bytes. I will fix it.
> 
> uint8_t digest[64] = {0};
> static const uint8_t test_result_sg_sha384[] = {
>      0x10, 0x3c, 0xa9, 0x6c, 0x06, 0xa1, 0xce, 0x79, 0x8f, 0x08, 0xf8, 0xef,
>      0xf0, 0xdf, 0xb0, 0xcc, 0xdb, 0x56, 0x7d, 0x48, 0xb2, 0x85, 0xb2, 0x3d,
>      0x0c, 0xd7, 0x73, 0x45, 0x46, 0x67, 0xa3, 0xc2, 0xfa, 0x5f, 0x1b, 0x58,
>      0xd9, 0xcd, 0xf2, 0x32, 0x9b, 0xd9, 0x97, 0x97, 0x30, 0xbf, 0xaa, 0xff};
> /* Check result of computation */
>      g_assert_cmpmem(digest, sizeof(digest), ====> 64bytes
>                      test_result_sg_sha384 ===>only 48bytes , sizeof(digest));
> 
> However, I believe explicitly setting the array size is the right approach.
> I’d appreciate your thoughts or suggestions on this.

Yes. Please do that. Since this is an architecture requirement.


Thanks,

C.



> 
> Thanks-Jamin
> 
>>
>> I didn't explicitly set the array size for "test_result_sg_sha384", and the
>> compiler seems to have inferred a size of 64 bytes—likely due to 32-byte
>> alignment.
>> However, the actual SHA384 digest is 48 bytes, which is why your compiler
>> reported an error: it detected a possible buffer overread.
>>
>> There are two possible ways to fix this issue:
>>
>> Solution 1:
>> Define a constant MAX_SIZE_LENGTH (e.g., 64 bytes), and use it for all test
>> result arrays:
>>
>> test_result_sha512[MAX_SIZE_LENGTH];
>> test_result_sha384[MAX_SIZE_LENGTH];
>> However, in this case, we cannot use "sizeof(test_result_sha384)" or
>> "sizeof(test_result_sha256)" in the test code, because the compiler will
>> evaluate them as 128 bytes.
>> Therefore, we should use hardcoded digest lengths (48 for SHA384, 32 for
>> SHA256) when comparing results in the tests.
>>
>> Solution 2:
>> Set the actual digest size explicitly in the array definition:
>> test_result_sha512[64];
>> test_result_sha384[48];
>> This ensures "sizeof()" will return the correct digest size, and we can safely use
>> it in assertions.
>>
>> I prefer solution 2.
>> Let me know which solution you'd prefer to go with.
>>
>> Thanks-Jamin
>>>
>>>
>>>
>>>> +    struct AspeedSgList array[] = {
>>>> +        {  cpu_to_le32(sizeof(test_vector_sg1)),
>>>> +           cpu_to_le32(src_addr_1) },
>>>> +        {  cpu_to_le32(sizeof(test_vector_sg2)),
>>>> +           cpu_to_le32(src_addr_2) },
>>>> +        {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
>>>> +           cpu_to_le32(src_addr_3) },
>>>> +    };
>>>> +
>>>> +    /* Check engine is idle, no busy or irq bits set */
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
>>>> +
>>>> +    /* Write test vector into memory */
>>>> +    qtest_memwrite(s, src_addr_1, test_vector_sg1,
>>> sizeof(test_vector_sg1));
>>>> +    qtest_memwrite(s, src_addr_2, test_vector_sg2,
>>> sizeof(test_vector_sg2));
>>>> +    qtest_memwrite(s, src_addr_3, test_vector_sg3,
>>> sizeof(test_vector_sg3));
>>>> +    qtest_memwrite(s, src_addr, array, sizeof(array));
>>>> +
>>>> +    write_regs(s, base, src_addr,
>>>> +               (sizeof(test_vector_sg1)
>>>> +                + sizeof(test_vector_sg2)
>>>> +                + sizeof(test_vector_sg3)),
>>>> +               digest_addr, HACE_ALGO_SHA384 | HACE_SG_EN);
>>>> +
>>>> +    /* Check hash IRQ status is asserted */
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==,
>>>> + 0x00000200);
>>>> +
>>>> +    /* Clear IRQ status and check status is deasserted */
>>>> +    qtest_writel(s, base + HACE_STS, 0x00000200);
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
>>>> +
>>>> +    /* Read computed digest from memory */
>>>> +    qtest_memread(s, digest_addr, digest, sizeof(digest));
>>>> +
>>>> +    /* Check result of computation */
>>>> +    g_assert_cmpmem(digest, sizeof(digest),
>>>> +                    test_result_sg_sha384, sizeof(digest));
>>>> +
>>>> +    qtest_quit(s);
>>>> +}
>>>> +
>>>>    void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
>>>>                               const uint32_t src_addr)
>>>>    {
>>>> @@ -372,6 +493,47 @@ void aspeed_test_sha256_accum(const char
>>> *machine, const uint32_t base,
>>>>        qtest_quit(s);
>>>>    }
>>>>
>>>> +void aspeed_test_sha384_accum(const char *machine, const uint32_t
>> base,
>>>> +                              const uint32_t src_addr) {
>>>> +    QTestState *s = qtest_init(machine);
>>>> +
>>>> +    const uint32_t buffer_addr = src_addr + 0x10000;
>>>> +    const uint32_t digest_addr = src_addr + 0x40000;
>>>> +    uint8_t digest[64] = {0};
>>>
>>> ../tests/qtest/aspeed-hace-utils.c: In function ‘aspeed_test_sha384_accum’:
>>> /usr/include/glib-2.0/glib/gtestutils.h:93:84: error: ‘__builtin_memcmp_eq’
>>> specified bound 64 exceeds source size 48 [-Werror=stringop-overread]
>>>      93 |                                              else if
>>> (__l1 != 0 && __m2 != NULL && memcmp (__m1, __m2, __l1) != 0) \
>>>         |
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../tests/qtest/aspeed-hace-utils.c:533:5: note: in expansion of macro
>>> ‘g_assert_cmpmem’
>>>     533 |     g_assert_cmpmem(digest, sizeof(digest),
>>>         |     ^~~~~~~~~~~~~~~
>>> ../tests/qtest/aspeed-hace-utils.c:145:22: note: source object declared here
>>>     145 | static const uint8_t test_result_accum_sha384[] = {
>>>         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>>>> +    struct AspeedSgList array[] = {
>>>> +        {  cpu_to_le32(sizeof(test_vector_accum_384) |
>>> SG_LIST_LEN_LAST),
>>>> +           cpu_to_le32(buffer_addr) },
>>>> +    };
>>>> +
>>>> +    /* Check engine is idle, no busy or irq bits set */
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
>>>> +
>>>> +    /* Write test vector into memory */
>>>> +    qtest_memwrite(s, buffer_addr, test_vector_accum_384,
>>>> +                   sizeof(test_vector_accum_384));
>>>> +    qtest_memwrite(s, src_addr, array, sizeof(array));
>>>> +
>>>> +    write_regs(s, base, src_addr, sizeof(test_vector_accum_384),
>>>> +               digest_addr, HACE_ALGO_SHA384 | HACE_SG_EN |
>>>> + HACE_ACCUM_EN);
>>>> +
>>>> +    /* Check hash IRQ status is asserted */
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==,
>>>> + 0x00000200);
>>>> +
>>>> +    /* Clear IRQ status and check status is deasserted */
>>>> +    qtest_writel(s, base + HACE_STS, 0x00000200);
>>>> +    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
>>>> +
>>>> +    /* Read computed digest from memory */
>>>> +    qtest_memread(s, digest_addr, digest, sizeof(digest));
>>>> +
>>>> +    /* Check result of computation */
>>>> +    g_assert_cmpmem(digest, sizeof(digest),
>>>> +                    test_result_accum_sha384, sizeof(digest));
>>>> +
>>>> +    qtest_quit(s);
>>>> +}
>>>> +
>>>>    void aspeed_test_sha512_accum(const char *machine, const uint32_t
>>> base,
>>>>                                  const uint32_t src_addr)
>>>>    {
> 


