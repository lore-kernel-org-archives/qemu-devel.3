Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE56C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxo8g-0002X1-J1; Sat, 22 Aug 2026 12:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxo8b-0002Tf-PS
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 12:00:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxo8Y-000332-2S
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 12:00:05 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67MEMNMv1364482
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 15:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Mebwxc3DUvKdRRcH3mnW9IK++g45lTnE5rWYhVjyjk=; b=Kmydhbv7ZGxxhx36
 HCkHyxnlrFtgQK6SUXnmUFX7aEr2shN2IIl68KvULY7MpxX0irBM4p4erTzMHFi+
 wPkZW8OFRqyIn/s3xnSoxjj8KDnI+Y06L8usk7P1fMyIIzCas/kKG4jVA8f2WaII
 xoe3bCZVshMQOzF/aSRKb6GFIbMSCWtAdCFMTWElpjL7X13/gr0BxzxPOLHWxfgR
 xLNA0+CbKuGP4Yy3T3sDjHmwkRcnZAAJ7rjl/7UFAnANYwhY+y+6x1Xpd5+xnsxS
 jlKAr/PgnlIzqGFiOciRxQvr2KjUbxiv7yRL7LL6et0dVYu435TQ3fZiW3rjNAtE
 P9rUNQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g741qshk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 15:59:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so24955671cf.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787414393; x=1788019193; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3Mebwxc3DUvKdRRcH3mnW9IK++g45lTnE5rWYhVjyjk=;
 b=dmy5QcrNtfIi9B++sWJZDiIFVXATTdNH5yjKZblxZPIQeCGDFUqerbJ7WC4D32eyJS
 oL8sPYEnm2N6qkO04N545DhxJfgOnUDmuiXwzd8qAlRsywycaazMwL7DS+5J9765d9hX
 0oZky6BJ5mU8BtCAUo/oW/D4bCsWCd2dDz+Gxx3FG+HPfnZcELG+rVEap95hKjD+hkNe
 Zs9I0YahhXO08H3IoweaNyICfzr1M4/upxFbDaQoJbX6i/996VqWApiKr8X12kLqlOIm
 f7SU6KycaQgzaXsGmIR9BgFMJFIpYENxSJIM1ag/Y/phGdRQaC4NusGO6j1pwfL07lrJ
 3kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787414393; x=1788019193;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Mebwxc3DUvKdRRcH3mnW9IK++g45lTnE5rWYhVjyjk=;
 b=FKsV2Ph4LIHVWEmDo7P2zQKuxQ7vikbztBy7xcCkTKRxrpPd5qQkmYBAKrXzwyVJ6X
 QHYD3keQT6b9Ce77xFYpLG2jW1XJAkfHvMyBRw7a02N1LjM/xPiXK7EY4QC3TRf3vrpo
 Gm4Uxc0Cwjq4whviosPTQ5OC5y1ZR0qeFe8LKhXon2TUe60K2x0ioMondlEEnlMLg0hF
 3ERiqcDf6qVoi2VTzsC3iRfx0IjQ5sgR6CLXTpYJNBIB8qhFGeJXasPJwRm8XuRo7Mct
 OAVIuf0yMTGr0nWOOu/gs+5WMS+eMsQ1FZ1Wkeufk6o1rcLeb67l1yGXpgnT0/U8L8ex
 r0Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpY8OlkwuYN2Al6isxaKqTG86WQZY/N/3/QS0mtzTfwAJfJ7eksAEl9JiMowETHhVDLMyG6WEC2l6dk@nongnu.org
X-Gm-Message-State: AFuF++kfVZU4/r0LZUEHiyut1hP/brwfPaxVq0V62bZeV5oUZVpYIraJ
 y6NP/1I2WX4/IJAoWiUlMmscl7pffMbulVpYzr0pAo86e73mX8cQwhDB5fKNj/vV7oWtFp6ghJK
 khu/bokvKudtSqKBKv7OnBfThDgMO5QOymvJKkBi8Bro8kPjURTBaU+A/NQ==
