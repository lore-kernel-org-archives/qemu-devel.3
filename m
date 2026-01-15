Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC40D44C7A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQ68-0000iY-EC; Thu, 15 Jan 2026 11:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgQ64-0000fO-J0
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:21:22 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgQ62-0005L4-JU
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:21:20 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.201])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dsSsQ2nFRz5wNj;
 Thu, 15 Jan 2026 16:21:14 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 15 Jan
 2026 17:21:13 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007ef1f2717-1e8a-488e-ac85-36ed80ec6317,
 730BEF4863DC82B2970748FB5926F4A3C98AA806) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
Date: Thu, 15 Jan 2026 17:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
To: Nabih Estefan <nabihestefan@google.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <troy_lee@aspeedtech.com>, <wuhaotsh@google.com>, <komlodi@google.com>
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
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
In-Reply-To: <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 41b0557f-8048-45ac-9872-f682a537c556
X-Ovh-Tracer-Id: 1439463034690374505
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGeBi6z9svdIU7huS3lqTPBQTqk3ilGchR8KH8GXLlM3MFO+4e9jppItFKu5umBRQz/pwnnAwwic7tc7H7KA2ZyHWKaKbHtRIJ3V3p+t8PeRK9FKdmnOn3aiR1PAnnIVv8G1TkwluIHDkpHqUev8Uzwv3QjBEV64HVdhKV+sLVaH7DCytxr1BmfG7Un7p16aYYqlO1Ajir3TMd459hpXV9jEqLGwKY4wZxfvFje8Hrcz05sb7dQPVS+Q4fYWL3deM2fY5K/bmC0a3C8FOMJ6+E+eHRNTzhizO13inAJa0Gep2PjIN5gaQ8RSBBKlc7ySjEg1zwUOpVp2xzBismf47bdWiRiUfnC8EshsN0eNFK7tguCl1UCIsPfoTtZzBLBC0W0JVxDGeqbEEyPJsPKPeDsAxz4NxJbJMIoCM81wfZRzbBKEDFTVLDCSi0NGb0YA0YOh+wJgiPKDULYe4B2fYbU34HcsVvlcivcMQC+tGO6SowQuK/pL5Kw+0pZ4NcvwY63lQXglzybgh4hc06etFyObwuMxumkRukN77XP67cxOedFZTZLIPMr5MVvmmjG4xvsxmsu8S/0hyeWH2H8tlXQqFHA9e9JXSL1v9+X/YMEpCTHj8AiGtmvTNgXfnUtZHUQPGlKxuFg60YAxkaUYzI01NjLFfUu5mpsTKQYGGSa5g
DKIM-Signature: a=rsa-sha256; bh=I2Q0+3Aqv+cMIGsCwW8bf2IvKiLX7qRwkvuoNacZupw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768494074; v=1;
 b=I32crqzVntePjVTh6OD59435FPhZU09pLmEj1J53CAM+1cfy6SwiNll0cqxzwGL92MIhHv60
 N4iDpsYZbVHmAXymZ1RoGwFqPMeMMc48E7qATYwu4uXif3aSomBUeR+R3+OYRVE1/VQOTfwfM5M
 E2PtEY2LH0yi3kHWHX5FDUncbPg19VkEllRzL4c6NUpRVIZgq+0TvmhTPupvJBNPTloQcu5rDvm
 jMvC9Spy7c+QFIy3dDsgaKrJD7fPpWEh97tz4QKP/s0/S31wF6w0ZTuXzHcJKwzvpPrwPDQSLig
 8xZCj9R8jaM/tCABXpZPru1tGeuSp5PqDcWBY3IxoeG+A==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
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

hmm, I didn't receive the initial email.

On 1/15/26 17:19, Nabih Estefan wrote:
> On Wed, Jan 14, 2026 at 6:38 PM Jamin Lin <jamin_lin@aspeedtech.com> wrote:
>>
>> Full changelog since last update (183c9ff8056b) :
>>
>> Joe Komlodi (1):
>>      npcm8xx: Fix u-boot copy size
>>
>> Jamin Lin (3):
>>      ast27x0: refactor FIT boot loader into fmc_image.c for future Caliptra Manifest support
>>      ast27x0: Add Caliptra Manifest boot support and MCU runtime loader framework
>>      ast27x0: Fix compilation issues on Ubuntu 22.04
>>
>> Compiled with gcc version 13.3.0
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>

Reviewed-by ?


Thanks,

C.



> Thank you for updating the QEMU binaries for the bootroms Jamin!

