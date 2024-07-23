Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332E1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 13:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWFFt-0001gG-Qa; Tue, 23 Jul 2024 09:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWFFr-0001ff-Si
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:08:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWFFp-0007x6-WB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:08:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso39513555e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721740112; x=1722344912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KHy9efmbMs/tFLMhDms174ZiL7qcVBoo//hIlvKfP2g=;
 b=FER/UBxBFhJ2hIBX+zxyRPrMc+VvBcDtrWKWBlmR/BWbUKYlNJwp8eBpMpOyrqUYPZ
 2VhAUCnvJlCzNfrc2VGGan23JpgG4E/s1k/bvW0JPVAqqaI9POQRPLHbftwndYZS4l7V
 AyVVGXdpBwrX9TCItiNORSMqSTqeUVJ3SKjQSYKOs0fLd+scqzfLrBwc9gp0YvhABNsu
 D0uYYGrzgjat6MaFx2xNO25WFTdxAUwoQwSU0V2RBlf9EqKDBtpM7TIMnRxeWHBoDIXq
 gJmL+jwCJvwrUHP2kX9MPr6PVsU6zO6yPWEWGHf7MAzZ5pty0pVdVFkVlFH32LMaD86D
 H//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740112; x=1722344912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KHy9efmbMs/tFLMhDms174ZiL7qcVBoo//hIlvKfP2g=;
 b=pmHmFxnvInixRUg8IgEqJ0am0YdbRNdWLT/McDABDTTKWvzI840feZXmLQrP+BiJIb
 Q8whSBwuQnvRCaLRKO1JlfggqsnIcefxJzkn+25pbQvOuu5C00vKtzQUOj2lwzTMn4PK
 NiBSBLRHA+1s0QEw28hxiGcnd0yUkTrFjUgEL0+fSE7suTijTPD2xUSDZzhuw73cqGMy
 FvnHy2MDFJGiJL+wma/W70dmdBP44I73NVBKAL5KkTsWv1smkxgoznc+H9XvbveeVkwe
 guV4sor1f1MpJc3PUSl2otheEKZP/oXlWUUzcBBs9gbBJWpbb7NjzXGAHqFPYAecYHoN
 3wcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9vCRWKca3pMR0IzXW7YX0cEfH9xMM8fbJgS5xqBzYCkr8tl1byFxNw1su5wMA37E5o7S4Eq6R6+6MDUW0anid/5IH8iQ=
X-Gm-Message-State: AOJu0YwnCTCPsx9zL2ZSYDeOk78gaposzPDl01hykM6omsxEwJm634Ca
 W5j4XmNshzNmk2tcgQY2V78ZPyvpvMYX9ychjc4zBxxkF2H6BayRYD/UnQNrnKE=
X-Google-Smtp-Source: AGHT+IEFLc8cg5nHnWVY4nIeNInn4vsdskbnDyYkI2BxzTijdSG7snht6GPDQZy1fdPJuyoxBX/9Gg==
X-Received: by 2002:a05:600c:46cf:b0:426:5f02:7b05 with SMTP id
 5b1f17b1804b1-427dc53b74bmr64602635e9.2.1721740111657; 
 Tue, 23 Jul 2024 06:08:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bab0sm11564354f8f.44.2024.07.23.06.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 06:08:31 -0700 (PDT)
Message-ID: <5a6f76e7-85b3-44cf-97e0-38994a8ecab6@linaro.org>
Date: Tue, 23 Jul 2024 15:08:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU Community Call Agenda Items (July 23rd, 2024)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU devel <qemu-devel@nongnu.org>, #@draig.linaro.org
Cc: Andreas Faerber <afaerber@suse.de>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, bbauman@redhat.com,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, jjherne@linux.vnet.ibm.com,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, mimu@linux.vnet.ibm.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <87ed7kxxzl.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ed7kxxzl.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 23/7/24 11:23, Alex Bennée wrote:
> 
> Hi,
> 
> The KVM/QEMU community call is at:
> 
> https://meet.jit.si/kvmcallmeeting
> @
> 23/07/2024 14:00 UTC
> 
> Unfortunately I won't be able to make it to chair but everyone on the
> invite list should be able to start the call and edit the notes (see
> link in the invite).
> 
> Are there any agenda items for the sync-up?

5 persons joined with no particular topic so the call was cancelled.


