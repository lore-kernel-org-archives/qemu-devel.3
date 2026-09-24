Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F99C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9n4a-0005yp-7y; Thu, 24 Sep 2026 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9n4V-0005yd-RW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 13:17:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9n4S-0002LF-UK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 13:17:22 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OFeKeU1899421
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 17:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UBjDWGhSIhC3y62okHbxonbpjWj3DeQDqa/wYy8nxa8=; b=pXgDSMiCKJX2b5nK
 d0v7f4YXXqMZlT9MKp5Y0ht6+Ceqz77IY2H4C/Vn70CT3dCj6DRVEcilBMRGtSuB
 o9U/0q7tCZqSLSmvaFxLjIfo52Hk8uDv+I1u3+1DHuootM3xXueMRba31AnivTMb
 6X9jvG6G/25dgqIfs5hXoy+EYgcCT5O+QaMCtvb2a4NJLlHmo59nih8k+UVccgnF
 ZEbex4JLVMJgsQoJc7CSmJrnZM3OqOyjoZlGxj6DjxRhkdA3ZHR9h+maI4QyAvgz
 nWyIVgxKh4Nqd2k4M0J8V2Rl08OsEuc5GKUJAU3QW2dMfawDHTwwGITfg51+9ju8
 fBEvig==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvghba1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 17:17:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30f1b904861so3233910eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790270237; x=1790875037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UBjDWGhSIhC3y62okHbxonbpjWj3DeQDqa/wYy8nxa8=;
 b=G+zTbp8E+WVPH+7ktSSyo1SkBSJMO/3B8mBh3q5KdahIUxnnyKCjKcW0rKtROh9tLU
 FValWJVbw2fv9K7L65BIEUlasT8f4gRgMAjBOB7VGZtYjEj9F+sbXisceZZgj+XyJdLf
 fAg0LfPDkWtKx/B2OmFzmRvBARcCqmjU6peiqTu4kAq3QgAixKz5L2p3gX87420tRF4O
 Y1rI0xmi8552SkNjlSDHvaLKZ1y8FGKHJ/AVqyP7MDPyGhiAcT6sMeiocB7EukOJdk2i
 lDe7thuzL15b2kuaBFkqW2AiKe5Sea1CUWiLu4RAyzQ29p7h7aNt1mwK7IKlsKlZh7PX
 tAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790270237; x=1790875037;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UBjDWGhSIhC3y62okHbxonbpjWj3DeQDqa/wYy8nxa8=;
 b=Gv5xWGmwaqlF3CbSbSTKFUcbo1VHnb96z7Ulv5yWMySs7QWf20QHrf7ychQhkE/M7v
 7PzIEdV8ynzQMIuV06YyazyWb9UAIeJ/MYXtf9IIZgJhFxDE2jD5CAtks4J/Z+3leYdF
 6KKneQnCXIVbjLDU8yGpy2S53vZulWe6LXoF0sNAg5IlyxC1fQnp2DUWs5ZwZcghX0MI
 A/YqDK6EkCWq8Yht2Xi4cl2lkRCsrul+3/MqeHsG1DfYkICkNzpQtO7amPuA0qSboRHw
 kLM+99yRPPkSyISRxVRprrHfaveKmafl8IvXllequUT1mc7LFaB5w7LQ41/Ydl5OdRrq
 kt8A==
X-Gm-Message-State: AFuF++nBOHPwSSkTZbpaCph1eskhuKqGy30oedYwiKnMpx75I1VRui8C
 w80KH9F2+p0HKmuBPXI2zYqcwIJS4g5EJm3VN8wcSrtcABFaPCtuhNpUDLW+AgsFf+ISzBo07vU
 k8HIGKvUixXEo1nwrY+Rh79v4S8nhdDdOKB519Cieq0pJcEI7B70NWNwT13wL1TKZ6Q==
