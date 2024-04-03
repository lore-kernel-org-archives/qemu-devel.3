Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56BDCD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrx50-0002Kc-Ke; Wed, 03 Apr 2024 05:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrx4p-0002JB-CL
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:38:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrx4n-0006hx-L9
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:38:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41569865b2fso19966175e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712137116; x=1712741916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lhpR+Ob0QS3t+VikVSZNsEQqBfbt1Gdqr3jlAHI25SY=;
 b=J3WfMknk1p0ZwE9O+rjkoCwsb8pCkF+yFAAzEQZFZ8JfcCndRtQvO5xghIC2RPC43w
 Zn4rY2s/gaZRlwdkjvGl/tnLBfmzdAdoouDOF/If7+7TJfHggkB0NejND2pnH+cetGMF
 UHCIkhSJCkO2sz9VU5SOsVqyd9z1EOh3OsIpZrhUJVua0Be1Q5XboCx409o8hERglhCM
 /tH3WLVBGIsvOwZeAY7jwtzkjrbTylsJNIWPwVXV+TnCi50pcek/jcCxDYZKnch1ptOV
 7bonyW+8Alx+PXwWjAsj9Ucc2L76x+dPYSYRZKunR6bFesUyeDiTG+Q/O6QJ8/wTbkO+
 SYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712137116; x=1712741916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lhpR+Ob0QS3t+VikVSZNsEQqBfbt1Gdqr3jlAHI25SY=;
 b=BTC1RTma0RgX6yBYgd7xz61kcJyjmrdFJO5agyVVUoJWmDU1wgCBq4BGc9J/Tl1iwS
 XvYxHofVgIpaGjKc+ZYSzYRMKei/+e6h+xqHHzMQHSwlHySsDnur4QJ+cf1eXcQxBfWT
 BZZ9zYAsYwh/vlinfUhscD55uuKnZHL+OF9pIuclKCUhx3Gr5otB2qEGBlaUsP1L0Gh3
 uAppR6LyZh9lm+bxh9/q5xra71SSvgbMLJRod1kUECs2Q3FPWH6YuUQeEHuFB43RiVuR
 WsEFs90/BasucDLiaG0k2P6AHC3AZVL2Fq3ix59DMkLQn5cLXvE0u7tE1tPG7LJG9Lpq
 nhrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLeffSnMSBFY1fwBe0SrjY4x/eeMEET9EEy/wnfES2cOfK93ug4k0ZKLQYU3yZPirLaHYtYvtVd7jKkPXscD3ruNfKqg=
X-Gm-Message-State: AOJu0YwbGBiczx6uGUNIPKvhV3YImQXWr9ICIl59B7tBHaPkX5BR9DRy
 tufS3D6nihAsfn7+gQnv039rluONO6DddPNeaFZ4LQQpfLdKOC2d+3c734to4NiafDHzzYBjFg1
 v
X-Google-Smtp-Source: AGHT+IFtjRlkNoXQr+cohHKccYPNrpUQ73LfaxavqU9MU3Cx6Ehm3go6KoBoGHkVDAcV3vezRhirAQ==
X-Received: by 2002:a05:600c:1d18:b0:415:6616:6513 with SMTP id
 l24-20020a05600c1d1800b0041566166513mr5860232wms.12.1712137116086; 
 Wed, 03 Apr 2024 02:38:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.223.215])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a05600c468600b0041477f3f99fsm23980760wmo.30.2024.04.03.02.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 02:38:35 -0700 (PDT)
Message-ID: <8164b02f-adb4-495d-af81-9264aa700771@linaro.org>
Date: Wed, 3 Apr 2024 11:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration, docs: mark RDMA migration as deprecated
To: Li Zhijian <lizhijian@fujitsu.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Yu Zhang <yu.zhang@ionos.com>
References: <20240401035947.3310834-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240401035947.3310834-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 1/4/24 05:59, Li Zhijian wrote:
> Except for RDMA migration, other parts of the RDMA subsystem have been
> removed since 9.1.
> 
> Due to the lack of unit tests and CI tests for RDMA migration, int the
> past developing cycles, a few fatal errors were introduced and broke the
> RDMA migration, and these issues[1][2] were not fixed until some time later.
> 
> Modern network cards (TCP/IP) can also provide high bandwidth
> (similar to RDMA) to handle the large amount of data generated during
> migration.
> 
> Issue a warning to inform the end users of the RDMA migration status.
> 
> [1] https://lore.kernel.org/r/20230920090412.726725-1-lizhijian@fujitsu.com
> [2] https://lore.kernel.org/r/CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com
> 
> CC: Peter Xu <peterx@redhat.com>
> CC: Philippe Mathieu-Daudé <philmd@linaro.org>
> CC: Fabiano Rosas <farosas@suse.de>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Daniel P. Berrangé <berrange@redhat.com>
> CC: Yu Zhang <yu.zhang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   docs/about/deprecated.rst | 15 +++++++++++++++
>   migration/migration.c     |  1 +
>   2 files changed, 16 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


