Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C44C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Mxq-0000rJ-SE; Fri, 10 May 2024 05:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Mxq-0000r8-4Q
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:54:54 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Mxo-0002Ig-Kc
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:54:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso471543166b.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715334891; x=1715939691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UCIU/5F/IQvR5oTCFId/ZxqooeGFTpmW7bXcpwpkBu4=;
 b=TD8thOUjj8MYoAo45l2KeWTof1u4+Bt4Uck3ZprX3zQpe0e/aseBS/2KcquwXuVb6A
 Ca53vR+CqIYJepygiBIF69wLlWlWFc8CZl8jUjZLkFTV8xs8bILkDCZg09m4eGezfRBn
 EXGzjBkfX+MdYBb7mMfjEYfACRQAVKJ/IPWWwZqBfNkhI+nxFBFh/w++vFJd+XSiXYFe
 guz3c4DiM5+HUAJaY2CQOebXrVV4ZW1uvMLIhVgPbRRiqM5m3knyWwFO14891APtZWOC
 FFnT1gOj7zDYokewgwyAiyFiMyd0K1ZrdjYJ2u4WCmjjsTVQDtfIoiNy7UKocedwYixO
 27mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715334891; x=1715939691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCIU/5F/IQvR5oTCFId/ZxqooeGFTpmW7bXcpwpkBu4=;
 b=sjvwwAcHflSVzdgje7FaYgu3H+bnpNWQOywOOkEZfaO8I0gfDOC+nHf3TZvivEEiag
 Pa5An8CAYNQ7wiXc5pFThY3HcPoafUhWGsTQaeqYI/1RLM5ZylKy7qKvJlwfqpgLAXHL
 p2BDjCR4Ic1VGfvh1v+4+CBrPeVMiFo0dzft4SrNDOF5O4UuRm38ARDR5kRrOK1iNZMr
 aUt5t5d7D9svv6I9d5cUfAMsV4PiuPGnc2w47O8vOnrz7eWkKjumOF5pGCGEznxkH8Wm
 Xs8YZf9TAm0fhaV47XC3Lw/a5iLTb+N0jLkmeon4O927x8H8DS9A/cX04r91dSkUqECA
 eWuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLX++TTB7AAqwimKFtVydZ3Os/xjCuFqo77ME0EFn682fc3RTjB3Wx02IHpqrW24qZVv07rnvCsMq/kG6Po9lyi8SAymc=
X-Gm-Message-State: AOJu0YzJslGVZh2NSnUu9HELCT3BOKmg2n9sAM6pzyXUmJytVaXarcMy
 Sdq3yaemrcYYaSVeNMd3boKAz5gR6lM6Ldpv7RmmXLbehwsL9Wp70LUMJnkLjrotjadVKG0iW0G
 D
X-Google-Smtp-Source: AGHT+IG/Fyw8Y5Reys8Dp9a+aQ1uT9NOJcqMAFpQGCGICPk8HWSiTgjGNJk/h4O7COU+bp+RKBpsDA==
X-Received: by 2002:a50:c349:0:b0:572:8b30:bef7 with SMTP id
 4fb4d7f45d1cf-5734d5c172cmr1651319a12.2.1715334890854; 
 Fri, 10 May 2024 02:54:50 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733becfcccsm1629032a12.40.2024.05.10.02.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:54:50 -0700 (PDT)
Message-ID: <53f5cfba-ce73-40ed-bc7e-fd4923dec764@linaro.org>
Date: Fri, 10 May 2024 11:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/26] hw/remote/vfio-user: Fix config space access byte
 order
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Mattias Nissler <mnissler@rivosinc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20240508174510.60470-1-philmd@linaro.org>
 <20240508174510.60470-6-philmd@linaro.org>
 <287e1fdc-3662-48a3-a6cb-bc5008d96525@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <287e1fdc-3662-48a3-a6cb-bc5008d96525@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/5/24 10:18, Michael Tokarev wrote:
> 08.05.2024 20:44, Philippe Mathieu-Daudé wrote:
>> From: Mattias Nissler <mnissler@rivosinc.com>
>>
>> PCI config space is little-endian, so on a big-endian host we need to
>> perform byte swaps for values as they are passed to and received from
>> the generic PCI config space access machinery.
> 
> Is this a material for stable?

Yes, sorry for not adding the tag :\

> 
> Thanks,
> 
> /mjt


