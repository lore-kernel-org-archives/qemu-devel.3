Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7339606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nXWvQPnH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gK+QsaRY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzIZ-00039n-C0; Tue, 24 Nov 2026 17:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzI6-000397-BU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 17:47:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzI3-0004Jo-Uw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 17:47:10 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaorB3274476
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 22:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P0YmWpW1/eHvSSkLARJTBPm3GOpe641k7iBUB3T57qE=; b=nXWvQPnHm/O+d8Li
 Qqw0leGHXFDcMC5N2dBBAEvgLsAzg3w25kmpOW1ocEWiKt+y42V4AKB0dpCGELng
 wQmAm0dxoBBqRpUImqpYt4hZgypoogLGQqJgge0pX6e8j3pJKUmS7BA/VxxH02Oq
 /jp8i/+QBv0ZqhHNm663SW3Kg50nHqByeGeS5KdhC0cx7yJuNXF4NwJDs4fYn4e8
 EyQsIoOPAjCv0NGA4hTlAHElmJLW/peuGxFQpcq09wIuX4ee1BRdf4I2zit8Pe8h
 Cf3HJf8Uu/Wd/LjDVgk78aiT+VFNDbnV2iOWvkrDLVpUEte3gNNarkUJVNkcumzu
 7EhHuA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnf8mxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 22:47:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so800064385a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 14:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795560425; x=1796165225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P0YmWpW1/eHvSSkLARJTBPm3GOpe641k7iBUB3T57qE=;
 b=gK+QsaRYjxuF4v02I/08OpWTmGqpJI06yDIfuf+zUdjCAKvtjSUZWdg/G06r8ngWUJ
 RAvj8g33lUEL23u9CihkZnZuOrDLjgnoHCwuvatNMAGfqdqOVb3GGKsvz3avo8XDj9yh
 FBdrVvbLfghycAFrhJIkgmg6WxviA+UXzBLJFoa9NX/7Y41e1aaUeRFUSFQbIpiRixL/
 cene1OYdLgSzP/l0H843sgwraLWx3ZF9r14c9ipLriJCbI9WQQ94bP/L2Wd4KlNR7KqP
 z+e2b+x0g4j7UZKsAvQ652VE/HmwV1fjBRwp64MOa7u9h0I5QzI4SoWc5qJFeXmSvU8k
 DaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795560425; x=1796165225;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0YmWpW1/eHvSSkLARJTBPm3GOpe641k7iBUB3T57qE=;
 b=qZGhpSyxwAr0PAtUHjbX9pqaUdYIdYEQ9wouOdoXHI8yiDjmvY3hFp0C/p4ce0WjZn
 wYte3HZMCxb+K74WQBEHnE4bGBNCR50ryqOyj5+eUxdkWq4l9/f7Rv1OmQICENF9K4pp
 jFATigsG9irka7fCrfRtB1nhthuW7iX0GcxcLk0Uv5Hw535Cj2qtcXu0yfpRxlvwR+IJ
 yhzKcqzI5O8YYF8nx9ctsGd7PbzmQDWUXuQf3BYaO9/RdnU95xdQNBRmkPBWes0iRUb8
 oZk5k7OEVvaZFf37tSyDRlKJRaHRokOG7gNzSO5oJOyd6vfEUDyBPdvfUKUPo0kUsdoo
 ZYOA==
X-Gm-Message-State: APuU4Z+Sd+wWre0QolHlzoSL/+C77OgBVgodOBw4vF10E/CFrhgQc2eQ
 b9w6as2IE+Hgz4teeVhg1DD541R9vqFjlIF5T8kWoFaOLxlczqfs/5sQhgwT+rgVb5DrRz6DSsJ
 n3Op1MBOtBvH4byy+8YD0hPeUvwi55qk2EcQv/qPvjcysPcWS6qDs+DgOVw==
