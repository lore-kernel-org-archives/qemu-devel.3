Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1846FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 05:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLGEJ-0000uX-9J; Sun, 23 Jun 2024 01:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLGEH-0000td-Gy
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 01:57:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLGEF-0002s5-OQ
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 01:57:33 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70671ecd334so409579b3a.0
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 22:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719122250; x=1719727050;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ysB+CNwBqOElMulAF6YFb640Tuze2xonSWNal2Cc1ww=;
 b=fcq3u+/ycjgb9UxsYHX0b45VbRAVLPa7R1v2HLhxeQx5IjGShzKJyuE+k2//f7mzqs
 jZKMO24Ta4hygSwEcp3KJM8U5FMtc4cadMWEqE+aP2/P4aa57/2dYNGTB9mwqUGlnKR1
 6Yo9268lXwW4ck0VV+bgl4OdmB4BOrVIbW2mEuKD6IeBd1ti2skGAnOoT7CcMLGKBs04
 fHf9tMvamzIPlq4Zh/P693apArPK9WLk+Wm9ztuR9ONJimod321H16HA6twDzCl2lGov
 hudoHwKL18oPOY6FtSuVIjoAO/cImOF3xeT3NBPh3xADTPu8B4gsslMb+33BfZo5Mihe
 Z0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719122250; x=1719727050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysB+CNwBqOElMulAF6YFb640Tuze2xonSWNal2Cc1ww=;
 b=hqRKril2o/3An4Au+hJUA5tBDd2x4fKi7NsN1ifaUqeStoZ0koiFgJK+sSOGVATls6
 dH9vlIVEP0JsV1sRIxtAoTraMg+aTPsT8TLmdSX2X7O+vlNUnCIJZdL4D1BHlyO2Jgqh
 zUO5X1EqyPebcXnp770df2N0VSlNoOHW4KOK9/tCNWrMuWBXVTwtgt0N0Gxq6A4NbeDH
 QX506XiGf8ACbuapgkmaMXdKFkwxY7zLIIqH71+QkzTznTB1pJx5np/2oj8dGCxmMfxf
 17vLkD+br8W5sEjtfA9XPBxv42XleyzDXWQwxg/uuR0d2xRLOvdCSihN7osOxb0+oOko
 FdUw==
X-Gm-Message-State: AOJu0YzjyquERCEhWiXRevLdKNfEt+dkGJHAAWpPDcnMvQstLsllWciH
 9AEqTTowzEzaC6tCXqOc4ZPxljg+UOK2j0U5J8Ncyg4Zn6BIOLLanRqK9ehnbL0=
X-Google-Smtp-Source: AGHT+IGacbpA5+wkvaAqjisPMD3AsQOk5dv1oEtYGD85qGqCFl0yr95orsJ0E71qjMVkilOuBXxgWw==
X-Received: by 2002:a05:6a21:1a7:b0:1b5:d194:d87f with SMTP id
 adf61e73a8af0-1bcf46515d2mr2379272637.59.1719122250029; 
 Sat, 22 Jun 2024 22:57:30 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb2909sm39685635ad.257.2024.06.22.22.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jun 2024 22:57:29 -0700 (PDT)
Message-ID: <987a2afc-c76b-4fbc-923e-466c1957a31c@daynix.com>
Date: Sun, 23 Jun 2024 14:57:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/14] Support blob memory and venus on qemu
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
References: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

On 2024/06/23 6:54, Dmitry Osipenko wrote:
> Hello,
> 
> This series enables Vulkan Venus context support on virtio-gpu.

Thanks again for keeping working on this. This series became quite a 
mature. I still have comments for two patches, but they are trivial ones 
so I hope it won't take much time to fix them.

By the way, the rutabaga patch series added the documentation for 
virtio-gpu at docs/system/devices/virtio-gpu.rst. It does not only cover 
rutabaga but also virgl, and says virglrenderer translates OpenGL calls, 
which becomes somewhat misleading after this patch. Please update it to 
tell that it can also pass-through Vulkan calls when Venus enabled.

