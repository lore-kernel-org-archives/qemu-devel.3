Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065C6C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqoZh-0003tu-2l; Sat, 08 Mar 2025 02:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoZf-0003tf-Vb
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:26:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoZe-0000GO-HP
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:26:19 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so15485435e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 23:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741418777; x=1742023577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZweTxkCcHtM32ZA2wHZ3IcSmhsvikZHNciAcyGtNLA=;
 b=anjxLax3DvBGRhAj5KZ+st9fTLrUIineDcWEBQ54S4br5C3vqgPk1bPmpN2Ic0j5F9
 b9sYMwliLJCAlG4Xjq4kujG8rJKxECl8vsd1QurK8xePlGhxg5b2wZhKT4erVXyh6XYC
 api5SjYJQ6qtEgKr2e033n5YRUPgB1AmDp6FwOQL+MM0pkBy0SYME7gLZPzCy3MOI2r0
 38iMoYk3i8bOcMatw6KqNAZSOdolY8gB3ZkR1KP9STL8z8oxb2Ha8hzo1CX3FktGtulM
 I4pMCPaqzx4ZAJFy1JgJ7KuFjYxVAnIXt1D+dm2uEAY35NYGhpXM4+vvPi68X7SeniJ2
 w13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741418777; x=1742023577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZweTxkCcHtM32ZA2wHZ3IcSmhsvikZHNciAcyGtNLA=;
 b=q8xvdr8rivssnbAJL16Nv4ICtuAk6xi6ZJojIHkbRC3Awst6cFZ5xSt11BB/Zq+Qpj
 OMQcQpXL6VViDWcTr7ON8FcRLUPwIPHDawYTnNTu0THg1eFJgRuypVj0oPo9mQckkkXw
 3epre9zp6bUgD/7EGNukeEmjtR2wSrs/BG29Hox76Cqvf6jX997jQrmTK3mA+Adfqdef
 5Jy1LcETd0MFlQIhPXNAjpEMfFgCez4z1VgmVIp073t6ojLEA4IWw0++h60dr9oU8zEH
 QRILVdt3PssmQTP+KW/KY6fGesTVgdrIp08lS3JrREAQhB3yPRnTXtyMKCHiibbA0Qeu
 6DXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd52dF586KiDQLH/XtlwoSstMSceLC38LoxBlWcGUDCGqhdxYlSYdMj9Kv3jZOAkaK8XbiOaBFLiyu@nongnu.org
X-Gm-Message-State: AOJu0YzndhtAz85krWv5wPtR8N+bDrk6b7qY7TEGBtlauEUt3v5aIwCt
 7z1PTrNZCsgB/h+R+mkmCb+wxP/ET8LpKPuV4m53Edxibh2lmHLpy9E5ZjW55Xrm2Pvy3iGCYNj
 bNWE=
X-Gm-Gg: ASbGncs+Rp60fMauWnrWy9ozE/yFd1f5KIpPvdjTAlhSVssEroSEam0HSa/xYk8AJpH
 r48/2sqm7uWrKYAiJWpX0dAnrXeEndAit5zgbOA56UpLGD4bSgOKJfrpQ2lvyraVRep6HnIyv/x
 7GBJBc+oQC/yznk1BGYNU3kZAjCjOB/yknzIT2eYrI6LnNJQaNEOauo54QlhOu1LJXIRxcR8s8j
 UT1lrIGt4QmJUplL/UvFyFBUWF2XgbJfY3TVgsKkOf8+DcNVBQ2euJ7OyYUF4cdUEql/nnZAss1
 JGjUwnInNLleXHlRuyj0bH66XXOFBaAQ5B3kbitRxgugD5bwL0lqRK/SZE5pqMwS798EcqAKSf1
 6qN/WyZQoVD/Y
X-Google-Smtp-Source: AGHT+IEhZeOKqUS5spjOQvUBLfJxeI0E0333Uf8jegHAWFYKms90jGEQskfo/IuRubd3oNL6v6hc5Q==
X-Received: by 2002:a05:600c:12d5:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43ce4ac0c14mr12095225e9.5.1741418776808; 
 Fri, 07 Mar 2025 23:26:16 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd9470e2sm74961815e9.33.2025.03.07.23.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 23:26:16 -0800 (PST)
Message-ID: <040335ad-eaf9-4d4a-83d7-27822f0c23d0@linaro.org>
Date: Sat, 8 Mar 2025 08:26:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Require 'user' netdev for ppc64 e500
 test
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>
References: <20250308071328.193694-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250308071328.193694-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 8/3/25 08:13, Cédric Le Goater wrote:
> When commit 72cdd672e18c extended the ppc64 e500 test to add network
> support, it forgot to require the 'user' netdev backend. Fix that.
> 
> Fixes: 72cdd672e18c ("tests/functional: Replace the ppc64 e500 advent calendar test")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/test_ppc64_e500.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


