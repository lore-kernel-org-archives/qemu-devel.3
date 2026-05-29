Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B372CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT20k-0002En-8T; Fri, 29 May 2026 14:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT201-0001sk-BK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:32:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT1zw-0007uk-Vb
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:32:00 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIQe5H877141
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fZdOUyDKUIE6R7VAX/E0rIaldfJFcrWncy/w5G9RArY=; b=j+8BjOW8TDT+9kHB
 z7zAmFlZjajL219JNx9CGoIHin3ciyxlyL9vmu1g/Z7+GRtJ3SuA26nUjLKog1ny
 fZ+ciiw4h62tiWBBlkjakIIdnj4Ty2c9PcxnJuEGyk+ijy2p4qK0tnBVArKlg9EX
 ehAFu06WjW6yhJCwvGldbgKT3VAadt9jtIlwyQqQP7/R5PFc7kyglC/qTOGD/XnI
 oosF03XAun+SPVnKuKwdR/qos5sz5M7rTWDkWCj32noEOGPM7aFgWew5GzVdgiAk
 9TaaR7h7mWurMBo4CVaR1QzzGHhn4hVrI9Wf3NCZ3BA8e7xBWZlvn1lxk3dLWsDR
 In+8Zw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg3401fp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:31:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fbfaf5so4543817eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079515; x=1780684315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZdOUyDKUIE6R7VAX/E0rIaldfJFcrWncy/w5G9RArY=;
 b=dtjv+2R3S/MwzfbYYAUUry0jZhlhLSDXkJTAoyuXZWJ+GfWFKAA33mvzTjrckAqK+Z
 awlcr5qXKeT6bg7OMZ2r7+jFa+nmppJbQdNe2FtBi0PzUoKIFbohDH42LX2odBWnNXrQ
 KY/Uc3nkxEtsV9HI2HMRa8R8TLDd2eSXeJC+YyR49CKXfDD36wYKLShwtSSSpG8UGUiu
 xsoSOy1s6/1gtY5pcjxO5vjRFJrtlylC7czQUJDVtoBNIGchBYWT3bddCSqbT6cs8PoW
 z6yt6i5NKe0J5rR8ANzRciF0an8d1URCID0fzr/rSj+9jGZXYWBbR0dOQ6KReahf1KMW
 IS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079515; x=1780684315;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZdOUyDKUIE6R7VAX/E0rIaldfJFcrWncy/w5G9RArY=;
 b=EkMqjxfSaPqwT8TZuHuvOnS1QvXj1+fhO9+Hh6N1AU0oyqmd/rbs5wDtxC+bIlY9ga
 FWu1atp6YYkG8Y0uffX+7oU5/9bCpgL0fOZgqnRQtmzpD9eQnWKh7oibG8+Rt0sk1jSV
 CV1UwPa7eB4jB1jXMq6UmPGP8lp6fLiue275II5PwUJD52XFK5ykQoRw7FuoH78trORU
 WU8rfPmjQR0SvTBnYbnh+uPGWG6Ykydvb6FCg58tS0zdgfYuOmUNaQlhPnnjGgR5Gl7E
 ZnFsdz8OS8by57JihwFq1zgCpGLwYh+WovIX0x2QQFPMDGfVWojbZF6xG96GUT1QSQCQ
 3h5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TEbJBYISzj/K18wS4nTOXv4b5y+/Nt+fnr6/evWwE7IIcHxpe3XRnLmbmqX72M7hoysQQFwt8AtBr@nongnu.org
X-Gm-Message-State: AOJu0YyxB/ZUo10aVGeJj/9XadYcEaeUmRiO4+MpuWWWx9r/vAxYOXOR
 mtYi/qSPGWQPNum1yD7EwJqhZ2ZS6HHTAOafn9Qsz8gojKoR1SgIAi7ehUqzWIc9WxdfQAriN0e
 lnhuMpppe+1YKxou1egzG5bB+7n8iuBEDCsa8ifv2umpjCvDPx8BSDyYyEw==
X-Gm-Gg: Acq92OFMNIHTiFO8gkkSlk3gYr/MN5R3/8M0lITCjEzrMVT6las941V45GATSdqZaJ6
 xbIFaTf8MUmDBxsrrNwO52UFxs+MugMu1TjLI5qXpmg6LxTH474HAUCb6SqRILsPhw7vbBjvWFu
 LhKtdxg+rmzQTWuQaMBbPXfHkf4JCr3tEaJLvqLtFOJF1QVl6LVGIoMMXj/tG3Eb1VbDlxox6o3
 xlliQ4VSQedOuACdGY/phekkNNUcWYFs3YScpmtZq8Y11ScY6MVhJIVAdtgEPnrDJXuj+kbf/JX
 HzqQTl1TVmTRm0RfObmu7bcO4wQR1IHwjUFomwG8VyirwhUe8GGwj+qZG7bmFLkVj4t6LqLpKWm
 tcJTC6Xbmj+NnwhkR9/3/iuTMHahxsgWg6+gagKoHzPCzwnQjLWbGKRVOy8TW3+3Jdrv7ciLTmY
 4LIU0mMfgSF8Y23j9HcD/sqU31
X-Received: by 2002:a05:7300:80c6:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-304fa4c81bfmr524506eec.11.1780079514706; 
 Fri, 29 May 2026 11:31:54 -0700 (PDT)
X-Received: by 2002:a05:7300:80c6:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-304fa4c81bfmr524459eec.11.1780079514192; 
 Fri, 29 May 2026 11:31:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd6fdsm1766111eec.23.2026.05.29.11.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:31:53 -0700 (PDT)
Message-ID: <1468c9b8-44e5-4ec6-98d4-d846498720ce@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:31:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] accel/hvf: Remove need for
 AccelCPUClass::cpu_target_realize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mBJB0K6Dsy0nkfyOuaiG83K98nkSRiLc
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a19db9b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=S1AAxW5niS9ldcQwnDQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mBJB0K6Dsy0nkfyOuaiG83K98nkSRiLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfX6CHMwIS+10AR
 Up4FlLs3X0HUA600QimkRY93/993Xg11VMoz/LdJbOqVfn+LO10wQ6HsT/JHSbK7+ZfhKGszDBZ
 j1ju17/zURezKFUCqr2HOfxZUqsLBrv+oB8srNCEsIIqB7qLCbnrhZJMzV0gjDL4bnL5W8gwVM4
 7kdtEWgYfvZ3g/gG1rBylknCfoiJRL89c2GHeFkPPHsHAeRu5vyoKA5c5WCSLgGaP6lpvg5964i
 5mqIJq3OEH2EftybsnSeVSVVzwIZOs8IyRnKDkl3wmU4c7yEipkkoefaqlHE8okwSUakum/VnXV
 tucm4Zysyqh6isSpNuqcbtXPKYVk8UqhCEepn02XUfrdB9m8ZYx9j59GCJ/Wkm95IBBtFYaixhD
 KHC3XTbACxtgPkGuYJjw9TUZ53/u6sFLDlEhakWXYMNx3fDmKA3onTflqtwdJm3uRwRJfu66OAz
 EgeVbU3EraVxwi3g3VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
> then ops->cpu_realize, which is set to hvf_arch_cpu_realize() on HVF.
> 
> We want to remove accel_cpu->cpu_target_realize, so have
> hvf_arch_cpu_realize directly call HVF AccelCPUClass target_realize
> handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/hvf/hvf-cpu.c | 6 +++++-
>  target/i386/hvf/hvf.c     | 5 -----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 

Need to update commit description with new cpu_realize name as Richard
noticed also.

Regards,
Pierrick

