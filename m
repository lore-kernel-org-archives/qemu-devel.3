Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5E2C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmofc-0005Gs-11; Thu, 23 Jul 2026 04:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmofa-0005CO-ER
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:20:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmofY-0005bh-Ak
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:20:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BcL83156225
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /E+mJnpVFBnV33x88m1qC4mMrEcrKP/097L4P3sLiXo=; b=E3ss6TWZjVCGzeQj
 Q8OmYgZZpmsk4QzFLXnZHWDPLezoW6bTvrUC78pO8v10S24ilu+oCdy+8AQHUHe/
 xoMudNuxu2HwPqbeeOfsCXLczc9e+EaVLyt+3wL73mOaKHEYMwjsSB7WoqxYQjm0
 YH4fZ1aCihgrJBlmBxwXZz6+LMLSZ7paXd3ojUvOdBiJ7t/FUY5MBWEDqcav1YlW
 shttNcnQwj1I026ZHgFlDBhWPRtcR18fz6OubI8zAXlf+0TZ9aaCR21eW4Ilb2vx
 MJS+QID2f1U7S1oiO5PUPybB6ZZoFZ0/GIYiEcc0T0kWi/dxpOBxekTEt9I0AASG
 yMosiw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk275k3jr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:20:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0199faafso8288911cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784794836; x=1785399636; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/E+mJnpVFBnV33x88m1qC4mMrEcrKP/097L4P3sLiXo=;
 b=E00FpqdVm4fYQ9UdjCLiPNHohiLevuN3vIWDldGApYzF5cq5Q8GAf4JwfhoMlUmUXv
 mSF6RJWq0sxCYPj3+kcOspKWrzpfuz5JlaC6Zs0vYUEfjl/3Dy08Xe1MoKFH/xyziGvR
 bR1ILu7PgZml6+EDvxmuPvBu7nftGFXEagmw18CaRWh79sx3U8kqGOvrsHN7vpgURsup
 HSPCl/kf9P0NOUu3GdmP6KmJ+diqDn6uEqgKwtl4QuPtbd966I2vGVCv68FgZHN/Xfmc
 sYoHHRFM/KnCjuly4pItegGs4hA+XKjPBdhL4OEbsGm/QIQVKhIqSHd1olp2lHHOZLDG
 /DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784794836; x=1785399636;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/E+mJnpVFBnV33x88m1qC4mMrEcrKP/097L4P3sLiXo=;
 b=ro67NkHheA+gIFRdLMpudd6NqKoUIQuT9m77kMhRWJ4zVj49/jsunfjUJn5NSAsEVh
 Y1pd9XqHL2xHP5/A6sPwEXTFz2Xjqg9JWjlxKUtnd8o3yuqBNhbt7VjNwLNV17oI7N71
 W5ErEifdKTCMiUgK7m6Az2esXiTRvT17CDNOFv0SjKnV5U0KShqIjEX8RKzI4HxsfftG
 4zQguxBJXzXhtqfHcn1/Wx6076lBjlK4c5xYcnG94Y6pu0nKZa7xh/ZfPIfBt2CA9Kqs
 goFVRZPhGWojCtdTst+mZ7p3ALrfT4fd7nkvbsvt+UqlYYUGP2Zq3z1UoZ1LVaTqw3GW
 9f3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpD35pd7DjGbsbMITV/Lr01/EvX5TmMglmvrVP+KJ2/xt21a+AKZ4b6JusPsco6l3sU6W6XelXYM3LU@nongnu.org
X-Gm-Message-State: AOJu0Yy3sJ8C7m3/7X8NgcrPgKIqij9P9i1mS2vXNcWjlddMLaMQmHnQ
 Ugt2A6B1jQQb7x2+hrs0wBwcng/9JyOgXs78ODmwkh93U0Bt+buZnCfIrTgARlYzvJlT8pcdLRD
 DGq1CFSVawSTYI7cH3O6Uzm5BN3IURkfQFUL9lhs0iiBmYnxT8ykSPGmpKA==
