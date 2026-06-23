Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81E9CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbx78-0002fo-I5; Tue, 23 Jun 2026 05:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbx76-0002fP-GG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:08:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbx74-0001yb-L4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 05:08:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N8V3BU3245123
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pf7e/9x2q9QPecQYHAYLWv+HB7zFxE0iZZ/bDuFCz4g=; b=LR2wfO8lGcwxlbTR
 8pdC+vhs2v+UemtEBX0CHsNbDLZY9QcJRuiogEpXTdtGwfIQ0YpKO2MfYXSwri2m
 EgWfAeViTWioMlVqVjFyzX2mkcqhpDUcGI3/HoniuCt+FqKdL1Ko3vBKT4uPvVLl
 IDuoHrdEXr41PljkJjPfjX3mCsGXz49BsnyUl4qVx4eWqMt3HWLKDR7H5OGslgqI
 gGTQqh16dJEBzIlpyVDo32bjPHw5fKL9xz9VdvHhkbfM3F3yL8723MD72wnb5dm7
 hgpL1NuLfAGAayDmKNe/mLJjFX7A9fDUb6zlFrnaI8EyzGdfPRtueLiic9azmuef
 Gpupcw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppyg4hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:08:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915767b341eso520924385a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782205687; x=1782810487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pf7e/9x2q9QPecQYHAYLWv+HB7zFxE0iZZ/bDuFCz4g=;
 b=BzSE+0cRKFAgj44MULigahZR2/8L5xEtljGA0nS5jvgMSWZ6coOUxRGNb5IN0sp1VV
 S2a76tPovPPKSjG/+oArHHtoh28Eqr2AFylk2yzkoPMj5L/uA3qM2XPOuWBg+y2HZC7F
 bvTtyxyvvsh/IAoHvZ4CGiQP6uSIrmUjXdqjCNSzsFmF6z2t3Or2hUPDgvvcv/rli9SZ
 f/lY0qvthZYR6mTK1EiNIEeVNbnEYhJPOHbLAKZZXraAYZ1EkLmn2B7OFk+SRBBqqf0z
 I994imEB2iFwJfOUOYVxMdjMoLFz5quWG52AePEcLFF+V/4nU5Hv52SZYPND4Z4ofNp6
 W85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782205687; x=1782810487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pf7e/9x2q9QPecQYHAYLWv+HB7zFxE0iZZ/bDuFCz4g=;
 b=eulGiTw7UetVbwZlUUUbUZYYglKHUJ8vEVwl+A3xHEFjG18sKszVjWXTH9CiNV9LOJ
 vtHT72yODTzwp2R1ybrJzzbMutta9lV0fwQNIcziSxwXWvWA2mGYmjzF550DGO+CiABn
 ExQnTmH4Ujn3O4aBEqTAqy6BeOrV4q5FU3l24pJi/86gGix8gCmUq0ioy7rRWliiegwB
 61ZGC+3VolNIWIKrXPv2JzVvpl1ddmQUtVorkVKogJxoKRbYKcpoEbhtKBMfAu9hIDU1
 1xrE35IULz4Lr+xxj6xM1GOJMaRw7O1kphb3j7NYSoj3YsDN87f9QdOhauj+gE9WKfYR
 iE9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kG2UOBNk+XZlg5tHtoorik4XqIl2KUUUDvhwwJZHDTwJntEG2fg7Dpmw8klSyQjdqn8XcaHSkU2vI@nongnu.org
X-Gm-Message-State: AOJu0Yz2JMX1ONceVR6yalkShWepLpWOFdX3tTOK+dcixkr/eozTjb0/
 HPZl3z6GxItRM/ea50pPa4/6HZq2b+x7mE4zSB+fLh6YgYgg+1fnoLLWnayPWu892EEZXHaGBiw
 jyGzkVrdJSD146ySi4wWOzTx4j3IddePOGi5GkGk9lry1sM1uiiTWzCZFQA==
