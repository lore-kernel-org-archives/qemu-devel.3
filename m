Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7C8C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKBa-0003E1-Qx; Tue, 23 Apr 2024 13:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzKBZ-0003Db-EW
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:44:05 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzKBX-0005kG-PX
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713894242;
 bh=Y+G1VDdMR6mQrW3FnM/pR6jbUjEy6GsbvqWqUStk7+g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=b0aKd2ilvOAiBB2EA3tYycjWqxDhfx7DLHj3hZyUj1VewLctnZG+nYboyS7cVvBwQ
 /7IRWUIuHFvNpqvsZJSYyRhVxCqY1jYrZwdDFMzYZXmYmdabR0ywk0dx8ujxiYpJMT
 aFbM1Y4WQ7Y6CugfHqoZ7jz7kwKGuNt80oV2C+bF3JIvD8I5Y1EskeU6jMZxai0JWM
 j3ikPaWtTHBefKrN4+JIW024A6+dKqSDLz9rgidpe2155h3RfRAFtrL0yuB5exJmh9
 EkYiCSiRckXORTRy34jSxRYqvBTYfCpu1zdKQt8OMM+Bj67YyU8iwd/YgORJIgScaB
 JhUN8Lz5Iit3A==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 035CB3780BFE;
 Tue, 23 Apr 2024 17:43:59 +0000 (UTC)
Message-ID: <2caefc71-7ffc-4079-9015-eed9139d127f@collabora.com>
Date: Tue, 23 Apr 2024 20:43:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/11] virtio-gpu: Resource UUID
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-10-dmitry.osipenko@collabora.com>
 <ad215124-6a02-4bc7-8cee-c6865bfff768@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ad215124-6a02-4bc7-8cee-c6865bfff768@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/19/24 12:29, Akihiko Odaki wrote:
> On 2024/04/19 4:00, Dmitry Osipenko wrote:
>> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>>
>> Enable resource UUID feature and implement command resource assign UUID.
>> UUID feature availability is mandatory for Vulkan Venus context.
>>
>> UUID is intended for sharing dmabufs between virtio devices on host. Qemu
>> doesn't have second virtio device for sharing, thus a simple stub UUID
>> implementation is enough. More complete implementation using global UUID
>> resource table might become interesting for a multi-gpu cases.
> 
> Isn't it possible to add two virtio-gpu devices even now?

We can add two virtio-gpu devices, but these devices can't interact with
each other efficiently. They won't be able to share host blob resources
without proper UUID implementation.

> A new subsection should also be added for migration compatibility; see:
> docs/devel/migration/main.rst

Will update the docs, thanks.

-- 
Best regards,
Dmitry


