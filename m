Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDOp-0002sV-CU; Tue, 06 May 2025 04:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDOn-0002sB-KB
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:11:33 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDOi-0002L5-HD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:11:33 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so874945866b.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519082; x=1747123882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GIAWZC2t4dWOC0QcsFDibPEeRsNatWR+X/mfUVQl/A=;
 b=uwfUWzhw0TbMiYkBdwwdBDrwxsTRi+at1jsLytU8TGMQSomphWIGcoM8sPjKlSgeU/
 D5A9kGM0/hhG31t9ieJ7iGpKoUectnYDYHUrjH5f9lAeaEzns6DML8lCTlMD9HAF4oYU
 Sfw44qmR6V/KIhsYqKVIaxpQIQqXcm2vKTqkjcOE6VoWXHTTku/G6B+gJKevc7mJt1gR
 oM23iW0+Q17JrSv3oPcKVqpyd/mA8o+aKl08LUswu2eBm/6CI5l5sKCpdMUNX0yzsEvD
 +hCjenOmGgundx+oCdTKLPo/C4L/nrwr4W3ocu2gzX1mih9/wxchjfg8uo250J8F0rRE
 dbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519082; x=1747123882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GIAWZC2t4dWOC0QcsFDibPEeRsNatWR+X/mfUVQl/A=;
 b=Ayry0qSofvRXlsUMdkVE/3LBG84qWkxMJKaJLvONmv+1vDgEhw+KGKbekuKjwlc4oK
 CNX0q7Apmb6tpcwARxoo4xrJvwao8kDqnNp0kBAbjtSZwWAA73RBdUM4WxLVQaYwpdhD
 UxxmIwhoWLyE/mjvf33XTDKPKxxb2hh78qTG7eAeoORVNPUGkIHWCf1M1W7BYEMgzaSb
 NCc5kKLjniDCyNOoTEEeI0i5qpcAVDTypB73Xh09s5KAqLaESmuMF7NvDb7a9asZVNPx
 3rO2AQfEGeiYeVxCcT/z3ll2uibtnlcCb3LsG4GBy87i0QtE4FW/Dz/N2P8z4yimxSTj
 FtfQ==
X-Gm-Message-State: AOJu0Yx9mb9f+Ds6Z53YePriQstBK66NeDOR5H0fxVKwkWCDhwK3RUQA
 ALTp0QndUX9z+m45Cqq0yucHYP+i2UpFWHuuZsaO6VfATFL3VgstZn+t06UYIBY=
X-Gm-Gg: ASbGncvCuq5hdJp98YcLIcfpWj3LL9phZtfofTWi+zFA5cS9tElmJYDJbpQziahua1G
 YZ573emA8yK5PIZhDuqNmf4oyVcgFf7JxQLgH7JhW4Q7nI3+BwTHSzJ7LOjMZCnff+GXUHew54B
 3jkp4T024fjekW3dCTwJHf8rKQotPe5t5bPxm3qxm9jqu2ZpiTI6qjxvovQsoiWZO9eKYk7Ys8T
 SyHyaOTyUGx4cagehYJblwt84N/eKSIrQrLFENUAXHUegUaeNef6bCPsq7NOvDToK28luA9n/XZ
 UmykH+LPNuJZp2knPsOJsGwjLkmgb6QjquciU5neMWf7XdwRC/mX+nJFiNpJ3og8RgS+kH/mQrm
 f6nce7KlOLnZwIw==
X-Google-Smtp-Source: AGHT+IECBQINNI4LKC133PnPB4V9RdX9gKcaNBAlgf/KLwJCZUBKrRsxJAXu72fScnuOEfPLidgmzg==
X-Received: by 2002:a17:907:3f9f:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-ad1d45aeb6dmr188504466b.34.1746519082278; 
 Tue, 06 May 2025 01:11:22 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad18950928esm657765466b.143.2025.05.06.01.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:11:21 -0700 (PDT)
Message-ID: <d6c4e9f1-d801-4df2-8950-063bfa366316@linaro.org>
Date: Tue, 6 May 2025 10:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] hw/s390x/s390-virtio-ccw: Remove the deprecated
 2.10 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-2.10 machine is older than 6 years, so according
> to our machine support policy, it can be removed now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 12 ------------
>   1 file changed, 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


