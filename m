Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E1CC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcMh-0007zQ-51; Mon, 24 Jun 2024 01:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcME-0007ju-90
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:16 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcMA-00054m-Uv
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:35:13 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-25cba5eea69so1906798fac.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207309; x=1719812109;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZruEpO/MoD1fTse4BnrJqqGy48HTV31dbaHBR+Pyh8Y=;
 b=XSYFq6SYjd5HIlzx0MI/a7HYbL+/ScrDXsvHru3mR51pU6MPY1reOkgeWLjTiZ9Xpc
 GQGPv4aF6pp1cwl6VHfgjxaJ2LT2tmajbw803+k3KjoGohVqg9vkrKuT51Ini4telXMP
 wjwULwHRjrKl8lH6oGfVfZJSsJYa72yLqZldh5ucqRB76Nkw07pgytfOOyc/6ZKcKbEG
 wdVZB++Gw6CE13IloXhMpMbXRZ5f+0d2sTjy+mNAEqAcH+buKG7u9nXeqB/ZWtZ8M4lr
 mC90QEZ3nd+Pvtt5IbGWLqtNFSweuCmxSdBoFClQhg/GQsCu5KmjRiyY7goPOA1qJeyh
 4FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207309; x=1719812109;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZruEpO/MoD1fTse4BnrJqqGy48HTV31dbaHBR+Pyh8Y=;
 b=F4NVfnMIRZ+Mi1cQaH+xyJCkQshkVFR2EWnfeUhZo3Mtab8cZHBADvrbKWF4VluxzT
 xi7MNEamXjhEP6zTNftTmYyQlyUr0tLc2JUewmI48hqKFSvGR6x1Sa1rS1eX0An8fl75
 SP11g12TSBM97or2TUb2w/eDUYQbajtpGHtqDNCvmFwOVUGyh4pIlzpZSyA0LKoVcQgL
 9gSF7+GRZxg8DK3mN9jV4SiljpqaTDvCsXvrnKpmzUaEMh90x9DVZV8qMp/7LrJLo9uv
 nYXg5FlpygB6Ax9SF9nsAQJY0yyWbQVt9PBZEWv72QmKAvufbMZZdhKptxX/hUEMYKHe
 DQqw==
X-Gm-Message-State: AOJu0YznUVYiZY3+wximGVMZqHJphUThXFGA8l3fwqbEbGCVjOKZZ+sd
 yMyfvMlO3wg3D84LUwbtWiird7HYlp5TE2u1YTjK5dtMHuRUh9RhEG4HzZSQfOQ=
X-Google-Smtp-Source: AGHT+IHQDTzi2/y9ZUWxR1dnfME2zS+83Z8PwDd+c9lhhKVHT4yqjj2r4sWhjYTgdtojg+o89fsNjA==
X-Received: by 2002:a05:6870:9720:b0:254:b24e:e351 with SMTP id
 586e51a60fabf-25d019339e1mr3985009fac.59.1719207309196; 
 Sun, 23 Jun 2024 22:35:09 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065107b892sm5518727b3a.14.2024.06.23.22.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:35:08 -0700 (PDT)
Message-ID: <91ba5af8-cea5-453b-a38f-4b97f2c7268f@daynix.com>
Date: Mon, 24 Jun 2024 14:35:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
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
 <20240623152343.328436-3-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-3-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2a.google.com
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
> Move fence_poll timer to VirtIOGPUGL for consistency with cmdq_resume_bh
> that are used only by GL device.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

