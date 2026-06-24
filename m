Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F806CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKaU-0004mH-Ng; Wed, 24 Jun 2026 06:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcKaT-0004m9-Jq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:12:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcKaR-0004ht-Tz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:12:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5tu0r2438899
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gZ9T77xPvqS7q08Fxc9Dhe2gSWfXHqU9L7RCio2fYN8=; b=gOBqTaGU3WZue8gA
 BUTtq7X/q3yxNZOmjrpFKPVaxInn7ZICTfUtq9KZAbVOLtbv0ztfMXpdNz6K34Pu
 eLPuG62cSU5hvEGLJHUtJYer3JIFLtUdi1WeQT0Yu8dIZFCu67PJALA2BP5ZJZnq
 IIwT6ydL0LLJ77i+5ama/FpnU1ybCtdGvhtboI7Kba/QsXHhjPxUu48qg6MWV4nV
 /K1+Y+2AipisdC3DLhDhexmfIFbCoZZ8U0LnMD3vfxHnEp2QHrv57t6jbyL/j3X/
 uWEo1q1ZU9MEF2VJvPs6EriAyn6Aa7aExKjyv+IJfFOIzxiXTel/X/5pduAfVF2N
 pKx7pw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ar1qg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:12:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9214bfa3b98so138219285a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782295921; x=1782900721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gZ9T77xPvqS7q08Fxc9Dhe2gSWfXHqU9L7RCio2fYN8=;
 b=ZjdDhiICwe/vG6/6KhVp8HvX5g8z6jl/g/iovLGs4351ZUFKHZ71iudt+luU9g47d6
 es+DyHGJlYNzQdcxKTzdYZqBN4u+FOF22xOmBAEgejWi55BuByC+gCvc5g1Z47CBO0Yo
 JabD0CyYkYM2KClWvYgAnO04Cd6rap37+b0oZgA+hM+YaUXfv+CIo7QeVthDCJ7CLY7i
 rvBRT5mjeyaxP3VEXeUpxOqgd30f6iAVEsyxCn1EZ/IBvfjl92rO+ntley5Mz3wpZDSy
 kG7boSaAqdj0xAQQd+xk3VdAQ1ZbdaNEKzxwkTiSUeiOKY/QIeImd6NMMJ/mpR0YIiBM
 JpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782295921; x=1782900721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gZ9T77xPvqS7q08Fxc9Dhe2gSWfXHqU9L7RCio2fYN8=;
 b=ApOq0vLHR9WoRts9k6fjrqe7xwPsMZgCbkIXo2WrUK+qb/HMbni3Pt2n3SprwqxlHw
 l361V64GwXoQkNVJqRf3AxoAxfBsb+Dm0h6cR2dyvjA1Zoh58D5/f70uWP3Gj+y7OX6S
 cULEUOxmfr2XJ6paKVgSkVyIKar+x/SmYLtc7288L6w0j7Hyp2B1uWT6jxqPSwIXogul
 +L5H0BNOiSFkJVQNFxJunfcnFjzj8FR2lW+2/tD9zZTG1JSq3PX6/SOdTgfEl5FVtgbg
 gziEuyrKvNT53fXvPCj8vtpQg8HsFb6IKRuSq9emJeLAycHANWWbUw8aNy4rk4Ugtpef
 sYcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sLYc4GD+kBxbKqAeTjwXwL9BOpO2TaI1dH3Bmj9VzmqK1gAlnO7ZR/LU02LQ1hwUh33Hh2LRW4Cmq@nongnu.org
X-Gm-Message-State: AOJu0Yw0UZiEUs4HQtaNNodRwyKxemUvrILCl16O/orjfz+VK1T0CUFS
 wBi3FzLfATCws9e56h0JRasd3hAwHoO6HwPobyI+8Y6d9o/FVNmvrDZOOq2CdOORM20kR+1h3Ey
 3NIOxTfv3KYWnOGRVG3TLsGH1fTDKq7st2C/TyIWLwRhb4nIF4V9eEmZaJw==
X-Gm-Gg: AfdE7cl9swsMic3kvmEFuecb8PPT90HRQeDJzbLjfdJjiq4x2nlJXgxeb7Qsfht8Ns9
 s5p9GOrQplrOPTkBH5Wlmp6fmI8g6rmutJa211RfdW8BhvhvRUNUyR4r+JttHujRwvVPLdhSvI4
 4IhP79E5Z98UUNbOhGSN6QXuHLVyY1R/aSyqb8HBvrKxzhbAkjYrVq/AgsuDMM9YEMnJ/4RsX8p
 VDSFWjSdcdV6rbdZaNwGz+Xkdc07+6G1gPbAnTPkBv/WhLQjoS7Otvz0isgTuJPPagvJZzho3VD
 Zn/ECYPE+UvLFHtkDfb2oizRpIrolVay+fnl7j6AJ1g9KdSotB2rIxOT+efE3vUY+0RmsGt7XqC
 1z0HRCgYfO+GqM+wWFUJHYz8c14ZRcLUj4IIhpZ4aKwi17f0vrb2r4b99MgTkig==
