Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87869C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJjY-00087u-LU; Fri, 10 Jul 2026 18:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJjS-00087X-H6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:30:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJjQ-0000VX-IG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:30:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3R8j1697277
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OzHOJ2HC7tdZbRTnY8sg6ICjn4p/PUwKIDnZ7I6tAmM=; b=kRzwGOGcSN+QJTNA
 uWfDIjm7YRuG+wpvd29AUIqQr3xzkVhP9bQIowAgi5DonlCtla1SIFzlV+pASsu0
 M3hGbbV0oulyA8nc/uU5gu6JhcCjxBYDnMD2ZGkqHKAVhuEiS2PyKuGgf6k3AXJp
 RgBvlhqCi4N0rbo4mdEa6L3jUnpx6L8+6xfzLi4ffaS3WVH55wjqgj/Rvjipv2NG
 01wJcIdQDyDFjL2ed19o3HYiBstG929dr8yoMOEFZCS3jcMM/1C1eNW7ltVQ4/xS
 IMkdZyh8lcHNqwtr+pKYIXhQx5+PslPkIRzUCsLyhIPTKQ3n3/iECW9jlsuE7QqZ
 Zp207g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5djmcg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:30:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so30694051cf.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722601; x=1784327401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OzHOJ2HC7tdZbRTnY8sg6ICjn4p/PUwKIDnZ7I6tAmM=;
 b=CbC3wdmlfQS5vwxSVYdxJYQSpm+Q+J+2stxJVLqvTWZJYwGL75f0VRLD2SJ2mwSDEW
 POVsazn2/XoDhuYzYUD84HTW6AhkxXytj3LYqCqiEEk0WdDFHK/EhKSPBaktk8aaO6fF
 r6dONX057kH0cNuRnKBv4HctsiRUXRR7piPdu7bOsD0G13aGBKVnMDpNUuUIGForrsPN
 Wp2DOcyrHxViGlDEuUY25LNIzH/jARaHmdftphGWU9O4hlLZ1SMontoWtdM1QHaIFhFO
 9fdbIOaDICiWqjBix/gsb1rCwLIW709dqXI4MwlUklwdPuVFSrTsDW9w5m5Roq3eBul4
 Qexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722601; x=1784327401;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OzHOJ2HC7tdZbRTnY8sg6ICjn4p/PUwKIDnZ7I6tAmM=;
 b=H5lGQ9C0bsVvk/ChCMXj4y1BzOwvYrgx85NmwnvVfsN2Fis3FBdWNO73GrGimzRPje
 v8IRNkUQlTAFT4LxSW9ipdTvchcrrGFMpQZ/bCtNBAt81E1Q5VWKJG1epIwhf51wyXbT
 V+77n7Q5EjLAy4N5c0mzXV2qcTlH2GLyz+apAa9/YvqUe980Te+fUQzhYLW1taUNDa4N
 GTQvZo5KE2AdF2I1tkkbbyyHj/icNm9Ns4hE3Qvk6mzp7JbWSkWLAmhLsi7YA6D0l50T
 ENfcviXxZ5CJc+VBIbhzR3AS2pRKB6fR7rY2xwCWQHvhjE+e5yyu2wxo4H8vBiYi4n0u
 uxjA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roco3rRqiyYBT9PUvgScOpynOLj4RDkqq58MCR30p3DWQW2VzmNdlFVw0RQAVKif+tcS1UTkNADU1in@nongnu.org
X-Gm-Message-State: AOJu0Yy1ie9rRCnQm9jN+FtkqTeaynC9PCrjA24Rk/C6H2xw8wNPCiL+
 D9fNzqsTkB30XD2LfcS3xNH02MR1EAztLAU/Ceti5CU6cWrHBHSPrAHxKwQKQ9zszY7ZAduxVRD
 jKMXCiwpQsW2C9dnbqrHlWSIOXg/Hlm1FWCKxFeu7omKRwkPNBxVs1HHA2w==
