Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73424C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 23:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf5jq-00084c-AA; Mon, 03 Feb 2025 18:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tf5jl-00084I-NI; Mon, 03 Feb 2025 18:20:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tf5jf-0003ko-PD; Mon, 03 Feb 2025 18:20:14 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ED7554E6010;
 Tue, 04 Feb 2025 00:20:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id pKSBRQrVEwqf; Tue,  4 Feb 2025 00:20:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ACE834E600E; Tue, 04 Feb 2025 00:20:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A7CB574577D;
 Tue, 04 Feb 2025 00:20:05 +0100 (CET)
Date: Tue, 4 Feb 2025 00:20:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>, 
 qemu-arm@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of
 DRAM
In-Reply-To: <7f765a75-d02d-450e-b229-3232d16871c3@linaro.org>
Message-ID: <816f46cb-ad10-e5bc-1ba1-45cf991c0347@eik.bme.hu>
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 <87ed0fayoy.fsf@draig.linaro.org> <Z6DTsdf35ApQ0qLU@redhat.com>
 <CAFEAcA8Qigt1EBVgz1D4hon0x4ukLZbZ-jS_KB+ZBH0yi+QCXw@mail.gmail.com>
 <Z6DXmN-ROswsaDAi@redhat.com>
 <7f765a75-d02d-450e-b229-3232d16871c3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-441919731-1738624805=:61971"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-441919731-1738624805=:61971
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Feb 2025, Philippe Mathieu-Daudé wrote:
> On 3/2/25 15:50, Daniel P. Berrangé wrote:
>> On Mon, Feb 03, 2025 at 02:45:06PM +0000, Peter Maydell wrote:
>>> On Mon, 3 Feb 2025 at 14:33, Daniel P. Berrangé <berrange@redhat.com> 
>>> wrote:
>>>> 
>>>> On Mon, Feb 03, 2025 at 02:29:49PM +0000, Alex Bennée wrote:
>>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>> 
>>>>>> On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>>>>> 
>>>>>>> On Sat, 1 Feb 2025, Philippe Mathieu-Daudé wrote:
>>>>>>>> - Deprecate the 'raspi4b' machine name, renaming it as
>>>>>>>>   'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
>>>>>>>> - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
>>>>>>>>   respectively 4GB and 8GB of DRAM.
>>>>>>> 
>>>>>>> IMHO (meaning you can ignore it, just my opinion) if the only 
>>>>>>> difference
>>>>>>> is the memory size -machine raspi4b -memory 4g would be better user
>>>>>>> experience than having a lot of different machines.
>>>>>> 
>>>>>> Yes, I think I agree. We have a way for users to specify
>>>>>> how much memory they want, and I think it makes more sense
>>>>>> to use that than to have lots of different machine types.
>>>>> 
>>>>> I guess for the Pi we should validate the -memory supplied is on of the
>>>>> supported grid of devices rather than an arbitrary value?
>>>> 
>>>> If the user wants to create a rpi4 with 6 GB RAM why should we stop
>>>> them ? It is their choice if they want to precisely replicate RAM
>>>> size from a physical model, or use something different when virtualized.
>>> 
>>> The board revision code (reported to the guest via the emulated
>>> firmware interface) only supports reporting 256MB, 512MB,
>>> 1GB, 2GB, 4GB or 8GB:
>>> 
>>> https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#new-style-revision-codes
>> 
>> I think it would be valid to report the revision code for the memory
>> size that doesn't exceed what QEMU has configured. eg if configured
>> with 6 GB, then report code for 4 GB.
>
> We need to distinct between physical machines VS virtual ones.
>
> Guests on virtual machines have some way to figure the virtual
> hardware (ACPI tables, DeviceTree blob, fw-cfg, ...).
>
> Guests for physical machines usually expect fixed hardware (not
> considering devices on busses).
>
> For the particular case of the Raspberry Pi machines, their
> bootloader gets the board layout by reading the
> RPI_FWREQ_GET_BOARD_REVISION constant value.
>
>
> What would be the point of emulating a raspi machine with 6GB
> if the FW is not going to consider besides 4GB?
> Besides, someone modify a guest to work with 6GB, it won't work
> on real HW.

Usually the point of such non-standard configs would be running Linux via 
-kernel which could use whatever is configured if it has a way to detect 
it or maybe for memory it could even be specified on the kernel command 
line. But maybe this is not a common enough config to support so reporting 
error for memory size that's not on the list of valid sizes might be 
enough. This is similar to qemu-system-ppc -machine sam460ex which has a 
memory controller register that can only describe existing DIMM sizes. 
Originally I allowed users to specify whatever memory size and only warn 
for sizes not matching a DIMM size because Linux only looks at the device 
tree which QEMU can generate when booting with -kernel so it works but the 
firmware detects RAM from the SPD data and can only support certain sizes 
so only less RAM that could be convered with SPD data would be visible for 
guests. But then others thought it's better to return error for such cases 
and changed it and removed the support for arbitrary memory size so now it 
returns error when non power of 2 memory size is specified.

Regards,
BALATON Zoltan

>>> For Arm embedded boards we mostly tend to "restrict the user
>>> to what you can actually do", except for older boards where
>>> we tended not to write any kind of sanity checking on CPU
>>> type, memory size, etc.
>> 
>> If we're going to strictly limit memory size that's accepted I wonder
>> how we could information users/mgmt apps about what's permitted ?
>> 
>> Expressing valid combinations of configs across different args gets
>> pretty complicated quickly :-(
>
> I'll try to address Zoltan and Peter request to have a dynamic raspi
> machine. It is a bit unfortunate we didn't insisted on that when we
> decided to expose a fixed set of existing boards in order to not be
> bothered by inconsistent bug reports, back in 2019.
>
> Regards,
>
> Phil.
>
>
--3866299591-441919731-1738624805=:61971--

