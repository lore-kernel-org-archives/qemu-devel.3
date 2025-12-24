Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB9E74917
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 05:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYHK9-0004Qa-2m; Wed, 24 Dec 2025 00:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYHK7-0004QC-15
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 00:22:11 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYHK5-0004Ho-3O
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 00:22:10 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BO5LpZL061278
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Dec 2025 14:21:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pgWoODZaTEd8qZ+JhOu6YjAzj9ca1N4uvQb6ApdJtdo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1766553712; v=1;
 b=PMKxD9xnuWQoRdiP9Zq1tYoiJlU90Mo7zapvC64wHsPR7jabzcZeVOX4+Fti0jyr
 g1/LH5hW7Yl00w40nn+sVySDfOvPCRM3UYgFHaEOz3Ouf77MA6VSpQuReX1D4AjY
 FYbc6YOF6MqGjVt8lhCud3PU4VpvTMNJ2ydIvtebbcNl3GgVefUhXHEUkyhjjSBG
 9rOrAt2CLDEE/mbU1SLh5EDM2cucLtNM9ZFXyOOqnod0FJ7tdrvhQhN5MNnr4E6Y
 cx6Tupyk+rHP141SdIpOlZ73joVAArfSL8NWeW7g+pOIinJaBTiTkiuCHcz/C8o2
 vHV4M5K9V/ztDv19zaNVGg==
Message-ID: <3a1bf99d-e011-4589-b7e9-662107befdc1@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Dec 2025 14:21:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Implement memory_region_new_* functions
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@linaro.org
References: <cover.1766525089.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <cover.1766525089.git.balaton@eik.bme.hu>
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/12/24 6:49, BALATON Zoltan wrote:
> Our documentation says that memory regions are automatically freed
> when the owner dies and the reference counting to do this is also
> implemented. However this relies on the QOM free funtion that can only
> be set by creating objects with object_new but memory API only
> provides constructors that call object_initialize which clears the
> free function that prevents QOM to manage the memory region lifetime.
> Implement corresponding memory_region_new_* functions that do the same
> as the memory_region_init_* functions but create the memory region
> with object_new so the lifetime can be automatically managed by QOM as
> documented.

The documentation explains the existing functions so the discrepancy 
between them you see should be fixed by updating them, not adding new ones.

Regards,
Akihiko Odaki

