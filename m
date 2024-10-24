Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91E0CE8E6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41gl-0007np-6e; Thu, 24 Oct 2024 13:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t41gi-0007mz-Ug
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:31:56 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t41gh-00080f-Fz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:31:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c8c50fdd9so14431795ad.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729791114; x=1730395914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ex1eq2dXKoKZNOU0o1C06Yv7ZF6tTCKwzI2J53l4+GM=;
 b=QS4YqghvcCqM9kB2QU4tO9Ndv3ddLhvUFwWBy1oWdW5Cif5Hb7zHM4RQN47E6Ah0En
 Tppt0nb/v9wx3yxOeh4k74AvBurTR0rXUxzt9+OsTYrRitLVd1SaLxWIVn9qlM0+utba
 A4tZUK2rMR6q3kJEvEKgizfC9H1I4JOuZS7krYcFmQI8zY3ldIGatuVDwfH6y4FySanU
 ysy20d+NABB9fDnDtV1Ib/ltG+7gtHrLSOR3t0VswuiC5e6ku3IIunPA47nNKnXYNR2E
 OLHT+9wuLV2lZyiKdk+W2YYCccPkzGtcMeiht8yyOPAK9lxKi57FrnswBMFInr4ds0qp
 ffrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729791114; x=1730395914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ex1eq2dXKoKZNOU0o1C06Yv7ZF6tTCKwzI2J53l4+GM=;
 b=vdmCVrwro95EjgEBX+SYpmANC3eUznbpf6j15dCWbZtVaoFcuFJhfMS3X6Wlwzg4Hn
 nvHwVJPMGM2YBS+y2VuOK+N3nTF01Ze8RYcpn0ttGkvDKyIhK6YHzJl2wfSm2h4gXCHO
 RPKkgedbnihnaQHRM+ESMOx+HthU9M5l1PHt4RDCQ9ZGuEo/WRpFSQfhDxaTI8GVJPaz
 L2+D/KE0RE9qDTjEwo5bxokEVnCYvo3j0y8R7wnGKqCXZ5h8vy2ScllSLkrSkpze9TjM
 Tm23CRhwqdXfnIxUYptFGWuBWugc9rQ4SEX4ZoQU43gnf9iwoJajoguAIjlCd4XaAb2X
 uIDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD9P/8oTlHQQHE9FOpP4CjymGSd0JVXYHRJ2bWn8wpWg/ZEo5XnShb9bFITMOaTmzfZ6M+sqY/TWA+@nongnu.org
X-Gm-Message-State: AOJu0Yyptpvh9g7x3WtrPBNdZBW6RQR6HB+DQmKFdsN29EXT+AZmiCnM
 45TSKKM8j8V/eGjnJHywluJ7LHIaEbMaEEdqb3f8Cjf/Jr9OZHGBkqT3XewPYFY=
X-Google-Smtp-Source: AGHT+IEcnU85hpfpG09I5j1Zg/mGrURc/ShV6X7JE74sguCMNSijNb3zWz+iQAB5FtRveKBaepuBGA==
X-Received: by 2002:a17:90a:d40e:b0:2d8:b043:9414 with SMTP id
 98e67ed59e1d1-2e77e7b1407mr4599208a91.18.1729791113839; 
 Thu, 24 Oct 2024 10:31:53 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5df4162ddsm4082128a91.0.2024.10.24.10.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 10:31:53 -0700 (PDT)
Message-ID: <c789363c-38aa-4754-8a2d-a75eb0bfdf76@linaro.org>
Date: Thu, 24 Oct 2024 14:31:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Re-enable the pci-bridge device on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241024130405.62134-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241024130405.62134-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 24/10/24 10:04, Thomas Huth wrote:
> Commit e779e5c05a ("hw/pci-bridge: Add a Kconfig switch for the
> normal PCI bridge") added a config switch for the pci-bridge, so
> that the device is not included in the s390x target anymore (since
> the pci-bridge is not really useful on s390x).
> 
> However, it seems like libvirt is still adding pci-bridge devices
> automatically to the guests' XML definitions (when adding a PCI
> device to a non-zero PCI bus), so these guests are now broken due
> to the missing pci-bridge in the QEMU binary.
> 
> To avoid disruption of the users, let's re-enable the pci-bridge
> device on s390x for the time being. We could maybe disable it later
> again if libvirt does not add the pci-bridge device automatically
> to the guests anymore in the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