X-Gm-Gg: AfdE7cn8A9xLnEo3nGow8Tkh3dQoW05yIsxUwi+sEWmOWdl5Sor31t47Lt8GkHD8kkx
 NxPGXDZGk7pG+hC4rSfP5oxxmlNsuPorihBduqBT5se3vf+i4hILzkj+95Aiw0DkW0/QUcMrbWN
 l+sgNRFMTYTpL0tlUlZpuwLuHN6entDAZfNsrn+0zRIyhByE9I2+tCR+j8Tmg+bPqfdLLXNQ+CG
 ypUnr6lmy1b2+BGSMJxNEmY1U/JTOS4TX05yUWbwrcISywVocfSaEZLkMbYgqCp9xYpXtGI9q2O
 12M1I9zyOjgp0Ud6CBRFaN3z5Mii2v9HXu6ais6OqcV2Xkk7F1mZxSPcdjbBtsKQXFMww9gTO+K
 Bc1LN1bQJ39Qa4nRUKYeX92kl2LRKyEUksuvWKDmJ10+tKol9qryirikWzrJ3lA==
X-Received: by 2002:a05:620a:c45:b0:915:8055:3f7b with SMTP id
 af79cd13be357-9208d3f2fb7mr2716790185a.46.1782205687315; 
 Tue, 23 Jun 2026 02:08:07 -0700 (PDT)
X-Received: by 2002:a05:620a:c45:b0:915:8055:3f7b with SMTP id
 af79cd13be357-9208d3f2fb7mr2716784585a.46.1782205686749; 
 Tue, 23 Jun 2026 02:08:06 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fc47720sm615728995e9.0.2026.06.23.02.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 02:08:06 -0700 (PDT)
Message-ID: <a8d251b3-71d1-4311-9980-cac82e82ed3e@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 11:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/12] hw/riscv/atlantis: Provide a simple halting
 payload
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260619044838.1054677-1-joel@jms.id.au>
 <20260619044838.1054677-9-joel@jms.id.au>
 <CAKmqyKML0szhhJv_pb=+oNZJwZhurn9k1La+FgiAHmBCYYFW+w@mail.gmail.com>
 <CACPK8XccZpBwwGQKs+CN_QGz19OMCiSnh1or8+aPewz8HRNK2g@mail.gmail.com>
 <CAKmqyKPkyRPkfdnGJevMVu8qvLbaUmGfzRqMapRqLBhU5WzUSg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAKmqyKPkyRPkfdnGJevMVu8qvLbaUmGfzRqMapRqLBhU5WzUSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX3TQz2pnwZt4o
 V3ZZde7tZGYfX3o96SFuo325+T/NaQhmVfx3odIe0raQu4Aqp9vCKoM04R2TGcbQi6MxzDXiRsO
 VJjgwH0xJEUfN5DeSfk0tphjLJp1MFjPxzZxXLrLRvH+/DGof2ssExKhSFT82zDGYNpnJLcQlLa
 hxg81U5Jj2+2JQSyy5c0gFjMUoa7AULeB0mf1LPdMHbbHKTd2j2nQkynEiGHPPStRidkN0EQ1uw
 DtAECsJmA7Wfify/+szBG51/1bYSiBu38cQ9dQbIxXZ+MeWi0vA5TQLxziF0ZZnBjPQdaLSguFs
 tq8PDeks9DF/oB4iR8fOXhXZrua5NzlbbR+BBUaMGRexnsLcRIsQQOZd3M3356hsjZALuDROZiJ
 bxAFEw28xJtXhwjj50benKiyrGXwR52bNWJ+4nFePGnkmfM4rXCmjVZWxKUlqC2v7nTzGYMTYZA
 HlUsNvd25Y+CNG+rsgQ==
X-Proofpoint-GUID: NU8nN5oYKTUyvZDKB7bfdRyMLeYL68qS
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a4cf8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=q43raG1AvvbDDsRyOWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfXxsYKZumi5+R3
 7/OqhHWeBRkrUn++j14DenrKI8zjQmOD/5e5MrtBote6cLl0s8tipK8tGK/mTGkqMdiwY9Awy8H
 XZuDkEWQDbLBFzwxeDyb7c3gN8pxl68=
