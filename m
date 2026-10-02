Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DF3CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 01:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCSWK-0005at-Th; Thu, 01 Oct 2026 21:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xCSWJ-0005ai-Bf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:57:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xCSWH-0006d5-HB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 21:57:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691NEW2o4046335
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 01:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QZWlUb84F/8nJ3CfAYsukFAu7PEIk4UVTTAG5pEG3yE=; b=FydpMb7wGzPAFMo2
 NSRVSn/SJOXTGXIcM5nDbGRD1uZks5GOKkEm3nTFuDfq5Hg16kQ8VuIIrTwKFWu8
 wWCGf1jyqhe3mwDYc5hFInnkiXqQk8w60lc6YZ9Xo5ttevoPyL9r5rlvS8ND7+98
 9E+Wmzvwey7jKXofYdQsvK8U2EgFS39hiBvfV/PQZC8tpShtpTqSRT0l3lAKne5y
 StsEucnZhTSpHw68QZdk6bc7NL92fJRjTUU2Yutr35ksGr/eysk2sW3lWgvgtjnV
 Irm74UT+YDxnMwnH0H0IX+j+exy8dxWf6OlcWLjbbKdtsF/A50el8Yy8JWekE0D5
 2rYN9A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20nfrf3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 01:57:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so490437385a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790906221; x=1791511021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QZWlUb84F/8nJ3CfAYsukFAu7PEIk4UVTTAG5pEG3yE=;
 b=S6gVROsgIh04opowTboC8bRqpMbzpMZNxf3vKIhvERmixNk3u7mWJam2c6HghUSv8t
 T96ABuWbsFT1DaQV2mKtd5ktdiHxGbKmzcZ4rR5/1mORnuc1h5eaaBUVlUNwrLV9ppOE
 Y5T0YrIn1RxPBhISfJfdmXvQXCyvRBdj3txpAYkL2bj2JP9CLaxH06nsME6PdUcbq00C
 8n6m9BqqkutZHweHZOYgZln791S7cRqOUzPa+9f8++o575p8ytw7Ffe6H5gx73E29zqn
 rBB78P9wTrtQdqsv6C5MQ6OJVBiLqkAuAUzFidDH7iOP9zvwqUz7RJnKmsNGMGDagI/x
 sgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790906221; x=1791511021;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QZWlUb84F/8nJ3CfAYsukFAu7PEIk4UVTTAG5pEG3yE=;
 b=KP4F8gIn54s2aY5E3TMAdPFIVQr7EZXpZTvlzsXR0TYd9TeeLyJXim683nrq0btGzT
 +Gp+qmvK/YwbdsKP74efUpCFdB3RXSRtpNmtFPdUlMLnbq3i+Xz68xYAWmH74ZioQWvp
 1SJIZjZ8vjfnRijO1z1vZXp/3jVBOin3QV21R+Aypq0tcEFY4+SwlukAjLUgtoZWmU/r
 4JtEOtP4XnYMl2ObVmnlYpELsCuggPiJ2Pp6alOVJhh7G7vDmflEQQLhIwnv5vq/MkVe
 tThz+P/KMF+tmLVezb1KQ84Dow5ij7Kk9Tabus2l2TkXdGwhvL1H5ftAgBpwDw8j8CEr
 D5Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEiqzlG0e1uzLFyDXkDqUNSMB3RXlZC34CyjuovN+eWuXmAfneFPQBiOyQOKSBCrf1p2pGkr8dK8c9@nongnu.org
X-Gm-Message-State: AFuF++mig44qiOI3tjb5NdcrO/zXZckb/Knzb5pRUSH72OIhRrohjgRD
 n0T5eU4/Gm+/uTqpoCKn2R9fpG4Is97eCBY1E4BssU+acKEMQG2y36iUHHoyAXN4CkQI+JC8mXo
 mBpPb3J/eKIwyaV1jhQNykiDtpLJZ4dzRyYUSHq63BEJRlxIsFrPUztarkw==
X-Gm-Gg: AYBFou0FvaljJZ4GolYVUWjENc9Fey4Nbp9ejHeH0n5tPsRJ/5tkQcv2CaV6s2gpxPg
 d05naczNGPq0n2xErCDMNaZi2a1EM/2ezP3cylOFGRWo5doyz2ctS+y1BxriI9Re5d1XzYyOloa
 lPdHcnPf75t5QPaBAMyw1qfxk6HlmLQJQxodJAu1ar//hp41eipm3BAmWJf03sWC/aPjyCx2e7X
 ChWT0N868o6mBRzZb1iNg6kv3k5YI/9FXgjB4F1AhCRr49ewrJMRFluIFeCXx3+nzkGHJXMtUvj
 QdoZjIWYlY6luBU1tXkXbcNhO+D0n7i8nogDRgT7zw6VtAPO5UEnzK6LPUiZqYawxasmlTerXBi
 D4b675k+kUkJlQ6SnJ/DgkBkz2oNf+DidF9S4+WHxJeSySI5eDin7vDYRgTbc3poOsdoYksqruz
 ROsFE=
X-Received: by 2002:a05:620a:4713:b0:939:fce5:f6d2 with SMTP id
 af79cd13be357-93cf16de7femr218161685a.27.1790906221460; 
 Thu, 01 Oct 2026 18:57:01 -0700 (PDT)
