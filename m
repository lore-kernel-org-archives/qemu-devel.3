Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93AEC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphGv-0001xx-AI; Fri, 31 Jul 2026 03:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wphGt-0001xK-UC
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:03:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wphGr-0004ky-Nq
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:03:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V6BHq43310003
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GBT3XfyjPUom495lVaSfPTGufcXcof51c7FlkCIEgzo=; b=AcmduX/kVWJH3eN4
 BFTmDWqjbVrBManH+vr/EFoG47QvAqJUSFYZQExMs6IcPxL9o5qerun6AVrWayIk
 rO44ym5oY0bTap/jVn5ow6mwn6s1gKpioZNaicHXkENJH5B5zAXUvr9uDBwplsPZ
 y4VCHrYNyvp0getTFiU9D2f8csKZzE1PQkYYRmKHIbeJv+L4C4DOpb5QwCo18Ag8
 NHs1fbhAS5j0Ww8lIE6uRCfmpmuKN8S020vkuO0cAXNeQiMzGzaBePb14srXtTsb
 +05KLz9XaBx7U1fNLLP7cyvPEUOAbzTeBY7ierTDxCfQYBHNnXZHtfd4qKd3h6aR
 Q4M60g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp7g86vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:03:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8fc6b670b4bso7284986d6.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785481381; x=1786086181; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GBT3XfyjPUom495lVaSfPTGufcXcof51c7FlkCIEgzo=;
 b=ZQ1guGc8eZ2Xvz7Y4ys3YkrjiAG8JEAZrse01Hd5cC7biPSF5ndSYfMGd2yOHCAd2c
 b53w3/tLeBuKvdDm9+gKtmK6Xyf9I1MKVmh3LqwZIrMUYwt6zxWZ0E5XTTsLLM753SUW
 Wl2/CfcNAX61f2/JJmVg/fv+3qeEFm473/1Tq/eD/RRaqb2Y4by9YtPZWNwIbT9SC1Kf
 d9Y1wJWg4/oHY4eWvzlgLh0RN1e8fNgDRXYylobV3Cd0MzO+Rk8L5+6ZxnSnMjWM75ov
 tRbeqPaBLH3KMHq9MPAGpPxGyguFgZih8NPU5OurINvdFCR30CU0J8WuXEClL4VPn3/N
 A3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785481381; x=1786086181;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GBT3XfyjPUom495lVaSfPTGufcXcof51c7FlkCIEgzo=;
 b=mB2qqlKvrGyBzCXY1QuX9mAq/hZn13V3Ut1AHup2TgRQBSk1xZKd/2qT9XhGtnKKvm
 3TjktvYDb++wgz9s3arSiGrQZYzg+RWwfGs1fDktnY/jnGErqMRaGWObSS0u1TW7P2B/
 Y89o19lM7+ER+Oh2squjuY5pYU28ZFT69OeMxRS/dnZIE+RyKlMfknwBK57DH4GIDfwq
 3mnwZ4fI8U4zoVkLVZPovX7TzgD5+OguBLoqfVDj7+DujP+6SNI+tVYY/7xoxiXlWLZQ
 IUKFilX+if9jxwXkUuhr2v8FYX+EIv9K9WvnbEuUIaXlEBTEd4YYAOMk6sDoXASUDYSz
 F6DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr39yczpR+7uBjt05fWn2CGjCqxye/NpetPZ3o7iqrpbOnn8P3aBk/AuFE1xhZ10QMMfU0THU0cM9aG@nongnu.org
X-Gm-Message-State: AOJu0Yzt9MjrXqSA+EfOcoJNH2T+LnrXdETh71O0Pm853BUqfI/yWBJn
 ZFJQdPMSNtXut+p7vQrDz9Zn5wMhYJSCCzCJ4sjKOb+Taw/p5rLP0EAn3U8OnWZSebOZqJo4aTq
 xLtNJzAVyFffaEebiXBUy6Youb98Xr9VWl9gUvHx2stgodRzdsSljlb39pQ==
