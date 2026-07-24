Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72998C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnAbO-0000T4-Ix; Fri, 24 Jul 2026 03:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnAbK-0000MO-Ce
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:45:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnAbI-0004xR-HM
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:45:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lO1L1992302
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aihJJWTPfH8Bn5vWUMrEuubJdhcMlzAT4VybF9iwHFw=; b=LAU5gZUP2GKZoVn8
 qmYud/WdExRW6uQknu+t3ptjwjyWx69BBsEwSO2xfr2bfEhypEu8MsPD5QDNFyJb
 yo+xnIdt0EL1fxgfIKgtYlVdLm1UY8jikQAuqpUMdUEkwrxL/ljNUEPA9eDi6tsL
 5atmGEwpoJWErWlMsPM5uOTL6f5jQb99fNB7QricKbjG0U32W86SBvlk1nsjm+Gi
 R/44176XZSvYNEazHM3LWEMyMEJDlzQsd2H+vyRoInCdT8sXz2qPkbkeRWACy9aj
 WEm7P93nJzPyhdTYrS7KngafKuxWGhXe+rxDDhJ8zC5N+wUqyawokhaSPQg/z2pc
 fq5x4A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p50q84-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:45:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so2430271cf.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784879142; x=1785483942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aihJJWTPfH8Bn5vWUMrEuubJdhcMlzAT4VybF9iwHFw=;
 b=FRWra3Gq5LKBC1G98GJzGbpq2fCMkFScDbVdNwslj30yStyHooSSFWLdkb50ccNQ1M
 d2X0bOBRenkt61AARE6EidmSptI/y8Fq04mB6RBIN6om4CAnBxpFX5Wwicu5sdDe2g41
 wgJKdjF/Ab2lVeYxpvsDuqvq6kkxjALqGAazy0D8KwtuQO8qsXSbR6S8OQX795nzWYnd
 SlCpvCa6T87h1HKRetQlsaLRUiZGtMMCFswF0d5yH+sE7r5AOYmDdSTD9p2k9nGlY0Iy
 dpXNgZlVMs47kMVxGzsscdYxnAA7t0H279Lyvn4U3DusuGXjienPeZBo59aeCyj6UL7Z
 Ie5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784879142; x=1785483942;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aihJJWTPfH8Bn5vWUMrEuubJdhcMlzAT4VybF9iwHFw=;
 b=JJTA7iRGcc4/E4yLSMDMB1lop8NPxTWeg7FXueztLQHCYY/wR9NeZcS9nlNZAg+/8u
 OmWd3Tgp9IhC6JRnS39EkVhVSJMYSBgU5DlB7UyQMqA5CvllZ6qGFW+6GOOMJejKLK3t
 J7taZc6y+0ltQtdjRt2em/45fqeLTel4Rw8TWuVEK/ZCNw3KtuHN8iyVkfAZr92wAX6R
 /SpjWr8fCuouZYTADjIU1Ahrqun5DXk8IRPXs07zEDE/MlafKm9qlmYsnpcmQX0r/NCP
 hvkA1jI9l17Xs+I4krEYHNZjd9fQTy5m03YSQsEyYJcJjVKr4mwTOm/IkYQQ+aGKvNJ1
 bxsA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roo6F3xYpJkV8X/sUDBrZXRDpoElFa0+K8ho00UwsHwXlrGNPBpRNeHE0fTfw0RW+Ydwtbzt7jFwzZI@nongnu.org
X-Gm-Message-State: AOJu0YwbtxLefZxs/CPMMEjCUnEm/Ej8XJtI+2m9KHgQGAm4w/8ildHJ
 wE+YIaHazYr1geHu7JcAVr3ieNawzsqrG44d5E8GcfEJ5bnkcB29NfJTEqmO99s4P4fd/Jpcx+7
 6lD//mkp7kIiK/CFSwBBfFD4BBa/9i7pJUIEfxbAJtM7tP838qEEg1yExPw==
X-Gm-Gg: AR+sD11bWSEJx2Ls8vS1LoVYtJ79q1u/4N6SkVC2fi/MdVnT16u49Oos0udsKPzXUTM
 sjn0uJtbpifejq8YoiteNlaWRZX11NkHepvDTJj34AAje2jePgA/zeeWsl6GXjaB7bHhjdDX0Pq
 /7W9KjDgi1t95RdxhGG6NKgV+HACAS5PnPhYMzQjGUVBgn/ZtgNfIUjOhc5NckQyIJsduyKXrT1
 Tdy7k/69OLl3uDrpIfqpznuk3kg2Uc1Jc1cfa+Z88yCS/ewuHPq5FJQ3ceJyZ2zxZ4xjfYgKszE
 0F6kIH4ibfM5TtbGHzB3tK0abVEXqi/K6dBuIjA+TZldp3jk9YEfCP5+nAhn5oypCyNEZti//zN
 HaKi2HWTV4SQwjoaKGPEH2A==
