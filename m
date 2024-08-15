Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34C8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 00:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOot-000693-8p; Wed, 14 Aug 2024 20:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOoq-00063k-MH
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:58:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seOoi-0001eN-7F
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:58:24 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb53da06a9so299243a91.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723683494; x=1724288294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgacmduwPoiD4QcsBQ/BUu6sTBnd1E6Jl6I1iqizSMg=;
 b=AEtNP43BytNvXp/q9ksbWskUI9PAn8u+m90agU1D0oXPPEmXRICuouNCvA5Geb2+WB
 lP7tpNHIPqnhmOOfdwqRvujmHs5FQ3ncCkxlC81k0mkhl3edw6ZE70dlbz/kBivf6Pjj
 AqrGYX4SeqAmXYRfxuly6JTIGfi/spZluRD/VpCRUArCCt8ynjzeAT32M1Ds5myhrDs6
 hLE1spPS8GD5NfcZ9TOHMEQhk0xoTQT3x8AV4k82N2mkY+adAivEiScSz9T1nOCILZ/1
 dI7t6frcaWcZzy9DnRY3gCr7xEn3FCWlhTx/bi3uSA+LO99h4bfCkp37flTyLEN2Pb1j
 ZVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723683494; x=1724288294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MgacmduwPoiD4QcsBQ/BUu6sTBnd1E6Jl6I1iqizSMg=;
 b=ieEQvzgXTca8JqTum5Wv+euSQHfPeFWR0h0l8VyTutZIcce7L+aVsPJZYa3euDnGbV
 x+ua1TnE8YfD1UL89gIxSWnzzRGFeRq9c7eTOp8Vu1Dd757msmkajfKyhUEiQghzIRal
 /uQ4KDmcOIPzh2MOq8/LG+7mIMurhtUCtyVyppD+IHEuLG/yQiHRHmNyCc385e1BpsHc
 vKPLacKM/7hezKfUq9AINu4q6plJ+fHgtpOOVOCIqTXc1QfKfKUGPWQaadMb9YTktZcw
 SLJcUNUoa9nRiecsEeHFs8VT5iweZ5gJk0trs6wkNMk+mws2/6mBDAaSeYVjldi9VU5x
 5Nug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBuuzEgyv+y/HPfnPrdBiM8ZwOgxR90smDIwn/3vlB0EkUc4zl1KO+Q3urLzjAMukL4tcaiPWrsgBNcidGqM9h5smHWFk=
X-Gm-Message-State: AOJu0YyIzTNSKM/t7mEiAn/Wmdrb+aNLONdpUnLGm148Fr/kgn71htZ+
 BdcKAm9fRDxkTEHPf7Q8h5zS871agBgSj5QlOwywEwJFbhUQN0EKAXbL1Z8IWPw=
X-Google-Smtp-Source: AGHT+IHIGjQ4lSqlcDSzTMO1pT7Jy+e1+QBUY1pZsffxSNhkQj+mfHoFffZzjb4nkri2uXVMjTzajg==
X-Received: by 2002:a17:90a:b00a:b0:2c9:6d45:8187 with SMTP id
 98e67ed59e1d1-2d3c3a919b5mr1963512a91.21.1723683494207; 
 Wed, 14 Aug 2024 17:58:14 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac855035sm2427052a91.48.2024.08.14.17.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 17:58:13 -0700 (PDT)
Message-ID: <07869c39-ebf6-4b16-b2f0-fd62b97399fe@linaro.org>
Date: Thu, 15 Aug 2024 10:58:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] target/i386 patch for QEMU 9.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240814164432.271179-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240814164432.271179-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/15/24 02:44, Paolo Bonzini wrote:
> The following changes since commit 3ef11c991e501768f2fa646e8438f075be1cd2f5:
> 
>    po: update Italian translation (2024-08-13 19:01:42 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to a6e65975c3fac1b2f067fef8eeed92584d773f06:
> 
>    target/i386: Fix arguments for vmsr_read_thread_stat() (2024-08-14 18:42:19 +0200)
> 
> Sorry, this one fell through the cracks.
> 
> ----------------------------------------------------------------
> * fix RAPL computations

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

