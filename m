Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59378C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRfK5-00075Q-GP; Wed, 10 Jul 2024 17:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRfK3-0006vm-4q
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:57:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRfK1-0000rA-JH
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:57:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb72eb3143so1954475ad.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720648676; x=1721253476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E5kaS5fu75MoPM8zIU21xS/FuLmD+xFBzhY9eL6dpd4=;
 b=Jfrm6niSxdEz2E+ViuDR3REkplSiA/LqHSqdclMZbbqwJMMOjI6igFyhFgavBgkWI8
 3/pf76fog/40keBSp3PLXrLv1O/0sq2Y9dNgEiO/cIl6Cuo1+qUfKP6d7EG8fcIgjENj
 K2Q3wiEe4rby8kRm3x1RLc1u9GmFsyph+R/TD8i/7bSU0SEu3UK4oZ6ca2p+vgIyvZ+r
 yo+Y5GjsroXgVBCQouO50MTojuXefwWpRuqPC0zKf6+EvFTi11K3gMRG4UYL0EijVrHe
 /3YGl6Csu2sqp7vjXn95RZo/FwI7Jw9zhPNdH308YfghQlFHgYQjnIhpe/6Fz+r3AwvA
 V3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720648676; x=1721253476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E5kaS5fu75MoPM8zIU21xS/FuLmD+xFBzhY9eL6dpd4=;
 b=ZenQvSjTO07cRndRyu4IQXOF4EFbWai7ubAlTOArw2e7xqxT5e6U5cfsI8ZMY4lyAu
 wcTFSJ318mTgfIEYHVjs1zY5SW/lkiXw7uf43scxIcJvzpCROI41L95VaiYNyF6KQYdD
 /EnNqFMHv/ah8VyGU8Xq9/nC/9p244HCInLprcYTaD840rrw3H+kLiFKiadjmAz9wJEV
 xXA8CGaCBYyp6ynIPlzu4AJiHCb2WS5mEUZqdonxx0wpBTM+1PE0100dW4p8OocqxiF8
 ZiPrCTZnJs6Pb/VhYpuc/2Ee6C1VhLuCGCXeT3GpKB026+PUKWr8ABhLBnnC7pEpO4gh
 g5+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuAHN3ybtYFbAqO3wfYQt2lcgC+xb64FzRstNmX/HBWeIQdNBfTlFuSLsXbTWA4FeFvCcENHYtoXxP7kEYBHVPK59NI08=
X-Gm-Message-State: AOJu0YzYHCYBaIV1upRYa6iDt/8P7NYAD4Xh6di2WTTe1653bS4AZOUv
 +Y13gJpAElAtJ6AXP33UDNm9d+RLVhI1o3T9ZEFHzMaHPTBL+s5DJhq9o3JMqfEVUNSnZbIL43h
 YqU4=
X-Google-Smtp-Source: AGHT+IHIfUjfARyEUcQ6xamN9ZnZl4RR9ofRlvany1kkXPoKNzBxyQ5FnUXwOHEI3nb5xrXNC5SMvQ==
X-Received: by 2002:a17:903:2a90:b0:1fa:1a78:b5a9 with SMTP id
 d9443c01a7336-1fbdb9b543bmr11934715ad.3.1720648675774; 
 Wed, 10 Jul 2024 14:57:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a1083bsm38256925ad.37.2024.07.10.14.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 14:57:55 -0700 (PDT)
Message-ID: <aec10cce-ca7b-4437-b59e-fd94b0f1d637@linaro.org>
Date: Wed, 10 Jul 2024 14:57:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disassembler location
To: Paolo Bonzini <pbonzini@redhat.com>, mrm94040@yahoo.com,
 qemu-devel@nongnu.org
References: <709543045.677058.1720634520917.ref@mail.yahoo.com>
 <709543045.677058.1720634520917@mail.yahoo.com>
 <35b121b4-8645-43db-a15f-4610b60f06f6@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <35b121b4-8645-43db-a15f-4610b60f06f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 7/10/24 14:55, Paolo Bonzini wrote:
> The others are not hosts, only targets.  By putting the file in target/<arch>/, they do 
> not need to add it to the "disassemblers" variable in meson.build---but they add it 
> anyway. :)

We should clean that up.  :-)

r~

