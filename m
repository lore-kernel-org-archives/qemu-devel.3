Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1931BC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMJX-0002FA-Uz; Wed, 13 Mar 2024 06:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMJH-0001ef-Ub
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:58:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMJE-0007Ue-17
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:58:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41332865b05so9661965e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327486; x=1710932286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bvpyc22xhhjpfwJ5rVRosnAeTUuTIeCxzuZ5/SO80mE=;
 b=r5uGwCd9UMp4mxlrXcBZiyEvXr6xaylcZeptKC+AhztR4b0mgoZkjV0sruUEEz/LRp
 bEep2jPHoVrchJ7n0x+tFgniLMgpiRuWJRxNHUn8hRyA629yivyBamRNwarGaHtrGctu
 3sKxLBbd+bPbhYWX+xAy3iYMnkulgDm+nzVk00UJzSSM8/tbsjK7wVx672ZtAJEw2+2u
 sbAvQRLRgv4T1gz1DEEPvc3pFtkDHyLWbz7qpm89MZCQAFJ4lB+tZOjeRwpnUiL6wa6f
 pEjgOgD8IoAXYY4ipvr9uKFlkQac7FOiqIg76A/x0DLEcncelhKtn5r/1P+LV/j+LNnM
 bahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327486; x=1710932286;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvpyc22xhhjpfwJ5rVRosnAeTUuTIeCxzuZ5/SO80mE=;
 b=hjPChtzeeZmmxa/qeQEHCwJNZltLKSNv5GYwVXPDUN+ODUBTmgZORA22JB/zNn+7V+
 NdPqpKM5o6oGHxnT88KvLNUKQMjwBnjbzy7QmWlxLHmc0OlvVmAtZt1ELZ0F8tbY35fh
 JUcgt5CYKl2f1NIwjvhy2foGuV+WYfnE5tEl9LfZsxMBBRqTbMuRWkNoJSvhu7iwkxW9
 uuDHI5+gi58mA8tg4VXAKYKMmiXJf2s/NdgyT7oJrVNBZQPkKIbGaXGETzptN2/YUw6E
 3VfmP327qMXYQBsxfoJdC7SE6/4isKXE9xscMilJVBsfR3bobzgfmF913nF9mNfsBosx
 6WuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPmaley7ijPosoGnOxEvhMHaNWWuQo1F8I5nXqVDEjpkwYecvVrLL0z9oTPTCrihgY3XbSNx2Y/ny/oFUvwp5iYgyt+t8=
X-Gm-Message-State: AOJu0YymJ/hFT3ndMQhJbxOUullI0zeJmDc1XSvTZyIkHHZ5fLEWvErz
 FdGgB1/vBLNLOdF6ZJUJMwOJOObYBdJaTALSKnJiGAsCrBKnxNc1WaKuvFwEuaY=
X-Google-Smtp-Source: AGHT+IHiwukxEptP3bIl6BnMPoaunQ9CiGjR59ed3TCv2vKnE4y2oADqtpenLGXgBvP0b4ewkWOy2Q==
X-Received: by 2002:a05:600c:1d99:b0:413:ebf7:6403 with SMTP id
 p25-20020a05600c1d9900b00413ebf76403mr447043wms.23.1710327486325; 
 Wed, 13 Mar 2024 03:58:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b00412cfdc41f7sm1441780wms.0.2024.03.13.03.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:58:05 -0700 (PDT)
Message-ID: <acf36be0-b7ab-413f-9cf5-893d3a19cafd@linaro.org>
Date: Wed, 13 Mar 2024 11:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] esp.c: move esp_set_phase() and esp_get_phase()
 towards the beginning of the file
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-13-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/3/24 09:58, Mark Cave-Ayland wrote:
> This allows these functions to be used earlier in the file without needing a
> separate forward declaration.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


