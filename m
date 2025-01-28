Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1955C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcltH-00009c-Ne; Tue, 28 Jan 2025 08:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcltF-00008a-7h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:44:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcltD-0004rg-E9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:44:29 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so4687309f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738071865; x=1738676665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JhU9sKV5vCK/pEkpfe4suNGeyv1cZX9+EtPpezhPKYw=;
 b=r6KBz2W/y6T+IqTHnhnEblcEuGlpJHRVYaVoEa42TmakKTPUNuCoXGuyNThleNsAQO
 VAkX9C7BVLm4Ty348XvUSKAILa9TxEA8cZMEvyMQRNsyw2OX6JZXwWaceFxvMUuQLAMO
 0ZCX1hNEcsIdpufUe0nFdkk3r31GvcR2S7e36sezu9XWzXOmbgwPh3X/s9Wn0dPHRqjb
 yoOyJV0e3gW57z9ihZ/tRMwNEM6wQ75fRJuhc09Y0LPreZCLRtG5lxE3lJCKjEmyEES+
 681pshqkzhlEWq0UQDNJTjLfvsTR9tIOstp9pT2qK0dy+uT+p4xrMpOFGmJs1jZhnVfv
 t4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738071865; x=1738676665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhU9sKV5vCK/pEkpfe4suNGeyv1cZX9+EtPpezhPKYw=;
 b=Zbrbz3ZGsVW780lO6re6pRE4Tm8dfiQNrgUydeq++kPi80AEXdswBZyEk5zKUSJOA/
 9IbOpobytxE7CwCMA0Cp4mM++/0J+yKsrRE6IQk0peFZt5Vxj2aksixg6+OyLaDRbd3V
 K2VqoiP6nNoXL6w/w24nF9ZnxPbIgD9tDRQIILYzqL6NwgGZwlwKRPcU/gPm0m+wqKGo
 JuY/g/jA6uZuyOAP7fVwRMTm1vTZ+aO0g2lcVb35TKn0zx74mV0M0+jdg38vR6UMzt1Q
 TTSvZljw5A4YdGiYSHnAE+H50MT43PdoN+F7l8FYc7P9MpSd9k3GnNcqrbBE5TMwRICe
 UGUg==
X-Gm-Message-State: AOJu0YyOMAiMMQfkY1k+C84Gu9NtQd++koc5qvwK88hORva9Tj5WLIwa
 hUF6mkfP3e1Zd3NTn/DqRW/k5yuKa1rh326XLPpG7g1nJDEkmTZwCxLUiV4dAtI=
X-Gm-Gg: ASbGncvknWDHOxllWIGvUvrlaoSa26DOQVyWp2Fxgy8pD0lKyQLI4a++sJv8WsLRC1M
 6fUrN6zfefrZob9NKOpECSVGtpxzI7fTH5qO6DpwNWXPCISaR9ioPVZNsGUloSr35y2bcIc9Ebi
 686eikB0hpr4hF9zVWV5nj2o71tdbA3Gfnu0/LWvv5p2Qa+I7qEXNL7T8Ts5dUcWWDgdtvY3kqT
 hq193d6kSaIN3Xci08d7nKkkLZCq+dUPqH3++1tEc5upaIaeroM5cU50gIafs5R7Vc85Mw/h4XE
 zC/s/p9ZV2N+vN2BU3ZwaqyJT9jgJU22/FviuSW7WMQ6TrhFr28X4Tb8tJk=
X-Google-Smtp-Source: AGHT+IFPCxozFh+u5Cqu6Ee96OWpFbN2YZkQgq70VXj8XW1qSX0aczzwaDIOqueNPPAHQvMOGebhMw==
X-Received: by 2002:a5d:64e9:0:b0:38a:88bc:bae4 with SMTP id
 ffacd0b85a97d-38bf5784ab8mr43608519f8f.18.1738071865501; 
 Tue, 28 Jan 2025 05:44:25 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764c8sm13946595f8f.3.2025.01.28.05.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 05:44:24 -0800 (PST)
Message-ID: <7c8fc594-5850-4398-8030-1637a7f630f5@linaro.org>
Date: Tue, 28 Jan 2025 14:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] target/ppc: Move TCG specific exception handlers
 to tcg-excp_helper.c
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-5-philmd@linaro.org>
 <758609bc-c399-4de9-94eb-e0b3215e1df9@linux.ibm.com>
 <c2a910a3-ba4c-f396-ddf4-c1cc9d502fc2@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c2a910a3-ba4c-f396-ddf4-c1cc9d502fc2@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/1/25 13:41, BALATON Zoltan wrote:
> On Tue, 28 Jan 2025, Harsh Prateek Bora wrote:
>> On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
>>> Move the TCGCPUOps handlers to a new unit: tcg-excp_helper.c,
>>> only built when TCG is selected.
>>>
>>
>> Nice.
>> Just a thought - will the filename look better as excp_helper-tcg.c ?
>> That naming usually help developers when using tab completion.
> 
> Or maybe stick to either _ or - in the filename and not mix both in one 
> name? If you want to use -tcg or tcg- then also rename to excp-helper. 
> We already have a mix of _ and - names but at least try to be consistent 
> within one name.

Other targets use a sub-directory:

$ ls -1d target/*/tcg
target/arm/tcg
target/i386/tcg
target/loongarch/tcg
target/mips/tcg
target/riscv/tcg
target/s390x/tcg

I'm not interested in particular with this target and ready to work a
lot on it, this is why I went with a surgical approach.

> 
> Regards,
> BALATON Zoltan


