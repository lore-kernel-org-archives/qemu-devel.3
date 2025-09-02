Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B774CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI69-0007hW-Fe; Mon, 01 Sep 2025 23:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI5u-0007aZ-HH
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:54:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI5r-0005Q0-E4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:54:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkEt016481
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gk2cjvU7nIIzsx4Y44Ib9puR8qPQ5NXD1fOQEHpaEqE=; b=JS4xgYhx7kPd5WRf
 F++Oi2AEf5zZ42MFb2LHE+VBEOGQEQwjkkIGl/TsNenFhu5HOPV8eGLGVJBKPtSe
 73SjbI7ONhvcyKgtZOnlsvXmwbMfYbplHsfqNpQ7ey9cErHc+ijiO+NiUtL3tS/l
 WuPrlZ3UVvzQqBkQHKWFplBHG2yMu4CpFW8Cv1RrzIUSJTiik74yN9MzgEgQ1UvR
 6wIqLKw0RToj+yK+RTdOHIu0t2NwZ0lUIwOnJaMOn03YFC3Wm8Lh82tXKhIcxXqQ
 kzew3Ef0ERQqZ9sJVVlIw6xELg4t6b/wVKX5oBv2T3euu2n5JXcRypP/7gPf8hya
 l9raAA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x8jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:54:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24afab6d4a7so12571425ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785239; x=1757390039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gk2cjvU7nIIzsx4Y44Ib9puR8qPQ5NXD1fOQEHpaEqE=;
 b=Kua+VJRh/n1XZfM0lvPHyh/wR7uw/zdoN+4oc6EMUwieBjbUoHEN69/nHEwH8ES950
 AjQViNuwuUNLj2GrQbVI3ikO6PbTzqa1RoI08xZ1XbTBwmdV2fESgLPZlSlLg6c7FwGT
 QKXqFthTzRaBsqwHUqeDmI+/45eGUfhN+Qf/VJVk4r7YUApI6O+SU5xXKYTU8v8NjTUc
 XIzpe/Yk0wNiw9ceGj8ItYSo0ex1X1EObEr4YkV/1LOTH4trKgg5XoLHXLZzAIsRy1wS
 LMGPeBpXuK0NK63g4EYapJr+RALPUzOF1L9ZU/IbaGNlwozfdezUE3M5jVwn3K03NX5U
 Rxsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXepCyD7D4yHTdEB3uI40f8mf5Z5j32464yMoTK6NT1UeGnLTCJPdzdvVHO5NYic7UG+m0tZtGcUgNO@nongnu.org
X-Gm-Message-State: AOJu0YweVz2K8qZdkux8fFx7Hi9pHs9Fyt2OTKRcXRUkJfEFtptvqEpM
 9DHcEKF3xNWXwMinrZyhR37C/AGrlt4a6K295jX4TD8Lu/v1NgtVqjCdW4ZF8DxkYcZQ0oUU/wp
 OhlacqN0c+U3y2LnSdv9m9sskSd+9Q2hB8pcnCnSdqYfr9z5pj3VDWOlHAw==
X-Gm-Gg: ASbGncu7eLpBtKYr2NoRrdT0N1Ru+j/ZSxksOL6R3nTVsOu+o5zGc8KzVSJqIAgFwY9
 l66xNzGcbfY4L53eVaAclch5wlTx/tlkTFKijisDG5abd93CogM9KQkfrukdLd3cmOwmmivRxd/
 8Q/OH1fDn6oVnf8y3vv0fOf6VolK/dHVKwzsd708TX7nIDLWe6IoAxDuswEGUpo19UYh4StzRna
 NWadNRX7bEae98+zkklXBCt7nrRZMAM3cUdlRh7pDJgaBbMD34Exrl0fCnWQyIz6WKHgBsAunil
 Ar1j0nl1HLKw/1NLRyqoh5jXkM/AQvzT7CD1OE5pJLIScrP8vf1oACvFASfOiQ==