X-Gm-Gg: AYBFou2naJacVbT3OyyRZi2OBDITQY6htamOBPWAd4Fg9dho8QwR5gUL97QW09bchlr
 BgvTCyBLvuTw1J82QTMeHO+1lbWrPWF3MrK1Zz19jofrLQYN8nOF308nUbkQe2wekwa49rlUTh/
 sRTXRR9hVVeBhw2/uxaPyxYOx0na992Fg9lGza284xBxmbp0Q2EDN1YwImfzbaZg13qKjSFgLmu
 RZG0L6yZJNScToDhL/ZJrT4NovuN2jQ5XeIVMa0RuP5LssP53ENXaJ5L1uPZ/Q4uekIgJoD1PEt
 2lXliv8b0cfWH+0xoGpX+g0W+nPyjPga3zDtlJljzhCOimImWcwPhYGfiQzPyiBe0veM6X4rl8n
 wyt7JZEa+l5JovIPXsh0mjDDCU22WMHwxJJlaCsuW74igdW1OuwIeABXngA8IO2NoI1U=
X-Received: by 2002:a05:7022:3f8b:b0:144:e246:a0ae with SMTP id
 a92af1059eb24-145040b8f87mr2711644c88.34.1790270237240; 
 Thu, 24 Sep 2026 10:17:17 -0700 (PDT)
X-Received: by 2002:a05:7022:3f8b:b0:144:e246:a0ae with SMTP id
 a92af1059eb24-145040b8f87mr2711611c88.34.1790270236585; 
 Thu, 24 Sep 2026 10:17:16 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ad4028a9sm129542c88.11.2026.09.24.10.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 10:17:16 -0700 (PDT)
Message-ID: <e3c1ef1a-a1f9-445f-93a6-aa43bebe0511@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 10:17:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host
 architectures
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab55b1d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=fLCAjOW_SeC3PywdR9UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: M2jDpN2GJu3qxtVUKXyuK0LiTAtdgZyi
X-Proofpoint-ORIG-GUID: M2jDpN2GJu3qxtVUKXyuK0LiTAtdgZyi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA3MCBTYWx0ZWRfX4Wt0dKUUwRxp
 5AmXS+aCTPVhJMLCjAXVKfps0kSNPTz9LYvp2W7BPbMog3dQgsGYnQ1nTlKnoijisfkIamAE1fh
 BVY9KlgRDnF3svtG9jx7iic5BKPAKuU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA3MCBTYWx0ZWRfXzia02LE6SS+U
 fdXBfZrDu3uvsGHjlAdpPruRhY+SuQaVC7b3zh3IlQG2ZYdIemFujViiUgJtToTWYkgJMulDG89
 WUcZIZ5xSkHIq9okEcFKOeNFeQTWd7ovgc0eCCTAFH9h8i7PRk49hlrsMU+aySs6Qwt/NM6VdB+
 j9TXJYb0/X2NASpl8NHd05rWmHluFC3KFQzQZSIO0BzOJovF70oZGmv7VZ+w5KyPiTHLLlOsqkT
 mIx7Pa1t+s7SDBcNypnxFjjbNT7PA29YzHfQ9CH+XEf4Xc0ETY4tLV3ZOx2hYMAzqs3y37Kvk39
 iLlgVFhO6f0SjVNhu1jlKlLm9otRP6M3tscX/jRBNdeW/PzIdmrNWl7cehjO/SngSvwIlJrA01e
 A6C6ZGku3vVr9QD0Apo4b7BbYWvbm5hloSPbZU1PUajruLzceo1fZPCqldkkmqgwYdBlA0Wetjt
 dK6lcm1KVxokGjlR78A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240070
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

On 9/23/2026 11:57 AM, Pierrick Bouvier wrote:
> To increase our testing surface on aarch64 and other hosts, and also to ease
> maintenance of docker images, this series introduces x86_64 base containers.
> We rely on qemu-user-binfmt (available at least on Fedora and Debian/Ubuntu) to
> be installed to execute x86_64 binaries on other host arch.
> With this, we can run the full tcg tests suite on any host architecture.
> 
> This series exposed an issue with on aarch64 hosts with test
> loongarch64-softmmu-memory that was reported in issue:
> https://gitlab.com/qemu-project/qemu/-/work_items/4567
> 
> v2
> --
> 
> - Add comment in patch 1 to explain we detect x86_64 containers execution
>   capability
> - Replace the registry change patch with updated libvirt-ci, that now generates
>   arch specific Dockerfiles by default
> - Use lcitool --host-arch x86_64 to have stable refresh output on different host
>   architectures
> - Add a patch to speed up compilation of x86_64/test-avx.c.
>

I'll send this series in a PR tomorrow, unless there are additional
comments on patches 4, 5, 6.

Regards,
Pierrick

