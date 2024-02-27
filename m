Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C67AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rev40-0007Ox-Gk; Tue, 27 Feb 2024 05:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rev3x-0007Nj-QL; Tue, 27 Feb 2024 05:51:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rev3v-0002n3-EP; Tue, 27 Feb 2024 05:51:53 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TkZ1V5Kwjz6J9xv;
 Tue, 27 Feb 2024 18:47:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0695A140F4E;
 Tue, 27 Feb 2024 18:51:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 10:51:46 +0000
Date: Tue, 27 Feb 2024 10:51:45 +0000
To: Zhao Liu <zhao1.liu@linux.intel.com>
CC: "Daniel P . =?UTF-8?Q?Berrang=EF=BF=BD?=" <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?Q?Mathieu-Daud=EF=BF=BD?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Alex =?UTF-8?Q?Benn=EF=BF=BDe?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, "Sia Jee Heng" <jeeheng.sia@starfivetech.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-riscv@nongnu.org>,
 <qemu-arm@nongnu.org>, "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <20240227105145.0000106d@Huawei.com>
In-Reply-To: <Zd2pWVH4/eo3HM8j@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <20240226153947.00006fd6@Huawei.com> <Zd2pWVH4/eo3HM8j@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 27 Feb 2024 17:20:25 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> Hi Jonathan,
> 
> > Hi Zhao Liu
> > 
> > I like the scheme.  Strikes a good balance between complexity of description
> > and systems that actually exist. Sure there are systems with more cache
> > levels etc but they are rare and support can be easily added later
> > if people want to model them.  
> 
> Thanks for your support!
> 
> [snip]
> 
> > > +static int smp_cache_string_to_topology(MachineState *ms,  
> > 
> > Not a good name for a function that does rather more than that.  
> 
> What about "smp_cache_get_valid_topology()"?

Looking again, could we return the CPUTopoLevel? I think returning
CPU_TOPO_LEVEL_INVALID will replace -1/0 returns and this can just
be smp_cache_string_to_topology() as you have it in this version.

The check on the return value becomes a little more more complex
and I think you want to squash CPU_TOPO_LEVEL_MAX down so we only
have one invalid value to check at callers..  E.g.

static CPUTopoLevel smp_cache_string_to_topolgy(MachineState *ms,
                                                char *top_str,
                                                Error **errp)
{
    CPUTopoLevel topo = string_to_cpu_topo(topo_str);

    if (topo == CPU_TOPO_LEVEL_MAX || topo == CPU_TOP?O_LEVEL_INVALID) {
        return CPU_TOPO_LEVEL_INVALID;
    }

    if (!machine_check_topo_support(ms, topo) {
        error_setg(errp,
                   "Invalid cache topology level: %s. "
                   "The cache topology should match the CPU topology level",
//Break string like this to make it as grep-able as possible!
                   topo_str);
        return CPU_TOPO_LEVEL_INVALID;
    }

    return topo;

}                


The checks then become != CPU_TOPO_LEVEL_INVALID at each callsite.

Jonathan



