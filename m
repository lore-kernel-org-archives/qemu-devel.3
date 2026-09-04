Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797FAC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RpV-0005xC-ND; Fri, 04 Sep 2026 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RpT-0005wm-Pr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:11:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2RpP-0001YC-9b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:11:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AJ4B33277346
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 11:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CwY1wxLw4pv4ymQuk++MVIJ6KQmjMSIyAsScl5WvZvM=; b=BZRujrxU/WDDcps/
 SFHJWMp2CUGHnyMYMQhSHd/vhQHpU6Y6KuB5LhQ9L7WdxsdQQkHsP5lIoabKWxqr
 VTmZ5qBY/VJO6dm6ACPMdDnhlfK6G0nGn98S6HXcka8BuIrAf7GQXvmVxZvpYRXK
 YjIhOn9IhfMUIag6Bs3J9bXyGy+jnLpcVjjuP039R+saIpCS8MG3x0MBGPSUdNvc
 VR9E+A9n2pnNwM9Cl30Z5Hpup50s8i8wI91fI/uenwHxt/2xpwhfaushLB8nXNl2
 vXKseVhLRbeeD63Y1+yZjjywEoWJwb2Fb5yamA01VeDVhmAW0pgz8KnGvmFj2HIE
 jJN7rA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd13vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 11:11:24 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c7a3b3c06bso260631e0c.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788520283; x=1789125083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CwY1wxLw4pv4ymQuk++MVIJ6KQmjMSIyAsScl5WvZvM=;
 b=NAQ6xTpgO1kTt4hM66geaqy5vzKx9dahpy8XtLDgZohqM4kaGVXFxrNXaZCcmElJhX
 JOAlzTF5YYWpkHckuJ1fHCABjNdW/QUI0nxKT3YtLTvLgvnzQ0BkLY6/coItN0Ubtab6
 JZvKGXyHKdVJALq4U2khq40Fei7zQ6W/lJFb/fQcC++TOjh/JL8RyS4eXtpOWyCZYSEo
 QHf0ZYunfA4+7aKEnMXtGFW/hxNoOzUgDNI4bPtgT+w3pF7DNxRGXrlw+HAlDUl8Esg1
 4gmlBaKojcLAbHV8ARwkQafdDgqojL98liUJpaKmumKbtcoDWs3zgn7CHwMyaKPaOeSe
 6YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788520283; x=1789125083;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CwY1wxLw4pv4ymQuk++MVIJ6KQmjMSIyAsScl5WvZvM=;
 b=D2FuelcvAvYF0StgJlyCFlW8IU4Qd4PyECwFrUwDjWIKg0ESBFkoK9gY8FwxcYy//l
 x3aSHDtCHOJdHv8h0PYR5dioswjm0F2MGQ6o7gvTPcCil1+qDOnQUeSqyY27jcM//SAh
 rOIk8S1bvS82ygziJbScuGgr2dc+1blLMOe9/wIZLFPxAtFIh1wre9uWYOsSeVa2FM40
 xvomVh05a9QR9eFIccjosTH/0HFTraTcswP/kkbUxB7yQz7MV18MBj0F9wREkDdvQg9g
 0+4CwHr2xmPRD9+S8K2CIZ0o6tqAm4t07NKpz0TrnqcBEtj7Xp2+zd3xVSVn4SF+kCR6
 xpLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqIuO06Rlb6SGbxK2QBe3YMRAGokkWoL813ndHm0lxVefrhVbCooFGPUw2ZmS6Bb91HDxPrXHmj+Lo@nongnu.org
X-Gm-Message-State: AFuF++kacgQHwJIwrU5Nnmh/0WxnK//Gd1ASRNBpBGrGXJ6kmCdgFlD5
 i9+ECXF70n4uO8pmWl2sHm5OrnAFNQZ1NlzWEdCuMTDzpOw7uPfZMKvP/SS7qsyfFOvX2KO0ojU
 bFvITGCToQ2eTeXodWXwudsBSB7sHzOH4HYtYq+ybKitOpB0nowU7J51Eqw==
X-Gm-Gg: AYBFou0NYz0r5TanDsiumyg1txzXqEiqHlxZ44BcC6pMFTc+J905IMP5xUw0WvXAU9k
 I4hynuzpI6wCP8fL0KHHOI5P54AsqnvrXfbY4Rp4E2TFY/4wZ0PUBoy9eZGVEjyieD8UIkaGEnW
 FlhElJ2dfEJvfQkvWJDbQKfxJLR+T85SfvMHQDSA0KncL88HKjOwDAW8ftpU80h6QDpUEBqHlfq
 J2HkMuPsBh0ZYkjOMDn65IRtNL2bhPh5c6Jt0Su4BxjrTPl7sT4ZG76F2XEM0///r958p0GfEXg
 mXJpqU2P6Esifq2zxGxpB7EXvL2FknPZiJNs6CjF5UNYtKkqnXzGC/0DIdAmL3p7O1O39bGuWPL
 geZeg8WOKTq6KK/rIqybterUTTMyIJsnWoQ==
X-Received: by 2002:a05:6102:1483:b0:77b:2881:580b with SMTP id
 ada2fe7eead31-78a4a949f58mr1551196137.4.1788520283434; 
 Fri, 04 Sep 2026 04:11:23 -0700 (PDT)
X-Received: by 2002:a05:6102:1483:b0:77b:2881:580b with SMTP id
 ada2fe7eead31-78a4a949f58mr1551175137.4.1788520282956; 
 Fri, 04 Sep 2026 04:11:22 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858791bddasm6008333f8f.0.2026.09.04.04.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 04:11:22 -0700 (PDT)
