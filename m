Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E008CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1vn-0001kv-Ma; Thu, 21 May 2026 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wQ1uj-0001YP-2o
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:50:11 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wQ1t8-0000Jh-GG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:50:06 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64LBkxh1049025
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 21 May 2026 20:46:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3hmhj7sLY3Yl68kHCPxgpyDGFrQxMm+KjRIriBcuInw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779364019; v=1;
 b=kCQNavbkmCY0RMW84SYqgnRhb/DizmwZTAv5XFwgDpbh1i51yQWHkIRrDgG6lxwQ
 BVcap6HSQLzXFFegFQbgs9ELchQDp1VwcqwbiwpNHPXAwYpVef/PtL9OIe/8GwVR
 WArt4TdyhXAQyeOPXeYVurmyslB904Pp+Eh/ZVPGcsi/YUqL7YVRp5YjRLPOyqJQ
 TuyPmkHA4PgcE59IMxJj/w6LgGgthMnmQy2Mz8BZDAGaqTaIgarLJeKO3I5O7PS0
 XmOOg/C2z/put4lNNtMbRSmBybQiOKcNVLDKY3ExFxriePQcSjIlbg1dW5IXYDw8
 i2yYnaeBngKhl/HOn/bDJA==
Message-ID: <0ac7ff23-4cf4-4798-a9d1-cfa5dc9a96a6@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 21 May 2026 20:46:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/39] MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-26-armbru@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260521080511.999266-26-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/05/21 17:04, Markus Armbruster wrote:
> We neglected to update MAINTAINERS when we moved
> docs/system/devices/virtio-snd.rst and
> docs/system/devices/virtio-gpu.rst to docs/system/devices/virtio/.
> Update it now.
> 
> Fixes: 487ce6ce99 (docs/system: split VirtIO devices from the rest, 2025-10-16)
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

