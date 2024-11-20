Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978AED711D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 17:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDofF-0006if-Jp; Wed, 20 Nov 2024 12:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDofE-0006iV-In
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 12:38:52 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDofD-0000JU-42
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 12:38:52 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea2dd09971so39038a91.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 09:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732124329; x=1732729129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zx5JAq7k1xJkr2RccleZsMb7GIfVTAn/0w/7U0jRir4=;
 b=vT64CKivBqobKwW+Xjd3jTGRD0FejE9w0Q6oz815t4vbtPXHm1oVydoRIlJlFJ1+dg
 CvAm0zfdNIoF2VUUfJ5h22g9KkpLZ0cDSSz75IcY1gETHBioqkjIXJcOqig8bzMVNn3V
 ZBckrGo9vwQ7F4I2I3EI/2+ApzcCW+kRbHarMgsu9w/ZzI+otUZl3fxdeLbUVTBjlKAC
 1dNpEoGrukb4nXVyVijzMXtjSI6ggWuc+bBPO2hY9RcM2SIl3NHCA8OWpCdVTh+LumVW
 trcXLIIJ2OkM9xK2ugZo/3IWQD6nQ1bbmop38oFsYJHAe+0u7rCyTDTP2DwCV6EOvBkY
 SgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732124329; x=1732729129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zx5JAq7k1xJkr2RccleZsMb7GIfVTAn/0w/7U0jRir4=;
 b=A0KK498n3BlImR0dncMMdi3IuLxjcxXHqo+4XRA073AX+7ICm1+KNx4L6LTOa7jcGz
 apyoOjOAf+8u6L11gmt086ms+KuiPwdYaaBAxJTGp8P8ruEn9AV88UNvRgp+Omce+yi5
 uUg3NBKeDGJ3fDCaqATT8Twst9o/DOCHNYT4NNxaYKwbG8capGNoxIInkTObMxnESyRJ
 U88tvMZeEfb3ZmISe7Hz19fhgWL8vp1Gkf725rZM2PVF+6aKVsnUPoELsxBwtZpKL7Zv
 3XL8lNgKY5ZRr9mMbFQQ+JTu25UpeECo2nyfsAsChH/T4G/d1DFuhf4n1BNvep2JNqYv
 nhUw==
X-Gm-Message-State: AOJu0YwDXODHljIVxdWCNnrU5gLhQMTZl+4HdVUJ57WVCMvYM7A/GYqV
 y3a5OY3f75agzXW6+UFsCwu6mDO41XWS+cO0vcIK2QJmc0dG3FfN2i/5/kZNVg0=
X-Google-Smtp-Source: AGHT+IHFHzXzcg2+UzvXgF3TneHikpUK02jyqqAHrI2bswcMQ0R4r3dy2pIL8OryJXyfdMO5bxr+4A==
X-Received: by 2002:a17:90b:4c04:b0:2ea:c2d3:a075 with SMTP id
 98e67ed59e1d1-2eaca737bd1mr4547369a91.17.1732124328666; 
 Wed, 20 Nov 2024 09:38:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f6182bsm93995015ad.277.2024.11.20.09.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 09:38:48 -0800 (PST)
Message-ID: <858acc0f-0426-4a91-82e9-454b5dca74c0@linaro.org>
Date: Wed, 20 Nov 2024 09:38:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: remove unused but set variable
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, alex.bennee@linaro.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
References: <20241119173445.54684-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241119173445.54684-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 11/19/24 09:34, Paolo Bonzini wrote:
> Queued, thanks.
> 
> Paolo
> 

Thanks for pulling it Paolo.

