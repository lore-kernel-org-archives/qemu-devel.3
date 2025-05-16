Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83699C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwM2-0001e7-5l; Fri, 16 May 2025 10:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwLy-0001dR-5E
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:48:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uFwLv-0002Nt-Dx
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:48:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a1b8e8b2b2so1456598f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747406877; x=1748011677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Hz9R3lbGIV+V7GuRIm48x4ah4B5SS/VSn+imgLSZbM=;
 b=USGhcD5s9VMHzC9xW5Gc6oMpWZcX5UN5YzA2ovARnkgCFO/qZs+wEvBiRprpwELdkO
 SqqBUjepB4lClqojXYN4JHc8PUJ9pYYgSQbdJQm+VlZwdwx8ulJd4ibVdWm4sOEhcVbi
 CyaXZOtSjtNC26Ll1RWohw2OoJ2Ci7o3MoBjYUtycOELaiSVNj20C88J7ZbxEhrl+Hn8
 zUSxkcbN0EBJrOfxD8IKPh1Jfs5alw5nyBryrgUdswO+RxucWcO51U2BpUfj9wdq7ene
 pV3hnlcVz3cKWtQAteyvXQ0WVKfMtC8T9HWczBldBLexMRwnUH2bHYB+Ke/966pon8ln
 bANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747406877; x=1748011677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Hz9R3lbGIV+V7GuRIm48x4ah4B5SS/VSn+imgLSZbM=;
 b=s1M2x6vhdXmtpYDoS5VTvKuCyILmjLO6nHdbF2296sqbm5DYswCC/iJ0qWVZ+4OP2u
 aV960GpXDHWy3DmFnpFrDZ3IIJ8eM5cofFZJq/cLsweeAK00nC4K4GBDR4dXf28KP2bq
 cEMRU9aiJHghK2SggrLtLiCF2aUszZkM3k7V4WYfv0sILMmbDdqLpknnVNi3adooyVAK
 J6vIbk4g9NQ9ZVWclW7Dz6uzFSjn6azM7Px8GDDadMsonYfEhZ6Grr4N8Vbmb1sj5JFb
 r60l1m/x/Bn/b4Mf7sBB4/GG2+bZ1R1obaxzmRHhJNs/VpELVORgw8OQipxqcfo+SCh3
 mgsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMCuyPXRAPr3lsUyps9WGVczSn5qSG8hBf2A7DjtUR5qIuKURs6VCSBNpncTbRdRyiCk5VJPpeGfrZ@nongnu.org
X-Gm-Message-State: AOJu0Yy8XtDeF0SwT4JQw3cWBMxNEBV0zEB+CtUHt5ylMDE139CmCeJW
 H1sXV/ES9GeDhX7BTCCcMmy6TDJBkxk1Mgmyol6RFuoTB2veszQCnfBDJQ9Idi7aLbE=
X-Gm-Gg: ASbGncsky9aJ7nK/yS5gLuJ9+0bJyM50VRSlko0TU58qpkN7JZCzX6edpKyCWUW5giN
 M9ZKOpWfWBXWBSDr6mwCiGcJLitTgx5rBwP9IzLhNNcPSvcb4IDuwXv4rIVPRbFwNUOXub2FZi+
 q3yH6knbjpmu7b4PjnJDSIGBrpaivuOJXJBMXaTsY8n6tvrOxr6KkBM06tYB39GDt+1wcsT7oU4
 Iwr2BEJTJg8aEiLb8rQtAwJrmeskqh8+PBC6eoenEWVX0hRWzzZg65adSQVDfwIzgfqOnfwILJT
 ILmWK0utcpSi0zfvWPWn+vg88Ogf3xu6GfkEU7BW71VIL0gcFSZkQAbG6yThFookIO+vfonkbyU
 POXQyPHmtz+/k
X-Google-Smtp-Source: AGHT+IF0eU5h38psqMO73iwCcgaikINZxZeJcvoOVEPB3Ux1ZqP2RZfnykIjp9/yr1rIYKQC/TmJrA==
X-Received: by 2002:a5d:5848:0:b0:3a1:f5c4:b81b with SMTP id
 ffacd0b85a97d-3a35c83915fmr3580179f8f.23.1747406877576; 
 Fri, 16 May 2025 07:47:57 -0700 (PDT)
Received: from [10.61.1.248] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1c6sm3080519f8f.2.2025.05.16.07.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 07:47:57 -0700 (PDT)
Message-ID: <002caade-699e-4128-ac08-7797b83b3cc8@linaro.org>
Date: Fri, 16 May 2025 15:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 thuth@redhat.com, berrange@redhat.com
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20250512144629.182340-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512144629.182340-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 12/5/25 16:45, Gustavo Romero wrote:
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   MAINTAINERS                                  |  5 ++
>   tests/functional/meson.build                 |  1 +
>   tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
>   3 files changed, 80 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..9ebb768214 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2065,6 +2065,11 @@ S: Supported
>   F: include/hw/pci/pcie_doe.h
>   F: hw/pci/pcie_doe.c
>   
> +ARM PCI Hotplug
> +M: Gustavo Romero <gustavo.romero@linaro.org>

As mentioned in v2, since this might interest ARM contributors:

    L: qemu-arm@nongnu.org

> +S: Supported
> +F: tests/functional/test_aarch64_hotplug_pci.py


