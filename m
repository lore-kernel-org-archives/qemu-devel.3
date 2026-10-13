Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE18CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGl4o-0000Nb-Gx; Tue, 13 Oct 2026 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGl4m-0000MJ-S4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:34:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGl4l-0008WS-6o
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:34:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHRJwk3018180
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 elaRv7sEPg/iyA4fQSbyvaRNHTml92lOgIFKMNJHvWQ=; b=LmywIwpuGYZDk+YD
 9qTIpMugyXagmLY4Q433xOZMV4OydEjq6mlci2VO05Gju56/6IlpSX4VdvPa13ps
 SqIJswzzItSa6yI0McDwl0+0ExbdMZEx3ydaGnjLF4wOAC87t2GuqywjTPq4hPDG
 h26Z5HoVM3ZVv+RiJp6EAQqeAPgqmQdbEuG8Md5e/0ymdxhsGZ4Cq0d/xNJBPAAL
 g6xMiiYIfNv70aOD6iiSG5Cd1Oci4X3YhoGrAAB9K7vHohHWcjLyEosnIwf4383Q
 r7Rt2CAzJhZhtNu0wI3eLaRj9UDpw2TX1QsR2pvAkD+CfFd/bxQB9nlO0GY4bh78
 tD2X9Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b18r8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:34:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35cbea41088so556823eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791930863; x=1792535663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=elaRv7sEPg/iyA4fQSbyvaRNHTml92lOgIFKMNJHvWQ=;
 b=Kdk3oAg6Qv/0/3BcR26xtb7jNKIu9vCdEjTE9FXUoxz+kfOnijT8K1ZqNOGoEQa5sF
 f+vOJwsnZCf1ALHZly2cCk4OCCgx3DNoxRdVz60YsqNkg+qUjiv6a6uLthGxLoQr4mse
 V6WXcjPrWKEbl2x/WUm7GT+CMlUFV44qM3eU2AMsx8fDiIAt+QGwUibDvX5v8EV1iXJy
 HkOIjf7QTstpGUh6Joag60P2CjvRz01lhRYE/zrWSMeDuDwTrsB/HraGeC4XIWVKLV5N
 u0/BjHfPr1StvW1bhGNwo3QW7QuQltpsr4uSGBIsHgaYnWoktQ9/WX+/6D5MnuTmItZ7
 jd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930863; x=1792535663;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=elaRv7sEPg/iyA4fQSbyvaRNHTml92lOgIFKMNJHvWQ=;
 b=tpqT4SveweVr41uaEu+uMTrTAf1ZBDe44pXdc/tRN1FsHDo8ytpnyGGdYCa1Nrh+Ec
 MeEqjjwBbvDGp1fy/SruYTtNUxduGaQUPatn/69HsJG66b3NXLINjJ8x5ynAMzmAncyx
 MwylvIXL4AObQb5nXnHHGrahoEQ0rpwRdG+1g6ZykgA+WE9CPwDauzUhCpatcsWrY2Lt
 L+PRpNxsUjtGbvV2vc8kuD9n8RHsSvYf8blWG/6T5tf+Bb3/fEm6ZIhuesYfOH3H3Dgs
 ppnw3kFaJHB90PR73PBRxaFvOoj1rhp8W16uRWPewOUFsqNgFgnLjHPEczDkroSrZZBN
 Cd5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTKeyPJG6DFrZYuw4R3xZPbz9wibqYHA6hhjy50MWe2JjNC48sLQQ8XOjUdkh32Tyo0zFuKbw7lhYt@nongnu.org
X-Gm-Message-State: AFq9FYLGpH0JYM+PHqAXamNlzl0mb4gUueKd66Uha5igipOOMgywQ9Gh
 0acBlNcPDnE7HAB6GBYy2Rp0St0xDaxuFP2shn8RMJuaQYT60KuIWbsk5F+S867acheWjW9QeRA
 7Ezyz1sBdLY6e1smm9egCM+GQKQYde6alynQlHiZAxbEKmatxj+1cPpWVQw==
