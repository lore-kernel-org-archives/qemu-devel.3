Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539D2C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Rfy-0000g3-1R; Fri, 04 Sep 2026 07:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2Rft-0000N3-Sz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:01:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2Rfr-0007yc-Q2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:01:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIIwE2094959
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 11:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GTmH8xj8TrjSZaxaVPuR3d7HGY+mYKJeMs9rsrBQvbA=; b=TpvKU3WsDM/t+Nng
 QqRTWDD10XVE39B0JUqYmtPr18m1+NMK1XFuw4dDIO0LZtdd0xBVDG2oJMBShoWE
 PImRa9COiCfv0j/6ZQ7Cqkm7SrbkVldDTU4eDQxgwZnR8uiI+ib9o95XZw8Br2cF
 pX3iCsOlPSbwYr4knOhVuFcuxCS9UYrwZe+iE62e++b0+fE1xIcgXOKNdjcnGUN5
 98aBGjeDCDx7JzfH/3v/AHhc7WQCPP/QjNH1X0vuie2GP2zW5kq5Q5YTL6aGq3/b
 86jWlg1qP8FruNLLSXPypso7cWHw1vSIMrqK0AtgXfMItRI6I5yHIbZHAHOnFTz9
 kfsV1g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqs94e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:01:33 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78a57b4bdefso19825137.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788519693; x=1789124493; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GTmH8xj8TrjSZaxaVPuR3d7HGY+mYKJeMs9rsrBQvbA=;
 b=Lm7zFldvGCDJB8y3KEdxKL8XvbyLIcKK/s7/lCQFT+SF3OQzqMWQ0Psrk/QvN5kNdh
 J71c7p9s+o+9FgL45bG3ltTRXqd6O87gG4bqlWMQU7oNcw/ZmsUZcBe+D7PsAg2YGw/d
 5i+XMePGIr97pWaqLFzFEk1CBvDVvRoPYLCNX1yAUhXYW5AiTahVwt/mTV0qSLt5jlRm
 8zPTwzwxNME3fmqGcNZ9sQ8vQC/+OvjgRPilssBXnBrcnNbXs5b/s/FZ8mJzGZKUMNLX
 lpFo+e7sNadNJclur7NQjhHDxyUwkqPPek56fdA+ZV6LUJq1gMiyrJNNDWq1jHHe12Os
 xBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788519693; x=1789124493;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GTmH8xj8TrjSZaxaVPuR3d7HGY+mYKJeMs9rsrBQvbA=;
 b=ipSP68HvPS1uGxyQSOIxvvHPjY77T0c/g+UIizbV3sZ1d4ZJpPyqvTOXhdX1hbDTw9
 tLug+5r3XzG8cEmjgf1M8jFjlcF1ZYHg6HvYzazFJEQRc77pi3EwWHQVwTdcwszWHB4A
 z58NI8vXF35oi+/J7vk2Quu60A1zqSxZ+Ccg7jWm9Z3kDAEcnL7ojWX71lbWzXoUZLV0
 /ivSISkgEjBgIxaBTtUiwDpbXVKRQyalHyF5R10Xl45tCjtRqHPI41m7zQvoWjJFx+VQ
 hGxYv3ibvkLFo5S/OayxzFrb7kUA5fxoO9dpn4sZDM/4+hLeKoxWyNhacug0E07+xweO
 jxWA==
X-Gm-Message-State: AFuF++lwXFTaRlfVsOd75WpsnCGfq3e6w37xTbpmzjMLkgG/NtRCBOr7
 yZqK1rMTz9Vj5hkayQhgK1iyMZyV9wkMgaN9Byn9M5OJg7nFsb8B6ayoLPp9EStwtF5yE8Qa9VV
 mJY+8nzvGqpKKU9entnK6PEiaV/Ty1CvN3vXdOZJ1tTKYVKLniurPiRebug==
X-Gm-Gg: AYBFou3uZRdIMh7DcCN12wyQMnyLtxetj81Zq4UTRMIl2iDgAhWA60PYDwL/3Y8Y7+j
 nP+zHX/GGPboj5THLYw7t/K9zXedptKahLwmn667noDuIIy6ukwkcAYmfAs+QGvcCpfP6QZ1smg
 edPG2RE2eWsSNL7CmwQSDnQfhkgYkACO6LrYJBeV5H0+XxLA07MR/gjqOiflAYo7BXrB6TfIM8E
 fhNpLVMpxgaYfEGiGqskLuQSLCS7+h5UbnsNtmxz/PQIbhqnRM3Ubo39E4BFhp0QnjkLUY7rKm9
 tAcYR7XLcnwEXdt3s+UcfkJvcato/uf10/Z7tiiqZh+iKPWMqgM6Y0NtG63CkxC8pPlFoJ3ve+z
 ftRk9M4hVG12UAohSrIOEB8UIr9g8qsn7ow==
X-Received: by 2002:a05:6102:160e:b0:778:5369:763d with SMTP id
 ada2fe7eead31-78a4a6df1c0mr1292557137.1.1788519692629; 
 Fri, 04 Sep 2026 04:01:32 -0700 (PDT)
