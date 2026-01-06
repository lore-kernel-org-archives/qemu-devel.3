Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5833ECE9D74
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9fD-0008A2-Gn; Tue, 06 Jan 2026 11:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vd9fA-00089K-3K; Tue, 06 Jan 2026 11:12:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vd9f7-0001Bq-Vb; Tue, 06 Jan 2026 11:12:03 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlx4m1jT2zHnHLW;
 Wed,  7 Jan 2026 00:11:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id AD7B940571;
 Wed,  7 Jan 2026 00:11:56 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 16:11:55 +0000
Date: Tue, 6 Jan 2026 16:11:54 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <gustavo.romero@linaro.org>,
 <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <maobibo@loongson.cn>, <mst@redhat.com>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <linuxarm@huawei.com>, <zhao1.liu@intel.com>
Subject: Re: [PATCH v17 1/8] target/arm/tcg: increase cache level for cpu=max
Message-ID: <20260106161154.000067f7@huawei.com>
In-Reply-To: <20260106155828.643-2-alireza.sanaee@huawei.com>
References: <20260106155828.643-1-alireza.sanaee@huawei.com>
 <20260106155828.643-2-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.156]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 6 Jan 2026 15:58:20 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> This patch addresses cache description in the `aarch64_max_tcg_initfn`
> function for cpu=max. It introduces three levels of caches and modifies
> the cache description registers accordingly.
Hi Ali,

Not (I think) worth a respin, but this would ideally say why.
Maybe something about presenting a more realistic setup and ensuring
the cache topology can be sufficiently complex to exercise that code
on TCG?

J
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  target/arm/tcg/cpu64.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 917db5bb09..be192d62ff 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1167,6 +1167,16 @@ void aarch64_max_tcg_initfn(Object *obj)
>      uint64_t t;
>      uint32_t u;
>  
> +    SET_IDREG(isar, CLIDR, 0x8200123);
> +    /* 64KB L1 dcache */
> +    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    /* 64KB L1 icache */
> +    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    /* 1MB L2 unified cache */
> +    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
> +    /* 2MB L3 unified cache */
> +    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
> +
>      /*
>       * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
>       * to because we started with aarch64_a57_initfn(). A 'max' CPU might


