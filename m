Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEC1C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8t6w-00070J-8B; Tue, 22 Sep 2026 01:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8t6t-0006zI-S3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:32:08 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x8t6r-00073P-MV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:32:07 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d91a931f66so26227455ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790055124; x=1790659924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eRzsPm4fw95V0jhUrGmmn3PBBw/ZiV5iu1fvnAKvciM=;
 b=bmljLqEGl3OvP4POf8EyoqCMy8C4b1ceZjtNOuDtzJDIyBeAqEyiKiTz4rWxSGMxGi
 s+ct8EXsmQ9Nc1G/fExGN8ZeVGWVphToW4UlyEYsBmLXBcJV/EBjmGvvxzbx9AaecZqE
 xrDBYbROsEPLNhH36lXg38peOtJNK3drCnHIm3yrKEYzLyIiDxGZBaoV2OCyKTN6ZiDQ
 SalW/xzOLI7eN89R7L1Ew8H/DQYazJQ03HEoOqhpFB91AXHR2CLg/EJO/d+yHB8ZRDGF
 3ZiKwzI3T9u6+CGvRKVsPfwu0F7TFp7wn+HGw3EnvzUZVvbnpXsgeE0rdFoUNQKglBuY
 VHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055124; x=1790659924;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eRzsPm4fw95V0jhUrGmmn3PBBw/ZiV5iu1fvnAKvciM=;
 b=ZxACqpEbA+ubC/7Gwzn6qT8BoYqe3mjokYadg/A7b0oki2ki/TY5RVb3OcY4eqjnbt
 2ZG9cG4eWwXBECwUYutZZ6+LvhuBsWhysmkvgf6PScYIjpIOb6U9Sf58lHGET2u5s7fN
 7DTyFcc+YoJtH1zGKVtyBHVFHptGQDj+kp70+RagHaF87VQZ5IBHhFxi1hR/lxvh06tO
 bh0ZOkNGhltdNUfbiJ7+dmX4fxO6j8lAP9yG68hgt1758Ee7b1GkWjMFP0YTy1+ZBMoS
 tKaceV4V3FPWxemJ/sMW3Prk+e6h2oyvdQg9pode/Ni2Rf+0xMP5gxEeN3/0ePTGEVOc
 ulXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzavyKjDUwmUg4e0u4XptsY2J1GbIyJ+SvlOB1Bx8QCtdwlFhJGjdRIrGpupu4BsN0pl2RrvB0hmBBJ@nongnu.org
X-Gm-Message-State: AFuF++l4nCeRItexa8dN6/o3VZDumR2u36W0ZpxhZnAkQF6R4E4gqtoy
 env4K1Bwc3inZbHSXcLUjfBOXhxXYYrzUa407uP3T6+g3gYw7QK8YXsJqDKLyN6fhpI=
X-Gm-Gg: AYBFou3oB4XNYHtOwE1POb/u2XBXfXBZT5weYx8MMAJ68qcOnnCSMxfQReRCaS4b5VA
 BKFym4qq0po//Tgtfy61oahxDsEtZAXzsg51f7G61kz0AYnCbR0ifr2aNiUQTe+CPtH7tOibJs+
 PqNZaFf+Q+Mra+GhvAsigKleBONLxEk83hFo0gWhpy7QAvv1UBA5tdIZ/jrt2gE3jbLf5fZGeDb
 y52+qF/JeRB8k4y1sICt/lGMhhmVwyjTen2O1k+OXEPIAkYI6eGsAFS69DM4BR30/2+kS7cxa+L
 LV5BsON9YNVx11SGZCyjVmWqel45XO5POX3S8rzM3orcuygANMtPt2h9r6RbBrJdnKd7829T//E
 F6NzWKIKNYEQ3W6WlGH5+03jwP4xnjHLOlupTmN78OChSFxKAGQpQGM1LctfYKr/MPMD+KUhWfp
 lIwUtOsZ/v17Ooj01oUxVL3NfbfeGRxInSHQQa5tPdP/iwPvu2BZFCpYML8ytL/Bsf25WQM/idO
 QnfNgVPzQM1l539iWiclTvm9+JdgmKh1xZDtzI4
X-Received: by 2002:a17:902:f641:b0:2dd:ad74:6d21 with SMTP id
 d9443c01a7336-2df60b31e02mr553435ad.30.1790055123889; 
 Mon, 21 Sep 2026 22:32:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d0682d6sm3396015ad.80.2026.09.21.22.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 22:32:02 -0700 (PDT)
Message-ID: <dd36a745-cc09-4ddd-9b1f-908d8114bb36@linaro.org>
Date: Mon, 21 Sep 2026 22:32:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/33] s390x queue for 11.2
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/21/26 13:07, Eric Farman wrote:
> The following changes since commit c1c18d1e640b64292859ce9f30f3c344edfb0294:
> 
>    Merge tag 'virtio-snd-migrate-pr-v2' ofhttps://gitlab.com/epilys/qemu into staging (2026-09-19 10:41:53 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/efarman/qemu.git tags/s390x-20260921
> 
> for you to fetch changes up to 96bd689997443a15f259fa99a6a672eb1f65062c:
> 
>    pc-bios/s390-ccw.img: update s390x bios (2026-09-21 11:46:02 -0400)
> 
> ----------------------------------------------------------------
> New s390x features for 11.2
>   - extend CPACF support
>   - enable secure IPL for virtio-blk-pci
>   - enable boot from virtio-scsi-pci
>   - regenerate s390-ccw.img


Applied, thanks.

r~

