Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05086CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENKe-0002fA-12; Wed, 07 Oct 2026 04:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEK73-0003tG-0j
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:23:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEK6v-0006cC-3H
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:22:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974UH3T3388628
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 05:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zza/51v/r25niNDy1jv8Q7So154orbVWO1RmBXG8VxI=; b=NGdQ78wgpoqLjL5Y
 qerdsX+EIiohg3PXFDtgP4ZkDdMBFlfbQNhL6WAcqvGavyOf4S5ADOEM+dZda6Jc
 6afmVmTlF+OaqfpKnOqQscO+L+lV8dMLnm1Mhrjbz37GZV1WbQVCI9CCkZlORV4z
 x3G7S9hedEj2ieZs5wnJSDFAmlKJWLMs7QRRph1WEKKziKpnZa3Y7DSDpoR8gZSR
 qU6YiynddDJgweatu41I2csUFa/0eHW5cGSfYOAv8QmM1ckbau33PZQSu4MTX5Wg
 fd+O+rqB5y38WM/Vm5UgwDDf4dUwEfv8S8q+bnjoR4gy0DQjctOsXQEfBJhoVa9J
 sgNKgQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xwwv1c2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:22:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbacbb996so590053785a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791350554; x=1791955354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zza/51v/r25niNDy1jv8Q7So154orbVWO1RmBXG8VxI=;
 b=X8b7BWzLrhmEDffwU29y4UIBD5mHATXJYiJccyzUEMm6VNIQrdOLwjmm5wCcweHzql
 VbbqqEOzmv9C+gtTFI5whYGB2y6vNu3IqbWm6QQflrpXLPEt2hyPRHVGOhb8Iwkucxvk
 ZymZSvZR6bKkF9jgmNUIieKkz6Q6loZ7CiwSlIohEA5wk8+oOndY6FDw56lDBSL37hg/
 tg/TdNeYJRcFNzuh+XMXWjNth/5nfWCeThpFamtzsi2+miKrn4a+vwhupKSZ5cxuDiHm
 vqA1FMuzLkLEcnZfWbNG3fV8W8YO9umNmb5034nN/uyvj98Tv7H1oMq2+o/QsJiTFHEe
 +tHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791350554; x=1791955354;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zza/51v/r25niNDy1jv8Q7So154orbVWO1RmBXG8VxI=;
 b=ai673m8DvJ8s1S7vEGcmVmXjiufX0ZUGshI5GLDFXdpX6kMmIqSMEq0lxNx2QDUJqT
 i7j6aUbpdxeqtKlGOte1fyKwaNcS6vid+NIHBxfv1IYpaY1JqBU3FlSrIMwrKbXGcsId
 RNTlh/KXf0MUEOjGYWpOuas4K6+Wrg9kBqBNVZAGfxwcpfffVtL1dlU2JvxaByj+E6/4
 4LvlZpuY5M3dR/Xo6MPJCf7jREW+WmR6myg6codeT/m1WTo7LeJp1e/zIRlJBHARDopb
 sNv/Ka8SnR3fEUxqA92mFvqKtOTYpUUewAbv2VzYrtBI6eGp2jpr+Ryc3hM3XktYhFqm
 IXlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx15oYe5s9krEUFN6DJrwu3kj4wJyAzVgz47aDx7OBf7W4oKtOe5A1tErmEEq7zi5y+4WfgRUDd3f4w@nongnu.org
X-Gm-Message-State: AFuF++ldoB1aioQKpqOwBHJYrPfPuG4cPFo8FLtOQyseGJX8EMZ70BDl
 XHaR6ip4TaGk5YkW9AODBwLjNHbWZayFzAHw9mE7GbM8s/2H7nN3cWCXAQQ9JxgpdYMlFY0ihHi
 2+89z/tL6fR4vf9A5aQFBs9CW0k/sMyKNDvPeGqgZMiL/u2ai7IpIJcEg0tvf6/hQxEzD