X-Gm-Gg: AfdE7cn4D8owsFKxmL7M0jMGktJ24r1sZQPGP8T0HMlK2+tvQoy8J+DY9ovK3mlwVh6
 Gqlqg4JoreF3RErcmlFJI9QO3Hva3OmlAOPIQMbvHiJedYFj8hDjeUaSCEcPQ6PkG1O7n4+ugtN
 a/9Eaq/BZs4EyYoFRGf/gplhOLGp+nEuCs6q90MT/ogG63VSl7sejOyubkEUL3O/hYX0XDiM/F0
 lNB58y95DmGgyDcJG2Bqs7abb93RS/JyFTEg25tCDKwJTJu+4NprrztLnECeexeA3Fn3ajZFqvA
 uVIwOm2DuMxIHwq0UsmS2nQYxF+EU/cGJ3ev+5r5GJmiV+eM8I+t172xwoU0jKnp+CLqBmUhJMJ
 NLCYoCburj8/iXHTvLx4x2clcSpNp1wH5kr9NRmPeklbzlG7a+CtTZipFIwj+AA==
X-Received: by 2002:ac8:6f12:0:b0:51c:730:a587 with SMTP id
 d75a77b69052e-51cbf2ee752mr9058291cf.63.1783722601519; 
 Fri, 10 Jul 2026 15:30:01 -0700 (PDT)
X-Received: by 2002:ac8:6f12:0:b0:51c:730:a587 with SMTP id
 d75a77b69052e-51cbf2ee752mr9058061cf.63.1783722601117; 
 Fri, 10 Jul 2026 15:30:01 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6e0e5asm173345125e9.9.2026.07.10.15.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:30:00 -0700 (PDT)
Message-ID: <ea84165a-e76c-4772-ba92-e8b217c0ffc3@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 63/98] tests/tcg/mips64: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-64-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-64-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfXy1G4puT9xfJN
 VvGCZqy30Vr4gL66lwLoFBa8t2PtlgNz+B4aCke2uQf6vpMntfddpOOS0hh6MTWiwFBeqyV/xHH
 dgneUnQogoqHULiBCpk7CwmitSq1rCQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNSBTYWx0ZWRfX5mfxWaA54+l+
 rbS3RBEMGxUIBCd8NNHfqfsQNMcVO4TcxGO+LDP8M7bv1cUTQaKe5Rz044ycCrGR61tp/m+GKmL
 uvjx0QbhDv/H+xKu0osaEZm1vPb1tpQxcHVnMJiS2EzUyNz2cpZcpUIj/LdTcgwJKC6IHoIZjzf
 C33PSiIqlQOZYWmz4aNK9Kbl07wplQ4yxo7c7wPNERDxbbTp0Ahh8/1njHXAfocAb4JcNP2fJgn
 v2htNHsIsUwZ2f2+Jy3Uk4lO79wVumzeuTlMb+p4rP3zgCoaoIIdEcwplV6XNHe1PMA7dkEAdhL
 h38/QpuZlClsw9q/54lF2taIHJDdsrWFu7Hl7xqX2BYbh3E/p3a15Bz8pMKLPdtadMV+fbC29UE
 vjq9vPufHtTQBwCUuoIaU1CjGhokSnsLUFLJKcnI/8UGma4kFH+j/0Xd9m/cPyOjEBEx0W5/mGJ
 lo0T7okpEQAUfgO6kIA==
X-Proofpoint-GUID: BnvrwK5a-AhxLMsVdycuTYkSDBJmv3vO
X-Proofpoint-ORIG-GUID: BnvrwK5a-AhxLMsVdycuTYkSDBJmv3vO
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a51726a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yMiodoD9cDZrc6EntcEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100225
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build              |  1 +
>   tests/tcg/mips64/Makefile.target   | 20 --------------------
>   tests/tcg/mips64/meson.build       | 27 +++++++++++++++++++++++++++
>   tests/tcg/mips64el/Makefile.target |  2 +-
>   4 files changed, 29 insertions(+), 21 deletions(-)
>   delete mode 100644 tests/tcg/mips64/Makefile.target
>   create mode 100644 tests/tcg/mips64/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