X-Gm-Gg: AR+sD11az5DQde7IYWszl0O/8HU3SmASLIay9bku9a1FWdTb6epNzi6KHYohVu8aRj1
 3p3aUTF+HkXa81TtZy9sVPAcrCAouoyuMlG2XiV7/zigtL0KoHivLdu0Ew1FRmZ/ASFUF1npDbb
 6aYzR+WJlmeRAu92jWJDcTRaqdE4g9lL9Qzfz9QOU+vKJyo/7mHFzvdEwegCxYjXz26nxZSMqwH
 3oNuKJqsHVObZKMbzqpHH93494AxBzPATF7u31jGSkyCWNrmlWaVYCTWnxe9LtjU97Pj/SIhnAa
 uR1XIlj6powQzlKXYGv4iUbcQyqcu8Wf5xsZrTNwmPqOGUGLPmdbO/W3esbW7BeGXQ4XNNNMPJE
 fRyNO8cGsn3yS/jTyiYZrHwFUVwkBARa3PNysaMttEXNJ5m6vUt0=
X-Received: by 2002:a05:622a:1310:b0:51c:7b12:5fdd with SMTP id
 d75a77b69052e-5283dfd78b2mr16402611cf.73.1784794836546; 
 Thu, 23 Jul 2026 01:20:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1310:b0:51c:7b12:5fdd with SMTP id
 d75a77b69052e-5283dfd78b2mr16402461cf.73.1784794836004; 
 Thu, 23 Jul 2026 01:20:36 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4aae16sm131381515e9.0.2026.07.23.01.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:20:35 -0700 (PDT)
Message-ID: <84061116-c6d5-4def-acd8-ba9c81a0eece@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-8-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723070059.6332-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Q53iJY2a c=1 sm=1 tr=0 ts=6a61ced5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=JKVTjpLFs9Zlh2JzcrUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MiBTYWx0ZWRfXxuPmcf94iltT
 9JrtBB3Nkp6K+yAiUZdJYnWkfA2CerH3NLUHEqgxMOGQF8Dr3Xni5xu1TVCVKMPqjeuoxYs9v6U
 8C6sOpqnbMQARmXCtALIl/iwJonNJXk=
X-Proofpoint-GUID: M4qtWxq0IknhBJ3xMfE73Z1M3trz0Gxl
X-Proofpoint-ORIG-GUID: M4qtWxq0IknhBJ3xMfE73Z1M3trz0Gxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MiBTYWx0ZWRfX3XMixwwE0JR3
 NAx5tyz3oxCAL7jKiWXGAJtkCognRXNLDSonCrtnys5h4LZfDhgguBVhJMoNQJFiOj6bSCBWRmJ
 xl5FFFdw52IBs5rIX+ICr0hbqqIGskI8qrf87hVWlLiZfesq1TmUYEe7WneaWMdXro4yA5TEk25
 oZrq8QRiNUHdKjukgwbrFhYbIjR2HkqKTuJjTFx+MyCsRm6S1j5wz2YfpNPzyKdwCrLSoiax5DI
 UrScZriyEALin7RBT6fhKnQzodchDiphBalSKEgOJYwqnFQ+/URBn5EucEk6NMKibVmPcPXf+jv
 6eptDUW4NuqbOCc6L+WVJiVgcKeDMzWK3SHuygfUjkHIGv3n/65fFNiWH0VjLIk9XDUPNYNyt/Y
 z5K2gAsl9f8dyVkLzmiiFx7NwQaIOe828jmytUvgVDUVpuLYnZi1iTCpjlP81N5+8kzYyHmtRia
 XlJ4BYdqeYxL932TEYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230082
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

On 23/7/26 09:00, Bernhard Beschow wrote:
> As indicated in the comments, the `mb[]` a.k.a. `mbs []` views should
> cover 0x400 (1024) bytes. However, the `mb[]` array covers four times
> the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size in
> bytes instead of counting the number of uint32_t fields. This shifts the
> subsequent register offsets by 0xc00 which is not intended. Fix the size
> and thus the offsets by dropping the now unused `mb[]` view.
> 
> Note that the different size changes the migration layout. Since the device
> model is new, no change in the version fields is needed.

typedef struct FlexcanState {
     ...
     union {
         FlexcanRegs     regs;
         uint32_t        regs_raw[sizeof(FlexcanRegs) / 4];
     };
     ...
} FlexcanState;

static const VMStateDescription vmstate_can = {
     .name = TYPE_CAN_FLEXCAN,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         ...
         VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, 
sizeof(FlexcanRegs) / 4),

         ^^^

This "consider this structure as a casted array of u32" is very fragile
anyway, and will unlikely scale over time.

         ...
         VMSTATE_END_OF_LIST(),
     },
};

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/net/flexcan.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

