Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B63CCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI3E-0000zx-52; Mon, 01 Sep 2025 23:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI3C-0000r3-Um
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:51:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI3B-00059p-96
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:51:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822XANN031556
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0DjbPoj6ukAs+xr4cOtzCfr+rp4q6KwLhoqVLhBLwRs=; b=jqEtpEwT2Ew7ea+D
 20CEnZX55CaqlWoAb+Y+gyBxb0/8zOO1sV/JA9D6vZnY1mWKwHBekBBmO6mSWOak
 d4kgnNlNJHN5BwuApOzZv87kdIcIShxqUUQ8j1Z9aWSn4pOPykKKxUZnot9RqoHf
 jyzQSQkA5Ka6vbFYCf4FUiOS4xDulq5Py22c+0hOmwQ1VzG5bshAqld8L58mHwpR
 4h/+RzlXQESXgJdS39h2ZRujLRl+0znitXOX/gQ+oZ+SzZU/JjS0LQRs6Cjil88t
 JmizaB+ecH3LRm+XqWl2M6CqCzIjFOFXVHWYQBBxXzs5aTTkORhCEZgnRrWQiXNO
 d5T4TA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw8597-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:51:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b4dfb96c99dso2009442a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785075; x=1757389875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0DjbPoj6ukAs+xr4cOtzCfr+rp4q6KwLhoqVLhBLwRs=;
 b=A1sl85AFmxes1Opn/J18z6FwcPUstPORUOx9L4/1QII6ECauR6NFTxaIdxJm0CT1hf
 otlR2CUzXFMpH14FaNPgeZQJWUodlJlK8G812iNdDVenBCZ2sSiDRMKjfksObiOcKVsN
 EJJmWUD4dbrmz6+3tIPo/P951K271ftzD8Tm6W1N5Fp9UcaUo2itSPZWFAa4y9V4tlP4
 WXHHdAtagJqtWExAkz7jZKDTw04rMVZYnesB6OQ03+jdrCHWGCuk9JhkHO8cp2GeL9Vd
 DSepby+9/NWiOEGR7EdqzDNT+8Izsx9J/viMQHXxdmjYit9HHPptFaXDuspwF3v8sIFE
 XNLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd7Dzbe8nc1Z7Fd/lazNcRl9ZW9Fl4CfOl+2RsD/tm72mZJIssnYl2gjW+/XJeZ7G4lKfJ+AWcksN4@nongnu.org
X-Gm-Message-State: AOJu0YxP1z1XxJyTNkQOCLbDcV59kyHkUet0z/2K8dkszVH0sfhrHyj3
 BHJf+r+S+gHH8vwa/rBs8Zr1HTUDWUrYg9MSYkaTWXXIgjG6JFl6p7Q3csi2KwwEjCnbABy8R3v
 oML0QU4AjzYu0r4j1QR1lJeTVHMmkT43Geg9x+H0oQhBllbvjTnkXdmm+rw==
X-Gm-Gg: ASbGncsrDbTBJy7xYEI0NRY45fKXqQ5/dCw6ospdo4ViUtbGyVgLHMUcicQNzOwQdAw
 RC8Y5zBVJmxV3TA6h3XfLYOHaKq/vKzazdfW7WxYwqXHYw+B8Lq8ETgVJiDdgXMp6OvZi1+M9wu
 xHWceVaYa4IORtf/OW9y5gzUJIUTe0RE/qx2d1KihebsZKAdylvJqcA2Ur+jNuTAIhI4R/I+OA3
 nYInPoahdymzbcSNU4Vy4WLkaJWn7g9hmt/CgSPcL8GN7UUIajH4eqY6IDVbSzNnhVGTykLmcEs
 GJLs3XldMFel4ihYx020umJmVm+CVIZKkRNdEbe0JGC3sersiDKDtHUpcCcSSA==
X-Received: by 2002:a05:6a21:3395:b0:243:a21c:3721 with SMTP id
 adf61e73a8af0-243d6f01e57mr14592045637.32.1756785074947; 
 Mon, 01 Sep 2025 20:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFSQ7KW6R6sn7ah5920EkFLnujMxtuwYMinvqSk9qIBidkJrCBJYcUVjwWtoZKzRNEVLWs2g==
