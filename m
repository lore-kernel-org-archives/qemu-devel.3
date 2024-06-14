Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF40C27C7B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 04:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHyAl-0000px-Jg; Fri, 14 Jun 2024 00:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHyAg-0000mN-4R
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 00:04:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHyAe-0005L8-Go
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 00:04:13 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso1415661b3a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718337851; x=1718942651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nCdeKEu4ZxIEPzH6/UOhej3HkL5Q6WpuA4Qml5CZg8=;
 b=ng4E/PIq5UZth7kISUwCbFPqPXYKai/+XV8Zio5XUKRb7Yz6o1Fmo6b75jA7uRU6n+
 5KgYp3/Uq2B328xCSiNBQclk7o58+MPhNjalXALGdX83wUDt0wh0i0gGOo0XFyJvdhtc
 PMGzO74lguO2jU4vVv7gcPhrCvHYz12hDnt8/aInAxFH6p02qOgdflXkasmLKW1ILmuX
 9mBqqwCHEtO8EHoHx6u9IEld9W7/sX392UgGq+eXYS/qNx06notF4jJkuA9QfsY2cn06
 NhxGBvSdI68AUkZEvuECYGpUteoh91Z2VnTJ9lJK7o5geuUhSAjxJD7mjzRQTDI3wtQl
 7gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718337851; x=1718942651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nCdeKEu4ZxIEPzH6/UOhej3HkL5Q6WpuA4Qml5CZg8=;
 b=P8mxFg4F5wW4p/9QA9RajTuCP+6G2H5X2nzvmGxgqbg8HEgtnx6X9//+QmUcw6u5pp
 jExpwKaPvSK+wXF//6s5Wr6HMoTE4UrEjqtijBM+eqVrVJ/ljbkJ1WMTI4YcqRaCH3Ir
 CxbS/SOX4lB3wYv+Gy/shWh/mcHFc0Wv0q3/ddT0K+J9rTMsQTCOhM7jgpuVez7I2skQ
 /wh++mqRV95OhA/4xGIe7HAkWmfv4OnvK0JlQafGRGutg2NP3ai2Rsg7kBAXEAM2VA5B
 e5q7CamlZIbuROqcWgrhgtUtsf8XzDA0d2KJnybOSFA+psM70w9dZmwRDq+Haw7Hzl61
 qbaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr3fRzbVB9nw8n8jjh1OWQsEpWMzTVZLczqCJmP6z19+F+Klmu5mNShG/xCdNIaK9oZ6a+b+zpkCsY0SKRZSbXmyVfK7Q=
X-Gm-Message-State: AOJu0YxQUHyfTXMFaWDxZxOG76vjGp8DAHeQfaS6YmbVDIRCxWDj+slc
 A4nRMY4PWPAzCFC6j7FSbSWREMf3MwVpyyP0QO1MMWW7c0SyXTQMpRE2NxO+qos=
X-Google-Smtp-Source: AGHT+IGDgdi73841X+6Nv8FPqSpOz4djvg8pEuxLLk8BY8BHowUqhjqW8Ylwr2OKpmY8qsXZvFY/Pg==
X-Received: by 2002:aa7:9a5a:0:b0:704:151d:dcd4 with SMTP id
 d2e1a72fcca58-705d71d0c25mr1845294b3a.28.1718337850701; 
 Thu, 13 Jun 2024 21:04:10 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ee0:d48d:29a6:b8ab:ce2d:2641?
 ([2607:fb91:1ee0:d48d:29a6:b8ab:ce2d:2641])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc9696b5sm2118438b3a.66.2024.06.13.21.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 21:04:10 -0700 (PDT)
Message-ID: <e3ab44a4-d5cb-421d-9530-69bf376a928d@linaro.org>
Date: Thu, 13 Jun 2024 21:04:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] virtio-grants-v8-tag
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Cc: peter.maydell@linaro.org, Edgar.Iglesias@amd.com
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/12/24 14:29, Stefano Stabellini wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'virtio-grants-v8-tag' into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/sstabellini/qemu.git  
> 
> for you to fetch changes up to 6d87a2a311fe4a8363143e6914d000697ea0cd83:
> 
>    hw/arm: xen: Enable use of grant mappings (2024-06-09 20:16:14 +0200)

gpg: Signature made Wed 12 Jun 2024 02:25:34 PM PDT
gpg:                using RSA key D04E33ABA51F67BA07D30AEA894F8F4870E1AE90
gpg: Good signature from "Stefano Stabellini <sstabellini@kernel.org>" [expired]
gpg:                 aka "Stefano Stabellini <stefano.stabellini@eu.citrix.com>" [expired]
gpg: Note: This key has expired!


Have you posted a refreshed key?
The latest I can find is from 2023-10-19.


r~