X-Gm-Gg: AYBFou2nU7PlhBwqxHQ1RjZvjy5xQ/sqVbQWkBrmTbv+xDsUPeryuWYQ0nSPumZbnmR
 QAvahsxFwC63q0v/ZySBAroD1V5FrvS7eNR9pqPb5bjrbh3HiSKsHhQpBPNTpYa9dcKTwv6nYrk
 pn1CTCQUz/GHxyTEm7HkYJkEp8YX3gEMZKhZQqWUS6ns8nZC/3g1zoEnhkiHTZKLifVJLSqMJaG
 zgX1f++R5gpQYsCaVL3fmJlkyF1sbBKR7FYTPZK7SauWYhXASLHug1fgcAN3Zy+lzsVjSGBwg05
 LobCiEdtXzso3m0jFVy64lQ9aH2tJCN7X4JoHiPZYGZA4Lv1TwOu8rxAkDXVxiyA9WvPSCG0zOd
 mwWOLWuD3QxlbpSmK+YkKSliO8qoAG5FrZZXNVbtZ4b4TGSLzKpAcdVgP2OOObuPVL5PBeA==
X-Received: by 2002:a05:7300:d115:b0:35d:2364:d4e5 with SMTP id
 5a478bee46e88-35d2364d636mr2285204eec.11.1791930862590; 
 Tue, 13 Oct 2026 15:34:22 -0700 (PDT)
X-Received: by 2002:a05:7300:d115:b0:35d:2364:d4e5 with SMTP id
 5a478bee46e88-35d2364d636mr2285173eec.11.1791930861919; 
 Tue, 13 Oct 2026 15:34:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35c89429484sm9195937eec.23.2026.10.13.15.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 15:34:21 -0700 (PDT)
Message-ID: <cf93c914-b533-4468-bea1-b0cecdd3fa93@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 15:34:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/hexagon: model PCYCLE counter
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261009003521.2227155-1-brian.cain@oss.qualcomm.com>
 <20261009003521.2227155-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261009003521.2227155-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6aceb1ef cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=eoA1o2jx2Vl7u6AJQ_cA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: KRgnytf9L4AkrerYMyzxriP7MTEB068h
X-Proofpoint-ORIG-GUID: KRgnytf9L4AkrerYMyzxriP7MTEB068h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfX/Z4NXvZcO7Xm
 O+CMrVczM/6X3XBvwhwa61AYK+HbseJoHM5DBcuwz8EUhktMZ5On6JXZwNXaKQk498s9Lj6rbVI
 Zd3CMNNRZpCp0XNemsOP+pBgXvROY9yS5cTvoikdwq5zie1hkuIyc5/QiNx5jhNrSRZS2Rmz49k
 k/8QOws519xCK0KtVCskUNw6B1oyFn/NHjP1mIj+hQ5pu30CwtJs23DrN0s1RxC56TKZF3Y/y04
 FOKuFVl+ZPKq2f9lm0sjZCwboO8W3/H0DgC8wEm/mZlrhDqEtTROly8G8FWcSPEM4PgFselVMhw
 O93tyPHg5vfIiusKgD06lNz8HgaEPCL0Py/RmaSR4XuW++tBk4IoFvZWH9T4m3si5nwk7Mp1atS
 UBHjzoI5IMGWicfLR5Csvlt9t/RkzKO9WvaCS70RXkFphm3B2f5qj/m2PYEmn+A9xzwkltstCOy
 Jikfw9nMU3lOiNb07Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4OSBTYWx0ZWRfXyCU0tz7f1SbI
 1edfttp6UyArUP2g9m6blAsZTRF6c8IBcNiuYa2R2N2qmnHnhrNwaeEA/dXSlrHgImVknepLvEM
 S8RLqlkZqf6MKk/uQY88fLYjyjswkwE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130089
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

On 10/8/2026 5:35 PM, Brian Cain wrote:
> {U,G,}PCYCLE now use a shared virtual-clock counter.  This is closer to how
> the real PCYCLE behaves and avoids the extra work that was being done on
> every single TB.
> 
> Handle SYSCFG.PCYCLEEN and the semihosting PCYCLE read.
> 
> Remove the work-in-progress implementation that summed the TB instructions
> into a counter.
>

From what I understand, PCYCLE is different from RDTSC (x86) or
CNTVCT_EL0 (aarch64) since it tracks cycles per thread, compared to
globals ticks on cpu, independently of its frequency.
Pushing a bit further, I also see that aarch64 has PMCCNTR_EL0, which
models something similar to PCYCLE.

In the case of aarch64, it's implemented based on time also, so hexagon
mimics this approach.

```
static uint64_t cycles_get_count(CPUARMState *env)
{
#ifndef CONFIG_USER_ONLY
    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
#else
    return cpu_get_host_ticks();
#endif
}
```

So, since we are not accurate anyway, and depend on host cpu speed
through time elapsed, is there any reason to have a pcycle_freq_hz
property instead of a fixed number?

---

The rest looks good to me. It would be slightly easier to see the change
by removing the count based wip first, and then introduce the time based
implementation, but it's not a big deal.

Regards,
Pierrick

