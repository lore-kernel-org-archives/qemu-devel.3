Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8766EC43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaWQ-0003y3-SD; Fri, 03 Jul 2026 05:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wfaWO-0003x8-OS; Fri, 03 Jul 2026 05:49:20 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wfaWL-0002Bi-NK; Fri, 03 Jul 2026 05:49:20 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gs88v5Cq2z3x2s;
 Fri,  3 Jul 2026 09:49:03 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Fri,  3 Jul 2026 09:49:03 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.226])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gs88v2Qtxz60Mh; Fri,  3 Jul 2026 09:49:03 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 9C077203D39; 
 Fri,  3 Jul 2026 09:49:00 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002513ba408-9442-4f3d-ac51-f6d38745d995,
 14A058C55D6A6F230EBDD70A449A090D8A18B59A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <5a1a6a39-a333-49c5-bf99-1d482a839f5a@kaod.org>
Date: Fri, 3 Jul 2026 11:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/i2c: parent slaves created with
 i2c_slave_create_simple
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
References: <20260627-i2c-adc128d818-anacapa-v3-0-cfb94270a980@meta.com>
 <20260627-i2c-adc128d818-anacapa-v3-3-cfb94270a980@meta.com>
 <dc92984a-5c25-419e-b4ad-f5b79efbaeea@oss.qualcomm.com>
 <03dbf5a7-68c7-4cdd-895d-178088421f9b@kaod.org> <87fr213m89.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
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
In-Reply-To: <87fr213m89.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9623910929165495341
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEeedfJhFyUE0/Hv4MLGWOFt9b5rx509g5FDtYO+C1+05GYljJB9U7iOiTGZ2Gd8aBpnUa3NxqIb6ip1594thit68+0uYC8CeZkpiZ60Tzvy3wonOzTd96Fsbf1nP1i2KxPEeGRH1BUxe8eTcsBDl1JjPqhsgm7gkfOxkhOiD497Pu6/FmDQ/j44pcGmwKzDZKH6ZdO+P3gBRHK6Y/1vppRBuWclB5Y5eOqa6yMBIrJ1z36gCHR4vuQp32pjh8dYPWyWApaxsNgt/G30FQ7WXJgea9CHNwgFpx45eDcErotwnoTSsP7qrdvP4RiwwaGtuAzOt841lAwiiVW8ZNxertTEfd9hPfRyOc+2re8T7ju1U8SWGBUptl8+vJkK8q38qTGROX1C4+9xH5QGvYwGNlHTwC9Opk6RJ+YzAZxWQeVqrQCTb9Pdg3+Aa9B7cfKV8MqXkDAmTCllNTaHrxSenesJOtHtHIRo5GSxXe1SRjLXi1IoWsCtx5LyejjDudZyBZdDy07Icgpd4Ri36W3FoLjYNSQ5fLytirDDAVO/eoBif84nbjYxZnwdrOVs4MTr3JJKDdpUD40onsdiDuH1OsOaHYmCwFFYF0LAFpWC4aZPPM6pYi/WbfFPIEq6dZp+xGkbovULMszITxovq4+7AlD3co8Tpjjl28maOp9EJluVQ
DKIM-Signature: a=rsa-sha256; bh=zJ2jJVBQ41jUzca14IuL3D2+R3XFMbt3FNBj5ISM8aA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783072146; v=1;
 b=jux3FXNyrIdviZzM0/bHzgBllxCL/puJwDEvb8cPY7CRhjgBjEl0Q9iiOCsnX6/gyX24ka3l
 KEtsMHo7QCYxKYz73N2gvRw58R+K4KR0yqjfvM83piDpHb9CG2Ciqz7rqnnTr2goYK9OF27eh6y
 eYTAyE3kPdl5wCZeDvVnc7nHG/RAxIz2eD5bULbyXK/jQFjIujVgE9GX4C2PHeLXPIFvV1aBOii
 fChe5WCc3MdMdNMpJFL0R7O4pjB240ke9MTkHnEnJPuRkfHODKst8aB7oH0Lnf1PQ+67wih/+y+
 uAsSdU1oVDydbIviXPMd+8XIFw0pg3zMjFTxeWYB0keVA==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/2/26 09:05, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 7/1/26 08:29, Philippe Mathieu-Daudé wrote:
