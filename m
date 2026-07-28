Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADEBC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocfb-0008JP-Qn; Tue, 28 Jul 2026 03:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wocfa-0008JF-7f
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:56:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wocfY-00038b-36
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:56:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aWkY1303407
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fphxwlYJox72NrqwlqXGtmxqrfLrjavamVJD53EjmnE=; b=K+VDjNAgqcYyPy+B
 r8wF6jGpaoXICoZbBIz0FNPuV/YCjq+QBMKa5AKKSdyg2xcNlifs2FQztYL5+ng6
 lNp8b9E4GhxvqG9dXW9QfSYurWe+DSL7rTRecK36Uoq4L/QTUvCwoITPfhOrYAjR
 v+7CrlE9oHAGv2xfg8FKBtRVakB8hHEX0zzZGfhBzhpWPcihPvVIHKbTaROysP/W
 QXedTMgTwl0nNXNIVZvDPNZ6jEzayZHJviZMoDl2FOKtvdYwaC/d1I1GYiV++Syl
 uq7s3oJu3OL2p/Fr8LgDVT2dGOEhSM3ta7oCw4K+TyzIzMQZD8egq3Bv93+zOObO
 jru2Fw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8b6yk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:56:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cee894b3d8so44906695ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785225365; x=1785830165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fphxwlYJox72NrqwlqXGtmxqrfLrjavamVJD53EjmnE=;
 b=RTv5WP9drTX5svO6W+JEqieHnUF92Qky36d3DtKHoRRDmC+5EF9t38mibRT/3rBRCV
 W0Y6rZtVPsF25hjMTIa2WJUl4gZeje1hs+Iy8oedJwRAqRoX7NKUWMXn71D8+sTnP686
 yOL/jY34Q72ooLzpktK22c2g4j/fX5qqGV102PiXgnw0PVg9FKfisW+7VQblTHOx81Z8
 yMuMee0MFmuJE6JO36B+kigqsyn48ejpuCz4E8lC5LVBZWs2EsQ6lRwTcr9xGmnHpUlx
 g/OnEAE8C7mXzKFEK8ULWbwUQ5nyjkJyr7sMoycoxh8Ylz2dSCV8kWaMW3kd0rJmG58A
 ObBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785225365; x=1785830165;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fphxwlYJox72NrqwlqXGtmxqrfLrjavamVJD53EjmnE=;
 b=fMKn7r53JfJIT+VT7aL5MjyhbAkmRKnAkHJGcDnQVUDYRfS724AIOXwPJtF4McK2RH
 F08p/2Ulnwtmk9/GxLzh2Yr280QvBf7pPs6gp+ertkzlB/W6Kp2K2SFEhSpfUQQMwzyT
 MA1HX3+izqh+HAaKZYIzapGHgsky10Jd3op9pvq3FkpfeZFR+t1m9McCyOHdIA/QpNU/
 N+Eokv7226sGdfsiuTYJTCfzeF7/xEJD0tzJhY0fBK37PmpSstS1K7l7CwFZKWhDXux1
 dTG2vaDYdmbI0j7KYeLV680P9LAHt7kbyDxpl1rX40OGrlGapL/VIBla+iOAaTV2YLuo
 2R9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxGzTNir+FZXUQRYa8fj9YW0zmGI07A7V0vG5nQTi1Y6AmMSutzyk15fus73KWtnsiotlklZVek0tX@nongnu.org
X-Gm-Message-State: AOJu0YxYcGHOHN2LT5iJtSwWTSOsX+GIEBZianBL7QQAvk9z7VsjOwF1
 Kl9prk1ghC9vM8dJj8cVm9/EBJP4XuZTlnY8xRHPaOe9Ykkzjh7p/XF/Il2KHqgGZSL+ZqI3uMF
 YwMjuT3g7NFmMwtfGU6VMxKNKJn217g7IuYS1OU9R3ivRTD3Poc1zBjOxzg==
X-Gm-Gg: AR+sD11HET9p6IF8QMJiWgOHj0LUiyB5PLcgc/3kvIs9oNio/3jeJOH9E4Nx4A4iweu
 n7lZgyIJx+eBPDek3VCEC9W13DA2FCmNvm+QWDcS2EWqICsqtSSifqN4J5Rksz6dgTQkK90lLJZ
 TXkS+rQvFfPhDMDGJO8ntUa+xGFiRqGTeNmwsyQobSPIDJRvXmGIRujMyYa4u9EfegpITvKYb3i
 xka9fwPdpn65OZzwQBtxRGuuFP5YTt6z1MEWxuUqMDWyE2xD7hBYjQ0GZkM2twPe2501nkMudnQ
 /VLjoLet7/SHwYJO1eAhYlXuDTqpRbf16H/mzvtEp1slCszBVNc7fS368YHtJIQeZlv6Z1HoG5P
 qAbM6N/8D5hxJrU6Be6kRCL/KNP6XquGdThQej4qUd6D+xg4/Rx6OHq8=
