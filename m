Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B98310A1E7C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5iuM-0006zb-TO; Thu, 26 Mar 2026 07:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5iu6-0006yD-6V
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:29:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w5iu4-0003Yi-0F
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 07:29:33 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fhM4F5ycJzJ46cN;
 Thu, 26 Mar 2026 19:29:17 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E892B40569;
 Thu, 26 Mar 2026 19:29:27 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Mar
 2026 11:29:27 +0000
Date: Thu, 26 Mar 2026 11:29:21 +0000
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisa.su@samsung.com>, <berrange@redhat.com>,
 <eblake@redhat.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
 <nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: Re: [PATCH 1/9] hw/mem: Add tag support to generic host memory
 backends
Message-ID: <20260326112921.000028e6.alireza.sanaee@huawei.com>
In-Reply-To: <87a4vuhnxy.fsf@pond.sub.org>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-2-alireza.sanaee@huawei.com>
 <87a4vuhnxy.fsf@pond.sub.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 26 Mar 2026 11:42:17 +0100
Markus Armbruster <armbru@redhat.com> wrote:

Hi Markus,

> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> 
> > Add a string tag property to HostMemoryBackend so that backends can be
> > identified by a user-assigned name at runtime. Expose the property through
> > QOM and add a host_memory_backend_find_by_tag() helper that walks the
> > object tree to locate a backend by its tag.  
> 
> Why can't you use the QOM ID?
> 
> $ qemu-system-x86_64 -S -display none -monitor stdio -object memory-backend-ram,id=fred,size=1M
> QEMU 10.2.90 monitor - type 'help' for more information
> (qemu) info qom-tree /objects/fred
> /fred (memory-backend-ram)
>   /fred[0] (memory-region)
> 
>  

Fair question. The ID would have been a solution if it had accepted GUIDs. CXL spec 
requires GUIDs for extents as identification, hence new tag property.

alireza@blue-ocean:~/Downloads$ qemu-system-x86_64 -s -display none -monitor std
io -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd76bb79,size=1M
qemu-system-x86_64: -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd
76bb79,size=1M: Parameter 'id' expects an identifier
Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.

Thanks,
Ali



