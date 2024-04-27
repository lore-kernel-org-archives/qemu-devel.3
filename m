Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D279C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 07:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0cTQ-00032j-2Y; Sat, 27 Apr 2024 03:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0cTN-00032U-Fv
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:27:50 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0cTD-0006El-5j
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:27:40 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6eb658ca1ceso2077538a34.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714202858; x=1714807658;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5LRrKLDHx8VtTDLL6dBug/YSiX5Rr4VjwdESRVOVz8E=;
 b=CxkvrZzVq8zfExpE2RngY4yvA4ax/R6VsLp77lNjK46Refjq1ng+c1HCb2XxwJcu+/
 BpNs9k0wdhyOCL1rerPB8iAJkxyYAv1OouXJybJQ+BtiQFVpqrplW25oAzV/JcAplh+l
 zo+vlBXaE06gzNMI+uoRc+ujU2BfqqoS+dgFmbRb7Y7SMh07MGRVjAAS5jiJ/9fkFj5M
 rZeICDf8wRgC+idGqEzb2DNctCGOXDZ7SBCOHIs0VzmSnx4cZnaDY7K9EGyyqA/5FgyA
 anDH+PdKMj0DqrtGUsOBAgM7e2Rf6EhpYDYWrfKp3F0z0Al+QeLR87tbKJB9uVc7gRJg
 0Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714202858; x=1714807658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LRrKLDHx8VtTDLL6dBug/YSiX5Rr4VjwdESRVOVz8E=;
 b=wTj+gHFplexthg9THubqyAJmitgwxErpSRxzvbMLyUQEm9bscM5sAhA6i/LWQrhMw/
 20h9Lf+GxocC6uMX1aUhCSPtHI1VXWJALtYOtLatthE6fpFHb4kCoKxglsd/WqanGjug
 Dzt9eY7ekkWouaoC/on/JkWelebkTjyl77nmJwOcjTD1ayKWefZ0js8Gi2sI3LUiemsw
 GbOB020zNakE3NKyvSyISHcc8JOoT4JdaQZC2oGw4Rm1yjEr8zi3q657qR0lc8tCLGue
 0kT60SAcABVAupVSVyA86noDKJqcQIWA1g3yRO+4YosF5/ZonkTNYYPyj4vn8EhoCwIq
 7wYQ==
X-Gm-Message-State: AOJu0YyQnL/3kWbvj1mKuFu6S2xnNUmdogRnvzoolXrFrvngP5qbHRLh
 4GyZ1GoWVdBNCOFjEy6o2bS6mWz/Vfos4+XhxoXqMqhUZe/cSRMfyTynCydn9yM=
X-Google-Smtp-Source: AGHT+IHKEeM4mG6PSgGm7m1mzKSw8F8A5zfB2Z1z55LnsJpBcwlMkm85rZ5Y2o+cut+lLbFVDd5jIQ==
X-Received: by 2002:a54:4e8e:0:b0:3c7:85f:7f22 with SMTP id
 c14-20020a544e8e000000b003c7085f7f22mr1904636oiy.30.1714202857706; 
 Sat, 27 Apr 2024 00:27:37 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 17-20020a056a00073100b006eadc87233dsm15861771pfm.165.2024.04.27.00.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 00:27:37 -0700 (PDT)
Message-ID: <ec230507-a728-407c-b477-cf98f99dd7e4@daynix.com>
Date: Sat, 27 Apr 2024 16:27:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/11] migration/virtio: Add virtio-gpu section
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
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
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-12-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240425154539.2680550-12-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x333.google.com
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

On 2024/04/26 0:45, Dmitry Osipenko wrote:
> Document virtio-gpu migration specifics.
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   docs/devel/migration/virtio.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/docs/devel/migration/virtio.rst b/docs/devel/migration/virtio.rst
> index 611a18b82151..67f5fcfed196 100644
> --- a/docs/devel/migration/virtio.rst
> +++ b/docs/devel/migration/virtio.rst
> @@ -113,3 +113,10 @@ virtio_load() returned (like e.g. code depending on features).
>   Any extension of the state being migrated should be done in subsections
>   added to the core for compatibility reasons. If transport or device specific
>   state is added, core needs to invoke a callback from the new subsection.
> +
> +VirtIO-GPU migration
> +====================
> +VirtIO-GPU doesn't adhere to a common virtio migration scheme. It doesn't
> +support save/loading of virtio device state, instead it uses generic device
> +migration management on top of the virtio core to save/load GPU state.
> +Migration of virgl and rutabaga states not supported.

Sorry for confusion, but I didn't mean to add a subsection to the 
documentation. I intended to refer to a terminology of migration data 
structure named subsection, which is documented at: 
docs/devel/migration/main.rst

A device-specific information is not worth to describe here.

