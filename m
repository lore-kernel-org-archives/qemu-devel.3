Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36445C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZkh-0006W1-Je; Tue, 30 Jun 2026 10:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZkf-0006UZ-GB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:47:53 -0400
Received: from smtpout6.mo537.mail-out.ovh.net ([51.210.91.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1weZkc-0006vK-9P
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 10:47:51 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.210.158.128])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4gqQwz4BNFz3yw6;
 Tue, 30 Jun 2026 14:47:47 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <danielhb413@gmail.com>; Tue, 30 Jun 2026 14:47:47 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.242])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gqQwz18nxz60Mw; Tue, 30 Jun 2026 14:47:47 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 DD83F2403C7E; Tue, 30 Jun 2026 14:47:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001c6bb933f-c171-45ee-b63e-b28d557242f3,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <752e7645-816b-4b8c-9bff-abfde0ea3451@kaod.org>
Date: Tue, 30 Jun 2026 16:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, mst@redhat.com
Cc: harshpb@linux.ibm.com, npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, adityag@linux.ibm.com,
 amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <d58ee809-02b3-49be-b927-eacf2da8bfb5@linux.vnet.ibm.com>
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
In-Reply-To: <d58ee809-02b3-49be-b927-eacf2da8bfb5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 15497730743525813393
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFFhL1THFxwX0LQ/ecAPJ/7sXa92PIbFPIcF9Ukf5TFC4T/hYmoHmbeEK2q7mO+/wZc5Ep7O9CDjwydtRNsp3ssTkGEKZlW76F5448+h2bkxcwF+FwjsUlb8rQafzEbPwvWz6jFqioA6jjxF7lUSwVgEypxXfhKjc7excDOgNoa94ZYJWmRSbiFBa4tx8Or19KqBwFBHJ7drLMePasTcZNxTr6FZ9H54eE+g5ztCy3R/tfQfvdkmQlWVC/iSB/i756WC2cxfD/r1ud6nZLYVxJWOcRoM9lYOUkZ4iB0HJZR7pvmtulsC/WdwKSrYXd0vPNnW8s5MTqlvVsUu6AVLENleQx+Jw84KmU5NgwpjD6CL9+SXEi+hpbhQ2+CDvUqisULG7lUUp7wg2TuZOKWrImG9IzZwZxk8a96BVV09uFwpK+8XenteKU0t5yxZEtlvnyBQ/3zM5wpmnT7Xma07lSyxkp3JaGmk1/W+dzCdRTwQilKYr4XErHjTL0yPo30xbFSOM8P32lR90nZbLZJwfhEzL3mr07Y2G/jmvdyt5+jqFQ8Q6j4kNNpsm4noWADyw2wPF5WoLwN1uKtrB2VjDB9JkXcHD0F7pqR0+uPdlWdA2IgL+dxh7Mh9kSE7E5tNlX9hdbrK4veDCm2Jb362zjIhykvpklQJ8gGQqM+hcSvSA
DKIM-Signature: a=rsa-sha256; bh=is/2fL0TeVagAyrfMMgGCc2Pc/iAS1UsDusm6HmzqZc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782830868; v=1;
 b=iFUilq9rIdbCCV5UKYNZ4dtMen1zPybz/A3xJ8tJsgeL6LD4+o2SDo1Kzv/533MYqXyX/jNj
 cmolTAceonYXbdLHwYSdpfoMZKpf8N1Q2/CMQKianhyN8a+rbRYDK5f4lZ1d4KiLDjyXS8nbHoz
 qtHbSNxreuphh18pFZqYj9knU0wVOCDAh6R1+glc1rs/pSNbvXv4mj0FlEBUuemUAXcCGuapZUR
 M9hUSkCw0Hmal3bAWFuXUihR21/kKxzch5evXZ0dUweh8oh6JVMZYZ2IdwsQW+BxW+pfcP3EWhF
 58d8CIb+O8EA7SKsTrF+r1K7wpZim6lOkQGgxwCWAb3rQ==
Received-SPF: pass client-ip=51.210.91.25; envelope-from=clg@kaod.org;
 helo=smtpout6.mo537.mail-out.ovh.net
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

On 6/30/26 12:22, Saif Abrar wrote:
> Hello Cedric, Michael,
> 
> Is it OK to retain you Rbs in the next v6?

yes. I took a look.

Thanks,

C.


> 
> or would you like to review this v5? (as the patches have evolved since you last reviewed.)
> 
> Regards,
> 
> Saif
> 
> 
> On 17-06-2026 15:20, Saif Abrar wrote:
>> Hello,
>> This patchset resolves the review comments for v4:
>> https://lore.kernel.org/qemu-devel/20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com/
>>
>> Thanks to all the reviewers for their efforts.
>>
>> Major updates include the following:
>> - Rename to phb5.
>> - New file for common definitions used in tests/qtest/pnv-* files.
>> - Initializing PnvPHB4Class members within class_init method.
>> - Updated IODA3 PCT table max size to 128, each with 2 entries.
>> - Multiple general cleanups.
>>
>> Tested with 'make check-qtest' , 'make check-functional-ppc64' and 'make check'.
>>
>> Regards.
>>
>> Saif Abrar (9):
>>    qtest/phb5: Add testbench for PHB
>>    pnv/phb5: Add reset logic to PHB5
>>    pnv/phb5: Implement sticky reset logic in PHB5
>>    pnv/phb5: Implement read-only and write-only bits of registers
>>    pnv/phb5: Implement write-clear and return 1's on unimplemented reg
>>      read
>>    pnv/phb5: Set link-active status in HPSTAT and LMR registers
>>    pnv/phb5: Set link speed and width in the DLP training control
>>      register
>>    pnv/phb5: Implement IODA PCT table
>>    pnv/phb5: Mask off LSI Source-ID based on number of interrupts
>>
>>   hw/pci-host/pnv_phb.c               |   1 +
>>   hw/pci-host/pnv_phb4.c              | 581 +++++++++++++++++++++++++---
>>   include/hw/pci-host/pnv_phb4.h      |  16 +-
>>   include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
>>   tests/qtest/meson.build             |   1 +
>>   tests/qtest/pnv-host-i2c-test.c     |  13 +-
>>   tests/qtest/pnv-phb-test.c          | 235 +++++++++++
>>   tests/qtest/pnv-qtest-common.h      |  24 ++
>>   tests/qtest/pnv-xive2-common.h      |   7 +-
>>   9 files changed, 868 insertions(+), 76 deletions(-)
>>   create mode 100644 tests/qtest/pnv-phb-test.c
>>   create mode 100644 tests/qtest/pnv-qtest-common.h
>>


