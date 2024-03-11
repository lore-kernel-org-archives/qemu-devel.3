Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA03EC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbOQ-00066M-7t; Mon, 11 Mar 2024 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbON-00065z-Rl
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:52:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbOC-0006Vs-3R
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:52:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so1444968f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710147125; x=1710751925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ny8lEvNQkMIWOPf6iTD2zCO6t8rpVgSAZFAYRbKxces=;
 b=iovATjaXVipBxUWU91ljysxpDrHOs54JwBneGoCghNQgd/GZZn7PBbI84Sq5hB5T+Y
 8JLTpKYS7TQLB4qaOLopG6nv/0vKFBmODZLcTczxnaUv0K1D2B8WwBFUV8COWhxKYOZJ
 qQC5nxLu2rHJ2opBg7oS8EGbH1NLKUhN2f9kFRopAWzLBhmvjbbwSeoh4W+77FhjJfIy
 U7bmC4wbMtp43oH/fW0d4MK1820fQQSU0ABAPXmKW36qTjCpdbeE+8/CQc+1hYKBP0Tw
 5PTxNJIugqUYHVITTZpNMajZbpxFx/tuW2rETo5W/s+dzrHv7nDJ3o9LUZ/xqX+1reWI
 M3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710147125; x=1710751925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ny8lEvNQkMIWOPf6iTD2zCO6t8rpVgSAZFAYRbKxces=;
 b=YLgolxp7uMx/vNeoHKfg2eWLCpNp0CSI/9f04AgulY2KHlVgDbxL/V4hmyIG90EKCN
 70cV5yYZwLVdCynAtQ83Ye/lNDGVBDEyhGYhShxSJWZyU+1eudn0gKjNbTsD+7cH3ChH
 Uh+3VjK6ogs6Z4Wt0d/uS+PorPq7RlP0i58/w5hlByO7aCblwSv2XOjTMGAsHHnz8M2E
 OruVv8oXOj/0UkcFmun8l/iUjWtMSi7+ED+Ia4vnMqWuAEyk4uhJ3VqPB9GHufWo3dX4
 gvG3efeeIIEEXS9dbhrSKYfDlGrwhnWvbLznUYJ/oFJLfNq/D7skgBMP/j1+YdGKdwxS
 yD/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZAEhOGDE8Mk7ZDMB72MrzMU3UA763iSIBoYVJpQzp/q5PIowbLnUOpn5j0Gs97fXSr0nJkUX25ymQH93+pNGDLvVohcQ=
X-Gm-Message-State: AOJu0YzQGQ4vKpQA0Ougs5Rjhfi3RfAVkngysWU4zsYQU0/2NUSY+0TG
 Iq+9mI/pbYReTF8CPTYxITfpyF/cS8/S8EN+abjMlYhVMYWoq6wDEtNhvGSD5MU=
X-Google-Smtp-Source: AGHT+IFKrMrc0SvHllEV34EE9D8Fq/WDwuWaIgqUIyI04D0v95sLOOnzr504MwGIdL8iaGNhAFxYng==
X-Received: by 2002:a05:6000:110c:b0:33d:2b3d:a02e with SMTP id
 z12-20020a056000110c00b0033d2b3da02emr3939254wrw.46.1710147125659; 
 Mon, 11 Mar 2024 01:52:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0033cf4e47496sm5869929wrn.51.2024.03.11.01.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:52:05 -0700 (PDT)
Message-ID: <d460eb7b-89d7-46ed-9b8b-2376f3744bcb@linaro.org>
Date: Mon, 11 Mar 2024 09:52:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/core: Cleanup unused included header in
 machine-qmp-cmds.c
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-3-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311075621.3224684-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 11/3/24 08:56, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Remove unused header (qemu/main-loop.h) in machine-qmp-cmds.c.
> 
> Tested by "./configure" and then "make".
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/core/machine-qmp-cmds.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



