Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346E5CAC5BC
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 15:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2X4A-0004WD-P6; Sat, 27 Sep 2025 11:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2X49-0004Vv-RZ
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 11:42:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2X43-00011I-4R
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 11:42:27 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2681660d604so30737585ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758987740; x=1759592540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4LSUVN8b2EB1HNgk8bEfVMqDx4CI5BWvd0c2OmO9dk=;
 b=O52Z+GPM2S0T3RQXZINxJWZKJ+A9GcSueI76a+Dt8YMWJw/gJP/JlYjN6rp1HNV2/n
 JSa4pkqSfjicoze/JX2beQ/GP75fitAkC8yvHxSon3/iO+WKPWBpUo/xNjOD3WM7iEz+
 Rab41uH+iWEubXH8mF/ZdpKGhb4kS97AJql5TtrpBiuzKE4bB1a3oiy6OmNXZhIAbxvl
 1tieNiLjbEDxDNvq4gKwuQDLX1xxQDMs9IUgcRRYv/RHbcU25LY1D3/BVKLkZjIPc5Ro
 eTTtdADFLE76EMv3yNypmvEnFNAhJ2BNca9L7rNlMPupugI6eEN/1WsXCR4WcqrAvmnC
 vAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758987740; x=1759592540;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4LSUVN8b2EB1HNgk8bEfVMqDx4CI5BWvd0c2OmO9dk=;
 b=elmXehYyZ4est5vi4ZpGD+ozT+ks2h9rBIqLB4kJAvwt9ZzpU9kQ9zF8g9huK62jYS
 x3UupIEdVx15+2xtD+cqOUbvjVb+dSE2ZnAwSMiDkcVfQrkSfz5K3bApY6mmkP7Ch/Io
 uzIKPx5rK6YeQ10TcWTg/YRlKJUAYto4YnTKvncBb6545wVCRZKc/0tMWT3GtrkV7vm4
 pDCKPLiwJ6jMAxmdrdEJxIyFG1EJpfQPK/a1KEVtTALv1Oqio+eqJhhnlx4IHX+ANtNU
 szIIL/xc6HDsoewyHatGpZGujDFMIBwq4vTDCxcPx5/+3tcfOkoA0kVx2I8k2P7dx5rw
 KwNA==
X-Gm-Message-State: AOJu0YwSh7Ue3jTFEyPShoirRXtNauPu980qeG6cQA0RwuxRsvmNnWhL
 Eb0dwJV1zWvYxWYe1ORklRUNyjavOFWCHrUSXv4oWQcgXi4Vr6WFvsmAkS+7b7tk5BDrQdE5HA8
 Xup0vXuH3Yw==
X-Gm-Gg: ASbGncusB1BgagqpH1oZviqPCClN07Cj5VcLqpBT9Zw6GE11uzlVxn715wmqUo6WQOZ
 Zu4Iq0qxZOkujn1A4ENjUKUA9zmrzjsEoOHoqWTtgfQkma7ofDSolazD4U4krFLo2hcjspsA/A8
 dg8PgH4lxtSGFa/DYfle/Z8VTms4tyDyHj9mLDbOn8PFwgs/abjRTIoamTPS7W9xglO9Q8jtiw9
 lJRnOGcUbMvwGwvyX0nuOK4ONJmPnlNsHtmx5OAgq34gNQ85wWrJ9rujf3ziSJalBQM+byfs0mP
 OOHGG6rGo2bdPPgpd/wmwVKM2VBjiUnU1/+6kgGd1FwegVl/SVHOuAQ8mqmf2p2AS9nhFbZw2wx
 TRLYrkHvrKHHC0VyrVahLTY38XtYDhI28+XPy
X-Google-Smtp-Source: AGHT+IF4xzE5y0AvBL1ESbNEHZCCAoS6mFBjtA8Q6skceSLIgAf0G31Y+8xkNmpxqhq+ozLqMJsOLQ==
X-Received: by 2002:a17:902:e74b:b0:24c:caab:dfd2 with SMTP id
 d9443c01a7336-27ed4a7aef4mr124212175ad.61.1758987740201; 
 Sat, 27 Sep 2025 08:42:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed65e8e89sm85432115ad.0.2025.09.27.08.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Sep 2025 08:42:19 -0700 (PDT)
Message-ID: <3677ed2a-914e-4e5d-940e-bde28b490307@linaro.org>
Date: Sat, 27 Sep 2025 08:42:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/24] maintainer updates (scripts, semihosting, plugins)
To: qemu-devel@nongnu.org
References: <20250926131744.432185-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 9/26/25 06:17, Alex Bennée wrote:
> The following changes since commit 95b9e0d2ade5d633fd13ffba96a54e87c65baf39:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-09-24 12:04:18 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-260925-1
> 
> for you to fetch changes up to 16b10fbf8bdb71ae20c7f74ab19c78d07c013ac7:
> 
>    contrib/plugins/uftrace: add documentation (2025-09-26 10:07:54 +0100)
> 
> ----------------------------------------------------------------
> September maintainer updates (scripts, semihosting, plugins)
> 
>   - new gitlab-failure-analysis script
>   - tweak checkpath to ignore license in removed lines
>   - refactor semihosting to build once
>   - add explicit assert to execlog for coverity
>   - new uftrace plugin

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

