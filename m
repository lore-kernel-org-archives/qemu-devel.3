Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D27CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB81P-0005Sx-UH; Mon, 28 Sep 2026 05:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB81B-0005Nk-SI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:51:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB81A-00082r-81
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:51:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MGCO2168243
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=; b=Yea/YMvjTExGSKVU
 EmxK3UkXJ9Qci3x4Yb21ljDH8Hfe+n03slpIrFX1xkoNWRvPFqUiGvbIHzg0BPpm
 blFs0SgUMbxQ58hdNPg/ukelhKU+QObS2zlQMwZQscrFE41FUyV6rrwtZnywFDjy
 bIEyJNbB3sKX/wQxPrwaM158uzwQj6YVOsb+uRTKzcGMW/6MRLJDL5rlzQweSXKW
 E7fgrVkQdWO5GZSIWfSrSXeUIH3hDxDDgGmrkrlsYYlxUFUJDuxaj5Sx+ch0P6Uo
 3y88V0GFi7UMVeL77c5OH66lVbJhVJujyaSlggPpFSKltUt6L6wWzrfUgKDR3ZSY
 u6DPOg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t0xpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:51:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9143d796129so43395336d6.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790589086; x=1791193886; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=;
 b=cVztvb5SaEHkDNDHrWI6IqSbd5S0Ud8DGz5V4/gjkmxvkAyUrj/UVCe3mJBsz4a0g/
 kVyNeXLM0FHf9/eShCosWPky2cqeox303o78R/WfYroWZaBlBQw8mooXpdXm8WJQenha
 C0HKA6vnAxbdp4aQYQqrjx2jEvxRkDLQI7VX+jY6ucQodq3fwiT/CzJ4g1wMzoPbXT30
 RpE0aSPPb8rVtQzIC5S3hSj22wRWayNuk6dl8nuCA7tgehm57LYoik/dV6WZ9KJUnLH2
 hCdKhoKRy2FaPiQ5unH00SUaB6mm1OTIK5Cn9B+SsYXWHHPc3HceLrvwFcunetjoTjQk
 ZMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589086; x=1791193886;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbqGKE7IymnKy3AGPJcXaahz7cXKiHNmsPTM/HEX/Ug=;
 b=2ZbON/MmLlJFdZ6UPLpjpZhP71UgMF/kBis5hnVtrqFiyMOSs/FwyRXmH8LDGqZqZs
 d4VCnnErLmxqIenDdZzo736/TNBPYGjc5ZHfayo4F5YKn+TbJ5cnFtv5vMoKWyAZG+i9
 oG19ZT00hWZPRagDeyfiYTM8SgL9NZkO+tjJ44BJUoaieytexXEK+5z4JTtkGFBjBVr/
 LZpwjASWaQx8RLt7eY+NghTeqzhz+4dzpnJKFytX74tqaTUwKMxhShf3Q/iiIQriiRqQ
 xzRBREJUWCCtPT9eigBTbZxWhcjONRLGMrWQQ4sSCEjyzB7HxFBxNFRjwXkMt0LXde8G
 I/CA==
X-Forwarded-Encrypted: i=1;
 AKwUvByLgywIs54t1Z0NLSu1wz1G3CPkRkyndUFGfQNg6IqUOvqHqJBuZiMyf0z9md9A6QmN12c18j9BEVbY@nongnu.org
X-Gm-Message-State: AFuF++nj3xs65wcNL7lz6RAqSNH9IkU1L5Qgi7EeRwvlhX4k1NU4+OjN
 Flqahso31zz6gvw+4Lw7IS+DUmAkDL6AOOftjIZyQqm2/GssddDBSRmNu9DHSmWgTac+/5IuyKf
 YZdgTelBIBmIYZYNxLXCEFq4odcSPe1QQ5dXFzIXq5qFXmfDBAsZ1iJIZ4Q==
X-Gm-Gg: AYBFou1lwoXNLm/Ssl99sT5PgAx47mnVc3U1XLYyWJxPP8XMOBxF+MPctIP0rFoG6ki
 TGEREpEY4O0SozbGv/EilEITDIZx1ZuzPDEQ6oJgvHjqyca3TC0jtFD8HBqBT/UA3/6QE8SgZO0
 pd8eydmsDvVI9arpQmDA6MW1eu6adaCOhsv8oMyjZxw6Nwl1EF9Yx0rU2u+9bilwKPeiRavw2BE
 dH9f6yGqJ5gp5p9osv/YFIqtXbRzHrZ81QBNjEz8BOguYokmFQcYNUro7jDKCN5MmvfpL6Lvwp2
 5QLACI1J90hHCxLYcPIKOsiO1CP5o16GlSYPE8bBomFGsE4v1A2KXJc2xp9FxdtkUeA7tZXIpwV
 gZ+1HKiexs+MWiAt+YfG9JMrXzavlYwUgHQ==
X-Received: by 2002:a05:620a:2b81:b0:93b:c209:b6c0 with SMTP id
 af79cd13be357-93c47224170mr1898636285a.5.1790589085567; 
 Mon, 28 Sep 2026 02:51:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2b81:b0:93b:c209:b6c0 with SMTP id
 af79cd13be357-93c47224170mr1898634085a.5.1790589085151; 
 Mon, 28 Sep 2026 02:51:25 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a355d96sm28115898f8f.17.2026.09.28.02.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:51:24 -0700 (PDT)
Message-ID: <51c1a88c-2f0d-4fad-b196-c7cba59c7c7b@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 039/101] tcg: Generic expansion of tcg_gen_eqv_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-40-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX8/HYlvHc5py9
 SwY7bvyj/dGgTmVXzAsZYNuQeZidLQ0e6qq1N4cSeVlbmjzRQXfepAGzZAm9y+85LaGaQZG6a5D
 Cakxj7AN/E+WGF5CKYp7HkzC59S4zrpCmlhEz5dFH7D2Sell/Weh9XLJNbUhXY/8WMcY6NX77p8
 mg/+/VlUncr9Nzv7ELZ4Qw/4eaZJu1reaHtt6fNRuacKct4UDj4kf3GUYX1JA1bVmig9UeIawzg
 7KJFe4B4Gvtg38MI35nVDMzDv8HkU5Dk23AadNATBtoUytr2ISVVIQ21V3YzI8OCcyB2KuyoFh2
 Oazdranq0e0teO4GKyiObAIsCQNhY7p8Ow9MxpoXVYrebnAf4sEGdi3Jjp+z6uagaUkhUTH4Qu2
 Jlcd7kYgBE1WkmLz2DBwta5VbYowjv+hf6tD6eB0FfpAQP1N96CailOGM6Ot1B7H3hceIAWwfi5
 J7Q/5spZrMYtuXjQEWA==
X-Proofpoint-ORIG-GUID: swtkLz2_hjr3KcR4HKMCBykjm5pPo8uS
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba389e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: swtkLz2_hjr3KcR4HKMCBykjm5pPo8uS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfXwobQfwWhOYlj
 Et5rnpk9ncF3RNaMekgqBWU30r0VdMyqXqTX90DJ8Z1S1/BDZ29C43UTFi/nGuX3WUYHZjZdjzl
 mL9RCAb5sYKEYXOcuNjRWM/sQ7LR3dk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280039
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   3 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

