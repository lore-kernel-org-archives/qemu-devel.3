Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C81C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcOS-0005PD-FQ; Mon, 24 Jun 2024 01:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcOC-00056e-SM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:37:18 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcO7-0005XZ-30
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:37:12 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso2659740a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207429; x=1719812229;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r/TlZl62s/0JwilXPCCEFYa5cWIGjt4qRe/1E+/8vu0=;
 b=bCyhD+T+lYcbAq6OeTDlweaXtrqzI5f/6L8SLtBmsOqx97CE77QKznTjcyVOgFqzDk
 oytQBANXMD/fTEPm7V6NkzGajh93vPd14UUAmnLpfhKDCtfcxxFvwJDw8ZqDXalkh9x2
 pyyObKVqwQPPACnAxu0Dpk2JMDVDKlbTSCBK01Z+PpMqniqmbv7/Gja2DwwbMo1F94V4
 pNRVPrP9nWJtTnw7/pf5+4+awJt3j/hwfuerCBWU8+ztTzpox8Kk2BI/lSQUFrigCMC5
 Todq88/ClJKefsn1ZYFAs1R+/pWwJ4WVnw7x5QAs9QYistORY3YGhmoLQ1QqyC6x4dK1
 FWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207429; x=1719812229;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r/TlZl62s/0JwilXPCCEFYa5cWIGjt4qRe/1E+/8vu0=;
 b=oz/Il1gYlNlVc3SAV/zayKI9XnvrrWXRf6w8Di9PlQmgpHjqE3Kt1f3/aHqiST3CRK
 f1TbjBKJl6PDxOG2caRsMBVqH6qb3DtN3AG8XbGk7s5kp5CHJmkyAxEzy5K/a95MLEuA
 LTAmKihF3IdqeOgrB3ix4CSIed9Unn1Nx9rgS0BUJdDWLw8a11YyN5zz1a+34eSZj+Sr
 8Ye++VpymFhkNK7O2fL9piaDbDJlo+BLpvMRUis5HMJpTRX4b7bPj4YekMF7h9IpdxMP
 I7ACsP2UR5Yhq0yG9mPpxhU3maO8rydwfELHU7c2E7aS1dSUVidKOPDz7UCmc8rQFKaO
 cyFA==
X-Gm-Message-State: AOJu0YwMcMV4GAGxELEIFNDge3bRCloTE8dyLNiBAMkolnUJE21A3C6R
 Vtt2v793m5ib+3eKyRmHezMrlM+oJaUcurTzYP2KuLliYpETsGHRG2zB3CODAtM=
X-Google-Smtp-Source: AGHT+IEiQKmpIV/Tgxkq2nmyXGkGFXJK6QMYBTJwWc3qOQFnpfJMvmp0mqKs8XNpepIwxcjLZL5ZvQ==
X-Received: by 2002:a05:6a21:196:b0:1bc:9b00:e012 with SMTP id
 adf61e73a8af0-1bcf8006722mr4635913637.58.1719207428601; 
 Sun, 23 Jun 2024 22:37:08 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3d4c3fsm53812595ad.195.2024.06.23.22.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:37:08 -0700 (PDT)
Message-ID: <edc41d3d-990d-462f-ab22-be26ec1455f8@daynix.com>
Date: Mon, 24 Jun 2024 14:37:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/13] virtio-gpu: Support context-init feature with
 virglrenderer
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-8-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/06/24 0:23, Dmitry Osipenko wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
> feature flags. Expose this feature and support creating virglrenderer
> context with flags using context_id if libvirglrenderer is new enough.
> 
> Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

