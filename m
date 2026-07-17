Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2472C4450F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkbbv-0003bC-Ai; Fri, 17 Jul 2026 01:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkbbt-0003ao-0v
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 01:59:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkbbp-0007Gt-8T
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 01:59:44 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66H5xLwK040110
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2026 14:59:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=H0DZvmLveY8I6R626o7v9VW1T0PiUvaN0y2R11N7pqo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784267961; v=1;
 b=MH+GszIFFYDejLrt3zqEmALdzlxPh3coAiypr7IwHA5E5kM6vWys916tJeBm7R/g
 o6xHNslRoLZsSNH5xN+aMS5K2uAw/7t5xChGM9XNk2OYqOx8EWe6My9hFmg6wdbN
 nxYdca/OgoJUkESG2bt6pZIDjkBJiATaZ4YIuc2/aCbGnxeW3/H2MwXbyqd2ydjI
 dh1aGxzwrHcKwbdo1LlUaGXVo5nwljrP8qF1lrUI7Srnz+uS2a13IJ9kfsIN8Olt
 RYUvFtVyC0ywky5CE481oQJC/iO5CX/MPAKGNlxs4lTA3VUzbMM+dLCp/78ofLA3
 GJqzKIcXMoe9/4nmdW2jUw==
Message-ID: <f1fd12b1-7fbd-45a1-b36e-206c65a99ac8@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 17 Jul 2026 14:59:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: use BIT() macro for scanout bitmask operations
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com
References: <20260717015252.25675-1-guobin@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260717015252.25675-1-guobin@linux.alibaba.com>
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

On 2026/07/17 10:52, Bin Guo wrote:
> The scanout_bitmask field is uint32_t, but all six bit operations used
> the signed literal `1 << shift`.  When the shift count reaches 31 this
> is undefined behavior (signed integer overflow).  Replace every
> occurrence with the BIT() macro to perform an unsigned shift, which is
> well-defined for all bit positions 0-31 and consistent with QEMU
> bit-operation conventions.
> 
> No functional change; the result is already stored in a uint32_t, so
> the generated code is identical on most platforms.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

