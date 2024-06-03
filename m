Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212AEC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9Ka-0002yP-Bl; Mon, 03 Jun 2024 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9KZ-0002yH-Iu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:10:39 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9KX-0004Rg-Ss
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:10:39 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ea9386cde0so42715921fa.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717427435; x=1718032235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/8jfXPQPGP/SL17Kpxbl/YGKr8yJT/3WSYPRxt1CfC0=;
 b=oHdOmJnRJneRpCUHv+EGvhNzcoBJNBb4vllRYRnLESgElmJZxb7m9cSad8+Ird1gdq
 8ZpaXS5DET/uU/QV9zSdfvBOCPS4LiiMnpyIp2QZJ6nhCoDQqJpogtUkNIU9aJuPs63X
 fInNJfJPBGpNCRgXjdTE0TwtJWdpqwzFO+uB5p5gLDaKWh4iQMB0fcAEIVqpS2DuXtLn
 ILCRIDRelHWsc4xYn4Gln2EIOxEP6G7sh2uI1i85pE+fR5fWgxSAHNFviXcx0RnpRS3O
 BLEQjwvBdQudRSgswCc7+ocbjbjf/eWgZUrC3A7hQVRXoiulx2gPHhcWfV6hzKz++PLs
 Zwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717427435; x=1718032235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/8jfXPQPGP/SL17Kpxbl/YGKr8yJT/3WSYPRxt1CfC0=;
 b=ppjzRjSioclo1XeINejPzjSfdZRT6CO9fAnsZVLW2H7Uh10txKIMEBVNzyGECJmbi4
 cCuheze7wJW9xcILDJ+PxDIxaeNxVU32UYgwHGKzhcwkMUUnDTcX6rv27+6YaIuTsId0
 M2Lkc9OkcNKCGzg7mynE+xIirY/xunUX6Rq5fI22gZr3FDsXb7sADYNj0/5H1qeC7qZ8
 n40JNJ7/I4kfSOjMMuW89Xmdy2RuMYR22M/8guIKm/UPbGA+6aKv5KB2Sm3Fnz5g2nwC
 U7vaageY6XtKPbJk5QLHazwD1g7Or2labKu8rcfeYPbT8ZQZZHTfilu50FzACZ+Hurpr
 EbPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9KleSLcbJzNRoflo0vcTB7quxFY7lPIHzPd25/f3IrDvDTugyc6IoC2hiDgwXbdyTesaltVXw7kwc1plpVidiDzCO6sQ=
X-Gm-Message-State: AOJu0YxVja5VXuFJGU4iThNTGcfSl/k5qzmZ/O7k4lJ1FjBDQEUK3q1w
 4rRtBALNPOtL9CMewYIq9VGO61rApeKE9+aEGFkI3olR6972/nCv7cqoYcJM2RE=
X-Google-Smtp-Source: AGHT+IFf/ykBLoQpidyG6mGKuGR7sbF781HloysYbE/Z4pOOr7V3+UN+7veHAcdSXx2DX/Bxr+BpdA==
X-Received: by 2002:a2e:91c7:0:b0:2e1:ebec:1ded with SMTP id
 38308e7fff4ca-2ea95122002mr56102921fa.25.1717427435429; 
 Mon, 03 Jun 2024 08:10:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a468ebb00sm4248390a12.52.2024.06.03.08.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:10:34 -0700 (PDT)
Message-ID: <c53d4f3f-6279-4100-8006-29e191e2c01f@linaro.org>
Date: Mon, 3 Jun 2024 17:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cxl: Fix read from bogus memory
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
 <48ebd16f-3eda-4292-9257-bcac9c82cc5c@linaro.org>
 <20240603110458-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240603110458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 3/6/24 17:05, Michael S. Tsirkin wrote:
> On Mon, Jun 03, 2024 at 02:53:35PM +0200, Philippe Mathieu-Daudé wrote:
>> On 31/5/24 18:22, Ira Weiny wrote:
>>> Peter and coverity report:
>>>
>>> 	We've passed '&data' to address_space_write(), which means "read
>>> 	from the address on the stack where the function argument 'data'
>>> 	lives", so instead of writing 64 bytes of data to the guest ,
>>> 	we'll write 64 bytes which start with a host pointer value and
>>> 	then continue with whatever happens to be on the host stack
>>> 	after that.
>>>
>>> Indeed the intention was to write 64 bytes of data at the address given.
>>>
>>> Fix the parameter to address_space_write().
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
>>> Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>> ---
>>> Compile tested only.  Jonathan please double check me.
>>> ---
>>>    hw/mem/cxl_type3.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Thanks, patch queued.
> 
> Had it queued too but sure, I can drop.

Sorry I didn't notice that along with your R-b tag, my bad.

Don't modify your branch, I'm dropping it.

Regards,

Phil.


