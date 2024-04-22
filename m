Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E461C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytsn-0004Fm-Qx; Mon, 22 Apr 2024 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rytsm-0004FH-DJ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:38:56 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rytsk-0006iP-GS
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:38:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57215beb016so297830a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713793132; x=1714397932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=M66w4ZMk2jUV5zE9y1t/5ZKvJPgqA4sXDNh2QHRZ59k=;
 b=BbKTVLC3zDg3GUsZN8LIFRHo+0rOLSQNhf7/yijIfBadDvYBdbBkcs9vO+Y0KcueZ8
 uUYeCoEfDRvlJt6EP3CL0X6oiurA9VpqLRG9kN8NvNYnb3hIucJPkiHcrCfzzgE5AKFM
 IqeH7u+sH6mYauKsYTC0KZ8fQPWe1VbLDHFmJc7vNVScLDrgPTeO/b9HTOgIKRhWvpa0
 k/+gGJevaAuk4kj+0HVJaNSVRSVL4qKwmKKGwEvPMljh0EJ0zTZQQ/aDKJr0GqO/lsUV
 5mNkS97JSSmalAvJz+Mkh2HCzAMIgQu9gLuUS7+joUgIblBFfRTa/jEcQEKNuIFsA0s/
 +Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713793132; x=1714397932;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M66w4ZMk2jUV5zE9y1t/5ZKvJPgqA4sXDNh2QHRZ59k=;
 b=AKyzeJN09GcOjT6yRPFda+ktS1QGrL+w6ywcTKIX1EVr6GOCGHRKh5BFstAVyYvPqy
 fKdAYAWPo10Y2m0x922JEKfW1FEb1jtq74vntQXYTV8JFBgu0BZll35ATEgplQGCJKDJ
 XQb+eNvvjawh0Iptw12A2oZwhqWGjSuR4/OsxSxgZJWA5kxnR+7a5dOTe3MdSOrsmXHz
 XaZncOytBcvv1MZotlvak8Gid8H1j/0fgq56dJFvFM5HeKpCNJ9Jg1+1kcyG13NMrk/h
 iCco9QQYpp1uFZLqL/QOhAPxYaJ3qVyJoXxKKdz9il258IMYa7UcvTKRZgO6fumTLT8F
 UBqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhkt0ZICeslSnI3hZPx+susHWiGMMUGlVodIwrh8pw3Xtm+3n1TOdzfe82FYFu4xeiz5gZaS4UP1eOW/oR5IqvCLk2j00=
X-Gm-Message-State: AOJu0Yz6KE+LfkIM50ziZP+UhAmMv+bvNX5BAfnVMNBdIhGnv8hbXOK7
 osdwb/EKbkTnKlBY3qGaSXACIuua8viKDREtMnJqupyTg2hqqH03q6TbfdETkfM=
X-Google-Smtp-Source: AGHT+IE8N096uPHgUTbmr+Lz7i1MruxsOOZkoRL1CTr9f8B4K8uCnGVRIzbLQu+eGqtlMsWhzqqaWw==
X-Received: by 2002:a50:d658:0:b0:56e:34db:f5ef with SMTP id
 c24-20020a50d658000000b0056e34dbf5efmr6311370edj.28.1713793132353; 
 Mon, 22 Apr 2024 06:38:52 -0700 (PDT)
Received: from [192.168.200.106] (83.11.0.31.ipv4.supernova.orange.pl.
 [83.11.0.31]) by smtp.gmail.com with ESMTPSA id
 ij6-20020a056402158600b005705bfeeb27sm5514568edb.66.2024.04.22.06.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:38:51 -0700 (PDT)
Message-ID: <c84bfac7-5fb5-4fca-90a3-93adb40bcf3c@linaro.org>
Date: Mon, 22 Apr 2024 15:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52f.google.com
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

W dniu 22.04.2024 o 14:56, Peter Maydell pisze:
> On Fri, 19 Apr 2024 at 19:46, Peter Maydell <peter.maydell@linaro.org> wrote:

>> The upshot is that the only CPU type that changes is 'max'; but any
>> new type we add in future (whether v8.6 or not) will also get the new
>> 1GHz default (assuming we spot in code review any attempts to set
>> the ARM_FEATURE_BACKCOMPAT_CNTFRQ flag on new CPU types as a result
>> of cut-n-paste from an older CPU initfn ;-)).
>>
>> It remains the case that the machine model can override the default
>> value via the 'cntfrq' QOM property (regardless of the CPU type).
> 
> This patchset turns out to break the sbsa-ref board: the
> Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
> avocado test both (a) takes rather longer to boot and (b) when
> running thinks that time is advancing very fast.
> 
> I suspect this may be because the firmware hard-codes the
> generic timer clock frequency it is expecting. I've cc'd the
> sbsa-ref maintainers: is that correct?
> 
> If so, we can deal with it by making the sbsa-ref board set the
> cntfrq QOM property on its CPUs to force them to the old
> frequency. However this will produce a technically-out-of-spec
> CPU when used with a v8.6-compliant CPU type, so probably we
> should do something to be able to tell the firmware the clock
> frequency (if it doesn't want to just read CNTFRQ_EL0 itself).

 From what I see in EDK2 code we read CNTFREQ_EL0:

GetPlatformTimerFreq() checks for PcdArmArchTimerFreqInHz variable which
sbsa-ref has set to 0. So it calls ArmGenericTimerGetTimerFreq() ->
ArmReadCntFrq() -> "mrs x0, cntfrq_el0"

I added debug output to firmware and it shows me:

HRW: GetPlatformTimerFreq TimerFreq = 62500000

Local tree:
ed0604e99c (HEAD -> test-counter) target/arm: Default to 1GHz cntfrq for 'max' and new CPUs
c0a8c341f5 target/arm: Refactor default generic timer frequency handling
592c01312b hw: Add compat machines for 9.1
62dbe54c24 (tag: v9.0.0-rc4, origin/master, origin/HEAD) Update version for v9.0.0-rc4 release
a12214d1c4 (origin/staging) usb-storage: Fix BlockConf defaults

sbsa-ref with "-cpu max" used. All cpu cores give me same value.

