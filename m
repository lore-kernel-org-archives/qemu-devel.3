Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0FD41C39
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 11:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBBw6-0001xA-I0; Wed, 13 Nov 2024 06:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBBw4-0001w7-B4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 06:53:24 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBBw1-0005Uz-7W
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 06:53:24 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso4334597f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 03:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731498799; x=1732103599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fw65cSVokJkxQ6NeO0sN4D2qESC5ip96VYkQcwL4Yzk=;
 b=AE293SbVq4Wnx/Dr3qRuvE/NloXy1hJncyCvoGjtuLJQXbo8dCnguCMgyddct6phTb
 Lj788R+OQWY35FvNUpRm7xoa908CZBKKC8KlfHxSwqQg+ZFhNMh+25U9W72r1uS2ce6Z
 32UWhv+L3d/eD/5++NpVDdszyelsDoz9rsnoD53HN6L2wosLTY88t5FgPgEuTVn+9oKh
 9EQcyfl3KsbgKriGnH+FaCkWoWAkieNgsjJ+bu1SgSYLsPgDPMASU9MbksNRCCVZxXF+
 c/CUH5MSukL+9XKTaUJXkOp5f650zjiFr9Htv39Zld3yhwEN8TOMqBKGxEgGZ2JSE22F
 a8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731498799; x=1732103599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fw65cSVokJkxQ6NeO0sN4D2qESC5ip96VYkQcwL4Yzk=;
 b=S1knfkgI2qr5QIH0IeoX/T0/849ZOotXeIJC2ELHkiBtV5oUynMowuFYt4WnqFJW0k
 j+/mXRUtPEcn/cbZs9DdJdsj9BG0epfigbHSS5MKGiJpmwDu9Is9ZnMhpZoZjB0r7b9x
 eWW8Nyb64ndFXsHaB7sA/usVjbIwnOYS0bvXDBvSUBUv5AGYCVpsPtxrS2pl+p1IeqrG
 Fnw+tD4XV0wfCsklIqKk50dUQPLXLKr4G9KUd/cCgUx1Zp9dSNpgJKJxTrDM8sELxCgz
 Vpv6wj9fzCmzWat1zAe5FPCTYeTeEyvXmiOr0TsAFZOUjQQX3+HAh9y5sQ5H6xYFORzA
 QXbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8+gqksgnTw6IguPsKzJOYjqSEyfYZuai7FkaBnCmO8y8dtK+vovBIgLXC6O6Vcx51Ve7pB+rNm2zP@nongnu.org
X-Gm-Message-State: AOJu0Yx2S6Wd9RUkIxMkxLwLLkXt+/a2AZaYxXFfMHGsyu4r3fQrQJ9k
 DeJiPfRMiR1F6Rn35tYQ/TJRY/D1PluJRGgEXckApb/gLytlNRMQIwxtfHvUifw=
X-Google-Smtp-Source: AGHT+IE0lb8016QmAn8t7n3tChYQBAYjN10KNqibyQmCJAj9L7wK/3AfTld39EfGeFffIlKUlY8gFw==
X-Received: by 2002:a5d:5983:0:b0:381:bdeb:1799 with SMTP id
 ffacd0b85a97d-381f186cd09mr17979149f8f.16.1731498799413; 
 Wed, 13 Nov 2024 03:53:19 -0800 (PST)
Received: from [192.168.69.174] (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr.
 [176.184.27.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97e46bsm17910989f8f.30.2024.11.13.03.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 03:53:18 -0800 (PST)
Message-ID: <6d223fe9-9dc7-49fb-a5b7-8835ff2b52c8@linaro.org>
Date: Wed, 13 Nov 2024 12:53:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Restrict "loadparm" property to devices that
 can be used for booting
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20241113114741.681096-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241113114741.681096-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 13/11/24 11:47, Thomas Huth wrote:
> Commit bb185de423 ("s390x: Add individual loadparm assignment to
> CCW device") added a "loadparm" property to all CCW devices. This
> was a little bit unfortunate, since this property is only useful
> for devices that can be used for booting, but certainly it is not
> useful for devices like virtio-gpu or virtio-tablet.
> 
> Thus let's restrict the property to CCW devices that we can boot from
> (i.e. virtio-block, virtio-net and vfio-ccw devices).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/ccw-device.h     | 5 +++++
>   hw/s390x/ccw-device.c     | 4 +---
>   hw/s390x/virtio-ccw-blk.c | 1 +
>   hw/s390x/virtio-ccw-net.c | 1 +
>   hw/vfio/ccw.c             | 1 +
>   5 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


