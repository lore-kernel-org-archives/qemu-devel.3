Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262ADD2C555
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FGC-0002ov-VS; Tue, 22 Oct 2024 09:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=pGrG=RS=kaod.org=clg@ozlabs.org>)
 id 1t3FG2-0002kE-Dz; Tue, 22 Oct 2024 09:49:10 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=pGrG=RS=kaod.org=clg@ozlabs.org>)
 id 1t3FG0-0001cf-2V; Tue, 22 Oct 2024 09:49:10 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XXtnT2lczz4wbr;
 Wed, 23 Oct 2024 00:49:01 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XXtnM6WRQz4wb1;
 Wed, 23 Oct 2024 00:48:55 +1100 (AEDT)
Message-ID: <ead07059-5ec5-4674-a25b-2afbd4a8dba9@kaod.org>
Date: Tue, 22 Oct 2024 15:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] test/qtest/aspeed_smc-test: Introducing a
 "page_addr" data field
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <20241022094110.1574011-13-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241022094110.1574011-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=pGrG=RS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.169, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/22/24 11:41, Jamin Lin wrote:
> Currently, these test cases used the hardcode offset 0x1400000 (0x14000 * 256)
> which was beyond the 16MB flash size for flash page read/write command testing.
> However, the default fmc flash model of ast1030-a1 EVB is "w25q80bl" whose size
> is 1MB. To test all flash models, introduces a new page_addr member in TestData

I will change : s/all/SoC/

> structure, so users can set the offset for flash parge read/write command
> testing.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

with that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   tests/qtest/aspeed_smc-test.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
> index b8ab20b43d..6db18451d2 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -72,6 +72,7 @@ typedef struct TestData {
>       char *tmp_path;
>       uint8_t cs;
>       const char *node;
> +    uint32_t page_addr;
>   } TestData;
>   
>   /*
> @@ -256,7 +257,7 @@ static void assert_page_mem(const TestData *data, uint32_t addr,
>   static void test_erase_sector(const void *data)
>   {
>       const TestData *test_data = (const TestData *)data;
> -    uint32_t some_page_addr = 0x600 * FLASH_PAGE_SIZE;
> +    uint32_t some_page_addr = test_data->page_addr;
>       uint32_t page[FLASH_PAGE_SIZE / 4];
>       int i;
>   
> @@ -308,7 +309,7 @@ static void test_erase_sector(const void *data)
>   static void test_erase_all(const void *data)
>   {
>       const TestData *test_data = (const TestData *)data;
> -    uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
> +    uint32_t some_page_addr = test_data->page_addr;
>       uint32_t page[FLASH_PAGE_SIZE / 4];
>       int i;
>   
> @@ -358,8 +359,8 @@ static void test_erase_all(const void *data)
>   static void test_write_page(const void *data)
>   {
>       const TestData *test_data = (const TestData *)data;
> -    uint32_t my_page_addr = 0x14000 * FLASH_PAGE_SIZE; /* beyond 16MB */
> -    uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
> +    uint32_t my_page_addr = test_data->page_addr;
> +    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
>       uint32_t page[FLASH_PAGE_SIZE / 4];
>       int i;
>   
> @@ -395,8 +396,8 @@ static void test_write_page(const void *data)
>   static void test_read_page_mem(const void *data)
>   {
>       const TestData *test_data = (const TestData *)data;
> -    uint32_t my_page_addr = 0x14000 * FLASH_PAGE_SIZE; /* beyond 16MB */
> -    uint32_t some_page_addr = 0x15000 * FLASH_PAGE_SIZE;
> +    uint32_t my_page_addr = test_data->page_addr;
> +    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
>       uint32_t page[FLASH_PAGE_SIZE / 4];
>       int i;
>   
> @@ -438,7 +439,7 @@ static void test_read_page_mem(const void *data)
>   static void test_write_page_mem(const void *data)
>   {
>       const TestData *test_data = (const TestData *)data;
> -    uint32_t my_page_addr = 0x15000 * FLASH_PAGE_SIZE;
> +    uint32_t my_page_addr = test_data->page_addr;
>       uint32_t page[FLASH_PAGE_SIZE / 4];
>       int i;
>   
> @@ -679,6 +680,8 @@ static void test_palmetto_bmc(TestData *data)
>       data->jedec_id = 0x20ba19;
>       data->cs = 0;
>       data->node = "/machine/soc/fmc/ssi.0/child[0]";
> +    /* beyond 16MB */
> +    data->page_addr = 0x14000 * FLASH_PAGE_SIZE;
>   
>       qtest_add_data_func("/ast2400/smc/read_jedec", data, test_read_jedec);
>       qtest_add_data_func("/ast2400/smc/erase_sector", data, test_erase_sector);


