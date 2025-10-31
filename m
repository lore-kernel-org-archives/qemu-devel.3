Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99519CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmsX-0006Ym-Ht; Fri, 31 Oct 2025 07:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEms8-0006J2-FK
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:00:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEms3-000459-0l
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:00:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso14906445e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761908432; x=1762513232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3+veC/ncpRU33lGg8BixbcoiDgMeNEhslD6Q4Wq4gM4=;
 b=MJ49IlBdJvGrXw0Jd3J4kAtKNFvzcLi/aEj/mirdl2ecXB4TDGz6lyiqhtfr44WzNe
 cEzQujq4YAbvy2h6ZP3FpBpXsW69O0/BrVjQ8AEM2HcUW+HxpthU5mFNk+9EoUSwB+t1
 q+/8nCcWZ0jPTWnkRTqwbmEOE/SjpbFkwLKMSlRykLjY6AxJyQzXh4lP/8vVa6/M26tL
 5pLbsEA/DrkUCyfEPJiHv+xiIyCwjKSDk+faGxpQBL09zbEx9KzGT9rZMtvSNwAk068L
 mU0VkFyzF8/K4PTOFqZTBG8YvOrZw2L/FOnYi9CJsXbEVOjU1hMOCHOG63gekrFgQD/6
 q3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761908432; x=1762513232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+veC/ncpRU33lGg8BixbcoiDgMeNEhslD6Q4Wq4gM4=;
 b=adWvHwsEF1gTCrDdErkgj2s2skYTKZPELZN7ExwtRchi/Mmr2NxO/ZUXKKPugKDDps
 nMKRVEofrTy2qAnET8lqwtlCs+WC/k+M1EoMs+Qir4HBV6/0MOrTeveaWhKBEyNxUetd
 smbpSnMB2BOWQU3AJqeYpl+Z/q43i9fM6rcyAxmZGWOgt5UTcc7HcBp88YyP/P1Bp4hF
 vlH1aB/7hAPrqS4FR7uu1Xg41ak3OPENd8lfw5CeGjObwAkPJj32suqlbWPoPJ7mWism
 1NnYdrQV0j0eYk+TZ0DeNmd19heutS1n31PPzP7QCj9J46mA+wU6pV510BqX1w79Q599
 KUMg==
X-Gm-Message-State: AOJu0Ywsn3nn0FZdIPMer7kKbq0zldlM3j9NkY0TLWqYZu1l7tyUm5+p
 GTfC5Q+SIF6ZWX3Vjea0U2Nfv3WtVV8WOFnJHt17I1zWfGnUda2/cZ0R1GGixUrFJlqMDOMyJw7
 xobG6TVRDbu3L
X-Gm-Gg: ASbGncv15T9S7lH9i2Xzg14C4BarqYig+2iZLK1uMej/WaVBB6+fYK9qOlUEP1pyyhQ
 UlKRYaivN5GEtNWUEw+O7Lot66g02uZqSVcLkYBDWLOybUPfDvpKLh1iiRn1Ebauz5gw8mOKVmY
 i0JIaExYrxe8tkQq0dBDeym9CV9kcrGyrVMJJTDVH5it4bA425VUmztwKJu1qDj2pyfhxhp6NTB
 yVii0UeNNKPP5UN6iLGM1QImeo9EvZMhsIZ+re+Mk84NvRG6L+Px9UOoaQlO/mNbVoDmHjz5Jia
 RJTIAU14b3VyodbOhWr9MNly+7SJkjI95hTSvM+9+NVsRvOtGnLcpjbncUUMMJKmCAUK8O4qark
 hMn+qrIHpzivirBEp9ExxgHxymuihmqy6cxcNX7sa2dOy6Ivq/s/M3KFswg4GMZvb1weRIpEbHd
 AuLm0jrYNtDQYI0FT0YmAvDhPZsLy9kq0QLE9WFYE+h4YFcswbJzAG2vIAOI46sJMnaaLlMf4=
X-Google-Smtp-Source: AGHT+IESnRz9yVlQjfcxPBTyZl563WQkZux3mAHBrKSFmldE7sJlSN+ENwquFfK70MebrXZ7u0hUKA==
X-Received: by 2002:a05:600d:830b:b0:46e:4cd3:7d54 with SMTP id
 5b1f17b1804b1-47731638218mr12909415e9.18.1761908432058; 
 Fri, 31 Oct 2025 04:00:32 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477389b3acasm14602335e9.6.2025.10.31.04.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:00:31 -0700 (PDT)
Message-ID: <1c1103ad-0d41-4bb8-8d70-7dcbb3e71774@linaro.org>
Date: Fri, 31 Oct 2025 12:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Disable flaky MIPS tests on our
 GitLab CI
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20251031094118.28440-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251031094118.28440-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Cc'ing Thomas

On 31/10/25 10:41, Philippe Mathieu-Daudé wrote:
> Disable both replay / wheezy tests which have been reported
> as flaky since too long.
> 
> Philippe Mathieu-Daudé (2):
>    tests/functional: Mark the MIPS replay tests as flaky
>    tests/functional: Mark the MIPS Debian Wheezy tests as flaky