X-Received: by 2002:a05:622a:11c7:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-5283defdf1fmr58976541cf.40.1784879142089; 
 Fri, 24 Jul 2026 00:45:42 -0700 (PDT)
X-Received: by 2002:a05:622a:11c7:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-5283defdf1fmr58976391cf.40.1784879141611; 
 Fri, 24 Jul 2026 00:45:41 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b842691sm38016095e9.1.2026.07.24.00.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 00:45:40 -0700 (PDT)
Message-ID: <e661a5e9-cead-4537-9496-8948eaecd5d8@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hw/9pfs/virtio: drain in-flight PDUs before
 virtio-9p unrealize
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Jia Jia <physicalmtea@gmail.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
 <bc503aefffd20b1806941b3ef708afbd92f0aef2.1784809978.git.qemu_oss@crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <bc503aefffd20b1806941b3ef708afbd92f0aef2.1784809978.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a631826 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=K92WTf5yAAAA:8 a=gwe2mGG68fmvmp0XBHMA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=X9ok8FpLfHEzVMsE4qxm:22
X-Proofpoint-GUID: YrDo1d0xa7-C67uyYEk6UDkMUBYrRxX3
X-Proofpoint-ORIG-GUID: YrDo1d0xa7-C67uyYEk6UDkMUBYrRxX3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfXw7FzRBT+h2oy
 9ZITGUNOuTybD+QK5BeVAYgIje37qeO6zGV8BBwy5CIO9nsD6n0s8eb2fgfRRsitlcQgdryWTrV
 Qa5oAaSGVame5VE6yya/fP7EoeFJRfk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2OSBTYWx0ZWRfX5ekVccu7cEgn
 UvniTG6O00j2mZo/1irDd8bZBcwZBzDzr3LlEXYOk2MxaSf09CN02Yiwr9JfxtW8fPDFGcI+hcF
 0wjnRANva0km+lG651dgnDiWsWVlCslnFzxCBvSKy+lwsKJ7LsQg57Wo7o4qlWz72pRQFRfvONe
 lEU50b+FSqS/f/teVTciJlF6enC1rp0L8pDyu6Ll8CtPbBwMwp9y5ELs0gxLDrqa1LazwShyKYM
 MXH0f2WFeAhi/Ff+6NrVs4Y46jo3X1PoLqEIcgJk11XYe2Y90OQcBlT/lM9t4EAgiRpOhPj9i9s
 7qTWgtCNMabBxMfTDgBvTiDl3wFDXnJYmsowuYJPadk5dVwAZOuyq7tSUTdJf+s0tPywO0ZZz8x
 W4k6nce3OZiJMj24KvVSbOJij4YPcJ7TeFMIk5E/STOQj9Q55guOIx5JJcYsWzJUb1P7VSlm8xp
 k+q/L9qo7UDFwMOT8Ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240069
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

Hi Christian,

On 23/7/26 14:43, Christian Schoenebeck wrote:
> From: Jia Jia <physicalmtea@gmail.com>
> 
> A guest can trigger a heap-use-after-free in the virtio transport
> unrealize path by submitting a Treaddir request and immediately
> ejecting the device via ACPI PCI hotplug. The unrealize path frees
> struct LocalData while a worker thread still holds a reference
> on it, causing a UAF in local_open_nofollow().
> 
> Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()
> before final server cleanup. This ensures all coroutines completed,
> all FIDs are closed, and no worker thread still holds references
> on 9p server state when it is freed.
> 
> Fixes: 6cecf09373 ("virtio-9p-device: add minimal unrealize handler")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3937
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> [ Christian Schoenebeck: add commit log message. ]
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>   hw/9pfs/virtio-9p-device.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 50dc93091d..1ec48fc9e0 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev)
>       V9fsVirtioState *v = VIRTIO_9P(dev);
>       V9fsState *s = &v->state;
>   
> +    v9fs_reset(s);

While doing the same, virtio_9p_reset(vdev) seems a better API access.
Also calling RESET on UNREALIZE deserves some comment:

         virtio_9p_reset(vdev); /* Drain in-flight PDUs */

Could you update that in 9p.next?

>       virtio_delete_queue(v->vq);
>       virtio_cleanup(vdev);
>       v9fs_device_unrealize_common(s);


