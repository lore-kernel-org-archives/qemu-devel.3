Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9206C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2QxM-0002CK-Uw; Fri, 04 Sep 2026 06:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2QxL-000274-9Z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:15:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2QxJ-0000Tq-FV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:15:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6847mvV32292565
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 10:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kGfJoSjFnA7I1L3Ldrvc+4eJtw4Df+WczMBV7FXuiBQ=; b=oyhfahlHyU4zeBck
 jWOItpyjwZWTJuga+L/YR8gpPDbK339OyCNblCoN42XYEU6z/KNzLUKUP1HzMj1u
 dZkgt10JuyUr2SxmIYeU6aCnFmAQ22fs5HhhjdKuJadj1HztGziMFXfq+IGVHauw
 aPz7TFCLYO1GL3Zo2cMoie/M2B78jLfv5WwE1sFWGX2x4yP/pKgRkON92c36Rgak
 8W+4K0Q6L8KLXGBWgIrwTd/4YKDvmswMABmgS6eNxevcVxE2gQtGMirzrIo/v1rn
 i52x6EhelcpP6cULu5LqupBhSDiOb82SAM2eCT8C8MDu5bzXAWLiq6wJ5c1AfVqG
 S8QS5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyp32gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 10:15:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-938153538caso146379585a.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788516930; x=1789121730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kGfJoSjFnA7I1L3Ldrvc+4eJtw4Df+WczMBV7FXuiBQ=;
 b=A/w0KHsgjgvJBGuvRa1k2VpZBsCj1Sx1OjhZwR/eWIQGcW9ztlAEND7g5+FWhu7vGK
 XxT2hFVFAZs78hA6OQky24A9tcF8QDhA6wvVN0vu5e6UwcvhF7MbTeUagrv4okEPQTJI
 Do+CKwOdVpCqTxlbqMJSgDVEyc8BjbcDIxD8+KPjOfFct4+UWi2hqXjB+opn1HhJeQR0
 1RfJ90+ymgX2A+bkm1S/flxiBi9sMms9F3zRTIWlN872QYYSZVhhmXM3XKJc1kG3Qmtm
 gg68vMpmq1J47zaE4Garc6neY/R/WKXyQvts7e559AIO6miBMYsB98xvme+91Ms5LuWC
 vEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788516930; x=1789121730;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kGfJoSjFnA7I1L3Ldrvc+4eJtw4Df+WczMBV7FXuiBQ=;
 b=SOOlIHMVLUlpjOrwqWpQ9/C7SUN+yTJ0qz7IBqgbuM/rkrjCJG2hPamWq55tuYRRt2
 AndGLC3v4bMBaXuKrFQUI6Z5Tey2aWaC7N++VaVQg7ZdfdFRI8I/WQlOAmMlBjIdgmbh
 1S+cRWbeFVWzPp4T1YkuYJQyJD0/nOGBS7EoYdAZIQSM542jAuyLHDPasdT+UE6dYy88
 yp151sN05okiwo/9c6id1gpRMFhxRdZP0xe1oJMYxKUOI+Zj3KomPTIw7+hA7S5hwN3E
 vm6mI0zrZbXWqI6y/w9UiTbN4Ti5eOZ7rQ2YljliKaVQ+PQDbjbegqaLpG+OdaI/0isp
 KBVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdzc4NBT6WuKlMY/QPHCbdjJCGjnfYh4fTWzP5fUxjFHRqYIxZ4GMJwG4uKHQBcVG9fxbJsn0CEQj9@nongnu.org
X-Gm-Message-State: AFuF++kZgMZAV1AHa7N1pp2P15ZX9fNMlTOzNsHvniyTE4rRRioks3NU
 Ns1IfR+jO83Q3AjVzbTLaBkO26iA0aOL6VAlhlKYQqsbhf+yg5qlWPKCuwn/WwDqxb5wuD3AdvU
 GfGyGfin9XQLLhKCrI7xz8CQ0VAOvj8vzWWIfo7cLAMyLc6DuNVZ6X+osIA==
X-Gm-Gg: AYBFou1ERgxmwWMqVAAGwMuwzJ5s+tobbnidegrofb81wst4zXJsAnmWqEOne51Z9Jv
 +vj6Zs/FCudgBbLvolNRhPbQkK5ATMEeuzdhiD+TNEUrpg8ohgF3A5Owvn78gASR8ldum5ES94b
 VJMHSvC3l9b4pyIPQNwc8V9R+bGYT2dgvNy+Oxj/wf4YDt2f/dU/XV9ERPQpAkHVkTwKjFwGr9g
 X1wwAKVFmvsZOC7tJj57fdFW1LmG+AGL6aQ6YmlUN1kMF0mgCHjjJF09CObNi58+ozg1Rt6pAvp
 nllietCxRchihISkxKuGxU/4VX8VZ4xgtFcCC6HaGI/WZrPv8V3IfGPnR8r0lpOX9OqjeWIHlWe
 U7KYzosk/o2uyOTRdfThNrl0q84syc3Tsrw==
