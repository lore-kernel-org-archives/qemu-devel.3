Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F1FCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Tu-0006cr-4X; Wed, 14 Oct 2026 16:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Tl-0006bU-9U
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:21:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Tj-0005Ut-H2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:21:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbRRb3813141
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gKMLoaT6NHOCDYGeTqe0TOq8sHeLXcYfyo2XbKFg6G0=; b=FCz0VNCErfbaRIWu
 AgjN5Fyr7egiXj+T4TsJLo5Tv5Bl9hqVtKMDfpdjSSjAg5fTZqICMGUNDrbYVkJ/
 kptzqykTyAyCma9lt12KiEmXpjG0xlwfkSODww1S4SI1zIQFIKAjmWqZcTHfkjfU
 KICwgRqdCJAIN7Ap1Q1qyf6VKW/QXac+Ldl9pmlg/IFwubB95m/G4Dpn3ty+xPt9
 2h4gF3RnJe6xL+Wd2Kp+kzNl7sVe+7mzZB8Tcd1p1MTxKE/Vr2Dh3gSoyot5jLJs
 tvhmaOIyBh9tve3VrnZ5HCYWUOmVs02DrjYREGrNm/SIVSkH4uGjJI6pT4MDFUQH
 /ja8cw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u3d6g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:21:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so4324011eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009292; x=1792614092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gKMLoaT6NHOCDYGeTqe0TOq8sHeLXcYfyo2XbKFg6G0=;
 b=DU3zJhuhvjJUADYN0gBqOGYFuEdqw9n/UTnJf8+g5Fswu5klkuFy6B/mGiaIZJXsr9
 Uw+Xd/YjcvNLZVNPoWZddTloVhtOXAVukkdlhnQv6d/XLm/0CL3oo192lOe1tCd5ofYy
 eJxxSEE2zbLViOYuSG+6WF3RLhzJgQEO22JT4D3wmL5KKSpUkrm30dU0w3rXNLYV4G5V
 e7oLdFojibsE1N4abcO/WXXHsyhSE+jIjfG6XeXTp2lKNwJ36z5xqQ/R3V5nVEGK4yQh
 a+4HIdSbALb/8HvNw1vumxrjkUod9Zx3srOYVxldpQVLV70/I8eEt4dpdjhKtc/N89Z9
 qLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009292; x=1792614092;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gKMLoaT6NHOCDYGeTqe0TOq8sHeLXcYfyo2XbKFg6G0=;
 b=WSIjNzm3qe2zI7gq4anKmSr/wiOsFBP4GmGHl/gtUWmC3pj4iCkNBOOYAVyiErReIp
 +GzfMxIdNV5QsQy2pd9ruzbqVq+9uFSRDLB+TpczzF7alWr8o0xWqWsq2M8A8dmZ5kOE
 2FXSsYDmea1nBryHhg9tZY5+udUJob7uP2Ki+v6iIkTcknrPjY98tHUJHkpDP/YT7DD/
 oT9ZjkUOxeEIVP7rbtUOINK8/bWtcco6Zdzsdm7qZoMGtZkliEQvLmldZj57950liaDc
 isOpvNbS87HsAzKeiomJUMUnBJRRXmSz0rnGmfYo11HPr20K+aWMV9HT/5EWWpIQYSrA
 9Sjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAcBu8oQKCXHNvl5gESlhjc4L+68a7hYKpsAVCUZKdmeKYGRjqrkLhrKiY1Uz0Zdv8tfKrgUYpII/s@nongnu.org
X-Gm-Message-State: AFq9FYIHDLVODrukRy07YXW/Xu8wCINvMAENOshn9QuDF95PrRJrKjel
 Zp/r9qgjmJLfMvJ2wFp6yb4+VXpQxtXmxyKH1QL8mtNSwl4mMW6RGKIFwwsDOdBegZfleFZk3mq
 YYDjVyu+OX8ND3WtadA964oMiu2gtEezaqoiZAzKcMzqxbNo5CXtAZgXngA==
X-Gm-Gg: AYBFou0QgJawuGANMfNiGLQt0ZfGJ2yj4vs8zouHj0BLig2Y/Pnc/znyHX9xtNxRlqh
 l+E2qrWh++ZhGoYybcwTpykOB2fkXlhOmRiecb7+Dh9o306Pfao8Het3rtZtiL+AtOIQXl+mPAO
 u7pXyZtYVQe0mwn7sdeUFAlQAf7sSSt1orrzXcrPMKRD7dBkzxGk5TNGpZTpOhElZOhoCnhiM7v
 fkQqefFFYWwSnp8bnxtE1kf0FS8chJQ8XE2N2ZZgxCKtSvF8UFyowUSGvKBj3b47AyN+tEdMks7
 Q4hKzYsF6W3wJwXUw2efKlPTD+zgWHRN2kj6wUNEM2pgXPUjBHh2qyz+QmCNg9FPzFaR+ME1y1A
 0E+9A55dFEFuPWtx+q3SnuIObtKvvWEGZJs7cQwqdWp0wLU6oE/QntzG06w16uf9bvgUidQ==
