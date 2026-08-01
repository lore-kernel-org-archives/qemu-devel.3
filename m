Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FDDC55173
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 11:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq8CT-0005Iz-F4; Sat, 01 Aug 2026 07:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq8CO-0005Io-Jv
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 07:48:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq8CL-0002F7-NJ
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 07:48:16 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 671Bm693010794
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 1 Aug 2026 20:48:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Yuz9HI6vWEK/kKsuT6l9WTOU6ILx+T3OLv1apKQIDDg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785584886; v=1;
 b=XHr+kkCe+OugqOz2thLB1JpPqsBMqUZ2zgDMUHhWXeDAk2zl2FriZnmnLgGtL1Wo
 WagD2h976hX0vJ6TdqCdXNNzxgvhbhpfZTDuAl3s8h8INBwPnwXr723z0XXGr6hh
 W3Gcm5f3rLVg8WUxltQ69VOU+5I5ccQiPh5pulp1VpnWypdNlWMxUyDEEb94NBvu
 iSCPYc06g1k+rAWGLJEQ0kpc5TF27szZUtZncYtFoXvGd99m/RWsReOL+eaX1iSW
 b5a/TFSP0CK9W6iMKwaZ4B6hX+Vk9yTyHi3bTB7a32Kbx04LKZmzZSa3UJZRcLhP
 7YsHpNCfV82jh6eFZut/Uw==
Message-ID: <ce7510e0-98f3-4e06-b67b-113f708d0380@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 1 Aug 2026 20:48:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/display/virtio-gpu: validate blob iov size
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com, thuth@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260729161431.1180691-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260729161431.1180691-1-marcandre.lureau@redhat.com>
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

On 2026/07/30 1:14, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio_gpu_resource_create_blob() stores the guest-controlled blob_size
> without checking it against the total size of the iov backing entries.
> Since both values are independently guest-controlled, a malicious guest
> can set blob_size much larger than the actual iov backing. Subsequent
> SET_SCANOUT_BLOB checks bounds against the inflated blob_size, allowing
> a pixman surface to be created over the undersized buffer. Any display
> refresh then reads past the actual allocation, potentially crashing
> QEMU or leaking host memory contents depending on the backing type.
> 
> Validate that the iov backing is at least as large as the declared
> blob_size in create_blob (when nr_entries > 0, since the spec permits
> deferred backing), attach_backing (when attaching to a blob resource),
> and the blob migration load path.
> 
> Fixes: CVE-2026-66021
> Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3945
> Reported-by: "sundayjiang(蒋浩天)" <sundayjiang@tencent.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

