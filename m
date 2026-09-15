Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7C8C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6N8w-0001zR-M8; Tue, 15 Sep 2026 02:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x6N8u-0001zF-Jd
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:59:48 -0400
Received: from smtpout9.mo539.mail-out.ovh.net ([51.210.91.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x6N8q-0007Cc-Fl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:59:46 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hkXv74B9Kz4FFJ;
 Tue, 15 Sep 2026 06:59:31 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 15 Sep 2026 06:59:30 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.227])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hkXv66Rbsz6MbP;
 Tue, 15 Sep 2026 06:59:30 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 376A9192403C; Tue, 15 Sep 2026 06:59:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0032333821a-d7e6-433b-ac90-a080adfba0e7,
 F600A384739CB2938D551E0B9A20D51493CD20BB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <269cd02d-df68-454a-8607-c235f1dc3dea@kaod.org>
Date: Tue, 15 Sep 2026 08:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/qtest/aspeed-acry: Allocate SRAM buffers on the
 heap
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260910012422.4065857-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260910012422.4065857-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17064701940348267565
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEjKIwTz0mYlDQl2swrh4HBfqrSYmO1n9PFHHbDcjpUz6ZiTREQ+OPPyurLiuDbnz/O45N4pJdp5xp9ugmuqZeJfCcrwXVkEvuHgJuEalEklLGJrXxc3fuPFxy5F9k3ChzVG+9uC3Ds2AG5h9q6/JI2m91+aGtKsyf4mZ/eeGIIyJsEgxJkdmGednzzVbxZEW+HksMZIh+qldD3X+P+Okr33VBqS263tO1GuS0lVQc0l9jWKYAK9XQDO+LmgRYQKalC+u1yAYJa62D0OXoRJQrtFFKrNBEGFDcwFLnftSwoom4/f2a4Y08lraSfEq+DuDJN/Fz1R8LgU6hWifJVwkNmCXl/WnZY+cHzcklr1aGlvnL/5JW6EfT6tYyZmg0r3D0Dgfw8KVYzFTFWdAs38IA30inkLjQAI1ujpvhpDE44zymVvGL0j4MF+kKtQo5w/fHgq/IIpBezBURG+W7JiVCyEut/bFouxTE3GIiHhxu8xg05B+rO7hNubUq2hHOax1zHkBaPmqp9mU3sHdIo5pJQHf4RTvXngt933gVVKYlgsd5lbez8Ib3fXLCVEy19PFZzYo7h1AEi5HJK8ur7rDjusGtQQgUhr/4PvqGVb88fpWdq8c2FXumzstX1zwy216olMEiyO2vmK6+L0oXYtBMXXuP8mF6EvV0q19LAtAPiIQ
DKIM-Signature: a=rsa-sha256; bh=xPiMEEJEG7DzeKJBMKXLRM10NdHf/WQ4gOHXSmJHbdA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1789455573; v=1;
 b=mMgQe1o+ugNEpFfLp/SG2M59b9GStI26+z4gSU3KgadQBYu+RlvA7nwxKWEw1B5HrlTXhjRo
 GmFy+cL8jORSNYktYW3930my14MYei4b8hgZ0+jAc1X4CS1jlHxNntf96oSqoYFf52bMs7PLttc
 CoKhCHsqh4AFntvKaOgzDd969tViExbCjdHnip4IhDAYvKsYnwA8Q4c10c1AbKY9IslKFrh9dHK
 P4PD+g4CQdDceTwm9dL/bZR4iAcFsVJp0MvBpACl+RD06fGEeYVfd/OQqnsSCqPC39b2KGIkX8H
 UEPYwK6s1ZeOgaPxGOUIXeLqcGDlYo7x0CJmb7yYHwoUw==
Received-SPF: pass client-ip=51.210.91.48; envelope-from=clg@kaod.org;
 helo=smtpout9.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/10/26 03:24, Jamin Lin wrote:
> The ACRY RSA qtest allocates two ACRY_SRAM_SIZE buffers on the
> stack. Since each buffer is nearly 9 KiB, this unnecessarily increases
> the stack usage of test_modexp_rsa() and may cause unexpected failures
> on environments with a limited stack size.
> 
> This reduces the stack usage while preserving the existing test
> behavior.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-acry-test.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/aspeed-acry-test.c b/tests/qtest/aspeed-acry-test.c
> index ec348c2206..51048d697c 100644
> --- a/tests/qtest/aspeed-acry-test.c
> +++ b/tests/qtest/aspeed-acry-test.c
> @@ -327,8 +327,8 @@ static void test_modexp_rsa(const void *opaque)
>           .alg = QCRYPTO_AK_CIPHER_ALGO_RSA,
>           .u.rsa.padding_alg = QCRYPTO_RSA_PADDING_ALGO_RAW,
>       };
> -    uint8_t dram_buf[ACRY_SRAM_SIZE] = { 0 };
> -    uint8_t sram_buf[ACRY_SRAM_SIZE] = { 0 };
> +    g_autofree uint8_t *dram_buf = g_malloc0(ACRY_SRAM_SIZE);
> +    g_autofree uint8_t *sram_buf = g_malloc0(ACRY_SRAM_SIZE);
>       uint8_t result[ACRY_MAX_BYTES] = { 0 };
>       QTestState *qts;
>   
> @@ -345,7 +345,7 @@ static void test_modexp_rsa(const void *opaque)
>       put_bignum_be_bytes(dram_buf, ACRY_MOD_OFFSET, t->n, t->n_len);
>       put_bignum_be_bytes(dram_buf, ACRY_DATA_OFFSET, t->m, t->m_len);
>   
> -    qtest_memwrite(qts, c->dram_addr, dram_buf, sizeof(dram_buf));
> +    qtest_memwrite(qts, c->dram_addr, dram_buf, ACRY_SRAM_SIZE);
>   
>       qtest_writel(qts, c->acry_addr + ACRY_DMA_CMD, ACRY_DMA_CMD_DMEM_AHB);
>       qtest_writel(qts, c->acry_addr + ACRY_DMA_SRC, c->dram_addr);
> @@ -362,7 +362,7 @@ static void test_modexp_rsa(const void *opaque)
>       g_assert_cmphex(qtest_readl(qts, c->acry_addr + ACRY_STATUS), ==,
>                       ACRY_STATUS_RSA_DONE);
>   
> -    qtest_memread(qts, c->sram_addr, sram_buf, sizeof(sram_buf));
> +    qtest_memread(qts, c->sram_addr, sram_buf, ACRY_SRAM_SIZE);
>       get_bignum_be_bytes(sram_buf, ACRY_DATA_OFFSET, result, t->c_len);
>       g_assert_cmpmem(result, t->c_len, t->c, t->c_len);
>   

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


