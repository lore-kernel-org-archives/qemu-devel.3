Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB76C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 09:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzu35-0007pV-2j; Wed, 02 Apr 2025 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yfRC=WU=kaod.org=clg@ozlabs.org>)
 id 1tzu32-0007oo-M0; Wed, 02 Apr 2025 05:06:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yfRC=WU=kaod.org=clg@ozlabs.org>)
 id 1tzu2y-0005tB-Nq; Wed, 02 Apr 2025 05:06:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZSJrD18p9z4x21;
 Wed,  2 Apr 2025 20:06:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZSJr75fyYz4wby;
 Wed,  2 Apr 2025 20:05:59 +1100 (AEDT)
Message-ID: <618c6b0b-845b-4229-90eb-a6fe31d2435d@kaod.org>
Date: Wed, 2 Apr 2025 11:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/22] test/qtest/hace: Update source data and digest
 data type to 64-bit
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
 <20250321092623.2097234-19-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250321092623.2097234-19-jamin_lin@aspeedtech.com>
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
> Currently, the hash data source and digest result buffer addresses are set to
> 32-bit. However, the AST2700 CPU is a 64-bit Cortex-A35 architecture, and its
> DRAM base address is also 64-bit.
> 
> To support AST2700, update the hash data source address and digest result buffer
> address to use 64-bit addressing.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-hace-utils.h | 20 +++----
>   tests/qtest/aspeed-hace-utils.c | 96 ++++++++++++++++-----------------
>   2 files changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
> index f4440561de..0382570fa2 100644
> --- a/tests/qtest/aspeed-hace-utils.h
> +++ b/tests/qtest/aspeed-hace-utils.h
> @@ -51,25 +51,25 @@ struct AspeedMasks {
>   };
>   
>   void aspeed_test_md5(const char *machine, const uint32_t base,
> -                     const uint32_t src_addr);
> +                     const uint64_t src_addr);
>   void aspeed_test_sha256(const char *machine, const uint32_t base,
> -                        const uint32_t src_addr);
> +                        const uint64_t src_addr);
>   void aspeed_test_sha384(const char *machine, const uint32_t base,
> -                        const uint32_t src_addr);
> +                        const uint64_t src_addr);
>   void aspeed_test_sha512(const char *machine, const uint32_t base,
> -                        const uint32_t src_addr);
> +                        const uint64_t src_addr);
>   void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
> -                           const uint32_t src_addr);
> +                           const uint64_t src_addr);
>   void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
> -                           const uint32_t src_addr);
> +                           const uint64_t src_addr);
>   void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
> -                           const uint32_t src_addr);
> +                           const uint64_t src_addr);
>   void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
> -                              const uint32_t src_addr);
> +                              const uint64_t src_addr);
>   void aspeed_test_sha384_accum(const char *machine, const uint32_t base,
> -                              const uint32_t src_addr);
> +                              const uint64_t src_addr);
>   void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
> -                              const uint32_t src_addr);
> +                              const uint64_t src_addr);
>   void aspeed_test_addresses(const char *machine, const uint32_t base,
>                              const struct AspeedMasks *expected);
>   
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
> index d3146898c2..f39bb8ea48 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -153,22 +153,22 @@ static const uint8_t test_result_accum_sha256[] = {
>       0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
>       0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad};
>   
> -static void write_regs(QTestState *s, uint32_t base, uint32_t src,
> -                       uint32_t length, uint32_t out, uint32_t method)
> +static void write_regs(QTestState *s, uint32_t base, uint64_t src,
> +                       uint32_t length, uint64_t out, uint32_t method)
>   {
> -        qtest_writel(s, base + HACE_HASH_SRC, src);
> -        qtest_writel(s, base + HACE_HASH_DIGEST, out);
> +        qtest_writel(s, base + HACE_HASH_SRC, extract64(src, 0, 32));
> +        qtest_writel(s, base + HACE_HASH_DIGEST, extract64(out, 0, 32));
>           qtest_writel(s, base + HACE_HASH_DATA_LEN, length);
>           qtest_writel(s, base + HACE_HASH_CMD, HACE_SHA_BE_EN | method);
>   }
>   
>   void aspeed_test_md5(const char *machine, const uint32_t base,
> -                     const uint32_t src_addr)
> +                     const uint64_t src_addr)
>   
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    uint32_t digest_addr = src_addr + 0x010000;
> +    uint64_t digest_addr = src_addr + 0x010000;
>       uint8_t digest[16] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -198,11 +198,11 @@ void aspeed_test_md5(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha256(const char *machine, const uint32_t base,
> -                        const uint32_t src_addr)
> +                        const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t digest_addr = src_addr + 0x10000;
> +    const uint64_t digest_addr = src_addr + 0x10000;
>       uint8_t digest[32] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -232,11 +232,11 @@ void aspeed_test_sha256(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha384(const char *machine, const uint32_t base,
> -                        const uint32_t src_addr)
> +                        const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t digest_addr = src_addr + 0x10000;
> +    const uint64_t digest_addr = src_addr + 0x10000;
>       uint8_t digest[32] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -266,11 +266,11 @@ void aspeed_test_sha384(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha512(const char *machine, const uint32_t base,
> -                        const uint32_t src_addr)
> +                        const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t digest_addr = src_addr + 0x10000;
> +    const uint64_t digest_addr = src_addr + 0x10000;
>       uint8_t digest[64] = {0};
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -300,22 +300,22 @@ void aspeed_test_sha512(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
> -                           const uint32_t src_addr)
> +                           const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t src_addr_1 = src_addr + 0x10000;
> -    const uint32_t src_addr_2 = src_addr + 0x20000;
> -    const uint32_t src_addr_3 = src_addr + 0x30000;
> -    const uint32_t digest_addr = src_addr + 0x40000;
> +    const uint64_t src_addr_1 = src_addr + 0x10000;
> +    const uint64_t src_addr_2 = src_addr + 0x20000;
> +    const uint64_t src_addr_3 = src_addr + 0x30000;
> +    const uint64_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[32] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_sg1)),
> -           cpu_to_le32(src_addr_1) },
> +           cpu_to_le64(src_addr_1) },


