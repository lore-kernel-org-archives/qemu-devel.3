Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B39CFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmRZ-0002Mx-2P; Tue, 25 Nov 2025 01:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmRX-0002LV-0a
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:22:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmRV-0003DA-BN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:22:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so53551335e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051744; x=1764656544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9PMY82i/jaFQBwB85/CZ8mIcoZUJob2eOmqwSq7Cyo=;
 b=VD/SgKFnSFPmMhaQwn0P6VRyav8K3P4rIAnqPlXdZk4R9kEF70RVC2zL2Q9cCJ4Paw
 V+47rb61etvubUNRKC93nTUN6AtgDSHOrGa2fD+V5j+3ZUovfmGUDJxxNrsW1kMVPcxj
 rEUQpvDHaYpppJUcRoR0EbemjKS2obcSqAtEq4FbM27OWxV9D7TQbcUNnTTUMtTpaIOq
 q+XIL02Zblbpiy9oiTmm6Hdx117W6VIG/+3RBLkTK9k04ACLJyGoi+kvpF7P8BUjKjMn
 TXvtT33TOy8FLCYzu6GPpdLyLvkLc+kf6OZNkXvcn+Bmxle6nmNAQ8igiZ/fwCINkduA
 nmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051744; x=1764656544;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f9PMY82i/jaFQBwB85/CZ8mIcoZUJob2eOmqwSq7Cyo=;
 b=bD2gBiViTKKa4mJpgovMlYMYCr2asXqL2DCIr5MDBRONfOtyo22U8N/9124mROmBYo
 tpOyu3xa4hCNR7iEJZoO3qxG4znHNM/uthxdPCKhedSK0x+nlnZi4BxYKVk5/WpaxvFX
 IvSmnNhg+IO/YypVw/EKZSzq2hT2HO0jtvnTHI1Y+zjNaExRIBoI0t5kVWO7rOdJUC2t
 KhX8sJkKFyeC5czR9d7IVn2/AyWeQFD6+HNDlB2jiQwuCzTMMr55eZv7wny07VPSbUBH
 nl6AD5+2IsWfWzVqLsUd2a6IRa/m1oyNK24kdN5VWe/M1Swulztm2OpT6d1B20ctI22F
 HESQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTO29VkIc23b6R5BpYdtSs7F3Npa6rTsz1tNeBmLRfdnhX5WoiGbvMaix3wcZWM6KNg2Na+muEXrKR@nongnu.org
X-Gm-Message-State: AOJu0YwNcWdAsjVEJMZaagICepDjs/7YCBaPoQgmuPvSIck8+roCVXZ8
 a0t82nQ391NK+kfgQ/+fixmwIWBh9BXWE/mEmPfat7H9xUIrcbvPs8+OBzQqyVNXwwo=
X-Gm-Gg: ASbGncsv0YJTlAx9OETAFqhwv/LnXYGYdIWjfUtWqjL/82ITcUMQsCpclnJl8vIYSes
 uzSesFKmOml+UxKoVcX1bv7QaHoA3wHXBDgHBeJCJ1rgCkADUr0qsFV3sGFUOODyKyRCSiNCfy6
 dOFTLtoDGMPgmBmBhq/Gl5teOxJAzhcNtxnKeULNqWwP8ZqwZAAoPd1MljLIE2dVKFgi6OAj1Xc
 2HOVC1z8DjwDbyEwPIAeRYwSog/i73yQDMJhCc75UwPTKcmdURiWFwTlxXScBrXoiX+Oi8lYhMf
 hxF8ywfAixB0FotSFDV/W0RYXiTyc4zedlkXghLP9CZv33xIhi+wQIUtNKnr0FEglaCN7kmXxIB
 jyjMVjvCsjsuaC9VLIro4pQcqhAEx8QgPV3M1wtCPUEtyDtjZVC88gYdHOANygMnSALlnY55g7i
 C9X7RGGvk+dXWCbkIisI35NigNij99h3og1Tiwuc1/g5XM/lbALvoSPA==
X-Google-Smtp-Source: AGHT+IFDchfo8wmvxExDOTScFL75Y50QSTKmA05qmrURNbKfXMlTq1TI/FEAoocUx4gEjb2eI/uz8Q==
X-Received: by 2002:a05:600c:1c87:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-47904acef12mr14222015e9.3.1764051743857; 
 Mon, 24 Nov 2025 22:22:23 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477c0d85360sm227844905e9.15.2025.11.24.22.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:22:23 -0800 (PST)
Message-ID: <f992f60b-515f-4834-88fd-d033255bed83@linaro.org>
Date: Tue, 25 Nov 2025 07:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] error: Use error_setg_errno() to improve error
 messages
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-13-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 21/11/25 13:14, Markus Armbruster wrote:
> A few error messages show numeric errno codes.  Use error_setg_errno()
> to show human-readable text instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/cryptodev-lkcf.c   |  2 +-
>   hw/ppc/spapr.c              |  6 +++---
>   hw/vfio/migration-multifd.c |  5 +++--
>   migration/rdma.c            |  3 +--
>   net/l2tpv3.c                |  6 ++----
>   target/riscv/kvm/kvm-cpu.c  | 11 ++++++-----
>   6 files changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


