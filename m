Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9ACF4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuxy7-0003O3-Lr; Tue, 24 Feb 2026 14:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuxy6-0003Nh-8j
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:21:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuxy4-0006wh-77
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:21:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so43924285ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771960870; x=1772565670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LtQRU59z92zSvn1k6+1ozxiKNm7wG6Dtg5eNj+CyUQ=;
 b=mpfm/gnK6XxGtwOConNrjG7CYveOiJqZd98TgQ609CgymKedeuu87uCr2EifZyKjFN
 7dNZt4m5mmeP/XAFb/uWLnenVVyUbegCn1fXcqNngCtqT3CjfiSsfHeHSf9gWB9yj9Eb
 o2s8oNH5Gw90PSX5ywoMjb9NLsGpNSVca+3n4r3xZH2wCU5hfj2HNQOGPKbWcfgWhGIv
 62TBQzYKx/y/0HyX4ryt5wIXKHIqKHcGqWOMOsdCJrDB5AIaWqT2lqvtfOsAwAm1odKU
 McmIEPwnrQN6Lj4Vn2/SoSvnC2Vy/RISVkTQURf1BOjwW6SMnOMxVxo9fe6anmNhchaL
 UU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771960870; x=1772565670;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0LtQRU59z92zSvn1k6+1ozxiKNm7wG6Dtg5eNj+CyUQ=;
 b=mQrwenOnmNS10cv2Cb46WInlzkFSmC6i+0wIalTU+1YEcnLJISJFak+mCKomUIlIac
 mwGnXYh0U98UyBTcyN/cd1iBoWhciqfsUdCT6K+5+JDM1fwxzIjmQOPgHVwk0i/pd5q8
 6r2TndwW5uvukPJRdNTOPWLcUBHtR327Xv+c8gfr+K262NFPJsHVZcnFemQ4deAGOVw9
 xytJAumnichh5CBSk6Zm+9BGp82TqdWGpwIgRpSW/56kzd/YOoVmktajHfX039TOcpxE
 qAZjdI2XW0tOjXezze7R94ucm4xuIRANvQmTARqgMDB+sNFRzHKUPORc6xH3l37LPGII
 Af2Q==
X-Gm-Message-State: AOJu0YybQ2Yrxp5jXu86WV0Dy5b6Q5wvZh+xrHGufi7lSLIvEeVReYUZ
 pzH5Fb1k5OJOqbRsBDecAhnXnPyOCbQ0Sc2oQC/qnW41xtQEo2LdHOoYgALkKCNkpFc=
X-Gm-Gg: ATEYQzxlPmV7akZXb9mxPKJDceSlGUpI/LMauZVUAAY9i3+BICfYJdus4DKlFVsSUMc
 t0KGfPtS2ETNPVPOoZhZ2omdKwaBT7XDkXnCjHNOu+TrOr2tx20PazYRsw3Y5Y0ZtTYmEs6i+BV
 Zp+TnBNbyCYIlxTOWfimxi/TVWC5WKeO2aAoIE3hnqJGn7Xf20omHIfUzxKc8de91u/zbCNB0kQ
 A+QL0pB0ZhxR+uCwfugkS+8y6txQ174p4y5GQZ5ou69AE0VjpcZhbMSG/Y/Rm9kELPE8oRhpOmo
 3Zqfqu2fjuUO1ua3qgBVFQYiJHjEbPXFxbe3IWTUmdtXYInS3Lvi9q9BCs07XVw9FWtUSHZJLJN
 /jtWHBMwY6LCsL1+sIr4qiz/V6jO5fgkDa2J2awy2I1dH3Q8qHSU7z+6xgk5Ewi+oNF0tkLmcs/
 FX3z2Pwmybn/bxWJLWFU89fr03/Qr4p4HV1muFJNoId1GVmJ6N2toYwd8z2v4whEgMJ9s9
X-Received: by 2002:a17:903:11cc:b0:2ab:344e:1400 with SMTP id
 d9443c01a7336-2ad74515cccmr131804005ad.37.1771960870147; 
 Tue, 24 Feb 2026 11:21:10 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74e34fdcsm106645925ad.19.2026.02.24.11.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:21:09 -0800 (PST)
Message-ID: <c8e97ad8-e54c-4134-a7d8-cbc91f7f4bae@linaro.org>
Date: Tue, 24 Feb 2026 11:21:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
 <20260224134436-mutt-send-email-mst@kernel.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224134436-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/24/26 11:07 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 24, 2026 at 07:33:14PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Pierrick,
>>
>> On 13/2/26 00:45, Pierrick Bouvier wrote:
>>> This series eliminates some target specifics in hw/virtio and replace them with
>>> runtime functions where needed, to be able to link virtio code in single-binary.
>>> After a first try on a series [0] doing this change and making all virtio files
>>> common, Richard asked to refactor this part, thus this independent series.
>>
>>> Pierrick Bouvier (3):
>>>     hw/virtio: add virtio_vdev_is_{modern, legacy}
>>>     hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
>>>     hw/virtio: remove virtio_access_is_big_endian
>>
>> Patch #2 has been merged as commit 6325407f67d.
>>
>> Since we don't have feedback from the maintainers Cc'ed, I took
>> the liberty to rebase your series, trying to address Zoltan's
>> concerns on patch #1.
> 
> 
> So as I said, main use-case where we would worry about perf is
> virtio storage. So it's mostly for storage guys to ack.
> Did not get Stefan's feedback yet on whether he is happy.
> 
> I don't understand if we always want to build a single binary though.
> If not we could address all perf worries by having both  generic
> and target specific implementations by using linker tricks (weak symbols or
> whatnot).
>

This is not possible unfortunately, since concerned function is declared 
static inline. If we want to follow the linker approach, we would still 
have to pay for an indirect function call. That's why we insist so much 
to change the current definition, as it's the only way to move forward.

The other solution is to exclude virtio completely from single-binary, 
but we don't want to have specific config for this, and we worked hard 
to keep our promise over all other subsystems we touched with satisfying 
compromises for concerned maintainers.
Virtio and vfio are the last two left. After that, there is nothing 
really blocking the path towards the goal.

I invite you to watch the presentation we did with Philippe in latest 
KVM Forum, it will probably answers on some of your questions.

Especially, you'll see we insist on single binary being a recollection 
of existing compilation units, and not yet another configuration to 
build (and potentially fail).

Regards,
Pierrick

