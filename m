Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BFDC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Z3R-0002Z2-Os; Mon, 07 Sep 2026 09:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1x3Z3Q-0002Yt-AR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:06:32 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1x3Z3O-0005UZ-A3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1788786358; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kMXbtxrRPaJ+E3qhYLoNEm2le+buDeOVUx7X76PuBvAW03+pMY2a66PLSguK7z3W5SXXfK2Xirkv8GAnpZKMcyhBvwD4f+y8Ye67YCEzVVQpgzeTbYPTl+i4HPPsgDswvnOrsnh5CP+ZloejpY+sqzW/4ZCoJZrbkb2jsO85cPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788786358;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Gf8VYP7N4hATDrTiZzU5GMGZ3enK1g/UcrmTROQWkzM=; 
 b=R/FHwu1RHXN279+TiOJtsYuWr36uyF3EOyacGEGIDaX011iSQDCNhZpbhBqG+PyuQ4ae4GTbL9OPEtdhZpfeNuSjnokGtVfESiRiCvwxGZsYRDjA8eyx4zfjSWZyeWYVgWCP1MxIbHiqpQ1QGMSMbMWGEMeqvDo7FrXE7cBayE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788786357; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Gf8VYP7N4hATDrTiZzU5GMGZ3enK1g/UcrmTROQWkzM=;
 b=L0QgZmHM3nOkKdD2ye4+33yWNIVb/yG0ENQNb169/2jnPHALzTEAqkvSNy29UfVh
 /upEar/QwWHOOC8aVuNkCxMGuETikiKJ1KiFcg12CWaCH6vomcrtXFkzQyU2BuPeyc7
 6IkcntT6ZoBDsc+SCRi0O6EOf+iVQduIu4CnG0Ww=
Received: by mx.zohomail.com with SMTPS id 1788786355604643.0054626038584;
 Mon, 7 Sep 2026 06:05:55 -0700 (PDT)
Message-ID: <fc5c5bc5-d3a5-47f4-8a86-bcd531f0803c@collabora.com>
Date: Mon, 7 Sep 2026 16:05:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: "Huang, Honglei" <honghuan@amd.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Airlie <airlied@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.11;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-op-o11.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/17/26 06:19, Huang, Honglei wrote:
> Hi Michael, Alex, Dmitry, Akihiko,
> 
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm over
> virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The ROCm
> side has
> been supportted by ROCm offical.
> 
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.

The headless context type is totally fine with virtio-gpu. For example,
ChoromeOS wirh crosvm disables display entirely even on guest side by
building virtio-gpu kernel driver without KMS support. This is something
to improve in QEMU to make it work without GL context.

-- 
Best regards,
Dmitry