X-Received: by 2002:a05:6a21:3395:b0:243:a21c:3721 with SMTP id
 adf61e73a8af0-243d6f01e57mr14592008637.32.1756785074507; 
 Mon, 01 Sep 2025 20:51:14 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006c340sm10903626a12.1.2025.09.01.20.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:51:14 -0700 (PDT)
Message-ID: <331ce915-0011-43ac-bd76-c765da47d3c1@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:24:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/38] target/hexagon: Add privilege check, use
 tag_ignore()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-7-brian.cain@oss.qualcomm.com>
 <e7127b41-f35e-4911-8b07-8080b30efb39@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <e7127b41-f35e-4911-8b07-8080b30efb39@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfX6lWx6WiDMacD
 MJRrWglDM64HeQkNHz/hlkN4y1isnIbRd0rO4ECVFEuhsKiwJs8y7I5KeWd2C06xa7w1vfvd/dY
 jhgRUvgTGfraGsO1EcEMLK+PetJRlArqX/vfNDhEEUiT9MCqO4zyH4U1tRN/6sC9m99r/2Oh0d6
 0vmFSoqJeO9Jm0EIpEp1D9REUAGdcnM+0HeQrbGDfug6nvyehxEmANC/NRrvzlTZua+h8zBNox7
 TEsUfoEio5UEtnmX0CzGG6R+KMcUl2rN2szcsA/pk/hGWUSc+8hta+Rm0ZjdHIidYjYxPoUBggV
 vOYy0wbeNxtfgYPmjt7FE8jv/Qj4CEgGy36pwZbUy8FIaGng8WlHLkdc1au+UL65NhTGwqbmr04
 ZQcrFNAj
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b669b3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9508i4g9bGZsseGkajsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: PzV4zGke5yWwW--9Ct-4FKPg1nrDaC5B
X-Proofpoint-ORIG-GUID: PzV4zGke5yWwW--9Ct-4FKPg1nrDaC5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024
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


On 3/6/2025 4:01 PM, Richard Henderson wrote:
> On 2/28/25 21:25, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_bits.h       |  2 ++
>>   target/hexagon/gen_tcg_funcs.py | 32 +++++++++++++++++++-------------
>>   2 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
>> index ff596e2a94..6582bb4f16 100644
>> --- a/target/hexagon/cpu_bits.h
>> +++ b/target/hexagon/cpu_bits.h
>> @@ -37,6 +37,8 @@ enum hex_cause {
>>       HEX_CAUSE_PC_NOT_ALIGNED =  0x01e,
>>       HEX_CAUSE_PRIV_NO_UREAD  =  0x024,
>>       HEX_CAUSE_PRIV_NO_UWRITE =  0x025,
>> +    HEX_CAUSE_PRIV_USER_NO_GINSN = 0x01a,
>> +    HEX_CAUSE_PRIV_USER_NO_SINSN = 0x01b,
>>   };
>>     #define PACKET_WORDS_MAX         4
>> diff --git a/target/hexagon/gen_tcg_funcs.py 
>> b/target/hexagon/gen_tcg_funcs.py
>> index c2ba91ddc0..65bfa046b8 100755
>> --- a/target/hexagon/gen_tcg_funcs.py
>> +++ b/target/hexagon/gen_tcg_funcs.py
>> @@ -21,7 +21,7 @@
>>   import re
>>   import string
>>   import hex_common
>> -
>> +from textwrap import dedent
>>     ##
>>   ## Generate the TCG code to call the helper
>> @@ -50,6 +50,18 @@ def gen_tcg_func(f, tag, regs, imms):
>>         f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
>>   +    if "A_PRIV" in hex_common.attribdict[tag]:
>> +        f.write(dedent("""\
>> +#ifdef CONFIG_USER_ONLY
>> +    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_SINSN);
>> +#else
>> +"""))
>> +    if "A_GUEST" in hex_common.attribdict[tag]:
>> +        f.write(dedent("""\
>> +#ifdef CONFIG_USER_ONLY
>> +    hex_gen_exception_end_tb(ctx, HEX_CAUSE_PRIV_USER_NO_GINSN);
>> +#else
>> +"""))
>
>
> You add new exceptions, but do not handle them in cpu_loop.
>
> I suppose this is not actually a regression, because we already
> fail to handle illegal instruction exceptions in cpu_loop.
>
> But you'll want to fix both.  :-)
>
>

Thanks - this should be fixed in the v2 patch series.


> r~

