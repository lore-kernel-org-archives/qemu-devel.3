Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21932CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PxK-0001i0-NK; Thu, 16 Oct 2025 11:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9PxI-0001hk-Ix
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:31:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9PxB-0005I3-LP
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:31:52 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-269639879c3so8710435ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760628700; x=1761233500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=erXzoxKlF1MBdXhNeeU9XBEgLEHuF5GOecvXBGPI/68=;
 b=vAIbWY8eJFtAkMoOnlCJxu0JDDQuKSEQHYrg7v3Pntb8nrOPiSm/HoDUG/cOJ2Nzyp
 a3aziMFNk6rnE4tlh2eaMfeVTODmW8JKKEG+iiAWq9CDc9QBUAOvgRZmKa2wcuM3MBfY
 63cTwtB8N+AZMR7UqzgOomH1KByGwcF+R7W7BTiy04ZFeJHkvYwfVcmf7YthxOBTTSfI
 ZcnMgsXAD7oIWHMqeyWZY5nS0ReSx0zl/Tj2NROjfPf0TNftGth2xbyuWK3Zag775tG7
 WtmNFrEie71mvFhFfUiBax3UjQyFciyhWTlbgr4LH65H3JB476RXG4aVV2ZLdAAUEXcJ
 Dn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760628700; x=1761233500;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=erXzoxKlF1MBdXhNeeU9XBEgLEHuF5GOecvXBGPI/68=;
 b=cmEQZicEoyNLo82N0hfO9XiWsgubisVGQD80X+W7T1G+onEMwmtrNMk5fJv6IAPrSG
 aw9m+PBh/IBqcUvBOW07Ktp2A5dawmAjTI7AbHl+X1fip/f+7As2t65smE0Gz1DHDCrQ
 Legu349S7kzCjkyNBg3+BCkZObxTflUTPopl6i4KXCg0KmuYfcKTOXwBH7j8a4IB11hs
 2cQYpxoXWnSaknlapCMHJIAeG486EJTjPrEY+1KVNbXhSKU1QlxfBq3IUP0vmt8eZgun
 E2xDkkXnbBOgp/F8OmhFrfW5/PqyXBZ9kddF4Y32ep17+XzkrbZrYhybM7wOrFo4kGV6
 A8YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgIOxeja+MSObC3YkrhZxlEu80QNAVrn35F+ebB4POfQ6l5evozRCoi+isS1VFNGAapPV7njOw7Z9K@nongnu.org
X-Gm-Message-State: AOJu0Yyx0/GJ5Um2QtTWr1ymPDN3ZUHihVAgUBJIQOGKCqkwH1Kb2bp1
 +Tu/vsPwiNdmfS7l3Psi3L1FFaUF+KBwF6Hyjj820KFVNCUrwTcCKQ7WaYUf+ZiFCv0=
X-Gm-Gg: ASbGncuIm0SyX5BggcmKhEDlUv6BtO3tZBnr9C4QIpHt9rrno+tu6lN/uci8Elq13fn
 7CcQeHHH4TTexD4A6QWzwQJGQoAn9j4eo5ClhzyRLhbR3fxdWaUTWelMt/c6EPoObnCNPBCJe0n
 EJVhbw/jqzlP9bKhseQGNijO8UvABr0LxuhjD9DIZ9xxN6h6rBkrR1llIFu4UDYxdgqgb/Pkb32
 QMarFJlm0udyrUvlq3a2wcQN2/PMH669+g2nyN25obToU/96TSQPV7Ft/uWIkGNLoi0Qh+ogfE2
 M80AMOLirx0bdJcRXX+DffeKKUUY4EAA/+5I8eAIZPb21iHU7G7ZFSyScniqq0kwafvQcymCeuG
 qofo3d8RkIanQfT8SiFYwuPxPAsHnPaXlBU6Uxwx9UTfWkoc2K0w+DAGnOaoNhZ/DPmVgkLN92V
 NJj5IMHFD74pR3
X-Google-Smtp-Source: AGHT+IG0Ll9nmcr9DR0Y2tjgybaQU21B+R9uHigz8z+hnsFsx7RoSE2awIp3vz46KfCThFcdGhgy6g==
X-Received: by 2002:a17:902:ce87:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-290c9cbc92amr5544705ad.19.1760628699815; 
 Thu, 16 Oct 2025 08:31:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099afdc02sm33757345ad.110.2025.10.16.08.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 08:31:39 -0700 (PDT)
Message-ID: <5db0da99-2284-4ad1-91a9-f5e19a2bb5a6@linaro.org>
Date: Thu, 16 Oct 2025 08:31:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] hw/display: add blob map/unmap trace events
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016150357.876415-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 10/16/25 8:03 AM, Alex Bennée wrote:
> As these events happen dynamically as the guest does various things
> they are quite handy to trace.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/display/virtio-gpu-virgl.c | 4 ++++
>   hw/display/trace-events       | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 94ddc01f91c..07f6355ad62 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -134,6 +134,8 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   
>       res->mr = mr;
>   
> +    trace_virtio_gpu_cmd_res_map_blob(res->base.resource_id, vmr, mr);
> +
>       return 0;
>   }
>   
> @@ -153,6 +155,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>   
>       vmr = to_hostmem_region(res->mr);
>   
> +    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
> +
>       /*
>        * Perform async unmapping in 3 steps:
>        *
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index 52786e6e184..e323a82cff2 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -38,6 +38,8 @@ virtio_gpu_cmd_set_scanout_blob(uint32_t id, uint32_t res, uint32_t w, uint32_t
>   virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h) "res 0x%x, fmt 0x%x, w %d, h %d"
>   virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
>   virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res 0x%x, size %" PRId64
> +virtio_gpu_cmd_res_map_blob(uint32_t res, void *vmr, void *mr) "res 0x%x, vmr %p, mr %p"
> +virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, bool finish_unmapping) "res 0x%x, mr %p, finish_unmapping %d"
>   virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
>   virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