X-Received: by 2002:a05:620a:aa01:b0:939:35e5:94ba with SMTP id
 af79cd13be357-9398031e112mr444421185a.6.1788516929821; 
 Fri, 04 Sep 2026 03:15:29 -0700 (PDT)
X-Received: by 2002:a05:620a:aa01:b0:939:35e5:94ba with SMTP id
 af79cd13be357-9398031e112mr444412285a.6.1788516928686; 
 Fri, 04 Sep 2026 03:15:28 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm5460366f8f.1.2026.09.04.03.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 03:15:27 -0700 (PDT)
Message-ID: <881be57e-5496-41f2-af0b-e21087fa5e54@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 12:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] hw/arm: Add basic Phytium Pi machine
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20260903112532.3276678-1-bin.meng@processmission.com>
 <20260903112532.3276678-3-bin.meng@processmission.com>
 <0795176d-4580-4acc-a3cf-c40f8d221661@oss.qualcomm.com>
 <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAEUhbmW4h_-az5iBsztzy8Yuu06+WMjOYcrL51sW8VEgyAaSMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Un6pg4w0OqRqmvUXagyImoi81qCwJkEC
X-Proofpoint-GUID: Un6pg4w0OqRqmvUXagyImoi81qCwJkEC
X-Authority-Analysis: v=2.4 cv=Q5XiJY2a c=1 sm=1 tr=0 ts=6a9a9a42 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=it7j-MvzHP9yZAzkGKMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5MiBTYWx0ZWRfX5yTmIW1zqd5A
 AOVBLT2Xkkk69AxqhRaeqllvpzxWK1BsERCVJ63eTiPmJ4xPotuZPlnLO7W7ySpcx1wcx2DaHNf
 tubLJp7M8lYf114U/hd2b6Sc5bp1pzKdkJqNVdxDXLzCwuY0o0nisZXwDQFxum9rJ/4g095Zv2u
 Hytf1oRBl1Z8jPxafrzA8ZbuMMAtFtaBj3kJ7iAZbIw0wK2hab5J3PtMmcY7gJ2eHj1YA3+yRsZ
 NxjIfRSA8UKBfvTkEyw+oAYgoImA7imXEZNVqcPjGhdYppvLIRLdHt3x5EHV95hFpobWjlK7Nti
 1EgjzGph8/x9wkXM8/kAR/OAHw4GXXtIkUhqmW+Hm2PHMMaW91pQ7R/3OgMlf/NZ4mRmGyTAe6S
 CeIsRS1KwAkIYngO+h/0Qx3nvcFeK+VASurhlw7gBPDEBLYGnK3xbuoaH1ImLX2jlK3fNcg5lQ2
 IMevaNYenz37mJYGztA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5MiBTYWx0ZWRfX90e+DdHR5TV2
 S3gtQpEy4WHiKh5Y/q5d/vwc7XPt7OBKqk2A14JNy7MtriSFmUqzMZk3Num/JZeQ19F/278aCPp
 15YRvhTgO0H7YfmVbQrkz7uVNj12idY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040092
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

On 4/9/26 09:57, Bin Meng wrote:
> Hi Philippe,
> 
> On Fri, Sep 4, 2026 at 12:56 AM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 3/9/26 13:24, Bin Meng wrote:
>>> Add the base topology for the Phytium Pi board built around the
>>> E2000Q SoC, with two FTC310 and two FTC664 CPUs, RAM, GICv3/ITS,
>>> and PL011 UARTs.
>>>
>>> Describe the CPUs as three non-uniform clusters matching the vendor
>>> Linux device tree. Preserve the board CPU slot order so firmware
>>> MPIDR 0x200 maps to QEMU CPU index 2.
>>>
>>> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>>> ---
>>>
>>>    hw/arm/Kconfig         |   8 +
>>>    hw/arm/meson.build     |   1 +
>>>    hw/arm/phytium_e2000.c | 406 +++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 415 insertions(+)
>>>    create mode 100644 hw/arm/phytium_e2000.c


>>> +static void phytium_pi_init(MachineState *ms)
>>> +{
>>> +    PhytiumE2000State *s = PHYTIUM_PI(ms);
>>> +    int i;
>>> +
>>> +    if (kvm_enabled()) {
>>> +        error_report("phytium-pi: KVM is not supported");
>>
>> Why is it relevant?
> 
> This is because the machine relies on heterogeneous named
> FTC310/FTC664 TCG CPU models and Arm KVM generally requires the host
> CPU model. KVM is rejected explicitly instead of failing later during
> vCPU initialization.

Hmm OK. Cc'ing Pierrick to add to our list of things to think about for
heterogenous emulation. I'd rather have this handled in a generic way,
not per-machine. Hopefully TypeInfo::is_available will be sufficient
to not expose the machine if KVM is not available. No need to think
about that now.

> 
>>> +        exit(1);
>>> +    }
>>
>>> +}


