Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1468D1951A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkUpT-0008WQ-R3; Mon, 26 Jan 2026 17:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkUpR-0008V0-EC
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:13:01 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkUpP-0001pi-OA
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:13:01 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so3204347a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769465578; x=1770070378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlJzGuUV2lxQ4/hzAK1kRSAbc6/+qB97mQaJNBoSymI=;
 b=hWmE5lr0UltAuC1DXEJLK01MoBYvmjHnYt9GxEipuWfhfAggsyhPUzlu1XT58bgdU5
 xLMBpm64+LoS+GSbw5vLdik5LKZNTeG8c++cfWflmWQAv4mt6Ny/nbzJr4hyGn53sgRK
 nyuMvk9uIYPOV6gUtdTY4FukX0X0IkOum1Xlk/5LNlK3OaUlyyn2vj0XMRl82Z9t7DTR
 YTE1VUowR+h1xcd5lMpOD8lQvL2UI/x56UzkwhRRPcaFBrSbBOqzsLKCHqpn6qTCwBBh
 /JhQPTLElStBCSyjRpHVFyGldjCaANO5OlDG+rE4E4WGuVtcWGuU3X6j0taIRUGNTu3d
 2spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769465578; x=1770070378;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wlJzGuUV2lxQ4/hzAK1kRSAbc6/+qB97mQaJNBoSymI=;
 b=agvHscKufhRiBN7H/x0dMp4V5HMaIb3hb3kLDamgi25taq+hHPZjqfQJdwi9dTnxOf
 fJEYhyekn5b0INBq+pDEWBc/RB4QZ2AipnLLyglEJZO+JmfYXyip7MrlYygQPLGoX7WE
 g4bfCrnojVXDhqjHs3QI48Q1i492VvjSyPdI6W6allggHJLmK4Rb1HYKMBtx6taWxzWz
 Ta9uPeNm4Ef6U88RAoGQiHhAZ9gaSaW58z1ghjVNSAB8dSM8fHEm7K1qv6W1upMIPYGm
 LRQZdRAtTaRem6XY+E0xUYSDQbd4WQV13Qj2h9k3vPB5+fVViyeysgNKITT+asL2mUgN
 av7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv673wCykxhIowQJUyS7VDXq6W4VeKLFC5kZpLBg8E/leeM7vAQgIPwv/GVbwNUY/novVlZJ3MFFM0@nongnu.org
X-Gm-Message-State: AOJu0YyZJlos9PxIt/evQCU9EdkB/dSVneFlkYfdkAEUnpilTSXwwNT1
 MDgTYwKeOH5VybcuSg4ZmtKo1n52HAz7lRUXMj6yikCW5ofdzr4eBGoL6eXR+a8Cuj0=
X-Gm-Gg: AZuq6aK+lNS5PNS481aHOuQ66IMfICUbb54kVvZxqEQ7PEoxEHPpU4NGdU/gpdVSQix
 Oq3yR9lpnmuPNzjcG4iqlijyF4pxSQCtCcWLXMVE1tb4T9a5RgGDD5RRJ/yp1pmOVUWlDHPKCSP
 aAEa48CCU9jw8EXnH5s6mvT6l3gvCUoTNP1cNLVd+Uu6B7s1kOIUX+IeY7f3zBPz+BvFMBUORwF
 yvYoY9HeXLBOnLB/x8x8ciu2vC+ZGYIF1z9yBCKmU9Fi6qqE8cYKNy6hwYSIT6zORdyI0OsuzCC
 ET/YTmp7s4LdO3fUfGl54pYK+zNiX5YyEJbNl81GKyI4V0J1/vyMek34DtvL1QQ6Zx1n0goqjBD
 SKmmGz8xc5s8HYksjmJHWwAIh2AXv9WpokB5Rbu5Pek5fD7lXFxF1Rpy3oNef3Wx6kqc6lvaCg4
 5nl5O4dSPiiu2hBIbp0LsZS3L5P71aqZNcYDNnc7lReDI3uUP3CaJRGEmp
X-Received: by 2002:a17:90b:2c86:b0:353:3934:1449 with SMTP id
 98e67ed59e1d1-353c40ded88mr5696200a91.12.1769465577847; 
 Mon, 26 Jan 2026 14:12:57 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3536b050e08sm3795873a91.1.2026.01.26.14.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 14:12:57 -0800 (PST)
Message-ID: <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
Date: Mon, 26 Jan 2026 14:12:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitlab docker registries
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/26/26 2:05 PM, Stefan Hajnoczi wrote:
> On Mon, Jan 26, 2026 at 4:55 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Hiya,
>>
>> I noticed this today, wondering why the daily scheduled builds are failing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/12868286187
>>
>> time="2026-01-26T17:34:06Z" level=fatal msg="Error parsing image name
>> \"docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross\": reading manifest
>> latest in registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross: manifest unknown"
>> make: *** [tests/docker/Makefile.include:54: docker-verify-emsdk-wasm-cross] Error 2
>>
>> I'm not really sure what the error message means. Do we need to push a built version of
>> emsdk-wasm-cross to gitlab, so that a manifest is present? Which doesn't make much sense,
>> since the job is all about a weekly rebuild of the containers.
>
> I don't see that container image in the registry:
> https://gitlab.com/qemu-project/qemu/container_registry?orderBy=UPDATED&sort=desc&search[]=wasm
> 
> Only the emsdk-wasm32-cross and emsdk-wasm64-cross images are there.
> 
> Stefan
> 

I don't see where the job that is supposed to build containers weekly is 
building them, it is just calling skopeo inspect (???).

It should depend on building and pushing associated image.

https://gitlab.com/qemu-project/qemu/-/commit/8bec7b9874235e60f14172618121c60fdbd39302

