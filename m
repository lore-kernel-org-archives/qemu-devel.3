Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF20C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcQ2-0001O4-IE; Mon, 24 Jun 2024 01:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcQ1-0001Ni-PL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:39:09 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcPz-0005fq-W0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:39:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-71871d5e087so1385000a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207546; x=1719812346;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d+W5aI5USBezVikdE6B8ndj9tRZTHyBLwqHq/qhXe70=;
 b=1qectmUUYGn9ygbPY72D1FtmSsL+4+Qgk494pM3r/FZmZbgmRUZtiMuuw6MIgb0/FM
 7M7eRJi9HhCLyy1sFdapxi65++7fMMv6AT/S4bbo2AY2BVNVAf1A256frbjk+cC/N+vd
 mSg6aKmzR5BLxNsInatTnZxoD5YX6l4FSCLYMT5cJKlo1Cv+c903S09rnVmHa9rA+OmB
 m91/QYmiNKJ392XMCSMCNy4qRAb888FdqhnOb0LOKBZ238NhpimMFsTSbtMSzc7KSr3N
 RjmgGo3HRvsI3CkaKXG211mJcfQy2LErLwKAN2vFftG4k1XVfcB1gPjHLqOFXAc/qG/X
 ckHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207546; x=1719812346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d+W5aI5USBezVikdE6B8ndj9tRZTHyBLwqHq/qhXe70=;
 b=Gk4SYQLPH3+3PcdLKyKle7k3RLlMb77pT3ulWn2TSIfAAsKNg7yuFWRq3bEJ+1092G
 Igcdx6SDHcBmrZ7UdhSmOfkoke2t3BcxRLHe8PU5I9yHbJ4HnNzTLywyWSvewsvHuIUt
 /Akd4HQ28g9oa0+eU1TFaRPVeRD8mGSiAf/sWwp5Xvrb9zYSCiSEgOAkNgnWDkS9kJm9
 nxD3xlP8DD8d7H28lhJtilD7LLGQkaEcDao0EqoYAu2NzRS9pgL7ks42tHE5gimjwSFU
 PFG8yPutV/0tOzBuZCRul66gCo6W4A77sl/s8Hg1PqGOF4WTWNdAkJWL82eSlqfZbfOS
 LIGw==
X-Gm-Message-State: AOJu0YxChxE2EDJUB9itX3/i/SF6rQdboN4D/D5st7dBqI2oSuHuQ28q
 44QcG+NYWU8FYha8FpmHqBptJCGhw1CCbn2I6JXDMf5S7avXCLPBPY9CiYI2mtU=
X-Google-Smtp-Source: AGHT+IE7tVnBJTLzKksmmgW8mYQDhNqkJeKAsI5wu0ZkOvRWXkwLf4VwMO0fXcqziH3U1RPOvNyFtQ==
X-Received: by 2002:a05:6a20:974e:b0:1bd:fe8:fc9a with SMTP id
 adf61e73a8af0-1bd0fe8fdc7mr239133637.17.1719207546563; 
 Sun, 23 Jun 2024 22:39:06 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3d49f4sm53902575ad.197.2024.06.23.22.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:39:06 -0700 (PDT)
Message-ID: <a6cbaab9-c672-49d1-b870-14be9af7e87a@daynix.com>
Date: Mon, 24 Jun 2024 14:39:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/13] virtio-gpu: Register capsets dynamically
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
 <20240623152343.328436-13-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-13-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
> assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
> like Venus and DRM capsets. Register capsets dynamically to avoid that problem.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

