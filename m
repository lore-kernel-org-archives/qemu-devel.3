Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF2EC41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOF5n-0004VT-W0; Mon, 01 Jul 2024 07:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF5m-0004S8-Pc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:21:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF5g-0004gd-NK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:21:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42565697036so23016735e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719832859; x=1720437659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dtvFfJZHexqAYaBJ9JwSErcs6iFCF0Sl9aNGrfPcKtk=;
 b=C+rBT40yhAPRakS5EHiiFj3x2wg5kRUJx6GP1jZzIK2LQzd5bbocPldZ42mVsBfHFj
 yuvKEZhbezwLjoHm0gisQcNPD4bETqNdGjLw69zspUU89M9kCnNfP2/nBuoPLnNmXGoY
 90Ncj+YA4b/DZjA2Cx4A4cE6CtYkkCN5be5zbt8uSA+COAht5JrrLwyaMq1/Bv1mY2Rl
 KQAQlAfIzvxW+ZB3Akwdoq6eti6rY70eMJOskTkPZbnBBnhHe6wqInrUI+0bDyvz5JZc
 lZ9uhJTGSR42heD+3M9rURwbk6tBX+acVw46CvFdvN3ZyZ4jFzOhI0XqcJRp2hXNuhvk
 OtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719832859; x=1720437659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dtvFfJZHexqAYaBJ9JwSErcs6iFCF0Sl9aNGrfPcKtk=;
 b=wMdyRtquxbCooRqvYrEcE6efJhL3oXGf8vGpSqOepxbCzUskbOWV+MOzZ8R2dorJWz
 X6FEQ8dPLIsVleBbHwjDz6JboyoFr66GFkG6+5s41cuEYLig45xdYiyNMGJr0XeDOkgz
 5fiGeI7x85To8iShqPAKMk8hx4Y0cyL10XCvBrsK1qaHz0c2UIA6m3YzLAxJ30IgMD35
 LLoC2ZiGl2JwxDzWr6ClKS/JvuuKbxM06vv/6OT+mUu2kLpbDz3eG9v3KIERI7toU+SM
 UiDIenuqDC/ZXnPs3bwyMJxFDqowvBSXgLodd9pNMbPJqo5N3dCSdmCb47I34ipitMis
 WMEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWH8HzxkuJCNmm+5x1sT8CYR6dizS+SEqxzAZ2s7343BNN7wMx6KSJ2SP15CQ9kcP9HuHg6mTC01s3GmdwWD1F8qAVHMQ=
X-Gm-Message-State: AOJu0YzvZaMqPtty3Q06PAg6gH63gyWCpHpiLvDgYpCymhfWgkSTlP4k
 5zGW0DIu+MNpMDAyWkUHkBh1I1meqxXrj06uVnx6obkTLeYK0Ygob+yZXQoEJ3RJNasCT9omCmG
 o
X-Google-Smtp-Source: AGHT+IEckQfZYwEUvPxfaPbjlVBnM8WWKbMDAfRvS7dv8DBSU2I2Kx7vzmKPSbhSzFEvEb4Nd/7tyA==
X-Received: by 2002:a05:600c:3b88:b0:424:8acb:7d53 with SMTP id
 5b1f17b1804b1-4257984deb1mr49838445e9.1.1719832859062; 
 Mon, 01 Jul 2024 04:20:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c2afsm151018005e9.2.2024.07.01.04.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 04:20:58 -0700 (PDT)
Message-ID: <9bc15a96-8717-4c3d-b418-934a6e13f06c@linaro.org>
Date: Mon, 1 Jul 2024 13:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] hw/ppc: remove obsolete manual deprecation
 reason string of spapr machines
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
 <20240620165742.1711389-13-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> The automatic deprecation mechanism introduced in the preceeding patches
> will mark every spapr machine upto and including 2.12 as deprecated. As
> such we can revert the manually added deprecation which was a subset:
> 
>    commit 1392617d35765d5d912625fbb5cab1ffbed8e140
>    Author: Cédric Le Goater <clg@kaod.org>
>    Date:   Tue Jan 23 16:37:02 2024 +1000
> 
>      spapr: Tag pseries-2.1 - 2.11 machines as deprecated
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/ppc/spapr.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


