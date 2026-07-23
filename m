Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7097C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmolt-000575-IP; Thu, 23 Jul 2026 04:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmolr-00055I-GF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:27:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmolq-0006ON-2d
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:27:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7BdJs3434611
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TZGYD9CvnDjbxwqUuFVcRShMNUuuRlmfl9ctZnUMFOE=; b=JlMzNWs5h9TDTvdP
 xEI3MLg7fQrpy4/b5N/MWfRns/4DhHjR0DkNoOp7UHj3l6RwM1G37eBrdV/U7KX6
 7EXJ50+wG0R26cDyrxS+EVvktGmZr/hhAyOk7ANWf+yeZuI8K0O4iFbJ94dRcwG8
 G12hlCAiwAWPxvGDWMqKScin4h+3jTudq1My3Ixtm14KzQPQY5SzVBhvkDhaT7iU
 hMNtx7M2FuhHCX3aocw6YIEFdVhDh/ulaUr7j8b1enFxj90HPZCvMe4HzadoF2ks
 IhjUxC0VLB7fVV4dcStGMUPdXw1qqiZGMeWah413vu6u7uOBn/zy3e5PqvmCxhxt
 Axe+Sw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk5cc28pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:27:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so4854551cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784795221; x=1785400021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZGYD9CvnDjbxwqUuFVcRShMNUuuRlmfl9ctZnUMFOE=;
 b=BXzraw+x+dr9DUtSJxH51UVUKT3hf6AcpOCf6IvDynj79WvTUAxcyHZEZhfa3+bGpF
 2FvzThMQpAZzVs6ESu3mADqm73BVMSi5IdStpHSGYpnoVK4JL6hHoyxI0XiylxJRSkT6
 827mWOA3+2TZ1RRtIGyS3ybSBkTPw8ZD1NmPcsg60NPbi6m2AGRttfOlnLkoWiLwKI2b
 w1Kc0+sLJK01c2boDTuX/osTTlX5VgY8dGy1h2jWZK4UAeQy7J1FJTGFWOtQdJ9/RV3G
 xeWxg5F410H0ky+Qjs/fbpCrePBdkBTG2+le+YGqh54kuOpnUsrLVPvicR8bEuR+vLe1
 MWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795221; x=1785400021;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZGYD9CvnDjbxwqUuFVcRShMNUuuRlmfl9ctZnUMFOE=;
 b=TPbF4PNngH15f4quUWvf1MX7p60mYl+3nMSNXyuNLbpa+ioClJaJRQenQ38LahFCCq
 SYUB1BdWbbTfF4VhrrFZ5nSBfc6h2k0M45soeDEGmUxBiHi9E8h5VT6FzAxsGG4mIQ9X
 wPdeQToeVvOapAoW0dAJ/1n6qXGPQC1WhBvB80R7MRfdcss7+lbcJYC30hgh3QCTy9WW
 gEVDsokoJqvOOVvgy9otNkfKuE90kMhN52egGGx2REy69Y7Qw3jKebmcAhE1C2pz1JYw
 +BFy8RzDTbogE6sxQuYxSWqvPeRZuVBJK60rrMU3rW8d4srajuMkbS0d2irvokXdu/GO
 UuJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiIIY7goasMWdjiUXjMvyqENfyTO8hpTIBh8A0/bfkJoXx3/ONiBVUyy9pbkmu5YmkkkqguLVWYEex@nongnu.org
X-Gm-Message-State: AOJu0YxrkZhLXPCgBEB1NPvyn6FKGUKVAQNubxj6ISTISLN8PeYl3L5W
 PEYwy4oPhD7kBbS1HnLf3NZuxlpTUpWHcWSXK53kNoYquNIKg8/rLhPoKlR1HzNjwdmMe2gPNXg
 gFXygvO8ls5HchJ+HTy+8NQ3CHPZGhulrIaoX3jCfISa7khlvT3iq7Go1rw==
