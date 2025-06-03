Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8ADC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQ1Z-0000nY-CF; Tue, 03 Jun 2025 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ1W-0000jR-Ds
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:41:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQ1U-0007Oz-57
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:41:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so3176283f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748950898; x=1749555698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OJHVndshKhRXQ+0FROyF2SRb251b7lJJ3w07hM252dE=;
 b=ay2srAPfJkUE+OCZqgyMBfNZf5t0USsmqIEj6yKV6MORcbAQZkjAEICz5Qsg9EoT0L
 3agMVL4PBf0WfT2XbiRu3E8OOFK7ARr+h7y0TzT7HZthY6OoUW20wF2X4lTrv8jHzR1V
 33S5sWX+8c1avmxe9MfigaPZjdLccSSzv9bXqgVCd2EYuNZOCsIIQFPY+NlQSAO9w7tt
 /1zdDU1ttLpKeOuDM68MmcZjKH6pRc/8kaOadmNsH1c1IKtqiS1rmAyVGwSmeQUAYKiv
 259acXu6h7M5pdI/kIqWsZU8qlusXRVI+21IVf4Uy4QoA+VRqozBA8JzYL07otvcii7r
 aewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950898; x=1749555698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJHVndshKhRXQ+0FROyF2SRb251b7lJJ3w07hM252dE=;
 b=u1Apo4rh/sZYvyUbmq2F4ihwzaQ/CP1/aDFfiKk47BSW2Gs3sM15XrSSspGIFT6TWk
 L/9rciT4zcbuJYiFeOPYn4d7sIPhPK6MOJnTIdyxvqNBeZx6xHc3pXiy+MGuQ/eGhLU+
 875n0sinvLl2knuiV1or7j8rLTaIuProlvzukFjGTRjsHH9xEx0BVnRLxKDZ7D/LtScf
 iuCnpaA7zjurWJklbdIXyPHm8U0Clmd5GLCVIISPC9EHdQAqJw+gDcXdA94Tj4kQzDhX
 oRw4gYqIDR8iiZpLNYbds0w/L5EanFmQdsWjkDpMVCsiDvI0YurAb/6mf1H0tKIXgo1s
 qnjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVvwQDf1PdwFUd+FZKu9Eq5FvHqnY53cgV3LpFpbilU7xdxbnR3uOfO8XlYzqEuAAyE3EeR9HoK+o/@nongnu.org
X-Gm-Message-State: AOJu0YwapwoLxxJOR5Ge+ldi1ZCUhhO9FndoyLNgyHjAPE8GVoDvFmks
 I5yQuQVaIC0LvFnSAG73Wmff9dOTpyaxlsJLVOL14GqthoHT+J27z4yk6z0FpLHNJIqUlxQ/9eX
 X7sg4LSE=
X-Gm-Gg: ASbGnct0TBGWHwDbH5Rmd4sX+zoX2AG1GkE7GxfcrZruubPLInoDoEcRr8vkghC0/8a
 fFdgGw0f+6fMNbl2c5R1nD8bscEBDbCNdmoxNWWua5fpkY5IOw1k5Ejf66t704LgKNWiQ7Nyyc0
 FNj7x7kLk1/anF9jmTGTcAT9vI8uNGyJPHJEAFVECy8p7O1a6DnSYY7jiVHSxVm7cnFZXWFQeEP
 Y0ecE2r3ucM+igk9umA58X7MMs+ceicpdwZC68b7rirMkEoG93MJamScxWogqEiyZi7cv7tWoSy
 +5mvx89I6Iz+0rHuTZ4Rl6L6cgULyCW+gYDx6llNlZ66OKaPOujkiEdXSZRevVan0m+kIe0GA+8
 V8IIqNz/C+iSLrZx0fRdtt61W
X-Google-Smtp-Source: AGHT+IGiGNB9vq2tX8VBDbXbc36/1KqTOPp2yqkpqbg9muig+4zhHwV4IiLboFTMrFXdTUv7y9JWLw==
X-Received: by 2002:a05:6000:2083:b0:3a3:ec58:ea81 with SMTP id
 ffacd0b85a97d-3a4f7a6d2d3mr13347189f8f.42.1748950897819; 
 Tue, 03 Jun 2025 04:41:37 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000e3esm158011675e9.22.2025.06.03.04.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:41:37 -0700 (PDT)
Message-ID: <4ddd1daf-4f99-4a9b-a26b-f4be0e1b9064@linaro.org>
Date: Tue, 3 Jun 2025 13:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] hw/pci-host/raven: Simplify host bridge type
 declaration
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <04bbdb7bcec7a4f1f88a903d782fd8737c7b8036.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <04bbdb7bcec7a4f1f88a903d782fd8737c7b8036.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> Use OBJECT_DECLARE_SIMPLE_TYPE macro instead of open coding it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


