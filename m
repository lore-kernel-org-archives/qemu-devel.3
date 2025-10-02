Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A12ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 06:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Csx-0001TL-GS; Thu, 02 Oct 2025 02:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v4Cso-0001SD-BU
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 02:33:44 -0400
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v4CsS-0008OT-IQ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 02:33:31 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.252])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4cchn91dVSz5xyP;
 Thu,  2 Oct 2025 06:33:01 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Thu, 2 Oct
 2025 08:33:00 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0063673733e-4d42-4dc3-a209-83a7baf98e1f,
 3289BCBDFD1086C5677F9DFD0C8EC2DEF9D0CC42) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <949cc59c-d5eb-4550-9cab-1abd53b19513@kaod.org>
Date: Thu, 2 Oct 2025 08:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
To: Patrick Williams <patrick@stwcx.xyz>
CC: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>, "open list:All patches
 CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley
 <joel@jms.id.au>, Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>, Peter
 Delevoryas <pdel@fb.com>
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
 <0165086d-3ab4-4986-84ff-452984d16153@kaod.org> <aN3ht1MdFppiDcPz@heinlein>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aN3ht1MdFppiDcPz@heinlein>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: b6d5c78c-45f4-4c45-a9b2-07d4b2ee487a
X-Ovh-Tracer-Id: 2061804206045563826
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEvE8MH0JYc2dC86obgQXi4Z1plEhb1olXRXhXlNlnTdP7qxTUq9VYW5cg1DBYis0FAX3pwwb/QtaHqjcHI+fOnleZk+Z6p4Fd1rUZPGKexm8atheaiHDfSgAvmohvBrk68nHY4JqP8EAAk+925DK5nkjf0tbwFlsBf4+qdRnZowu7Bb/I0I1I0lTukhI+0peaZFdcqVJgIr7lnLRM5suYKTyKqwmEtHn5PeGNJN1h1acFlaZraI5lWBwPtY7bbygmb+O7iNijHh1nDb84TqtcUFgZBi+c1OfPzGHY+mMDNfup87rk1ouPpf5r9U5c/yRxav6UREftlfu5f/BItShCbrkwl7a07+dmITb4BPpgpLBMRdiWaeydRaE0Z7eylZUmUmjurux+O9GvSmhm+bJnrZeqSWeaGV5ZQqS5MGFHgOae68DxlwJrC10HQrO5t245bmIxTbRVPFixGyeWoFDlzPsIyr+NlxHE8NXT1DM0nHZcyYF2/16qaohjbQGVwBqajpFb+pKYe6ewrz4d+LMZWjNb6ntnwBNcgdksRCNjikG+HONMtBarmTznfWGYnMAwSZiC4nvKXoEE9lnAEhnEYU7wBZbrjKpBBmsLrKTUKuEJ3QQ5BrtuOlYcWqJ9MoEUYfp9ji9ZS6jb7xlt7CjBZdzgPu0GnZT43BFPtxpgBMw
DKIM-Signature: a=rsa-sha256; bh=Lnr3EAB9ep6FPnWLuszLSFNJO0gBlf+stX1hXPd+AJo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759386782; v=1;
 b=fvtlEZrh/QCCAo8sW/htTGirfHTWUyXX4IdVOU8KS9e5BKIpSQ2HmwCESUWa13sgkkcnaqJj
 038ZF+Bh3wtD5xJdEoka//xrgpqGLUV+Dx3PVIxuN/sRBFnNzh2XAntNiL9i4MKFT1g7epxKAVp
 JxOo2rVy6Mh5J4AGqkPY5v+nBrGz79BVvVoV+2CTd03tXhb7npwICd1Ocy03V5rIb0SWnGI8T59
 88uobF38HTrXjTIu8qhghMBff0xMGGXK0lzunqUt/AfMzkilu9RTQjK1WH4Km5w0+zobo2Ph0ym
 6Y1vllnBwlGAMt7AJzzRkZMSCEvzef5xR+cmmLEDbw/xA==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=clg@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello Patrick

On 10/2/25 04:21, Patrick Williams wrote:
> On Tue, Sep 30, 2025 at 07:51:15AM +0200, Cédric Le Goater wrote:
>> Hello Patrick
>>
>> Would it be possible to contribute a functional test for this
>> machine ?
>>
>> The request applies to these Facebook machines :
>>
>>     sonorapass-bmc
> 
> This machine type is deprecated and never went to production.

OK. Let's deprecate then.

> 
>>     yosemitev2-bmc
>>     tiogapass-bmc
>>     fuji-bmc
>>     fby35-bmc
> 
> All of these are used by OpenBMC and/or Meta for QEMU validation of
> new BMC images.  I can get you an image for these if necessary.

That would be great ! Pointing to the latest images would be preferred.
  
>> Since these machines contribute little to the Aspeed models,
>> their value lies in the firmware they can run to exercise the
>> models. Without functional tests, I plan to schedule their
>> removal in the QEMU 10.2 cycle.
> 
> I don't understand this statement.  What does "little value to the
> Aspeed models" have to do with keeping machines in place. If we are> only going to have support for machines that you deem as "valuable" why
> would anyone contribute a new machine?  

This is specific to the Aspeed machines.

We maintain *many* Aspeed machines with only minor differences. If
the only distinction is the flash model, the 'ast2600-evb' machine
can be used with the 'fmc-model' option to specify the flash type.

The I2C devices attached to the board do introduce differences, but
if upstream is to maintain the QEMU machine, there must be a way to
test it. By the way, I liked the idea of introducing a file per
machine.

Finally, without tests, it is harder to determine when something
becomes deprecated/unused.

> Is this a new policy that QEMU
> only wants specific machine models for any particular SOC?

This is not a new policy, but it is strongly recommended to have
a way to test the machine, and I try to enforce that. However, if
someone indicates that a board is being used for kernel testing
but lacks an image, I consider that sufficient to conclude it is
not deprecated (and that providing a functional test is possible ;)

I hope this clarifies the intentions. It's more about making tests
available than limiting contributions.

> 
>> The fby35-bmc value is in its multisoc nature. We now have the
>> ast2700fc available as its replacement
> 
> We actually don't use the multisoc aspect of this machine.  I'd be fine
> if we drop those pieces specifically but the general "can the BMC image
> boot" is regularly used.

ok. I am fine with that if we don't need to boot the coprocessor.
Peter provided me images in the past (2022) and I am using :

   $qemu -machine fby35 \
      -drive file=$flash,format=raw,if=mtd \
      -device loader,file=Y35BCL.elf,addr=0,cpu-num=2 \
      -nographic  -display none -serial pty -serial pty -serial mon:stdio

and it seems that without Y35BCL.elf, the machine crashes.

Thanks,

C.



