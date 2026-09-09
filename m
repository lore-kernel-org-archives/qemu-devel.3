Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EAC79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4EV0-0004Lp-CH; Wed, 09 Sep 2026 05:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4EUy-0004Lc-V3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:21:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4EUx-0000hc-8N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:21:44 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6899Lamm065140
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 18:21:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=YhBHpu1GgJZn+17EEqWfhexFk7lXk90aXlRUn4+vveY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788945696; v=1;
 b=FkxqR91MjiAGQT8EW/2t+a5+wCclILxX/pXJoUQc8xz2MEqqsEDyS9vagPd48vWp
 0KAJDC8zFJoBOUwUsmeDzNq8ZSgjzPb+Oc7siERwov/EXCQIyuVGTWjFl9PmmkGu
 pYNrdL0AxYrwnX9B17ub/yA0XWmm+oyoNAcP903majeAgfZrhRCfXVKQU/ghiSMr
 bNq8ZWBa5y4LoeCwH6LmZ7iIDtfaKwBZQLg0dpawpKDmcND3/SKk+NLcoa0JdCbV
 dJhCX4OGE2bMYyNMQzFvEBvWZSr12hiOT1DcSMN/MTibghfxR+ueH3lGDOTEIsWt
 jyi5sBg0QjQTpSimKVN8Hw==
Message-ID: <f5b7a18b-3e5c-4662-adc1-8048f6d1b5f5@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 18:21:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/25] contrib/vhost-user-gpu: drop scanout_bitmask
 bookkeeping
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-15-15b5ae6b0023@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-15-15b5ae6b0023@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/09/04 22:10, Marc-André Lureau wrote:
> The per-resource scanout_bitmask is a reverse index of which
> scanouts reference a given resource. The information is already
> available from scanout->resource_id. Performance impact should be
> negligible.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

