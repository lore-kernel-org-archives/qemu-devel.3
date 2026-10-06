Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40299CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEGlF-0006Vi-1p; Tue, 06 Oct 2026 21:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEFTE-0002aa-Oy
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:26:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEFSt-0002oE-50
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:25:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eKXM418960
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 52nP0BOAav5p1wTWpyqMlxWLS+x1vw16L0c9WvcWI9M=; b=J65Ius3XYU31qca2
 qcGd22/0Oyto6RByWCKG7mjAJpqRJuN+A7YhbWaKYcuKqOCxKW5547IBCp2cW8Pu
 Na1JEAEklmL+9BUIc8+cxUd4elF3l9y3gZW9eWjjeBvQTfVBlY342NIfrnlc3iBx
 kQL9LBbzD57+qYor35lyqZqpRKdI8+wp7jb5njXLbODFs9q6E7+fhXts0TG6Hv5H
 cyo/zElGJ7u4/AUWVTOXuy+wlI0O8hlUbDAgFd3i/CO7/TsVTSqCIz7JIJyejc8B
 MFZwV6dYlH0lYKqNeZ5Wb37koCQBZE+KR9s5vHF8jupa3NOL+Ra8KetI+g5+6Yt9
 UGmq+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg4dqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:28:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb71b1443so495256885a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278912; x=1791883712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=52nP0BOAav5p1wTWpyqMlxWLS+x1vw16L0c9WvcWI9M=;
 b=ATr46Et9WJIYKBpxUFaqInmadjA59QBPW2TMuVkL3QcsMlqMgGwaE3R+R7n2zHYsRo
 Nbgeqfuet8wCUuJzF3KRnsodf6wXZaTV88DpCURR0x1Vl/biBhLovVOWw5gu/4bD0vNF
 MlHWm8zyDFU5vc4dofwb6UoN2eydKhQ3E1gAB7TdKD2X1V9uq+8tdJvR27siGRXa6sFZ
 C9lfn7DLwXMd60C9fC0IQCIavpAt64LIJrRn5gAozwQ0+/jvllhFRV6ZVePSaztfr1og
 tNx64cDEPMiTXaIZ3RBOcQPGwfCIMTHtgwgyIh3CPcObW/iyl5CR1q/T3r7OWtIhsO+8
 c8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278912; x=1791883712;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=52nP0BOAav5p1wTWpyqMlxWLS+x1vw16L0c9WvcWI9M=;
 b=0fsZYq7qL6YK0Uc8QLT2MA8vdRXvT/pnseFu0Z/L+7xnsfi/jk0mBbhzzn65GXL6Hl
 BOusk6FiR0y7qw/5V5zqJGqE6kyuS7cciqmygPEakPyTCsNansU87RBQOZu01FVSw1v2
 hc8cadzrdi3diOo0boD0T1Kv3QbmCgr/3G/D4fjKrf/UzmKEeR8DePfzZwqv/2DWdbr9
 1F4ivuMI98cKVIny1gDzkE1bWsQp9eiP+QsCABRnCxj6UhUEC/WPSWHBC49TrPTpAixi
 HWw4inCf7OV6c2XuWWuH9FylphUzYXKFeqhSgCwrZnTtePdWuQZQZx80VTqlZwRT1XMg
 B9iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSqtH2CSRe97+Zn2bA79jzszc0L20e3ciQOsYMVorY5BDNVlnmODBGSPsMazLLHHodJrhruxskFbRy@nongnu.org
X-Gm-Message-State: AFuF++moZ8hmBnabOskY666dsyK2BrcYyNqBECj37fwupfR5RqMGNdB2
 xOP8vhTv14zmzGn403jZ/j/it2yYjGYPGGK+UCDL0DwIFLX7Gqd6OKJ8m4pDMKe6Md8z2k5bUv4
 T3gCPjT5qulDYZvbKVJDHrlTgyRC8TCAIiVji7nuWEN0kc4hzTp5M6BZfzQ==
X-Gm-Gg: AYBFou3FXVZ/wivAHEMErRdMJTMiYL7N6sVVA17j7GQjFn/fV9rjoSSdgzFGPsBYz8H
 RPBGcBgxdFa9ynkc4cl3B6Ge8oTIErb0Sh0BuaV9pPCdcUMcMUwe2UGu+jFxq+ekE4mHCRXpJsE
 BRQUwV0Uah0bT9WysTpUXQXSXldNZEMkoIE6n4UGYS8hlj/o/Rg6tylOgVZJceOWOcBCi60P3LN
 1W8smrZV3P5SgIFB2MMoYDfTJ8y1lqgR6HGzUWSVWs8cBA6eOTCXsHWp/GwjhF5NINyyggR/onv
 TqP60vY5/HkbleT3mj1ObSQtFke4gi9mD3VpQDhaVCNygsJkBHzSaLND/IlJ3tPjgAYD2Re1qr8
 nqPirOS42R1mSJUD+OBaTjStW+zJ/sL5rbQ==
X-Received: by 2002:a05:620a:269b:b0:93c:5152:8775 with SMTP id
 af79cd13be357-93e8f0592cbmr137740885a.3.1791278911703; 
 Tue, 06 Oct 2026 02:28:31 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:93c:5152:8775 with SMTP id
 af79cd13be357-93e8f0592cbmr137725485a.3.1791278908901; 
 Tue, 06 Oct 2026 02:28:28 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c50f54sm54416385e9.10.2026.10.06.02.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:28:28 -0700 (PDT)
Message-ID: <843c6a28-df55-4df9-a29f-7951925a4303@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/31] Kconfig: Extract config FSL_IMX7_SNVS from
 config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-24-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-24-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BQpYGt4rT5wAR-ZWW6eNn3mti9wy5PAA
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac4bf40 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hB8EK7K3M6JkGnyv8YgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX+EEHm8idbcUm
 p4ciUC067Sh/UmKx1RduiWUmobfPwuqqqt7xNU3f318m6ibFpI1V3PKtdw3Ol9esY2SSI+TKi2I
 4eZxG/Ijlm4j7ALXbwPSLk7JSaEJMzA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX2z4ELrOKNSmv
 n9bkj2M0IAEp7UZjMZqtTJT/sZfd8uD0En3B+6crmBPMmnS3kK7pmaXkmm7n2pYPbiLuTMvZ+fJ
 VEggVnyevPKO544VrhDPoptOxGyIxslZd5wukS7+KMxeGzkVBMEqVca/PDlryK9VwDsc1ei6lR0
 B+zqppbSMHZV9mb5BeiS8KdHkKNmKGWx+lZVCy7vbrYvUe11P81pe20MKXSS1wZmj8/nQGIdesE
 +ZrzXPiWQL9WdelvuhNp9K5NZx6gZKnM5t9KjYumS6PPyikUcDJSFqplQY2wfNU/zaZ0P5w82xL
 5cS+Yckpeu3Ugg0OUDH7HLFroZ9Bk60ysgpKnzCVtGnxtiGMvHWKLBnXTfsAlsUBkybPdXKUU0l
 /2VAKq70qJD7EeBAnhrBD0BWyD1e5LvEqdmLChmpwD54xojovCm7NrUpcQOM3WObLxAmZibRI9y
 d8iOqG7dit8Y2xqEAow==
X-Proofpoint-GUID: BQpYGt4rT5wAR-ZWW6eNn3mti9wy5PAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060037
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config FSL_IMX7_SNVS to eventually eliminate config IMX.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 5 +++++
>   hw/misc/Kconfig     | 3 +++
>   hw/misc/meson.build | 2 +-
>   3 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

