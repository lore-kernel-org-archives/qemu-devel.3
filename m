Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC75CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBX9H-0003ik-Ch; Tue, 29 Sep 2026 08:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBX9D-0003iH-V0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:41:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBX9C-0006SX-9s
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:41:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE46H264774
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FIjhFAWGDPbgdz7XMVSBdmafCEEA6Xw0deZbJN3b4pM=; b=P+CVi/wQLlbJw0/+
 pkPmnIyH+NDLh1XsCf7yXRVrBfNI0Hc3dEpOsHjiGNgSAXKr/D4W72k4q2VhNtY9
 dzlK/gfPnaWTnIg3bHOzQUWP2qYjLWuOwtjusHiJRKWhboJF3dLsC/TvGWphVdCR
 KFD6krqpewCM6StBwhc22DvxeVb4DFOZ1mN/o7inWMT6AFRpuvDSOvo5UnB6RSel
 f9qJ1NwuWLewkFb8QPhvu8l8wyHRYfPCEncSfgxLR3t+RA0/EFNuxnR+VxbCtesB
 5Zxbt7AVfUyNUSEMZ8TlwjUEgQx8epvmHjTpnZBLjkckZbrQB19phkwr1pgK/1GV
 4U69RA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkjtd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:41:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so514644985a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790685684; x=1791290484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FIjhFAWGDPbgdz7XMVSBdmafCEEA6Xw0deZbJN3b4pM=;
 b=He5hHl9Ia6WqeHE3PnNfeCh0TvkL3BLAldXUcxBOoTBs9KtLSZAJFLydBIDFe4JtwB
 K5FfT3vEwyei/of60qYkgPfTmTgtT6PNukf7prJRt7DSIswoM0oLtMdxH7fAQQr5PHP2
 N1MZH49ltD///FHdIehiptT6k5F/hynM1rPlP1rJ8Vb4nqkSjgnD04s0VVsLHkiWhQbj
 mhHcgN8M8VFX8qmJaarQJeEvRl1iRYm7IRIRoE8pthDNDcNH14tMz7IUj1WKroPzl7Py
 tY8ASMIBpst1V1RlyPq2ZtM4lkOPUxBD+zR43cA0Jhsv2BBEix0QfaGy2BTWAOZk8PV9
 8uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685684; x=1791290484;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FIjhFAWGDPbgdz7XMVSBdmafCEEA6Xw0deZbJN3b4pM=;
 b=nvsHyTshvigbfuJbW62LmPMsJQII2N0TF7sabeliSGFOIYbhltDLkiaYUAqLmNqnyb
 +IRYlq3oR/ArP9eIEOx0soAiemy2wc7PxxVziC0L7ke2TNlU1TmQiqnMdEg6Uwa1JTRV
 uqiuEsBsukMPgOt7dqqHc19IA5+2RjJ1GVj8rv9VTTsFSsw2qYyXacUBJbM7UWLBlV4s
 QctmospTNh71Erb9N8cOIC8gW+Z/s0TVeZnG7Z0Ou900EoklAdcns763SnWKMCCCzxpI
 8AFtG/RJHdbqhwRWjrLYvidchw24Q5MBldDJ5hR7j4RQROe+0zjUkXXbLEnILkGzzw57
 Q+RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWO0wNAjo5V5S6EYwKr8pvcHl+hp8rKu1PtP4NNgQpWz8UQhrFOoeD4TWXMU3trPKYA5Cix09P9QmT@nongnu.org
X-Gm-Message-State: AFuF++mah7/OdxvJzIAWvlbr45mHW+mrzIXm4CRV4aSZQKUHMwqLss9k
 8sos9+mZEW+PiyDs8tBALVN8lM8u9r5PXRM8dlWYCE7UqaTYNiBD4scnJ4ocmnNdNYobqKeb5/I
 VadGK5iEsfTsMSig2yMTVxzDd9xfPAWlpuzDVFqsko35yJFDXVd47pj+ZEQ==
