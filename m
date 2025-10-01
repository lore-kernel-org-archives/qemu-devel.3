Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92FACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3sT2-00069B-W1; Wed, 01 Oct 2025 04:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3sSX-0005zP-Uj
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:45:14 -0400
Received: from 2.mo548.mail-out.ovh.net ([178.33.255.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3sSA-0008IP-6u
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:45:12 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.207])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cc7lW5Ly4z6Tc7;
 Wed,  1 Oct 2025 08:44:39 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 1 Oct
 2025 10:44:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0026aa758e9-9916-4492-9bfd-4d84e33cf992,
 D9D4E9C7278927B1F3584C3B5B4DCE3027F8E762) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bd37b890-1bed-4862-9df7-cca0ea9fa2d2@kaod.org>
Date: Wed, 1 Oct 2025 10:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tests/functional/aarch64/test_aspeed_ast2700fc:
 Add vbootrom test
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
References: <20251001064625.1058680-1-jamin_lin@aspeedtech.com>
 <20251001064625.1058680-4-jamin_lin@aspeedtech.com>
 <3e2c8210-9e99-438b-aa9b-13479d59f6c9@kaod.org>
 <SI2PR06MB504112C0F9FC1130B4C3D50EFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
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
In-Reply-To: <SI2PR06MB504112C0F9FC1130B4C3D50EFCE6A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: ec12f570-b181-4071-94a9-a7d27cd4e0f2
X-Ovh-Tracer-Id: 16858943731903597359
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE0JRuojqGEGWDKbDMZjl1LZuxhN4A3cRj+0EjXUqx/1YqykBXCG4vq4TR8YCGtd81uup9ti/uoVIrPmMVTjNT5B9SEnSPVxZ54hJ6N8ZBiD+/QdWCqiwAOLfHA3O/uikjftV85/beBEuUQifJHMcmx+NgEqJtJ+Tpo7ofLUj1bSlknfMwrYS8MujyqW0277FX8Ev3aJjEWtkWcOUbmlceiykeYaEgXQbbW2JLWD8KxusqodsQq7gM+1jKob1ail2O+4uqbOaaPKflAx4bkvdckOfkjdNr/lWbOFp6RbHOCC8uivDd/W6IqpHxMrcVK9eb70QZ42ctulCsKNKlzB1laiw727XBazWpe1r3hVx9We+Tk+6BA5/n5HVIYxVSfy299vihnJDm6Toa1G6AAplQOsYbjcyYROK3VeX4F2wKUd6iNwmMQOQTxvwFZ4JPrn2nkTxAyLq9fR/B0vOhEYJq2/2JwFkAiEHzqPFiHUZzAkymgwr5ymFSDzGCbEAZZZ22PXItCfFlfgXvLy0HRuYzgZGo5Qvw46hu1pdB0gyfaYJUftC3JZpc88DiavBG8wbKUxR2L4L+dmIT36Bq3WEEg9r+1DHNrYpLJGZsLaCs4wsri4MKaVJwualZFQCn4fyVAJTS5XMBH+X4aIVW2anGBFJRhg4cku0NvELrc+8hArA
DKIM-Signature: a=rsa-sha256; bh=JIJR4XSo7q7Ut+FtXKmkf9cqQqiVDG21f9SIYVt47TQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759308280; v=1;
 b=bm5n0TmBQtrwfgPxN6FbOxaW87EPA2hl/PSusrDsjYTyGerlWf6aFEnhIoP88TMkjrLfk05O
 MimvpFP9uJO8QdDRV6DfBxsl8otGwLeM9SxuZqe8q7BfkL6VZKN9q4Z5rkIT41PnMK+RR/jrOui
 /0Dqrz59pIhoAdnRiabco2z17WHDDRZz8dq0vDxwyMZucfSvV9zliJIG6woj0SdyvBGgr7Hw2O3
 gRdNTtWLFm2Fpp1hT5alA/DWYTg2zFmokKsLJr1lKgkOV5jXRFT9seclW+n1QIC6TrhFKpWNbWq
 MdpmIbjHd8LbFjzc8NUHvcfdCgoMtzr3LFHLxYl6hjaJg==
Received-SPF: pass client-ip=178.33.255.19; envelope-from=clg@kaod.org;
 helo=2.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Jamin,

>> Could we update all tests to use the latest SDK v09.08 [1] which was released ?
>>
> 
> I’ll update AST2500 and AST2600 to SDK v09.08 after the release.
> 
> For AST2700, there are a few issues we should discuss.
> 1. AST2700 (ast2700fc) – SDK v09.08 support
> The ast2700fc machine currently works only with SDK v09.06.  v09.07 and v09.08 --> Will encounter boot crash.
> To move to v09.08, I need the patch series(Control Coprocessor Reset....). I’m reworking it so it can be accepted upstream.
> This refactor introduces AspeedBase and AspeedCoprocessor classes and will require substantial changes across the codebase(It will need a lot of changes).
> 
> 2. Starting with SDK v09.07, our SDK no longer produces "u-boot-nodtb.bin".
> As a result, the manual device loader tests only work with v09.06 (-device loader,addr=0x400000000,file=u-boot-nodtb.bin,force-raw=on) .
> Proposal: drop the manual device loader tests and keep only the vbootrom-based test cases going forward.
> 
> Could you please give me any suggestion?

I suggest updating tests with SDK v09.08 for all supported machines.
The commit log should mention which, and briefly why, machines are
kept to the previous releases.

Then, the series refactoring the AspeedCoprocessor models can update
the SDK to v09.08 once it is ready.

Thanks,

C.


