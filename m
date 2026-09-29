Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C94CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWuy-0006wy-TK; Tue, 29 Sep 2026 08:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWux-0006wq-H4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:26:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWuw-0004Fw-6G
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:26:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE6vp931801
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Ea4LwV7AW5F/Tu0HVFvFE50cJiL9+N9achJSzzlP74=; b=HtQ+9aK7xDncwwPl
 pnUrfhGQI7ig1xFe45+/choMLrDztAslRRF4lMP8TWKCjh4Injr3NxvQRfhSb5mR
 iDLHlgKIr5slri8BVqlt0fEV46aGKNVSGAKY3frzpRIysna4Cmihhq8V97Eiq7HV
 7cJsOdu1Ok/KLEMgwKhywMEQIaRhr/j0zcEykSSXaPg1NXF12KnIR/GtjegDu5lB
 JL0RdlhWY9fZ0lJmYijaLsjOPKblktr447wKLj8iJeCpP5DLMKD/qmAQuPN4fAFt
 rgk8NM4oxVZWL8M9rwI5Xf7hMhfRjqMfv/BV0Q7H/HtEXyWUNFxJ8SGjKujBUA1f
 vEebKg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxhx3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:26:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5d7c4c26so771279185a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684800; x=1791289600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Ea4LwV7AW5F/Tu0HVFvFE50cJiL9+N9achJSzzlP74=;
 b=ZQBhnPOAdOh97yzFVmGh5oVGILASsBc6WR7gRbfF1OL4aEu4ImCqJoO6jYbycd18WX
 F6rktv8ZB8MzWlkNTdpEqX9HFvKRgC4Y0ZJGKyqLiJIiDWTCJ8aX9J568IuKg2tCXhKk
 utOtyLTl/G1Ocu78JEzVzucBKKRTGkWuN36ztht4GW3tw7/zgzLkulNi030zXfOEq9XJ
 4hwnVqrqvMQycb2iKYTj/tUhj1PysCFCOqSr4YPnq4W6FsnCX5og3Yeed3Vo5uKwhg3M
 xp6atvsL68xgoKS9KQO/PsMW4HbkzpiPe+ynm53NdXAjeaqz3F57DND0NW+7By4/vbQu
 syfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684800; x=1791289600;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Ea4LwV7AW5F/Tu0HVFvFE50cJiL9+N9achJSzzlP74=;
 b=PCtaAHy4cJQqdiAXBcBGkz3Pb6qDVrn2NUltph4MMXV+14iWjuwhPH/R79XeuIw22K
 6NnZD4PAD5QO0NJShNbx0ijIFTIk5xcYN2RaB0VfcazhDrAXOofDf+wFgYQVv+W9VH5h
 QHU1MIUvoCuaCAwxdkUHMBUAMCCFgjXOmaDWubbS/UpwkCuAAIP5frx43RHg68s/aMjU
 DlNocSFc9TS6xeM9LbU8RsXQsQW8dK+AS9TnsDZlMjH6A/SCw26IIR8yQoLUOpz3ejG4
 Ql+aHM/sjaaDUJbsYxdA6AFJe0brP2V0du4p1Y8oGcbmc7O0s+3UBtzUSGlliolHSspm
 Pm6A==
X-Forwarded-Encrypted: i=1;
 AKwUvByRNgn1YLfNwbF83IzXdpbxsOobL9iCA5WgwvlI9txAUAbE5I/ez966+kXq2YKEOWKm+58qfSJbkhnL@nongnu.org
X-Gm-Message-State: AFuF++kwLA9n60tFUJM5uGYMDl81E2IwpLlREUFrau/F5JFkbDGCmEIY
 3IQqpvjDYcqPyes0HC5I/Whba3qiiHWoefK/ena1h7bvbIrQExoL9FzJ/AdMv2MTFMv/L0mSKtN
 SZ0skbkmEFW/7OYLb8buXeQ/G+dOzbYK77mgeDmdRpi+2vyxmuKdGj4Yr1Q==
X-Gm-Gg: AYBFou0mS7j1ejpRmH0rA2VKuEE2v/abhDoAQqRwu7aTdo8WGMJMJO45Cr4jFBNA7No
 71Fp0p2PMkNeZyT1FQkOlIzG10NjpTMeKO+BG90BDNIK5ku9GQOMrSN+tWlYKb/9lqnPNNfzQnh
 Jpuq3mM6r5CGnd+Xa/cJukmM7eN4cD7/wOVNkKPWeNd6DnQCldacQLp7sjiutrO+ojOdcmCJUdo
 i0bpvtvMhktSAGb/KJGcMadcw5mJXPUuJE7iUQJwlV+gvDbmSBeU1GnGtZNSXPMzDWwwwPWx7yS
 mHnyyZsy3o44/vz78hEF9PYgilA49tazpafQ+H+5ybrFUZUaRt+qckFT50NoV+6g5QzFPzAFSB8
 5/2Xsy3Gwobx1rmZemjfLHnggYvyWT++3sg==
X-Received: by 2002:a05:620a:6493:b0:936:77d7:55a4 with SMTP id
 af79cd13be357-93c43cfc87emr2595193385a.19.1790684800639; 
 Tue, 29 Sep 2026 05:26:40 -0700 (PDT)
X-Received: by 2002:a05:620a:6493:b0:936:77d7:55a4 with SMTP id
 af79cd13be357-93c43cfc87emr2595187885a.19.1790684800031; 
 Tue, 29 Sep 2026 05:26:40 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50abad2sm3307215f8f.37.2026.09.29.05.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:26:39 -0700 (PDT)
Message-ID: <95bc55f2-9f89-4927-917f-6c83723dc3d1@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/42] hw/char/imx_serial: Avoid casting from void *
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-37-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-37-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX3fjZOLfmbIH6
 SEBnJfT2UbYFFTStCj5Ac2m6IOGhsGqcja+92YSacRYo5lzSIeDKapZFkdm2FCticLIU9x8BgMD
 uAHGXZgnLeGO8ifqUpcZbCzxrIk2FUY=
X-Proofpoint-GUID: Vpe6-rJeCvSok-vlH8iOIJKpBotHyiGo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX8pIYpw1vCYaE
 /8b61i0DziHBV2xgTccbiJ9QI8+0ags5mw9Frs7vAYKJXY8ZrJ52gPmxGjbwJmHDMFpUKCQ6mIE
 Bqvi85k5KVvHZZRvVXgvKkWqibVEJF4aKFcUzX9I2Uby0zLafJOAU5qHKkELiaoDqNIdPGQV2nE
 LyC7QwfP8BNTXS2Nhjs05nNOWXe+UpYoZEwBs4K1OxEk2WQhwE7KwFROrjCVSiYWYb8ItBaCOZG
 StWzVJCXRXVKb3UNL9PR9HeyM22xWp/qLq1YpUxadsKapFv9+Dw8cAxAnMCZj5ay1w9393x7E6w
 A3EvOnCspNXAZVz++rhyI25iQgKUPWzfPHwkpFlWdeQvR9RKeuXX5zMOJ/OIEZX9wZz+B0Ga8XB
 vCnsTnME7HbhnxvOneldzEMGaiVgC9tXggBl5Gaff3L/a2UMhvNY8qyF/IK0UHYfKZN28vKOB5T
 zReQW3JZbW6Ix8KvbSA==
X-Proofpoint-ORIG-GUID: Vpe6-rJeCvSok-vlH8iOIJKpBotHyiGo
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbae81 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iphPbDPzkScA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290049
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

On 21/9/26 23:47, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/char/imx_serial.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

36-39:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

