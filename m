Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B6FE74902
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 05:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYHUD-0006Tn-O9; Wed, 24 Dec 2025 00:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYHTq-0006T7-OZ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 00:32:17 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYHTo-0007xH-Ar
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 00:32:14 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BO5VCWk065031
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Dec 2025 14:32:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=urDunSip2voxy2onRe+fTxc2/q8i2vTwdecip/2Se4o=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1766554323; v=1;
 b=qPCnsdJBLJVGt2/IAJ2vJ1HCLaMgMo6l3IRNMchhAfWVnlzfPzox/yUNZNlT2iof
 DxrELlgkUwrrSUR9oDrvN4EQvI9LuTPQGMp1JvEtTzksU3nbmi3c7to7ToGYc9Ab
 +12Ex+HUklkKYbYfkidgBBWJHclHOB1Od6NWuZQtjgkcvXeYaDv1DUPstQUMlySL
 hNwC8Wx5pdcapKXLBso2oEdBkqUWKs2cGtYNgo2PzoXxys/QIFrYLj4KFDmRaPYl
 U39KIHEMGIPOaXt0Du4f3EUmsKmwY0Xf/oCq0TCBvQsvbse3ltvxk+V8zVH2pKkm
 wll4kmTsbVs7ma5EUXPUQA==
Message-ID: <247c13de-cae3-4855-bf08-0300d3633ae8@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Dec 2025 14:31:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu-virgl: correct parent for blob memory region
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20251223184023.1913-1-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251223184023.1913-1-j@getutm.app>
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

On 2025/12/24 3:40, Joelle van Dyne wrote:
> When `owner` == `mr`, `object_unparent` will crash:
> 
> object_unparent(mr) ->
> object_property_del_child(mr, mr) ->
> object_finalize_child_property(mr, name, mr) ->
> object_unref(mr) ->
> object_finalize(mr) ->
> object_property_del_all(mr) ->
> object_finalize_child_property(mr, name, mr) ->
> object_unref(mr) ->
> fail on g_assert(obj->ref > 0)
> 
> However, passing a different `owner` to `memory_region_init` is not
> enough. `memory_region_ref` has an optimization where it takes a ref
> only on the owner. It specifically warns against calling unparent on
> the memory region. So we initialize the memory region first and then
> patch in the owner with itself.

Patching outside system/memory.c can be fragile.

I think an object is being a child of itself, which doesn't make sense. 
This can be avoided by passing NULL as name. The object will be an 
orphan so it will have to be freed with object_unref() instead of 
object_unparent().

Regards,
Akihiko Odaki

