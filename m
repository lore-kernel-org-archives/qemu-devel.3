Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D1C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWH9-0006KB-Ez; Tue, 18 Jun 2024 06:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWH7-0006Ic-8p
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:41:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWH5-0007zc-RF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:41:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4218314a6c7so45206435e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718707274; x=1719312074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3R+UjQl1RxIgS8AG7wIEPYsce5sJ3W4+fNsRtJtvYxo=;
 b=RA0y7IujTLL1SuELftnnxIeqMadipXBKRU2WhypH85kxzNjGEkgjMgPBn6aYPnMFux
 vSDvQAPmJLJMMTqcwOqr1wUPsPb6WYfZ0+K0xKPMW21sedT9zgK7wNmA2/M7H5jVxNWq
 uJoeQf+vvWbc3OMmQldPNoUYwLZdE6U8NXkU7p/0Q68jnwpx+ZOh1UwpVtFsNV+elCdN
 jOZKC9lVcveB0giyXpJRXWJlmG+JSaLl0MfM1hW1qG3EDSJMlbiykNUobGJ+uyqQ6pkT
 wVwaicmPH0w0w98Axo/j4XLdztkwVpPj2Za6eEDygkZjwWFft811Fph8H1m8Ne8QCnqM
 bFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718707274; x=1719312074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3R+UjQl1RxIgS8AG7wIEPYsce5sJ3W4+fNsRtJtvYxo=;
 b=dA4dDJVwAByusyQUvXsgGMumgEefmK3NyHD/iWapMKa+C7OKgXPHpaAOEg7Ub3I2qe
 B8dU7gKGT03Dv0LQAb7v8T592d3y+40BqN/nsA3CGN2nQKhKN/d316UyWtEXJ2eIcuUC
 FGOZv0Oyjcprz9N3UWynHSha+hgA55dagcNWnBKdoSZvfC3bMdE+dJvGoaIDUl2uY3R6
 CSgbdQL2tU0caIwxuiKwQM1s2ARi3U0+M+bIkWzyuprg8tZGLxQCk3gXtFpQMlhdxpP/
 VTrIiSBnc8M8QHlRxE8daaDM5cFT2C973HH/rZDKhRvATDDUvhskYV7T9e8b3y//nePR
 Q3Rg==
X-Gm-Message-State: AOJu0YzXXFH/vvunge3fKWRhoLSksjYH91vzemMgvEMNNYFMRZ2y46nh
 nGfl0vHguih1Hkgv704FRRFlxGw5N2My1M0NseM27rrdz7DboGoOQBnAjL/bxCvMmcrmvB9hFp8
 99IY=
X-Google-Smtp-Source: AGHT+IGE6FNLNO+us67yLcFYyrRWZZb73LOH6IpukKTKSguLpOWP0TapvXdSqCll4vCg2B2iAuuXIA==
X-Received: by 2002:adf:f7d1:0:b0:360:9625:c571 with SMTP id
 ffacd0b85a97d-3609625c5f8mr3880341f8f.48.1718707273897; 
 Tue, 18 Jun 2024 03:41:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3615d7a1a0csm1349736f8f.23.2024.06.18.03.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:41:13 -0700 (PDT)
Message-ID: <71eac8f0-c1e4-4b95-b365-5158a119da64@linaro.org>
Date: Tue, 18 Jun 2024 12:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu*()
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612132532.85928-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240612132532.85928-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 12/6/24 15:25, Philippe Mathieu-Daudé wrote:
> Trivial patches using const IOMMUTLBEvent.
> 
> Philippe Mathieu-Daudé (3):
>    memory: Constify IOMMUTLBEvent in memory_region_notify_iommu_one()
>    memory: Constify IOMMUTLBEvent in memory_region_notify_iommu()
>    hw/i386/iommu: Constify IOMMUTLBEvent in vtd_page_walk_hook prototype

Series queued.