X-Received: by 2002:a05:6102:160e:b0:778:5369:763d with SMTP id
 ada2fe7eead31-78a4a6df1c0mr1292531137.1.1788519692077; 
 Fri, 04 Sep 2026 04:01:32 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm5200181f8f.36.2026.09.04.04.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 04:01:31 -0700 (PDT)
Message-ID: <f2e64e69-db55-4be6-a0c8-33e72d3d1407@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 13:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ahci: Fix leak of IRQState
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alexander Graf <agraf@csgraf.de>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-2-farosas@suse.de>
 <CAFEAcA8j8MYW-YtKJ1trVk2NureE0iUk+E17kX5-jW10x8HyGQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8j8MYW-YtKJ1trVk2NureE0iUk+E17kX5-jW10x8HyGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5OCBTYWx0ZWRfX/c3gg3jHTaPU
 4Na+Iy9nhD4vmME1sm8jk+i99EaBioJYv/QocvJVV0KJq57FJKDOpcuD1it06tN8OwIb1R4YzcL
 /A0gT18tJiYYgwMUDoW+9MUmDCOPQyo=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9aa50d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=YotW0nCnj4l7ijUbx1QA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5OCBTYWx0ZWRfX4UfJXwPXlD8g
 h9MT5p5fSsdKeMTPCliM9FUtAs/UvXaNfalpsMNzd1WugxRuxKJ330CJp/p3qPTtC2oMvjXlV85
 Vk4cML7JfbANZ9O5KB1fDXISW54h/KD88PbRskI3NnPfCuSzLnh255IPytzvHau8Rwdb8Wyhkau
 IgOHfaqYjKsw4fW4tdZbBXNoRDs6s3FUaBomy8O22ZHbOM2hPACFEwSHj9QdYlP6B1t2yWjo1Rx
 AH7BZ1LwgsHUnlbMP2UwcErAMHZxffKXYxdZsE8QRk9UrbYVRCeAepI0G9TUfZtpOjlnAbtS2f6
 5hMyD7kT0bdK0tp1nzKwHSwBwp16QoN1dTPFcV8UQr5Libj5OLdeQ/M6OenNu2PtlZyeV03ZGnz
 W6eHAOuGpGkJLJuwxNyZe5jFCBbRAQBPUvfxF/izQgr655RipLGKQ6p/P5ceuFZp4SactPVVWnB
 lVd8qAc1S7JrtZm7NtQ==
X-Proofpoint-ORIG-GUID: JVRrp527l0rO3-Q6iq522BsEW65hNVjP
X-Proofpoint-GUID: JVRrp527l0rO3-Q6iq522BsEW65hNVjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Peter,

On 4/9/26 10:31, Peter Maydell wrote:
> On Thu, 3 Sept 2026 at 23:06, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> ASAN spotted an indirect leak in ahci-test:
>>
>> Indirect leak of 576 byte(s) in 6 object(s) allocated from:
>>      #0 0x556112a08ca0 in malloc
>>      #1 0x7f21591e595d in g_malloc
>>      #2 0x7f21591ffe38 in g_slice_alloc
>>      #3 0x7f21591c988d in g_hash_table_new_full
>>      #4 0x556114d756f1 in object_initialize_with_type ../qom/object.c:506:23
>>      #5 0x556114d77590 in object_new_with_type ../qom/object.c:706:5
>>      #6 0x556114d777e8 in object_new ../qom/object.c:722:12
>>      #7 0x556114d6d2be in qemu_allocate_irq ../hw/core/irq.c:94:25
>>      #8 0x556114d6d1bc in qemu_extend_irqs ../hw/core/irq.c:82:16
>>      #9 0x556114d6d329 in qemu_allocate_irqs ../hw/core/irq.c:89:12
>>      #10 0x5561135da9bd in ahci_realize ../hw/ide/ahci.c:1644:12
>>      #11 0x55611360156a in pci_ich9_ahci_realize ../hw/ide/ich.c:132:5
>>
>> Although ahci_realize() frees the return of qemu_allocate_irqs() right
>> away, the individual IRQStates are still left around.
>>
>> Issue qemu_free_irq() at ahci_uninit().
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
> Classic leak resulting from qemu_allocate_irqs(). Ideally I
> would like to be able to remove that function exactly because
> it does tend to result in leaks, but we still have some users
> nobody's cared enough to try to rework yet.

TBH "nobody cared enough" is a bit unfair, various developers
(included yourself, Mark, Bernhard, Daniel, myself and others)
wasted a huge amount of time in the past trying to do that on
legacy devices and various series efforts ended dropped (which
is why I used "wasted") because we were bikeshedding on unrelated
details.

Hasn't Alex already solved that now for all devices in his latest
series?
https://lore.kernel.org/qemu-devel/20260718213652.37673-118-graf@amazon.com/

> Another way to fix this would be to embed the IRQState into
> the AHCIDevice struct, and then use qemu_init_irq_child(),
> similarly to how b38859be76abf removed the qemu_allocate_irqs()
> use from hw/isa/piix.c.
> 
> But I have no objection to this "just fix the leak by calling
> the free function" patch.
> 
> thanks
> -- PMM
> 


