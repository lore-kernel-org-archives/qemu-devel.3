Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10617CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utO4k-000323-EI; Tue, 02 Sep 2025 06:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utO4f-0002zd-LK
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:17:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utO4c-0007aQ-N8
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:17:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45b79ec2fbeso34990645e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808227; x=1757413027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rly+1aW0RM04C1ueHyEUX9nrFXkquj1rDqnBJ6wqqvo=;
 b=Zb+TDB0BYMjWnoIECheYyvsuzXBQVo8mNK8Ve5pNyDqlhcFFhxd/64oKqDvZ9tlOtz
 lDNh0U5TapmzHOKF82z7I+zzbVnhU8hzAFZ31VQFUlB2xGgiGTQPbOHGmC42AcqLutes
 gXeYFZhATRHIKGlfTSMlZ0u/PLusTeWcGgL8vylzHQfsPycKZ6xrImbZGqIScJ8imISN
 lVFzr8BXfjckIO8PB2m/SvMI3f2oGTzYMKv3ZOyBuw+SVGuGHgePfXsmwBwJDlm5iSGR
 ZCsJYA5fuHKEqUvm5kngHs7vpTYbJLKHrZAOo2FtLsALpeMHN2ObR03en2ewype7SYAg
 Mibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808227; x=1757413027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rly+1aW0RM04C1ueHyEUX9nrFXkquj1rDqnBJ6wqqvo=;
 b=Vrl5vMLHmJLn+4BCbZOeKZ2gFjPkX9NnkKHrOmSwMiSePa8+CzTf+IinXml+JSlStQ
 fctMFuvcxxnhSkCUULJwJcKG/h3FOcvRR6bIMwVGDbQlrFyJBX5wdFxKBYA2TZ7c4kOh
 Cw8rzAxYceIJMehMmZu1v9SN3S0i/30EOCQnGXG/oLWeeVr1gFSHzHlI5MV9QsnA+cBw
 MWFYAneF/71JJ/Iat4/9w2bhkjv9KpLWvn9a5T13nwsxfaUx1PmwTuYDTkBa0Y7jx/XX
 /rM19XiyPhMYBPMWdjn6eGEZTFepuQfFH8rQnfxvvdyFq4aNiimiBISGhputDenJYeRG
 ZQ3A==
X-Gm-Message-State: AOJu0YxH1HIiK/X9VG0WCAQkZZim7BmGxAzrg6IWSpcPoqgqs/kGtlCN
 FbgQhssKOQpg1lU7JyRs6yeOchEtSs6nyeLBxFqgUsUymoFvK+RCi74W13qdDQkcQBQ5bZMzdh2
 616i4
X-Gm-Gg: ASbGncv0FmbbffaE7c9VvVCQ9DCTxiANsNrXRv5YWKPRpiJDUBw9oIFBeSRPke9UKKW
 Q/UTEfaCYbBeMETdyxn4f63XGCOk0Hqg0GAwmZJE2hgqNb6nTIN8fbhzJ8lMs7yUwPx8zCLXEq1
 bvMEHI72w5RVMOBkPwxijySlABCNGaHosoTJcrzOBT2dH+SnuTO4MT8fod9i88t2P9MUAPIUdKS
 fBfq8AA3bitUx/YeymXqcK1qvBExiiBQ/37wepAmtQSrwMRZlwmDjvgWc5IMkRNYXlwTIl3yY5f
 tWxQkCTmwPGkO2/h/eC+iuAUXv+o0crqJ/oNoq3nFLMD6h0iG5DtxKN6/9l2Q5EA7H7OAxbv7FZ
 sMgoFyhxelpSPFZQbrg/8LJY9mtewcsqMbOaqrTdNfi/tCqYIfKt0FdOxonYjOXjPhg==
X-Google-Smtp-Source: AGHT+IG1SDxYeJTEFH/Uf3DiNgiTUn5lT8oKqC2DBWuRYMa6RC1Uot1Uv82h4RbRq0osnGIylno0WQ==
X-Received: by 2002:a5d:5849:0:b0:3cb:3ca5:8717 with SMTP id
 ffacd0b85a97d-3d1de4b5ae8mr9336141f8f.23.1756808227560; 
 Tue, 02 Sep 2025 03:17:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d15f7b012csm15900909f8f.63.2025.09.02.03.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:17:06 -0700 (PDT)
Message-ID: <bcfea710-57d7-4588-a96c-a8f27bb4ddfc@linaro.org>
Date: Tue, 2 Sep 2025 12:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] system: Forbid alloca()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, kvm@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250901132626.28639-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901132626.28639-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 1/9/25 15:26, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    target/ppc/kvm: Avoid using alloca()

>    docs/devel/style: Mention alloca() family API is forbidden

Patches 1 & 3 queued, thanks.

