Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97ABC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM13N-00061l-FL; Tue, 25 Jun 2024 03:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM13L-00061I-P2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:57:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM13J-0007ru-Si
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:57:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4217d451f69so44767655e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719302239; x=1719907039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBCJjW5vif2LHelkGvlFGYgM3YeiN3kgyhPutsaEpy8=;
 b=u0lwQVWAAypNNFyuYRrNnC1lE1Op8ZQJrXlbUyFUbl0feK2BYxeZ5EAtJ3A8NpAJEh
 uJNB+rCYejnwpc8DzhGtabx23R/eUm04zQbiDFOmGVUX49F3NJ9L2WWgf5Yg8ZCBdSHP
 TaU43vvON5x4Kx6aidYNQnuYBVvVvIcCr5koCkKzTAL7L+tnIShQMNq5VUSfpnmPIqc+
 hs5aCbZHvBHeqIH6BQj7t/X594+Wkm1AtWAifVCC5pygEy8gzdmrHT70mKHbfnSVdF/S
 0YKAFly+7vgx0FZ2/4SA+kg1BXPhsqEyJYl78w0rDcYou/EYqVaiovyNyXSRGG1GN7td
 YWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719302239; x=1719907039;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WBCJjW5vif2LHelkGvlFGYgM3YeiN3kgyhPutsaEpy8=;
 b=rRZ9wOw01SyMi6ndVUfWqHa2qEgbY13aS7sYL8iOS4woRW5/k6p+K35CQolOvH803x
 A3S11j41I5AwkF8KUATvpb5Un8CvYt3CcUIGPfd3EJ8e8cf8LvEz69IzLahfu4QqEoq8
 1t5v3mRzByfw8lZqMLrB71ANnKjxsEZr7Q78z9j/GaX775WyAEBu0VGcOSLCOqCs+jmD
 3QSjS7NChfQ1AjvBRi7Ch+4LaPgaNK9sZY3YHVYVSOcz5+O6EaWz8IdkuqumeEtbh4uW
 aLUnJmyJN3NETEs2ZZYR9rMHh5UC4YqetMNORwn1KzR8sJt5ZO8r7fdcj7o7Snlyj49M
 nXyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7p3IryU/JRsr+N1w8vUiVYNljgE/u0VcbNvpCdk4Ro/g+/uf6xNjT5e3giYM74jXe1oBiGJ6dGfdMMnpKCobAtCgRWFM=
X-Gm-Message-State: AOJu0YyuWFhbCQNXPyHqB8gRgui//os4AiSXZzXYwZ0Uo4dCIII1sDRm
 Y9CERjaabLweEP05Y3JsGK2gnHO8rGNUVpW9CVUacFwOyVQr4wxKSHT0pwK6NzU=
X-Google-Smtp-Source: AGHT+IFAE75zsstpfd9ckvqfICq43v7lBMKc1+H0vfw230z0x2AHHOswqQGvim235QLd0LyekU5LPQ==
X-Received: by 2002:a05:600c:4711:b0:422:5d3d:34cd with SMTP id
 5b1f17b1804b1-4248cc2a7a6mr46055725e9.16.1719302238722; 
 Tue, 25 Jun 2024 00:57:18 -0700 (PDT)
Received: from [192.168.69.100] (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d212254sm201106575e9.45.2024.06.25.00.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 00:57:18 -0700 (PDT)
Message-ID: <40e4c21a-1f64-445e-a385-a9f4ccec0b0d@linaro.org>
Date: Tue, 25 Jun 2024 09:57:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help improve 32-bit testing
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org>
Content-Language: en-US
Cc: Dov Murik <dovmurik@linux.ibm.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ab8beba8-658a-4359-bfb1-672e5782633d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Richard,

On 25/6/24 01:33, Richard Henderson wrote:
> Hiya,
> 
> I've just discovered a 32-bit build issue that is probably 3 weeks old.

How and what did you notice?

> While we still support 32-bit builds at all, I would request that we 
> improve our cross-i686 testing.  For instance: we have cross-i686-user 
> and cross-i686-tci.  There is some system build testing in the tci job, 
> but (rightfully) not everything.
> 
> I would like a full cross-i686-system target that builds all targets, 
> and I would like the debian-i686-cross image on which we base these to 
> be more complete -- ideally, exactly matching x86_64.  In particular, 
> CONFIG_SEV is not detected within the current docker image, which is 
> where the current build error is located.

Orthogonally to whether we should improve x86 testing on 32-bit
hosts, IIRC this isn't the first time we have an issue with SEV
(or more generically Confidential Computing) on 32-bit host, so
I wonder if this is a feature worth testing & supporting there
(thus Cc'ing more maintainers).

Regards,

Phil.

