Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F32D132BF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wv7-0005af-5P; Mon, 04 Nov 2024 08:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7wv4-0005aH-Mt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7wv2-0007X0-IL
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730726095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zBdLxOtct1jI3R7L4hg7Uj0l2W/4sY/QbfjGDemHWiQ=;
 b=X4quj8/S05z6WMhF05iMAIH0iXXZS1xXviF4FuGj/8UowdTSghsqO4x9Pyi1DA4+DTumif
 Q9sOxZ5TeAJOMCagzVQ/doSraReCX2Lw+f/jd3Z8s0Q2yQcC8IgPpgyUchszHXWElCGSc7
 fzOK38o0zb2owSNGt2QHezJ0hr9Omlg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-eVpB3dJ1OAWXIIUZAZVHcQ-1; Mon, 04 Nov 2024 08:14:53 -0500
X-MC-Unique: eVpB3dJ1OAWXIIUZAZVHcQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso26620005e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730726092; x=1731330892;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBdLxOtct1jI3R7L4hg7Uj0l2W/4sY/QbfjGDemHWiQ=;
 b=IRtFpanjNOxpljBK0FvkTqxQxPaVlJOIjj7sZPGHIzJTGPTVXOsRTHskUgynJ/5guI
 jwQqeYD/xgzKHYBVXxrv5tQo3XwncBuSjkz7jwmHyLTXB0qXbvhDbBWsDqccPHHFxl3/
 OwIRlAieqRVz1fh26Pl/FNG+GuobsIwtS6tg3+HgJ0h0hOu7kptXJ7AB8lVpfvxG9I1c
 Xod1cgsPbnbs3CoM2u7i4Gu8ac+l8lVBkPx4oApsDO0QJjgQ0sOfXjYIsH/ARQGTOt8a
 HhHd9/N64HozM1kpGZqRIQIrSkiWiJi5cGMY8z+20Pv53BSB8IlCROw6yjjd/rT9JI3l
 C6xA==
X-Gm-Message-State: AOJu0YweNoZJqzuPGo2JdGGIOwxxP9F4G8GZpFN6fmrRThNHdmpKbnGP
 QUORW95FpBS5Kd9riG+0lw0TK09iEI4h6B3Ojm+raRAscixjLTO3A1XUFQon93ChHdofq7eaZ/W
 BWqkmbmneni9TtF0g/B7skXTBy3vmz2KMQoCMpIMNzRsRcIHcYra5
X-Received: by 2002:a05:600c:4e91:b0:431:4f29:4a98 with SMTP id
 5b1f17b1804b1-4319acbaac3mr264290845e9.20.1730726091912; 
 Mon, 04 Nov 2024 05:14:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBaeoTLFQSUi583/dx9H7DbfoUCUJkMdj+5SXU2yGP+5NvZ9viN1pZOc2Q6S4OrgrmY2JHMg==
X-Received: by 2002:a05:600c:4e91:b0:431:4f29:4a98 with SMTP id
 5b1f17b1804b1-4319acbaac3mr264290655e9.20.1730726091516; 
 Mon, 04 Nov 2024 05:14:51 -0800 (PST)
Received: from [10.33.192.239] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7392sm13160029f8f.55.2024.11.04.05.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 05:14:51 -0800 (PST)
Message-ID: <0d10b58c-25c2-4f3d-be25-51d9b650cc6d@redhat.com>
Date: Mon, 4 Nov 2024 14:14:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] Misc patches (functional tests, next-cube machine,
 ...)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, QEMU RISC-V <qemu-riscv@nongnu.org>
References: <20241031174832.6574-1-thuth@redhat.com>
 <CAFEAcA90nvvYoK52Yv4kdgRwJ+WyFRP9sW_U0gKdD4reaUGCFg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA90nvvYoK52Yv4kdgRwJ+WyFRP9sW_U0gKdD4reaUGCFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/11/2024 13.31, Peter Maydell wrote:
> On Thu, 31 Oct 2024 at 17:48, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:
>>
>>    Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-31
>>
>> for you to fetch changes up to d73ad1b1c0e62976d4790606ee29725a0d8a8906:
>>
>>    tests/functional: Convert the riscv_opensbi avocado test into a standalone test (2024-10-31 07:57:47 +0100)
>>
>> ----------------------------------------------------------------
>> * Remove the redundant macOS-15 CI job
>> * Various fixes, improvements and additions for the functional test suite
>> * Restore the sh4eb target
>> * Fix the OpenBSD VM test
>> * Re-enable the pci-bridge device on s390x
>> * Minor clean-ups / fixes for the next-cube machine
>>
>> ----------------------------------------------------------------
>> Daniel P. Berrangé (2):
>>        tests/functional: make tuxrun disk images writable
>>        tests/functional: make cached asset files read-only
>>
>> Mark Cave-Ayland (2):
>>        next-cube: fix up compilation when DEBUG_NEXT is enabled
>>        next-cube: remove cpu parameter from next_scsi_init()
>>
>> Thomas Huth (10):
>>        .gitlab-ci.d/cirrus: Remove the macos-15 job
>>        Revert "Remove the unused sh4eb target"
>>        tests/functional: Add a test for sh4eb
>>        tests/vm/openbsd: Remove the "Time appears wrong" workaround
>>        tests/functional: Fix the s390x and ppc64 tuxrun tests
>>        hw/s390x: Re-enable the pci-bridge device on s390x
>>        tests/functional: Convert the tcg_plugins test
>>        tests/functional: Convert BananaPi tests to the functional framework
>>        tests/functional: Convert the OrangePi tests to the functional framework
>>        tests/functional: Convert the riscv_opensbi avocado test into a standalone test
> 
> Hi; the opensbi test seems to consistently time out on the s390 CI job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/8260596592
> https://gitlab.com/qemu-project/qemu/-/jobs/8260043983
> 
> 789/972 qemu:func-quick+func-riscv32 / func-riscv32-riscv_opensbi
> TIMEOUT 60.04s killed by signal 15 SIGTERM
> 791/972 qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
> TIMEOUT 60.04s killed by signal 15 SIGTERM

Oh, interesting, that looks like a recent regression - running riscv on 
s390x hosts used to work last week, but with the current master it seems to 
be broken.

I'll respin the pull request without this patch (so that the other fixes are 
not blocked by this), while trying to find out where riscv breaks on big 
endian hosts...

  Thomas


