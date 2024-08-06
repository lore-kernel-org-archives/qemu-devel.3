Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F84C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFUO-0006LR-Ni; Tue, 06 Aug 2024 04:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFUL-0006Jg-8j
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:24:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFUJ-0002Js-OU
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:24:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so3275785e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722932649; x=1723537449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1NqOcFNHbhT1NGjqswedMfmrLNO9L7Y0/lHhZXRg3E=;
 b=Dau/NImbcQVs1Ik9ZJwBwJ5XOVQlqgBr09AW20HUy82jVLCZZEI69HmWvB0npuMrHY
 IC5djOmM1T50Vyhj2su/jcJ12rrjcydge1pDtpXi7HJJi2UORMxKfim5+BHetAiOLiqA
 Y+HHRjyzw8aDMpXfptttrFLt5bMzDBDlwinvpfKf3kOTtZvsLgnoV8Mhr6jgFOOD19C8
 Uwhq66eMHn6ihF4An5vWfxKiX+jf5AR4ktq5+AlFf0TVnehSh/3nnNJsZ1GaWXgWsGoz
 vg4qPaooHM9t05H88ipJsGUFEjmaA7mCN9okznv/XVoTxFUiD7MrqBq0v2poVQVNA37+
 438Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722932649; x=1723537449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1NqOcFNHbhT1NGjqswedMfmrLNO9L7Y0/lHhZXRg3E=;
 b=vivbiDgWc42rjdTcadIzICwfhnmU2QjN2nfUsxI+I1hYw6bNtC8U9bgBRbbFKQi6X/
 86HCRYEN8BFmTLFeXig5+v8HJcOMlt481S6p+xoErYnQH+MPCxo+0TJYxzPckqlb5mJs
 DZ9AzfFFsaW2eXD3D+TaiYlJem8RG3M7RnJ4zqTkWIXZmfH47g1rQnBSGEMWC+J2lvqY
 WQM8EKjN2kehy/EUb9y1POUgigc+k+UKS+nd4DdEMcmD/11RzxH6dYqZz0pn7D1L8vdL
 XW6bjAPD2O5Vd/oLF6xscCMBBCfNLh+xBUmx/p0wTTJJenFMt00BrHpz83VS0Cs33emS
 Qugg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf/J55STIpkir6rpRmoFeVcxWmxIJq0vT9EIqF5iNwH+SYFXU6I6LwWO5NPEYaT5gRBLuxfI5+CAFmw2tocomKbTs5eW4=
X-Gm-Message-State: AOJu0Yw9cvZR0muJoVwKsLM4ha0BEX2y/daQAD7AwVPLQBaXQdae6D5f
 Gl1f5LRsxf3rD8TUFP9wRwJvkxL3QV1Hmkhf2A8QOsbc7xezj77u3nl/ImqzKYY=
X-Google-Smtp-Source: AGHT+IE85dyjSACDuCcfd23rwGWQsG6GELE40MVP5IPQzH+r48f6Xw4yi9yR8PEQ/jLZ6gQQtWLhCA==
X-Received: by 2002:a05:600c:46d5:b0:428:e820:37b6 with SMTP id
 5b1f17b1804b1-428e8203ceamr111506105e9.31.1722932649139; 
 Tue, 06 Aug 2024 01:24:09 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89aa9esm230608915e9.2.2024.08.06.01.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 01:24:08 -0700 (PDT)
Message-ID: <0da52473-5bef-4858-a482-590ad2d04f20@linaro.org>
Date: Tue, 6 Aug 2024 10:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/specs/pci-ids: Add missing devices
To: George Matsumura <gorg@gorgnet.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240805031012.16547-2-gorg@gorgnet.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240805031012.16547-2-gorg@gorgnet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/8/24 05:10, George Matsumura via wrote:
> Add the missing devices 1b36:000c (PCIe root port) and 1b36:000e
> (PCIe-to-PCI bridge).
> 
> Signed-off-by: George Matsumura <gorg@gorgnet.net>
> ---
>   docs/specs/pci-ids.rst | 4 ++++
>   1 file changed, 4 insertions(+)

Patches 1 & 2 queued, thanks George.


