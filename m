Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2451D38FE9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg3nQ-00036e-IB; Wed, 14 Jan 2026 11:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3nP-00036S-FD
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:32:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3nN-000656-G0
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:32:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so70375e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768408352; x=1769013152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o3nxwlxG0dBms6iykwpGPvH5Cf5H/IzmiicZUf7qhYc=;
 b=jS+ktqIzVrfduC5+nFhYTyKUEOYhOYJ1RAmIRhznUUZb5IfIaOsWX/cMMSD+rTz1YO
 30C7YzuVVdDta7+bqlCnlHOaCDT8NWnRJl1PAW51vUAECyLnDEspQn/mO6FgVmarJ+eo
 c3rkAv+uULB8l1xy992vVnRN4Ks0SHzrTDU55XKLjfVcoZKr45845+0VDfsv9toNSFAy
 D+YSY03zHc39CN/Ngp17oEbT6Q3C3dDpz+usw3H4N8ozZPXDAsUm7m2+2WmceEPXTEU2
 gIpqiiJEjtDYHsJfxY5TODcEWAM5WAjLU0FyzuHrXFjIPs0zDSKAcCFv+LJKOCK2ordJ
 FKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768408352; x=1769013152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3nxwlxG0dBms6iykwpGPvH5Cf5H/IzmiicZUf7qhYc=;
 b=mSEPRyI8+cPW5zjaMILQvHL5bF86/T0wG9hTFyevIdyDBh+e20qTwTXFdbeKQ9IiJj
 szgTRLwJGfQ2bO9ZLfw3eV95N99CBvaAEnoNgzXTiSRKWTvcN8xZ+T3liF2vicKhsqrX
 0AIrlxglHucerLZyG5hEaH8nJfP8uW2iDniKl8MCgtcnEGZVTdIMs7g4xc5l5vacE56P
 xb0us9NAoV3VsaE2QtBD70rBD5IkY7fgCeggP8/8A6XRJk4PfIu8WAC7ZzF5wah8rJzX
 /xorQmuMR1+ZLJ8CtxBQQ4167q35+SbnSeMqqxiJsXVvnt0ml9OSMpjiQ1aXq5qo3LNx
 9DWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBR7FaMaj5aEekvscSsEJeG8CbYN+W4BE7PY7dFQ5EW6C3wDDnJ82NeIBg1szsJevlnFU/SAqX17zo@nongnu.org
X-Gm-Message-State: AOJu0YyJqKLHUdgP3CmpovhoEuzeYix9yukoMF6Mx8F8xUJKXeiZwbWc
 t8lYyarxjOPclKHtF2gs1dLeoe4RrrZ6FDT1qYpFRIRBTbpN+2vy1h92HlrpdxKq2OU=
X-Gm-Gg: AY/fxX6Q/zWZVClm68mc6xnEOQDZCpGiT6Lpc8rCprnKG32O+e7ZNZAKJOupYDRTTB5
 qbOsAL+3L6TTteO+qp75wZDvH2IF2kPeOlOUURia8utQiERJSZSgojt+mAJzi1CwLlYR1Qekh6O
 +OsB7hjxofEPaqU6pGP/QH9appAXRLmR0qPHRYu5mbMhwdi9yKMBaUS1kRD/R9NrbAi3yWBlLVs
 aJhba1gQfe7HYOM6/negMExFxMQug7a+gFrKrWR8PH8TWzTYbRlHnCXuVVZc8aSqVln0VH2yf9L
 dBW9bHB1kriXEgT+djQXkBvdxvJ41hYyGpJOmRNf+E3JBdzcXf09QsaMULoCiZNn0XnPuiXkzLl
 Xl1ys3XUJWjqkzlqMLiRy3r5s/a+id3M3bh5p+88DZB1TSl0BrfoGdSRGj2JqTCnVrZ7fhtHxPY
 zrIuWpuEjjkvpqZORoLLle6iVwmm5A46dRr8pMRj0FPjOrRxyPYD3NpJIpd9uR7Zv7
X-Received: by 2002:a05:600c:a101:b0:47e:e946:3a57 with SMTP id
 5b1f17b1804b1-47ee9463ba1mr10630525e9.36.1768408350849; 
 Wed, 14 Jan 2026 08:32:30 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b83csm309185e9.3.2026.01.14.08.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 08:32:30 -0800 (PST)
Message-ID: <1089ae3a-bfd2-436a-991e-98f6a215f194@linaro.org>
Date: Wed, 14 Jan 2026 17:32:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Support for zboot images compressed with zstd
Content-Language: en-US
To: Davide Cavalca <dcavalca@meta.com>
Cc: "daan.j.demeyer@gmail.com" <daan.j.demeyer@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <IA0PR15MB6368898A053C51160B3FEDA2B78FA@IA0PR15MB6368.namprd15.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <IA0PR15MB6368898A053C51160B3FEDA2B78FA@IA0PR15MB6368.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Davide!

(Cc'ing QEMU mailing list)

On 14/1/26 16:20, Davide Cavalca wrote:
> Hi Philippe,
> 
> I was looking at this series https://lists.gnu.org/archive/html/qemu-devel/2025-11/msg03753.html by Daan, which was queued for 11.0 per https://lists.gnu.org/archive/html/qemu-devel/2025-11/msg03759.html , but I can't actually find the commits in https://gitlab.com/qemu-project/qemu/-/commits/master?ref_type=HEADS .  Was this merged in the end? https://bugzilla.redhat.com/show_bug.cgi?id=2385692 for context, we're hitting this in Fedora and I wanted to evaluate the feasibility of a backport. Thanks!

I remember when preparing a pull request it didn't passed our CI,
then I forgot about it... My bad :/

This is actually a dumb error due to the patch not respecting
our style:

ERROR: line over 90 characters
#55: FILE: hw/core/loader.c:922:
+        size_t ret = ZSTD_decompress(data, 
LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buffer + ploff, plsize);

Since I already queued the series, I'll fix the style and include
in my next PR. No need for Daan to repost.

Regards,

Phil.