X-Gm-Gg: AR+sD12l/NjgEoc3uCMW2oCyp/gHNCpIy5PRUyKsV0w9eeRXlgQlK8lmJmR+vhS18oo
 oAkyf4F0IhxCUxCloCNTebmqtxVsyoBY5KvdzE9h6dFT2R+IVsFs4mJ2NK0bOQYm0rzV+WsxD1V
 +0MhSz2M73OBPEExOzIZtmb+s1lI5swSTEJa7EHkj255aKtdrymZKWObTLi2rWhlq9Q2LHzMrdD
 zTtV1+EQ3Q79Fpy8Roe5IW4tlZeYuRi8Tms2FNqxvA1HQ5cfJ4bLQBW5v/WRU7gBCamkXmMUXQx
 IZ/PqYcPLv7oKc7slyGOoorP6lLq2CBG8caRLGtxT/JvK9YrznqwVHMT5rtxwsmNfppGEhV0KZt
 1XiUD1X4t+/WHia5ZHS9BoZmOUkgE
X-Received: by 2002:a05:622a:311:b0:52d:d08e:d43d with SMTP id
 d75a77b69052e-52df56da01emr129942111cf.4.1787414392827; 
 Sat, 22 Aug 2026 08:59:52 -0700 (PDT)
X-Received: by 2002:a05:622a:311:b0:52d:d08e:d43d with SMTP id
 d75a77b69052e-52df56da01emr129941801cf.4.1787414392370; 
 Sat, 22 Aug 2026 08:59:52 -0700 (PDT)
