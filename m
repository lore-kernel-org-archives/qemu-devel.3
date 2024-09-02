Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F2CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4Fg-0002I5-UH; Mon, 02 Sep 2024 06:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sl4Fe-0002FW-Q9; Mon, 02 Sep 2024 06:25:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1sl4Fc-0007Ln-19; Mon, 02 Sep 2024 06:25:38 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wy4Yj2hz0z6LD8k;
 Mon,  2 Sep 2024 18:22:01 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
 by mail.maildlp.com (Postfix) with ESMTPS id 9162E140B55;
 Mon,  2 Sep 2024 18:25:24 +0800 (CST)
Received: from localhost (10.47.78.245) by lhrpeml500006.china.huawei.com
 (7.191.161.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 11:25:23 +0100
Date: Mon, 2 Sep 2024 11:25:19 +0100
To: Zhao Liu <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <zhenyu.z.wang@intel.com>, 
 <dapeng1.mi@linux.intel.com>, <yongwei.ma@intel.com>, <armbru@redhat.com>, 
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <mst@redhat.com>,
 <anisinha@redhat.com>, <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>,
 <mtosatti@redhat.com>, <berrange@redhat.com>, <richard.henderson@linaro.org>, 
 <linuxarm@huwei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <Jonathan.Cameron@huawei.com>, <jiangkunkun@huawei.com>
Subject: Re: [RFC PATCH 0/2] Specifying cache topology on ARM
Message-ID: <20240902112519.00005b67@huawei.com>
In-Reply-To: <ZtL9u9kQcx0GtEKq@intel.com>
References: <20240823125446.721-1-alireza.sanaee@huawei.com>
 <ZtL9u9kQcx0GtEKq@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.78.245]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 31 Aug 2024 19:25:47 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Alireza,
> 
> Great to see your Arm side implementation!
> 
> On Fri, Aug 23, 2024 at 01:54:44PM +0100, Alireza Sanaee wrote:
> > Date: Fri, 23 Aug 2024 13:54:44 +0100
> > From: Alireza Sanaee <alireza.sanaee@huawei.com>
> > Subject: [RFC PATCH 0/2] Specifying cache topology on ARM
> > X-Mailer: git-send-email 2.34.1
> >   
> 
> [snip]
> 
> > 
> > The following command will represent the system.
> > 
> > ./qemu-system-aarch64 \
> >  -machine virt,**smp-cache=cache0** \
> >  -cpu max \
> >  -m 2048 \
> >  -smp sockets=2,clusters=1,cores=2,threads=2 \
> >  -kernel ./Image.gz \
> >  -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
> >  -initrd rootfs.cpio.gz \
> >  -bios ./edk2-aarch64-code.fd \
> >  **-object
> > '{"qom-type":"smp-cache","id":"cache0","caches":[{"name":"l1d","topo":"core"},{"name":"l1i","topo":"core"},{"name":"l2","topo":"cluster"},{"name":"l3","topo":"socket"}]}'**
> > \ -nographic  
> 
> I plan to refresh a new version soon, in which the smp-cache array
> will be integrated into -machine totally. And I'cc you then.
> 
> Regards,
> Zhao
> 
> 


Hi Zhao,

Yes, please keep me CCed. 

One thing that I noticed, sometimes, since you were going down the
Intel path, some variables couldn't be NULL. But when I was gonna go
down to ARM path, I faced some scenarios where I ended up with
some uninit vars which is still OK but could have been avoided.

Looking forward to the next revision.

Alireza

