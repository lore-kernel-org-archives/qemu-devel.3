Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03C5C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr49-0007e3-Ib; Fri, 31 Jul 2026 13:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr3y-0007Um-8D
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:30:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr3v-00065o-QV
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:30:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFOOX8215387
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MsSPBW2RttFdlfwlUhpdiE6jWIwLdglknk1eL8d0dWA=; b=KrKB+btUxibclRdC
 HKjEEiR4Q7ilVkBUGAXIlWxzdOKo9WHGmvR8QORJ+c7T3/k0awL51Ll1zXpE5BrS
 dtA6ttxDX0cF2hni4VQNgQo+KXdB4vGxq82SMwEf63GiefecgqnFpwLXydDJUyqo
 7VMFpb5UtprPoagjd49sV+irVaIvWkp/q7huGzkJKANTPyEEPi5BH//Jhk5/f2Os
 eJNBnSPIkPiUw3p+mV1q2WERQDYrPDB7fuI4KlTW4c0L9Z86AKDJqzTK2g8P5Kl1
 95xugbfWnlmEGEz9772mF+JkfDEiURz92HOWTGS6xuYUz0Ic0xA+mIPj7NRugjgv
 fAcL+Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frujusg63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:30:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so15255515ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519019; x=1786123819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MsSPBW2RttFdlfwlUhpdiE6jWIwLdglknk1eL8d0dWA=;
 b=NPaI2FxudEuG7UMUWz0aQtYXt+v9WdjmDRRmeLXMCQCWGa/iiWOgfnMSH39C7+yWB2
 npMBbNpC4m6Xi4d9vbLK9vzKfYGPiVn80eXlpE95phlxz/IM53zEjYTH6dB0M0+eiY6a
 56LomrmxRXVZaLLkirmviY6DWs/Lail2HNxC681Hpdk5gS3h57kFlc6Cl64zpB5CC9kl
 PCZ3Mr5hibkAFhz9d8Yg6AqRWfg9HWNMAUanSXnmi+dfq0cCNd9cQQDYTfgsLBxWaUQe
 bY24UaEDlqU+KXU/7u5pBpsEHeNG1TZLgq/5QRtXaXWLZCjzEpW4i1N9D31UPnkTw6aG
 PenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519019; x=1786123819;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MsSPBW2RttFdlfwlUhpdiE6jWIwLdglknk1eL8d0dWA=;
 b=OQrEl1vfnWqkND4R0T/Ir04YvWLO5u21c733yXb0/CmnaBYefUSniRFgrI/8Kjzid8
 9uhOkQVtM7Ro579gtZMnYGCMuEFDCvphLq4jCE6aALr9Bc1gG+BGRWu3EMz21uUvPSjQ
 VW4dyDjrrDsIG9SdLamDXeD9BfrTPSMhh+cYwBoigUgq0liuHVtHJXxnpyU5oFfLXpjr
 GC745I1zxCpNNq6d/DNKv0PDwyWpv5PBG/owAmFPGCSLSCihIB/S2Y0EPQ9WX9HTBKkO
 Ax9c9qU8Yk7pHbVcTx4YAR3LyVwA5+lDId1aZFAWp604L7TCOOGS+MsAu08Zbl5ybotv
 e6LA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFYZ7zusL1bnus+WYWAzkrU34KFSMH4uz7y3DAg6mThKUJ6O/NVaxKyZPRxo0+E/8vENY/RpeHs26u@nongnu.org
X-Gm-Message-State: AOJu0YyQYBMPIe2Ohu/3BObLiD5jX7IkvrYfSvUX/Ezap7jeoEdRUZrb
 kNjQBDi4vdj5Zvxelv0d1SpZtGRGJAPcp7GgogT5FK6a5/59tKFJAfT2i2WqIdOKts7yUV1FmRO
 t6iLxKWHpdC4/UOFpXTtPwiI+0rC4xmdrCnPZPypS0q5htLnJ8kmQHJDLoQ==
