Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FCBE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 07:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXbeO-0004nN-JC; Tue, 14 Jan 2025 02:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tXbeM-0004mw-UR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 02:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tXbeL-0006Dc-7T
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 02:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736840862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YeH0PlAxfXb8b1NkU0F6Ttas+EobPPuKBZANUV6MO7E=;
 b=XVSqpHQSAoJe7hOcPwVZTsFUOVBfZ5JXYU/5Mq9J68zr4pUOMQDtgSqoF+1nSCP7aeK4R+
 lKD/iBkIq/z8d/OhFV1dAqhSn0xivlXSUrEBrjkYwp3xHQ7mobxUY4ysEV0xBF6naWjBRJ
 uVs4ay+wLboMW/rmQR+hDCG2oqZAlqA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-S2pFrVcDOGCn5H3DXpYPoA-1; Tue, 14 Jan 2025 02:47:40 -0500
X-MC-Unique: S2pFrVcDOGCn5H3DXpYPoA-1
X-Mimecast-MFC-AGG-ID: S2pFrVcDOGCn5H3DXpYPoA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436225d4389so26476275e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 23:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736840859; x=1737445659;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeH0PlAxfXb8b1NkU0F6Ttas+EobPPuKBZANUV6MO7E=;
 b=WfLMGTQE+svBjHESGI23ISkIDGr4HYPHKPuUPHzWIS5ONg0Za3pc/LD8KYM5jx8If2
 NODniiflxfrJYIMfLHop9l5iShQ9Dnq0jWupweeSsbiYd3YL9407EqlAfB6lHCs9WW96
 tE37syxNt1XnslbKZaL/aFjHKzIWfmGnMUV+GR3veoTYNcE/ZvwTe4F1MGpHoWdVm0nG
 wFVzjWnQ9DbsUe0Ra26x8rNiCaMxPIYpdzf4U07dlDEwKfZJD02tBfGk0U7KrLKzI48V
 8x+kYYPRlQGox/VKIaoRLbPAiWepFmfflA93/0N4lVdGLyVC/wfysI6nM5EoemSI8smy
 d7eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2wvDMP09hSinMuqPpELiF8T1kehQD2oLGfydnf/e7c3zRYQI/isgKebs1uot1EoUUq0g/gdZlfyBD@nongnu.org
X-Gm-Message-State: AOJu0Yzc+Q9c2bmz7rX+xQnIjznI6/fGi1guGDE4Dn23pz9B+ONPWnDm
 7RAXxJ1WjEM0yzgfMSqF/zsWHFYVRG3s2d5En7f6n2HKeMRPK2+cFoRzgWuRt1mpovksdomeI9M
 3lWG1yzR4CinSExoECn447mh8gVBajjrTQKmviQ6UcQsiyNxeNqmB
X-Gm-Gg: ASbGncszcE/DRkKSBnPZM1AnOSFyRoGYjVw7zmJJjB7efAjU3ffdFIBvPvL4iKCXGVP
 /e3B2a0smkg344zUpDNAwyAswKGHkCtSIvGh95TjVIerzIAu06lM/+NhPyYqob9nAVaRYB0Ix9E
 IM+R6m32M77F1stJFTOc6Wg7u4xOjz0t3STHTWAtzBZu0+MqrnXSvurWbzvEP0m/TMU1cljD6J0
 hyF9qzsjT/rN40zchMxoHf+yUu6d0tSpfBPqbp1vLWvUKnqhECaWl1m5oMnR9PTTg++FX5CCdgL
 +v6wKOpF1ScpfikRFIY=
X-Received: by 2002:a05:600c:4749:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-436e9d6ff7bmr139831035e9.6.1736840859578; 
 Mon, 13 Jan 2025 23:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEmgAKe0ntMa53aUwDfcVFfnOvo7J/kOguFkelPiVLLyJQzUjhEBorDvLkEDtRyIiJ4jxFfA==
X-Received: by 2002:a05:600c:4749:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-436e9d6ff7bmr139830885e9.6.1736840859234; 
 Mon, 13 Jan 2025 23:47:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1d13sm14237926f8f.91.2025.01.13.23.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 23:47:38 -0800 (PST)
Message-ID: <bd1941e9-bc24-4bed-9f27-3020ae6ab54d@redhat.com>
Date: Tue, 14 Jan 2025 08:47:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
To: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
 <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
 <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <D71LX5ZNBHSB.9MP9IHEN5WLU@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/25 08:11, Nicholas Piggin wrote:
> On Sat Jan 11, 2025 at 2:25 AM AEST, Richard Henderson wrote:
>> On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
>>> Hi Cédric,
>>>
>>> Cc'ing Laurent & Richard for user emulation.
>>>
>> ...
>>> The deprecation message (see previous patch) was about the
>>> "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
>>> for user emulation?
>>>
>>> $ qemu-ppc -cpu help|fgrep 405
>>> PowerPC 405d2            PVR 20010000
>>> PowerPC 405gpa           PVR 40110000
>>> PowerPC 405gpb           PVR 40110040
>>> PowerPC 405cra           PVR 40110041
>>> PowerPC 405gpc           PVR 40110082
>>> PowerPC 405gpd           PVR 401100c4
>>> PowerPC 405gp            (alias for 405gpd)
>>> PowerPC 405crb           PVR 401100c5
>>> PowerPC 405crc           PVR 40110145
>>> PowerPC 405cr            (alias for 405crc)
>>> PowerPC 405gpe           (alias for 405crc)
>>> PowerPC npe405h          PVR 414100c0
>>> PowerPC npe405h2         PVR 41410140
>>> PowerPC 405ez            PVR 41511460
>>> PowerPC npe405l          PVR 416100c0
>>> PowerPC 405d4            PVR 41810000
>>> PowerPC 405              (alias for 405d4)
>>> PowerPC 405lp            PVR 41f10000
>>> PowerPC 405gpr           PVR 50910951
>>> PowerPC 405ep            PVR 51210950
>>
>> Up to the ppc maintainers.  I don't know of anything interesting at the user-only level
>> wrt these cpus.
> 
> Just getting back to things after the break...
> 
> We are looking at modeling some microcontrollers on the POWER
> chips. There is an OCC power management controller which is a 405
> and some other weird cut down 405 derivatives, we're not up to
> those yet but we want to model them.
> 
> We should be able to remove a bunch of boards and CPUs, I just
> haven't started looking, so might be easier to wait for a bit.
> If it's not causing others too much problem, could we leave this
> in for the time being?

Sure. We will need a new SoC for the OCC and a firmware image. I think
these can be built from https://github.com/open-power/occ or, if not,
they should be made available.

Thanks,

C.


