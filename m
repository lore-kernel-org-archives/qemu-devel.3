Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CA1C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprCQ-0003El-Lm; Fri, 31 Jul 2026 13:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprC2-0003D6-QE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:38:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprC0-0006hm-Hd
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:38:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFORML507778
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /fskMw8sNeLE1zJneDE3zhyh+q/nxwgZtfbpGc6ko4A=; b=li6SKqTJN6ThcEBp
 ORRmn9X1Vmxwb51FUAyeAQk9dKS0Y9v5W+wqwSPI0h0rYHh5kw4NjZUEELYvIg0n
 Ef7eAn3cC60PfkZ1+nzTfTbpDnRQXG2sXMHzMgf46Yoc8u7SV/KmN5IYLAAzgZtJ
 lVUrEaSYPQgLB0Ot5Fm3Mq0WPlpKaVGL/NnR72AlzOeT6sGTaVqK9JezCGuVr81M
 ffq2EFzXs/u0TH77Evq56U/Smu7dBBKxqSGNHiqoY8QhkISngXFUG8k1dnT0LVfK
 Ln14pIIIUwhcIVpKHuwXfTnoUEn2miYvcFdywbIn/V2VermNzr2Ju6TV6PwkiVvd
 xNVo6w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru131nkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:38:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso1828078a91.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519522; x=1786124322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/fskMw8sNeLE1zJneDE3zhyh+q/nxwgZtfbpGc6ko4A=;
 b=eufwXP9ijVLcTWsPdMsQtuqvqvjUDu+vlbcUoEkAutSlIhNVNeTEFz+yy6a5mmeuLJ
 xNLUQuoLxVq/Bc9v+1h191/0rI4xtg4LoNRlg2OmNNtGuLj0Q3HbBMN9zw1w6lg3zkTn
 plrk/Zit+17p7H6sGZkxm5mkL2azVw3/BqI4qufN2IXom0atPLlzsI9M9JDMxEBrnCFH
 Logk38byNOguP5CZG4aUUj9V0oWAHwpZpWLdcSvyt52RnqmO0odE4cRC2mS6xiDQ5seF
 5CCmQVmFznvHElP75vQ81EubLxwzzCfW4kZEWsrTHC7mh0yEboTR853ExjSfUKgEruR4
 /5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519522; x=1786124322;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/fskMw8sNeLE1zJneDE3zhyh+q/nxwgZtfbpGc6ko4A=;
 b=RdTMAFmObt1N8qCCBSw0SvAikysdaM1Uk22gyyQxKS4YrdXIm3rBwwshXEZkTO914m
 BXr9LjCvthtu7qivKR3rzAcXkchjubjkRChW/+o4n+SQ5bbixR58fg6PGbtuEAh0eBYJ
 hLOcsB8PB9EOcnn1ElCiwmW2+ntUCXCr6nAh5jYOmcRYCLr+2bLaYO56g3wmKmpV1M4N
 GyrjtvKpHWrImWzvMtWzrJ4foFfYg2p0TGXSGWPF09B+7o4fo0MAcStD06usf4w2xdPn
 X2FPs/ADAA2zwnq0QNhFUUMOzI5TSDsH++SlnCZpzJPQCrtudMsOOwV1LwbFcy5KxMHH
 IBpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro29RGlv9v/Fws2B9R8ExLfj6I+JNCQi30vGkuG6Dbi5+mFlnOL/9C8hiIqgyURcHJ1XnUIdSHL3hgX@nongnu.org
X-Gm-Message-State: AOJu0YzGnN68XMG+m1i26frE1W/8WIWLLXPygBzZ3Xp95mKuLmCJJhve
 H7d95mDdkRFDPpSKKLEr5cdeXzdZM31dEZdheUF0oeQHMLtEGdesj9abNy7VWpVL8Dw2u4Ee+j3
 TP9SRHHnt483/h+XovMULsC63NidQuEfmrZGZzo1WghZZVx65/AyJBNSQ1A==
