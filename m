Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266E0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 08:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLBd-0001Ai-5g; Fri, 09 Aug 2024 04:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLBc-0001AE-1h
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:41:24 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLBa-000240-9V
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 04:41:23 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef1c12ae23so18114991fa.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723192880; x=1723797680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rLRmzR6QHUMpm5wRbsBUblbVL2vSdCxkjV4kebc3ElE=;
 b=hBv8Ae33P8PDkU2UYX2wjM378p0jJpw6VtyKGnOTcOVvjYANkqqnz3Q9fVN/Y2LRuF
 D64cptpIa9hsbV5uCO+QCHA7cti1tHefd/P7uAsSlpEOGg4gNoffgKLYK3J9h/ciNuf+
 y1b82D8Ku2Mg6DYqyduLiLZ6/Oeu9Q2NgqE5agtYPn7nvR0af8W5xsBargO3NIsZrcde
 YFRbNmOZRRCY21UFM2by79xp4zImJf+lXftiflSY0uRGlHPTfwd/R4tPga/xUGptxyfS
 nACZGuSyu8oYyXSlPd4syWe+vGCUdSijVn99Hprfqx0wd3/V+HFJzKRYUJ/UabG/IABw
 NcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723192880; x=1723797680;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLRmzR6QHUMpm5wRbsBUblbVL2vSdCxkjV4kebc3ElE=;
 b=lFw/GzUPI08ZmcpWpzHg/EOZCqAhVRzB+GhfNMLVWxW58l1jQ+F5l1kOOX+CdThEnX
 YaCAqiTOal51OJaXjSJl82tFXgt0DPoLdpcCzKWPzxDq93E6/vKqawlFFq3NoePN4jQB
 bnvDq2Sepuw7XHiz0Fo7cMDRg0g+aB2qcXPSshU68Kh2ykhT0fzkxNhBcKZrq4VS1JLN
 fLXAIbtFT2+0Jy7qtHxEcDQAeu6m4IchSJx8igfEwD/GeKZbuGE0VUBWQwahZtvesBYo
 C2QfA4SF7be0nuPtIPn2e+a0ovsJk2d7wWY9HNqZ2KzIzWOqtCm2Der2DP4wrqN+5rvd
 49gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZe77YjYJpnLEn5Da+uuk+S/zJV1TdwZleqc+nZRyrigxkhbKpUGbsZmhtKp7MHRanNAD+D3Jg1dJdW1M569tYLhzfPcw=
X-Gm-Message-State: AOJu0YyoeP20kIKSk2tfYSSxlEy4QVYSHJ0a2SThfczownrsYhjslK54
 fBBUd/vJt+6vsHV3jk/t3KRUAAk2tIWFx2KFTT1J0Uva69QKNoDq4Z3r0zrLTUs=
X-Google-Smtp-Source: AGHT+IFWgpGGrq/PhhF81FKDJGK2T2hXmoISQE8H46zL1wzee8Q2GKwde0ynqe9Xi1GFJC3q+pEI2Q==
X-Received: by 2002:a2e:9450:0:b0:2ef:2344:deec with SMTP id
 38308e7fff4ca-2f1a6d6ee7amr7013781fa.45.1723192879955; 
 Fri, 09 Aug 2024 01:41:19 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c74ff9fsm65213855e9.28.2024.08.09.01.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 01:41:19 -0700 (PDT)
Message-ID: <7c5d7418-b59c-42be-a98d-b36a7838f744@linaro.org>
Date: Fri, 9 Aug 2024 10:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] qapi/pci: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 jiri@resnulli.us, jsnow@redhat.com
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-6-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240808182636.3657537-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 8/8/24 20:26, Markus Armbruster wrote:
> Since we neglect to document a member of PciMemoryRegion, its
> description in the QEMU QMP Reference manual is "Not documented".  Fix
> that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/pci.json    | 2 ++
>   qapi/pragma.json | 1 -
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


