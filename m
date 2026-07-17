Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32804C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkfFG-0004Ja-M5; Fri, 17 Jul 2026 05:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkfFF-0004JF-4y; Fri, 17 Jul 2026 05:52:37 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkfFB-0004G9-MC; Fri, 17 Jul 2026 05:52:36 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4h1lZL6zMdz66BP;
 Fri, 17 Jul 2026 09:52:26 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Fri, 17 Jul 2026 09:52:26 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.244])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h1lZL5lxJz1xp5; Fri, 17 Jul 2026 09:52:26 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 78BD39419CC; 
 Fri, 17 Jul 2026 09:52:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0023e3b33ab-5aeb-43d0-aa2f-6b4e1eef9219,
 D28FE153D5A3AE5C5EC95691E5B856C14C2CAAE9) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <dfc7535e-0134-4dbf-a98b-136d0c1f48ba@kaod.org>
Date: Fri, 17 Jul 2026 11:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] tests/qtest/ast2700-smc-test: Add Data FIFO mode
 test
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
 <20260717084559.3477061-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260717084559.3477061-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18111788854098766893
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEIPGjQyOOXMyiXAD5Ankd4DsiLy3HWWdZH7PV/nfC8/ZxV+f9FUNFAJzXQV/dYM+wpxgYuPQGiIJLq/E841n3ICnTxpfwKOxFHvNkC6BpwWxx9h0c/Zt17OPyaavXQhn3h7wfW6nKKhRfnceDiFey1ITgEeIkPjzf6Hz6uIRtW0hsMFi6BwOWBsPjGChF97c0gt4DS0Yr0mv0MopCXMeeS7krVgR8F9Uh/u4PzWmflhbByS59gzsyhiC+6GUfdrm9fCxjvQHfdRUkFwTfGttUHo3QmImRAxGdsbT0acx3QabJfcanbPEb0szNa6UO/rBT3YnHwx8BlWv3Tz+YEgWypOd/e2D1cq5O08jQTO1Cly95InttpddOScv+geqkBT1wls292GUT9/Agne8SeZ8jJCSY6FDTu4lYzotFhicK8+HO4pe6UX+mYeCD4Zpo/fos4oMdh82sISVHueB72W9FIWLMAn51Ei/iMH8RAAnnQCeULIvbFga1tb4thtADk3qvJLEuwHbanwFqUdWQ5lC/4GbhimmtkIX6l13linB/uTPSMIUkKhO9zq4HoLXZzWqwIFjkDHU847pt87l2nCQmyR5lKJ73v30gvKFci3bmWOExF6y7Xmq4RpZL6ntASoRwgPres+Ua8/irgjt62EOQvaVLjNcGB1kd2p8BjoPWWGA
DKIM-Signature: a=rsa-sha256; bh=vvBaxRhPu+eUcr8DQqvK2xxu39LbaSPQcr6iNCxHHjE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784281949; v=1;
 b=Zym1/FLRrcMz+cThtndFtQDOPBx2MSmxFFbyJ5hrZ2OLuqDDNX5Rnq94Rz3Qpv8evgR533UJ
 e/Vwx2lh+K0M3DP5McWQDuLiz75mn/ra/avQLaO9CnjXcMJGD2QDlzQALGfLfiMooGhXUy8fRqJ
 vpQasq8iKd04IUmJoo+SDPBmNSHi5x5GrWeUgrot9mDtNaQZ9mbKsQygGHLnVh3mg6JtJMRuuP3
 AQcpX3ZfYcF5iEa7PuY9U5T+tWQAxi5B1slnPK8fWPnGAEeYIuLjbU64sBN35prh1/m6Jy0gWLv
 OTQGNe70w/ERtH9bO251ojIoRMqknsn9l1K8woMRAiVmg==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 7/17/26 10:46, Jamin Lin wrote:
> Add two qtest cases exercising the new AST2700 Data FIFO-based flash
> access path (R_DATA_FIFO at spi_base + 0x200).
> 
> Write_page_datafifo sends the page-program command and data through
> the FIFO port, then verifies the result via the regular read path.
> Read_page_datafifo writes a page the regular way, then reads it back
> through the FIFO port, so both directions are checked independently.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-smc-utils.h |   4 ++
>   tests/qtest/aspeed-smc-utils.c | 102 +++++++++++++++++++++++++++++++++
>   tests/qtest/ast2700-smc-test.c |   4 ++
>   3 files changed, 110 insertions(+)
> 
> diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
> index 19c557b822..e4f538e579 100644
> --- a/tests/qtest/aspeed-smc-utils.h
> +++ b/tests/qtest/aspeed-smc-utils.h
> @@ -33,6 +33,8 @@
>   #define   CTRL_DUMMY_LOW_SHIFT   6
>   #define   CTRL_DUMMY_HIGH_SHIFT  14
>   #define SR_WEL BIT(1)
> +/* Data fifo */
> +#define R_DATA_FIFO 0x200
>   
>   /*
>    * Flash commands
> @@ -87,5 +89,7 @@ void aspeed_smc_test_read_page_mem_dor(const void *data);
>   void aspeed_smc_test_write_page_dor(const void *data);
>   void aspeed_smc_test_read_page_mem_qor(const void *data);
>   void aspeed_smc_test_write_page_qor(const void *data);
> +void aspeed_smc_test_write_page_datafifo(const void *data);
> +void aspeed_smc_test_read_page_datafifo(const void *data);
>   
>   #endif /* TESTS_ASPEED_SMC_UTILS_H */
> diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
> index 6d75a95578..146332240d 100644
> --- a/tests/qtest/aspeed-smc-utils.c
> +++ b/tests/qtest/aspeed-smc-utils.c
> @@ -57,6 +57,28 @@ static inline uint32_t flash_readl(const AspeedSMCTestData *data,
>       return qtest_readl(data->s, data->flash_base + offset);
>   }
>   
> +/*
> + * Data FIFO port, in spi_base's register bank (not flash_base). Accesses
> + * through the FIFO require the complete user-mode transaction (opcode,
> + * address, and data). Assumes CS0, whose FIFO slot is at R_DATA_FIFO.
> + */
> +static inline void datafifo_writeb(const AspeedSMCTestData *data,
> +                                   uint8_t value)
> +{
> +    qtest_writeb(data->s, data->spi_base + R_DATA_FIFO, value);
> +}
> +
> +static inline void datafifo_writel(const AspeedSMCTestData *data,
> +                                   uint32_t value)
> +{
> +    spi_writel(data, R_DATA_FIFO, value);
> +}
> +
> +static inline uint32_t datafifo_readl(const AspeedSMCTestData *data)
> +{
> +    return spi_readl(data, R_DATA_FIFO);
> +}
> +
>   static void spi_conf(const AspeedSMCTestData *data, uint32_t value)
>   {
>       uint32_t conf = spi_readl(data, R_CONF);
> @@ -826,3 +848,83 @@ void aspeed_smc_test_write_page_qor(const void *data)
>   {
>       test_write_page(data, read_page_qor);
>   }
> +
> +void aspeed_smc_test_write_page_datafifo(const void *data)
> +{
> +    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
> +    uint32_t my_page_addr = test_data->page_addr;
> +    uint32_t some_page_addr = my_page_addr + FLASH_PAGE_SIZE;
> +    uint32_t page[FLASH_PAGE_SIZE / 4];
> +    int i;
> +
> +    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
> +
> +    /*
> +     * Send the complete user-mode transaction (opcode, address, data)
> +     * through the Data FIFO port.
> +     */
> +    spi_ctrl_start_user(test_data);
> +    datafifo_writeb(test_data, EN_4BYTE_ADDR);
> +    datafifo_writeb(test_data, WREN);
> +    datafifo_writeb(test_data, PP);
> +    datafifo_writel(test_data, make_be32(my_page_addr));
> +
> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        datafifo_writel(test_data, make_be32(my_page_addr + i * 4));
> +    }
> +    spi_ctrl_stop_user(test_data);
> +
> +    /* Check what was written, using the regular read path */
> +    read_page(test_data, my_page_addr, page);
> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
> +    }
> +
> +    /* Check some other page. It should be full of 0xff */
> +    read_page(test_data, some_page_addr, page);
> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        g_assert_cmphex(page[i], ==, 0xffffffff);
> +    }
> +
> +    flash_reset(test_data);
> +}
> +
> +void aspeed_smc_test_read_page_datafifo(const void *data)
> +{
> +    const AspeedSMCTestData *test_data = (const AspeedSMCTestData *)data;
> +    uint32_t my_page_addr = test_data->page_addr;
> +    uint32_t page[FLASH_PAGE_SIZE / 4];
> +    int i;
> +
> +    spi_conf(test_data, 1 << (CONF_ENABLE_W0 + test_data->cs));
> +
> +    /* Write the page the regular way */
> +    spi_ctrl_start_user(test_data);
> +    flash_writeb(test_data, 0, EN_4BYTE_ADDR);
> +    flash_writeb(test_data, 0, WREN);
> +    flash_writeb(test_data, 0, PP);
> +    flash_writel(test_data, 0, make_be32(my_page_addr));
> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        flash_writel(test_data, 0, make_be32(my_page_addr + i * 4));
> +    }
> +    spi_ctrl_stop_user(test_data);
> +
> +    /*
> +     * Read it back through the data FIFO port, again sending the whole
> +     * transaction (opcode, address, data) through it.
> +     */
> +    spi_ctrl_start_user(test_data);
> +    datafifo_writeb(test_data, EN_4BYTE_ADDR);
> +    datafifo_writeb(test_data, READ);
> +    datafifo_writel(test_data, make_be32(my_page_addr));
> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        page[i] = make_be32(datafifo_readl(test_data));
> +    }
> +    spi_ctrl_stop_user(test_data);
> +
> +    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
> +        g_assert_cmphex(page[i], ==, my_page_addr + i * 4);
> +    }
> +
> +    flash_reset(test_data);
> +}
> diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
> index f85077e04f..925dbcfaaf 100644
> --- a/tests/qtest/ast2700-smc-test.c
> +++ b/tests/qtest/ast2700-smc-test.c
> @@ -64,6 +64,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
>                           data, aspeed_smc_test_read_page_mem_qor);
>       qtest_add_data_func("/ast2700/smc/write_page_qor",
>                           data, aspeed_smc_test_write_page_qor);
> +    qtest_add_data_func("/ast2700/smc/write_page_datafifo",
> +                        data, aspeed_smc_test_write_page_datafifo);
> +    qtest_add_data_func("/ast2700/smc/read_page_datafifo",
> +                        data, aspeed_smc_test_read_page_datafifo);
>   }
>   
>   int main(int argc, char **argv)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


