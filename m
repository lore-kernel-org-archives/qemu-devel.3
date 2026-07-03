Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa1E-000749-QL; Fri, 03 Jul 2026 05:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa1D-00073x-0t
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:17:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfa1B-0003pG-5p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:17:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6637ZgK13410048
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 09:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HFdkywTkmu+cO/GdHRntTLOjky0TWYm/hourhkaDIg0=; b=Mre73s6HT7Kq6gKa
 y9oMy69QnakLLymIkOQMb26wo+dJojQ1/HaVJLa9C460Q6V0DrXsXyy8W4eWK2Yd
 SWu5uZl99k/Vu1l+iZ0pi4MnbuErXwlj3ZKtvvNiYHcjiIjidzmq5gxc2RI75i29
 6YShkQHZYbg0FwBktLaHt8GKOLfVhq1Uq9id+gNzimQ5fF5zZv4Mn193EpJwlgR7
 jdgbp0tQi5Ni95lZsTiHpiRFKqLOoYxnJuL2RlRVjVdvFS8t4BPbZvRg5mpAEiM9
 UXIc7HbBet8daoh8WbLKBduQ5fKRk7GWN+FJy/c46C+03GjB+XZ5JYdMKhSw3LWh
 FybI4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u30c3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:17:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e8004d60eso58133585a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783070222; x=1783675022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFdkywTkmu+cO/GdHRntTLOjky0TWYm/hourhkaDIg0=;
 b=Rc7m+WhSca3Xts4WG2+/hBTma0C+HLYD0H7xEh5FC5duk26/Z0UizT5kjCKkxjWgug
 fd4juI1bkeKIOx7NJjbQ9Ju069KtFfVP5a48OzLaQItL8xDyWAwu9xGp1EEUvU8njvaE
 Zz8DtVZA/X2L13cVbIIXltClfcOcdGtUHryezDWSPPBouRXHI/sCYTltzLJ+J8IZr5wR
 ddJfTe66TS3QLa2UO7WW57A1+1flI7495KFsdB4yAlrPsjoW8fYMTlbkxb0Zw8vXGx1i
 j2+ECy3aM1RGj8NwrFvRhrmSKTyqdGE7CB+nNnHE62MeIv+9JMsKt6OrwNx5uE7PE4QP
 +Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070222; x=1783675022;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFdkywTkmu+cO/GdHRntTLOjky0TWYm/hourhkaDIg0=;
 b=px6NnpWjrb2PQWTzSpAf7ET0PbAytrSPcmUXATHmPlUH0TaIbTWBa2JchEomvNK9pi
 ni9DNvBOJjVlRjxz5hMqw/E7SIZUUsbPs7B63Px958iOd5knE7+2NfF8NJ4RY2JlVIiS
 HAGcNwZNreXo3+rFM1NXuYF2a/KQ+aJ9Kg3kVY1LQ1ErbPGj8fFJAkPRcdm2YHpxn3JV
 tzzppU4ADqykZzMuS0cg6NwiIte2mz6hW9tvpbwQaSS+Rpvyko4St75xAWWK2B9KkGZ9
 kYi6dxQQyr/h0f+DTW76bVpbCEW4kAOJqVCv9/4mpwD+px40uJZ66Yt8FF2hQ+Bcuzg2
 9I8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OLgoQAQh2b//qZoXRk2glENhbcTavEZZ5EIL+yz91KndSf9lmk8jX9/R7yZ4V9R+HgiyNa+O+Zt0P@nongnu.org
X-Gm-Message-State: AOJu0YxWZ6J0q+FpGIuG5xPpvqeqK58d5cgMp+oxwTmexwzPuyX8XKVh
 I6dIO3yWh5O9p4ZgT55NBCftM8h2cjN7sWft6Mq5S1sex3B9ocLsFwJWN1GU/ztaolMtKDyEuvf
 VmiyJQbx+EMa+ibBYx+2hBvliFfz0LnFckXoDYMe/5glJrjQT7uv0Fdgwaw==
X-Gm-Gg: AfdE7ckIQiXnvxa/dTYw/lVW/UveZLnDJlBZvWuuBb5901V8Nm0CwOs9cpGJanf2Mm6
 R/XWdRcWy74pT8cag2GZW/sb57MB05uXrLRd7udGWaQeivYw3FpmetNYM5LL5U1b/z7biQP4lzT
 6N/fSh7GdOPCHfu3mixy/F6g7ecz7P6dTMEDCyWhCKGmGAnTXuzT8LN9+dGJGSa16gbpfl4mulx
 lgwrhYaovq0URjO1oeDaCdxEttgA4q1OKibUjmtEY2E1nNC/Oh3+y/93eOSuy3+rLvRCv+YgVNI
 pSiBCdc+nt1Xk1WxIXvHJc/ufoTJ/9njKoyhiq0NDrg1NQewrSzxp0K5IO5yw8tw+tdnV7Npt0K
 P13e6b9COmoBdWwFNKqVNtg2IkLSizEkQMKSxbOfpze7kZ7D0XQYdlerd4+GYdw==
X-Received: by 2002:a05:620a:628b:b0:92e:5444:9274 with SMTP id
 af79cd13be357-92e7b017933mr1133752385a.30.1783070221716; 
 Fri, 03 Jul 2026 02:17:01 -0700 (PDT)
