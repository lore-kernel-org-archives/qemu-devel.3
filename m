Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178ADFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIUMv-00019A-FX; Thu, 30 Apr 2026 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIUMM-00012P-T9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:35:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIUMJ-0007mi-R4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:35:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UFN2vQ2941670
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o73+wVUbfZ64CRb5FCEd5kNWzMHmLMy+Nngj4UMXxVw=; b=SP/m1mmDHO+nZpBt
 1jMGLXn5NgJEndX7Kv5z2XZLlAmQDVcpRHUUceEEZ7xqPyeO2+FhoF6H1Jm2G8Sp
 fH+MlJ0nB8PhOe6j4auM6DwymMkMyii7CoM9HIbwXAqhud0mXm9MpwN07INyA9/i
 GWmg/c6a68M2VpXkEYm4S1YVL5fmkFTrT+oCAepeK9k1F6oPjVs/Ru/oFr51fzkv
 dNXdZ6bejdX2Fv8O5BGMw59ZAN/CdLKZpO3EFrsqd2DcXuShZJHUV9Rz3p88CQ5O
 xpBfwpxrvOus3GUdy24MF3yl1TQyd9IZlAU4/mOE4UBxJzTWV7u6WQGRI/IWcBcj
 MR77gA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duyr432q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 16:35:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so1812614eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777566923; x=1778171723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o73+wVUbfZ64CRb5FCEd5kNWzMHmLMy+Nngj4UMXxVw=;
 b=VPSDP4m3oSWbYhwQ5koaeHTZyXceHrGiMN3DXPxrgClLrC5Z6kd6RQShfeAD/L73Tr
 N+jjgz97zXSiyLQCutT4kgdxmSTjMkNbv+Xp44RY+xUojVmXhbTi1uoN03dWxqfHXHN4
 bCuwI0+Uynk9Zf/Ymrz8gipE502wRJh1e76nkp2jtqlCH4QF3pC2UKP828wBXGeF11fH
 WuWYF/EWcVXbfsjLPm13L8owl7mnihMRY7lZh8vRIT2wQH2fvqZito4WIYTKOEXHVlPP
 YCBe5qoewBQfMeQCoAkXzwutL3TX+zv0xCOBuIRWEu1c+AdwryzyT1rw/qv/id9vh7EF
 DEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777566923; x=1778171723;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o73+wVUbfZ64CRb5FCEd5kNWzMHmLMy+Nngj4UMXxVw=;
 b=mXoKRD/KtEVfHlU7qluzLxoHb5N8bQoKzdn0Z2uQKm5gVIynnoaFKDs3tPxEYxeMDp
 xAU689sGgz7U9bOcXREZqCz1ItDTQn9Bf06t//+es+CYvCzvESPA6gffAerxRt00CqAV
 ai3rfYiRwaEzkAx+fcQBs3K1lXG6HXTkyFOEQNAnOEOF7wOsCTxB+y7awzJ4d5yH46kt
 WjVKhpdOpL1TpRDmI9qBSyVpSE0zQdC5gnFBkZzA6IeKPwLAOpSjJ5kSJ8bIpoeD4Mz5
 16aCZlqv1GxyZ8LUWvbBpNrZfCmGh0IAWk7JN/As8H9w3l13IO5WWP83UQVgkj+Orfng
 a4KA==
X-Gm-Message-State: AOJu0YwjJntacojBRIqykuIYB5l6P+uN6/O7Kc4mb6GrNMg76vo/omHR
 vjbGvLJk1VjU4KGlaOdCZt2b40QhCHYmQhnXDVq2J59S/Zvl2rVtSTRobWFWtA+Q9zzq7WoikVA
 SQAQqtlhWFwJ7AM2XHAMZj+UNUtfd3FTRVWZIy56zqCGaqi0XqZGp+utGCw==
X-Gm-Gg: AeBDieuHh6k2Y+ViGHc4sSYjnQX36daorwOvvmW0F6yUHRyncOojmNCynbP9+pNpLyT
 yZ9E6LQRHSRJA/UpTSAEIncZul/mNqwyQpE4HwOIsPvxHkPPH1uKPrbdjoXCDSIB5O+IUW1Nab2
 xl5Eqb1LLKhhFnJVB6obqiZE6reYwc91HOSd2Yozt0GJm81yNsXMggtrxv46xHFdZQydaS4Ygjo
 4T6iZ5HHdR3TTW+LmLG0sL3iGdMEneaG3+CDTarvzvWvymM4buEUm9l6dQDwdY/MaoCN1uYAUpq
 Tr6AFqA1IJ2AOxzG3MVuZSmGnY9waI/BdT72LKQpk6lQbPYZ3YWc7t/O736hyuG3+f002HlSzqT
 mIOnLAAEsPbvvGZEN14DWpD//z3dF0QMYCeWyX0WDlGm4vlEUN7Lpgw5pxpP8v2TBFz/QKLC6bQ
 ttedR9B9HufvFVbsflFCjov6HO
