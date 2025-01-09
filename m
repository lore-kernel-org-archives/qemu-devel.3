Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3105E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtiE-0000ck-N7; Thu, 09 Jan 2025 09:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtiD-0000cT-O6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:40:41 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtiA-0007NV-MH
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:40:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso10586485e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736433631; x=1737038431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYXRCqbkM1s3ekvoBjDXOmJHmGiSw2UMpzHpbfdI/V8=;
 b=udRaSoOgTZLilldCWi151nebbSx9Q4Lq8CcL4m82AL06j97AyIWIJfaS+uR+fCEL0J
 qmtO+vn+ptUv+qfiY9bL9r27pqvfpy2T9YSfHnzm/oH4Rt6Xe5hIHzWx/h+ckKvrX93g
 OfEW7/mW4lPIN4Df0qAQN2mJg/D3pNeGLgSXiUbHGU8cU7dkbtGFHgq8Nv5f1u3naAJk
 /MXUS56lRI/+/+K1E9Yso+0HFsk9YqDrh5AFTZC6czy9XxQg7iyk0CWVpPrC5zzQ3as6
 XowNiTgXpBhhpJUC3iuLKEPXES8M4ECU7t7gvjyGe3pM3sjJjnB4UWVHPVFvereyA1v5
 Pezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736433631; x=1737038431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYXRCqbkM1s3ekvoBjDXOmJHmGiSw2UMpzHpbfdI/V8=;
 b=iTUE5fGiH/b58BMFB3r2ku4dNpE3Yi7Z/L5fv6xQUMkF7exB7NjaTqSCxqDMt6jmKA
 dYh3CFnK+cRtzJO7U/rpbWAZjr11ECAZyOrvBOJxaLC1twwjt6IcO5iMufVtmEt88WPu
 OJnnBJ9TMNFvw18lrDPq34eE34Xm4I3r8SdUxm9Cv3w4H/rhn0wceKziIyxDu0L+/aSk
 GZ52TxTkpXQydSwvv3Mg0hP4C0Iq1b+J7+A9P/Aj8KOfl2zeCtdOw2BY8tGQgN3SV+UH
 FM7g48GOQauHmpII/4qUUdvuA33HkWIsJSoINDqwukEYNMOodrNJV56Ynje4ebbtvyI7
 TPOQ==
X-Gm-Message-State: AOJu0Yy3mlwJqigmuAOtb1QHwR0K6KbHbUNeXiIU3EPQyfZPVsfqMxRX
 r8yZ4jW14PE+OgEbogZPrH7JSF4dIcPCL14+pCGm1ylueg26BAfc5WwnQYflUS8T/O+LT8fBNZJ
 tgLQ=
X-Gm-Gg: ASbGncuBauC3TCZhaGhcdxekfiyQJiIpBdv2g0QwetKfKJBJl9PG+MIi+L4G3r5WJK5
 uVvwMlnRR8bucrofmFMsdzKNzqGHC24wQX/50pcB78oumMfaGgKRW15j/4LhmaAGHVyCYGEtt82
 UYCA++c8010Qves86RzWpBSXQY0FFITF/euBQCn9C1yrbgTqX5K6rRzx6wGfEXPAKW1ipDVLnok
 ZbqdVu27VxmjQGZOCI6y5/M8+kWbiqISYKAmzCt5T6uJUvlqWTDk0w7fweu9QmoDU0qwpAFU2CJ
 7JACZLla/DCL42U1sOQuDZyT/zg=
X-Google-Smtp-Source: AGHT+IF85vFJG5jHU9GFKa00Kz4E90daRoF6Sxj4MwHQ4tF6mZySw+7d66Q6Zhtasx3SCfPUI70xLw==
X-Received: by 2002:a05:600c:3b86:b0:435:32e:8270 with SMTP id
 5b1f17b1804b1-436e26c7ebamr69338155e9.14.1736433631619; 
 Thu, 09 Jan 2025 06:40:31 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcceb374sm69319395e9.0.2025.01.09.06.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:40:31 -0800 (PST)
Message-ID: <eb8464d7-f709-4c58-8edf-48aadb29db9d@linaro.org>
Date: Thu, 9 Jan 2025 15:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] QOM: container_get() removal
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
References: <20250102211800.79235-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/1/25 22:17, Philippe Mathieu-Daudé wrote:
> Respin of Peter's v2:
> https://lore.kernel.org/qemu-devel/20241121192202.4155849-1-peterx@redhat.com/
> 
> 'The series is about container_get() and its removal.'

Series queued.

