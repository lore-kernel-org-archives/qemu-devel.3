Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB722C02197
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezAD-0006Nh-8U; Mon, 03 Feb 2025 11:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezAB-0006NR-Qs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:19:07 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezA9-0004a1-RS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:19:07 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso6567060a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738599544; x=1739204344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6JmQhWYBv/7vKIG7Kne6Qi0XIk2WkTX7JMwwDBl4qQ=;
 b=dly2KewTxRGD32vbM9OfMalvyc3/obnlJ4E0pNa6SWnJ/HWi2GTLt5g1DqXszGDuPW
 vspVlMuVDAzmYfMDdWpwU345kpyG+U6VAYmlH2Ew2jIDZzAkJ1S7gxeywGMoFyJ9X4vm
 FJmmo8dq7pj8qUTNrEgtZaDoc+N5g8kcIjNmAbOJkeBfNw3g3dl+ptkT0WWulZ3B/t40
 NjOP78DoZ3I5bl0UzupkGY81Zy+BZI03u3T/u5aZXCzb4HMtgQP4mr4l4Qzd+erzQ5em
 P6HV+deaqRIKY5IBQ+sJJQZzESTK7B1vg/XBncD6yXr3dS5b9I/gCKU4pge3aWKMgj++
 k8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738599544; x=1739204344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6JmQhWYBv/7vKIG7Kne6Qi0XIk2WkTX7JMwwDBl4qQ=;
 b=dnPCPWfGuTYVX1TczogT9q9DNC7ARy8SvAhETi0/aBWZrq3Y8K8GM7TOPT3lClAPWJ
 1q3RHxUidljLRo7ylfBgZeChrlY4LlNfmqVBhEmt5Ee3Hi58twM/2kUaWDnoLLdB09GA
 p2z6809Sp570rZYNFkp/EKtBKtn+U1Gm9Nu1is5SydsZ9dC4kTwQym3skUJcWFvii7rL
 SPtapWKna5xZPACBaXrkMYmaf7EUqSI1VConBMMCRtwGTZcPFzA/50XSlFBeGZSsIvfA
 c5N1EfwLrVk7I94Otqx+aWo1otbruaofciP4J6ki3ml5L4TuOekzWB8keTa4GgWK7C8O
 l0Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhYZUFJpAtTn/f1EA9SR6l/XRIR2kKnxTNpzXPlg56z3TitwEuIGEYYz9sB6GP8hnNsZGy8zMW0oVz@nongnu.org
X-Gm-Message-State: AOJu0YzYjkkkQIBmpysMu7SfRtJrUShdWxnCdUv1pjok/QsFxqQpqh0f
 lEiIKsvidMhQECXuxYihxz1dE5sXQ8Fdn8GSIGhYCgtEXaFHdOs8b6318X3iSzg=
X-Gm-Gg: ASbGncsDPwJCKLzbVD0he/T0nKXpY4H5PJK4euP6vki9k7/9uFvw+fmfP79T7/mmxKX
 yhAbVAiHZwr4Qj5I+PgRtfNQo8ByE2mgjJSJhMdO7DC/i1okRX2SCMJcAAuDY7u1LINFEZUoe1U
 gID1HnF43RPG4umb4b5Hiqx6RldzP+gJrdkFIJBWN5ozybju0qsuThF+tl7Y+Jk/TbbDf/Y0x9h
 3r4OvRum/NL3nPOi9zl26yU/zdJ2ZVIcIp4upqybLH65+Zx8NnTnZXh6MdlMnndgG9b/2Qvy+M6
 Rk1Gv2KNe6rSDRqQAwMrxgsrf7WNgycCNGscS8ZxwHiUsrITPEe4ioiN6o8=
