Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89653F43680
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDf1f-0005jK-CW; Fri, 17 Apr 2026 04:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDf1e-0005is-EJ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:58:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDf1c-0005K6-Q6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 04:58:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso5314485e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776416287; x=1777021087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFP3C4Yi06h2nN63khd3cz+ceImWWuencx5nv/LVR+Y=;
 b=BCAHmTkJouBrIngJgaAOeql0Ahz0w7pxwvZQtY3oHO7xG95wzSh2PkkU8KERxV0VUm
 9IYEem790vlZ3Ff48Hosm5YmIqx0kx04GtYy5dMXh2XOQl4d/gvbnMErXGTe4YcZ3sE4
 74oS+v7mzjPqLv0/3dyh1DA8Q9tZHlZ4SCrtVHQtd5Yv+HIPZH7weasoJWpeOFF87dMh
 /gwSZUh75+3ZjnDpugbPXpCIe4aZkkLArvChI8CFEZRNgyrHfGm+hju92rYwGbUcRuUc
 eE8/n/9sSHjt3h0s1if+yx+MRc9aWUFh8eY9CduzrFg0HGoDzho+nLrNeT/ncTR7eBaX
 TPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776416287; x=1777021087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFP3C4Yi06h2nN63khd3cz+ceImWWuencx5nv/LVR+Y=;
 b=Q6zK6hrwzslCfUjOAQzewZaArn/tKml9buRaDR8gb/jVesccMkWXTOEdJYdX9sf/Vq
 OW/JzZycTjo+wRS5F6VweKLkbJE9MDyJPhxtTb1uRqwmfR0aU5Lc1l2ze1vHYpZtEdEC
 5SpMEL/IXM0ixIwmVrgjXUMmz1jv1//cUkga5npnTeFfK/9D3NRdAEb3/nVEyjPIiMil
 2hfdVXF1N+nf14reWyCsm2bAx7znB4ZTxY5YmL0sWQ4n1u8I+cShSdHnvFM+Bq6AfXvQ
 LEpIvedNR8RsDwrVtpUZQ7iaEtLxLaTeOe83qC5ilKUGDd7goqmCgzNzIWHHw5jG+tau
 z8fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e3Iqv+RO8F3YvGNNrjfXMZqO1e0YeDF+X9J9WK1+Qx6AEVpb3OD1NEKDIlGTje8sb8y20SZqmPURI@nongnu.org
X-Gm-Message-State: AOJu0YwmtJJLNaVDndGvCdSQKzuvywy1n3D3LO+Cdy6c6emRucwIYxc8
 i7WXX7hIUilsYKBpjqOvINdQuWYptvVSK+5rYN2LWaDanlLplENV7rwojG7PDbH4QUg=
X-Gm-Gg: AeBDietvusuyl3A8LOUG1HNPDgk+oL4Gub5XX+xWUngAbI9fOzKWk87GIeH8Mwy08DM
 /xniV0zD2bBh58oDE6NZ5uNgGSGUeomrzDpDpxiYZ8Em4AUjgHqgVJtxxX5Dssw9dwdPhUzyZmj
 2f4U/GVMs0gj7H8ijbZbU1qhNsp7sO/9F1g5oCQjAUmR3DjpraJjQRLnzl7CJ/7XLOJ3Oe4upbQ
 /QPeYx8eAM8X77wNvFbZr77dV5Uw3JYBkZnODxqrdby7sgqc2UnohX7bh0xl1oLcoxVdHWLycjh
 MLexncdqeliYqRVx0Az88zCwLzqfPwvEW+BZK/0F3zsXrJRdAnu0rbQaXq2fHfPogr0NogpyTE6
 eiu6DIe2sYQ5/j2qOacDhyxx5/L6GU8szYpm7deluesbHrchFkf9toNhbrEDIhi5p3/3azkuvgg
 Tq0lM6IAfRIOwd0iyy2kzxjL8OvfJGYStRDkyO6q19xKGKuHzxXWzjCYn9s5y203SkJF4ZBX3yD
 2Zk
X-Received: by 2002:a05:600c:3110:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-488fb73841dmr25124515e9.3.1776416286943; 
 Fri, 17 Apr 2026 01:58:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7aa593sm12134895e9.24.2026.04.17.01.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:58:04 -0700 (PDT)
Message-ID: <a75dcca3-9cab-49e3-818c-4d52c2a1bdd6@linaro.org>
Date: Fri, 17 Apr 2026 10:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-11-peter.maydell@linaro.org>
 <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
 <02e21af2-d6e8-4418-9cab-af56c81afc27@phytium.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <02e21af2-d6e8-4418-9cab-af56c81afc27@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 18:07, Tao Tang wrote:
> 
> On 2026/4/16 19:28, Philippe Mathieu-Daudé wrote:
>> On 16/4/26 11:16, Peter Maydell wrote:
>>> Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
>>> respond to a query about whether they still wished to be listed in
>>> our MAINTAINERS file.  Remove them, on the assumption that they are
>>> no longer active in QEMU.
>>>
>>> This makes "PCIE DOE" orphan.
>>
>> Cc'ing Tao & Gustavo who are working on Security Protocol and Data Model
>> (SPDM) which IIUC use DOE.
> 
> 
> Thanks Philippe. DOE is indeed relevant to SPDM and RME-DA work we have 
> been looking at.

Commit 4f947b10d52 ("hw/nvme: Add SPDM over DOE support"), described as:

     Setup Data Object Exchange (DOE) as an extended capability for
     the NVME controller and connect SPDM to it (CMA) to it.

introduced the docs/specs/spdm.rst file which isn't maintained:

$ ./scripts/get_maintainer.pl -f docs/specs/spdm.rst
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

Would it make sense to move hw/pci/pcie_doe.* to the SPDM section
instead of orphanize them?

   SPDM
   M: Alistair Francis <alistair.francis@wdc.com>
   S: Maintained
   F: backends/spdm-socket.c
   F: include/system/spdm-socket.h

Added in Cc contributors who might be interested in being listed
as co-maintainer or reviewer ;)

> 
> I will help review changes in this area as they come up.
> 
> 
> Best regards,
> 
> Tao
> 
> 
>>
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>   MAINTAINERS | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 0b2adbc247..bc7c9b61da 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2160,8 +2160,7 @@ F: docs/specs/*pci*
>>>   F: docs/system/sriov.rst
>>>     PCIE DOE
>>> -M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
>>> -S: Supported
>>> +S: Orphan
>>>   F: include/hw/pci/pcie_doe.h
>>>   F: hw/pci/pcie_doe.c
> 


