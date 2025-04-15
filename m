Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4024BC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 18:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4kvE-0007DN-71; Tue, 15 Apr 2025 14:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u4kvC-0007Cs-NL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:22:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u4kvA-000741-3O
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 14:22:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tI0r025039
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 18:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4y+OgGtawT/K+JThcbthAY4XI2x6J2QZ2+ysu4Bfjb8=; b=Vg5RrRH7BVupq90R
 9vlI07zKli9G3BTDnrAUbK99jtD066BHsc7LjEhmKRWqQ3M/+KUjNaTZELa7vyAD
 gKl6EmoB4vVFM5R4MjUon+rZn4X7IQ7/jfRbGhFTC/l9aWEqVoaApe+PRk2/vCZs
 wew1pBmytZMdSXOZTz34okonb2wuWaiZ/O0yU+YpgYGKsdmbAy5Dv5G4zEZfhT2/
 +hKfx9Vzo7YbN0iWixAOInzn3plqUgcoXKhLi01zWn/3FkMQlb0CnUEyuM2ud/e2
 YifbSTAQiOMoI86RUaMSp+8xoaWOixn+az6DF28m7wIbbiJlbo7qD8D1LqHRfBA3
 LGllAA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf69s3h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 18:22:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-739525d4d7bso4183657b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 11:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744741323; x=1745346123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4y+OgGtawT/K+JThcbthAY4XI2x6J2QZ2+ysu4Bfjb8=;
 b=w/dcmTcJoSP3KGqgCw+ggY4i8vfI62QwgaGbH8toES/5t3PVOO4B8MnMovnC81aStf
 zCro5l23MTKi/E7ykouVDfI45eWn/lVeu5GeMNoMO/b4A+YFDXuVNtoU/9aaA/vMiIas
 azRRDCBAFwMNnEneoO6QJcEanFB8aWLJ5/spUnejfAIYTlJ0Rp6kyo2eQdgJOCvWUQal
 vQf0t+hATqUE0zTovXlhi7VKvjmmb5ReEioZGVH3mKnCOm13UGzoh91YDA00tNeNq0Ur
 KZtJRNjifny8GX4fMfHGKHmPMwEEgyppeIlNwwTlgeo9JEkJOepDjXq/1LtnWsQ9g53a
 NrYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrQgMplIXWipE5NlwaM3LFmnklnUamPkIeArP7az0eqzNhuTVlKsZrpbgEbZktVSujkiv5AlNG8WX8@nongnu.org
X-Gm-Message-State: AOJu0Yzvh0c2o/isrcAIjhRwV7U2YSO/63ZhQeB4ILiXu/yM3J7Tlbti
 XVKSvMDKVanTVl1Xi16LgGg1HpoJpAhcl5bA9Gmqhd9gDm0IrhfeKmt29aC1cHABOn5IVFybWG1
 ZND4YUfxyOYJ2oxszDBt9fn+/AaMDe32cxMht4J5PNBdFvj3N2i5ulCko3JzpvQ==
X-Gm-Gg: ASbGncvvw4j8n5do6cSviSZ9CrhQi1SXWK74ar2GdB+xGSl/2VOySpBhwI6M/UBcgTu
 7BYUuqX2M6IL4kqWzwpMQOlWwHZVbh9lsWlHCGmeOcG5KYVhlHENmv9FMb7gWT/1GRpSCnou0Qo
 N0bv2ImTxP2gW7l+6uAepJuZ+LhH1OwyOZzhSAH9yYtO8kTVjRo/z9FDOgl8Ejf6rXDUAI1WvDg
 80iQkT2pyECOC30wHd/b976Vtb7Qypsla2YdKuWQSXHF3+lranwAPBOSADMlEa0QJBB3dMPihpz
 URYT9Xbf0wvSjC5ZpPa4kwg4DjOTD4NyKkqQ/+YMgayDl/y3ffyusCtnlDtvntFbokDqCP96NOX
 T0ANmqZT86qlt
X-Received: by 2002:a05:6a00:4485:b0:736:6ac4:d204 with SMTP id
 d2e1a72fcca58-73c1f934cb1mr630227b3a.11.1744741322944; 
 Tue, 15 Apr 2025 11:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF620i5znmkCVZYLqlKvrBmEpfdhGV+ljriHanbbnK5bHD35rV640X1/ZHwxlov9hAebLESQ==
X-Received: by 2002:a05:6a00:4485:b0:736:6ac4:d204 with SMTP id
 d2e1a72fcca58-73c1f934cb1mr630199b3a.11.1744741322529; 
 Tue, 15 Apr 2025 11:22:02 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198a73sm8897950b3a.22.2025.04.15.11.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 11:22:02 -0700 (PDT)
Message-ID: <12956419-d35e-46cb-985a-5ea06d2d4154@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 13:22:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr, hintjumpr
 to multi_cof
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-4-brian.cain@oss.qualcomm.com>
 <058301dbad5f$467a2530$d36e6f90$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <058301dbad5f$467a2530$d36e6f90$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bHELAqLVhRmfzngVpduKmOuQhYU8jbBS
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=67fea3cc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=1BT2pQa5RkY6iQFXzHUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bHELAqLVhRmfzngVpduKmOuQhYU8jbBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=882 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/14/2025 12:04 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Monday, April 7, 2025 1:27 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
>> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com
>> Subject: [PATCH v3 3/5] target/hexagon: Add missing A_CALL attr, hintjumpr
>> to multi_cof
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/hex_common.py | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/hexagon/hex_common.py
>> b/target/hexagon/hex_common.py index 6803908718..a2dcb0aa2e 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -247,8 +247,11 @@ def need_next_PC(tag):
>>
>>
>>   def need_pkt_has_multi_cof(tag):
>> -    return "A_COF" in attribdict[tag]
>> -
>> +    return (
>> +        "A_JUMP" in attribdict[tag]
>> +        or "A_CALL" in attribdict[tag]
>> +        or "J2_rte" == tag
>> +    ) and tag != "J2_hintjumpr"
> It would be better to make this decision with instruction attributes only rather than a mix of attributes and specific tags.  If needed, add another add_qemu_macro_attrib call to hex_common.calculate_attribs.
>
> Having said that, the correct tag for hintjumpr is J*4*_hintjumpr.


Good catch, thanks for finding it.  And I suppose we can change it to 
`"A_HINTJR" not in attribdict[tag]` instead.


So, now more like this:

      add_qemu_macro_attrib('fREAD_SP', 'A_IMPLICIT_READS_SP')
+    add_qemu_macro_attrib('fCLEAR_RTE_EX', 'A_RTE')

      # Recurse down macros, find attributes from sub-macros
      macroValues = list(macros.values())
@@ -291,8 +292,8 @@ def need_pkt_has_multi_cof(tag):
      return (
          "A_JUMP" in attribdict[tag]
          or "A_CALL" in attribdict[tag]
-        or "J2_rte" == tag
-    ) and tag != "J2_hintjumpr"
+        or "A_RTE" in attribdict[tag]
+    ) and "A_HINTJR" not in attribdict[tag]



> Taylor
>
>

