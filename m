Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB1C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGwy-0002Bm-9S; Thu, 07 Mar 2024 11:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riGwm-0001WZ-GL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:50:22 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riGwb-0002y9-Q4
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:50:20 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5135486cfccso1210923e87.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709830207; x=1710435007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1I46XS+O1jQxKPl+LOAjTnF0s4MIyjTZwxpWLE4Enkg=;
 b=qSbPzbLqQEzZAd0XmZ4Dy8iBAMzyRCTEUSbT4lK8o06fl+CyynmDrYYkyrhULp3CZ1
 WrGmExHdhpNIoCr16NTIrOIB3R1vRmGRJbnONO1gU6rsdPDc9+p2SYkoFGQey1hhrMcD
 k83Gl3H6X0H1o2wJnS/NjFCMsfzRjqubspsUGbFc6H03HwxsZhe1VPHbPRGnx6Xx7lrn
 BriiFwHderjbPwoDqOoN+1A6tZ8JcTmDPeKV0A9/ZOo0wuX6gsWVQyqiSH9vkLFXv0xF
 8c27ddxDU8KWXrO9fl6vPyVjTqDuTX2PZ9bYIiCmZzxgVbC+wo1BQFQpp81iHn7ca7Rv
 iXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709830207; x=1710435007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1I46XS+O1jQxKPl+LOAjTnF0s4MIyjTZwxpWLE4Enkg=;
 b=arE8QKypsTG6ypJg6gBxbfhMIgYaDe213Br0Vv9QmrjiHZCB+rBKmPZo0qfbAKh8F8
 5/qSmmKcstzkOWQnDVtnYBcknz1LmEiYm/jL7S5LRdPxq08PPqr8/5Dha1403HrtHAu9
 TG/zOsj2FCd5zH/Ae7Kr6PBdLDbLP67FvqlowzM5tuxDWdZuA7tdaSitcwzxPSEZsvQa
 T6pkN7YOeKfAq+/a++rLYtk9r7XOYexcNvjqYKMejEV3EI6IixLsxgm3cr3248J4lrRg
 fn1pkEZuPxp6mp3fKi4BHXcIc6vkvOqC7c6A3Vg5L5FV9u3bfeQHDb90EmNyPNY3yH7P
 MTZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr4Xc+/snTdNOMQ+28dD1yMYmdQtRjUMN+HhfRxtKJgaxMNGc9EBpSnGOAUJu22BNmAMYDlpI1rkmadT6xZiFnHm7wrgE=
X-Gm-Message-State: AOJu0YwP+tVGyOnnneRAOXs0/OHirbviTrL5EIRya6vciQ6TM7oAuFre
 ivrDD8iZYGT8W42zvQTJZ+fifQ9hY/rmaQrcF6g3grRKN5qCxh9bzrtYIxk1bDs=
X-Google-Smtp-Source: AGHT+IGYTTxN/obWy5zRo+X5ts6U7agdd3tXwDsLVE3mD4/cWliSdjB/4DqLWechMUwRAEur6bQsCg==
X-Received: by 2002:ac2:4284:0:b0:513:58c7:371f with SMTP id
 m4-20020ac24284000000b0051358c7371fmr1734270lfh.65.1709830207158; 
 Thu, 07 Mar 2024 08:50:07 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c444c00b004129ed6f9cbsm3269016wmn.4.2024.03.07.08.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 08:50:06 -0800 (PST)
Message-ID: <7561cc84-baf0-4185-90f4-43cb2246dc8a@linaro.org>
Date: Thu, 7 Mar 2024 17:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] physmem: Reduce local variable scope in
 flatview_read/write_continue()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: linuxarm@huawei.com
References: <20240307153710.30907-1-Jonathan.Cameron@huawei.com>
 <20240307153710.30907-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307153710.30907-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 7/3/24 16:37, Jonathan Cameron wrote:
> Precursor to factoring out the inner loops for reuse.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Picked up tag from Peter.
>   system/physmem.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Nice finding. Similar pattern in system/memory_ldst.c.inc.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