X-Google-Smtp-Source: AGHT+IEhCqGW4p/kPC3C2/4dqKJZ4Emb/N/MU063Ikqk7mo/VIRNc94Pz1I60J8gPBW3czgaDQjHZA==
X-Received: by 2002:a05:6402:13ca:b0:5db:e7eb:1b4c with SMTP id
 4fb4d7f45d1cf-5dc5efbf41amr60307893a12.10.1738599543924; 
 Mon, 03 Feb 2025 08:19:03 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47cf294sm777844466b.41.2025.02.03.08.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:19:03 -0800 (PST)
Message-ID: <7f765a75-d02d-450e-b229-3232d16871c3@linaro.org>
Date: Mon, 3 Feb 2025 17:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Jared Mauch <jared+home@puck.nether.net>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 <87ed0fayoy.fsf@draig.linaro.org> <Z6DTsdf35ApQ0qLU@redhat.com>
 <CAFEAcA8Qigt1EBVgz1D4hon0x4ukLZbZ-jS_KB+ZBH0yi+QCXw@mail.gmail.com>
 <Z6DXmN-ROswsaDAi@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6DXmN-ROswsaDAi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 3/2/25 15:50, Daniel P. Berrangé wrote:
> On Mon, Feb 03, 2025 at 02:45:06PM +0000, Peter Maydell wrote:
>> On Mon, 3 Feb 2025 at 14:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>
>>> On Mon, Feb 03, 2025 at 02:29:49PM +0000, Alex Bennée wrote:
>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>
>>>>> On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>>>
>>>>>> On Sat, 1 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>>>>> - Deprecate the 'raspi4b' machine name, renaming it as
>>>>>>>   'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
>>>>>>> - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
>>>>>>>   respectively 4GB and 8GB of DRAM.
>>>>>>
>>>>>> IMHO (meaning you can ignore it, just my opinion) if the only difference
>>>>>> is the memory size -machine raspi4b -memory 4g would be better user
>>>>>> experience than having a lot of different machines.
>>>>>
>>>>> Yes, I think I agree. We have a way for users to specify
>>>>> how much memory they want, and I think it makes more sense
>>>>> to use that than to have lots of different machine types.
>>>>
>>>> I guess for the Pi we should validate the -memory supplied is on of the
>>>> supported grid of devices rather than an arbitrary value?
>>>
>>> If the user wants to create a rpi4 with 6 GB RAM why should we stop
>>> them ? It is their choice if they want to precisely replicate RAM
>>> size from a physical model, or use something different when virtualized.
>>
>> The board revision code (reported to the guest via the emulated
>> firmware interface) only supports reporting 256MB, 512MB,
>> 1GB, 2GB, 4GB or 8GB:
>>
>> https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#new-style-revision-codes
> 
> I think it would be valid to report the revision code for the memory
> size that doesn't exceed what QEMU has configured. eg if configured
> with 6 GB, then report code for 4 GB.

We need to distinct between physical machines VS virtual ones.

Guests on virtual machines have some way to figure the virtual
hardware (ACPI tables, DeviceTree blob, fw-cfg, ...).

Guests for physical machines usually expect fixed hardware (not
considering devices on busses).

For the particular case of the Raspberry Pi machines, their
bootloader gets the board layout by reading the
RPI_FWREQ_GET_BOARD_REVISION constant value.


What would be the point of emulating a raspi machine with 6GB
if the FW is not going to consider besides 4GB?
Besides, someone modify a guest to work with 6GB, it won't work
on real HW.

>> For Arm embedded boards we mostly tend to "restrict the user
>> to what you can actually do", except for older boards where
>> we tended not to write any kind of sanity checking on CPU
>> type, memory size, etc.
> 
> If we're going to strictly limit memory size that's accepted I wonder
> how we could information users/mgmt apps about what's permitted ?
> 
> Expressing valid combinations of configs across different args gets
> pretty complicated quickly :-(

I'll try to address Zoltan and Peter request to have a dynamic raspi
machine. It is a bit unfortunate we didn't insisted on that when we
decided to expose a fixed set of existing boards in order to not be
bothered by inconsistent bug reports, back in 2019.

Regards,

Phil.

