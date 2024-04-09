Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A2ACD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCsN-0007Cu-Iy; Tue, 09 Apr 2024 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCsL-0007CO-M7
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:55:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruCsI-0005AX-B8
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:55:05 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a51d3193e54so277041566b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712674500; x=1713279300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JIxBlNMLeeTCPRzSysq7IW094RmXyUXJNyrOnI9eXo=;
 b=P+H0Kuf9DjieJZfrJVQM53qstwTW2Qd0AwdGWMiSIWyNK5f2tjlQ8S1bkCGgEwIOqk
 bMRqTEFU72K4IAyPv9+NAL50a1wYpnf4dsbtOKOgyN4uQxrBYdPF16CYGxnG+inBxcFK
 5q05fOnuB+o0nBiUpJ/zaWsx15w2tRXKzoBperSgTIIocW7VmJVUDYRFOEh5a5FYFEq1
 qFB2Uk2K+hJlXeRVvxr6I0+4onLkp044yJnREuFoZVCRdC+xKvykytpcxaUcQfq3ZX6f
 N4zlEJ/zRKpZO+F1ii0FhZh62GyPHBJD+HX8HC4iHYOP3KTQAY19KS4tZq5mEikanI1V
 +zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712674500; x=1713279300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JIxBlNMLeeTCPRzSysq7IW094RmXyUXJNyrOnI9eXo=;
 b=P4gQJ53iUqSdAjiOjwlKn1KKcFGhSd522txlQTg6gHdy5PfXGBsh1XrEkGIz+plRXK
 2M2d0uiEdEpt9a/j69lQPi0lhd7izorXkGPnSPbh0xLEDSZTCfE3hnFtqNisLGF3fp2Z
 0lY4jWthlhy3UIiomm81UlKbg8Y0ICxtW/ji+NgXOhvGzkagpNaPOpWzIWCvzgd8LhYD
 2HjQ22vlz2G3XodmelsiFzki4VrlCigq7BTg4PuKAKKFwIEIz2knWvbxR5CQVwa6mx0p
 P9bJMgpASiDHT70Ka/PHpFPQbToIuDkdEFyhd4817iFlXxFSJdEtf9I5ahD2uk4NORDG
 Hk3g==
X-Gm-Message-State: AOJu0Yz+4gjAknxcUrbfGOjdrP6qQXnm6kc7wm30LJji+mlEGsFDE6/s
 ozEYoEdnterAyrrfYkaXWYTUs4PAX7FXUk6922AISVmvLnkfy5YabOB34yre0aU=
X-Google-Smtp-Source: AGHT+IHqydUO+5x+SuQrN0Sz8bGLQAO1zxyNxYs34gl53T3RA5Z8UD3UPYasMMyu3e/DVo5u3xNp3w==
X-Received: by 2002:a17:906:b7c4:b0:a52:1be:f4a6 with SMTP id
 fy4-20020a170906b7c400b00a5201bef4a6mr492986ejb.21.1712674499799; 
 Tue, 09 Apr 2024 07:54:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 ao11-20020a170907358b00b00a51aa517076sm5398938ejc.74.2024.04.09.07.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 07:54:59 -0700 (PDT)
Message-ID: <3d27eb80-8274-4745-a7c6-c746b7c49bcb@linaro.org>
Date: Tue, 9 Apr 2024 16:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] hw/sd/sdhci: Discard excess of data written to
 Buffer Data Port register
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Bin Meng <bin.meng@windriver.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
References: <20240404085549.16987-1-philmd@linaro.org>
 <CAFEAcA-nrJc_WqTgw2uugqKoOdfoF8-NiKwftZczk38_XR5_CQ@mail.gmail.com>
 <CAFEAcA9iLiv1XGTGKeopgMa8Y9+8kvptvsb8z2OBeuy+5=NUfg@mail.gmail.com>
 <CAFEAcA_A54DX2VHCq=GPjaJrG+V_UJrsvvZq6RafgHutwMOtsQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_A54DX2VHCq=GPjaJrG+V_UJrsvvZq6RafgHutwMOtsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/24 13:35, Peter Maydell wrote:
> On Mon, 8 Apr 2024 at 17:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>> So another approach here would be...
> 
> That said, this is all quite complicated looking, so
> for 9.0 and backports at least this patch is fine.

Your patch looks like the correct fix, and doesn't seem that
complicated (nor hard to backport), so I'll send a v2 in case.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM


