Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F61D0C5F2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GRq-0002Xb-Uv; Fri, 25 Oct 2024 05:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t4GRk-0002WZ-23
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:17:28 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t4GRi-0000Nu-F2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:17:27 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1e63so2177180a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729847844; x=1730452644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeBP8uld+Y18cRxY/zh1caFnXNNzWPZdwKC99KPZ3E0=;
 b=JI8vR13jmFHrcdMomjJz6axshzvFQeS+IuwCmT0f754dvq+60NbHxQWHY0lSlcfTs6
 yUg+0ROTyZ8pFm4pGCN9t1jTAuqS1K1wT17gt682GFceU/A81L8/KMr2oESu2Tq8WtPk
 tmULr3ZBOmqF2VQrP3pYGS4yvB21m+lR0S/cYebqQzWrnE3o6jFX9usDPil8e+o2eBvH
 4UVdwU4uX//4LVH7J8jkZfCRk4syevKXTcqQG5JRhKkDMvDEUAnrSK/6SXah8KToHKPq
 saSndwWaXkR3fau9b2w9OkJeUdSumqApA/LhHq161v+IFFZpmCyHOerUfHokUjmPMIHQ
 Mj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729847844; x=1730452644;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SeBP8uld+Y18cRxY/zh1caFnXNNzWPZdwKC99KPZ3E0=;
 b=A/oVGVxis+6skRgcDNzZFoBhyEUn9kGtBI9jRyVCAVXypo1zd9/74lgSuWtRjxTkCx
 BbFmm215Pv7CAnljfEAss3i5eRhOgGyV1nLIpYBBqNnIrfKwrKRPS08W1ha5JoludJPo
 zjDtGuyYt4miLJ7RT8DCuqlSsanP1v5ebEc5C6LfbI0pbHItrWbgtUC7thr2MD/TUQH9
 GmQvQPSwzjjWBYAeM2prT8MD0V8pPVvIcIvj/1Qd/J78tK2dKwTJdtLjgkanfZ5vUeAf
 MaSSt1tlsavI7zqh1S66+AoZVf9/YS9nv5Ck0LdeY0EXy9bSB69U2TtHfEig5zzLdJGc
 WTQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIaxX04DKTLC2+PKv7/FvewV54qOlge7u9no6YsEBZSo4PAY1/az8xkT0/jwvD5oGvJInhzaAONoFC@nongnu.org
X-Gm-Message-State: AOJu0YzsR0IBeO8z10dQyajgVADVhMMvbZN0AlOD0LT3j/pjHsxt+T33
 hyjkZ0Y055Qu/XHPy5N+h7BPqUIrIIScSqNH70tkwBSrRUQLRwWBRJ/RHXdJvN4=
X-Google-Smtp-Source: AGHT+IEKFkUVFuwOtmaJhCWGO6bV8mCUE+b8SJ3JPptaEBfBTDD5+9VVGg+cGhCqOKEAllpHeTq3pQ==
X-Received: by 2002:a17:907:9452:b0:a9a:3d5b:dc1a with SMTP id
 a640c23a62f3a-a9abf869709mr918375966b.15.1729847844009; 
 Fri, 25 Oct 2024 02:17:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a0887fasm46858866b.210.2024.10.25.02.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 02:17:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 857B95F856;
 Fri, 25 Oct 2024 10:17:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v18 00/13] Support blob memory and venus on qemu
In-Reply-To: <20241024210311.118220-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Fri, 25 Oct 2024 00:02:58 +0300")
References: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 25 Oct 2024 10:17:22 +0100
Message-ID: <87ed44ilst.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Hello,
>
> This series enables Vulkan Venus context support on virtio-gpu.
>
> All virglrender and almost all Linux kernel prerequisite changes
> needed by Venus are already in upstream. For kernel there is a pending
> KVM patchset that fixes mapping of compound pages needed for DRM drivers
> using TTM or huge pages [1], othewrwise hostmem blob mapping will fail
> with a KVM error from Qemu.

While we wait for someone to volunteer to maintain for virtio-gpu I'm
happy to get this series in for 9.2, hence:

Queued to maintainer/for-9.2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