>>> On 28/6/26 02:45, Emmanuel Blot wrote:
>>>> Slaves created with i2c_slave_create_simple() were left unparented and
>>>> showed up under /machine/unattached with no stable QOM path. Add each
>>>> slave as a QOM child of its bus, named after its I2C address, so it has
>>>> a deterministic and addressable QOM path.
>>>
>>> +Markus
>>>
>>> Personally I never liked the idea of having buses being parents
>>> of the devices attached to them,
>>
>> What was the problem ?
>>
>>> but maybe it is simpler this way.
>>
>> It is much simpler for functional tests when looking for board
>> devices which don't have ids.
> 
> A QOM object must be the child of exactly one parent.  This defines the
> QOM composition tree.  The link from parent to child is a property of
> the parent, and therefore has a name that is unique within its parent.
> An object's canonical QOM path is these names on the path from root to
> object in the QOM composition tree separated by '/'.
> 
> For devices:
> 
> * If a device is plugged in with -device / device_add, and it has an ID,
>    we make it a child of /machine/peripheral/ with name ID.  If it
>    doesn't have an ID, we make it a child of /machine/peripheral-anon/
>    with name device[N], where N counts up from zero.  The canonical QOM
>    path /machine/peripheral/ID is stable.  The canonical QOM path
>    /machine/peripheral-anon/device[N] isn't: it depends on the number of
>    devices already there.
> 
> * If a device is part of another device, it should be its child.  The
>    child's canonical QOM path is the parent's plus '/CHILD-NAME'.  Stable
>    as long as the parent's path and the child name are.
> 
> * "Should" because we have a lot of code that fails to pick the parent.
>    When such a device gets realized, we make it a child of
>    /machine/unattached/ orphanage with name device[N], where N counts up
>    from zero.  The canonical QOM path /machine/unattached/device[N]
>    depends on the number of children already in the orphanage, which
>    makes it unstable.
> 
>    Letting code get away with not picking a parent was a mistake.  I
>    guess it "saved" us some thinking about what's part of what when
>    converting existing devices to QOM.  In other words, it enabled sloppy
>    hardware modeling.  We've been "saving" thinking ever since.
> 
>    I want /machine/unattached/ to be empty.  If an onboard device isn't
>    part of another device, put it into /machine/ with a sensible name.
> 
>    Whether a device plugged into a bus is part of the device providing
>    the bus is a hardware modeling question.
> 
> Now to the patch in question.  I understand it makes
> i2c_slave_create_simple() pick a parent.  Many machines and devices use
> that.  I examined its effect for machine anacapa-bmc with v5 of this
> series using "info qom-tree".
> 
> The patch moves a bunch of devices from /machine/unattached to
> 
>      /machine/soc/i2c/bus[0]/aspeed.i2c.bus.0/0x70 (pca9546)
>      /machine/soc/i2c/bus[0]/aspeed.i2c.bus.0/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[1]/aspeed.i2c.bus.1/0x70 (pca9546)
>      /machine/soc/i2c/bus[1]/aspeed.i2c.bus.1/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[2]/aspeed.i2c.bus.2/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[3]/aspeed.i2c.bus.3/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[4]/aspeed.i2c.bus.4/0x70 (pca9548)
>      /machine/soc/i2c/bus[4]/aspeed.i2c.bus.4/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[5]/aspeed.i2c.bus.5/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[6]/aspeed.i2c.bus.6/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[7]/aspeed.i2c.bus.7/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72 (pca9546)
>      /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x22 (pca9552)
>      /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x24 (pca9552)
>      /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.1/0x22 (pca9552)
>      /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.1/0x24 (pca9552)
>      /machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[9]/aspeed.i2c.bus.9/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[10]/aspeed.i2c.bus.10/0x71 (pca9548)
>      /machine/soc/i2c/bus[10]/aspeed.i2c.bus.10/0x71/i2c.5/0x22 (pca9552)
>      /machine/soc/i2c/bus[10]/aspeed.i2c.bus.10/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[11]/aspeed.i2c.bus.11/0x71 (pca9548)
>      /machine/soc/i2c/bus[11]/aspeed.i2c.bus.11/0x71/i2c.5/0x22 (pca9552)
>      /machine/soc/i2c/bus[11]/aspeed.i2c.bus.11/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[12]/aspeed.i2c.bus.12/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[13]/aspeed.i2c.bus.13/0x70 (pca9548)
>      /machine/soc/i2c/bus[13]/aspeed.i2c.bus.13/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[14]/aspeed.i2c.bus.14/0xff (aspeed.i2c.slave)
>      /machine/soc/i2c/bus[15]/aspeed.i2c.bus.15/0xff (aspeed.i2c.slave)


it "matches" what can be found under /sys/bus/i2c/devices

Thanks for taking the time to run some test.

> Is this a reasonable way to model the hardware?  I can't tell; I don't
> know the hardware.  But it sure feels less unreasonable than the
> /unattached/ crap!

Hey :)

I have always tried to find a QOM parent to avoid orphans objects.
I2C ans SPI devices are the leftovers on Aspeed machines.


C.



