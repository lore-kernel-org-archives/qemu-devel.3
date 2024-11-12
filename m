Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1633D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuPw-0000lY-Bz; Tue, 12 Nov 2024 12:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tAuPu-0000l3-UT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:11:02 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tAuPt-0002hg-DC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:11:02 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2feeb1e8edfso76396971fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731431459; x=1732036259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lTrFyt7xvaBjA0opqp0jNJBxCdnRTPvW3DdM/vMYjkQ=;
 b=Nf+KfBhNEVzAt6lKAzufg46h3/98FPz2nxEXDGsiQSC5I2sgv4U11uJDdZna+T3r2x
 3ogx2m8WbOmMC7lmELnCnNSBvelj73yySXuFyjxMEgO3u/YH1E/F7VpF2JSNMCL3og7D
 e8z+61dTa4De8IubQrOPBcQPWXrTQJpbjQ1flRY47D1K8xJh+B98i/OWgiPDXuyXkTwe
 i+68xecWKTOFLt4AQF5+l7afV2tDVTnkCg1uruWyztTWtZekIYvzvtcwm+U/mQghqMLL
 RaAV+mostNGK7Q2/DAuc8Lk1L4zr62JbTWFpV7VkyLTqcdtfwwqXRXH9TDmx7n8W0bGM
 VWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731431459; x=1732036259;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTrFyt7xvaBjA0opqp0jNJBxCdnRTPvW3DdM/vMYjkQ=;
 b=CFA/fChaoEFq42V70+zYayQ2r7ehppkZVN2Cm/elOUvofpq1ycM6RAsQY+dbS5MHpM
 mlOxUgCv/ncEQpuYOFeJsrhrKb/YCwlHoxn7D/ohVPP2WjrU6idBkZIMD6oFasVXxEFQ
 e3M73ABZXhGJiyZjbkRX2wb3If7W3Ssy6cNtVxiUDJq/qbC57cduyyADeU0WA/pl6eow
 zt81AaowNf4/1zl13KZLWUaP1lzaKI7seJGqy6x5MM1u7F9pvIAcxR659m/BhI/3v/lz
 tVzlMubbnZg0G74/rDgOT7GtNch7SHssUl5b6GL79o+fQmy/egKL4gyypn/Zr/LWjTH5
 2svg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOPfMIRZrrm9tMnXRe/quU/hrtgZ3dvNZvwwtRUBCduE7TAeCbbxsAJ1DHoYTuMuAYD83JeUnsgCMX@nongnu.org
X-Gm-Message-State: AOJu0YwqFQ9tiT45lpa6d73xOHrTYs31K52+G/WO3liWJ1PtpKJe2aCh
 hpyj2ZE16POP5gjbgyjNkXvFwLDqo6CYdqKSm0ZW/zzCxfJWuxCQubIkvZwNokooumzVOA6s9K1
 rp1E=
X-Google-Smtp-Source: AGHT+IEZJkkHnFzx7/g8tIsfc7KeUAIB+t5nT3U1cUtHe95euLU0cyf6R/UfJIu5a6PhAo9IOj1S6g==
X-Received: by 2002:a05:651c:1551:b0:2fb:2a96:37fd with SMTP id
 38308e7fff4ca-2ff2028a91cmr133928431fa.29.1731431458917; 
 Tue, 12 Nov 2024 09:10:58 -0800 (PST)
Received: from [192.168.210.26] (83.11.2.232.ipv4.supernova.orange.pl.
 [83.11.2.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0def87bsm749844566b.143.2024.11.12.09.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 09:10:58 -0800 (PST)
Message-ID: <90513bfa-0888-44fe-8cd0-7b2e7518a41f@linaro.org>
Date: Tue, 12 Nov 2024 18:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [edk2-devel] [RFC PATCH v2 1/1] hw/arm/sbsa-ref: Support CXL Host
 Bridge & CFMW
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: devel@edk2.groups.io, ardb+tianocore@kernel.org,
 quic_llindhol@quicinc.com, peter.maydell@linaro.org,
 chenbaozi@phytium.com.cn, linux-cxl@vger.kernel.org,
 asa-dev@op-lists.linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241105104346.417102-1-wangyuquan1236@phytium.com.cn>
 <20241105104346.417102-2-wangyuquan1236@phytium.com.cn>
 <20241107120457.00006024@Huawei.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241107120457.00006024@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x232.google.com
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

W dniu 7.11.2024 o 13:04, Jonathan Cameron pisze:
> On Tue,  5 Nov 2024 18:43:46 +0800
> "Yuquan Wang"<wangyuquan1236@phytium.com.cn> wrote:
> 
>> This creates a default pxb-cxl (bus_nr=0xc0) bridge with two
>> cxl root ports on sbsa-ref. And the memory layout places 64K
>> space for the cxl host bridge register regions(CHBCR) in the
>> sbsa-ref memmap.
>>
>> In addition, this support indepentent mmio32(32M) & mmio64(1M)
>> space for cxl components.

> Those are too small.  Might work today but not sustainable.
> 
> I'm a bit surprised it was this simple to move the MMIO Space away
> from what is normally done for PXBs.
> I think it might work because the GPEX memory windows are effectively
> unlimited in size but I'd like some more eyes on this from people
> familiar with how all that works and whether there might be some
> corner cases that you haven't seen yet.

I see the same problem as with multiple PCIe buses (for NUMA systems):

pci 0000:c0:00.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0000:c0:00.0: bridge window [io  size 0x1000]: failed to assign
pci 0000:c0:01.0: bridge window [io  size 0x1000]: can't assign; no space
pci 0000:c0:01.0: bridge window [io  size 0x1000]: failed to assign

I do not know how it looks on real hardware (all my systems have one
PCIe bus) but shouldn't each host bridge have own separate resource
windows for config space, buses, mmio etc.?

Now we squeeze all pcie buses as pcie-pxb devices and this patch adds
cxl to the combo.

