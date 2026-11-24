Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAB606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A2Kg4Qgn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X09set2R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVz0u-00075v-Hd; Tue, 24 Nov 2026 17:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVz0s-00074g-4D
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 17:29:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVz0q-000575-Dd
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 17:29:21 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMB0tb3219668
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 22:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ShNmbDyhACrLM1WvKkBqs2b23VxyoaxZsWVwsp8GROo=; b=A2Kg4Qgn/Zp9s0TH
 3TcnLz/tpX754JDoB87tbgQnJVatpi5EFG4BnqMmVkhYfPFRb9OsH1Pbv2LNeaom
 VIBdiLrHn8LxV15o772VxB6XkpURngHuRCt8O8adbI7OI9arMN2l/Wr8jDJZmM7m
 ZKq6YThIZBZ+EQKb5aZViFS+A8gbHYYF0Upb/7Z0v+vC0wOaspFIEUTnxCl0O2Ct
 SHkp81n1+tval6nKaDcv881RNR8QM+MDNPZVCP8Q5CoA8wwBCXTABh/KVOve9t8n
 VGo6K5Ws4h5Hy1KJBAj+35N1wotHY9MVuYIOISytJpOBqr8cc9gViaBpV43g37V3
 Irey4w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnf8kbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 22:29:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-946038e22f5so58369085a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 14:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795559358; x=1796164158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ShNmbDyhACrLM1WvKkBqs2b23VxyoaxZsWVwsp8GROo=;
 b=X09set2RS8cU/zgnsVytzXY8oKoyYO5kK9A00LSwm4OunhCp9NW5VJipvjGQVE40mN
 Vm5EfFPH0el+hXboyk23Z4Hm4Y4Vw22tzbHmEn859lRcNaOcSH3q9aXVNoMLQx7laHa3
 Jhl4+LFFaK43QePOoWZS8jR1Y2InwLe6C/U2YYFqQlD9YP+/uovydD1c17swzSR4iXDU
 TbFz2r8UX46JR1LihqDm/bqtjplebw7GdSYUJltHIYjg3RKIPe71WEcIBV8r9P+AaRFs
 LKqlK+FDJhqu1kwRYvRaYCEaDOaTAxINr46xADUG1bu2S219f0xei7Qxl82e44pcEU2G
 koXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795559358; x=1796164158;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ShNmbDyhACrLM1WvKkBqs2b23VxyoaxZsWVwsp8GROo=;
 b=Ni0g9bsgYtqt/wkCz7LF3MNPnIOq1SM1W5IRPFWQYd7KmIewd2tIP703qSdlXZMBWY
 +82JbHqIt8ojUsljX55XJ6E2NikLq5XERYcPcdMQHZZv+MzxaBBuS/GJ8uzD4rXFNLDI
 h3l9sbkTwXnDBRYU1F3Ecu2k1ZaV5QAPI3P5VXlUf5Qzx9DMKRJKuvbmhtubT/tl/hjA
 ucbh5l2w/9buqXpF5jl7Wc6axJKXGEwqdAigGFLBiLPFK9ddPRTbVVXaHcJutkfjQVop
 +Y4PQZ9q1ectXGOMSNfMCZoQoM8VaphkykFrm0eQpgd5Q/CosTAUf/W2VrmV31tWBTjs
 oZIA==
X-Gm-Message-State: APuU4Z+09idVBc/WVjqyaigTY7+jvj55MvjVwNcire4yyDZ6HNNeKmjm
 62VMc08lkzqpstptienfmNcFGP9oG8VotFrafaDD50chftxF6uCLHLgCn6oWiwWkQ1N5HCPbq1Q
 MBi+DUvKZQHD0aZF+YfLn5VkJHyWPcVFJNhVCmSbP2RuDzU5OtoF8swvTVA==
X-Gm-Gg: AZFdTZdCNmHKIX9XcUqdW+qqN6dt/IUPILO0viHR48f5uYblXdjDSLrd44dHhe/CcBm
 WrblG8otXL4vAyIpIborx0nSFqsxHSqA9E4dBH5fiFVXCcrHc+5O8Q6VF88ZPkjAwR1mNnxk1FX
 wnlk+b7faqZLc6JplrSJJhjMPDH5ZkGJ92uZrf9HN83yYE0dDdV0Whe7dikFgwHhr1qlNe3ivwY
 VIlsRXRrOB4rjes6mKyFdO7+5+wt69bmhkHNL0os60jdyC3N2PHDT5e+0zq8GcEd8yFhsgEt8nt
 o/5OCPhpAdFIckL4OF+pmgBEMA65sS0g4MVSvuRSfcbjFn6dCa5RXxttInVfHlBK0PAN+ZN3Ova
 APVKoZ4Is8msK1VY0Ju23ank1dmGcru4/ORUUOf7N2e6OKfi5S2aKXAGTOp8JgWvoPZjeKqC5sK
 YUJDlq1cE=
