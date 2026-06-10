Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6986ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHNq-0007xS-Et; Wed, 10 Jun 2026 07:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHNp-0007xA-Mc
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:46:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXHNn-0002Ay-Bm
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:46:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNTfX968280
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P73fpMnfXWKRKpWDvJw5iLVgsikmyd1E4Bl4VBThfUY=; b=m2346nZb6u9jMXz5
 bsAUVaD1rfKTTXpSmz+md1j8QrZyDhVo09mUYzSIfX32iraCbUsYsMRkxYdlU2dO
 wsoX2VOgSKTy0lFhF+ITtpN4848G+vdVUkD8iP6GmSTHeYe3M8OpzHtHbh6b7ywK
 2PGJfZR6k1EDcm7IskshLVCmmJksL5onJEjMrb+yFHFqQzHgs0Bl2wsRWDNVfafl
 ip/dd8cIvKrbDF/sL3MXlXwHqCNk3R9q8Id/0JFOohMHYemLcxKvE3f2moK67kCf
 Zfok7vbodnd4U2qW1JIDo4JvU4rLE+Bj1d/dkG/6B2vz2SKhoUbMlL6CY/jmbeVG
 SbQtmw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epxuvj00m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:46:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5177bddf6e0so33941051cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781091964; x=1781696764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P73fpMnfXWKRKpWDvJw5iLVgsikmyd1E4Bl4VBThfUY=;
 b=cSlrxWiXhWVwMUJ9liwwpCAM/NfwJaglNYZ3L9mmQRfa0+LYITrg3+33iYpDM10ckp
 fl7zfR3cKIroq5rvCzFz+eHgHBNFVM3Muow0DGu+cgDqCuwqV1IpAI29ke/IoGqqZTwA
 zT5RJoliBODHQfmvPpztKQS4gx+lvVl1emzWFZQThXta3o4Hos7e9Vy75czyeHUG7MbI
 B6tGOIp+y0K1XNEcaGR/6besjE9o95GPPTXqcrb08F65+uOIx68R+5fzrJF0ZZmgGrlE
 Zu0udi409qumDVp7dC/KnqZ1RcYIsi4Za7rx79Zyt/yBwDF1h2BZSsF5+DQj1FCv/1XH
 ZaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091964; x=1781696764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P73fpMnfXWKRKpWDvJw5iLVgsikmyd1E4Bl4VBThfUY=;
 b=Q190qLQdIR34OSH2HwOiB+voh1SFqGRdChgfMjLBJwwwIxPltfXBJ7Rwhr2HbvRhi+
 RVklRFfQx4f6wn4ZIJL+hZk6PL+0WOXkhSSV0+DY2uarxHwGDpkwHfRJyLpmbeGZDGuB
 4mZ1Rbz3vD6Z8ExKmgG/Mk6jv61f20pNduaEjAsQrm1RgTMmTqCM8cc6Mgrtzd2XvBtr
 Ivv0vigPAk9U6B+CQtyTLPK9Wa1stDj/ogbKrQBrGxYzDIGVtw0vVe/WOMUM7u9SAft2
 g1YIpfMP8TlMG/yRQYz7+O81TulPoR+krs+VV2zxDbBYxzziTlmrNVwm6eJwbZ72a2sK
 r7ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GIz4/n1YnrVnZJ1F5KQ0hBYtqn0VCuQpjVo6pneUxnl7kD2kOuGs47l1RLs136DhKn4noiG8N4y+V@nongnu.org
X-Gm-Message-State: AOJu0YzA+9mvZAvuB8/jNZlxcmj9CWXUETDiOvVEq+HxvafjnzMMkhd9
 FV0zWiPQNGNxaACjUKm/KHiTPk4mIGhMyegmBJNCzpypyRp+LxcH5S9h7WmZAdrAWTXh/kUwzRG
 AuMKZ6rtpZQoAH924bttBttPzL6ykjI3t1/LUBsH2hTX7+vMVL1IMWhsDSg==
X-Gm-Gg: Acq92OGbsc4ICZh+GbepfDDTE17xnXf5Z5kJ7xvxBw8JuBUeyKJiABTzaBMj0tA/Rzf
 hQeHPKc5XN2TrE89ftMYn0mLjeBurERgjVWQKlTA02Y2/2Yli4P4rzc8MqaKOqZRCIcOY2RMQMz
 r/TTl865J4Yed/vS8AYkx1jz1X3pR7tsjlVa8igBQcsG4L+39CmSKtUKopYwrmtVDrmmq+MWJWU
 tz9115PdUKpOtgUGml3k0OB5ot+xGrkQ5FSfNJKS/UsgEjDw4i0TQTfb56InOUz5veXm7irGlJ5
 vvU1Q0r6lmCw89PiBCwz79DM3M+GMBpob6I/p+BS+j7TDuhcWynWLgX+bm5Qjq4teUuMr2KCkEq
 qLhLvQSCDy5/zTXPK/WViaJCiMVKpL/z/1g/xE2QlvmP6U2/ewE3/H+6LwMch0Bgmfpmdw0owbS
 MXH0Q=
X-Received: by 2002:a05:622a:28f:b0:516:6818:6d74 with SMTP id
 d75a77b69052e-5179882d40dmr272205041cf.34.1781091964499; 
 Wed, 10 Jun 2026 04:46:04 -0700 (PDT)
X-Received: by 2002:a05:622a:28f:b0:516:6818:6d74 with SMTP id
 d75a77b69052e-5179882d40dmr272204561cf.34.1781091964063; 
 Wed, 10 Jun 2026 04:46:04 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0553fd86csm1188238866b.46.2026.06.10.04.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:46:03 -0700 (PDT)
Message-ID: <261b9e67-6e5e-42c4-93d5-ccc431f5714e@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/22] hw/arm: keep QemuInputHandlerState in musicpal
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-11-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-11-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hJn6vsaThsftWzFuF3JRbfzqqUsDbbzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDExMiBTYWx0ZWRfX7JzGFNX99uxq
 Hqs+lo0D3HsMjFNN9WZRE4LS75jhPpeIZ4IOmsC0ab0WKdxXM0ZhZtTlXKhjYhi9x+Az3ySThV6
 B5oca24U2kcEzDipQvaAT3qWcSm115Nq8Zb73s8tYe3wx3w0cxdq9+sPYlOEIs8t+v23CALbiBA
 BBOVSRiDA4CsAwngnGzOtqSmxpNnYI1VklHhjr2zF+uoEvAlZRq1xihSskPShFL5HHMyy/0qaYB
 v01SuECkfkaPUZrOuwx0219Jl2O5WHGAk300b36+9kg8ZEyI0mKtCN/MB7Nou9NiBaGQiOav8LO
 R7ql3qwMuTyhOS9mnUPZIVZL9z9Wpl03CpN1MHFAWivTWYbTsSDMBhYcjTwl5sU1vsCKk7NZChh
 DKOECP5pHzHHW6xR6D2IsLV03CbQWYHoD6QCFL14JU4EWsXg2So9tGHLKQ7ESHddXIsKBZ/dmNO
 PbD1P/8gy4IjBJlISdg==
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a294e7d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: hJn6vsaThsftWzFuF3JRbfzqqUsDbbzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100112
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 10/6/26 12:56, Marc-André Lureau wrote:
> Track the input handled state, and dispose it on unrealize.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/musicpal.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

