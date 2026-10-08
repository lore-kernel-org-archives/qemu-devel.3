Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E79CA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvR1-0007UB-Tg; Thu, 08 Oct 2026 17:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvQr-0007TK-Dr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:13:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvQp-0001rv-ND
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:13:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0FHr2534330
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YBHCT/fAW01FtajcauNSEWQ1HSP4McWMe++TK7LIi3I=; b=kDuiHJqgyyoUXffr
 ruJddeMKjvWLC4LLvkAJ6nMElb/VlYySwg6wofLAgUPjg73sbXLm2ksiB/BWOpup
 Qk8BGfuIlSHs4p6LMdNAmZIf+mR717gYC1GBovqJl0/3bsvBqO3vAz/UO0t+qnIj
 clRn2REALfLEMtRqYCn0M8qwxgjYbU6osGsZlcmQHxkRPmE28hqiCUAr679tVn8F
 Up1b19S5kVkvNQ2RfLWph5SlG8MoopiZjNY7+33lBS2xr6QtQvkq88MRaB2gLl83
 17UMQYLHpc8rbgeVFqCTzzS4uGltxlyIQmG/ZncaDgvX6lowvjnjMZ0OoEun+Rng
 O30cjQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev58y67-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:13:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3515d2fc5ebso9144436eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791494017; x=1792098817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YBHCT/fAW01FtajcauNSEWQ1HSP4McWMe++TK7LIi3I=;
 b=ThLSg8sbOpFelvw/rjlwB4MntmI4ZsKtinSwWMJiXW8qYbph6SPvQrVchVyMXTFx+Q
 y47TjnbJhG9U3P0xvycqcV4UCB/tvd8cUMfqqs98JZZFRhV45MDeAoQS26SvJOFSyXtb
 eXQVA+1E0RKw2Bz0hKQJ194d9/SW6WLDTQPcsmBGpk8IH8Wxg5T66JAV8aXqH7gW3/dp
 Cik4E5AQQv0DAtoIVRgbPpqWnHrsBymgCcOoZHQiuppqXgYtr5Hrw5AdDf7WFSSDH6QH
 URk2AP92Y7xEQfd1Hyr89Zj26K0fdDz2fc2AfOhLW4OA550xcIKwxQrOX+NfPhNrjiyU
 RjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791494017; x=1792098817;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YBHCT/fAW01FtajcauNSEWQ1HSP4McWMe++TK7LIi3I=;
 b=rW4jRzZlZx+R5zVURqBgjUIHMTgubz/AXX7MPciPD+mi1Ni1wvpEVkE4sIHJif95pF
 +jNnerJcsBxyNVmgitP/YwdovDw4lOMpKp8x90s1iVbG+BdB/K8Sv+Z9mOpy5SWzm8T8
 n4yzGLWIiASC84sWzy6xcQViUjwAmF7GyL4pNRVNgVJ7+dz9cWkZUBtxnoD4be8HUJOe
 F2YbZERCzxz+f1MABYZH0vXdUoHnNL7m3VtY9BKuZNhd5FPbbkTqRTnnWOvhXzQkd43D
 mjQlDD5dUQTnmgZGwusDQid19ag3U6GJ4NpFrOFd+hYRH7WK1ZzDOJFosJPGnhHR2X15
 8cfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkMM1p21bmBY6MIHE2Qd6yfhvWdqSgaRcBHodBACRRYBw3K7EPMGX7VDToH6HHSDHA/W2+RmfbFHEF@nongnu.org
X-Gm-Message-State: AFuF++n5ahoQ7Od6KwmlC4OYHCY1maTk9+YtmL4gNTOD6XOjExn3HQL8
 5nQIzw0LFSylQ4xvTiqDOXbkgBiyCEjVM6Vfju1EwE/dL+qS0ttntmFf8vYf0+PuJbQ/C3nI/ZJ
 jU1X9JaZp5ZMJgTigYM2kNjl/p7c6UiCGkWn48qBGT+ph7Gd+/ig2sj57Nw==
