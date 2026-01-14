Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09846D38FE4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg3ce-0004Vz-3M; Wed, 14 Jan 2026 11:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3cb-0004VC-Ue
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:21:25 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3ca-0002DZ-Ev
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:21:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so60165e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768407682; x=1769012482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sXOCjVQvWKTby5rxVEA5VahbwUifLcpXBwJaBo5DfG8=;
 b=Rcjf4id4QNB4UvTS5qYBC/vcu9iAkyTuAafYPGiUIpQCIVajs6WoZOYtkOBlqu2wSF
 jNnvQEpaiZrn2iWJbcoE7uOXncUR0WJ5JMmJ/qM28LuJygfpodVr503/MuWPEXoZHcq7
 dwRnCIZcfctAfoHSgdOuxVxaZygES4FqRDNIuY4kRL9c82o+v3FatdDxs4VWZ3xrrp+j
 duA+WNWu1efvPnaCsqsiBJNFTl12/zjvYKFgl1yFl5jEoMhrHJVIRjo8uSjgeFpGGbyr
 2iL7k0Mk1XG4YspUaUjjrYtPEnedG1edc9QOGOY7iO7Pniv6ES3sfFKEAOB0UTRoO2LF
 YGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768407682; x=1769012482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sXOCjVQvWKTby5rxVEA5VahbwUifLcpXBwJaBo5DfG8=;
 b=tLtwtuF3v7wQeqsJWVfnEkrcvQ6Cfo7v51x8z7tokH3zSi2sO+u25650A3+ltWtN4v
 LqHEmCGo6XWQRzkaQHc3LmYjSjmpCzIYzpiC2m8LHa0KaSYVTaXf5h0E83yTle5VssDH
 R1K19JniY6Q4VyuIvsMtJquJQd2oDenZS/t8h4lXRPwu0C5zsLnESTDxsbNCTI1y6DTM
 wRFYW/P/ziYMSTior86pWj+k8KNZID/PiBWsVR6zHLKY2UEBfOTRBFoM9riszOxSa0qQ
 5mH6Q+yJ8xowfMU2bnOT/0j8HL0Oa48nrFaCzAfMlvpKbQb+EAJc9aagRTxp8CBS9eCQ
 X+Pg==
X-Gm-Message-State: AOJu0YxjCRaC+/FnNtzNKm45rKdru145jPle3k1Ez8tCB6vEkH9LrIE0
 8CiScxNFZH3xvmj/QUOIImgY2uYoSGQ/PvZodPnGEBUyWaTG/a5XKdSEsTZyYGWqCp18vo2sM71
 SAp0H7/Y=
X-Gm-Gg: AY/fxX6sv6GXdOyFyoJMaem5ydHGjbvQN/kedCdfkL13rAUs+fms3aUqh4MKZ61twaU
 BqCy4Uwg9TOGMMMQAfUax4znxqsG84U3xgkG64MHCRzQQHLOhM6ZlAqyawjEsUAJOOIV9uyYD7t
 EwGWFl/A4IEHFKVksXTUkBN5aFqrL8o+uSvb90iXpJYRrkv6hYtul+e1guOsvoXC8W5qJMv4bye
 q+wA84NtPeSKXsRobG/sWXxzY3JurXIx7yaxl6Wh0rRFatNRlCoDNcS/SUGX5qb8ieGLYv7Hrni
 YQ496mOckYu7Sz2bE1ccHC4Kl9LvRe3Kw1lxp5otJtr8pK/XqO7NBV0c4r751J9l9F67Lok9xJ/
 VJUQaK4XY81MAh801m/NPi9AXWOUv2W0geXYRJMz5M8f8LcUhG9LS6gR8JNr4oMxZXhPkeGEQSB
 KNd1mW4DBNSdqHsrQtCsJtWTKahqA+tL3Doa8w2C2Iml2PBVf1nSfhuA==
X-Received: by 2002:a05:600c:4e46:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-47ee32fceffmr31422735e9.10.1768407682283; 
 Wed, 14 Jan 2026 08:21:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee591933bsm35046785e9.15.2026.01.14.08.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 08:21:21 -0800 (PST)
Message-ID: <13ed87c8-da97-430b-b1db-2bf0024cc4f3@linaro.org>
Date: Wed, 14 Jan 2026 17:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/qtest/migration: Update framework to allow
 using HVF accelerator
Content-Language: en-US
To: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20250128135429.8500-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
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

Cc'ing Peter and Alex who asked how HVF is tested.

On 28/1/25 14:54, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series modify few bits of the migration QTest framework
> to allow running the tests using the HVF framework (also
> leaving the possibilty for other ones, removing the KVM/TCG
> restriction).
> 
> Philippe Mathieu-Daudé (7):
>    migration/dirtyrate: Do not unlock cpu_list lock twice
>    tests/qtest/migration: Make 'has_dirty_ring' generic
>    tests/qtest/migration: Initialize MigrationTestEnv::arch early
>    tests/qtest/migration: Pass accelerator arguments as machine option
>    tests/qtest/migration: Add MigrationTestEnv::has_hvf field
>    tests/qtest/migration: Run aarch64/HVF tests using GICv2
>    tests/qtest/migration: Allow using accelerators different of TCG / KVM

