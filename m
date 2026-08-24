Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA86C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNnt-0005IR-Vk; Mon, 24 Aug 2026 02:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyNnn-0005HE-Mn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:05:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyNnj-0006Yq-Lo
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:04:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5R9F51937605
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dve2VfMDeq/z4BW6WrsexjxKgIgOTXqHND2JWWbjFkY=; b=N3y+LqU/++uxh/Qq
 ANhOnqM/2KcjhqZmtY1NGew0Ueq4GgVPfCbh3nR5WqcQfHOZFZ2iUS1UZHzthv5e
 aBvDnIXhZ7epVcoIhfdKoH5ph+y231G9q6Ph+z2+z1O7znnDxFqZuZ4zymwblSr+
 PdXH0XC1Ywgm0/lULhydq3s8zoHiadd7oqQCGBg1RKn+xzVfDwmoPLzjzLRczjI9
 DzJRdijGHH/EyJJ4ZupXuVauWJ9tBixbQ4WUMM60xg410aVOWOYfdp4esgTDmomH
 vwS2P346SDx+0xdw2AYPEbg3Eotl5o38NxfbBUW8WRXo26vThfFbvhQYWrf+evPf
 BhBrig==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g741qwk9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:04:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso29213501cf.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787551487; x=1788156287; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dve2VfMDeq/z4BW6WrsexjxKgIgOTXqHND2JWWbjFkY=;
 b=QPiCRevEz+jm5/dL1dWxZv5znWekfN2licSsPdzeiX6rArfOqd+KaNQPSkeiyW9gc/
 zOwZv2dC1tyhrd99yjl1rYrQZQDy07weEUHRDjIKv1fg5dVxvtS32OnI1I41YokptdGK
 9N+wvSzIbJk1Nuid9vtnKNUNHKrszoiEj9pubfFSiydcmL9SbbRSA9PTfSIPBMDfldkT
 pt2RezHlF/zqcBQwVRWe5v1vlp8wzOBVj0oTm/5cmQwnH3nfwl1tzYJMkwnuUrEVfAiL
 7Lwehj6oWVS9mWGCPFD2lQczFPmMTbH/uVdqFTPDsPvjHojFsbGMrOFU7qjrP/Zac1sw
 EKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551487; x=1788156287;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dve2VfMDeq/z4BW6WrsexjxKgIgOTXqHND2JWWbjFkY=;
 b=qAykugPccyUtEXYWig7kbVDrxdFDt4JyjLBzCgnzPHuOgMnn/a9kx0M54P5ktMPS+v
 uzm++Vpy0brfCjKdiulgzuHWaRBy9EhOFtXac+xGXLV8R2nUJyUFtp9TFdCpvDu3zTi1
 QBNxpuezCI4kHgtwhYfbvReGaRQTFJnizBIV2pZiGlsIshc9Py66sXjWf+VqJdQ7INry
 xN379SQxvw7MxHYbkL0VdjwVz+KHVpofldLVW5gT7rRIrK01voD8LkfOcIRu3uxW7oTi
 VYRkYgu567E4ZFNBZDHlja2XI2WTEjaR0cIasl1q9ivKBYmHJrifeBGcAZxuf/B6+bwF
 pcGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDiuCiFqQIMRYHtU51BdRMVS7z0UwytApsokXB0NESzLh+mYzjOI7T0dQNI/DpwL+wHnUAP1DYl2w8@nongnu.org
X-Gm-Message-State: AFuF++lubFVxdtEIRTn9I6wxUKK8zzSRoagtVjcumHpbJgwVS00jSz1s
 LIZR6QMC6jVoEEOz9bsKRJgKa1B7CFh5i22rKmObq7O+ZCWojUtWn/YJZnmW+w+R8l6bOzKghEp
 iSAdV4paYt0V3Xj99bw4FXGm8KUnUUO+2QHlWTst5PPYbEUVC6zdZ/xx3Ig==