X-Gm-Gg: AYBFou3hMXmxpOxcX089s0E/BmlZg7j2JCfFtVyWdZ/xNY+ig3FprFvroU1Rt4v5qnN
 QCnIv8R+EIa4SGoUZQvtbiGNAzNcLm9fz/+yvhdFcsN7teAxZ/uVRV5BlVwvxSASn56tYnGF0CJ
 vtTC8QQz7/DqfhWt9miDKk6aqNrbOD3pG3jMgkqKWIh90yeAaSBmgOCz4FJmpUdD5bXmozmrGZQ
 IaM7/gMg+dluGlsiqNrBre/FbejsfWMJPqgIefhMWfnxPV7f9IcGEnjS3Yyj51MKveNzNDf9oe1
 AERCOoembkmaUf6Djcxn+Vrei0wMvLJMGZ8KZPvfZ8MRCnIlsE9Ov7/INOYDUa5aIiiJwcPk8E5
 wBoKbDsqZidljTtDEqRDQyEDxl6OnKKt1YZLB4t3qjFY8Di6ghS0rQYe7SCMg44RU/H0g0w==
X-Received: by 2002:a05:7300:a92:b0:351:4d5d:39b7 with SMTP id
 5a478bee46e88-3537e0a4a27mr118191eec.38.1791494017356; 
 Thu, 08 Oct 2026 14:13:37 -0700 (PDT)
X-Received: by 2002:a05:7300:a92:b0:351:4d5d:39b7 with SMTP id
 5a478bee46e88-3537e0a4a27mr118155eec.38.1791494016748; 
 Thu, 08 Oct 2026 14:13:36 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a2afsm625719eec.31.2026.10.08.14.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:13:36 -0700 (PDT)
Message-ID: <cf94e70c-65ab-4c94-ab40-9dcebd02aa43@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:13:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX90inRrWZpEph
 ur3tBoZULwr6LZ/UzW7o9Mae/QgOhWxWrbXJ8mgUgxnzoCKY0X1k0qXmZr1Yjdg/TcP/8MLgUYc
 GbpLD4HXCuftUraoyLsbziX0kCDzuBg=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac80782 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=vwnOIsNelQcLABv4K88A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 9KgkVV70mZAJNPyMfTN4xjkCXTNQ8hiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1hPDucABAzrq
 3hqmKgazI9Nn5aarIViSKOQRb7M/GmdxT20IKkSfAD8pzvbh71sGEHVL02GrJAt+azUwOjlkA/N
 XQDLyH94u1BRJhUG0Z+3KuiQV3kZCN5xLWsK8V8oJ1icpPFl+5DcLmlncAaayQkwAK6v81Vb990
 tkQP8uEyhEjUcT52bYPQ13VEnbPNHqHPP/oF7nJxTkN7tn5pho7xvfDekW5zV9OXtuOcWl3+FGV
 kDdVjgvfXfX1MYJs+02o4RiJYhFdDY4/UithWFl5dK6QLDLOwGACNXwqEh/Vlw10/RO8l2Uz0ou
 s9550L9/kKpQKEBls7xzIfvuW9Ivr/h7WZogwgZcMl4dpjNpQLb4q5rBEkG9awmvN4rgXWxeFqk
 NylgPBRRNVyramDfih7HX48yIMW2EapB92I41+WUYiqmG1Rx0Qcr9/EVWnEtByNICFrjPPnFKQq
 h6yJNmvJodixfFKaiog==
X-Proofpoint-ORIG-GUID: 9KgkVV70mZAJNPyMfTN4xjkCXTNQ8hiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

On 10/8/2026 2:10 PM, Brian Cain wrote:
> Hand the k0lock/tlblock lock implementation functions the packet PC as a
> constant instead of relying on next_PC's opcode-dependent staging.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_mmu.h    |  2 +-
>  target/hexagon/sys_macros.h |  4 ++--
>  target/hexagon/hex_mmu.c    | 16 +++++++++-------
>  target/hexagon/op_helper.c  | 16 +++++++++-------
>  4 files changed, 21 insertions(+), 17 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

