Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8E7C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 18:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP4gO-0002LE-Bg; Wed, 03 Jul 2024 14:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP4gM-0002IF-Rq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:26:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP4gL-00063v-2c
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 14:26:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70aaab1cb72so4020914b3a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720031175; x=1720635975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpZM+3CSyxUDzIjnKoVepOc/vfRhsv5MlG6Jo01fANw=;
 b=ffhtzk/TNPpm3XoIe/G2OB66zuP/ZoNk0mw2oJJYd0gLSVO2Bt5GCR36C58JHoTixf
 PL/WjNhp9pd5q6TjnSK5AmCikYVvnuKRORectcurZ+FKfvZ3qafToVB7DflHiO5UEi9H
 /x5V0YcqICr3T4vra/xL3fgZ5tFXaWxdtzdzoKImJsPX7PLIMXj9Ak51regeTTG/3zNf
 JaWg6yFd5Y+YdADBTYyln3Vm0n6e9hCBVYwPtYsiPywkRKRcKkSlbg0FJOjS/PNqkGWK
 6FK9DJnordN3rx1aVSya8ZQpnXnywtT8kWlj1AmIx8LSLk72IYAkMarz0ZpXJ7kSKPNI
 AKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720031175; x=1720635975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpZM+3CSyxUDzIjnKoVepOc/vfRhsv5MlG6Jo01fANw=;
 b=kE6NzWLXqBe8agKwpr/FxT0JAkTOvQqAmsvJbYe/FDmfnSVjwXWLTOz3ewbCYIwkNt
 nIscd2M3vbO7otC4LMgMIy785yMtrtpyY7aJR23Iqw5lSA6H0gq39X1U0Mqm52jhqhOp
 Cd54U+a6qGTBTGfVjUAEzVvbnAOEeuOSkzn1zxhyrOuX/7JW9k/3A5RyQMe5SEdv5iZH
 avcxA2KWtzVOn2ZfrXixs55MHDl0Yb5Jdcs0ubAfmHKJ0BRsxEoWLwCOjC3CGbWeJVCD
 k08ufUnuJfQJzy9wQ49mNrKQijCCHdJo0/KyjQB6btApajdgzkBowye/J3LO3YOQLkbu
 T2PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUecXLImxM90OWqmYnJc9T7Tpn7RjtmHgr1pTaUFNnyjgpiOKykH+vZiCAcj9vdENqARKwEyp2QhnMCbvPwgdBV+iPMx7E=
X-Gm-Message-State: AOJu0YwvSjmxZYKMf6DKpfvfjkjicTVRFCAVyLvXnGTexql24DqzZREk
 1N0y9Djd+Loih6C4FZxZmzzNgB1797266aaj84zn3rdu6F8ZtL9P4tRSspMuD1E=
X-Google-Smtp-Source: AGHT+IGflBY4eMqJyjmsaLyiKpzf4uVLOhGCudMBpvalPCnFoIiwoqhBzAoqWcDAKTKLG2vbYf2Tuw==
X-Received: by 2002:a05:6a00:3cc6:b0:706:6bf8:bd7 with SMTP id
 d2e1a72fcca58-70aaaeec9a5mr16223598b3a.21.1720031175553; 
 Wed, 03 Jul 2024 11:26:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044b0b61sm11097627b3a.176.2024.07.03.11.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 11:26:15 -0700 (PDT)
Message-ID: <d0770ec2-1425-47af-863b-6d924f20d3d3@linaro.org>
Date: Wed, 3 Jul 2024 11:26:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Block layer patches (CVE-2024-4467)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240702163943.276618-1-kwolf@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702163943.276618-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/2/24 09:39, Kevin Wolf wrote:
> The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:
> 
>    Merge tag 'pull-target-arm-20240701' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-07-01 10:41:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git  tags/for-upstream
> 
> for you to fetch changes up to 7ead946998610657d38d1a505d5f25300d4ca613:
> 
>    block: Parse filenames only when explicitly requested (2024-07-02 18:12:30 +0200)
> 
> ----------------------------------------------------------------
> Block layer patches (CVE-2024-4467)
> 
> - Don't open qcow2 data files in 'qemu-img info'
> - Disallow protocol prefixes for qcow2 data files, VMDK extent files and
>    other child nodes that are neither 'file' nor 'backing'

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


