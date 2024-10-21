Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2663D15D8A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 12:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2roq-0007YG-3E; Mon, 21 Oct 2024 08:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2roo-0007Xi-Gb; Mon, 21 Oct 2024 08:47:30 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cGEO=RR=kaod.org=clg@ozlabs.org>)
 id 1t2rom-0003pl-IH; Mon, 21 Oct 2024 08:47:30 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XXFSr4fCtz4wxf;
 Mon, 21 Oct 2024 23:47:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XXFSk66tYz4w2R;
 Mon, 21 Oct 2024 23:47:18 +1100 (AEDT)
Message-ID: <d4d29a44-3e79-4a47-9301-8c4de18d923d@kaod.org>
Date: Mon, 21 Oct 2024 14:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 13/16] test/qtest/aspeed_smc-test: Support to
 test AST2600
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
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-14-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241018053112.1886173-14-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cGEO=RR=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/18/24 07:31, Jamin Lin wrote:
> Add test_ast2600_evb function and reused testcases for AST2600 testing.
> The spi base address, flash base address and ce index of fmc_cs0 are
> 0x1E620000, 0x20000000 and 0, respectively.
> The default flash model of fmc_cs0 is "mx66u51235f" whose size is 64MB,
> so set jedec_id 0xc2253a.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   tests/qtest/aspeed_smc-test.c | 41 +++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
> index 0171ecf4ed..30f997679c 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -737,21 +737,62 @@ static void test_ast2500_evb(TestData *data)
>       qtest_add_data_func("/ast2500/smc/read_status_reg",
>                           data, test_read_status_reg);
>   }
> +
> +static void test_ast2600_evb(TestData *data)
> +{
> +    int ret;
> +    int fd;
> +
> +    fd = g_file_open_tmp("qtest.m25p80.mx66u51235f.XXXXXX",
> +                         &data->tmp_path, NULL);
> +    g_assert(fd >= 0);
> +    ret = ftruncate(fd, 64 * 1024 * 1024);
> +    g_assert(ret == 0);
> +    close(fd);
> +
> +    data->s = qtest_initf("-machine ast2600-evb "
> +                          "-drive file=%s,format=raw,if=mtd",
> +                          data->tmp_path);
> +
> +    /* fmc cs0 with mx66u51235f flash */
> +    data->flash_base = 0x20000000;
> +    data->spi_base = 0x1E620000;
> +    data->jedec_id = 0xc2253a;
> +    data->cs = 0;
> +    data->node = "/machine/soc/fmc/ssi.0/child[0]";
> +    /* beyond 16MB */
> +    data->page_addr = 0x14000 * FLASH_PAGE_SIZE;
> +
> +    qtest_add_data_func("/ast2600/smc/read_jedec", data, test_read_jedec);
> +    qtest_add_data_func("/ast2600/smc/erase_sector", data, test_erase_sector);
> +    qtest_add_data_func("/ast2600/smc/erase_all",  data, test_erase_all);
> +    qtest_add_data_func("/ast2600/smc/write_page", data, test_write_page);
> +    qtest_add_data_func("/ast2600/smc/read_page_mem",
> +                        data, test_read_page_mem);
> +    qtest_add_data_func("/ast2600/smc/write_page_mem",
> +                        data, test_write_page_mem);
> +    qtest_add_data_func("/ast2600/smc/read_status_reg",
> +                        data, test_read_status_reg);
> +}
>   int main(int argc, char **argv)
>   {
>       TestData palmetto_data;
>       TestData ast2500_evb_data;
> +    TestData ast2600_evb_data;
>       int ret;
>   
>       g_test_init(&argc, &argv, NULL);
>   
>       test_palmetto_bmc(&palmetto_data);
>       test_ast2500_evb(&ast2500_evb_data);
> +    test_ast2600_evb(&ast2600_evb_data);
>       ret = g_test_run();
>   
>       qtest_quit(palmetto_data.s);
>       qtest_quit(ast2500_evb_data.s);
> +    qtest_quit(ast2600_evb_data.s);
>       unlink(palmetto_data.tmp_path);
>       unlink(ast2500_evb_data.tmp_path);
> +    unlink(ast2600_evb_data.tmp_path);
>       return ret;
>   }


