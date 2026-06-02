Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CC9C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKCK-0003u5-9c; Tue, 02 Jun 2026 04:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1wUKCI-0003tl-Ef
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:10:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1wUKCG-0002ZW-Rt
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:10:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so83649335e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780387798; x=1780992598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=1StUh7JbBAg2/PaMLZfTADpssQinVdArm8pijSahYNI=;
 b=QJvH3oes709jncBl7POoY+CSKN/E8CXG6+3DTamgqcIfZXtMaSvqUFqXAqEV0hreQd
 oBjkGew7H5HKc9I+oZ4JM3N5y5rARFc6PN4zjINiXvMUMNN56hXASkih6LFQWvzmV82v
 v9TfezXRVNVTH319J0HuTQRgZ2tNeZPTUFy/IPizBVK8/BA04kHTc7i+qlkJWqJAyqtI
 O/gpfusoCKCm3MmxkFJxH8Ibp03q4gq+NdcR52LLTWOQiqLmaPfyl3Xj0gObA99gsNZt
 FTNkqkn6bX24DAZAxlMsNW3oUtzs6tnGbNZFWGuv+W1QPyu9DbdOG5f9ahZiGk7cvpT2
 5pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780387798; x=1780992598;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1StUh7JbBAg2/PaMLZfTADpssQinVdArm8pijSahYNI=;
 b=a3P5F7efnNpONWLq7UPV7eR7HMUctTmfj9yKoCQCUDwBdYiuZL2X4OGehlQde0W4A/
 ubZjJzTZwqBm2XpF7rBitnAXnDOp/rHAxlTDelc23xg1ANnj0Nh41Hc4o6BVZTiMFQvj
 zDukCOBes+FrLC/mxyW7HoLQl7jP7RiHVyEzwSL5YMk5kgGU81Tz7SkJJ29iC5v4HatJ
 mVC7dcH4Tp592/8CUgf2029umQN02x68gWIAMtb/uaOloXiLvOVc041YUy7GMwTCmf6C
 3jMv2g82XigwJlazCrrJM9fsvu5t/DrU35+s66x3bFLKlu74To2ZjVp02Rso1laT56/2
 VAbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Rd9oYbTXZ2iIOg7F/PzeoMR03L6ZjVE9uapQa9W1lSWhqoWNthgjbC25yGA5vnLQJtn9d5fzyDjEI@nongnu.org
X-Gm-Message-State: AOJu0Yy1gGoAtRcvpOCuFzgbrxUtba3UMR0b6sjrXjly5/ApBGmo+ovp
 G/M5vq0LISHcDZWJ8amHJhVK+eSee1ir3sJffXh2dhQMW5mq8QeuhyMV
X-Gm-Gg: Acq92OE+81XXFR34oXmg+kF73hM0jRMeNYuzOdD7mkC/iNNprS+ClEbWF0T5q9ylnwI
 +PhXXsGcdS3hRJzB5seWs98BeQQayFthHjg0gDhcmHz+GtRd6x53hxQ7xCl0a5uRP6cs2yKrEkF
 KpQlxv2J2E3dVqKZomItUWc92x6wT6T71EcLiw6jc91Irf2McL+nVT60jvS5ectpugSuZ+5Ue1F
 GHNBrD2WBRP5TXxz7USSguqP2WvnV/VrY/xBtYq2WfZEUIu9GirxXzvZabSJnQTk1Ba+JnMG0K3
 BgPIABiphPOA+VJvocsf9n2ZTz32xtEvAabuD8Xglbkt7yTyY0AKfFU9cDlnxTpbJ71ql1Ar1Oq
 mMR8WC1VB8yvYsXB6IndFGR+YAJvBSjIGEv/xaHGytmP27EpVAGk+CdsoRdowu7z/Ux3PzdgvzE
 Ylu2YkJSpTCtpN1lyO5jGpkifwqRqauZOiK57KrvQcWnd1
X-Received: by 2002:a05:600c:6287:b0:490:a1a6:6f24 with SMTP id
 5b1f17b1804b1-490a29338a8mr262796955e9.15.1780387797792; 
 Tue, 02 Jun 2026 01:09:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b09ba7easm16681415e9.8.2026.06.02.01.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 01:09:57 -0700 (PDT)
Message-ID: <ff08c5dc-f55d-464d-9401-719b1e833acd@gnu.org>
Date: Tue, 2 Jun 2026 10:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
 <20260602033118-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Bonzini <bonzini@gnu.org>
Autocrypt: addr=bonzini@gnu.org; keydata=
 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
In-Reply-To: <20260602033118-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/2/26 09:38, Michael S. Tsirkin wrote:
>> But if as a project we want to limit the
>> blast-radius if we find we have to rip out a hypothetical tainted
>> contribution, shouldn't that mean that we hold that as a project-wide
>> line, rather than leaving it up to the opinion of the individual
>> maintainer ?
> 
> It's not clear it's practical anyway. So we limit contributions to 20+
> lines, so what did we achieve? They accumulate over time.
For small contributions it's more likely that there's essentially one 
way to do them, therefore any copyright violation accusations would be 
more easily defensible.  Also it's not like you'd rip out *all* small 
contributions at once, so it doesn't matter if they accumulate.

But yeah, it's possible to game the system by having many small 
contributions, which is why the policy tells you to contact the 
maintainer prior to sending many small fixes.

Paolo

