Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B6AC55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrAG-00005e-1E; Mon, 03 Aug 2026 07:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqrAD-000056-L6
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:49:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqrAB-0003pI-WA
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 07:49:01 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673B9t43051648
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 11:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cxsw5N4jJ/n1S3+fFpQVbypg/bFRiTJMzeFOLOhiJw8=; b=SJGTvPbM9eMR/Iyf
 yRiJ8XJpkm1JL/9lSUFX1mHaGIXz9lgoOva2h4W6PTqqAYQb8Lu9ZZ/XJTOJ570r
 iySlt38RwQmwXK6L4EXfulnButYbVDoDslXa18X8zgsgyRYCoDQWolK8adFuAbl9
 tYvUzPfxLqgujabiiXNOlZtFfYAUK/+qLRcYeBHaDzHO4G8ihHHrAN3x8hFoYDCh
 QL+DX8yz9sU6iLKC/aYnkfeydUct3DtpzmKw839MEKcq4VhyU9YVFo4T6Xg+hFbt
 0b+LZIGhyqoz4HzWmgAYXsrnD/I0Prr7VZHFF0L3u5+wtaJhAv9E53wThtcrG8pd
 JK4w4A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrb9bd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 11:48:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso59036211cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785757733; x=1786362533; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cxsw5N4jJ/n1S3+fFpQVbypg/bFRiTJMzeFOLOhiJw8=;
 b=ijml0ok/GosdTRN03ivSNw7pqUqcakyQ2DJ3PglG4hVOsV2ke5yprCiJFKqk1pBNsl
 tcnW/eGxD0RljvdaYf2LysHjZtxESepmHe21HOOmPuo9taqgZ2LZfGi/LxhxlAgKfFqK
 m3Nm/q1ewegbd6xyNdj67ahZwgHycAYIdz5DdtEbKJiyyJ8YLElCDBpVyg2adhgzuoDG
 0bbuPLIM4s7K4WP9NoOesxPwDt1rwiwdkSvKX4SIJ1L/MAKhgCDrfDslk9GMbBCQIsTY
 hEDYXFJYOmOtJjsYgDTEodx9dAoTukYN/4lLu7Xos4SImIvhdyILnzBTpS7f6GN8XEH1
 1UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785757733; x=1786362533;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cxsw5N4jJ/n1S3+fFpQVbypg/bFRiTJMzeFOLOhiJw8=;
 b=UQVnykGyqzAHrIIloLotWDqlgCoJdfYp5lfDX/L/vb9ZzxIDjdugU++mK5uloHQHMd
 kSidIuEtnH+Czi3zAEYrSkq0GbioIdr9ZEDvY16zuqQwkM03LAi2KGT4moPUV2yGEfW3
 huoLv/owFuArh6xSHfs+ONMpzFupJRlnqS/OxyxnC9KRhYoS8RWELainBtGoTk2UMP4w
 F68HLZKkoSXXJi86Lx6O5QCce1+7/h5Em1l/889m+18/mbTiu10zubbBb6MyDV1W1/Im
 Ej/zI98qnKzp1tiT/ZhbcAhLk5/BP7m5+Z+ezmcPrwtBKUg3mWV9vmvcuFUGlf8ch3sD
 8kDg==
X-Gm-Message-State: AOJu0YzLlNYLnIacYRAjHuM7yURJsT0fhPIJaO7WEgk8y0/TbkkD1fuf
 /9NOCnUS00oQ0ToIe2hDSS2pV3JAp962th1xV1+3z0AJrZ9EJ4nepFbdoa5lJcr/xqPwnb7sGFW
 i4qPxMPGBR6TKnPRAmo7jVZmxo5ONQclQpdLaW1T//14gS7EceKyQIABYm/ZGCL/wsQ==
X-Gm-Gg: AR+sD13zHr7y9NKp3S9kbDWY+i5fKgT/s51ofH5eQBlkM1+YVDBc06UwCA4/7rE3v6u
 hADW8ODCJugHHI9BHXDwtC9BA0XRqCMxblaMODu2UK3N9G9NCPjD+MQcWlELwClBBfJXuDIIWRa
 O/bFliQjZZpaO0VFJWdAQnlg58LNIMq0hvuAo+wJaRH5xnNRHTB6EXrtpe+jgJFZIH+gykZV5fU
 cgNrPhTQWyYPptpkgEPTepduc31YXO9gv9+Jqma2KlvR6D66CrqfRyZTFcVrQmpgzL2j1Urz3Xm
 l9rKCCl5qJfWb7ubr6aVCmxTKTI1fn7HHjQzCHCBL3Hz+dRGYOtECCQWw96fRNy6SnNHGku4FJi
 ULcXn2B21VU1zINj3t9ApyhJX/3MJHRFXDEfyXS5gyoE6a/Oam3g=
X-Received: by 2002:a05:622a:2509:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52b5666d93cmr194190761cf.6.1785757733530; 
 Mon, 03 Aug 2026 04:48:53 -0700 (PDT)
X-Received: by 2002:a05:622a:2509:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52b5666d93cmr194190431cf.6.1785757733125; 
 Mon, 03 Aug 2026 04:48:53 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6d7sm33173850f8f.19.2026.08.03.04.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 04:48:52 -0700 (PDT)