X-Gm-Gg: AR+sD11lcrRWBPwUHRPrMP5ovYqxk2UpJAcFdK6CZDwyFflMRB8gT5mVe/uuxN65jdT
 0/P5/L15KXRaH4i/JQy+Hw3kV+YcO5vyA13lJfaJA9WIQ/vwhc0hil747TZWWhux+/4oIqKh1Cc
 186zfr2q54Rpm/lzshWH7lkQ5s943leTLlrEki09AilNYu1M5bJsbJykXegvkPOt31VTAq161Cm
 g6+gQBXwKxawS3YkO9JS87rarOS9FjwjT2yiMBRjmlFiQ8Tcq2FsMJnwdrl165zvx0wUJR4Qtb1
 YpvRfY9lSf2RMfHz61UaLTy8/2q8WgzS5iy1jcidmMxPKhYo2b5giKIIp+s0vbMlKfLXm3Jy4Ah
 NAdS5ieg3g0iOceacuX2bFWBFS4dArfPybIDN8HSX1ty3uYiJAZyV0cvUphsdZJhOuOHE
X-Received: by 2002:a17:90b:534e:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38fbc42bceemr828765a91.13.1785519522337; 
 Fri, 31 Jul 2026 10:38:42 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-38fbc42bceemr828738a91.13.1785519521921; 
 Fri, 31 Jul 2026 10:38:41 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm609478a91.4.2026.07.31.10.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:38:41 -0700 (PDT)
Message-ID: <0b533fa2-37e1-4892-ac1f-8dd4f292d311@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:38:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] tests/qtest: add qct-qtimer qtest
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-18-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-18-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX6WBLoWvvISpI
 dw9WKCdnHQRSKr0TUH5dJVutozYFjbZ5/V/wgKQ56dAiF23jBSZlYgObp6CH4FD9ELLdJW38B8c
 KUKw6yn04zY5Jsi6kqX3D6oAq4ED6BE=
X-Proofpoint-GUID: Ifoj0WUlzVTqfH5g1m3DJFUQr_NCtke5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX+IbvQddPH+3V
 nf6wEipN58umxA45fMaHxzopbtwQFjHEkjY1LM/VfOZzKGYdrSB3vNHbCaeBJP8FLTif8Km+MBF
 sVr81aZXIgpS5oyrK1Ow75cMBZD82ShxspF5iYiJiwwsAVg8eKTcaifYtLF/tDuevX+LfGTvQzJ
 3SSww/BdvTDI5lhBZfsdUIA691q4HE4ZH1xvH+KiGF2ixgB5vZIwuf7dXX9DgiRYd9a1/9W9IhK
 bnbGtnEFSqycmbpeUV3IpWd5GFTmY9EI3LKqV0Rx0yNIwjbleBQoiPbX24mJynPx19l8hQRTz4v
 be32a7CPXZJitvmMJz9+nZ8Qhgvl2zAXquswYm3oICdNR+Ow9BjFYrpYDkUOnoQ11T6g+x2ldPh
 imurYFQNVXOgElhn3XMGgGVUUdzfFJxWv6fAQN1dmpXCuyH5RcaBFUNbOXzGH33Dr64R60wMRF3
 QU6/u9lBmeyjtdPUkcA==
X-Proofpoint-ORIG-GUID: Ifoj0WUlzVTqfH5g1m3DJFUQr_NCtke5
X-Authority-Analysis: v=2.4 cv=CYI4Irrl c=1 sm=1 tr=0 ts=6a6cdda3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=wfYuo2B1cPFpyHyyc68A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310135
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
> Add a qtest exercising the QCT QTimer's register access, view-region
> frame addressing, and one-shot timer firing behavior.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                   |   1 +
>  tests/qtest/qct-qtimer-test.c | 269 ++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build       |   2 +-
>  3 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/qct-qtimer-test.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

