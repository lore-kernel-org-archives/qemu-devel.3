Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EFBC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIjy-0007WO-U8; Mon, 01 Jul 2024 11:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIjq-0007QN-H5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:14:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOIji-0006g9-JC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:14:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso24822185e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846873; x=1720451673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2a0xXDjwxeZ6FAtG4UH0onsqj+r76a1/MttyDo80JQ=;
 b=OJxbfYyKDeu8HIGSOm3rnbj0UpOCRnXdITnFcD2iOVc2TXsWKyloeLPpOi84kq8vMU
 tmk6cF4mA5IBQCWZ56McQuPqt4XIdWDsim82jXjaG8tyi6BIRuL/9aRuBFR1SEkfjMBG
 ZbVxHkL6LJTdnL65puhIryP6R8CK0T8HUEbSEJnCIVNB+3Zq3xaMuA99cO0lL1Qbt3WQ
 hf7BCpEOcXVBsaZ8k1T6ChhnAlVtLlK78VgbmkyrelvNJ2EEm/zCoUw0DvNMAjyncZKW
 L5wCqKsf/WWq6v8O2mRW1kDNaDsTiWLgCwv0Ox6mJ0cZ/Cv/8OAJnJ3DQh/SlBJJkJGh
 6WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846873; x=1720451673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2a0xXDjwxeZ6FAtG4UH0onsqj+r76a1/MttyDo80JQ=;
 b=OQBs3GP8+Z7O8515WEonUQQkWxVSl79366GZJJfhr8Ztym6oYMiy4RcHYdT6B1CDVU
 r1DKJg3l5RJgehSmkHmddPR6Eu9eWOs+Sbr59X9yNI6xiXtxzNlymCYzww+mdadN5b34
 fl1EJF9JsmfnCNVwTzuaDui4WD3Uj8QFHkW1S1CWdLPlNurUqPQgLsR3CxDuZZKlQ7qz
 bg+kXRmRwW5xXNKyNf9DJdSksmA0InfrpQrnV6APpxLhhuJk6O4v0fQFn2LFSGGtxHQo
 QFc06cvQdKKGN7vSpHjsBlcRhKk1hX9YBtwHGyLOQ6wevBGZJrdxBuaowbRFixNQDBF3
 cDSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVInCixqKofKLqlgNKojHRXs1o1BGGcgSKEIGfmhBROpEtVZcBmiH/mbNjceEt+mm6wIeUvkLFcufVT9bC+qZ6EH6hIzBs=
X-Gm-Message-State: AOJu0Yx5nLZXdirvgCtVxFsU2adbmLpfoJNommKp8vSs+Yj7lMPeTCQH
 +PtpS0s+K/eT1w0TfpczRxGXcjf2Ua4vEjESn4BT6hRR7Hh4TerglKBW5weqHLs=
X-Google-Smtp-Source: AGHT+IGIbbUkZ3k71CDHK25YcPbRrrdvFuLO8u6yLVmJuZmSkOtdp4D7LsjGIdL592Zpuy+s2fyZIw==
X-Received: by 2002:a05:600c:4f12:b0:425:675a:d52e with SMTP id
 5b1f17b1804b1-4257a02147cmr40629535e9.2.1719846872957; 
 Mon, 01 Jul 2024 08:14:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1055b9sm10255077f8f.95.2024.07.01.08.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:14:31 -0700 (PDT)
Message-ID: <6934fc98-b638-4cd7-8431-40ca11f48cfc@linaro.org>
Date: Mon, 1 Jul 2024 17:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] hw: skip registration of outdated versioned
 machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-12-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> This calls the MACHINE_VER_DELETION() macro in the machine type
> registration method, so that when a versioned machine type reaches
> the end of its life, it is no longer registered with QOM and thus
> cannot be used.
> 
> The actual definition of the machine type should be deleted at
> this point, but experience shows that can easily be forgotten.
> By skipping registration the manual code deletion task can be
> done at any later date.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/virt.c              | 1 +
>   hw/m68k/virt.c             | 1 +
>   hw/ppc/spapr.c             | 1 +
>   hw/s390x/s390-virtio-ccw.c | 1 +
>   include/hw/i386/pc.h       | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


