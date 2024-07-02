Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B5DC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeLR-0008A1-5N; Tue, 02 Jul 2024 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOeLP-000829-7I
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:18:55 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOeLM-0007DR-HL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:18:54 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-710437d0affso2429415a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929930; x=1720534730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dRLqbreccQD5Lc1QNngtgWw2Qk91fe6q7yRc0Z06oEQ=;
 b=wZ1Xigxt/AKn8vGzC+J+Vuh3ogP22eWrAPzF2CTqxdExlyjuMJLG9x+l4l05mrRr5T
 5WyIkaZ1OHWiWRqFTG9o6zxdg1wTYkCk+lhucv1Lj0q4L8kl2x2PruoDN+WjliklAvgL
 wSHmw0XumRYWkpvEHqbCNCdpWlfEs7CWsMqFg9cnSyByUfeNRih6NZJdgT3rZuYE4Rsh
 JeLeqgZ1388RLC0FDGm9o+BfWNftJur02BsWHd7BWb1tNR28WsdwrzVxBE/AVUZMISHR
 hXA6bURUrxj1z2VhEEFXDo3pseMoXDy0YKq9PG/VOLyhyEhLg7RxQu01B+cQ/ldSuTSM
 BpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929930; x=1720534730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dRLqbreccQD5Lc1QNngtgWw2Qk91fe6q7yRc0Z06oEQ=;
 b=do4hneqWuCAxCqbMMxtO70iSqtAnPDFhfHCxhKXch3PwsjtdNOIs5//81XBgvli9G2
 AZ4hTOGU4QcFH7aS1NrBXl63kQ/HTPHK8hjcdX2rxCRWtMkEFRGZpSVeA9ZmKX/1zj2p
 6YdQGSY7dPodwnM6YAMLVkBDviurROmdK/ZTYLSvcpafVTl7GzVoxby4AFbknqUlWSUb
 mTIwuvL99Bc4OXFPy/2swMgYpGk8vPewRewVXm0DNzAdAJHQxxj1Qrm+4Kh1w/NerIuI
 /uq4lr65trr7OP8nLdkpHD82LOj2csrqLTO6s8Rcr6JHx2vbD+NYyGNb6Y3if6x6G2UL
 GHFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJxutjiAzNVp99xOXxm1+1x/qewPmpD3HiXuPPxAIi3JLXW+DIELijvWRtNhGPtUQrglHC/BDMUpuEK8xu6URLDwKidZs=
X-Gm-Message-State: AOJu0YwzRkdM22VZIwCB5Ie6pEZUCYzwoG6EuxnygH6bsjjEAa+q64hZ
 y9ujmzkN3+SItW2j552sqULVBhj+CPnKTKFtWaEJsbg2rCMP7QeegRCdLUy2Lnl9xmPKTdBRuWG
 g
X-Google-Smtp-Source: AGHT+IFEHpdV1y2f+VOeQUimhfIsVLvMMEyTSKTrvE5W/o3XTLKN+K7p6Ea6ojyduhjxCcKI/6aHWQ==
X-Received: by 2002:a05:6a21:788d:b0:1be:c914:9ea2 with SMTP id
 adf61e73a8af0-1bef621e0b8mr8986460637.49.1719929929573; 
 Tue, 02 Jul 2024 07:18:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6a6f0817sm5632146a12.27.2024.07.02.07.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:18:48 -0700 (PDT)
Message-ID: <fbe9c88e-677a-4248-9901-76c56e52283b@linaro.org>
Date: Tue, 2 Jul 2024 07:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org> <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
 <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
 <mvmr0cdjjlh.fsf@suse.de> <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org>
 <mvm7ce4jjvf.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvm7ce4jjvf.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 7/2/24 01:09, Andreas Schwab wrote:
> On Jul 01 2024, Richard Henderson wrote:
> 
>> With -d page, I get
>>
>> Locating guest address space @ 0x3f4000
> 
> Why do you get a different address?

Is /proc mounted in your environment?
The guest address base selection depends on /proc/self/maps.


r~


