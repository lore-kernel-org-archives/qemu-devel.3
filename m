Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088CDC54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 16:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIs3B-0002un-EO; Sat, 24 May 2025 12:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIs38-0002uZ-G5
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:48:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIs36-0003VR-QR
 for qemu-devel@nongnu.org; Sat, 24 May 2025 12:48:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442ea341570so5446105e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748105319; x=1748710119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TUUPUwcRCfgIknEVmNOCMzJ3hvMRXrOqsw1xUPQIDdU=;
 b=txRoP3z7v8zEY4sWFoXLxTYQ8PPcLwEsqdfpxTzOo8utp5deEvddq5giM50hKf/uoM
 okRsoBQ1fkNPvvxxl2CicQwWPp49F0YpJ4F6LRMlxxszrK0VcoFzHhQdbn/4rFs0apJb
 orABfvX6Yiq3QDPu0EZCndkJRmEU1WWX+gqpi3E3XLOtJq2bUndkX+cFWzVcgYmXQAtl
 WZ22h5TNtKnP0W63ogecH/fjVLY2qEQIjhoSFppxXiQWbBkJH77k+aJR/cSacve4hfcC
 NMhUYxx+uDXLUjApjfNv9DQMGPOtQRIqX3RlKhCsbpsbb+nwF5s7h0nFr+JZBM7DiVkx
 b0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748105319; x=1748710119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUUPUwcRCfgIknEVmNOCMzJ3hvMRXrOqsw1xUPQIDdU=;
 b=W6T9LqbiD4VxuMI9T62LfxK8tf02xX4EfkNn4m2JRAnubbDuMuj/qC3T3zF6gPWEf1
 6W2uOO7q+MXWpDKIgrOPt8zCzqxwB4C5yqpizzLU4CNryef65jXI24JvaTJJKDV5meji
 CA4+ChqUce4GVr4lR6AHE/9nFgwMCRxGHmr4oANCTfaEJ4g4Putzi35APDvqG6cPucIg
 XFXrFxcL5WzbIolU6J4r+/yxQPTdWraSHY/AyNgL7scqeRAXmip9dix7FloU3gXlasrS
 RepjYH+BhdNH9lD2H6F6TXvB0p5JsjBpCMy7DbOk/N8mwTr/T5Ows/jBpXfXqyYHoxL2
 Q9JQ==
X-Gm-Message-State: AOJu0YyHZ6KaplBpKGkNWNR/ulmB5vugCO1M/3URBlqKIlC1Iifk5lof
 AN61m0ebe0qVepq64N4YCz8e3M4Sjq/eJ2i6pIl801nnCk/u/mIdIihIMlEG0KfV3uk3A9yi25M
 DipPpmsCVSQ==
X-Gm-Gg: ASbGnctTy0W7QovBo518/28KIQpPxJOCwrsIcec/JJdu/2z1ZQDPr4ROegz4QTIA2dT
 85hRPn7B2h92vQUWYX5+Z+y0+dccGyH0OGxT/HFtmniFMQ1yPHHT95BwqhdYPqGkf1H3uBA4YZj
 Evzz8TlrTftY7qEZxzD9nTFe7d0P1TQyGarclUC/lDjLUqfDTutZmLJTkMMbqEdx+XHAfW0SO/O
 FlFZs8tvRbXMlyK82ItjORX/X7f8Q/nt047X3fjc5yfw9tHmwQYbftevVsa8jNc9QsGF8yY4KEC
 +JwbDdJBnASKvOUYBF/ldwmlnKeSQ7Ey8OM3HylaO6PjJMNt5TxNTbcElK310egPhA==
X-Google-Smtp-Source: AGHT+IFbz3CNpYMgqJ8KDuvNw15sH9RsF1MRtrCw1nvPCccSMflhTAf2kkcsihapbXzREwrHNpJZ+w==
X-Received: by 2002:a05:600c:5126:b0:43d:a90:9f1 with SMTP id
 5b1f17b1804b1-44c93016686mr29212855e9.6.1748105319135; 
 Sat, 24 May 2025 09:48:39 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7d9bde0sm181635995e9.40.2025.05.24.09.48.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 09:48:38 -0700 (PDT)
Message-ID: <66730f94-559c-44a7-8cb3-a7bc3759e28f@linaro.org>
Date: Sat, 24 May 2025 17:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/25] plugins: add API for registering discontinuity
 callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <3b5ee8f787cf2ebf17962b172eaf2bd46343235f.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3b5ee8f787cf2ebf17962b172eaf2bd46343235f.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition to
> those events, we recently defined discontinuity events, which include
> traps.
> 
> This change introduces a function to register callbacks for these
> events. We define one distinct plugin event type for each type of
> discontinuity, granting fine control to plugins in term of which events
> they receive.
> 
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   include/qemu/plugin-event.h |  3 +++
>   include/qemu/qemu-plugin.h  | 16 ++++++++++++++++
>   plugins/core.c              | 15 +++++++++++++++
>   3 files changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

