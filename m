Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51865C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWXB-0006Q2-Tk; Tue, 18 Jun 2024 06:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWXA-0006Oe-DH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:57:52 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWX8-0002GX-T6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:57:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6f1dc06298so637099366b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718708269; x=1719313069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4We8Y2vKgsnGooRtjXK3lNhHTqMXFx1CNtOn3Ir4OXc=;
 b=E/DBJEOnwStwGENNFmf8KF5rAvBW4fxSHRxtKSLB2PBqqnA6IfkJuHFgxEJEmxOO5e
 sfbB2J5D3/6sE0817fszI6Tg932kcwSg1SSSh36utDObpBl0cXeYauwjAJQJJBdxbgvL
 F866n36G+ScFibcf7eTUq2nGG8B6CcfAv1Ahlz+moaa4RLW8pD1Dk+FYOpq9gwmequya
 79ia8zRPpY7JBR8LiIdOJqz7Rwxw9kIea/ZQtl7XFzfOa+mE4lV3xegKC/ZS0c1p+PXo
 DBzyF0Y0CS1RsZgwWqCxwh2n25taiSPNXCRlylnwvMrCEhfvhW4IWYwgoZnb/cKVlFUh
 BhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718708269; x=1719313069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4We8Y2vKgsnGooRtjXK3lNhHTqMXFx1CNtOn3Ir4OXc=;
 b=ExWUehx90Uh+54pGXZfTljNGceQY0yI7K7ld11nSeJxSRby3MyBnbsla5KhNmgrLwQ
 HhTFPuKXJCR2BPRUUCcC2OaYgnhUZshOyVYW/mehE0N6C0fd7lbMQKcC7S+47+1ocU3v
 RpvMPeEOmktL47+fhdA0L/mzFYLxEcZmuE5Zs+NPtfPXNwVSlX6sLfgG/gamgC7ABl+N
 5vTA5mY5Vlnx+cf0YpR8nqgc8f9QpiMfxCFWNSvVco9j+2mhPzjFd70+UkLQzMU4n/tk
 7EsSnh35I1mtyLyNCU8G7QK0dKknXWDTJBu9dSab6if+PApDZgJoOlVLWwToqg7xM3st
 P8cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Z+3Y4TXyHJ/xcP9rxb1RkUax7V/OXyHXeWB7MWV3Pfyt6tfMC6WlAD9YFHGXXAgriWzWRvFK0fPoWhz6vCl6/+DBN2Q=
X-Gm-Message-State: AOJu0YzHhZru9hiAj+MepSHWcsqhOvYYiOCjhNEytP+91sfVUb60Fsgo
 cJjwajduz7pvyGreuui2/SjwFZbyTY3liOEXDDAxQY6BxxyhFG1lA950whZGMzw=
X-Google-Smtp-Source: AGHT+IE3wmy4cSCNWHRrFc0EyvBNs+LIX+pYXWUWiYbqj/lySUBhGepzHE9qQYKRxwjVL14pKZtpDQ==
X-Received: by 2002:a17:906:365b:b0:a6f:2448:a274 with SMTP id
 a640c23a62f3a-a6f60dc1f00mr632573166b.59.1718708269136; 
 Tue, 18 Jun 2024 03:57:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db674esm604942366b.83.2024.06.18.03.57.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:57:48 -0700 (PDT)
Message-ID: <8b2b8861-f916-4256-ba47-ff26dc25251c@linaro.org>
Date: Tue, 18 Jun 2024 12:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/usb: Introduce x-query-usbhost QMP command
To: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240611102305.60735-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611102305.60735-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/6/24 12:23, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/usb: Remove unused 'host.h' header
>    hw/usb: Introduce x-query-usbhost QMP command
>    monitor: Remove monitor_register_hmp()

Series queued.