X-Received: by 2002:a05:620a:628b:b0:92e:5444:9274 with SMTP id
 af79cd13be357-92e7b017933mr1133749685a.30.1783070221242; 
 Fri, 03 Jul 2026 02:17:01 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a450bsm17544419f8f.10.2026.07.03.02.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:17:00 -0700 (PDT)
Message-ID: <dca7072f-6232-49fa-b8c9-dbb8f82b85a1@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/23] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-18-clg@redhat.com>
 <28c14e21-9382-4d4b-bde0-622d4dca9bf9@oss.qualcomm.com>
 <30a8d3d6-bfdb-49fc-b891-ab09c0a3a692@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <30a8d3d6-bfdb-49fc-b891-ab09c0a3a692@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 83gO9YCcR835QWEf5GOEtZvrfW18ww4T
X-Proofpoint-ORIG-GUID: 83gO9YCcR835QWEf5GOEtZvrfW18ww4T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXwEdO8DFh9OGB
 3fOCTpblpbRyHju8lrevmUAkmgxnMCZhHMdxMorMM/fY1QGQK10KqtvTKuxACdXkipvRLZkiS6u
 ZXpn3OFR3HYSQpdcbZfbUo98e8i5pgo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX+6T9V12VhHmg
 vbxP197q0eoCBvmlXW+bcVgjnF54ra12GHSN5jAqIAU0EDYK+bxdy4LSVADkcgq7HaMq2FwlMhZ
 sSaxRj+uqUnGucaQjJY5nXxHPdC39yMvb+mzl9eZqBTbIWcXnrvNsxCweOcbCayRl7t8Rvv15fx
 WJ0qM9GJkaI3R7ICeKTgdRqO50ar/vzM5Kgi7uPMMxvUsguVRkXVKd9VDuhOxyGiVyQvB7x/cDm
 eSH0dOOZMOOR0DZzqwfRyDvgMX7MGlAt1pPe/DVhhMt73EAESLBj2v3LhamcIf+h1VehSBlD0ip
 uju96UNMlnNkV1cQhYGsv/ZHxbHi1lCA1fq55k0kPGRoodFrZ7qXphDDAOXI1KmOMKQHtDI37Fa
 OkZ6CVqwXQKEUtSzj/yydQG7pDiMDgSWnyLPZPukyTZjfRrRCcwRcEol+RmWlUKXVfVTavNCqMK
 9JtF1XGzjNj6npfFNsA==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a477e0e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=6OzB9O32XWKsRYI0ZnEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030086
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

On 3/7/26 10:13, Avihai Horon wrote:
> 
> On 7/3/2026 5:07 AM, Philippe Mathieu-Daudé wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 30/6/26 06:31, CÃ©dric Le Goater wrote:
>>> From: Avihai Horon <avihaih@nvidia.com>
>>>
>>> According to VFIO uAPI, precopy initial_bytes is considered as critical
>>> data that should be transferred and loaded prior to moving to STOP_COPY
>>> state to ensure precopy phase would be effective.
>>>
>>> As currently defined, initial_bytes can only decrease as it's being read
>>> from the data fd. However, there are cases where a new chunk of
>>> initial_bytes should be transferred during precopy.
>>>
>>> The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
>>> reporting a new value for initial_bytes regardless of any previously
>>> reported values.
>>>
>>> Implement VFIO_PRECOPY_INFO_REINIT feature:
>>> 1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
>>>     VFIO_PRECOPY_INFO_REINIT available.
>>> 2. Request a new switchover ACK if initial_bytes increases post of a
>>>     previous switchover ACK. This ensures the device is not moved to
>>>     STOP_COPY before initial_bytes has reached zero again.
>>>
>>> Acked-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-13- 
>>> avihaih@nvidia.com
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   docs/devel/migration/vfio.rst     | 14 +++++++
>>>   hw/vfio/vfio-migration-internal.h |  1 +
>>>   hw/vfio/migration.c               | 68 ++++++++++++++++++++++++++++---
>>>   hw/vfio/trace-events              |  4 +-
>>>   4 files changed, 80 insertions(+), 7 deletions(-)
>>
>>
>>> +/* Returns 1 on success, 0 if not supported and negative errno on 
>>> failure */
>>> +static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
>>> +{
>>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>> +                              sizeof(uint64_t))] = {};
>>
>> What is the point of using uint64_t[] here?
> 
> Since there is no data payload in this case, it's mainly for consistency 
> with other VFIO_DEVICE_FEATURE ioctl call sites.

Ah, I didn't noticed. Does the VFIO_DEVICE_FEATURE ioctl expect
the buffer to be 64-bit aligned?

> 
> Thanks.
> 
>>
>>> +    struct vfio_device_feature *feature = (struct 
>>> vfio_device_feature *)buf;
>>> +
>>> +    feature->argsz = sizeof(buf);
>>> +    feature->flags =
>>> +        VFIO_DEVICE_FEATURE_SET | 
>>> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
>>> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>> +        if (errno == ENOTTY) {
>>> +            return 0;
>>> +        }
>>> +
>>> +        return -errno;
>>> +    }
>>> +
>>> +    return 1;
>>> +}
>>