X-Received: by 2002:a05:620a:4713:b0:939:fce5:f6d2 with SMTP id
 af79cd13be357-93cf16de7femr218158785a.27.1790906220981; 
 Thu, 01 Oct 2026 18:57:00 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca202e42sm99210985a.19.2026.10.01.18.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 18:56:59 -0700 (PDT)
Message-ID: <5fa8da54-5f3b-497b-a174-5c6537ce5520@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 20:56:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gdbstub/gdb-xml: Add hexagon sys regs
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260930175108.3592113-1-brian.cain@oss.qualcomm.com>
 <20260930175108.3592113-2-brian.cain@oss.qualcomm.com>
 <42ce6d66-e33a-4455-a1bc-dcda53f143c6@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <42ce6d66-e33a-4455-a1bc-dcda53f143c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lQ6iPEG329AVprmTKhDV1tDMchh3h1wf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAwNyBTYWx0ZWRfXyGClrYwZKTKQ
 6n8hSphypd3mlJ5To6qAWTQtOM+znLDS6x1mRJg79Fpz3GH++O8m9tby+5Mv68w+4H2ye87oHK2
 dq3hAxzc1r4lZ/rEpykrWWNy3meDAK8=
X-Proofpoint-ORIG-GUID: lQ6iPEG329AVprmTKhDV1tDMchh3h1wf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAwNyBTYWx0ZWRfX1gy7qxVqpzll
 4APA8CrUJ7L3fW4bNccLAnAreBhpcca2zu0YcOcKB/aL0npJGl2c331mn9nU2o/9UbrMt+11Qrb
 XIhzOrYwI6dWXdzMIHfelV4zE6YyNCaQps5k1dGPuOpnhgs4OyPHuAe2nYXoyQ/uQq4flEpSKww
 D0v3aBb5xzxCJvpJgCm0BW2g5vn+ErT5gPxCFY1ral1LKMVS6Q65pk4B2xwKpTPGpxMdLUEqtZz
 y+3JTioIohRaeInIV5YYc+C3RAjb0kxxC4xBl0j/Q139q1tBxqYYf0XNK4/gCoM3QTDuSne98M6
 Tob9pn/d2FuDwgwPVzbjNkV//0TIX3S+9/ukxZ9FZYAGBpoCAQ+dFHq0S0TkJjms2JlxJ0CWICA
 FKTYLHWUVnIUm1/UxjbuPTZwjnC4jUwfSSq2a7LeHSZ1E6eWDIFpG8AaMjXwLineDRlQ0Q4eLmw
 tbZzIo8At6FzCEhff/Q==
X-Authority-Analysis: v=2.4 cv=f+jdl+yM c=1 sm=1 tr=0 ts=6abf0f6e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=eU0e3LhYAAAA:20 a=EUspDBNiAAAA:8 a=Mag2Khele19Lara0ktIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_05,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/1/2026 3:58 PM, Pierrick Bouvier wrote:
> On 9/30/2026 10:51 AM, Brian Cain wrote:
>> Add the hexagon-sys.xml gdb feature describing the system and guest
>> registers.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   configs/targets/hexagon-softmmu.mak |   2 +-
>>   gdbstub/gdb-xml/hexagon-sys.xml     | 157 ++++++++++++++++++++++++++++
>>   2 files changed, 158 insertions(+), 1 deletion(-)
>>   create mode 100644 gdbstub/gdb-xml/hexagon-sys.xml
>>
>> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
>> index 6cbdc64be56..1ba6420d205 100644
>> --- a/configs/targets/hexagon-softmmu.mak
>> +++ b/configs/targets/hexagon-softmmu.mak
>> @@ -1,7 +1,7 @@
>>   # Default configuration for hexagon-softmmu
>>   
>>   TARGET_ARCH=hexagon
>> -TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml
>> +TARGET_XML_FILES=hexagon-core.xml hexagon-hvx.xml hexagon-sys.xml
>>   TARGET_LONG_BITS=32
>>   TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
>>   TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
>> diff --git a/gdbstub/gdb-xml/hexagon-sys.xml b/gdbstub/gdb-xml/hexagon-sys.xml
>> new file mode 100644
>> index 00000000000..434f11c0747
>> --- /dev/null
>> +++ b/gdbstub/gdb-xml/hexagon-sys.xml
>> @@ -0,0 +1,157 @@
>> +<?xml version="1.0"?>
>> +<!--
>> +  Copyright(c) 2023-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
>> +
>> +  SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +  Note: this file is intended to be use with LLDB, so it contains fields
>> +  that may be unknown to GDB. For more information on such fields, please
>> +  see:
>> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/docs/lldb-gdb-remote.txt#L738-L860
>> +  https://github.com/llvm/llvm-project/blob/287aa6c4536408413b860e61fca0318a27214cf3/lldb/source/Plugins/Process/gdb-remote/ProcessGDBRemote.cpp#L4275-L4335
>> +-->
> small nit - could we reference a specific llvm version (tag) instead of
> a commit?


Ok - can do.  New URLs below are what I'll use instead:


https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/lldb/docs/lldb-gdb-remote.txt#L738-L860

https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/lldb/source/Plugins/Process/gdb-remote/ProcessGDBRemote.cpp#L4056-L4116


>
> For the rest,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>
> Regards,
> Pierrick