X-Proofpoint-ORIG-GUID: NU8nN5oYKTUyvZDKB7bfdRyMLeYL68qS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 23/6/26 07:20, Alistair Francis wrote:
> On Tue, Jun 23, 2026 at 2:38 PM Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Tue, 23 Jun 2026 at 12:11, Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Fri, Jun 19, 2026 at 2:52 PM Joel Stanley <joel@jms.id.au> wrote:
>>>>
>>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>>
>>>> OpenSBI hangs before any console output if the domain init code sees the
>>>> next stage is not in an executable region.
>>>>
>>>> If no kernel payload is provided to QEMU, the next stage address is
>>>> NULL, and the riscv virt machine memory map ends up covering the 0
>>>> address with the catch all S-mode RWX region and so OpenSBI prints
>>>> console messages and does not hang until the next stage boot.
>>>>
>>>> The Tenstorrent Atlantis machine address map has RAM starting at 0 and
>>>> it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
>>>> tripping the early check and hang.
>>>
>>> Ok, so I looked at this today and I think this commit message and
>>> approach aren't the way to go.
>>>
>>> I do think the commit message is a bit confusing and not entirely
>>> accurate. What about something like this (might need a tidy up, but
>>> you should get the point):
>>>
>>> commit aac25688634d1afe6735cb71d8dd1ea652fa90d4 (HEAD -> riscv-to-apply.next)
>>> Author: Alistair Francis <alistair.francis@wdc.com>
>>> Date:   Tue Jun 23 12:37:47 2026 +1000
>>>
>>>     hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr
>>>
>>>     When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
>>>     to print any output, as it hits an error early on
>>>     in the boot process and gets stuck in `sbi_hart_hang()`.
>>>
>>>     The error occurs in the `sanitize_domain()` function inside OpenSBI.
>>>     `sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a generic
>>>     coverall S-Mode RWX memory region are created. `sanitize_domain()` is
>>>     checking that the next address is executable.
>>>
>>>     If no next address is provided (which occurs on QEMU with an empty payload),
>>>     then `dom->next_addr` will be 0. On most RISC-V boards address 0 will fall
>>>     inside the coverall S-Mode RWX memory region and pass this check. On
>>>     Atlantis the OpenSBI firmware is running at address 0, so this address
>>>     falls inside the M-Mode only OpenSBI firmware region and fails the check.
>>>
>>>     Once the check has failed OpenSBI aborts and the user doesn't see any
>>>     messages. This can be fixed by either supplying a payload, or just
>>>     manually forcing a non-zero address (actually just any address that
>>>     isn't the OpenSBI firmware) for next_addr.
>>>
>>>     This patch ensures that if no kernel is loaded we still specify a
>>>     default kernel_entry so that OpenSBI happily boots and jumps to
>>>     the first address in memory.

Nice.

>>>
>>>     Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> This reads fine by me. Nick?
>>
>>>
>>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>>> index b40a893a37..dba56ad6e1 100644
>>> --- a/hw/riscv/tt_atlantis.c
>>> +++ b/hw/riscv/tt_atlantis.c
>>> @@ -444,8 +444,15 @@ static void tt_atlantis_machine_done(Notifier
>>> *notifier, void *data)
>>>      if (machine->kernel_filename) {
>>>          riscv_load_kernel(machine, &boot_info, kernel_start_addr,
>>>                            true, NULL);
>>> +        kernel_entry = boot_info.image_low_addr;
>>> +    } else {
>>> +        /* If we aren't loading a payload, OpenSBI thinks we are trying to boot
>>> +         * address 0, which fails `sbi_domain_check_addr()` as that is where
>>> +         * OpenSBI is running. Let's tell OpenSBI to start running at the start
>>> +         * of memory so we at least let OpenSBI complete.
>>
>> This isn't quite true, we're pointing to just after opensbi. The start
>> of the rest of memory.
> 
> Ah yep, good point.
> 
>>
>> Perhaps:
>>
>>   Instead point OpenSBI to jump to the end of the region where it
>>   was loaded, which avoids the early hang in OpenSBI, allowing
>>   the system to proceed with the OpenSBI boot output.
> 
> Sounds good.
> 
> Alistair
> 
>>
>> Thanks for taking a look.
>>
>> Cheers,
>>
>> Joel
>>
>>> +         */
>>> +        kernel_entry = kernel_start_addr;
>>>      }
>>> -    kernel_entry = boot_info.image_low_addr;
>>>
>>>      fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
>>>                                             s->memmap[TT_ATL_DDR_LO].size,
> 