X-Gm-Gg: AZFdTZdqhyqYcTw1+UuQ/RxiUMSCO9GEridU+zMy1uMUIzSet6Gr95CcrqBHfwkFqi1
 fcNXA5AJ++QK0PB49vgcmNK4CRvav41jxLnipbcFywmPbLuMsb3/eZijiF8ywvC2vl2iWQxqZs/
 zH6u1a7SKgGdoR62maOei36Fwhkf+GeLu2xWjgBrX2vjl2KWiizgJDmSKDP2Ub+LMP+1QtOGxnc
 fC5AYdncToxY/SkCbSE19FvL0/wht27dXunTug7ysPRgZSWwVI0YqlQQsGNnUPTTpQjgzQO8NJ8
 kUO+zGkSiXlUDj3vNYGW1wo+Cd0N5IGVBtmbLrqYqcbC+Ua/Rhkq5BG3LKLybfCcX2ptm/c3t48
 a4BDybHo45lIsZoTubvmFiLKU4R1RP3wseU6gVPPj2QgmbArcb3LGkKsPnkEMRyK8hVDX3z+p9X
 bNfKTXldg=
X-Received: by 2002:a05:620a:1b81:b0:93e:746e:235c with SMTP id
 af79cd13be357-949ba965a6cmr2791196285a.15.1795560425259; 
 Tue, 24 Nov 2026 14:47:05 -0800 (PST)
X-Received: by 2002:a05:620a:1b81:b0:93e:746e:235c with SMTP id
 af79cd13be357-949ba965a6cmr2791192185a.15.1795560424769; 
 Tue, 24 Nov 2026 14:47:04 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm457779365e9.15.2026.11.24.14.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 14:47:04 -0800 (PST)
Message-ID: <e020f6ed-03f5-4ed8-8926-b5f3017c7174@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 23:47:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less than
 a page
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
 <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4OSBTYWx0ZWRfX3hR4QitcGd3J
 vuCIgh/sLl03q4ZHpGT7JjxP7dEdzbuLZrXo8wSVy74P7d2lj4qskXHuecC6uTe3mQcRY831e7q
 sr42uIBtU9RH29QwCH48/P5uhzVMOoQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4OSBTYWx0ZWRfX+MFbKA4+uJ6A
 umf1EcU69UC8yuIB7l5Zp1b0uYzb1RpsqcGW1rMXtm6o/+itDsDtgUAh6dJZWBQUig/3X3fpcSl
 A4TM0Xr0JmL+6cHEQ/aKWadMCc6OHfgb3Y06PFfI8bs5bn1yf9qMKcMZ6jclULVCVyOgjkOpEEK
 IaKx4jxa9uZBW9Wx+Ny7RvMCETzFVYQveb1jnROEDR54cUDSM2Bwjij+35cLLUbUNGxWO+aSOCL
 DsL6Ld9zg4scPcIoPHnV2I2P/8Nd2Jbp+czv0YbOqfnNKOSilD4SNecukIB0JQWcSBeOJXfyKev
 szCux0VasMBaJKTFsjA5dJ3iEQ/2Jap9DF6zWkvsWo8TB15TXeMnOQYFUJqEeTvnnMVqDIZYnIR
 dXgxChZqepAv+FCfif9ODC5bMViBgY4pBKmDfol8hUg1NwYgvpeUphBzT+ScjjciaPA6+jYkQD7
 5vMBjOQQ1GbDwvIpK8A==