X-Gm-Gg: AYBFou1VIL5EljXZHIn7gONdsAaO4SmGRwowIcYmsNNUibL5jYmz4dOIjaz7lXKVbhU
 CLQ6vX848ynINfJDE/RF1M6iLZqWqeJD00qr282fJYtIFeQejyUL8+erhfmIlOIDrGeMgcHsTb9
 yw9x2LNq+d7f7gjgkKXClEZNLUJRnS0kRKIZH6utMIH/xN2LT/m2MyixrBRk8uqDmSFC7SvisO1
 PDwnqxQM///Gp9zsSTeOm2BlOZvZcf8Uq+fmCqedwov83c+yLVDuxol/hwWRGIMndPSMn8XoGF1
 Q9Qpqa2UEJg5V6DY0h4/3HebM+5Vp1nbCLUL2AFhBLmPKf45EJ6ZAhCkxj7jmmmLNdmzgX0lmNp
 8DbS2pmk91L7aYC4Lv0alSUoLp1wPu3sTYg==
X-Received: by 2002:a05:620a:6289:b0:93b:c3ac:a94f with SMTP id
 af79cd13be357-93c43cd3c72mr2405521685a.37.1790685684151; 
 Tue, 29 Sep 2026 05:41:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6289:b0:93b:c3ac:a94f with SMTP id
 af79cd13be357-93c43cd3c72mr2405516685a.37.1790685683528; 
 Tue, 29 Sep 2026 05:41:23 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe0ea4sm87621545e9.3.2026.09.29.05.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:41:22 -0700 (PDT)
Message-ID: <d764cadc-c998-4122-b833-6c73b94021e5@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 006/101] tcg: Use QEMU_ALIAS to define most
 tcg_gen_*_ptr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX0TCtImRZfB2z
 +VV/LE0AbNRzrVLgCKBkMNSQA1t5LoFbPTtpcAZWj7yS0CEQkIlvtsG9Rw1T6avkwpgijU7s/2y
 Bu6kHZ4w/6rwbyszxBzCpnYKFdXEINlTlSIBlT3bDlksbLiF9IL/DHPpKcA7/mn/0WumNFT1qZF
 4RZPkY2iuumP6cMT7KeHfb7yqW0F4HoA37hodKf/D0JELqhH6WL55iZPWqBcpg4/nCbAK/V4PGz
 PsabHpcarAGR5kCEhi9q5dfKsng5mTNpNZj5ZFIpyzEqF7atXs1kg78pnyHW5XDT5F3pyqE74po
 sdPEbhFNAIlmZyZuPHCz0/riqPGXgLLaJO9rjHG1VGz6tT4qAmrlyRHmFMTpw8hNa8L8Ei17X6U
 irWtui0Qdhmr0XDYGWIMvVLpaeBh1g9QE6qJhK2k5jBI4CfWz8NbFYGeAhCJNSq7UW0d3BJsJ9T
 pWuxPVoDPiRrriJ6wgw==
X-Proofpoint-GUID: 141c4jx3lywUWFIwfUZlr3U3DbOLqhg7
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbb1f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 141c4jx3lywUWFIwfUZlr3U3DbOLqhg7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MCBTYWx0ZWRfX6FbOxRtgZbzV
 zaf24HRs/s205eYe8sjDh+klRFFgTChKUmZ1IAySgSIqmwLLKhvm5zRTwLlCs33Z8J/K3NayGD2
 EGHteOT4bmtFEjCykR0dcpgQxzJwmfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290050
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

On 27/9/26 10:58, Richard Henderson wrote:
> Now that we've dropped 32-bit host support, TCGv_ptr
> is always TCGv_i64.  Do not drop the type difference,
> as that's still helpful conceptually, but define the
> functions as aliases, exactly sharing code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h | 99 +++++--------------------------------
>   tcg/tcg-op.c                | 18 +++++++
>   2 files changed, 31 insertions(+), 86 deletions(-)

Assuming all the toolchains we use understand QEMU_ALIAS():
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