X-Gm-Gg: AR+sD11WNAGvBi8Qnq4oGwX8GU6mOE4Z71KCLm6mZSa8aDVycCr3BzVUhMa4mQwxDtc
 U0X75NbMHc9kXrf9bCdPL1EDDdPbXAsGv3mD5u4I9tUFuLgTMFrzI1dhZdsPiCD4rDOZ6Vl7qZ8
 ML+avh2ZRkOLMPg/stBAYfQOrHRhLIhSZsykGTvb2EIDQ3YKEPHZIHGGPacU+C+lVYcxUymyyK/
 ZAruCpf3fYcfb6agMnBDem2t6mYDCfYqD08bFta6WI1CbVd1CSXsr5s/HjyHVd/ivcKcVcINah5
 uBzZRaAIBZS6MAfZU73eNLGGqwp7xztX8stBiZsPTDjP0cPVz8ZCsGRTODC3RZ13u44nHOIbEYt
 B4xIYGaFfsdmG09teJCALeVeRvZD7gQp+eKAZnqMjtfAUXjz3edg=
X-Received: by 2002:ac8:5953:0:b0:528:38b1:b539 with SMTP id
 d75a77b69052e-52b4aec47bemr9139441cf.10.1785481381089; 
 Fri, 31 Jul 2026 00:03:01 -0700 (PDT)
X-Received: by 2002:ac8:5953:0:b0:528:38b1:b539 with SMTP id
 d75a77b69052e-52b4aec47bemr9138961cf.10.1785481380560; 
 Fri, 31 Jul 2026 00:03:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c660f6fsm325090a12.25.2026.07.31.00.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 00:02:59 -0700 (PDT)
Message-ID: <064d4375-1e23-4076-85b3-99e9fc6091c7@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 09:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] tcg: Add revbit{32,64} opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BcLoFLt2 c=1 sm=1 tr=0 ts=6a6c48a5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: b9TLLbH6hiwzoHR4aO5ryzTqPsY1KBmy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX71cWoN2R4t2B
 1B1YVTQoUITzfP68LeZzVWdNsqs/m72xxrEG32jUSrkaPeqiXbrKRMvWzZbG4ZfQx4MIgkEa7nj
 WJwdxyVco2ozBXUBFzY/2YrznTi69pU=
X-Proofpoint-GUID: b9TLLbH6hiwzoHR4aO5ryzTqPsY1KBmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0OCBTYWx0ZWRfX2n8hTQpw0+9T
 TTMx2tXgcE5u26FldPpdvGG2ezfpMbzK5I0g6i6mH8ZQCXmgjbkjSscVw6hZ02NEDzoNuTyRzoU
 ylyCecjpQCRPd49nOqVMhdNpBOkkll5/0ceiQA16js6RKDxJMWfUU7qXBedSz/ViNDw5OsPK6qe
 U85WiNxS7BAo7NMXR76DZSdRftpgUhgwI9KQBxXJROSZ0S8nY9UknCsC/TbLJ+jCrDzZfm6mm2L
 4OEhYjsSY/1IPUFftSvkbTu1NLYBL6bqR5MSf5oFsMWCwV0IvFe2R6JtamYueM1Fe7WXvRO47VO
 TaCFE/Vvm9numS1DPNz/QYwnk9GlgoLA1QDN7jUNHx1gzy7S9xhBGgz5G5WI2nREckxLnxmVlHJ
 LOsihwyufYsEcr3AKj2/Y/++YDN9q64fUQrfGkL56DNRs9dy+alsRpdGk0MYnXrIYzk9tjHuKNZ
 /mRrj/QGNaiMT3MyZOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310048
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

On 31/7/26 02:04, Richard Henderson wrote:
> Add the plumbing, but not yet implemented for any host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  2 ++
>   tcg/tcg-op.c                     | 43 +++++++++++++++++++++++---------
>   tcg/tcg.c                        |  6 +++++
>   docs/devel/tcg-ops.rst           | 11 ++++++++
>   tcg/aarch64/tcg-target.c.inc     |  8 ++++++
>   tcg/loongarch64/tcg-target.c.inc |  8 ++++++
>   tcg/ppc64/tcg-target.c.inc       |  8 ++++++
>   tcg/riscv64/tcg-target.c.inc     |  8 ++++++
>   tcg/s390x/tcg-target.c.inc       |  8 ++++++
>   tcg/sparc64/tcg-target.c.inc     |  8 ++++++
>   tcg/tci/tcg-target.c.inc         |  8 ++++++
>   tcg/x86_64/tcg-target.c.inc      |  8 ++++++
>   12 files changed, 114 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

