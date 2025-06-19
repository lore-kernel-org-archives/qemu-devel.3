Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C75C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 10:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSCvl-0005vG-Ml; Thu, 19 Jun 2025 06:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSCvk-0005us-1E
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 06:55:40 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSCvg-0002H8-Sk
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 06:55:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNHSs63zJz6L6Ll;
 Thu, 19 Jun 2025 18:50:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D241C140446;
 Thu, 19 Jun 2025 18:55:20 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Jun
 2025 12:55:19 +0200
Date: Thu, 19 Jun 2025 11:55:18 +0100
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, "Mahmoud
 Mandour" <ma.mandourr@gmail.com>, Bowman Terry <terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <rientjes@google.com>, <dave@stgolabs.net>,
 <joshua.hahnjy@gmail.com>, <rkodsara@amd.com>, <sj@kernel.org>,
 <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <ziy@nvidia.com>,
 <weixugc@google.com>, Bharata B Rao <bharata@amd.com>
Subject: Re: [RFC PATCH v2 QEMU 2/4] hw/cxl: Add emulation of a CXL Hotness
 Monitoring Unit (CHMU)
Message-ID: <20250619115518.00006e40@huawei.com>
In-Reply-To: <20250612155724.1887266-3-Jonathan.Cameron@huawei.com>
References: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
 <20250612155724.1887266-3-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

On Thu, 12 Jun 2025 16:57:22 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> CXL r3.2 defines a CXL Hotness Monitoring Unit. This allows for a CXL
> device to do on device estimation of which 'granuals' of data are 'hot'
> - that is accessed a lot. For a typical application hot data on a CXL
> device both wastes potentially limited bandwidth and many have latency
> impacts. Access counts are therefore a measurable proxy on which to base
> memory placement decisions.
> 
> Typical use cases include:
> 1 - Establishing which data to move to faster RAM in a tiered memory
>     system. Discussions on how to do this in Linux are ongoing so likely
>     use case 2 will happen first.
> 2 - Provide detailed data (at low overhead) on what memory in an
>     application is hot, allowing for optimization of initial data
>     placement on future runs fo the application.
> 
> The focus of this emulation is providing a way to capture 'real' data
> in order to help us develop and tune the kernel stack.
> 
> This emulated device will be fed with data from a QEMU plugin. That
> plugin is responsible for the actual tracking and counting part of
> hotness tracking. This device simply provides a timebase (epoch end
> point) along with configuration and data retrieval.
> 
> The connection to the QEMU plugin providing the data is via a sockets.
> Supply the cxl-type3 device parameter chmu-port=4443 to specify the
> network port as 4443 and ensure the plugin is loaded (see later patch).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Although we don't support downsampling the device is currently reporting that
it does by a factor of 2.  Fix below.

Yuquan Wang ran into some related problems.
Note that with current posted rfc1 kernel driver best bet is just
don't specify the downsampling parameter at all. It will default to none
and doesn't run into the bug here (as we never check the value if not specified).

Whilst testing this I did manage to trigger a double free in qemu, but
I haven't replicated that yet. 

Jonathan


> ---