X-Gm-Gg: AYBFou2evSpdcBRm9pz4pcQqUSJ/JaS9fstO9rFsC013Km76bl8aEd9Viaa26jp7JOd
 E9oGU1rrRyCSH0sM3+7FnN3Vtuqp3qYMSOBGUEZq+qUuxFcY8aRgd2uIjr7lxrPgoVX48UcsRLI
 0zycvKHvWbSpT3lkDIJX+m0sg75ycO4aS/tU8c3zOwpR+uP5a2p4cjOpPLg7goUEbLOkDzYATwW
 lmgYtz06hvmzNucUY69wUYJ19/sKoBBkPYH36uwbxFoLyLuWfHjuM9N2aftTXxFY8ebpfjrynhu
 vF7a0n/G95Yub1i4S+zd/CQv5Uo/EAHzVs0xddkVTwYIGiLMO3j6L69JlsIUXzvK8gLq6IECRcg
 BuETgUlSRUQfkcRixi/UQFnMV7uQvdAoRBQ==
X-Received: by 2002:a05:620a:3710:b0:93e:980a:2fff with SMTP id
 af79cd13be357-93e9b85670emr234518085a.83.1791350553517; 
 Tue, 06 Oct 2026 22:22:33 -0700 (PDT)
X-Received: by 2002:a05:620a:3710:b0:93e:980a:2fff with SMTP id
 af79cd13be357-93e9b85670emr234357585a.83.1791350516100; 
 Tue, 06 Oct 2026 22:21:56 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm7939175e9.5.2026.10.06.22.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 22:21:55 -0700 (PDT)
Message-ID: <1540f830-c33f-4776-a94e-6ace7da14cf6@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyMSBTYWx0ZWRfX6ZgqW24k1Uw/
 DTFxI1IReTqZYlNQ6jHhZl14kirdLWkG1eFFsS7lUD8wY2CrXRRobk8siG7b95jwDSwRYllOiwU
 92/bw2+MIgwCVSIv78pzk+ljMdnAcTVR5pQ9X7Uhil8bWfuYkfgbIKQXjAwSBLs825p2TqcRJND
 H4h1Z9dHXBnaVu2mgmvYNYIMsqklQbQeGw57ILh21213MVUUqsf+gnBVMlDDMfOjfmVY0/4YZ1K
 aAGl9PuKvoPbFr4A4J+NefXTRWgPIqJ/yKR6r/3ShYE4fbaJinqmuHxSubbB9D4uGqlXbMEOo/0
 BzW49Ixy9XqQklR+1BaPc4L7NQOhyEAN1f/MDRp0uTM7WLJE9e6SxtXOsgW0Lt2+v9qkyf9C4GP
 EqQfEfdOZQ5av69NO+5YeRmHV81rNptLDa/tl6KKr7zdVcZGuKHeLM4Ft2Q7EkUWURsmGgApL90
 upIN1jBTCQYT850AUVw==
X-Proofpoint-ORIG-GUID: YehDXKG9rLw1FAzbJFoe0J8BlxaBF6nT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyMSBTYWx0ZWRfXyTdo2eWrZnwf
 9bSeS+r5qZytg62mykJKieIaW+XenNzOzg4BDfQIQOlIXzZQL8w8cfkTfD3tWSc3DZOKkd/Rqtl
 Ecgc/UkNQa1KmR5pE8ArE1rPK6xvCTw=
X-Proofpoint-GUID: YehDXKG9rLw1FAzbJFoe0J8BlxaBF6nT
X-Authority-Analysis: v=2.4 cv=SJXXx+vH c=1 sm=1 tr=0 ts=6ac5d71a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070021
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

On 6/10/26 20:25, Pierrick Bouvier wrote:
> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
> based on endianness, are accessible through TARGET_NAME. However,
> TARGET_NAME is a string, and thus can't be concatenated to generate code
> and retrieve matching SYS_EMU_TARGET enum entry.
> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
> identifier.
> 
> There is one more subtlety, user binaries have extra targets that are
> not present in SYS_EMU_TARGET, like armeb.
> Thus, for user binaries, simply export TARGET_ARCH.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson.build | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

