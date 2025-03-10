Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3216C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trcGM-0003rg-Ah; Mon, 10 Mar 2025 08:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trcGK-0003qr-MF
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:29:40 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trcGI-0006Dp-7m
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741609759; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JRMUIZ2P1dbud9nz772QplJXHgeT01b5jEZa7IkHniHKcnNiUuzZuhZk0bFIgZoVBuSeo8pRZn2lZv4ZGUJqKu8OGsZdpfCPigjP4WzojokG0S0X5CaX/QTr6j8yQwQwQTZmxQSUHNkd2yhhJLobnM0qfJAQkZQY6M/a4l3xzf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741609759;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=awIvpUzffD0A1Q8aN1RQ39QrgmgweCLMP3iaubfG3CM=; 
 b=S9T8BVYV19yrHzekjpYNRocPXkQgmFBU8YGk9PB+XTkmmpFpDCD3VTJipJIBsTP/z4IiP9AodQny0ypGKtONctp0CJo8NTVMgtL7uKJLbF+YTtXf3x6U0l81KQ4mXElYyS3IMwIVcNOfNKQBY2N2OFmSBkPho/kQuhrF7TLFAAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741609759; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=awIvpUzffD0A1Q8aN1RQ39QrgmgweCLMP3iaubfG3CM=;
 b=YsSZph3DGGfkNqGAOfdFqc5vxvCfkbHTn8rYkerbRR5zbbDiKg3rwkJuXxvM491+
 7Js+BUfPEXRf5cb46DZsWZvJnO5zmwYyy6ktGOEjyzC2vwxbMtEYLet6BnOg0YKhAtj
 f+tzRgCM5piC8K7l71fn1KlDbRHgoV2bWnaajcO8=
Received: by mx.zohomail.com with SMTPS id 1741609756471554.8248487674084;
 Mon, 10 Mar 2025 05:29:16 -0700 (PDT)
Message-ID: <44613051-05e2-4811-aeb9-ad0affd24d74@collabora.com>
Date: Mon, 10 Mar 2025 15:29:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/10] docs/system: virtio-gpu: Document host/guest
 requirements
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20250310120555.150077-1-dmitry.osipenko@collabora.com>
 <20250310120555.150077-11-dmitry.osipenko@collabora.com>
 <06751210-413b-499f-8ddf-05659179fdb7@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <06751210-413b-499f-8ddf-05659179fdb7@daynix.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/10/25 15:25, Akihiko Odaki wrote:
> On 2025/03/10 21:05, Dmitry Osipenko wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> This attempts to tidy up the VirtIO GPU documentation to make the list
>> of requirements clearer. There are still a lot of moving parts and the
>> distros have some catching up to do before this is all handled
>> automatically.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> [dmitry.osipenko@collabora.com: Extended and corrected doc]
> 
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Thanks a lot for the quick review!

-- 
Best regards,
Dmitry

