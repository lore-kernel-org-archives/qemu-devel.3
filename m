Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D8BE9E2E2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8ON-0007nJ-Mv; Wed, 11 Feb 2026 06:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8OM-0007n2-25
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:28:22 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vq8OJ-0004cP-Ul
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:28:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 189965969FA;
 Wed, 11 Feb 2026 12:28:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 7sG6J82bFBaO; Wed, 11 Feb 2026 12:28:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1822E596A0D; Wed, 11 Feb 2026 12:28:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 153F65969F3;
 Wed, 11 Feb 2026 12:28:13 +0100 (CET)
Date: Wed, 11 Feb 2026 12:28:13 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: =?UTF-8?Q?Daniel_P=2E_Berrang=EF=BF=BD?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=EF=BF=BD?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
In-Reply-To: <aYwuxfPyExb3Hv8y@intel.com>
Message-ID: <cefd333c-9893-47b7-9c1b-1ebd218b734d@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
 <0193cb6f-7b73-43c1-ac89-93b426d3983e@eik.bme.hu>
 <aYwuxfPyExb3Hv8y@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 11 Feb 2026, Zhao Liu wrote:
>> So another way could be to not use properties for internal settings but add
>> another set of internal properties for those. These could be set the same
>> way but stored in a different hash table and not get mixed with
>> introspectable and user changable properties. But maybe that would be too
>> much refactoring.
>
> Yes, it may require adding interfaces similar to object_property_add/get/
> set, which would need significant changes.

Maybe not that part needs significant changes as you could still use a 
flag the same way adding a parameter to object_property_add/get/set to 
tell it should put the propery in the internal hash but then you need to 
add the other hash and maybe related changes. I don't know how much would 
those be but no new interface is needed just extending existing one as you 
did already.

Regards,
BALATON Zoltan