Message-ID: <a5bc26b5-2191-46b5-b93d-7dba4ef016d0@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 13:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-gpu: fix integer overflow in buffer allocation
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
 <5df23403-6da0-4431-be8a-a74c82298894@oss.qualcomm.com>
 <CAJ+F1C+yCx72e9AE6Vz-2a3cz+GqN-ovvFcSBXdDvyiEh5u8Qg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJ+F1C+yCx72e9AE6Vz-2a3cz+GqN-ovvFcSBXdDvyiEh5u8Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX8myOHMjTUdeN
 3zatokXSd/nhbN3WuqLl6dYHSoJg9h8YpM6fSMhI77jOOwuEsjtxImDcmAJq3npd+kfU5cC9kbK
 CaHVzO72nL6L3w2+mqzg7UvCpiEXWJY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX4jzXQctQWAuc
 mOFpKEA75K5TQzu1deCTpiFkfslQOV3ybTWYIabJty6saomu6zbsXPcesy844Bs/3Q8mihPZpka
 4yODgXURPzctdHA2Un2hdbfRi6DzJt/hOKC3trV3uO9v43aM6hi50rG6YxzBkwftV/s4fNze+/t
 y5nRE4bl0u1LmOgsaCiuqfLtZ6PW5lV4WfCfhdrA3yS9XWxrfre7nsFMiWAzx/TV3hC2eHmBx6M
 n9pCPAZ5kpDAlNNf0u6xhi4tVXWY8rVKfZp03gxEtNAoLk5M3QzOjv+k7o+kaxUOCq7ishOws07
 ECU4imQ7/TkS+uFT9ti9/N4h7rBWjmZ0vIcu4dQ4hayABeTlvyB2/BIBPUGOeCCDNivd3z3khlS
 XH8LcSscJSnLxLgxe+onsnJNjugE4jfDZCYxu9y8gb/sfHuF/mjt2Fuo1QR7gCqmlic9mxU5yzy
 y4WckBj8TpCd/GM2lkA==
X-Authority-Analysis: v=2.4 cv=RNSD2Yi+ c=1 sm=1 tr=0 ts=6a708029 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=6b3zXhvIAAAA:8
 a=vpfsDNsLfHy5G1n11wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=vnv6_c11HO5uxQbMB8V9:22
X-Proofpoint-GUID: ju4jNQDuJqisHus4oy2BSCvCjp93er1d
X-Proofpoint-ORIG-GUID: ju4jNQDuJqisHus4oy2BSCvCjp93er1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030105
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

On 12/7/26 08:48, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Fri, Jul 10, 2026 at 7:35 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 10/7/26 15:47, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> A malicious guest can trigger a heap buffer overflow in the
>>> vhost-user-gpu backend by sending a VIRTIO_GPU_CMD_RESOURCE_CREATE_2D
>>> with large width and height values (e.g. 65537x65537). The allocation
>>> size width * height * 4 silently wraps in uint32_t arithmetic,
>>> resulting in a much smaller allocation than expected. Subsequent
>>> VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D writes past the heap buffer.
>>>
>>> The in-tree virtio-gpu device (hw/display/virtio-gpu.c) already handles
>>> this via calc_image_hostmem() with uint64_t arithmetic and an overflow
>>> check. Apply the same approach to the vhost-user-gpu contrib backend:
>>>
>>> - Add an overflow check in vugbm_buffer_create() rejecting dimensions
>>>     where width * height * 4 exceeds UINT32_MAX
>>> - Promote the size arithmetic to uint64_t in mem_alloc_bo() and
>>>     udmabuf_get_size()
>>> - Check the return value of vugbm_buffer_create() in
>>>     vg_resource_create_2d(), which was previously ignored
>>>
>>> Fixes: CVE-2026-15264
>>> Reported-by: "Vulnerability Report" <vr@darknavy.com>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3940
>>> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    contrib/vhost-user-gpu/vhost-user-gpu.c |  8 +++++++-
>>>    contrib/vhost-user-gpu/vugbm.c          | 11 +++++++++--
>>>    2 files changed, 16 insertions(+), 3 deletions(-)
>>
>>
>>> diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vugbm.c
>>> index 503d0a4566f..710d5452977 100644
>>> --- a/contrib/vhost-user-gpu/vugbm.c
>>> +++ b/contrib/vhost-user-gpu/vugbm.c
>>> @@ -13,7 +13,7 @@
>>>    static bool
>>>    mem_alloc_bo(struct vugbm_buffer *buf)
>>>    {
>>> -    buf->mmap = g_malloc(buf->width * buf->height * 4);
>>> +    buf->mmap = g_malloc((uint64_t)buf->width * buf->height * 4);
>>
>> Just curious, would this also work safely?
>>
>>          buf->mmap = g_malloc_n(4, buf->width * buf->height);
>>
>> The GLib description is:
>>
>>     This function is similar to g_malloc(),
>>     allocating (n_blocks * n_block_bytes) bytes,
>>     but care is taken to detect possible overflow
>>     during multiplication.
> 
> Yes, that would be similar.

OK, then patch LGTM!

