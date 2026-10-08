Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C073BCA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvHP-0002ke-Dl; Thu, 08 Oct 2026 17:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvHH-0002jD-Al
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:03:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEvHF-0000yI-K6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:03:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L00IL3968913
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /by6Cuft5unZX8vqQriDNZZEl3h1JVv308sD1N7LaAU=; b=ZgbaEvrRM+yK5SRL
 qVbsUKaIgEQHmI+12ys+PvPCJibWmZbB94CwFHOGrMVJnogwM6eI3TbBqjfSuDJJ
 f7/DmMTFtZh16MyJy82+9xx0I6uXJfLPOCrV0b2rdqwTU2y5UPSP040e1e8CHmub
 KoL+4YTjCSwuw+eJy9eU16SmB01FXwMu/5znohUtZrxFxbH5bku2HRBYWchsZRw0
 ogg7zeACTsTakV1O5s5GyuOUyui72AoeZYEDiGvOLWBMzRlhy6tY2UrjaMO1nbLr
 /o8Sqzfmi78c1HH+yKP/vOgbFq3ABMijg9b1KJ1CM/LM8DF9F7eEuAD3XV+NPaw/
 MN0DKg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk8kt9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:03:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1663fb7e005so1245475c88.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493423; x=1792098223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/by6Cuft5unZX8vqQriDNZZEl3h1JVv308sD1N7LaAU=;
 b=X2p+OqezQ3IA+j8BV9ZjCBl8B+xE0ycr/nkTpy0X8szK1tSwUsxYe3or8ECj4eiCEy
 GRDSFDGeM5tkHQXtw+7FJPNgk81iBlbPXBxHKZn84D+HCXwdj5tykOigsrjCPBzfBeOG
 RzVZ/23vAOrFtovMHarFeYJQPVVIxw1wKkiaiIAl/9Xv8KDGggTLzDKfYU4OpZomTSH5
 8hmKVhPMbzggy4NMc9wyb01psvXrldmGaA5VNa/Kbq0cWVrV8ZTrJ71sGMpI/l/vrfU+
 KfXxfXSy5wUyFA76zVMRbnrgTZ2vD5tevFg4c97Epw67hapyGofMYyPiC7n5c2okdukX
 ouVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493423; x=1792098223;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/by6Cuft5unZX8vqQriDNZZEl3h1JVv308sD1N7LaAU=;
 b=jmcfmuB7deBCdcx2AnfPTGA8cv6AkbwsZom9/MU9bSXKvQOO9kNJUYO/ZproPzAdyR
 IEhBAQf1Fe9ScTWW2xC3ovB5pl1ThJl5K/2wDNEpi7Eb1cOrwyWRZJCjrbt1uiLXyR2C
 grpnZJK0XWp4Cm0O0o8UhTaX1pM8hPBbgxdZMvYb4JWZm/tQIojWPtRCW15mOHVGqpoR
 oQjorsXcJi/pSm0Tyk+P2T3P2sBJL6Y+QFves+aWvT7LzGe+tRtASrt0XbExTGe2TJT+
 k+nJfWLtwASncbAIHvZdTjpDeBbXq9l6u3EbUi/g4IU19rBOhU+/kgRE/b8M2qPX7lQa
 hY+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU/bSY+ZbUIFiqWuAonT0DuGiu5RQsfrKPVQNC/twX2vyqj93HsUh+UvPksVdWoMVTKy53eKgNOEv+@nongnu.org
X-Gm-Message-State: AFuF++kQj5BdPF+adc+gR+6MHWv3zood9/G+vh9Hbcr1MLgYGia+IoQd
 gfXjhvYVdnRJC08oF1nSnTuR5iYwXj4bBBWpbRpvvsySWd4SOXvrwPEGYHEHB3KP2ktBduFFiF1
 gjGMh8RjAAqJSAJglu3zymGYfSOnMyQXhQ2ybJoqUSyQUwo++N/ZBeDzlbA==
