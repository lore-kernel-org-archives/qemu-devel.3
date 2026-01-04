Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A9EC2A06F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 03:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcEmU-0000lo-Hk; Sat, 03 Jan 2026 22:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vcEmR-0000lF-1d
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 22:27:47 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vcEmN-00065A-85
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 22:27:46 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6043R4Hl007991
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 4 Jan 2026 12:27:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=r54p1hcQxl1AEaZSZl/mi7S50JCTbZ4g52Kq1htgaYg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1767497244; v=1;
 b=Z61M7YyWpxnF8ltjMCmiPtBQYLasM+yUT5jO6mw6vkNnmwzx5CbhNijwn/fPSvI1
 hCztwfo9nU9jAipofcEz9z5qJixVQU8R4wRBpFsZ+7AanK8D7TD9LWMk4lks9kfe
 r6mb2cXlWag3hjTuivvm1lIfYnI5d9hNLVr8rX4J9wF4LlwBx/YxogyxMBbCW+HX
 2Z3xgH5WC2Bt6QBqsdVWW8SukUFrcmZ0aFwPnG6qpVFahnUDpUuj99LN07WK3EtW
 Dwi4fTZuiDwBmgHOti/cRrmROpD7DKKLlrV0o/2ZSvfOqVMp+3THGoPCS+hw4UMK
 ZfnZkLO3eCraNY/50HdCcw==
Message-ID: <3dfaef3f-f150-495e-8d34-bd82f190bc75@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 4 Jan 2026 12:27:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virtio-gpu-virgl: correct parent for blob memory region
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260103214400.71694-1-j@getutm.app>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260103214400.71694-1-j@getutm.app>
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

On 2026/01/04 6:43, Joelle van Dyne wrote:
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
> However, passing a different `owner` to `memory_region_init` does not
> work. `memory_region_ref` has an optimization where it takes a ref
> only on the owner. That means when flatviews are created, it does not
> take a ref on the region and you can get a UAF from `flatview_destroy`
> called from RCU.
> 
> The correct fix therefore is to use `NULL` as the name which will set
> the `owner` but not the `parent` (which is still NULL). This allows us
> to use `memory_region_ref` on itself while not having to rely on unparent
> for cleanup.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

