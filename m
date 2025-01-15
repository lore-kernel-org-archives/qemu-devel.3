Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133D8C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 09:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzJf-0003gL-HW; Wed, 15 Jan 2025 04:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzJe-0003g1-Hm
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:03:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXzJd-0001Ti-0c
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 04:03:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso44394365e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736931834; x=1737536634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xxkIfTUSJx0OfXP0SS7AQUKyLooNQKVwHEYK8EQL1Lk=;
 b=D0LDK1zUoh33tjH50ggBnzMvWNTFDXlwnHFQz6Oj/dSXX0xMQvPhZAdRk+0kzUwxuk
 R0BrqsUaBsgPNEsAsRhjkEX/SG7kYkrY1iIkpl5a9HVxgRldByuwsXs9oAtfQLLDA4ST
 /q1V5zYZAlkxjF/GXnwzpJvO8kU8alJaJIAvDS6LVWj2cZlYPvsR9Fr7c1SXsvW2/4HB
 40fTV+otj45tq07VaNAjD9zl6VFu3v8EMZ1WB7ki4Jjp0DgM3UnukXaH/XlVytei7KxR
 p6Xhm9HYJeR3i8IT/S9MgftapenghyK3WMKXitaCeZGgQfRss4cuIdBTjFL5s1EdA6m0
 wKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931834; x=1737536634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxkIfTUSJx0OfXP0SS7AQUKyLooNQKVwHEYK8EQL1Lk=;
 b=VH8ibnv4IDzmHCB3z24W6uyR0aNVh3bYDMFBYglOLu9H4dAcEAsDopEcsSOJa8ob/v
 zS6vpPpvVjS8UMHR+yKblJ8+ptDy05ZI55maMTH55bHshYH2IPLxazk73UieOfUMMaJV
 VWRMl2Yt2QJhUcrULL153PxOYncjuU0dIUz74x2POZpB7WqcseLGOS5GvtdWBbvk8AAg
 8uODeWgKeB5UbqF4dP4oGgrCNJADQc3/wwvxmjRkq67MtTxoQegkhXIroMFKjmfa1otz
 JQrnGbYDJoKXtu8ad2LL8cx0p7XUIOzObZjS2kyrtVN0kVI1GRSExNK48pHWpdFQXEWb
 +kvQ==
X-Gm-Message-State: AOJu0YxaRmt0aM3JwJf5E/U3iKQNZzF6zWX/2aWVOL0i9BaD/1/i27jl
 ie7q5bSWHmMNjvWihl6PWF2OPY76A16Au27N/1GbZKYEAwEC8EaknirNPa5k6xx21fbsEKmGQlv
 JEmg=
X-Gm-Gg: ASbGnct1w3fLyuPAFcaPhUkkxCHHPLTQnj3Nk2j1oD5o8dIN49N6rdQg2gEH6e/AR0d
 qpcQ4zKvC4/iOoLhiR7sS76hjLGODxgPioRFbDmmRiOybPyxQ1o8yH4kTJUgtRoFT7qGfPC+Wm6
 c7kS+wMAFxoYBXYlQlAuwUZc+8JOXYytLHZb2VTbdWo/SyBQ1wsKrrhalVt/28bKAyGqAc+9hmO
 js/lwRPOZFJgj+/CXY38wadSArDPVAo6zbMpM2uFC4PBdDFtjp1QP//l/VX8fLKj1jbdQzvAdW0
 FI/KYlEmefte3DMozIc39eYU
X-Google-Smtp-Source: AGHT+IEiEFl3X4Pol9kqCXnu/vq+BEG8iYsszmJF07v3rKDy8+blF1P75HV0ozWT1TmfiWvRQpvixQ==
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id
 5b1f17b1804b1-436e26d946cmr216198645e9.21.1736931834547; 
 Wed, 15 Jan 2025 01:03:54 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c75290a2sm16002385e9.29.2025.01.15.01.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 01:03:54 -0800 (PST)
Message-ID: <e78fe4b2-68ac-47a8-b1a3-b715074e2f4b@linaro.org>
Date: Wed, 15 Jan 2025 10:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/s390x/event-facility: Remove the obsolete
 "allow_all_mask_sizes" code
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-7-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115073819.15452-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 15/1/25 08:38, Thomas Huth wrote:
> Now that the machine types 2.11 and older have been removed, we
> don't need the "allow_all_mask_sizes" compatibility handling code
> anymore and can remove it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/event-facility.c | 37 +------------------------------------
>   1 file changed, 1 insertion(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


