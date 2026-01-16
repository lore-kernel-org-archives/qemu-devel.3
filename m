Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18016D47CAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgXPy-0007Dl-BW; Thu, 15 Jan 2026 19:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgXPk-0007BQ-Qg
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:10:10 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgXPi-0002rR-BV
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:10:08 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c838069e5so859455b6e.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768522204; x=1769127004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZvTYcLaqKlw0wIxtAkLAmLveDy4j95X4eQG9s3hOI4=;
 b=uH9YJ2Z11mQRU2FfGKPsf06hvltORvB8Iv60bBSObT6TQ1xrLUpeBeCsvIS3f9oHte
 nZUtBlNCqXkxWgIIwI1Sz+v4hxcRV+AczLC5iTYuaTFLu+lVSQ2MMVuGL1ZyVui9E1zi
 /Fq+KC0PlMdIBOQndJGzXj3pBnb7PlpSFwyC1wjNrA7q1QZsni9pkA3t6QeV1tfQRC0h
 k39+Rb45kjPNwTqe5qC8MG37NYOqYhqYeTRiXNh7VG99lrwTM7zwd6+YTXcWfcRJKbHw
 HCPcbilNorjb7YxI8JqmlnuRxINJ2bwRn4qO4J24mvs271J5ZuNGQvqoxljPWS9ulkSg
 rrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768522204; x=1769127004;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZvTYcLaqKlw0wIxtAkLAmLveDy4j95X4eQG9s3hOI4=;
 b=QvQCuU4GpQvgbIfVvxrKfw4IsNowlyVHLFMSHkjwDFUHFdCAlhuvxkGsChXR1MYlbl
 15nV8VXa7O3+K7Vb8IxvnIg9ubEwMghjaKC/gCJYM6Bmi+WUE+jCltHgVmJdjoOeGEr7
 NW3msBDRVwGP1XFB4YagGot3CJ6JGSV0X1KpfpZ3suMKNtfGL4bzzElxHtd8TRoTQUCj
 qK035/DmvLQfd5f5wNlLVK8RuEMZDTYwXqxezydGg2atVUqMC0ihEt8fSrK4hXXshgH4
 +4GvistuvJUs3ODDEQlEf6veseUtBIiQ7nUNtM/aMPDZaRvfFFWxjrLYf2tiDGTSoAJN
 30LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJshqvWj4Or0DAeGFLtsSy/ptlLOs0hQ2Ip6s0YpL3if3n0hY+cUyFoWmp0/XilfU1fx6RBtnLW+P@nongnu.org
X-Gm-Message-State: AOJu0Yw8Xc8XK/sQ2nI7vjhMjMTzmE8IoHJyP7rr58VUmlAiWx+DRxSz
 Dx9A+F+QXg8+nbEZXMJWFFzdbWNeKi+3Yi1IiMKvuI6xwt1xRIoe6j+gVVoEn39IzDM=
X-Gm-Gg: AY/fxX4On5iYPFyhmsykSWvnsMw2TYZBeIBPudJZmC8eO54DJ/TA1gwHT35JOq/WjUH
 t66bsXBPhLocYJjW7v/pNgxE4C7eFoLioNPGDdbM1nHVr3ZY/R7LaACcVJmRchn8e7sSNabpoXT
 HPGUaC7E/3WZ3DR+lJYmE/ds6cElYgaLlsCVczqw7HX68gEp3EkQ7Xjftidd/nh4sMUIYBYkVtV
 P5RMtfVjNOQBzE6FX5tVC9F/t67HW7mfUOwIh4VEA4RBYy1Q/iB55aerTKxVUJ8Qm16cFsAcQuW
 vkLgCwurJZq1GU5vztEhRuAMSbTKsngs2plkdWUhAmPgIaK/rqKaMQQozczT9kt3yrujHyYnitZ
 dsDbL8O6pzOXbQaOnQ0f1LmFGA3GQ2CcxLA9IbeDfVIwh3r46WrhjNzD4gd1alTdbitm3kAo5hN
 QNfpAg2kKiDkYAUpNpU29wChaY22RNDh151m1k50E+BabA9U8IsJK/
X-Received: by 2002:a05:6808:1246:b0:450:d143:b79f with SMTP id
 5614622812f47-45c9c1640a1mr584264b6e.66.1768522204220; 
 Thu, 15 Jan 2026 16:10:04 -0800 (PST)
Received: from [10.244.221.227] ([172.59.196.187])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e03dff2sm484256b6e.17.2026.01.15.16.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 16:10:03 -0800 (PST)
Message-ID: <2ebf4582-630c-4f2d-980e-fd5216c4e9c9@linaro.org>
Date: Fri, 16 Jan 2026 11:09:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wasm: Enable 64bit guests on TCI using wasm64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
 <d848e36c-848e-4d3f-9b43-dbd14b1bbee6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d848e36c-848e-4d3f-9b43-dbd14b1bbee6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 1/16/26 08:59, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 13/1/26 14:54, Kohei Tokunaga wrote:
> 
>> Kohei Tokunaga (4):
>>    meson: Add wasm64 support to the --cpu flag
>>    configure: Enable to propagate -sMEMORY64 flag to Emscripten
>>    dockerfiles: Add support for wasm64 to the wasm Dockerfile
>>    .gitlab-ci.d: Add build tests for wasm64
> 
> Out of curiosity, since the series is fully reviewed, who is
> going to merge it, Paolo or Richard?
> 

I've pulled this into my remove-32 branch, which I'll be re-posting soon.  But if someone 
includes it into a PR first, that's fine too.


r~

