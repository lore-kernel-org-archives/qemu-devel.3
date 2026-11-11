Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627B606A89A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=NTYXB4HX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8Gp-0001pb-Io; Wed, 11 Nov 2026 08:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xR8GX-0001oJ-6A
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:21:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xR8GV-0005FC-2C
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:21:28 -0500
Received: from [172.19.247.154] (customer.sttlwax1.isp.starlink.com
 [74.244.199.159] (may be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ABDLJxP014373
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 11 Nov 2026 22:21:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oDZVA5sOAxutwyCgqgoYaDcuYX68EoullRBI4mlUp9c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794403283; v=1;
 b=NTYXB4HXuvJqFxzZ8/zPRNf/w7wmBtTP+Im7z6uRMVn/kuX5L73tFvVUV2Nkv5DY
 CKQQDERIeC1aeREX7XlNBevrfKZREbh0hoj0OuqHZIHr4JBJEaV/f1a+YhA++E96
 GoNeY1WbGEUAQiEIZBwe4xUGh3mPvPUxXzs7XrJBSosZuioK36lir5OVcTgQplv7
 ubWZP5RdMmC4wtjH0pX6hQnT8QyCb597vfR60Xi/Jrkdz53ZE3gfL/lO5wouRMEC
 7EP9dlHxu/0rtmTaBVstvCNE13ecC/wPk9UdC8R/PcrjnaIFkqdZGquz+yfq5jBD
 K1o+5kkPvT2MSNV4dhEHFw==
Message-ID: <e035cc08-d4e2-402c-97a7-02597d43b915@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 11 Nov 2026 05:21:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] virtio-gpu/rutabaga: reject non-32bpp cursor resources
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
 <20261110-master-v1-3-7a0505d6c259@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261110-master-v1-3-7a0505d6c259@redhat.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/10 17:31, Marc-André Lureau wrote:
> The cursor buffer is always 64x64x4, but rutabaga does not check the
> resource format before the transfer read. Gfxstream copies only as many
> bytes as the resource format needs, so an R8_UNORM cursor updates the
> first 4096 bytes of the 16384 byte buffer and leaves the rest untouched,
> while formats with a larger pixel size do not fit the request and fail.
> 
> Refuse cursor resources that are not 32bpp, reusing
> virtio_gpu_get_pixman_format() as the allowlist so the 32bpp formats the
> other backends accept keep working. res->format is the value passed to
> rutabaga_resource_create_3d(), so it matches what gfxstream stores. Blob
> resources carry no format; they were already rejected by the dimension
> check and stay rejected. Log the dimension mismatch and the transfer
> failure as well.
> 
> Fixes: CVE-2026-122027
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
> Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

