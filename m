Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D21CDD0FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Mgm-0003xX-7W; Tue, 22 Oct 2024 17:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3Mgk-0003x9-9x
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:45:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3Mgi-0007iQ-Bv
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:45:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c805a0753so53327905ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729633511; x=1730238311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZnM6ntIP/B/pJcZOvtXOMQQynVkp6BnyRgAw0610MbU=;
 b=O/IsZRxcw5T1HVi+q/nYydNc6bKdwGnm2JyopEyON5IZaL5fC5Yt3foPcASzNZAVlF
 AF43k2+89gYI48x6u2yGNSsOw9Oa/efMRcuWtWvY2+1pNFpMZszhq/7wTuU9t3xVL73n
 pVtBX74pmDKs4ARed/HRhlFr+NmKxshrtYfMRdgPqfsPhVQxOgC2rM1jmOq/WmyZJ6Sk
 iqk19WQB+mtBPwr7EtPh7uQoaM+0/BDs4bXIt00xMTh/lCnTWxsEHGe5Iqny9QikstaM
 i/CZJN89APRLvIim5x34Ez1n2Rr992Tl/gMaTpirn7hdN3jp2VLksYbjt512a1t9bBIP
 yUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729633511; x=1730238311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnM6ntIP/B/pJcZOvtXOMQQynVkp6BnyRgAw0610MbU=;
 b=eqT9rfYApQnxOLrQJ7ZrJgyjxR0sau4o5OVJ3FAaF4a7Ys1ki1hcb1eYfcKtHRgsES
 OvL8ULPKBckCT2OqeXYYoGA7O7CJ/Ql3CjanEPVYXWt8XQmELs7IBTIoCl+MgfsoXB0Y
 g7tcZx/C9n4Hymzk4B09MXlKV+JU1ek7ksu4xNHQP3OWltW529todHL1e8kOYD8YbxeT
 kbh6vNczzDYxzfIIuGcREEea8Lr6dwNKtqebYPiYEMBkQPZV4nVrqIcBqdeNethzQdIU
 W6XazhoOMVflMf8u8vQAeBkaKAHt44rUQMYKVZINzK7ogN3HKC6P11jzfSZHcAeF5/r8
 GicA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+0YbAURltsHYgPbdGipfdx6rO6Ia9CYcAQXK32VPNc0U2x7aOk9LapdCuh2UdyD4NW9RVXZR9cfpv@nongnu.org
X-Gm-Message-State: AOJu0YyvX1NVnQUiHj9U5pNzRcze1qxF1LeilbrR97A26z21q1vF5y7r
 XEYkJTYFmUGSUxZJUbqzr9RC2iiNvu7trjY44A8MRS8H8303JM2Uf5ONcTH3B9M=
X-Google-Smtp-Source: AGHT+IHoOtagCZAY6Zo/hQbPu2l5XRVUmVA5+ZnMrDptagQgMquyjNoIxko36oEh57cjYwUaBEvsug==
X-Received: by 2002:a17:902:d4cf:b0:20c:b517:d715 with SMTP id
 d9443c01a7336-20fa9e5e89bmr6397075ad.25.1729633510773; 
 Tue, 22 Oct 2024 14:45:10 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0db2c8sm47097885ad.195.2024.10.22.14.45.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 14:45:10 -0700 (PDT)
Message-ID: <2b8cc882-062f-4278-a043-60e2a135f425@linaro.org>
Date: Tue, 22 Oct 2024 18:45:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/functional: Add a functional test for the
 collie board
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Thomas Huth <thuth@redhat.com>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <20241017163247.711244-2-peter.maydell@linaro.org>
 <977b5038-fa06-46d4-946d-f60135ecf106@linaro.org>
 <ZxdO57heifGyI4lw@redhat.com>
 <CAFEAcA9G_VjeUSgGW4b_WihkJ18JtO=a=VFYsrhgL=FYxd4dpg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9G_VjeUSgGW4b_WihkJ18JtO=a=VFYsrhgL=FYxd4dpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62b.google.com
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

On 22/10/24 06:02, Peter Maydell wrote:
> On Tue, 22 Oct 2024 at 08:09, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Oct 22, 2024 at 01:11:31AM -0300, Philippe Mathieu-Daudé wrote:
>>> On 17/10/24 13:32, Peter Maydell wrote:
>>>> Add a functional test for the collie board that uses the kernel and
>>>> rootfs provided by Guenter Roeck in the linux-test-downloads repo:
>>>>    https://github.com/groeck/linux-test-downloads/
>>>>
>>>> This just boots Linux with a userspace that immediately reboots
>>>> the board, so we wait for the reboot log line.
>>>>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>    MAINTAINERS                         |  1 +
>>>>    tests/functional/meson.build        |  1 +
>>>>    tests/functional/test_arm_collie.py | 31 +++++++++++++++++++++++++++++
>>>>    3 files changed, 33 insertions(+)
>>>>    create mode 100755 tests/functional/test_arm_collie.py
>>>
>>>
>>>> +class CollieTest(LinuxKernelTest):
>>>> +
>>>> +    ASSET_ZIMAGE = Asset(
>>>> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/collie/zImage',
>>>> +        '10ace8abf9e0875ef8a83b8829cc3b5b50bc6d7bc3ca29f19f49f5673a43c13b')
>>>> +
>>>> +    ASSET_ROOTFS = Asset(
>>>> +        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/collie/rootfs-sa110.cpio',
>>>> +        '89ccaaa5c6b33331887047e1618ffe81b0f55909173944347d5d2426f3bcc1f2')
>>>
>>> Should we wrap these lines to comply with checkpatch.pl?
>>
>> While we have some line wrapped URLs in the tests already, IMHO they are
>> pretty awful to look at. I think we should make URLs be an exception to
>> line wrapping rules, provided the URL is the /only/ thing on the line.

Clever, fine by me.

> Our style guide already says
> "If wrapping the line at 80 columns is obviously less readable and more
>   awkward, prefer not to wrap it"
> and that's the principle under which I chose not to wrap these.
> 
> (I think of this as analogous to George Orwell's "Break any
> of these rules sooner than say anything outright barbarous"
> rule for writing English...)
> 
> -- PMM