X-Gm-Gg: AR+sD133BdKytupGOxdH9fb92FC8pajAqaMB81mYmZSvLX7nzQwCCCt/Voi2hV4ZU7r
 +/wO3piMyvJ59WUeHSz4k2Wnd8p/FLzSxuYe2qOg6lMpo0Ptpx7eWW261OUpfBM4AmaIiks6pum
 wQXx1cQ8mR1x2l5JLHeGJx/v5mgm+Hmxffhsd880kLPSyOYGByoI0P6hWyfiqla2qgmJvdeO7oy
 qkU7HsLj3f4tNOIz10HxN9ti76Yvw2chbyjGodQwQceqebpkUmdD8BpIHHkeIfPOzQk60GhX5sA
 dXs1Ka5hGneFyt7YPUGR09WYog5F3I5+t+Jn0U7qN6UgG7HbvOdsRVA9obLv/XhfHuFx/868h2l
 M7UDzkrWZAMEcHWuRv4MbDQoQz87a12aVcLCplC/LekmtCbBcuT4=
X-Received: by 2002:a05:622a:986:b0:51b:fc67:c738 with SMTP id
 d75a77b69052e-5283ddf7f62mr18980771cf.29.1784795221235; 
 Thu, 23 Jul 2026 01:27:01 -0700 (PDT)
X-Received: by 2002:a05:622a:986:b0:51b:fc67:c738 with SMTP id
 d75a77b69052e-5283ddf7f62mr18980601cf.29.1784795220709; 
 Thu, 23 Jul 2026 01:27:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm191487425e9.8.2026.07.23.01.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:27:00 -0700 (PDT)
Message-ID: <50ed801b-87a2-41de-9ec5-dc652fcfcfaf@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] hw/net/can/flexcan: Fix RXIMR reset mask
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <20260723070059.6332-9-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723070059.6332-9-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J0alNBBKvp07CYXOQcpH0tu_Eo4Kvdg5
X-Proofpoint-GUID: J0alNBBKvp07CYXOQcpH0tu_Eo4Kvdg5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4NCBTYWx0ZWRfX/3PC3ETRPUjn
 yyFPDI4FqOvEM2/xGlmap8ifOnAv8jtnzOTFoFYKY47lpeE+JFAnv4fOU+sKlq8xNOaBOnec9R6
 eVWGj67GS/0mcjv1fUwiUW3Rplhg6Zw=
X-Authority-Analysis: v=2.4 cv=L/ItheT8 c=1 sm=1 tr=0 ts=6a61d055 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4NCBTYWx0ZWRfX1BY0ft3LgXh2
 vFM5eK4WR4iAJDgfZllM/TscA8SUQty4j8FQS7GbnvDaJeDwuQIeJ+0DNgRtrWmOv2REmtAoXOU
 37RxmK+Ze6Jk4NZ2k129C62XFgQoBN/D4us/0uhypBdMygebgQOZmfWOeIOdxYKq4lQqyQU+9dR
 h95f2Bp/ORVaMWiQPfzRoCJ0ecwtfiYsstoLap1sZtCpg5JGBaIJ8k0gWtNbCFw4VvPn5wqu28A
 ar8B6RAzU6bt6ZhxPUkLNJEwoNiK8dpER9KgQT99NVQDLmvEOcjhWoACoBdmsyPcOzsJT1JY17Y
 /Z1sirR+MyDA0WPZTLzjnO1ogIE3KBlaOWLNSmpEvQ85ox6SSnKSkDtYb4yW7lu0bMRslbdNES9
 B5Q6YTznchlWL4yG3mrmKKHdW3sGJ8n7VSa3+lTWVGEF3hsM+0nItevlJ2iVuOiloruwgscpegG
 mMht0eTav4I3ugwZW0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230084
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

On 23/7/26 09:00, Bernhard Beschow wrote:
> The RXIMR registers are not affected by soft reset, so their reset mask
> must preserve all entries. Set the mask for the entire array instead of
> only the first register.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/net/can/flexcan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

