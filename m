Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE6DC36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 09:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzudj-0002lf-6Y; Wed, 02 Apr 2025 05:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yfRC=WU=kaod.org=clg@ozlabs.org>)
 id 1tzudg-0002kx-F4; Wed, 02 Apr 2025 05:44:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yfRC=WU=kaod.org=clg@ozlabs.org>)
 id 1tzudd-00025r-UZ; Wed, 02 Apr 2025 05:44:04 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZSKgv59sLz4x3p;
 Wed,  2 Apr 2025 20:43:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZSKgq4qvgz4wbc;
 Wed,  2 Apr 2025 20:43:51 +1100 (AEDT)
Message-ID: <43581924-e627-427c-b290-05f473877c41@kaod.org>
Date: Wed, 2 Apr 2025 11:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/22] test/qtest/hace: Adjust test address range for
 AST1030 due to SRAM limitations
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-15-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250321092623.2097234-15-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yfRC=WU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/21/25 10:26, Jamin Lin wrote:
> The digest_addr is set to "src_addr + 0x1000000", where src_addr is the DRAM
> base address. However, the value 0x1000000 (16MB) is too large because the
> AST1030 does not support DRAM, and its SRAM size is only 768KB.
> 
> A range size of 0x1000 (64KB) is sufficient for HACE test cases, as the test
> vector size does not exceed 64KB.
> 
> Updates:
> 1. Direct Access Mode
> Update digest_addr to "src_addr + 0x1000" in the following functions:

The change does src_addr + 0x10000. Can you please adjust the commit log
or the code ?


Thanks,

C.



> aspeed_test_md5
> aspeed_test_sha256
> aspeed_test_sha512
> 
> 2. Scatter-Gather (SG) Mode
> Update source address for different SG buffer addresses in the following
> functions:
> src_addr1 = src_addr + 0x1000
> src_addr2 = src_addr + 0x2000
> src_addr3 = src_addr + 0x3000
> digest_addr = src_addr + 0x4000
> 
> aspeed_test_sha256_sg
> aspeed_test_sha512_sg
> 
> 3. ACC Mode Update
> Update the SG List start address: src_addr + 0x10000
> Update the SG List buffer size to 0x3000 (192KB).
> 
> buffer_addr = src_addr + 0x10000
> digest_addr = src_addr + 0x40000
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-hace-utils.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
> index 8582847945..8fbbba49c1 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -132,7 +132,7 @@ void aspeed_test_md5(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    uint32_t digest_addr = src_addr + 0x01000000;
> +    uint32_t digest_addr = src_addr + 0x010000;
>       uint8_t digest[16] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -166,7 +166,7 @@ void aspeed_test_sha256(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t digest_addr = src_addr + 0x1000000;
> +    const uint32_t digest_addr = src_addr + 0x10000;
>       uint8_t digest[32] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -200,7 +200,7 @@ void aspeed_test_sha512(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t digest_addr = src_addr + 0x1000000;
> +    const uint32_t digest_addr = src_addr + 0x10000;
>       uint8_t digest[64] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -234,10 +234,10 @@ void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t src_addr_1 = src_addr + 0x1000000;
> -    const uint32_t src_addr_2 = src_addr + 0x2000000;
> -    const uint32_t src_addr_3 = src_addr + 0x3000000;
> -    const uint32_t digest_addr = src_addr + 0x4000000;
> +    const uint32_t src_addr_1 = src_addr + 0x10000;
> +    const uint32_t src_addr_2 = src_addr + 0x20000;
> +    const uint32_t src_addr_3 = src_addr + 0x30000;
> +    const uint32_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[32] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_sg1)),
> @@ -285,10 +285,10 @@ void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t src_addr_1 = src_addr + 0x1000000;
> -    const uint32_t src_addr_2 = src_addr + 0x2000000;
> -    const uint32_t src_addr_3 = src_addr + 0x3000000;
> -    const uint32_t digest_addr = src_addr + 0x4000000;
> +    const uint32_t src_addr_1 = src_addr + 0x10000;
> +    const uint32_t src_addr_2 = src_addr + 0x20000;
> +    const uint32_t src_addr_3 = src_addr + 0x30000;
> +    const uint32_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[64] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_sg1)),
> @@ -336,8 +336,8 @@ void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t buffer_addr = src_addr + 0x1000000;
> -    const uint32_t digest_addr = src_addr + 0x4000000;
> +    const uint32_t buffer_addr = src_addr + 0x10000;
> +    const uint32_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[32] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_accum_256) | SG_LIST_LEN_LAST),
> @@ -377,8 +377,8 @@ void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t buffer_addr = src_addr + 0x1000000;
> -    const uint32_t digest_addr = src_addr + 0x4000000;
> +    const uint32_t buffer_addr = src_addr + 0x10000;
> +    const uint32_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[64] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_accum_512) | SG_LIST_LEN_LAST),