X-Received: by 2002:a05:7301:6f0f:b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-35ef1b4df16mr705265eec.5.1792009292185; 
 Wed, 14 Oct 2026 13:21:32 -0700 (PDT)
X-Received: by 2002:a05:7301:6f0f:b0:35e:f1a5:9ba6 with SMTP id
 5a478bee46e88-35ef1b4df16mr705244eec.5.1792009291560; 
 Wed, 14 Oct 2026 13:21:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b19c6c7b4sm29768222eec.24.2026.10.14.13.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:21:30 -0700 (PDT)
Message-ID: <8eccbbad-9f8f-4b64-abb8-d634b3e5de3b@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:21:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
 <09d841b5-8d8b-4f7b-8c62-e28d0e338d57@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <09d841b5-8d8b-4f7b-8c62-e28d0e338d57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX+fHHny+RemTc
 kBuAESefEDJ4LYHtqRsbigyFf77OMXusukyO1+HrdwiTTOf3FDc1y24SpCYUiTLOj07Zz2gNRhZ
 6ogvqeNDYoGWy2QxtRFyi4G5oM6O/qQ=
X-Proofpoint-GUID: 7c9nlM8k81r9P8mGJh4e4B4JLhvEIV_p
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfe44c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6bofpjnaxr4RaKfIrxYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX0lngHTakAg4r
 aVTyA80kreDNO1fiBupI8oHZbefuT7f4gkAZiUAllEtKk6sU+JUCe0QX/DRZiLXXDCq3K7gP6x5
 6VDVVxr0O9NOU0+rsLWdNkJh93Wq2ZgTbGPy31A/TAZqVfHk5QAmLQCfuIuS5/oH1Jd4izcgP4C
 B3JZ+pfHPjR1Yd204hAnEr5+YgUWRzFraTksW70sbLY89Px7YJne/GQaCjfkM7JH44fzVvwnOKr
 yowCyzOxbcKsx9dVT7DHo+5RrotEEJC1rnjNqXfBOQzBd1WkOhGbIeeFV4MXJshCsPK648tGKPj
 3pdxBisWmOFhTBhPqXoALmlXhV29I4ywIlMpPUFhsFq9DvN8cmFUyCRme6s3SdqdcWnr0Or8wGi
 XoP40ZUdHLi44AIHC5MrtarErBoAPkbp6NXLuxFYF2kMgRCw6BoBzTqQ2/+HMJs8WjaJPOb9ZS+
 NzN5yaXUCsAU3ZjT+Zw==
X-Proofpoint-ORIG-GUID: 7c9nlM8k81r9P8mGJh4e4B4JLhvEIV_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/14/2026 12:45 PM, Philippe Mathieu-Daudé wrote:
> On 14/10/26 20:25, Pierrick Bouvier wrote:
>> This allows a specific target to declare its implementation of
>> semihosting.
>>
>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/hw/core/cpu.h             |  6 ++++++
>>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>>   2 files changed, 23 insertions(+)
> 
> 
>> diff --git a/include/semihosting/common-semi.h b/include/semihosting/
>> common-semi.h
>> index 1e7699d7bbd..618f60f76e7 100644
>> --- a/include/semihosting/common-semi.h
>> +++ b/include/semihosting/common-semi.h
>> @@ -34,6 +34,23 @@
>>   #ifndef COMMON_SEMI_H
>>   #define COMMON_SEMI_H
>>   +typedef struct SemihostingCPUOps {
>> +    /* Return argument @argno */
>> +    uint64_t (*arg)(CPUState *cs, int argno);
> 
> To be cleaned on top: const
> 
>> +    /* Set return value for semihosting call */
>> +    void (*set_ret)(CPUState *cs, uint64_t ret);
>> +    /* Set an error for a semihosting call */
>> +    void (*set_err)(CPUState *cs, int err);
>> +    /* True if the guest is using the 64-bit semihosting ABI */
>> +    bool (*is_64bit)(CPUState *cs);
> 
> const
> 
>> +    /* True if SYS_EXIT takes an extended parameter block */
>> +    bool (*sys_exit_is_extended)(CPUState *cs);
> 
> const
> 
>> +    /* Return lowest address until which stack can grow */
>> +    uint64_t (*stack_bottom)(CPUState *cs);
> 
> const
> 
>> +    /* True if SYS_SYNCCACHE is implemented */
>> +    bool (*has_synccache)(CPUState *cs);
> 
> const
> 
>> +} SemihostingCPUOps;
>> +
> 
> 

It's a nice intention, but this triggers more changes since some usage
of cs will be inherently unconst, for instance riscv_cpu_mxl.
Yes, we could patch all the callees to reflect real constness, but it's
beyond the scope of this series IMHO. I'll keep it as it is for now.

Regards,
Pierrick

