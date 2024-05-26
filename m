Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33658C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBNkb-0004wI-75; Sun, 26 May 2024 19:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBNka-0004w9-1y
 for qemu-devel@nongnu.org; Sun, 26 May 2024 19:58:04 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBNkY-0002lg-HL
 for qemu-devel@nongnu.org; Sun, 26 May 2024 19:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716767880;
 bh=aoIrv7jRFNoYKVsU2vRxz8J+M3+4v4YDJXWFm0Qbor4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YAjK/wqcM9aYtI4S8KGDfsAqlGLMyNMk5YxoXfDk5gd5FgN8+pCXAbB+F0hZI5MNf
 q6MrcxBrdngW2B+G1r+5lRX0JjW0Q57pe83xdJ40A7BRHEX5/XoeHKuH8Vl3rrzU3E
 uCTrD3KL/jxpTARctdd2WBV+bwu826Lpx3LzQKmVv+KL0aIFWFOn4BCpEPaP+RnVjG
 xpAPJt9qrrCuRaDo6Y83GgibrRlhgTJqYO9gTmt1FT0cSDPTe7F59TEkYF4Wc2k2Rw
 zKOuhB7pUdkVrPt82J/Oq65Fz9bC3V9hMEfvoJl11KCXD76MpSJxeWQBHMDHueHQ04
 9WGWVhR/1d/Vw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C4ED3780C1F;
 Sun, 26 May 2024 23:57:58 +0000 (UTC)
Message-ID: <7c5f87d8-dc2a-4e34-93d0-c4bf1800a953@collabora.com>
Date: Mon, 27 May 2024 02:57:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/13] virtio-gpu: Use pkgconfig version to decide
 which virgl features are available
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-4-dmitry.osipenko@collabora.com>
 <87r0duggh8.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87r0duggh8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/22/24 15:48, Alex Bennée wrote:
>> New virglrerenderer features were stabilized with release of v1.0.0.
>> Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibility
>> with pre-release development versions of libvirglerender. Use virglrenderer
>> version to decide reliably which virgl features are available.
> Is the requirement for 087e9a96d13 (venus: make cross-device optional)
> on the host or guest side? Because I can't see its in a tagged version.

It's required only on guest side. Mesa 24.2 hasn't been tagged yet.

-- 
Best regards,
Dmitry