X-Gm-Gg: AR+sD12cxsHALfUTHBYFtL9+2Rz8zrCL4Cm5W8VXMd94/m/vtcrgIpH1LFxCgD0keVu
 wLyRYvilk9ehUNSDYwMhA+IfLAty6nbfgFofaZ1ypEFcJg6F3DGz0YGEFjD/DgBN8jFmvrSS+dB
 Q0gFF73wngdqSlSgDrJK8RA2K3S+KQmAzCmBKmlMqbMHYIiE9kejLe2pIMresK2XonaKDNSw90O
 Tmd5gtKMjslHCN0ywJOok55sNuHtVjskB401giwqKvJAFMBgnDpIYoz0f/Hm/TcKWqQ2rTzcEDL
 ExuT6sR/yXiBWhDklHSz4P1Yh7IOnP8ax62nFxztXHyAU+WeCmnSONspP1GEsXSrHN5Xj6MYUP4
 8jn+HmMgyZFIX12eWgheor3Pr7/4MBeJn3liArT0tl8095j0N1g==
X-Received: by 2002:ac8:5a93:0:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52de36d0274mr291776931cf.20.1787551487370; 
 Sun, 23 Aug 2026 23:04:47 -0700 (PDT)
X-Received: by 2002:ac8:5a93:0:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52de36d0274mr291776591cf.20.1787551486966; 
 Sun, 23 Aug 2026 23:04:46 -0700 (PDT)
Received: from [10.254.188.74] (241.170.88.92.rev.sfr.net. [92.88.170.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496734bfcsm1132966766b.43.2026.08.23.23.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 23:04:46 -0700 (PDT)
Message-ID: <6c69caa2-dc51-4fb1-8f4e-d9972ef0be4f@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/riscv/boot: Make RISCVBootInfo const where possible
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-2-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824055642.41098-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX9QMt/EzCieVa
 bkN7STlF6HT1kajPQ1sf/lMXsT35ZL0D2Nj559bM6SAT8chLbkI02EZ5UJ8WU01UmJ4C5diRVat
 p2lzuiUgkTj5Sm3wTC3SVnvfzcRrtFTgyTdkvr9HnUVAW/ckfycsSNPs0en2k8m5SCTnJD/eMwZ
 fNL9xFOkJVhS32hxuhsPpZlfVcvg+CA6LBa6wDdxKvkYtxh9D3S5cFKdBtET+VRsJgUzIylBZU9
 F3ka8U35wVM8lc5RAjs2Jd18BnVts9DTbrykuo2hXQE/h6DltGtLJpLwil+UQMxG8s31ycE0sha
 Au81Aw/SAd6cdBaaVOnrvismCb4ryV+9yasVGkKoqGmXzZL5GQHlOB6T51ABmNC4HQyuSXXdMpy
 AfwISxFq8OwEpY4N0LB0uR14O1RSfF+yQlk/pPGaL6pjQVos5YwxRX7QoMmV+qNP9TNAq1n2yJT
 mCtx3hJjAvrru+OMidw==
X-Authority-Analysis: v=2.4 cv=GvNyPE1C c=1 sm=1 tr=0 ts=6a8bdf04 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=+Tg70iCNDwYGP/1Xem9bLg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YWV-e9l3BiEZpfse0y0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: fIN_YkLJo7sRCH7bjGdAQOBC45e93XHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX0pIFLnxQsXH+
 EGVXd3PP6LxF47zIDkUqbfS/VFFex7SnJXP3vxMdIkaIfMW17M49fipA7bk/4TZWp9Pv2j9q32o
 5EjTrEeNYMOLVO3saaC4sZ2NyMaRxxk=
X-Proofpoint-GUID: fIN_YkLJo7sRCH7bjGdAQOBC45e93XHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/8/26 07:56, Joel Stanley wrote:
> As with riscv_load_firmware, take a const pointer in functions that
> reads the structure without writing.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/riscv/boot.h | 6 +++---
>   hw/riscv/boot.c         | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