X-Authority-Analysis: v=2.4 cv=f/Xdl+yM c=1 sm=1 tr=0 ts=6b0613e9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=Ubi_aw4poBBurKDQ:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_NhedOj9AAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=yoYchZ2Zi5ai8TPxqxcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=2nPl5URslPAF9H5ssSkj:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uL2Yg6zhKWSpTv8gWE4JD1OAgR7d5AAe
X-Proofpoint-ORIG-GUID: uL2Yg6zhKWSpTv8gWE4JD1OAgR7d5AAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240089
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 19:42, Peter Xu wrote:
> On Tue, Nov 24, 2026 at 05:37:23PM +0000, Peter Maydell wrote:
>> On Tue, 24 Nov 2026 at 16:36, Peter Xu <peterx@redhat.com> wrote:
>>>
>>> On Tue, Nov 24, 2026 at 03:52:22PM +0000, Peter Maydell wrote:
>>>> Hi -- can I ping people on this memory subsystem question
>>>> again, now that hopefully those at KVM Forum have been able
>>>> to dig themselves out from any email backlog? I'm really
>>>
>>> Not yet for me, maybe it's because I'm slow.. :( Also because new things
>>> keep coming too.
>>>
>>>> not sure what the intentions of the MR and RAMBlock APIs
>>>> are here w.r.t. alignment...
>>>>
>>>> thanks
>>>> -- PMM
>>>>
>>>> On Mon, 16 Nov 2026 at 15:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>
>>>>> memory_region_init_ram_ptr() (and memory_region_init_ram_device_ptr())
>>>>> create a MemoryRegion backed by a lump of memory provided by the caller.
>>>>> They do this by calling qemu_ram_alloc_from_ptr(), passing the size
>>>>> and pointer along. However, qemu_ram_alloc_from_ptr() does this,
>>>>> regardless of whether it was given a host pointer or not:
>>>>>
>>>>>      align = qemu_real_host_page_size();
>>>>>      align = MAX(align, TARGET_PAGE_SIZE);
>>>>>      size = ROUND_UP(size, align);
>>>>>      max_size = ROUND_UP(max_size, align);
>>>>>
>>>>> The result is that if the caller passed us a lump of memory that's
>>>>> not a multiple of both the host and target page sizes then we create
>>>>> a RAMBlock whose used_length and max_length fields claim that it's
>>>>> larger than the actual backing memory. Any user of RAMBlocks that
>>>>> trusts that information (such as the migration code) will then
>>>
>>> I don't think I fully digested everything, so I just quickly glimpsed over
>>> the conext so far just to start replying something..
>>>
>>> One thing about migration: I don't think we will migrate these ramblocks,
>>> because we need to register them via memory_region_register_ram(), and we
>>> don't do that for ram pointer based MRs, AFAIU.


>> The TPM code does as well:
>>          vmstate_register_ram(&s->ppi.ram, dev);
>> but because it ensures it creates the backing ram both aligned to
>> the host page size and oversized to a multiple the host page size,
>> the migration code works even though it is accessing something
>> larger than the MemoryRegion itself says is valid.
> 
> For this one, I think we need to allow user specify MR alignment for
> APIs like memory_region_init_ram(), instead of playing trick with self
> allocation with ram_pointer assignments.

Cc'ing Igor / Marc-André for
https://lore.kernel.org/qemu-devel/CAJ+F1CKaRhO8sGf51SHf1mrL=RA+NmCdtLdPcpMrcufp4wfB3w@mail.gmail.com/
https://lore.kernel.org/qemu-devel/87in3kfiic.fsf@trasno.org/

  > > > migration code is assuming RAM is multiple of TARGET_PAGE_SIZE.
  > >
  > > Physical RAM is multiple of TARGET_PAGE_SIZE O:-)

  > > > Should the migration code be fixed, or should the TPM code allocate
  > > > ram differently?
  > >
  > > Migration people (i.e. me) would preffer that you fix the TPM
  > > allocation.  Or you can decide that this is *not* RAM.  The unit of
  > > transfer for migrate ram is ram pages, a.k.a. TARGET_PAGE_SIZE.

  > I have done some small adjustments to allow
  > memory_region_init_ram_device_ptr() to work with a MemoryRegions size
  > != backed RAMBlock, and it seems to work fine (and doesn't need to
  > allocate more space of guest memory range, or fall back to mmio)

Cc'ing Cédric, similar issue in VFIO?
https://lore.kernel.org/qemu-devel/CAFEAcA-QHJ=HaBc5WSLLap8NdDw+tty4EFfGt6cmmNOK6e_m7w@mail.gmail.com/

> Actually, I am aware of a kubevirt demand to enable 2M alignment for shmem
> backends, which needs exactly the same thing.
[...]