Received: from [100.68.222.250] ([12.252.7.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c939352ebsm16606756d6.29.2026.08.22.08.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2026 08:59:51 -0700 (PDT)
Message-ID: <d050f95d-78e3-4793-b2de-38e307dc2837@oss.qualcomm.com>
Date: Sat, 22 Aug 2026 10:59:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/hexagon: guard writes to unimplemented guest
 registers
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-5-brian.cain@oss.qualcomm.com>
 <1d9ef45d-8d1b-45e5-b947-f87dab34fb4b@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <1d9ef45d-8d1b-45e5-b947-f87dab34fb4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDEzMiBTYWx0ZWRfX4V6J3b5UWAx3
 +vmXHmUjhfgnaXEQiyIV7P9zMziCeDgAcCbuVFacDQZi0sZWXP3dlMqI6fC2DjH4Y1GdSbUe1AQ
 xjOXUVM9Amkma6U+4Ei7zwXoecpE2VuICQcfsCMK52UcaZp+wsobUrh4/mkQmr+VI+WTGsZ2t4G
 mBDDyLeFzRWxJ6kRZhz6F/9KSa8n+W8ew0BP1rBfbyVXpWNoJu14Q3bftAam5ANSSh06MaR0/vE
 7H4XMOXXFQhIzDVs9MRFKq9cnaeD/iW4KuhKNQdReRslF6O7QVgAT+L12Q4I7Y4lIDhql1EyvAU
 fyS3/fYGtVz37iyzYctwA3Vs6QK08ymmTkCTAxdUc3Fm588/yLik+LPpCzs1GYzbd6sYQefspDi
 XOqBChz1Ul78pyyCmkc4DMacPpjsIqwH8gym+AxuI8yF4OlOZDATVMg9iol2I+uS+UFw4tEHIkB
 Ul38QG673Gt5onC0ZGA==
X-Authority-Analysis: v=2.4 cv=GvNyPE1C c=1 sm=1 tr=0 ts=6a89c779 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=kDiSab31uyKP0veRcQS/NA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=xqBZAWFBNsxML_jAN90A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: QNy-A8CwxP0RuVLLdZ3Zh09cpL7Aooh_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDEzMiBTYWx0ZWRfX782HcxfLoaU6
 XtwkUjpqUdxItF1MgjzSzKs4z+aXEeTA/u3HgsAMaA4DlHVzuKv6cxka+qLH9iX9Dyp/O6WL3YB
 O6le8zFaUBoGszEO2fMhnrwkLzdRNUU=
X-Proofpoint-GUID: QNy-A8CwxP0RuVLLdZ3Zh09cpL7Aooh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/20/2026 1:44 PM, Pierrick Bouvier wrote:
> On 8/18/2026 6:31 PM, Brian Cain wrote:
>> Gate guest-register writes on greg_writable() in the generated code so
>> writes to gregs above G3 are dropped instead of dereferencing an
>> unallocated TCG temp.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/translate.h   |  7 ++++---
>>   target/hexagon/hex_common.py | 18 +++++++++++++++++-
>>   2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
>> index 00de2b0d2ec..05425d92b29 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -97,9 +97,10 @@ bool is_gather_store_insn(DisasContext *ctx);
>>   #ifndef CONFIG_USER_ONLY
>>   static inline void ctx_log_greg_write(DisasContext *ctx, int rnum)
>>   {
>> -    assert(rnum <= HEX_GREG_G3);
>> -    ctx->greg_log[ctx->greg_log_idx] = rnum;
>> -    ctx->greg_log_idx++;
>> +    if (rnum <= HEX_GREG_G3) {
>> +        ctx->greg_log[ctx->greg_log_idx] = rnum;
>> +        ctx->greg_log_idx++;
>> +    }
>>   }
>>
> I'm not sure how this change is related to what is given in written
> message. The functional change here is that we'll ignore write, instead
> of asserting. Is that still expected to have a write on a wrong register
> anyway?
>
> If not, maybe we should at least log a guest_error instead of silently
> ignoring it.

Indeed there is an unimp logged, by greg_writable().  The fact that we 
have an analysis phase, reviewing the instructions in a packet and a 
subsequent generation phase obscures things a bit and the commit message 
can be improved.

I'll work on making things clearer/more explicit here in v2.

>>   static inline void ctx_log_greg_write_pair(DisasContext *ctx, int rnum)
>> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>> index e33d43e3ce0..c180c19b092 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -1097,11 +1097,24 @@ def analyze_write(self, f, tag, regno):
>>           """))
>>   
>>   class GuestRegister(Register):
>> -    pass
>> +    def gen_check_impl(self, f, regno):
>> +        if self.is_written():
>> +            f.write(code_fmt(f"""\
>> +                if (!greg_writable(insn->regno[{regno}],
>> +                    {str(self.is_pair()).lower()})) {{
>> +                    return;
>> +                }}
>> +            """))
>> +        else:
>> +            f.write(code_fmt(f"""\
>> +                check_greg_impl(insn->regno[{regno}],
>> +                                {str(self.is_pair()).lower()});
>> +            """))
>>   
>>   class GuestDest(GuestRegister, Single, Dest):
>>       def decl_tcg(self, f, tag, regno):
>>           self.decl_reg_num(f, regno)
>> +        self.gen_check_impl(f, regno)
>>           f.write(code_fmt(f"""\
>>               TCGv_i32 {self.reg_tcg()} = tcg_temp_new_i32();
>>           """))
>> @@ -1121,6 +1134,7 @@ def decl_reg_num(self, f, regno):
>>           """))
>>       def decl_tcg(self, f, tag, regno):
>>           self.decl_reg_num(f, regno)
>> +        self.gen_check_impl(f, regno)
>>           f.write(code_fmt(f"""\
>>               TCGv_i32 {self.reg_tcg()} = tcg_temp_new_i32();
>>               gen_read_greg({self.reg_tcg()}, {self.reg_num});
>> @@ -1131,6 +1145,7 @@ def analyze_read(self, f, regno):
>>   class GuestPairDest(GuestRegister, Pair, Dest):
>>       def decl_tcg(self, f, tag, regno):
>>           self.decl_reg_num(f, regno)
>> +        self.gen_check_impl(f, regno)
>>           f.write(code_fmt(f"""\
>>               TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
>>           """))
>> @@ -1150,6 +1165,7 @@ def decl_reg_num(self, f, regno):
>>           """))
>>       def decl_tcg(self, f, tag, regno):
>>           self.decl_reg_num(f, regno)
>> +        self.gen_check_impl(f, regno)
>>           f.write(code_fmt(f"""\
>>               TCGv_i64 {self.reg_tcg()} = tcg_temp_new_i64();
>>               gen_read_greg_pair({self.reg_tcg()}, {self.reg_num});

