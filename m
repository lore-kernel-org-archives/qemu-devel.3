Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00A7CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPalo-0008OQ-WF; Wed, 20 May 2026 02:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPala-00077R-Uk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:50:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPalY-0002XL-Q6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:50:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso32576435e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779259851; x=1779864651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jK/DXZWUGXwPNhkrvcKMJSxv3cQVYaI9ga+iHxxrF4Y=;
 b=jRoQu2aoWFTGPyoEs7UahRDVhVV8mVyl7dVsf5CDPdBOXpwsDtb3ly+HVHZaAFWKVL
 Dzxyz8FVN83rzmf9NEvxBRo5z2G/KmKDBwdW90h9iX+HS06d8HrWoWPt0uB8y8w3LaNo
 ZZa+KQSfhrGdWKypNTXZXitOa00/0QfBZChLFmcC+RuZ6ieRPNwENuiayAwsuH0GCiuL
 iIA1qDiqKpM36vPwk+aDizhceUQNvq7WQdaiBE8RHN1Tv7UtTWHpspVMR2Egq5thwUFJ
 Or4BLvmjEF0fMC+Pl9MWduNhHab2DbCd18Rw9ueG/RWZzdUZBX2Vdar+zbA+LTetCDJG
 BvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259851; x=1779864651;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jK/DXZWUGXwPNhkrvcKMJSxv3cQVYaI9ga+iHxxrF4Y=;
 b=dZIY9SRzNXxiDe8yd8GMjPP+Huh1d4i92yBcJwo696PggCFzKLbif4syrB9DCrXvdY
 GXW07veVCwGyBukCysx6rvT7/iJHlcati5ePr6QeMRaPXrbDYeS3Pfk1//Uuj9VpiEJw
 4lmpCvMl96OyFfL8vcJPgp1PtsFqA2U3ihC/INh1e2k0AUacuoTTxFK8foLhRylX28Pn
 pSMtd9nVei6iScPdWd0Rlb+jRaPebNvssoNZ/nRNpOVMwyhcy64yguC4H1fwLdFCUWev
 nrxfoZSBwnlsesOEzMYMoz3OsKxhQ8WrUkC+MRah3k/6zOovHtDnnk4eU55OaW5UTijc
 TukQ==
X-Gm-Message-State: AOJu0YyKWunyyg/utVijF+c0Agw+zsOIV2R1zyp5pVbkD4d21ElCj36g
 YAFw950wIN+tGjWHYRfBZd6Xa4Mrrmou/BFMXKUTdzTBST2Z48C4yjVEVEWf3briZgg=
X-Gm-Gg: Acq92OG2MDZXVHKAWwlDbDlKvU8z5JpQ39BqJyLW5sTy5t1k9pp0n9Tch/XXQCm4rck
 K1yJKSNZYhf44TuXFK2eBEcSHoHS2GfwDxSSfS8OC1Io/EMz3LNua9MRP7GlZZRRi4l3+CIrKd6
 OuW2iebxmc3Gtm4IJkHHQCmxlFAYpr2j+Fg4e2vxaY6X7wJx2vk/0k+RvsdnEljwWUWLf5AkecZ
 uARftRrKYNlWqhThhlMr+43dUbzcuqu1EwgY1aZ5IHd9s73vsdjKxN2XvUYOctOTb0y7klVe4TK
 BReVquMhsDxQNMEOTb7BMsZxeFzaAZsupY6UihKbBALVmgNgLUV+EgVdQg/71N6h4TVqimF54+7
 KhzKNyPi/IiHQABSIFYCm6NZjhgPV6R3qVpqDQgUODMTfTG9wP8+yO8OONn9EzF+P9zg/keZj6D
 1GpwWr0DbiED+2YV5CcuTe+co8DzL7TjOklzIuhqOGd9KY0cLNlYIUrp8WI0UD2PdGug==
X-Received: by 2002:a05:600c:5247:b0:48f:d1b8:9aa0 with SMTP id
 5b1f17b1804b1-49007bdff16mr196961715e9.7.1779259851002; 
 Tue, 19 May 2026 23:50:51 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf80d04sm123309475e9.36.2026.05.19.23.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 23:50:50 -0700 (PDT)
Message-ID: <2dcc0a64-6cf2-481e-83ff-bc953afeac48@linaro.org>
Date: Wed, 20 May 2026 08:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update ebpf reviewers
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, ybendito@redhat.com
Cc: qemu-devel@nongnu.org, yvugenfi@redhat.com
References: <20251206093345.71031-1-ybendito@redhat.com>
 <87pl8ph7bz.fsf@pond.sub.org> <87o6ia1val.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o6ia1val.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 20/5/26 07:53, Markus Armbruster wrote:
> Looks like this fell through the cracks.  I'm picking it up.
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> ybendito@redhat.com writes:
>>
>>> From: Yuri Benditovich <ybendito@redhat.com>
>>>
>>> Signed-off-by: Yuri Benditovich <ybendito@redhat.com>
>>> ---
>>>   MAINTAINERS | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

