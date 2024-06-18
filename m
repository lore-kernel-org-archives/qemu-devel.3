Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBEC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJXGT-0004LM-Vw; Tue, 18 Jun 2024 07:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXGS-0004Kj-As
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:44:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXGQ-0002lC-P1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:44:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42278f3aea4so47362375e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718711076; x=1719315876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s2Zju3i41H/qhpQ+2cXlbpOuDcss5eDRIqTYTxjUdVI=;
 b=c6YoDBbse0KFMIUPUstWtOMYc1gII+YaD7sCIc2RTaY+2U5Mg3UoBaaK0wQT1pzLDu
 75NkXyc59pvpleh5nXse9mU7yhL/QB8tkAa1r5xJ02NuEX5DCaIYyXu3WfHyfj8u65Md
 XrEV/bgc5LhpIgJq0jMpOuq7ItDnTDoRqFMgLrE1vDSKfYkTqwLjdbyEvp7M3A84oWMK
 LbjHmsXDER3wiUFMRT0FBGYW9An6tzlBUEMNTcidf5xvrHnWUG6Gs3DSzPdgncXEe/Q0
 orq2lx4o3i9QZqkIjXo3CBdh7wNaUSO1M01CMIYaZrbYTLX0MRwxiEaJzKQlVG8CynZ9
 /AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711076; x=1719315876;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s2Zju3i41H/qhpQ+2cXlbpOuDcss5eDRIqTYTxjUdVI=;
 b=DB1SswR6VR5J9hdsUBY+pg+OME8hDMv5hlUwtDUgfN7Ib9uzWw4d+x9Ne39i7o4/ek
 H2oA7XhmbG54mfrRFvA77bcPG/db3htBXqiF+abMIbSAh/iIZtv8IdG+A90f24zBmPHi
 HqLYaV2oJhDzD/szPtXnrwbV7BBpxO/zjYG70J8f8/CXMAVVtdynwiFPQCXg5N8GMDTZ
 YeMRvD/ZopL3Jbv2XEzGfZtcOX1JGkNv3b2+vPKZiyH9SaeDoehoyn8y/WDH2l8aAaIH
 CgOuQkxx9jimY6u7TRpWh91F1nXm6VCdVUgd2cVlrRqDrqMwQ7fqBMKSleyeBb4Vy1v4
 Xc6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6MiBo7MFXLRZrCTX6kpR6179P2qTCFRWrkgoFpG4j9VEEcrgm9BKMYyxWxPRMGzkjSrg1ZZUyNYJv3B2HyJKg2SW3CYY=
X-Gm-Message-State: AOJu0YwlCDjUJIdq5/TIRZXZWqxgqYNAFItidxdlTbXuOFAnjxtamskN
 LnMatkvY0TBoo/BY/tviyA3fKeSJ6mcp3RjITXMGWiYZyaxInT+sOlSIHHXjexg=
X-Google-Smtp-Source: AGHT+IHItt0U5+NKlZRWZvnAigMX6H3yCl2z6o7IeK/tAtahja7XRkYa5QpwWiMfH8YriUc6WSTE+A==
X-Received: by 2002:a05:600c:888:b0:41a:a521:9699 with SMTP id
 5b1f17b1804b1-4246e650e3amr28726335e9.4.1718711076545; 
 Tue, 18 Jun 2024 04:44:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de68asm226013805e9.29.2024.06.18.04.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:44:36 -0700 (PDT)
Message-ID: <cb06b6ef-90f9-4528-a3ff-ebf318bca6d2@linaro.org>
Date: Tue, 18 Jun 2024 13:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] MAINTAINERS: update kraxel's entries.
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20240528083858.836262-1-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240528083858.836262-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 28/5/24 10:38, Gerd Hoffmann wrote:

> Gerd Hoffmann (4):
>    MAINTAINERS: drop audio maintainership

I couldn't figure if the discussion on patch #1 is resolved,
so I only queued patches 3 & 4 to avoid you getting spammed.

>    MAINTAINERS: drop virtio-gpu maintainership
>    MAINTAINERS: drop spice+ui maintainership
> 
>   MAINTAINERS | 42 +++++++++++++-----------------------------
>   1 file changed, 13 insertions(+), 29 deletions(-)
> 


