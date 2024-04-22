Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A560C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 20:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz07q-0003H2-5b; Mon, 22 Apr 2024 16:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rz07o-0003GZ-Bx
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:18:52 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rz07l-0006bt-Kh
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 16:18:51 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a55b3d57277so188190266b.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713817124; x=1714421924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FoTjUmsI06mXdlRsjSLRmG7j9QE6cwxbcOFwfN5sLnQ=;
 b=tHwXHwd87Ak6qXYFQrz9GMMG6N7/azpsdteAFBj9yRaZY6IwFNQE7kl6Q00uozH8Dc
 6jMDs52xWWgQus0s1AyxiA6FlT53I5/No/Ic+/SXBIrVJNq1+n5H+9MhBQ9dulPF0PFw
 1+F034p9RlhULe9hxJbPh/Zj+41RO5yeWtvBQw710m8JoVg8vd6Ez1jIatrshMmnz1lH
 jKzZ8v36Z8lQFunW6cnDQsV0KkXWfzgAH44v+9j5Z0/lFThwFwpstyKt3vdhg0MyYWSO
 wtBR644JADyje+GfH3DzsT+gcImTjEYzGkQz/b95PU8Z9Qh/bfb1jqXYOmVdIn9AsbJJ
 2faQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713817124; x=1714421924;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FoTjUmsI06mXdlRsjSLRmG7j9QE6cwxbcOFwfN5sLnQ=;
 b=QINfHh0fd8mHUXAGbEwj88kMK6hK9duZBj9on6+Z2ZQlFsCJf2FmpsymPbju8sCEe9
 S+WoVJL0Bt311lqiwG6/3MGoyARztB2+x0Vk2H9ESkc5W0DeuLZb5pKCINLOYDalce9i
 3MkkydkPFEBEeH76BEtcnLB2YCv++OWGefORsKFK9KfVv0PoJlRADfWEZwVGl72nC03y
 uV2nprlRUZ9rwNti3+VMs9A1U5ziAEvEY5odnZ49eGNfLTRw3qe78AhEgteZYuDhRiwz
 nw7kOtCabvOf3DYhrbsFu/V8Lyu5b+0WGah+bWRUMyzDBKW866UXBdtIa7iQEtjioT6D
 9Nkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhlxAb62YzN2I6/+tHaruuyYUxqzDVjXzByPT0/ChfpycNpzK+IGDY0xL4HbPZN2pM7x8S88wSbRe7ciPRrTn8kP9m7gU=
X-Gm-Message-State: AOJu0YyUVOHUQS5GGikJRs77WcrmsV3E89zbJD2bAzFKV7103MknC5qU
 l9a1LBGj9qSpNsGEob0B7n5YGFeQj4DlxKvisDvAoFTQVEpl2qLuuxaWivooDqA=
X-Google-Smtp-Source: AGHT+IGSTWGMNUBvvfxKQarG0UKGpGW07NUhtmPA+Ts7NRd+Luboe4WkqRu5BCJpSv4hzJY5zeLqHQ==
X-Received: by 2002:a17:906:3842:b0:a54:4f06:4d00 with SMTP id
 w2-20020a170906384200b00a544f064d00mr6135641ejc.65.1713817123973; 
 Mon, 22 Apr 2024 13:18:43 -0700 (PDT)
Received: from meli-email.org (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a170906260300b00a559965b896sm3511158ejc.202.2024.04.22.13.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 13:18:43 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:10:51 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
User-Agent: meli 0.8.5-rc.3
References: <20240422142056.3023-1-philmd@linaro.org>
In-Reply-To: <20240422142056.3023-1-philmd@linaro.org>
Message-ID: <cd1r5.n1iglebry01@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 22 Apr 2024 17:20, Philippe Mathieu-Daudé <philmd@linaro.org> 
wrote:
>Since VirtIO devices can change endianness at runtime,
>we need to use the device endianness, not the target
>one.
>
>Cc: qemu-stable@nongnu.org
>Fixes: eb9ad377bb ("virtio-sound: handle control messages and streams")
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks for the explanation on v2 btw. virtio_is_big_endian()'s doc 
should probably reflect it's not just about legacy devices (virtio sound 
isn't legacy) but about target originating data streams too

