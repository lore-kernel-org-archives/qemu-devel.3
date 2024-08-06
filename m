Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B67C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 21:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbRQf-0007u3-Aq; Tue, 06 Aug 2024 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbRQd-0007tT-On
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 17:09:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbRQb-0003Cp-OS
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 17:09:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70eb0ae23e4so872871b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722978548; x=1723583348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wbcMjFSXScyn2wq67zwS+i0sNqFv9/i5pxZ7pBeW4OI=;
 b=pLwCHL/61JuhyBIhNHEaZ3NG5eOAF/Y4Vil2aJnHSpz93i7ZhFsOcePIgXP3v6upc5
 dw9IiChWi6ADGr3CYDpayYTg+uNwleC3aHpKYdbuHaWj6fbUFfFy7Unc9Ulz7JyLjSsm
 DrhisHp5imPtm4CfYLMwmkN/uUxdy6AMrAd2PyAtqYGkFSHqQCXj9nr+Ph08JW+v2HXq
 ge5SIAXT9vhXjN8WIe8SI+ZAFi3Krhm/gYNkJI1rgoHmH0Kc4GyGQqapdaVn0aMpsE5L
 /T5684faGiGGH1k6cqVgYZzgji3VGSQyGiDjWKm41SFS12arBlRgngYEPaxZ3UrJZBlk
 d1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722978548; x=1723583348;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wbcMjFSXScyn2wq67zwS+i0sNqFv9/i5pxZ7pBeW4OI=;
 b=bs+HIvYf9pp01QxBOJ6/9gY0o8vQ+hgSAJB4alAQ+BrPHqmJzwxPtdbC7UptJw+rJI
 oxnVXo2jRFQJeKNyAOEVhils/kVVdqz9EIEd5hZwKsn0aqgmYdYs7MSC7VGvBLpZHrc1
 A5DPJXWbXWFWLGN88OIzvPvKugWw4EiR3EKRLOjrMg6+JroETx3jLLADTJDy9CKbl7XG
 vHtXy2ABJL82CkwqCh1hapFqI7IL+xty97PDSy/JRJIocVZkaIsmrJ/8MXnpUzo5xa74
 Ov1+191J/wzcS+MYUCGIlIADtjxmcLbg20JCXcRXkZzQuRsqzenWHlEzSQGoTsf41AFP
 sn7A==
X-Gm-Message-State: AOJu0YwwGB/Tjfvwv1mm4Vify9L6xUCoUTz+iWfjtnSEenP/UXzBtzca
 xRpCUf00ga0ZlXXKcdx268WgxAnjchZLzPeaa7atZ1MnAytwt5Odbx2P50n80S9lWVcy0GBGZ1v
 ExSc=
X-Google-Smtp-Source: AGHT+IFN+Ittwt+Wdmmp+bojlvdh9csycQwZUYujshzvBsoUUxa2Z16U5L8fVSGInS4po2DrpiW0vQ==
X-Received: by 2002:a05:6a00:918d:b0:70e:a4ef:e5c2 with SMTP id
 d2e1a72fcca58-7106cfce31fmr14763759b3a.13.1722978547619; 
 Tue, 06 Aug 2024 14:09:07 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed151basm7343849b3a.169.2024.08.06.14.09.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 14:09:06 -0700 (PDT)
Message-ID: <ba8db6bb-cc9b-4c79-9f81-7dbf3ad8ba75@linaro.org>
Date: Wed, 7 Aug 2024 07:08:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] Misc HW & UI patches for 2024-08-06
To: qemu-devel@nongnu.org
References: <20240806125157.91185-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/6/24 22:51, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Bigger PR than I expected for RC2, but unfortunately
> the LoongArch Virt is broken so requires these patches
> (it took me long to figure all the issues with them).
> 
> The following changes since commit e7207a9971dd41618b407030902b0b2256deb664:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2024-08-06 08:02:34 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20240806
> 
> for you to fetch changes up to e006f0186bff4c66d3dd7a34e08fdae81d606480:
> 
>    docs/specs/pci-ids: Fix markup (2024-08-06 10:22:52 +0200)
> 
> ----------------------------------------------------------------
> Misc HW & UI patches
> 
> - Replace Loongson IPI with LoongArch IPI on LoongArch Virt machine (Bibo)
> - SD card: Do not abort when reading DAT lines on invalid cmd state (Phil)
> - SDHCI: Reset @data_count index on invalid ADMA transfers (Phil)
> - Don't decrement PFlash counter below 0 (Peter)
> - Explicit a 8bit truncate on IDE ATAPI (Peter)
> - Silent Coverity warning in ISA FDC (Peter)
> - Remove dead code in PCI IDE bmdma_prepare_buf (Peter)
> - Improve OpenGL and related display error messages (Peter)
> - Set PCI base address register write mask on GC64120 host bridge (Phil)
> - List PCIe Root Port and PCIe-to-PCI bridge in QEMU PCI IDs list (George)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

