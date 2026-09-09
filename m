Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A745C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4E8T-0006Dq-Mw; Wed, 09 Sep 2026 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4E8S-0006Di-Kl
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:58:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x4E8Q-0006BP-Ro
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 04:58:28 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6898wJoC056077
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2026 17:58:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=H8pDqeWgN/FSr8BepXPbgT21Kj1WWDMeItYuVz94U+c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788944299; v=1;
 b=NkQP6zvLexOAOy7BrGRBJpQpCfY7LKkJngnO2f/Q+5SpKrdPYkB+yrmsDDm4glYC
 qFBKb4pEAvvjU8DtYW/slVoQDvrNYuvjznh+EtJHYtgkQsXOeDK7F15StoDWtJoe
 qKkY5DWsPlRx74q6hH+g2rutl4WsTB2jREx6LFYWz5c2UojJwDrlfOZ4GGjjFtzs
 wrKmitCi0VGSBpx0XhUtYLA5OhtCH3VtxQeVWf4Xo+zsfc//YmFQjpHI6wAZsVv4
 bYZ8Z/woIve3CqcJUudmxrDPRo0f6f8Q6xwiMatND2gwYsz3tyMXPrpusqlB4gna
 /z851/N/LuzVWGsx9KclJg==
Message-ID: <ae89c37d-c8d3-48b0-84f1-a056f307f123@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 9 Sep 2026 17:58:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/25] hw/display/virtio-gpu: introduce
 virtio_gpu_{simple,virgl}_resource_new()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-3-15b5ae6b0023@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-3-15b5ae6b0023@redhat.com>
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
> All allocation sites used g_new0() which zero-initializes fields.
> However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
> Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
> field initialization in new constructors fix this and reduce code
> duplication.
> 
> This fixes -display dbus with virtio-gpu blob resources. The other
> end is currently receiving qemu fd 0.
> 
> Fixes: 5f899c34af1d (“virtio-gpu: allocate shareable 2d resources on !win32”)
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>


Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