X-Received: by 2002:a05:7300:324d:b0:2d1:9b35:4eec with SMTP id
 5a478bee46e88-2ed3c4d51f5mr1572059eec.2.1777566922562; 
 Thu, 30 Apr 2026 09:35:22 -0700 (PDT)
X-Received: by 2002:a05:7300:324d:b0:2d1:9b35:4eec with SMTP id
 5a478bee46e88-2ed3c4d51f5mr1572039eec.2.1777566922032; 
 Thu, 30 Apr 2026 09:35:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3bf6812asm471595eec.28.2026.04.30.09.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 09:35:21 -0700 (PDT)
Message-ID: <68c58756-f5a9-4a8f-9085-11f417db7f4c@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 09:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pythondeps: require Meson 1.11.x for Rust support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260430083411.807762-1-pbonzini@redhat.com>
 <ce92e959-1194-441d-a900-44004bf56d4a@oss.qualcomm.com>
 <CABgObfb0okzA7z6PcCoUZ3LQLN0=zQ6HgqGzXE8EVXn7TTghnA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CABgObfb0okzA7z6PcCoUZ3LQLN0=zQ6HgqGzXE8EVXn7TTghnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJcm5v+Z c=1 sm=1 tr=0 ts=69f384cb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=EDGFiycANETlAr8RHyYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE3MSBTYWx0ZWRfX9eCR+W+7sRGQ
 wKlPalCaugumsrq4I+TR5KNa/6GQGjH5d52cltK9R1PCsmuD1YJtFhQeI6WxEA3HfvA+3hKckzb
 rAN42jr9cbSRoQAFEtShXyHVT4aCW9CFWFedhqlZiPp1XRRXpd+YEL4JPrwqfl+Func/piBsyq5
 975+Ad8HswNnEtlbmw0zYGMxEJKFFsqbLF+WYKNtPJTwhSl/jG7b/Unbb7nwsBjn+YU8NCUbDiE
 dbLPagWnr2RZixPPiNgHApBTL/oN+QIh6g95QZy4IN0tOYfO7jVh7JEQ49nYQRdaCg4rsbVHIDZ
 XJ7eVOADa+u5uIcVYd5eAasW9hpoW8zQ5JKKB4SwuRsz+r6EDyo+XjtLe6730L8zX56Y1KHvwp2
 UB9TrJwMapoT1hS1LtJa/BHVCTJkBOph74RBdc4i+g3JGpQAb08xUoqNMGDIT1vIjOqoBRX8AVH
 FSZdYJbWYULYbMZZu1w==
X-Proofpoint-GUID: Hgq9l0qJQD7j-r07RlPQyroM8EtoK-QA
X-Proofpoint-ORIG-GUID: Hgq9l0qJQD7j-r07RlPQyroM8EtoK-QA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/30/2026 9:23 AM, Paolo Bonzini wrote:
> On Thu, Apr 30, 2026 at 6:22 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 4/30/2026 1:34 AM, Paolo Bonzini wrote:
>>> This fixes plugin and module support, thanks to improved support for
>>> passing linker arguments via rustc.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  pythondeps.toml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>> index d0e86425313..47d4caefa90 100644
>>> --- a/pythondeps.toml
>>> +++ b/pythondeps.toml
>>> @@ -24,7 +24,7 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
>>>
>>>  [meson-rust]
>>>  # The install key should match the version in python/wheels/
>>> -meson = { accepted = ">=1.10.0", installed = "1.11.1", canary = "meson" }
>>> +meson = { accepted = ">=1.11.0", installed = "1.11.1", canary = "meson" }
>>>
>>>  [docs]
>>>  # Please keep the installed versions in sync with docs/requirements.txt
>>
>> I sent a patch yesterday but not sure why it didn't reach the mailing
>> list. It contained the 1.11.0 wheel.
>>
>> Should you update configure and the wheel file also?
> 
> Yes, I have replied to your patch and I've queued it (currently in
> CI). I initially thought of making this a separate patch but in the
> end I'm going to squash it with yours.
> 
> Paolo
> 

You did well, I just saw the answer now.

Regards,
Pierrick