X-Received: by 2002:a17:902:d48a:b0:24a:aedb:1929 with SMTP id
 d9443c01a7336-24aaedb1b07mr94133745ad.16.1756785239309; 
 Mon, 01 Sep 2025 20:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOhTpnzpM1cqIAo3LchYIxxKACySo27HQhjgFahrQkp3jXijguvbXI4LzO4Yrr32bskZg2pw==
X-Received: by 2002:a17:902:d48a:b0:24a:aedb:1929 with SMTP id
 d9443c01a7336-24aaedb1b07mr94133375ad.16.1756785238821; 
 Mon, 01 Sep 2025 20:53:58 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:53:58 -0700 (PDT)
Message-ID: <45614e79-e520-4d52-8d92-1f593201cae7@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:44:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/38] target/hexagon: Add system reg insns
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-22-brian.cain@oss.qualcomm.com>
 <030601db8fca$04123730$0c36a590$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <030601db8fca$04123730$0c36a590$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -Q7pK3W6TkzO-l6zKdZXCF7erphPv4MW
X-Proofpoint-ORIG-GUID: -Q7pK3W6TkzO-l6zKdZXCF7erphPv4MW
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b66a58 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=4mQr0rTdCtYg_iFpx6sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXyrr3vn/ZDhXz
 dPBdQuU4RI7QcMhpeKSrmjmPozqTk7WQazB4vtQgYZwcwDdKpwnX+I4xVKb+HmdyKJO++P7Oso8
 /RltKm1l/weGr/Fn5Ofz5PMA5QtJJMw39UP8IrZj9tRLFSqbakTE6TJdhwieMiWxNmnG/H7DER6
 SCulB2lTvGMpi/vKRmslsbJSPsBNoHsMiWqFcLbfgCfUiNU3wkFi1/sIx0r3PUshVVCIEyy5oEb
 m9nQg9kppdY4HErZf2nljnz9vdTtnKbYlL2Ii5K1L43vMQckUUEg/Za7HrknacsltmCqwCGFPOT
 QDbCTw1NrJEJujvjpZ/Y2QYdjAcriQ1v8sLe6mbiqsMPTQk7fCsFIP+SBP1DA4EPjX9o0hfS9XR
 eFSUUSjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/7/2025 7:32 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 21/38] target/hexagon: Add system reg insns
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/macros.h               |   2 +
>>   target/hexagon/hex_common.py          |  15 +-
>>   target/hexagon/imported/encode_pp.def | 213 +++++++++++++++------
>>   target/hexagon/imported/system.idef   | 262
>> +++++++++++++++++++++++---
>>   4 files changed, 410 insertions(+), 82 deletions(-)
>>
>> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
>> 6e4a3a1697..b0e9610d98 100644
>> --- a/target/hexagon/macros.h
>> +++ b/target/hexagon/macros.h
>> @@ -675,3 +675,5 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv
>> val, int shift)  #endif
>>
>>   #endif
>> +
>> +#define fPREDUSE_TIMING()
> Why wasn't this in the previous patch with all the changes to macros.h?
>
>> diff --git a/target/hexagon/hex_common.py
>> b/target/hexagon/hex_common.py index 7fb11a0819..9147701333 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -1235,11 +1235,18 @@ def init_registers():
>>       for reg in new_regs:
>>           new_registers[f"{reg.regtype}{reg.regid}"] = reg
>>
>> +def is_new_reg(tag, regid):
>> +    if regid[0] in "NO":
>> +        return True
>> +    return regid[0] == "P" and \
>> +           f"{regid}N" in semdict[tag] and \
>> +           f"{regid}V" not in semdict[tag]
>> +
>>   def get_register(tag, regtype, regid):
>> -    if f"{regtype}{regid}V" in semdict[tag]:
>> -        return registers[f"{regtype}{regid}"]
>> -    else:
>> -        return new_registers[f"{regtype}{regid}"]
>> +    regid = f"{regtype}{regid}"
>> +    is_new = is_new_reg(tag, regid)
>> +    reg = new_registers[regid] if is_new else registers[regid]
>> +    return reg
> This looks OK but is out of place in this patch.
>
>>   def helper_ret_type(tag, regs):
>>       ## If there is a scalar result, it is the return type diff --git
>> a/target/hexagon/imported/encode_pp.def
>> b/target/hexagon/imported/encode_pp.def
>> index 0cd30a5e85..37faf62b1b 100644
>> --- a/target/hexagon/imported/encode_pp.def
>> +++ b/target/hexagon/imported/encode_pp.def
>> @@ -1,5 +1,5 @@
>>   /*
>> - *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
>> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights
>> Reserved.
> Why are you changing the copyright date badkward?
>
>>    *
>>    *  This program is free software; you can redistribute it and/or modify
>>    *  it under the terms of the GNU General Public License as published by @@
>> -16,6 +16,7 @@
>>    */
>>
>>   /*
>> + * encode32.def
>>    * Encodings for 32 bit instructions
>>    *
>>    */
>> @@ -341,6 +342,8 @@ DEF_ENC32(L4_pload##TAG##tnew_abs,ICLASS_LD"
>> 1 11 "OPC"  iiiii  PP110tti  1--ddd
>> DEF_ENC32(L4_pload##TAG##fnew_abs,ICLASS_LD" 1 11 "OPC"  iiiii  PP111tti
>> 1--ddddd")
>>
>>
>> +
>> +
>>   /*               0 000  misc: dealloc,loadw_locked,dcfetch      */
>>   STD_LD_ENC(bzw4,"0 101")
>>   STD_LD_ENC(bzw2,"0 011")
>> @@ -375,6 +378,7 @@ DEF_ANTICLASS32(ICLASS_LD" 1110 000----- PP------ --
>> ------",LD_ADDR_POST_REG)
>>
>>   DEF_ENC32(L2_deallocframe,    ICLASS_LD" 000 0 000 sssss PP0----- ---
>> ddddd")
>>   DEF_ENC32(L4_return,          ICLASS_LD" 011 0 000 sssss PP0000-- ---ddddd")
>> +
>>   DEF_ENC32(L4_return_t,        ICLASS_LD" 011 0 000 sssss PP0100vv ---ddddd")
>>   DEF_ENC32(L4_return_f,        ICLASS_LD" 011 0 000 sssss PP1100vv ---ddddd")
>>   DEF_ENC32(L4_return_tnew_pt,  ICLASS_LD" 011 0 000 sssss PP0110vv ---
>> ddddd") @@ -382,15 +386,18 @@ DEF_ENC32(L4_return_fnew_pt,
>> ICLASS_LD" 011 0 000 sssss PP1110vv ---ddddd")
>> DEF_ENC32(L4_return_tnew_pnt, ICLASS_LD" 011 0 000 sssss PP0010vv ---
>> ddddd")  DEF_ENC32(L4_return_fnew_pnt, ICLASS_LD" 011 0 000 sssss
>> PP1010vv ---ddddd")
>>
>> -DEF_ENC32(L2_loadw_locked,ICLASS_LD" 001 0 000 sssss PP000---
>> 000ddddd")
>> -
>> +/** Load Acquire Store Release Encoding **/
>>
>> +DEF_ENC32(L2_loadw_locked,    ICLASS_LD" 001 0 000 sssss PP000---
>> 000ddddd")
>> +DEF_ENC32(L4_loadd_locked,    ICLASS_LD" 001 0 000 sssss PP010---
>> 000ddddd")
> There are lots of changes here that look like formatting/whitespace.  It would be easier to review if you could minimize these.
>
>> diff --git a/target/hexagon/imported/system.idef
>> b/target/hexagon/imported/system.idef
>> index 7c6568e75e..fd7ef18b3e 100644
>> --- a/target/hexagon/imported/system.idef
>> +++ b/target/hexagon/imported/system.idef
>> @@ -25,44 +25,262 @@
>>   /* User->OS interface                       */
>>   /********************************************/
>>
>> -Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF),
>> +Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RES
>> TRICT_N
>> +OPACKET),
>>   "Trap to Operating System",
>> -    fTRAP(0,uiV);
>> +	fTRAP(0,uiV);
> The formatting/whitespace changes are not as rampant in this file, but this is one example.


Tsk - I thought I had addressed this one but it looks like many or all 
of the errors here remain in v2.  Apologies: I will clean it up for v3.


>>   )