> +static uint64_t chmu_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    const hwaddr chmu_stride = A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0;
> +    CHMUState *chmu = opaque;
> +    CHMUInstance *chmui;
> +    uint64_t val = 0;
> +    int instance = 0;
> +    int rc;
> +
> +    if (offset >= A_CXL_CHMU0_CAP0) {
> +        instance = (offset - A_CXL_CHMU0_CAP0) / chmu_stride;
> +        /*
> +         * Offset allows register defs for CHMU instance 0 to be used
> +         * for all instances. Includes COMMON_CAP.
> +         */
> +        offset -= chmu_stride * instance;
> +    }
> +
> +    if (instance >= CXL_CHMU_INSTANCES_PER_BLOCK) {
> +        return 0;
> +    }
> +
> +    chmui = &chmu->inst[instance];
> +    switch (offset) {
> +    case A_CXL_CHMU_COMMON_CAP0:
> +        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP0, VERSION, 1);
> +        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP0, NUM_INSTANCES,
> +                         CXL_CHMU_INSTANCES_PER_BLOCK);
> +        break;
> +    case A_CXL_CHMU_COMMON_CAP1:
> +        val = FIELD_DP64(val, CXL_CHMU_COMMON_CAP1, INSTANCE_LENGTH,
> +                         A_CXL_CHMU1_CAP0 - A_CXL_CHMU0_CAP0);
> +        break;
> +    case A_CXL_CHMU0_CAP0:
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MSI_N, chmui->msi_n);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, OVERFLOW_INT, 1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, LEVEL_INT, 1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, EPOCH_TYPE,
> +                         CXL_CHMU0_CAP0_EPOCH_TYPE_GLOBAL);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_R, 1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_W, 1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, TRACKED_M2S_REQ_NONTEE_RW, 1);
> +        /* No emulation of TEE modes yet so don't pretend to support them */
> +
> +        /* Epoch length from 100 milliseconds to 100 second */
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_SCALE,
> +                         CXL_CHMU_EPOCH_LENGTH_SCALE_1SEC);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MAX_EPOCH_LENGTH_VAL, 100);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_SCALE,
> +                         CXL_CHMU_EPOCH_LENGTH_SCALE_100MSEC);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, MIN_EPOCH_LENGTH_VAL, 1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP0, HOTLIST_SIZE,
> +                         CXL_HOTLIST_ENTRIES);
> +        break;
> +    case A_CXL_CHMU0_CAP1:
> +        /* 4KiB and 8KiB only - 2^N * 256 for each bit set */
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, UNIT_SIZES, BIT(4) | BIT(5));
> +        /* No downsampling  - 2^(N - 1) for each bit set */

This spec is a bit confusing around this, but I think it is 2^N

> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, DOWN_SAMPLING_FACTORS, BIT(1));
Hence BIT(0) is appropriate here for no support (full rate only)

> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_EPOCH_BASED, 1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_ALWAYS_ON, 0);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_RANDOMIZED_DOWN_SAMPLING,
> +                         1);
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_OVERLAPPING_ADDRESS_RANGES,
> +                         1);
> +        /*
> +         * Feature to enable a backlog of entries that immediately fill the list
> +         * once space is available. Only relevant if reading list infrequently
> +         * and concerned about stale data. (Not implemented)
> +         */
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP1, FLAGS_INSERT_AFTER_CLEAR, 0);
> +        break;
> +    case A_CXL_CHMU0_CAP2:
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP2, BITMAP_REG_OFFSET,
> +                         A_CXL_CHMU0_RANGE_CONFIG_BITMAP0 - A_CXL_CHMU0_CAP0);
> +        break;
> +    case A_CXL_CHMU0_CAP3:
> +        val = FIELD_DP64(val, CXL_CHMU0_CAP3, HOTLIST_REG_OFFSET,
> +                         A_CXL_CHMU0_HOTLIST0 - A_CXL_CHMU0_CAP0);
> +        break;
> +    case A_CXL_CHMU0_STATUS:
> +        val = FIELD_DP64(val, CXL_CHMU0_STATUS, STATUS_ENABLED,
> +                         chmui->enabled ? 1 : 0);
> +        val = FIELD_DP64(val, CXL_CHMU0_STATUS, OPERATION_IN_PROG,
> +                         0); /* All operations effectively instantaneous */
> +        val = FIELD_DP64(val, CXL_CHMU0_STATUS, COUNTER_WIDTH, 16);
> +        val = FIELD_DP64(val, CXL_CHMU0_STATUS, OVERFLOW_INT,
> +                         chmui->overflow_set ? 1 : 0);
> +        val = FIELD_DP64(val, CXL_CHMU0_STATUS, LEVEL_INT,
> +                         chmui->fill_thresh_set ? 1 : 0);
> +        break;
> +    case A_CXL_CHMU0_CONF0:
> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, M2S_REQ_TO_TRACK, chmui->what);
> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, FLAGS_RANDOMIZE_DOWNSAMPLING, 0);

We hard code the value 0 here which corresponds to BIT(0) above.

> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, FLAGS_INT_ON_OVERFLOW,
> +                         chmui->int_on_overflow);
> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, FLAGS_INT_ON_FILL_THRESH,
> +                         chmui->int_on_fill_thresh);
> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, CONTROL_ENABLE,
> +                         chmui->enabled);
> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, CONTROL_RESET, 0);
> +        val = FIELD_DP64(val, CXL_CHMU0_CONF0, HOTNESS_THRESHOLD,
> +                         chmui->hotness_thresh);
> +        break;


