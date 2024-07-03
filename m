Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3867C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 04:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOrtY-0002X3-TN; Wed, 03 Jul 2024 00:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOrtW-0002W8-LN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 00:47:02 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOrtU-00057g-4M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 00:47:02 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6eab07ae82bso2973705a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719982018; x=1720586818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9nr2Oz2suWK4vsrP3dAYq3AnEWFLRItcUBOf7GOL2jU=;
 b=NReAE7Etknp0t6vzOfvapNGWTdTVrc6ZADJ4o3ib43j6pD0EHjWoFTj4XeRN3mn/dY
 Cp081wwUBjX7+8MQLkmrPRvybq9n7Y7oW5PvNvxG4e+D/DZKc94z58cP7giykgGmpaYs
 /hsh8O85FoFxKoRPYELRH8jWyzkmm6lubhrb5DJR4MCavqkdpo+OcH5vAP77r04ee7dD
 3HbsMCaPkuIk8DKWMindiIeCJ/m8oG7J7ksaL9ibGaPy2kRzHyL763vk5pQ8HOSLBhF5
 PZ3EtSk0K18S+ME0exL8QUacw3ynbOFmrD78U5OpuBDzPlyhySpDjjVTL/KSZ9RUUG/N
 dplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719982018; x=1720586818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9nr2Oz2suWK4vsrP3dAYq3AnEWFLRItcUBOf7GOL2jU=;
 b=nsm1RBBm1yW3qhbZLXvEigJSIP3sGCaCl4pl78+yifRPqmLM24M7EAcAWKF3WCQnxG
 09fXrkwzDYSeqdYXb2dWY4TWWo4jV/lC+3Oxyf6rB7cMAvpta7rHCY8PFHz3PZx6pKhT
 9nvSJuW9BmRMu6tTpt8BkniRF3L5/Wj37Rim7PLBr9p7q3/uLoOyeph/YnWykVqNPEMi
 boCwsYEV6Q5IrqGqMXZfqabMvUx4CcX4fRwwkMLuvC6J8kuAkes5pT5C0cv+3Z9rDi+T
 CFnVXY3qjLLmUFXhux8HSv6itogV2PFGgh+7DMzZwDlANxkt1IeFn9E4vMNg0pIhIlTV
 oB7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj7L26t8SWZsJTYL31RrCn4YrAHf0zMjuOYHHGkLy710ZKXuZL1HC/cv9+vsDWrHA6RhOOkYa3RmPg8BvapuuZOOCD+gM=
X-Gm-Message-State: AOJu0YwTvtaqOtK6A25Xq+JxRlbWjGe/SWr3+APQit0L/xGSphs0VdAD
 yTDMgrt/+B6Lo5xvOgrtrf9ckAD2tBbSxSew33l+NFQRUWZtsPXLYQkXNy7yN44=
X-Google-Smtp-Source: AGHT+IH8FxHEGF+ka/88yL7PrLBp7rx3sap8hapOBkbTWdh9qd62216nQz4OVvFh3zsz54LZABIdgg==
X-Received: by 2002:a05:6a20:2588:b0:1bd:2520:c595 with SMTP id
 adf61e73a8af0-1bef61254admr10667890637.31.1719982018282; 
 Tue, 02 Jul 2024 21:46:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10e3311sm92630675ad.79.2024.07.02.21.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 21:46:57 -0700 (PDT)
Message-ID: <ab533c23-85d8-464f-bf06-0eda81bab8af@linaro.org>
Date: Tue, 2 Jul 2024 21:46:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] qtest, s390x, avocado and doc patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240702103310.347201-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/2/24 03:32, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:
> 
>    Merge tag 'pull-target-arm-20240701' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-07-01 10:41:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2024-07-02
> 
> for you to fetch changes up to e3e2708fee10e6df413c36a71b100c59710e727e:
> 
>    pc-bios/s390-ccw: Remove duplicated LDFLAGS (2024-07-02 09:52:38 +0200)
> 
> ----------------------------------------------------------------
> * Fix interrupt controller migration on s390x with TCG and enable qtest
> * Fix memory leaks in qtests
> * Use a proper qom-tree parent for s390x virtio-net devices
> * Add hotplug avocado test for virtio-blk
> * Fix Travis jobs (need python3-tomli now)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


