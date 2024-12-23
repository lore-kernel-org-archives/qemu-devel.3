Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77807E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 18:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmuO-0005zk-Dz; Mon, 23 Dec 2024 13:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tPmuL-0005z2-GJ; Mon, 23 Dec 2024 13:11:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tPmuI-0000Y4-0I; Mon, 23 Dec 2024 13:11:57 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YH5bf1q9Zz6K5Ym;
 Tue, 24 Dec 2024 02:07:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E6CD4140517;
 Tue, 24 Dec 2024 02:11:48 +0800 (CST)
Received: from localhost (10.47.75.118) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Dec
 2024 19:11:47 +0100
Date: Mon, 23 Dec 2024 18:11:45 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>, <linuxarm@huawei.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <zhao1.liu@intel.com>,
 <zhenyu.z.wang@intel.com>, <dapeng1.mi@linux.intel.com>,
 <yongwei.ma@intel.com>, <armbru@redhat.com>, <farman@linux.ibm.com>,
 <peter.maydell@linaro.org>, <mst@redhat.com>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <mtosatti@redhat.com>,
 <berrange@redhat.com>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <Jonathan.Cameron@Huawei.com>,
 <jiangkunkun@huawei.com>, <yangyicong@hisilicon.com>, <sarsanaee@gmail.com>
Subject: Re: [PATCH v4 6/7] tests/qtest/bios-table-test: testing new ARM
 ACPI PPTT topology
Message-ID: <20241223181145.00003b06@huawei.com>
In-Reply-To: <20241216175414.1953-7-alireza.sanaee@huawei.com>
References: <20241216175414.1953-1-alireza.sanaee@huawei.com>
 <20241216175414.1953-7-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.118]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Dec 2024 17:54:13 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Test new PPTT topolopy with cache representation.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  tests/qtest/bios-tables-test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 36e5c0adde..0f72520664 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2019,7 +2019,11 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>          .scan_len = 128ULL * 1024 * 1024,
>      };
>  
> -    test_acpi_one("-cpu cortex-a57 "
> +    test_acpi_one("-M virt,smp-cache.0.cache=l1i,smp-cache.0.topology=cluster,"
> +                  "smp-cache.1.cache=l1d,smp-cache.1.topology=cluster,"
> +                  "smp-cache.2.cache=l2,smp-cache.2.topology=cluster,"
> +                  "smp-cache.3.cache=l3,smp-cache.3.topology=cluster "
> +                  "-cpu cortex-a57 "
Trivial but is there a reason the cpu must come after machine / -M bits?
If not I'd leave it on first line to reduce the churn in this patch a little.

Either way,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>      free_test_data(&data);
>  }


