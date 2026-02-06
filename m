Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ED8EB28D6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 08:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGsY-0002HN-2L; Fri, 06 Feb 2026 03:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1voGsV-0002H2-Qu
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:07:47 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1voGsS-0006aL-Ts
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:07:47 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61687EOh099025
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Feb 2026 17:07:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ub1BZFeZzYFwOD4ZElxV/a6Xhoc8HXWKQuC3hcBVF9g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770365255; v=1;
 b=GSHxozTGcXy1GoQODfhN5scpevp/KorjGde9H7UuC72XaVzR9UVZLkHB5DBR14s4
 U5JX/zVl+fXYh56ergswBXFO4pq+SI/SXjpSHPUGNCO8wQN9/HmUH4nnS9hB7Y5W
 lQm92CEC8mnqTmz6aald6QBloHllZpBWKinxd4/QGqFuTzYs5E29xlybEEo0q97N
 tWt4fr/JLMQW1YKEFa0ZkC0UoRN3ooxXlp2Z9viD9Y4uZnIuvBNI/hy/Hgq4cnCU
 yV0fWeMlHLmIK4/wL/UEamAU+tk9jC/tEH4eOASL9quZRook6zGHq09q1Fku1TUQ
 i7UC8drixC0VCSqGO8BxwA==
Message-ID: <bb9c5527-2d1e-4a67-9650-e299eccb5c47@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 6 Feb 2026 17:07:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu-virgl: correct parent for blob memory region
To: Michael Tokarev <mjt@tls.msk.ru>, Joelle van Dyne <j@getutm.app>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20251223184023.1913-1-j@getutm.app>
 <fad0fd0e-99bc-4455-822d-3cca651ab5c2@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <fad0fd0e-99bc-4455-822d-3cca651ab5c2@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/02/06 6:57, Michael Tokarev wrote:
> On 12/23/25 21:40, Joelle van Dyne wrote:
>> When `owner` == `mr`, `object_unparent` will crash:
>>
>> object_unparent(mr) ->
>> object_property_del_child(mr, mr) ->
>> object_finalize_child_property(mr, name, mr) ->
>> object_unref(mr) ->
>> object_finalize(mr) ->
>> object_property_del_all(mr) ->
>> object_finalize_child_property(mr, name, mr) ->
>> object_unref(mr) ->
>> fail on g_assert(obj->ref > 0)
>>
>> However, passing a different `owner` to `memory_region_init` is not
>> enough. `memory_region_ref` has an optimization where it takes a ref
>> only on the owner. It specifically warns against calling unparent on
>> the memory region. So we initialize the memory region first and then
>> patch in the owner with itself.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> 
> This one is quite a bit confusing.
> 
> Is it a qemu-stable material?
> I'm *not* picking it up automatically.

Yes, I think so. It should have had Cc.

Regards,
Akihiko Odaki