This looks broken to me. The addr field is in the scatter-gather list entry
is 32bit :

   struct AspeedSgList {
           uint32_t len;
           uint32_t addr;
   } __attribute__ ((__packed__));



Thanks,

C.


>           {  cpu_to_le32(sizeof(test_vector_sg2)),
> -           cpu_to_le32(src_addr_2) },
> +           cpu_to_le64(src_addr_2) },
>           {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
> -           cpu_to_le32(src_addr_3) },
> +           cpu_to_le64(src_addr_3) },
>       };
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -351,22 +351,22 @@ void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
> -                           const uint32_t src_addr)
> +                           const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t src_addr_1 = src_addr + 0x10000;
> -    const uint32_t src_addr_2 = src_addr + 0x20000;
> -    const uint32_t src_addr_3 = src_addr + 0x30000;
> -    const uint32_t digest_addr = src_addr + 0x40000;
> +    const uint64_t src_addr_1 = src_addr + 0x10000;
> +    const uint64_t src_addr_2 = src_addr + 0x20000;
> +    const uint64_t src_addr_3 = src_addr + 0x30000;
> +    const uint64_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[64] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_sg1)),
> -           cpu_to_le32(src_addr_1) },
> +           cpu_to_le64(src_addr_1) },
>           {  cpu_to_le32(sizeof(test_vector_sg2)),
> -           cpu_to_le32(src_addr_2) },
> +           cpu_to_le64(src_addr_2) },
>           {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
> -           cpu_to_le32(src_addr_3) },
> +           cpu_to_le64(src_addr_3) },
>       };
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -402,22 +402,22 @@ void aspeed_test_sha384_sg(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
> -                           const uint32_t src_addr)
> +                           const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t src_addr_1 = src_addr + 0x10000;
> -    const uint32_t src_addr_2 = src_addr + 0x20000;
> -    const uint32_t src_addr_3 = src_addr + 0x30000;
> -    const uint32_t digest_addr = src_addr + 0x40000;
> +    const uint64_t src_addr_1 = src_addr + 0x10000;
> +    const uint64_t src_addr_2 = src_addr + 0x20000;
> +    const uint64_t src_addr_3 = src_addr + 0x30000;
> +    const uint64_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[64] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_sg1)),
> -           cpu_to_le32(src_addr_1) },
> +           cpu_to_le64(src_addr_1) },
>           {  cpu_to_le32(sizeof(test_vector_sg2)),
> -           cpu_to_le32(src_addr_2) },
> +           cpu_to_le64(src_addr_2) },
>           {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
> -           cpu_to_le32(src_addr_3) },
> +           cpu_to_le64(src_addr_3) },
>       };
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -453,16 +453,16 @@ void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
> -                              const uint32_t src_addr)
> +                              const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t buffer_addr = src_addr + 0x10000;
> -    const uint32_t digest_addr = src_addr + 0x40000;
> +    const uint64_t buffer_addr = src_addr + 0x10000;
> +    const uint64_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[32] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_accum_256) | SG_LIST_LEN_LAST),
> -           cpu_to_le32(buffer_addr) },
> +           cpu_to_le64(buffer_addr) },
>       };
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -494,16 +494,16 @@ void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha384_accum(const char *machine, const uint32_t base,
> -                              const uint32_t src_addr)
> +                              const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t buffer_addr = src_addr + 0x10000;
> -    const uint32_t digest_addr = src_addr + 0x40000;
> +    const uint64_t buffer_addr = src_addr + 0x10000;
> +    const uint64_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[64] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_accum_384) | SG_LIST_LEN_LAST),
> -           cpu_to_le32(buffer_addr) },
> +           cpu_to_le64(buffer_addr) },
>       };
>   
>       /* Check engine is idle, no busy or irq bits set */
> @@ -535,16 +535,16 @@ void aspeed_test_sha384_accum(const char *machine, const uint32_t base,
>   }
>   
>   void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
> -                              const uint32_t src_addr)
> +                              const uint64_t src_addr)
>   {
>       QTestState *s = qtest_init(machine);
>   
> -    const uint32_t buffer_addr = src_addr + 0x10000;
> -    const uint32_t digest_addr = src_addr + 0x40000;
> +    const uint64_t buffer_addr = src_addr + 0x10000;
> +    const uint64_t digest_addr = src_addr + 0x40000;
>       uint8_t digest[64] = {0};
>       struct AspeedSgList array[] = {
>           {  cpu_to_le32(sizeof(test_vector_accum_512) | SG_LIST_LEN_LAST),
> -           cpu_to_le32(buffer_addr) },
> +           cpu_to_le64(buffer_addr) },
>       };
>   
>       /* Check engine is idle, no busy or irq bits set */