X-Gm-Gg: AR+sD10qwyVt9SLa3F4TfAdOV66n88bdLtF4epx3Y580jjbmECgt3JCB7ZSiK+Z+R4V
 PrhVGbMFsnc5Cwygr1YR2T3YubeYKOxDdvRRf5hgMyz3mPrrZchpNktiQIMF8vo46sm4K2uoQEr
 O3joKYqq5AlV4oxzMebxj0HaM1v/3wWEO6mqqC1vnhWSGIoNkPLWm1nQlwWrxW+L97ZPqkmMk/Z
 xznzYThlMXhbqpF2hpMwoT28fRD0SAXfzdo7YLt1/KGWnVTbQpBpC6Atyzqb5CwyBfKetnyQwds
 eTTAAIDx/nF4zTSK2JQ++1qvVQiLDOcjDQuDqzK5GA83TgZS8Avw2mg+SLPktMwLtJ3neOgJgtl
 +Z1DVBSdV3/AYJ52neKgf0qQZp2S8xAn+XnxfON3be2VuhCAfJMn4txrGZR6vu3TlgxZt
X-Received: by 2002:a17:903:41c6:b0:2c9:97a7:3283 with SMTP id
 d9443c01a7336-2d053717161mr4341155ad.23.1785519018665; 
 Fri, 31 Jul 2026 10:30:18 -0700 (PDT)
X-Received: by 2002:a17:903:41c6:b0:2c9:97a7:3283 with SMTP id
 d9443c01a7336-2d053717161mr4340765ad.23.1785519018150; 
 Fri, 31 Jul 2026 10:30:18 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b1594b0sm8286465ad.71.2026.07.31.10.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:30:17 -0700 (PDT)
Message-ID: <3ac6125e-be6c-40c0-8034-021554cd269c@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:30:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] hw/hexagon: move the TLB to hex-subsys
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=U6Giy+ru c=1 sm=1 tr=0 ts=6a6cdbab cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bP8p35ZJUs-PDvbpqJ4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: FjSqd56KXmUZ9xpPNggwhgwAWHW4LujE
X-Proofpoint-GUID: FjSqd56KXmUZ9xpPNggwhgwAWHW4LujE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfX5xMbYfDdXEal
 bIXBIGOdldNFDPqfKWNIxS0MuMYBtIsW/wSAGQxLQYf8cKiRNf4J/mELGnO35dfdwx1XtdiSrLF
 fea8jWbLP0+olZwYhn8kkpOLg6R8oe/l5mv5/cHnIJxmK6Xk/+gViyfRtA19MTEGhMmbmKUmNRL
 FLFpvMWS8gfHoztOLTRyxlwyHF+TSE3AFluE+S6952T1nwsQ983tWjPOrtIc7kCNg2MuImDDklN
 DpOKgvnOGESAa8RNzWTKNDrHxPQVNa0tj/A/l8ESU8Ie+297L8g0pOy9hpjDzwXl3sBn/1AHyNI
 K61A+5nCQKsPaFAKH351PZsl/kVH+mrShEBWjIGW3Vt/EpAoYjo9HCDkXbqTL2n0oKjWZUNrvLq
 6CYzeZorWRwj+uWnnode3hXi11URFeK4hBHXvVsiJ3Ta+SzIyvUt4NJEPfqr2Zx6SbYgzYclaLX
 EOR44Z/1+1KT5su8x3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfXxZhqA0a9UWWI
 Qn4R0p+MTCO8LO8k133yh7rV/uFgtQj+W7qfS6HDkIVMON8mTlnzDOR7HRQnlO+SdI+emUhOwEu
 asIj0xRBvwIDU6t/GoGjGKZRHlQx4vw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> The TLB device is sized from the config table, so both machines create
> it identically.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h |  1 +
>  hw/hexagon/hex-subsys.c      | 16 ++++++++++++++++
>  hw/hexagon/hexagon_dsp.c     | 10 ----------
>  hw/hexagon/virt.c            | 10 ----------
>  4 files changed, 17 insertions(+), 20 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