X-Received: by 2002:a05:620a:444f:b0:925:4655:aa0f with SMTP id
 af79cd13be357-92783d3fbb1mr395001085a.35.1782295921550; 
 Wed, 24 Jun 2026 03:12:01 -0700 (PDT)
X-Received: by 2002:a05:620a:444f:b0:925:4655:aa0f with SMTP id
 af79cd13be357-92783d3fbb1mr394997885a.35.1782295921082; 
 Wed, 24 Jun 2026 03:12:01 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22b73badsm5543225f8f.33.2026.06.24.03.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 03:12:00 -0700 (PDT)
Message-ID: <455b2cb5-f362-45e4-b728-0adbacbb0f88@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 12:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 016/106] intel_iommu_accel: Handle PASID entry addition for
 pc_inv_dsc request
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Hao, Xudong" <xudong.hao@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1781463125.git.mst@redhat.com>
 <c93b82e7dde2e9c26ab743e80d19050bde988fdf.1781463125.git.mst@redhat.com>
 <582f27d5-71fd-454d-9bb6-6c2cab574651@oss.qualcomm.com>
 <IA3PR11MB9136FD0ACC5901A0FC8B55F092ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <IA3PR11MB9136FD0ACC5901A0FC8B55F092ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1oZfjRRIvz_w306Hi2lMUkjAlTBpUoqS
X-Authority-Analysis: v=2.4 cv=EuLiaycA c=1 sm=1 tr=0 ts=6a3bad72 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=6IYIET9UmWKdtAJgz3sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA4NCBTYWx0ZWRfXy+ZnvKCrD5TL
 dHuSVBW3J82LJBSze4oSvw9oEspejQEG8W0aghna4TMHaMTmmnUD5bbhboBtQ2TEFVATb0nteXp
 sjk3vQvKqHi7x4Yh4ZVi+4V2+1CM8wg=
X-Proofpoint-GUID: 1oZfjRRIvz_w306Hi2lMUkjAlTBpUoqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA4NCBTYWx0ZWRfX98OwYglmXe8J
 nMfgVvv3czUbbsHoMQ9TvnzN0yIUTb73tAjQCFwdAPi/l+FTox872r1Vbty1caFH0k24RuAqEEx
 4Wr5m63P6qVxxMibmJQVujuURLueCOXNvXiGdCxIY19q9a8+B1fiNR5G3Rbi/0O+jjEVyJwVQtL
 wngUtX+p6DOYsf90ChT0CmK5OH2hH2lwKYVyuurmmoxwdlnvDwx8VhWi7aJs+fMIrfls2Jwrl85
 jeqnsHmWq7CmIimov2+G37/uBroGlSBlL/rf3EG86zIwm6pUQQjXOfXVa900PbrFOYFyJuGgix4
 AFrsEdii1K6dFmkRRe2tnssDfr4cGmwjxOpkG/8EKd32csdFNOzN4h78aaLnH6ouNuJIH8hkzKY
 EQ5oc0Z1wJVUEoc1F1IuM0yosLYv9v2HTooD7AnpH6UzptMgrJcaFsr2X3epNs1D8E59ai36E9j
 u0dh5qdu0LiaWBII+Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240084
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

On 24/6/26 09:46, Duan, Zhenzhong wrote:
> Hi Philippe,
> 
>>> +typedef struct VTDAccelPASIDCacheEntry {
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>> +    VTDPASIDEntry pasid_entry;
>>> +    uint32_t pasid;
>>> +    QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>>> +} VTDAccelPASIDCacheEntry;
>>
>> Zhenzhong, this structure should be declared ...
>>
>>>    #ifdef CONFIG_VTD_ACCEL
>>
>> ... after this guard.
> 
> Indeed. It doesn’t impact build process, build pass with or without fix.

I didn't complain about build failure in the main repository ;)

> I can send a fix together with PRQ v3 series if you will not send it.
> 
> Just curious, how do you catch this?:)

Rebasing this patch:
https://lore.kernel.org/qemu-devel/20260225031658.32095-3-philmd@linaro.org/

