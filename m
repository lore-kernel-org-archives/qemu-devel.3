Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD60C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtge-0005ZF-LC; Tue, 10 Jun 2025 03:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtgY-0005YR-Nk
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:46:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtgV-0004xL-Sn
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:46:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45300c82c1cso8457735e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749541574; x=1750146374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MYoVOR1CZxd8oYa4whcklsfk9DWRVKfrTpPqPhEbrvk=;
 b=gi2cwS+UsLAv+BZAXwtGLDrFaEHs1hAteebD6QBHRHQfLh+HsGtoACOvJOVx4u310k
 ZcQrFrp3cP7oEyemelf8TIPUdj6YFFqL+9hR08ilD+YjRCtaivsMqJOrtz2xPKewvBqi
 eWMxW2uizQay0ppbT7ORtxSPICRRUwX5KLJWou7pdW0vwQb7W/QKBs0NXXeplgjMv6Ur
 Fq8P+K+lLiD3Qvni2V+R0N4fCrip7obYqBDZ/YgptmkjtaHbfuNzjS7Y7DjITtyX0LGp
 7po4tpgffCqg2UQOD3gsElEoPi+SVUT8Jj370n67bULfEkA30AeBEy+ApfqIFbDUkUwt
 +yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541574; x=1750146374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MYoVOR1CZxd8oYa4whcklsfk9DWRVKfrTpPqPhEbrvk=;
 b=UGsQ6F3ezZN92s729NUBxvtOWxSiR8UCYiUHLw3XPRmE3Alvo9VqU5Zc1DmPWXC2BB
 gvg0xxygf+7xnax13nblcfmLOmUq/WUX+FgZTj2GWaEQYQfg1C29Sh2s32jyXrqN6gYA
 /rbEo8FZLHY37yAX5gKKSEJVz+crHyXJ/sshc7qhlDW+f1vLu0pWLfVsESd+ZP84Dhaf
 Tl5ZUP41RxYuMnom4lWVPlI1ieg1iYm07m8vBBTrOBd/A/veFu4yP95yUVK+OnTQuge8
 0JVAx0YYt71H6LEEhySQZIEYNSW/k7UeyZbqpB3jAIVJ3mwoqx+VM4XBQl04hyb7gC9h
 3Vzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2TZ2qRXEAS+qSfU1YcDcEJk6M2wlXSMPkx/5lB/gdylmk06hAhJkh10sl8VZCyaQnSRMcdlrWKgB@nongnu.org
X-Gm-Message-State: AOJu0Yy5O5Xm1Y4RIuS5Qj9hueNDt/AbcDJQfWQIN4QznGpplLIyO8Yl
 pMbXmneDGtj2ikzA+YiNNAvNUSRu9UC9eOCbDve2Zm5xh1khAtxU24WpM1ABwYoaC00SBI3j0pN
 06EKPsRA=
X-Gm-Gg: ASbGncvugoGuPx8dSIIvmZlVVUyruIF9rglc10sPe4EJV8NursfUYNYgnTX2Iqz1d/s
 KVJNkorggv98ON7ElMuxDVxtq8jWlovEnJGsavhQ36zSUThMgmcg9JVO7HtBvA4VWN177JJq/7P
 HcmI7eL6PXmhkprcbflYJdjtmYtUrcP5qZQr2+hXEqqIaViDhdUkk0AB9FiIPB6kNQhWQaKdfzb
 4yCwyOB5LFEUHt5D0DZR+OCYY8J/sH5PWYNim/2MU9bJlCiOJzp1BT5JWyIw4zpfA88Dbx6D/dJ
 emh/Gg/OyIGxQHUrlAPCFsT5AO2JC/jme+2ySwiV8X8AFTTxuVNx4px8i0jtQr8dTLwO6wxpoP9
 e0twZTtIxViKDYOxRm2409b4cazwbiw00sAU=
X-Google-Smtp-Source: AGHT+IHTwALnX+YgBBIX8b84mz2gWAhXnx1SqX7gmx3oLFuCkSrvvXwL0hmEhZq+BFKgN6noe4kfjQ==
X-Received: by 2002:a05:600c:859b:b0:453:6ca:16a6 with SMTP id
 5b1f17b1804b1-45306ca17f5mr76966835e9.10.1749541573929; 
 Tue, 10 Jun 2025 00:46:13 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b92d4sm130903155e9.19.2025.06.10.00.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:46:13 -0700 (PDT)
Message-ID: <54d30dde-a988-4fb5-aee8-0d9e2b91d592@linaro.org>
Date: Tue, 10 Jun 2025 09:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] configs/devices: Add MIPS Boston-aia board model
 to RISC-V
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-9-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250602131226.1137281-9-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/6/25 15:12, Djordje Todorovic wrote:
> The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
> MIPS CPC, AIA plic, and AIA clint devices. The model can create
> boot code, if there is no -bios parameter. We can specify -smp x,
> cores=y,thread=z. Ex: Use 4 cores and 2 threads with each core to
> have 8 smp cpus as follows.
>    qemu-system-riscv64 -cpu mips-p8700,resetvec=0x1fc00000 \
>    -m 2G -M boston-aia \
>    -smp 8,cores=4,threads=2 -kernel fw_payload.bin \
>    -drive file=rootfs.ext2,format=raw -serial stdio

Please add documentation in docs/system/riscv/ and link it in
docs/system/target-riscv.rst.

> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   configs/devices/riscv64-softmmu/default.mak |   1 +
>   hw/misc/Kconfig                             |   5 +
>   hw/misc/meson.build                         |   1 +
>   hw/misc/riscv_cmgcr.c                       | 204 +++++++++
>   hw/misc/riscv_cpc.c                         | 225 +++++++++
>   hw/riscv/Kconfig                            |   6 +
>   hw/riscv/boston-aia.c                       | 484 ++++++++++++++++++++
>   hw/riscv/cps.c                              | 187 ++++++++
>   hw/riscv/meson.build                        |   1 +
>   include/hw/misc/riscv_cmgcr.h               |  77 ++++
>   include/hw/misc/riscv_cpc.h                 |  69 +++
>   include/hw/riscv/cps.h                      |  75 +++
>   12 files changed, 1335 insertions(+)
>   create mode 100644 hw/misc/riscv_cmgcr.c
>   create mode 100644 hw/misc/riscv_cpc.c
>   create mode 100644 hw/riscv/boston-aia.c
>   create mode 100644 hw/riscv/cps.c
>   create mode 100644 include/hw/misc/riscv_cmgcr.h
>   create mode 100644 include/hw/misc/riscv_cpc.h
>   create mode 100644 include/hw/riscv/cps.h


