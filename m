Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AE5C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 16:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s96Dc-00038Q-4A; Mon, 20 May 2024 12:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s96Da-00036c-EC
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:50:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s96DW-0001R5-40
 for qemu-devel@nongnu.org; Mon, 20 May 2024 12:50:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjk410C0dz6JB8l;
 Tue, 21 May 2024 00:46:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 155CC1408F9;
 Tue, 21 May 2024 00:50:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 17:50:14 +0100
Date: Mon, 20 May 2024 17:50:12 +0100
To: fan <nifan.cxl@gmail.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240520175012.000045fe@Huawei.com>
In-Reply-To: <ZjLCS8yJC-OvPsUS@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org> <ZjLCS8yJC-OvPsUS@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 1 May 2024 15:29:31 -0700
fan <nifan.cxl@gmail.com> wrote:

> From 873f59ec06c38645768ada452d9b18920a34723e Mon Sep 17 00:00:00 2001
> From: Fan Ni <fan.ni@samsung.com>
> Date: Tue, 20 Feb 2024 09:48:31 -0800
> Subject: [PATCH] hw/cxl/events: Add qmp interfaces to add/release dynamic
>  capacity extents
> Status: RO
> Content-Length: 25172
> Lines: 731
> 
> To simulate FM functionalities for initiating Dynamic Capacity Add
> (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> add/release dynamic capacity extents requests.
> 
> With the change, we allow to release an extent only when its DPA range
> is contained by a single accepted extent in the device. That is to say,
> extent superset release is not supported yet.
> 
> 1. Add dynamic capacity extents:
> 
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "host-id": 0,
>       "selection-policy": 2,
>       "region": 0,
>       "tag": "",
>       "extents": [
>       {
>           "offset": 0,
>           "len": 134217728
>       },
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> 2. Release dynamic capacity extents:
> 
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) looks like below:
> 
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "host-id": 0,
>       "flags": 1,
>       "region": 0,
>       "tag": "",
>       "extents": [
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Hi Fan,

A few trivial questions inline.  I don't feel particularly strongly
about breaking up the flags fields, but I'd like to understand your
reasoning for keeping them as single fields?

Is it mainly to keep aligned with the specification or something else?

Thanks,

Jonathan


>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4281726dec..27cf39f448 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -361,3 +361,93 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDynamicCapacityExtent:
> +#
> +# A single dynamic capacity extent
> +#
> +# @offset: The offset (in bytes) to the start of the region
> +#     where the extent belongs to
> +#
> +# @len: The length of the extent in bytes
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'CXLDynamicCapacityExtent',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to initiate to add dynamic capacity extents to a host.  It
> +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
> +#
> +# @path: CXL DCD canonical QOM path
> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# @selection-policy: The "Selection Policy" bits as defined in
> +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> +#     selecting which extents comprise the added capacity.

Hmm. This one is defined as a selection of nameable choices.  Perhaps
worth an enum?  If we did do that, we'd also need to break the flags
on in the release flags below.


> +#
> +# @region: The "Region Number" field as defined in cxl spec r3.1
> +#     Table 7-70.  The dynamic capacity region where the capacity
> +#     is being added.  Valid range is from 0-7.
> +#
> +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
> +#
> +# @extents: The "Extent List" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'selection-policy': 'uint8',
> +            'region': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to initiate to release dynamic capacity extents from a
> +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> +#
> +# @path: CXL DCD canonical QOM path
> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# @flags: The "Flags" field as defined in cxl spec r3.1 Table 7-71,
> +#     with bit[3:0] for removal policy, bit[4] for forced removal,
> +#     bit[5] for sanitize on release, bit[7:6] reserved.

This can be nicely broken up into removal policy enum plus two flags.
It might be worth doing so to give a nicer interface?

> +#
> +# @region: The dynamic capacity region where the extents will be
> +#     released.

This has a better definition in the add dynamic capacity entry above.

> +#
> +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> +#
> +# @extents: The "Extent List" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'flags': 'uint8',
> +            'region': 'uint8',
> +            'tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}