X-Received: by 2002:a05:620a:2995:b0:93e:60e8:c9ad with SMTP id
 af79cd13be357-949ba82848bmr2799134585a.12.1795559358148; 
 Tue, 24 Nov 2026 14:29:18 -0800 (PST)
X-Received: by 2002:a05:620a:2995:b0:93e:60e8:c9ad with SMTP id
 af79cd13be357-949ba82848bmr2799131785a.12.1795559357737; 
 Tue, 24 Nov 2026 14:29:17 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm31829524f8f.8.2026.11.24.14.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 14:29:17 -0800 (PST)
Message-ID: <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 23:29:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4OCBTYWx0ZWRfXxP8yFbe1GqOw
 HcTBV+j4IhYBV8YhyCaJBKbPiDtuY9RuWh4+206+pg4tztkuYcBwFbCaMM5e8RCvqpdML9dJRts
 rf1teEhM8ioM6Xt6/X1Gx5oZCTG7FSc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4OCBTYWx0ZWRfX+WAka+4eKTXt
 WJQnR7Bj25lvus5NDJlE3YDvSLvblzYNktQoiW778ar9dvzRitPFKc+IABXlZTzYN1CdFXw2DMJ
 9UexqB4Ap9WzrIfyfn9dthmgpWj3mAcEkINVU7Hikcq16GbekNF7JSvv2F9ppUOlTW6cOCmWOVf
 DSSsada7Za9n1B9prpgljx9lJhxypbdoGby6y9xNtUPLiKuqQrc+FPNpNuzNoKkIuJSZSuJUbyi
 w4ZKi0KyfDTX1tyRWC5yqxNn6wjK9hX/Vvf9k0/krInuOY+59EConIN0qS3la2Tf4BGo570CyDw
 Iw6X76Y1NTcJW3520L3lQiEmEjSZfEuycKowzWgCusBsV1ytQdSXj75l+ZlVcnFSzjvbDrwIIqU
 xhoNr1ozXM/P0kN35JOiPVPeCkG5XIdh28FGccOqAj3Xsu0MLtT/oD7jTG46q77uNtcRNRfyqD7
 bTLekJ0r3LRXq6Dg7Aw==
X-Authority-Analysis: v=2.4 cv=f/Xdl+yM c=1 sm=1 tr=0 ts=6b060fbe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=eDDFyTeRAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=m9HIm91mUfWJKHlhNhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=xu_OM7uD2k7YPmAm5WZD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D8tF8guMO4kHfkF9JNPDtDNOxp0K21Z_
X-Proofpoint-ORIG-GUID: D8tF8guMO4kHfkF9JNPDtDNOxp0K21Z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240088
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 21:20, Peter Xu wrote:
> On Tue, Nov 24, 2026 at 07:27:22PM +0100, Philippe Mathieu-Daudé wrote:
>> A ROM device changes its contents with direct stores while in MMIO
>> mode. TCG does not see these stores, so translated blocks built from
>> the old contents survive the switch back to ROMD mode and the guest
>> executes stale code.
>>
>> Make memory_region_rom_device_set_romd() drop the TBs of the whole
>> region on both transitions: before leaving ROMD mode (if currently
>> in it), and after entering ROMD mode, for TBs another vCPU built
>> before its TLB was flushed.
> 
> Pure question: should we flush once, but only when ROMD->MMIO?  Said that,
> IIUC we need to flush after switching to MMIO to avoid the race you
> mentioned, that is something like:
> 
>    if (mr_is_romd(mr) && romd_mode) {
>        set_romd(false);
>        flush();
>    }
> 
> It's based on my limited understanding / assumption that during MMIO state
> TCG won't be able to cache invalid TB on these regions.
> 
> So when switching ROMD->MMIO, invalidated TBs can exist, hence flush only
> once, after updating romd=false.  When switching back from MMIO->ROMD, no
> chance caching anything wrong.

This doesn't run. Its flush comes after romd is cleared, and
memory_region_flush_rom_device() asserts that the region is still in
romd mode. The reproducer aborts with:

Assertion failed: (memory_region_is_romd(mr)), function 
memory_region_flush_rom_device

>>
>> Measured with a guest that repeatedly leaves and re-enters read-array
>> mode on a pflash, once with no code cached from the flash, and once
>> with a function in the flash called after every read-array transition.
>> The flush is almost free where code isn't cached in flash, and costs
>> about one retranslation per cycle when it is.
>>
>> The pflash models are the only callers of this function. Other ROM
>> devices (nrf51_nvm, amigaone) flush from their own write callbacks.
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Elliot Berman <eberman@anduril.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>   include/system/memory.h |  3 +++
>>   system/memory.c         | 14 +++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)