Message-ID: <dff55838-6fd4-4345-8a04-dd62f46e317c@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 13:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] monitor: Refine 'info tlb' command
Content-Language: en-US
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 armbru@redhat.com
Cc: AlanoSong@163.com, qemu-devel@nongnu.org, laurent@vivier.eu,
 zhao1.liu@intel.com, atar4qemu@gmail.com
References: <20260818132519.186010-1-AlanoSong@163.com>
 <CAJ+F1CJ7swW-JWMoRT8=v4hsdGk-O5eFsD=n8XBCirjBHJWAgA@mail.gmail.com>
 <aoTl_9eaioevcOVM@gallifrey> <apncP_5e7fcofZL8@gallifrey>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <apncP_5e7fcofZL8@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FegjNN0PvEaBMuZwCt0dYcDfZr9Mgza1
X-Proofpoint-ORIG-GUID: FegjNN0PvEaBMuZwCt0dYcDfZr9Mgza1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwMCBTYWx0ZWRfX7RoU9K1qL6TW
 iRrjPwVCW40zcMsIjezF6w+P3OsXq+FPPtyVHkcY6UO4U0ZWEV8jZInoAu/89u/uWmNjgZJRpsG
 Y/IbkM1C+ZHV5k5LAh14S5NfKBJkqlY=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9aa75c cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=3WJfbomfAAAA:8 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=vqefOp8smvypG_KKsZQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwMCBTYWx0ZWRfX3N6jgZ6XlYC4
 yVSTvd5PVik4XJRrOj/uUv+Dbb2BWp7yNHP7PRhmoT21Q/qK0nFiDz0XJ/LBcTjtwqR1+n3KcCP
 S9JwaQodX9HctWgmQr6Nj1+ZHo+60DVpkPxVjIY7YhTpVDOG9oxal3scu7DjRzdf3rL0/k5q7Ch
 GD8XKfYCoTQAqHEz8aL3hmFkriiemIk5w6T8DiOYjUkN1lhISvwHXE3bqS5uwBeSiSl2KbbDGOp
 C46ENsGv0V5EBLz+65z+7Fy1vVLAEVMgA7Iy6VAhqUEukq1ZoKkT+l0Gn/NgyykCcNyIZBPlKNX
 np6imxK3WzwvmQG7tySPbKzVr/sHjs2NsUp+UnDau9G8ztXxpVzzO3Y2Ohm11rV0J4oCxYPy9gS
 GzC3y/IcKGTN1hSQIJiUSCwN/USEDU1zOj25LMU4c36/YaNUCDB0F0WYN/S+cAuXIbDbk8khbwx
 ZD9ZLH3Q/ouJwUqPIiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040100
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 3/9/26 22:44, Dr. David Alan Gilbert wrote:
> Hi Markus,
> 
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>> * Marc-André Lureau (marcandre.lureau@gmail.com) wrote:
>>> Hi
>>>
>>> On Tue, Aug 18, 2026 at 5:30 PM <AlanoSong@163.com> wrote:
>>>>
>>>> When booting an i386 target, the 'info tlb' command
>>>> may walk the entire page table hierarchy and emit
>>>> an enormous amount of output. It will take dozens of
>>>> minutes to print all the info, and
>>>> The same situation also occurred on sparc32 and
>>>> m68k targets.
>>>>
>>>> So this change do the following:
>>>> 1) Add a address range argument to help user control
>>>>     the number of output items.
>>>> 2) Add warning note in help message that such address
>>>>     range argument only supported on target i386,
>>>>     sparc32 and m68k.
>>>> 3) Print ignore warning when user add such address
>>>>     range argument on other targets (sh4, sparc64,
>>>>     ppc and xtensa). Those targets only print limited
>>>>     tlb info.
>>>>
>>>> Signed-off-by: Alano Song <AlanoSong@163.com>
>>>
>>> lgtm overall
>>>
>>> - m68k print_address_zone() used to be called with page-aligned zones,
>>> but now it is clipped to arbitrary user ranges, which may not be
>>> aligned. 1 byte range will be reported as 0kb. We may want to handle
>>> the case for small ranges. Btw that code could use the macros KiB for
>>> readability
>>>
>>> - A later patch could prune non-overlapping ranges during traversal,
>>> not just during printing
>>
>> Yeh I'd say it's OK, two thoughts:
>>    a) I'd have split the patch into a series with more managable chunks
>>    b) There's quite a bit of repetition which feels like a common helper
>>     might have removed.
>>
>> But:
>>
>> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
> Can you pick this one up please?

Doesn't this series need a rebase on top of commit
93b9a2436564a9df25a0b978c8245fed255264f2 (Make HMP optional)?

> 
> Dave
> 
>> Dave
>>
>>>> ---
>>>>   hmp-commands-info.hx      | 17 ++++++--
>>>>   target/i386/monitor.c     | 92 ++++++++++++++++++++++++++++-----------
>>>>   target/m68k/cpu.h         |  2 +-
>>>>   target/m68k/helper.c      | 55 +++++++++++++++--------
>>>>   target/m68k/monitor.c     | 15 ++++++-
>>>>   target/ppc/monitor.c      |  6 +++
>>>>   target/sh4/monitor.c      |  5 +++
>>>>   target/sparc/cpu.h        |  3 ++
>>>>   target/sparc/mmu_helper.c | 40 +++++++++++++----
>>>>   target/sparc/monitor.c    | 23 ++++++++++
>>>>   target/xtensa/monitor.c   |  6 +++
>>>>   11 files changed, 206 insertions(+), 58 deletions(-)


