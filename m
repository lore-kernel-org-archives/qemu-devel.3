Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BE8C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJ9m-0002yc-Sn; Mon, 01 Jul 2024 11:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOJ9k-0002xZ-Ra
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:41:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOJ9j-00043b-6P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:41:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso22005775e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719848485; x=1720453285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kTQuvoIZa1mgjjqs6UtPeKi9vZn2qkQVlR2uigkLyY=;
 b=r836cz4nr20pU9wjDTiqYa0E2G29Z5T/2cBNCVBE4qNaX058/deBl1yID7acC3FZPS
 JQHwwgTE5Xd2nfwz59P/YwJDLKUNd9wbkBfAg7yQvxVUEm0x/35kq7v7uWXOYBgzpwbf
 nGURD1r5Ojp9sh0o9sbRpD2kiPunSfZAxzzK20t0iwGBNm2fw+etFz/PIEouCdw7DpYC
 ftl3ImcUtLh6NnzYbk3E+3lh0b8S3XwmJU230+E9kZs08Nds0o6cGH6/JYBCkabMeoHy
 5CG/1jRXUTUud/yq7mLBq0DrBsbXtPwb+P+tY2a3tfLHWoO4Xx9rLywIbQT954cddKu3
 nG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719848485; x=1720453285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kTQuvoIZa1mgjjqs6UtPeKi9vZn2qkQVlR2uigkLyY=;
 b=tlDC4GFxxgMjJxkVMRvxPNLOkElkCzkwd8sp5Cc0OyLvCdIP64eFCF/Sx8wQvKQWLr
 /DE6b1m9mvnT/3bBNwB4K3eaBkdNDnCtDR4MhgyKm4ZOF36ChFvHoIhoBKokzzbf4aE4
 6jxmeZ1omrhHbPSl8Yw7NUBfRfotzSd437ZT9bZ8uBdc7r1o7stTGVSIPn46pZhPVYBp
 6D3NgFefmIXhFkGGAotv0HAEXD/LKr/Jh2tKJTXeK09YDI606NhDm6zaPIqjsS/TD5ny
 AjMQO21e4JAzKz0E7m1iFBoUAUFoSCEDzZPMdNLpaqacPEEwy2bsVbwJCqgrA70e5114
 yCvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTch4Eu0OcVIQdccLYQjpbrwGNQ9K+g/clXz46m16tuDsGa5dsz+AxXGqw+smGs/3BHCmf65EEHdZD3rN7kpy8gRBQgfM=
X-Gm-Message-State: AOJu0Yytk3/izKbnIoGmtq9sNmnBlnyRAZg59V+ETNIGeV4aUfoIExTa
 5Zin5rlfQcgfZN+6G33OHOzgMYMzfLBaFeW5meQzO0a/J09pmsLixncjt2pi760=
X-Google-Smtp-Source: AGHT+IEpE0Ercv2rLbcg/nb+THB3MX/K6pRwicaWhPHIh1I39kR3h8gNWdJ1j1agig9idyEWvEipfQ==
X-Received: by 2002:a05:600c:4f52:b0:424:ad14:6b87 with SMTP id
 5b1f17b1804b1-4257a02d548mr40466625e9.4.1719848485556; 
 Mon, 01 Jul 2024 08:41:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55e61sm157499465e9.20.2024.07.01.08.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:41:25 -0700 (PDT)
Message-ID: <078a21d4-0025-4545-a9e2-f945eafe57ae@linaro.org>
Date: Mon, 1 Jul 2024 17:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hw: define and enforce a standard lifecycle for
 versioned machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:

> Daniel P. Berrangé (14):
>    include/hw: add helpers for defining versioned machine types
>    hw/arm: convert 'virt' machine definitions to use new macros
>    hw/s390x: convert 'ccw' machine definitions to use new macros
>    hw/ppc: convert 'spapr' machine definitions to use new macros
>    hw/m68k: convert 'virt' machine definitions to use new macros
>    hw/i386: convert 'i440fx' machine definitions to use new macros
>    hw/i386: convert 'q35' machine definitions to use new macros
>    include/hw: add macros for deprecation & removal of versioned machines
>    include/hw: temporarily disable deletion of versioned machine types
>    hw: set deprecation info for all versioned machine types
>    hw: skip registration of outdated versioned machine types
>    hw/ppc: remove obsolete manual deprecation reason string of spapr
>      machines
>    hw/i386: remove obsolete manual deprecation reason string of i440fx
>      machines
>    docs: document special exception for machine type deprecation &
>      removal

Series queued, thanks!

