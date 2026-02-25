Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA03F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6Rm-0000c4-SA; Tue, 24 Feb 2026 23:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6Rk-0000bd-4g
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:24:24 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6Ri-0005c1-KA
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:24:23 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so2063085d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993460; x=1772598260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=daxhZ0+p67TLJVoLT0Rahir0z9/SxFpm/cDkdV+GqiM=;
 b=mcoDpfhZU7AY7JUtcIzXyFmgg3rBdJVwV6ybS/FAdOCE9SKtxqz5hbLFzrUbA1iUDZ
 2rpcZtbxCIOMEIR8yawSzrrYWsaiHdXqh/Cbs2PldNVsDD+ymJhHZUUaqGJfskHuRy3k
 tFGnI1N1f+xPxRw7559XV/vM6zCL5hDiN/ZK5rC2fKnbDfso1F2Qdc9/G2Wi7NJKh6yC
 WgoX2dOxnCU0OudJKVrFFKv+z6VqA7iedj07EGDDnIhaX7Np9U7lMlMej/5cOhpQGrGR
 78LRvfjBBw9OCve7Em7LRT9vsI621+9qKM1GY5WEPMqAX8jAg/VYkzVx0tCPw0ZsuRrY
 3lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993460; x=1772598260;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daxhZ0+p67TLJVoLT0Rahir0z9/SxFpm/cDkdV+GqiM=;
 b=XbY7lpE94tWFWLmia8MhWp0lJn0xknIuojfnGbVB3JTVPzu+Ghg7Tli5QQHOHwNhzn
 hSfybZHFI5/4PEeRVHf17VKUoWw8l/ETxRpzyAb32KFEorNIRcTVcQ0VzdLBeNCgBPmP
 izSYx5jQ04Tj5xPD24FgQ01OVY7PIUzPZi8ZYJsQMEpo79PUNlAb0xzmOwo2IRmCAFRE
 zI6lYZgMw+xULTFoV09Woa3auP3JkmkK7Fkha6FKBo2dcFmn2m5oS6glqIqp+/Q96WJD
 471UeYhNGXffaaHpzPBwJuZuGKfYcQuX0jp9zi57ixRNTit8BRLpYsoxYqKFraPZQzr1
 glTQ==
X-Gm-Message-State: AOJu0Yxr/n6KgnlAZrCrutcd1ih6uhrPD+zzQkXTQHUksU3SdFIrP4Tk
 k6ztfT6jEBsFitANFkyizHPHjyQZNS3UeWK21uEikEXiptKBaiqKv9OuTgf6ZC1Tpdk=
X-Gm-Gg: ATEYQzxuXsEGRxLXZt1RhW1nPYPGqVo2mPvK1XsJimVQiDwgOQ/8gJ1N6j7Uxo8QXpE
 iQSmw5S+S1kPtRuPlV62BJ2PjkhgTBcGToFM1Syr609oq+wyEvkNeb2es3Jxq/tvzAUrP0b+T11
 LvknZUCUY+to+i+TzE2TJuNix0lJN3RfwMfHqLUV9as+VaT9nig8tTJrCD8atlplvihkqo73Duw
 qrF9Hj/QclchgAGutrANmgeWAKqI4GZAhUzgeBDOmCYH9hl3/19RpjQh4CHAf6InPNwKnetXvF/
 lmmMNWacIAYSBOd8uIc89GPO8/fuiuCbB1tATQPF/XBcndjMWSTAl1wKHcHHBXU4NuZlnDDsWrI
 bFdeZhBmX5AbuMTYxdoiqIYRPnuGt+Fbz2BY+8IOuOfpm0oKf5nLzTiEqP+SmcuJifEwSSJDjHm
 vaeSIknd9UyN5ny5UTCS9MqUatVFGDipJ6n2Yg4gIchNnRozgGM1kWGvJSUePgR1A=
X-Received: by 2002:a05:690e:168d:b0:64a:e3dd:58d0 with SMTP id
 956f58d0204a3-64c786d10a1mr12354405d50.15.1771993460507; 
 Tue, 24 Feb 2026 20:24:20 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-64c7a2520b6sm5106487d50.2.2026.02.24.20.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:24:19 -0800 (PST)
Message-ID: <9cfa73f6-824a-4c35-8c1a-05d28d58c437@linaro.org>
Date: Wed, 25 Feb 2026 15:24:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] target/arm: Support SME for KVM
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <CAFEAcA9ChSZchdz+17-ee3CzWK6g_BsbEz9_DQ--F+Ek037JLA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9ChSZchdz+17-ee3CzWK6g_BsbEz9_DQ--F+Ek037JLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb130.google.com
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

On 2/25/26 04:08, Peter Maydell wrote:
> On Mon, 16 Feb 2026 at 03:45, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> RFC mostly because the kernel support is not yet upsteam.
>> This is based on
>>
>> https://lore.kernel.org/linux-arm-kernel/20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org/
>>
>> Properly testing this will take more time.  I'm not 100%
>> sure how to confirm that the SME registers have the correct
>> value across migration.
> 
> Am I right that patches 2-8 in here:
> 
>>    target/arm: Remove aarch64 test for kvm
>>    target/arm: Move kvm_arm_sve_get_vls within kvm.c
>>    target/arm: Init sve_vq in kvm_arm_set_cpu_features_from_host
>>    target/arm: Move kvm test out of cpu_arm_set_sve
>>    target/arm: Drop kvm_arm_sve_supported
>>    target/arm: Remove kvm test in arm_set_pmu
>>    target/arm: Drop kvm_arm_pmu_supported
> 
> are preparatory cleanups that don't depend on the new
> linux-headers changes?
> 
> (also maybe 10 and 11)

Yes, 2-8,10,11 could all go in now.

r~

