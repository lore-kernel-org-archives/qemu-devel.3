Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3A1C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 21:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tctBt-0001fB-5l; Tue, 28 Jan 2025 16:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tctBo-0001bo-NK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:32:08 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tctBl-0006wJ-BB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 16:32:07 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2165cb60719so110065185ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738099923; x=1738704723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpFRa/5fNPBcrXZU4JbIQmWEfIKYnr6nLj8X5qu+ip8=;
 b=SIKfqMYTjxx0BP+iUKFTuJ08zvj4SjEiuVglQ3MX6Sbojf6rxIluIb2vKdtR4VqhzB
 5wU5iBpeOTr0GJVhF/iWFrJxqgYzeFCcqK582cf2eFAzXL86dQgl0opNiKfyyqp/sFkb
 u2RfJxKZ8/ZedpYIauMU1SIVOz/MAzfu778lCclJrsCs8Gf1G+t8n4Xo0BndREA+YjvG
 OI3pCKZ1BLfuvqiF/8iXTplfgZfxaVks2qMAZxIKloixn5O1ceR7OkzWl1HvJ6SthuxF
 8kx5WnG0ItcxyWjll1RY83PGO/9K+y/KgSz6kAwt4qbx3gf+4+gqoiHwFrf/NqzEcByy
 A2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738099923; x=1738704723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SpFRa/5fNPBcrXZU4JbIQmWEfIKYnr6nLj8X5qu+ip8=;
 b=ET6efNDnEKbCW++2+37JYag3wHtZV7yNrYUpgaI48v9JDFtPOJIwk5z5qdHA0g0yWz
 Mi6V/xrKdx/aZSH+sEYTAz3gE3yOJQuhLUQlMgKEKDg9u/S+cyxCPzaDJu19Hb2rweC3
 VSmQIlurtK7Ihtv8Oi7wIKWxOQBhM2xC4n2bFeOgfC2MCerueCtYJRFAqcjFL8kUcHDY
 /lLz9PeRSVIxD3TjCP8cq/0rE43Mam/fzxjfpSg8JbuwOZnBvboVghhuclAaPzNhnOii
 qMlbir4L3VAaj556ZLIBS9/dvTHGc+BcfTpD0wutAn8PREVQDsv+yW/+PBfuKtwYcATY
 sJTw==
X-Gm-Message-State: AOJu0YxL85u9mD6rNdIUINa6q6+cFUxdvdvjswSyth5MqCpkMJbikER2
 21d3wvBA4fFOlqT3gmUgU/QG0sq/5pX4sKI+NeEH7GP5Hv/Y8KpXvWKmk+aRnTXEsdNnFD5SF0y
 Z
X-Gm-Gg: ASbGnctOq2J/PtlKA7Q7RNHdeflEbQ5X1kDxw6BJhMqVMhFpzkzh1herYDiq8FP3grR
 mHgvGp7TsqUFxrS7ifEAGeoD20dYdbvdhFhyYKKrJ9A9sipDbyOQu+7c14LAk9h47woBvCAHjQy
 HlzP+NwstIdIRB4FgS+W6itz/17/9b6V/ZYgPQTkUWd/qec8/50/kaeiclNBXCH3ae3J1LHI1kD
 0zs7VnyW/sxNQ+f/mjB7WtTYTTrdwWA1M4tyi96vHoK2V2sVVSpbkQS5NN+JAUra0VluM4vfoDy
 cZ4n91p0MVSmGpHsy3EXVRzLXEJPmwKWGq07zvJSpowaAAV5pSyr50/nH0832dI6OUv0
X-Google-Smtp-Source: AGHT+IGP2K47NFugMKGdFXqBOFkBzyuLU9uYAvlZzz/9ST0bGBAic8lHwVy6GSC23zdy8TEySWQRQg==
X-Received: by 2002:a05:6a00:18a7:b0:725:f1ca:fd8a with SMTP id
 d2e1a72fcca58-72fd0c6245cmr1034270b3a.19.1738099923578; 
 Tue, 28 Jan 2025 13:32:03 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a76150csm9766345b3a.87.2025.01.28.13.32.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 13:32:03 -0800 (PST)
Message-ID: <7d640990-535f-4492-a8f0-443003032c6d@linaro.org>
Date: Tue, 28 Jan 2025 13:32:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
To: qemu-devel@nongnu.org
References: <20250128180742.1137741-1-clg@redhat.com>
 <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
 <9bf6cf01-d8c4-4ed8-808d-03e6ee05bc7b@redhat.com>
 <85e8445a-b7bf-4d01-a6e5-5fcb7d562780@redhat.com>
 <7c68e0fb-142e-d68b-1201-98897854915c@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7c68e0fb-142e-d68b-1201-98897854915c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/28/25 12:23, BALATON Zoltan wrote:
>> Oh, you're right, OpenBIOS hangs with "milliseconds isn't unique" when running "qemu- 
>> system-ppc64 -M mac99 -display none -serial stdio" ... that's weird... so you need to 
>> keep the -nographic here, indeed!
> 
> That's because of -display none, without that you can see the output in the window. I 
> think if OpenBIOS finds a VGA card it tries to output there so you have to remove that too 
> to get output on serial.

Yes.  You need to add -vga none to remove the graphics card.
With -display none, you merely remove the qemu interface.


r~

