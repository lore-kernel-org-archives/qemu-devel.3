Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B44C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4ye-0003NV-ET; Wed, 14 Oct 2026 15:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4yX-0003Ii-W3
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:49:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4yU-00029h-57
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:49:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEafLO500299
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2D+BovE4Kqg21T8f07JGN1ItfyrkIk/XZRbvgdhFNqc=; b=Tfxl6sF5S1P19t0z
 jXJ3u581G7EY2dAEdGLP+DXgerCjUMkluoT6KcBqLq83o3tf2xOyCHbeF/wRPWwW
 WcrsO9eTLmCiV7yc9Gn5gpzd8zFY4idnnxTqFVvE6aVq1BdZZGMiRpJUH2aR6y2V
 pNVASu5yl9KPcnClY3+TyREBaUEN81BQj7xAit7jgJd1dGNmYu1Zqm87dA+V+NtQ
 DjrF/VFVsFugO1YXaVrNBxTdR1azeydsJCwv0ycXI+GrqhexqCL/HUUru+ORLYRg
 0RjEi9Z5HMmkITdPfW/UNNYXVUd9a19tl9SU0hY92DfFWK4iHC9HJfPRnc2CKIjf
 zv1IiA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1h5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:49:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ce7a85f04so983177885a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007353; x=1792612153; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2D+BovE4Kqg21T8f07JGN1ItfyrkIk/XZRbvgdhFNqc=;
 b=ibRF9fd26fJzWox/x2aRW1VIaAmqFsX/Fy9zIHiSxxkbC7y582Pstcy/dl/skFTEEr
 acna3w+pKiOSNtCE/prMzjx6KG8Giqsbme3kppDgnH83beca0d4YsfMwE8jlqAxL7KPa
 2VbmfRIGVnm8TlCVoveGOCdeOmJj56uxFwmzrpAzdfOO4H8mK/q4FMa7h/NK8l/1mWnW
 7spXyfW0aBrxmjnGoycWHRzzZRj9gn5icE87sEM+M+WQVzDYKalgUvOwCbZ9eijIKJy0
 Pj+qiopnSIXuVkMYrwfJ9sbrnDm7A+xN3bjcjpovGy6RVRTSt+s9/G8rzlSPbNnBPWwa
 Zp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007353; x=1792612153;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2D+BovE4Kqg21T8f07JGN1ItfyrkIk/XZRbvgdhFNqc=;
 b=xqfZFxb3ijunRqK+2/4e2vTxVqUyXr7REHoArE19MRg/y14ciYXwUO8G7XzEDw/FB/
 43Rf+1JdJhWULLphAg1KXkWJ02PVOpXZff3rsHp7mvO2zvZAAMVw5Ig85HS4R/gqKpBv
 IyMjkuQgmQ//iGsx7H46q0lJVhK7Sr2Kwg+hpBoqHdk+jb+eWg+lSeytq4RwaWENJ1rf
 F1vHlML6siH6QKVH5NU1UmCGNnI2KHbQojV4oXpWQzT0Q4d16NB5jHEkv0tITc7GHffX
 OARh+rjADrQhics4sH7R6kZFOEr27ugO4fr3VUZrPV3RqtAcA+aJx4XjK4068apoOi3z
 TXsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXnlxru7YLMwxphgQM7Bn1dEL+Ll20lnsNVXmdsz5zw3P5mcDsbwFF7YBs91CzrUWgF1Bbfp3ecizw@nongnu.org
X-Gm-Message-State: AFq9FYJQjL9elrYNDotStrUfH9/L2hwV2cD9mHx1kzFH2kcub1Tr0CLN
 ounu22EG+/dcHXm4DHId1rQWI6FpV4iQUqgmA/4D9KxULcNgcC5rUwHqkXm6hk9tcDPe32mOfjk
 aTdQNw50JFTUR9t6ug3I8ATHSRP03flV5WNnoke0CBfee0MKOLLC+V6W50Q==
X-Gm-Gg: AYBFou3IbAUGZljElQ0k3JGZKtU1PUbWA24hvwQIxw2281alRlfHVfcQ1Ycxui37ygF
 KfKCB0N132QUIoiHOrCJYOi9WIobaamT/Q7aZczMcq5fp2nT9zIUABOdVud7SltUj/9deDW0Klf
 dLgSq15Gq0qVmGWC1Wmo9Vwa7Zcdcj0FHFH5ofoDSr8Hs/2OOMpw6xJp4etfoHTqkEwoHAd7mTn
 cl42sil9Rk5p1T2m75Maw152/GbCGE/wbmRrfcCc/VQ3o6nRSD31nlouhT5qRjxSVdC2itHAVAo
 eCv5WZeQPJddHrwc2LZgytoIHc218RPyce2RLsLzd51iMUalKCwvaB2/OPZzdajp78KyAAhC2HS
 efbssj+IBChv+7JxlAj972/G10HP+1ncQwQ==
X-Received: by 2002:a05:620a:4109:b0:93e:4bbf:cc11 with SMTP id
 af79cd13be357-93ebd1f628bmr2728077885a.30.1792007352840; 
 Wed, 14 Oct 2026 12:49:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:93e:4bbf:cc11 with SMTP id
 af79cd13be357-93ebd1f628bmr2728075885a.30.1792007352414; 
 Wed, 14 Oct 2026 12:49:12 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4e8csm13228471f8f.23.2026.10.14.12.49.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:49:11 -0700 (PDT)
Message-ID: <48a13fe2-8e73-4eab-b302-2197cac5799c@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/riscv: declare semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-7-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-7-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX7VhSFTjJvwF3
 SWsoQzDPOqH5QLH0YDamlw5VckNn5QvnixQYCZQdQTpC3rAzMtPItrBjoy2Xe4jQZ/SUIUb4Avd
 D9eobe4qYOkG8ts2F/v3NHgmQTQUhjc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX5dWOu5MjFvNm
 HKOLTAqzwotWl9p6LGgi3bJ7E/+DYfJ6553BOJobdtx8Xhq34XTRCOK3eC06+d6h6jAWmJFgHor
 sVvwZzKfIDDsTaJL/SMrnEJaDibqKEqipwUws4Ueg+1K8UAh9cZ6qSV3ICOJEKl94ucVlhz8mE4
 f+M1c4t8sMSv4LzW/kbR8su6QnvzOu2X2fN4TwtsAww8bS7jD+VWW7LEKudeydPLBJoh6WfPMo2
 FE28AGDa/oALgdQP+PGCjt8Kl1k3z+F7SuRGAZjyHQ6mkt6S8sD1BpAGxUuE1w+d+3Y1eUqN5+A
 iDaq0d+LInSgG2V5jQyCRstbgZPpJvpcl1wvUaGEAWv7L/OegkSUqYdPupw1l5TDsGEvq4/SllA
 2iWNvIlB4d8oCQaiV/aYEhKoV1HLDQ==
X-Proofpoint-ORIG-GUID: Dk7KoNMlGxoGCw9XzLbDZWntWwzSIt29
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfdcb9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Dk7KoNMlGxoGCw9XzLbDZWntWwzSIt29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/riscv/common-semi-target.c | 62 +++++++++++++++++++++++++++----
>   target/riscv/cpu.c                |  4 ++
>   target/riscv/internals.h          |  2 +
>   3 files changed, 60 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

