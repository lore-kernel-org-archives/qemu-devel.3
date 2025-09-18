Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F356CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 07:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz9Gm-0003K7-3Z; Thu, 18 Sep 2025 03:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1uz9G8-0002sM-CF; Thu, 18 Sep 2025 03:40:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangjinqian1@huawei.com>)
 id 1uz9G4-00025N-MC; Thu, 18 Sep 2025 03:40:52 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cS6r42YNTzRkHD;
 Thu, 18 Sep 2025 15:35:48 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
 by mail.maildlp.com (Postfix) with ESMTPS id 135C7180B5C;
 Thu, 18 Sep 2025 15:40:26 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 15:40:24 +0800
Message-ID: <e8515205-7ae9-4a1f-9f06-926aaf81a791@huawei.com>
Date: Thu, 18 Sep 2025 15:40:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] arm/cpu: more customization for the kvm host cpu
 model
To: Cornelia Huck <cohuck@redhat.com>, <eric.auger.pro@gmail.com>,
 <eric.auger@redhat.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <kvmarm@lists.linux.dev>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <alex.bennee@linaro.org>, <maz@kernel.org>,
 <oliver.upton@linux.dev>, <sebott@redhat.com>,
 <shameerali.kolothum.thodi@huawei.com>, <armbru@redhat.com>,
 <berrange@redhat.com>, <abologna@redhat.com>, <jdenemar@redhat.com>
CC: <agraf@csgraf.de>, <shahuang@redhat.com>, <mark.rutland@arm.com>,
 <philmd@linaro.org>, <pbonzini@redhat.com>, Zhou Wang
 <wangzhou1@hisilicon.com>, liuyonglong <liuyonglong@huawei.com>
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-9-cohuck@redhat.com>
In-Reply-To: <20250414163849.321857-9-cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.183]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=yangjinqian1@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jinqian Yang <yangjinqian1@huawei.com>
From:  Jinqian Yang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2025/4/15 0:38, Cornelia Huck wrote:
> +/*
> + * decode_idreg_writemap: Generate props for writable fields
> + *
> + * @obj: CPU object
> + * @index: index of the sysreg
> + * @map: writable map for the sysreg
> + * @reg: description of the sysreg
> + */
> +static int
> +decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
> +{
> +    int i = ctz64(map);
> +    int nb_sysreg_props = 0;
> +
> +    while (map) {
> +
> +        ARM64SysRegField *field = get_field(i, reg);
> +        int lower, upper;
> +        uint64_t mask;
> +        char *prop_name;
> +
> +        if (!field) {
> +            /* the field cannot be matched to any know id named field */
> +            warn_report("%s bit %d of %s is writable but cannot be matched",
> +                        __func__, i, reg->name);
> +            warn_report("%s is cpu-sysreg-properties.c up to date?", __func__);
> +            map =  map & ~BIT_ULL(i);
> +            i = ctz64(map);
> +            continue;
> +        }
> +        lower = field->lower;
> +        upper = field->upper;
> +        prop_name = g_strdup_printf("SYSREG_%s_%s", reg->name, field->name);
> +        trace_decode_idreg_writemap(field->name, lower, upper, prop_name);
> +        object_property_add(obj, prop_name, "uint64",
> +                            get_sysreg_prop, set_sysreg_prop, NULL, field);
> +        nb_sysreg_props++;
> +
> +        mask = MAKE_64BIT_MASK(lower, upper - lower + 1);
> +        map = map & ~mask;
> +        i = ctz64(map);
> +    }
> +    trace_nb_sysreg_props(reg->name, nb_sysreg_props);
> +    return 0;
> +}
> +

Hi,

There's a small issue here: the memory for `prop_name` has not been
freed. The memory allocated by `g_strdup_printf` needs to be released
using `g_free`.

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 1f69efe922..af39729fe0 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -446,6 +446,8 @@ decode_idreg_writemap(Object *obj, int index, 
uint64_t map, ARM64SysReg *reg)
          mask = MAKE_64BIT_MASK(lower, upper - lower + 1);
          map = map & ~mask;
          i = ctz64(map);
+
+        g_free(prop_name);
      }
      trace_nb_sysreg_props(reg->name, nb_sysreg_props);
      return 0;
-- 

Thanks,
Jinqian