X-Received: by 2002:a17:903:41c2:b0:2cc:9473:97c8 with SMTP id
 d9443c01a7336-2d015cd593bmr15211755ad.15.1785225365169; 
 Tue, 28 Jul 2026 00:56:05 -0700 (PDT)
X-Received: by 2002:a17:903:41c2:b0:2cc:9473:97c8 with SMTP id
 d9443c01a7336-2d015cd593bmr15211585ad.15.1785225364777; 
 Tue, 28 Jul 2026 00:56:04 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde80306esm46994025ad.75.2026.07.28.00.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:56:04 -0700 (PDT)
Message-ID: <cda94007-9cff-49d8-a36b-15beca93790d@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 00:56:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 050/103] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-51-pierrick.bouvier@oss.qualcomm.com>
 <1c5b223c-301b-419a-a686-0170ce3fddd0@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1c5b223c-301b-419a-a686-0170ce3fddd0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfX2i/ulYMzbmrr
 U6N9vIHaeSEL6aF1pBp0rwfmOMmc8yjnEPZ3ggfB4p5IP6Tx/UqC8qqInBTvtabYNjECj0YdB2W
 q1jUgSwbA7aH36GGpiX0jliSi51vipE=
X-Proofpoint-GUID: HOlUdpR0GRRi_BlufZyhpFz8l9EmpeMP
X-Proofpoint-ORIG-GUID: HOlUdpR0GRRi_BlufZyhpFz8l9EmpeMP
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a686095 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=jfscbKKzqSeY98Pw_lIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfX8oWhT0GQtzP+
 qoY92VIBbw7vQHxzhbUJm4D5T5kCchBDqBsKs28RhKbCoVcxCu2HbAolLZKVW9o+PKVIh21mD37
 KMYekFQhg45ngJnukF3XORO/T7gL+Amdh2opEnLqGJO8Uec5kaSiwry84OHt6jmQY80sdeJR8sL
 lQPDlu8HubXwHYU00AjVruFEs0oBzgR0wG5Qc9Hxz5TofpLJfZwvnUJ81aGM8AWsGG7wM5XhDzO
 0d+HNLVjiaXKh6F3BsOl6Q7G/eJX7bQc5r1h2onhuVOjawogE6kLfUmdpC9dIjhmkqVwffsmcBx
 pFrXJ0tg1LvH66IlJYc4WI0ke7HD+/TQjvVMJRTR+6pyPG22n+TrHJLLdrSdsQ9lYdNpOhpGOQA
 Wt79YG1V7gEdAst4sXLuTVPQ5E//wK3dIxtTGMMDpfUzl4d0cyG2luLltQ4JR8JGRQn7MWmvgAk
 QrmiVNjpjjbEYlwESkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280066
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

On 7/28/26 12:36 AM, Philippe Mathieu-Daudé wrote:
> On 28/7/26 06:41, Pierrick Bouvier wrote:
>> All big endian targets were returning a wrong value due to this.
>>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>    tests/tcg/multiarch/sha1.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
>> index 0081bd76577..6cebad2951d 100644
>> --- a/tests/tcg/multiarch/sha1.c
>> +++ b/tests/tcg/multiarch/sha1.c
>> @@ -48,10 +48,10 @@ void SHA1Final(unsigned char digest[20], SHA1_CTX* context);
>>    
>>    /* blk0() and blk() perform the initial expand. */
>>    /* I got the idea of expanding during the round function from SSLeay */
>> -#if BYTE_ORDER == LITTLE_ENDIAN
>> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>>    #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
>>        |(rol(block->l[i],8)&0x00FF00FF))
>> -#elif BYTE_ORDER == BIG_ENDIAN
>> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>>    #define blk0(i) block->l[i]
>>    #else
>>    #error "Endianness not defined!"
> 
> Orthogonal but what about tests/tcg/multiarch/sigbus.c?

That's a good point.
Taking a look, the original issue with the current test is that #include 
<endian.h> was missing (for some wrong reason, I thought it was defined 
by qemu in compiler.h), letting the defines undefined.
sigbus is correct since it has the right include.
I'll change the current fix to just add the right header.

Thanks,
Pierrick

