Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A82ACD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpEu-0005gf-Dm; Tue, 26 May 2026 06:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wRpEt-0005gG-3c
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:42:23 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wRpEq-0003Dl-U2
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1779792127; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DUNLZpIk27szSZvMuALvNVhWz5Ep+tRTTDshK5ePLalL+9NNlJ6jW+h53MCxUk219yjBI3Ef3xkg9kNA6JvfXGau/gMBrCuIz4viYUebeAevj6JMmSgcjtF0hW4jopmYv50mZJTFYPKSeifKV4cGov/Fyhm54KkL6F9eVIosHuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779792127;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Wl7iPgw1fde5WndyazRRr9jiwdo7BpdfX7/II43tzeo=; 
 b=DThyliioZ1obJLGarxP9Z7pTs6mIoYi8grknsJoesHuVxAKlr2JYYFJKdtxl4aSenDbXkozwPoTjgRJ3hoQZDeLVTXYljQDlqMURMhQ0CqWLFRsFBiOPzCKROm6XPo9VcDX6OUwjselpD5GG1q8wncgDlyAq4BWo9cX2Jtcx5Dg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779792127; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Wl7iPgw1fde5WndyazRRr9jiwdo7BpdfX7/II43tzeo=;
 b=Nkrvf5N/N2YgHAxpxVTyA5X3Z2T+nuMqPv/pn08RpiPq+fzS2qJA6xbChQnuCnal
 3AVvyHUEQ8OPRlxQSw50S/SGPvHd4rXfg8tzPwnbCf2ni9Ceen/JkLJvXJ5LUoxD+Ik
 StGTbhNYvGeMZDS/TIwRhs3CfdkoxQGhH+wDUHH4=
Received: by mx.zohomail.com with SMTPS id 1779792125102787.5427035739658;
 Tue, 26 May 2026 03:42:05 -0700 (PDT)
Message-ID: <c2d2a4ba-d1ac-4795-a7a0-7bc31f08a79c@collabora.com>
Date: Tue, 26 May 2026 13:41:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/39] MAINTAINERS: Fix F: in "virtio-snd" and "virtio-gpu"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-26-armbru@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260521080511.999266-26-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
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

On 5/21/26 11:04, Markus Armbruster wrote:
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
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 03817a0ebe..c864fb971d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2613,7 +2613,7 @@ S: Supported
>  F: hw/audio/virtio-snd.c
>  F: hw/audio/virtio-snd-pci.c
>  F: include/hw/audio/virtio-snd.h
> -F: docs/system/devices/virtio-snd.rst
> +F: docs/system/devices/virtio/virtio-snd.rst
>  
>  nvme
>  M: Keith Busch <kbusch@kernel.org>
> @@ -2802,7 +2802,7 @@ S: Odd Fixes
>  F: hw/display/virtio-gpu*
>  F: hw/display/virtio-vga.*
>  F: include/hw/virtio/virtio-gpu.h
> -F: docs/system/devices/virtio-gpu.rst
> +F: docs/system/devices/virtio/virtio-gpu.rst
>  F: tests/functional/aarch64/test_virt_gpu.py
>  F: tests/functional/x86_64/test_virtio_gpu.py
>  

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

