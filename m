Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D4E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK3T-0006xI-TN; Thu, 19 Dec 2024 12:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK3S-0006wv-8f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:11:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK3Q-0005j1-QO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:11:18 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862d161947so522122f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628274; x=1735233074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBkyLcSf+GGjx0/wEp5sNI3G9o82r4z7VP+tvGX1FFs=;
 b=Sss2Bpi+0Wn58C3sQDLb80mUhdTRog4wDS+lIe3er7Jj6Mx71bigIzqTZKVJxu6NQI
 IXKY4zyiJUALW3VeXYK8qBd5NPGVEG334Qrz+/lVHsoHQGqcue+ZebNEJ2boykv+4TYS
 xIZ0p/+nQBHIEEJHNRiWP/OqmzKnRIuTrQ2C4ZUoO2Wo1m+h9jToSPG8NTPNHJShAaK0
 umIN0+DHK8nfkPO7epIueeK5wJG52dj9rZc19v1irJQBUErNs+1Zyx0bHRzjpi/2u216
 raGYWAhakGBiXx6flT42MF3Pn9yculeGil9d4YmK9nS/6ih+2Ti5tGEbWD8JtIMlrHNH
 qzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628274; x=1735233074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBkyLcSf+GGjx0/wEp5sNI3G9o82r4z7VP+tvGX1FFs=;
 b=QL1AWlpNfUG8rIkXT7JC2aiQ90id5z+VmHJGpv4YbEFNeDQBVM2YdDi6xQov56UR8Z
 mS10Vu33GMMYlbAxuexqD+pyUqFq10aBG866iqxSOkZzpt7ABmixHWSjvecBUH2nBElP
 58u0F2BRI9hB3HMi8wzDf3mnYHpbLcIJrMLQdBZf9rUIoeFzTN4ASoxBWkYUhbTPTh8e
 V4fRaUne6QtJdwcgWmaxK4pHxrb3vvKNBlZkIo+jxnuky0POOy6vrEwwL+l5c2HPvWHc
 piTYS0wPqZ7qS1JXlFYdPXaqT0/Hy40ihysVdKpUGmmloOnED7MCpbNX/j+7f5DlRy1M
 X//A==
X-Gm-Message-State: AOJu0YxhEXWOyfazAN/ZvZXP5+FLEsEJ0bpJ9UE4mO1ChNcG8ZhXja5Y
 T7WgDOUkkmiLtjXkEDPNTMyg6L3MLSTREqYzU9K8HRSdILGSGhbCfG4/EGS+VgL8cU/SekdNqzm
 7
X-Gm-Gg: ASbGncswZ/g24anP9WV4N2sJXLdTtw16TbYKjDfAqj59Nd3TUuU2iMQzUn8X+TqvrKS
 XmUzRKb2lizxT/JXIiUn9e84CjWe6yjgkwa/1uqdBqKyWW+JcN+5BYlqRgpPwrtmS96MLQ+GkbU
 n7CXR9sXk7fE5+paPf6nTNnvm/lqclcLnzl6jYWfcFYnDOCcx5cxxve4mlSXYgq+XD2Gj9SU+p+
 euUqR1/NVyW7JMLTfUKlQeQVPlPFyTG745wP1uqNd8/6sgqMEuwaElc3MyhK66ia79KGwE=
X-Google-Smtp-Source: AGHT+IHpT4Cngp0M8WEaFs5xmzjkRHwEThdLD+vf8y+j4IJr4Ju/MTBQiPksoiGJOn+hCcIMUHT/9Q==
X-Received: by 2002:a5d:5846:0:b0:385:f417:ee3d with SMTP id
 ffacd0b85a97d-388e4d86e8amr7323979f8f.35.1734628274513; 
 Thu, 19 Dec 2024 09:11:14 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6c5bsm56868735e9.2.2024.12.19.09.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:11:14 -0800 (PST)
Message-ID: <7f4b7cc0-a012-4243-a3bc-c678688f5ece@linaro.org>
Date: Thu, 19 Dec 2024 18:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] include: Cleanups around 'exec/cpu-common.h' header
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
References: <20241217151305.29196-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241217151305.29196-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 17/12/24 16:13, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/xen: Remove unnecessary 'exec/cpu-common.h' header
>    system/numa: Remove unnecessary 'exec/cpu-common.h' header
>    system/accel-ops: Remove unnecessary 'exec/cpu-common.h' header

Series queued.


