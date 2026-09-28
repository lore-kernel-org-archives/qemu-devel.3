Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28082C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7mR-0008Tv-QX; Mon, 28 Sep 2026 05:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7mO-0008RM-MW
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:36:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7mN-0006ge-8k
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:36:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M6WB1445810
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1z+PZJbObkGN/CyEI8Q3Vfa7mpgsIaWhGtuak7+0gPA=; b=b9r0HwnvYToiBRRX
 Zk4kIWKNHEBHTY6tm5OnjdR+kCy97m6mXKc60DgOU6jg3vrY2jT6jU0X0IQ1l7/p
 Ni0umWq9ZZRq3lHmeFF5lTfPR+Bmbr70zqzdtWKXOzlmMnVITQ/ALao9o41qEVjz
 XjWvSjoBDCtSf1mMOlRLzk7vGkomlQdstRnvDCEamzz9kzLo/VtFsMLGTvM1evTD
 BBPgL4abncWDCCTyXPnRku+gaKzrWXGUyRG4QRkdwSokOSi0EfnsrlD+aMlzI4b7
 3vLgLM1mFKMWafs52kJB4GJuQUCjRjoLEV85vU9yQ139OGy7VSK166ZsCR6ILKN8
 RfqNBA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkr23t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:36:10 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so737669785a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588170; x=1791192970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1z+PZJbObkGN/CyEI8Q3Vfa7mpgsIaWhGtuak7+0gPA=;
 b=GpxlBbuaRkrhjQRDjAjSLE+XffgQIE2o3dW0K0Xey6fLJBTIoVN6OAWaK4tsHgxplN
 B/0VksHKLN3GxFAPsZ0Toa03QjRlbF8NFZXjuATxflQUN5ZWtK7A0nLNcv2koD/eRNO9
 DLTtpYy0C45z2lpTL4QjQmleG7HZ8lDPNrpweqGRNREY20zcvonRD8VmDMf+he57OUGU
 isaZ+brJ/tyOqKr3JUB4BjmKLdv0LwEWBJra5hTCh36azzs9z0TtWN21Ld+K8NK5dDPI
 jorF6ZRUK3Vi7+DMLHvLhxitPIyVl66WJevY6ABwqJR+NtV85vbgoCYWYJmgvysFkKbJ
 SJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588170; x=1791192970;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1z+PZJbObkGN/CyEI8Q3Vfa7mpgsIaWhGtuak7+0gPA=;
 b=1HUjH65mwbuxNm8P8c5YOuQ0ROuzNGTGHxyjnrvB37y2ncGjkP+xmNREQtP5oPR0eH
 aLVEkIZS5RGIldyMZLP75oHGCGc+DJtStgWCD4ABNcyP1yAA0rxVYV/edIrhBogsH5+1
 nzt9iySn1wxOlmq3EVaIoHUInR0tzxpl+hPWOFTMdJdgqEI7f7gZncDdGLTxcnzUnmLY
 JvZLZRXneuLBQhzlTaBmxhjdwo9lAjl6qrHFJ0XA0BYvbz4bBhKVrzrTaXG7ahQJOdVV
 XvU1Txs8O34hYxvZyLy983j4cquluie+9Pr9BuNPsWGV2bNzCZOMD2Px+Xrk3A3F8N6Q
 oZlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykwX6XEFaIoKe0Zl5PVg6YlrwkLdqyLS71NHk41A9I/wMCOfkrLLK+q4FFXnIvHE0nOYoFU3W9+Cn1@nongnu.org
X-Gm-Message-State: AFuF++kBbmNslflKKl7pLoPnnSgQEwJ/kJGC/a3/MRhLJK29rF4YFziw
 6lwwHcYAmuNEESncBpCX5hVdCTq8JQbTYTRgMAy/BhFu3nlmK8OJV0jyr94QoeBtUV3NVGNqzWr
 +XeDKyLF1YDr+oyroDVKTp4mu5g1uGYdMg34bNvG+3tc82P+21r6cWzfi6snqi8nHAA==
X-Gm-Gg: AYBFou3WDHAU0ihQV4GBpn9ciuiBgc7K9TnvW7A31fYPKgltLEN7ZkIwraNmgXMCg96
 BKtC4l723TDreHnQf6pn1N3a2WfS5EZuE1THPi23N+PnUynv8RYKrvgcWMcrexx/b5d8NAKXWQr
 +NCjdpCGLOJ9QTfvzHl/UAbz5W3brAmDR+RFqvoE8I15FtIqw08DToq/Ijkwsb4KLlMSEJQ679a
 8YiXXP4UqkzcpQjYgz3s8c/yHvs8C1DcSC7Lm/1NsVoQ7gz15rYR6Ygy/ZrCuRbtw+mJKNvhZZP
 zkclcxRbGyTepnqHLCxscYTZtlsnjabw2qzt/LDFVmxI4/J9hWuEAym4XcR9XEXwLV5TSuLRkoZ
 QheDxWqZeo221QbV/GVTuOf4WtOZ7TrOOCw==
X-Received: by 2002:a05:620a:2587:b0:93a:2a59:3377 with SMTP id
 af79cd13be357-93c43e0e96amr1947550285a.41.1790588169674; 
 Mon, 28 Sep 2026 02:36:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2587:b0:93a:2a59:3377 with SMTP id
 af79cd13be357-93c43e0e96amr1947548085a.41.1790588169292; 
 Mon, 28 Sep 2026 02:36:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a74538asm25270986f8f.34.2026.09.28.02.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:36:08 -0700 (PDT)
Message-ID: <eaece176-c8bf-47e3-8ef5-4c9be68352af@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] target/arm: Enable FEAT_UINJ for -cpu max-v9
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfXxtSt92rW34JQ
 q3i2/2Yq1cCITjWPr3ZNHfAIWGp3vg/JZIxh5PJmIQ41+boEwD3YcyzOW67kr8RWHnNklyxAl28
 a2emnZw4v3dpWv80MThByp87e0AKev+66tQ6IgMrD7j9FSM+X8TrkmMGfyn37FLJ4JaRFVJye8C
 mzIWg+xE6qaUErxfGOMoYpexyJ8l9PWh3ry+Bclgs6vBFWoIYWzVtzxupTINg+L8bfEkKZ5cDQE
 8L8xehVTaZydM9OrKQuvoaarBFTM5mmexh3Q+YfBt50LgovUEmVhQRoaKjkTnkMe0Z+R+EUcoFr
 6OY6Dvi+spfgnHngwdExkxMk2F7NVRnlvRun4s0a9WAr19LI8jMlMsHZd1Asfp3U9PRpBSB28ee
 Q3i+IyL7Aeq8OP9dDE5wsD/KIdKsqR4fv3mSw2AOG50JAxsTC8WH3qvbQX/+gnuJ6+vCDm0cbjv
 69UZLX701opXUKUIt1Q==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba350a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dCBIpMvwHQuBX3SvVyRV2t9e9RGYUWqa
X-Proofpoint-ORIG-GUID: dCBIpMvwHQuBX3SvVyRV2t9e9RGYUWqa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX2GaUtcXt/7sE
 Zmwhl8PB40/oszdE19wZETA4Rl4a8dDIoNpyFbNeROyfyIDH3+twu1bZbVl2XZwNjPWMiv91D51
 v67WTwSO5yxRK4nHBgZVpQksXdRJI1E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038
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

On 25/9/26 23:50, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

