Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F13BCA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoVa-0007P7-9J; Wed, 30 Sep 2026 03:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoVZ-0007Op-36
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:13:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoVX-0000B5-Ku
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:13:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6oVVj2009230
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5kkh/huNXEVBcCe/KpjKfETn2AQJsW1QkPMsdritBVM=; b=V51c5xplZwf9ef67
 ES9OWf8L5Qw2s8h4NRORyeKq96rcsL4TgPcrRRAOINCQgBLUton3H0qtol7kPmyh
 xnIp1T4WnBmD5/0wwFppC4kLHoMBo5+NLpRfHGakjGY/T1j+6oQ0jujS/hmB4rlu
 VGhz4HkfPzcNiZyjbNyBn008AAUOAonVn4NiGGqeBsWG2rMuzdzfQf30Uutg0t4e
 cgW6vYJNj1aRVV5VZ8LGbKinLxLPW1HJ8FzxHhjDgNjWbzkcEVIpnCWy+/QoVU/2
 vU0VSq7JEHB52zrw0XfLChyRl9QZj2sHr+83Bj/jCxqotsMAixdqdHL5GOIk773p
 WDSFaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhehdub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:13:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0c7126e7so906355185a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752417; x=1791357217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5kkh/huNXEVBcCe/KpjKfETn2AQJsW1QkPMsdritBVM=;
 b=PMWIagmQ+OlCiprzu3h+OUcg8rj0XUwaIg7b9bA0dKlX3CLdpYvMXx9FibjgaP3Nie
 gCwMwciS2Hk70MYIqy2NxmA8K+9reZvqztfISOvAztl07Nxjm3koMIVGHslbnaJQkz/6
 QElBsUcD1NH019czZd3QZ8IUa+8ubJVJfvCIpVuLC0F4tvNsunjMnNlOc3U5QOAMUgiW
 p6Gq2O13t7Kt1pFGxP3x+GRSiqiwT+q5zUqbtpN5qd13E0Tl5SP8pQEfrE6m5wAGqExg
 3IVeP+0puu0tDaES0ze3YMlUDpyokQGLYEYgRWWSJQBUJoX++EMby4QnsIcN0GAbbJTB
 z+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752417; x=1791357217;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5kkh/huNXEVBcCe/KpjKfETn2AQJsW1QkPMsdritBVM=;
 b=Gl2OAq1jKbpvPUnqZmyPI9MBYq9bfWQ1dPpu2LajeofGTMTE/LyG4CAPAWbwENeR7W
 c+CtwfKr8bnNlBPUC0BaZZI9CFasm5aWu9qNHJcQ5Vom4OVAkapHH2uWqdofKxH8jKIr
 iLh0TluajEVjiEd89X4Z2SlJ1nHdE4YrLHqgUjLI0q0kny6xw8lSO9c85SbHvPvTwFgj
 rD/ItecVA/+DEXEBDLWInz5vswSJyKlCaXGnRZGANxbXG8cB2CjpaszZrxqo2RTDW2k+
 KMHD+DqyhPee4RhB8cAYzJQY3ybKg9HlMl7gkH4kEVK3tZLAYJikSc1IXNdGIk0qwYnM
 wN6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT9ItlYvqJ3xk/uq1mpma3HxNAZazBmT4zYINjku+hhEYc4rJmsltYpvIquBsO6TBQy/2g0XxctQIm@nongnu.org
X-Gm-Message-State: AFuF++n2gPqVNS9FrWZ5XWA/gS1mdOOodNtpWXifX3+PEuserKV3AB/J
 B7GRJlSyZkpu9LYewMHxKPgrKHQhhiIYlrTxMErayUe0BiNTRfvwANqmeAiVJ/ObT+xxthUtktF
 8exE6TPBVWVnxnwjmFGAIBvLG0oxIbfoZ15OlD3YHdwcokcsuSrSjbGM4AA3rLqRznQ==
X-Gm-Gg: AYBFou09RNi5lfcjLuhh0bOObgcnjZZh/1fxAeHxrNSBmU0JoKfE/l38Qhit33cf62M
 aQRT9fpuFXZ9G+XCeHWbCJbcFa9QC/41i1/C24A1ZmCHUY9RzG26fcspzBnJTd0AH+hmFqa37Yz
 eV/Ip/hsamFezRY/0B9OCZeroMrcKzfkopyU+s4lPBoi7AI4Z7PHqYx+JmywzF3aULbmtL1eEgI
 1jwP9cbEYPGwGSBx3baSWoab4ZPnIKtkWhbJW0FWgtpYXEEnc0s2cCZTi+4rBj2msYNwdfkakmi
 Y6stSJvmgFIU6bHJWgDx05byacKiYiWBkLCLcRb2EBfK9MQ/iCatJ4D1x/BEPYmFv9YZ1bdVh6s
 +2SCVy6kRWtku7CXnrbk1sd/jrLL0JUiZlg==
X-Received: by 2002:a05:620a:2682:b0:939:5ab4:e6ab with SMTP id
 af79cd13be357-93ca95eb8acmr66633385a.5.1790752417420; 
 Wed, 30 Sep 2026 00:13:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:939:5ab4:e6ab with SMTP id
 af79cd13be357-93ca95eb8acmr66630285a.5.1790752416840; 
 Wed, 30 Sep 2026 00:13:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029ff46bsm1244014f8f.29.2026.09.30.00.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:13:36 -0700 (PDT)
Message-ID: <47b87027-deff-44f0-92ba-ce2d55cf1516@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] tests/tcg/mips: declare msa tests sources
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929212439.110454-21-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929212439.110454-21-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XSGoJ5UKoBWkSfFOM8BSgpDOZHJ8bEqu
X-Proofpoint-ORIG-GUID: XSGoJ5UKoBWkSfFOM8BSgpDOZHJ8bEqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX5OhRyr0703dV
 5mppJMOPwv3gyHYl9+ei60Tx9l7cuFtAZcOpd4usjZu4pd2/niIvOD0BYS9ALReFd1QfO8qIFOl
 g5MNqpXYXI0jaSjfBP1mK0N8thbVTSGpRk4hIoe9GaG9mYIoTCUFMmHUhmuR5FZhDBjQNeNKNOQ
 2r3NEeUeEqwqPJmzzZ6lbGR9PDfNCF2CkEjViADXpAYiVlwwh4gGPP/xNLApSY01QfTor6tcJ+t
 CyCJmQRNsEEvsMylxNdFnmIMOsJRfBYgfe88QEccNodM/MDjGvzBeDxLMpXeoK9MsErzIMGH3pT
 y/OF8ow1Vvv5Sut3o3xOtvoDOAaF7omw1+DGT1zT6ZcaN0gc68cxamsSpzy7ZeosA1Dt+YW2Xsk
 BIanM3YUcjqJlt4x1y+x9Ad2PXui7aoRxQXNju8x4EXDCc5MDtO3Rw2SFd37b6HKj5LGqjLi/OZ
 prGNSOx317rgMN+A7kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX/S9vuzoBmyXv
 n5rul9ESzZF2uaORqAm1Eg860sEmhh3ndZVBGLOVCSCSs8/x5Kk2u2OQzkMonE/vnNYL5whLsSE
 TZdUt4YllWHR69k7ZbZG/SLA4fCEK3g=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abcb6a2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300028
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/9/26 23:24, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mips/meson.build | 277 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 277 insertions(+)

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