X-Gm-Gg: AYBFou201yxru9GScaH4K43DUr46n0doQxo9QWCX1Libaoz1K2x5lXfiAJ53xWEzljU
 R84B0Tso3KJnlQnX3f4rWswhHCpVrqig2ct50ESRrl/4OJvA2HUZGKOQJSwyFF9+CpVEEmUK2PT
 GV2Da+J7pfDcA2xtVNzBQ2jIEuvIw469bBvGcjfe2/+nbcivXS9FzxM+wpxZhnBBcordnEIwnE3
 g6RbZ0XxWbsLyQ+3kAI8yEDS/M/iOTAubA9HkudFJ5KO78RsAT2ynYTfXldRLX9cEZsnBEWqWR6
 T/BuOPE9JI94j6wpR9zLXDKHSKl727IPODNYlO+HtTmM2SdKBd847x2whWXNu6cxgICnTws59LD
 9JWehbrza3B3xYFQ4wHdpQroKQBwBVqSCRD79LRwPh0stIw4bdVD6I+06cDT7Toj+t5fUvA==
X-Received: by 2002:a05:701b:2903:b0:168:6ad8:e89e with SMTP id
 a92af1059eb24-1686ad8ed93mr1210775c88.45.1791493423363; 
 Thu, 08 Oct 2026 14:03:43 -0700 (PDT)
X-Received: by 2002:a05:701b:2903:b0:168:6ad8:e89e with SMTP id
 a92af1059eb24-1686ad8ed93mr1210723c88.45.1791493422373; 
 Thu, 08 Oct 2026 14:03:42 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1699718c547sm811207c88.3.2026.10.08.14.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 14:03:41 -0700 (PDT)
Message-ID: <e5123432-6524-4c96-a0b7-2671f88215f1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 14:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/hexagon: use vector payload size for HVX
 operations
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
 <20261008003711.3984454-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008003711.3984454-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5ailbihnlcpKeF-nM_5K0zJhEr8Y3tYe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX7Wby4CuVMwbu
 MCKDydc+9Be5/lYHCcjwOFh8TElRSHjc1qf1qVGSf/hrQZK3aYIB5JkVJgwOQlpC62GIfa7i/y2
 Yo+x0JcBL5QHlZT5BLcq5yjv04QQTBY=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac80530 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iyuLYXmytgxMYKUj0GcA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4MyBTYWx0ZWRfX0hzxAc/F7kXI
 9+Cxxbd8fe5vRLHh83kiHFtqbQDKwhmhj9JdTgSfqy3IRk+zn5L5FL5aE467rkeCroeeZzuXKr+
 u5QDD1KLh4HhUtxWRqHzvYVLfo2L5ONSOvkjtJaq7lqQRUPVNFRe642lBAa4hlZyDELEoliqQJj
 lnP7+kGJYi95FDge2a2d5ifzPtd1iVMN7jeWlX3bKHJ6sjwHric3FxKcNsb7noFHpyi1A80/SCq
 ZlKedVad0eMw9c1p3tTOEgE29s9AFpjLs315zI5ObypBcuqT7YuOY1g8zMHY81JUCSyZ1yQcN2r
 0V95vCR/QObwVSzmh1+bbr0bYT/fFFe60MRwx8PkofaP2PgFXIm9Y+7QKxQ+yHsf1IEpOAIIqEg
 bhgePptbW8A5TM9R8CG7gCFUhzsCmCM5wSscUfJVsgiNckX3T+A185pH9oouZrU4dbUbMsPeRVh
 1vIawD2XaG5O+NfQbsw==
X-Proofpoint-ORIG-GUID: 5ailbihnlcpKeF-nM_5K0zJhEr8Y3tYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080083
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

On 10/7/2026 5:37 PM, Brian Cain wrote:
> MMVector is for HVX register state.  Now with HVX floating point/QFloat,
> MMVector includes internal extended-precision bits in addition to the
> register content. Use VECTOR_SIZE_BYTE for GVec op lengths, vec mem alignment
> and xfer sizes, scatter/gather processing, and histogram bounds.
> 
> The standalone scatter/gather helper does not include the semantics macros
> that define fVECSIZE(). Use sizeof_field(MMVector, ub) there to express the
> same payload length without depending on that macro.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h            | 172 ++++++++++++------------
>  target/hexagon/mmvec/macros.h           |   8 +-
>  target/hexagon/genptr.c                 |  18 +--
>  target/hexagon/mmvec/system_ext_mmvec.c |  14 +-
>  target/hexagon/op_helper.c              |  34 ++---
>  5 files changed, 123 insertions(+), 123 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

