Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5CAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMuO-0006uB-V1; Mon, 29 Jul 2024 05:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMuN-0006tA-Cf
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:43:11 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMuL-0003xD-OI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:43:11 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f136e23229so12939961fa.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722246188; x=1722850988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9no4KWut5H4NSOgf4228amWo7spe+7p8DlDw8huReg=;
 b=sgKaI3PiTGSZ6gN5G6C87HG17CzuGvsYEVbu7ke/g2FZWjaqiHPIP0nwRdIC+DTXxz
 7rjip7C8UkXXOBKTmevUIkztGEKs/kzSp/kb9Q6CBnGzGcrQGHm/8rZ2x1zWJK6p2qPZ
 EX72snr0BbtQsbAsnAAFijZ3nJ51stVDrvOnBT/qwgUx6MB6qERRjmt5ETvY58gDpEgV
 Ye05jF/GQ3228pjQSxyQcy2EURDzPcU+gZMSKVLCY6It/9n6JnICqkEkZompvuPlN2wB
 F/iNeiKaBX8ExMS1KRFhRLJ+zoXnmwJhNV5extZFNilz+RYIGKX3BLZY//ATfceiRGrp
 0cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722246188; x=1722850988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9no4KWut5H4NSOgf4228amWo7spe+7p8DlDw8huReg=;
 b=fSC9oLA4sL1ejSum7xyEQhuETqY8UmoQO+ccmcLWYSYUqtdCGg19t9iJUbLFVuQQpX
 CwCxuaXxLHgM8eHqsPZO8Z3xC95rDpSt0envv2Jo7KGGZjpn4IGtudi6txLaYl9R87rX
 1UYSZAGabujcuFQ0AsDD0dZmiEUfd/VvRdN2+WCR2mpbH2VesNj1gw/uxDZvT0L3w65T
 7yW7h6NfJ1K9Yp2QzY3heo/G4nmFNL9wDOrvpSAQF0WIeQRmucQzpws9+g5N7gYrtEPD
 zZ5pOe/qHrXyvczgT/sVD8DC5nKlExuKxZXSiuFiKFDXQMKbMlOwa9ENKyifkndbiCaW
 QmAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGz0O2rA4RkPY0Rhu9EZSeU1WvJgnLQ6MuOKqDxPZu4eNpGQ91f5xppQAXeZixGpweM7vca0NGKmTlthJNeRiPI7qB5RY=
X-Gm-Message-State: AOJu0YyAHfiuuNHmV3sdbmnFhY8pA9fmR++EJQ5tzWSeE7AwFLGuJ4YI
 ug4RhdmBmWNMnbNUgeg7vCG0uFTSDmtK3uSkavrHIL1mqRhdqfeycrLBjMqeD2AhdhHSOQrAYCM
 R
X-Google-Smtp-Source: AGHT+IGMP1/TdbHW4qOVaMliaaoXF6M+PsudwPSiqbBJMofBVz+CiRmw7FIFAxSjq+IJyCWewWcpFw==
X-Received: by 2002:a2e:9845:0:b0:2ef:2006:bfb1 with SMTP id
 38308e7fff4ca-2f12ee06661mr49047001fa.15.1722246187485; 
 Mon, 29 Jul 2024 02:43:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573f935sm173423765e9.14.2024.07.29.02.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 02:43:07 -0700 (PDT)
Message-ID: <5d5a2fea-3402-4e9d-ba05-3caede577d30@linaro.org>
Date: Mon, 29 Jul 2024 11:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/96] ppc-for-9.1-2 queue
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20240725235410.451624-1-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

Hi Nick,

On 26/7/24 01:52, Nicholas Piggin wrote:
> Apologies this is so late after soft-freeze, apologies. I was waiting
> on "accel/kvm: Extract common KVM vCPU {creation,parking} code" to be
> merged upstream [...]

When we have dependencies like that we can ping the maintainer or
ask if he/she is OK with blocking patches being merged via another
tree with their Ack-by. Sometimes their original PR might be split
in smaller parts to help us merge our.

Regards,

Phil.

