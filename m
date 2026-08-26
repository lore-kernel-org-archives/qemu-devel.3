Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B992CC61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzI3W-00012C-MM; Wed, 26 Aug 2026 14:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzI3V-00011J-8v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:08:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzI3T-0003zP-Tp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:08:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuqX11541304
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gfta1wVShaiF7i+tkcCGqAk8FK9EsbJ8xRldVZZ6TEQ=; b=M8F2WEf3u9ErDkyS
 h9FsNQQGITGlOBwIFcVa3BEcgm6EMTQmVSSXGGpLeYBLIkDOVuICkzRTLtDaIKYp
 wrvDRjeG9waqeaPT8ecmHqD0BQBMZzFAkEL5vOJik2VysnqZxWBmqVo+LBBKH3ov
 85tyXF33R5LkNQ8Zx7h9Tz7RmoOsRCh2LgpsLruTicwRzjIUJZdtc8wulsNuGUoa
 /9fgo0qZVU5Lj47T79Dnrdb7quUvXokoWrfU9HYoJv5K4korsYZWQOXyU+2iVPhB
 F44s4noOCV5TTjBjD0ldfWKS7HEoX427IwuE2p4V3y7RrIPTvFXFAP57CCqicxl/
 U9uU1Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0759cpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:08:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so13947901cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787767734; x=1788372534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gfta1wVShaiF7i+tkcCGqAk8FK9EsbJ8xRldVZZ6TEQ=;
 b=EwdG3pi7QMNkNuxg2QPSTfo4USY3k2jOldc3vUcFY3xW5KANK8BbDz1JvNIstAp8nu
 qn37IpKuYopjxFcZ/uVPLQP+AR84ldQDr3CuHSTMNEY82JTBOA5lUnbOIqTsPOS4Nzgx
 nkS0I8JEzr/52WXmTZl7gAB9C7c06sQUlJ/3h/B7N1qK8twsQHzQzyoyOY0HSrbCyWCU
 lhqq14W0anhki96/9rnYuHob94jmD1xQdXtv7lBtz9/IwH3P6EK4Dije34WQMR+PWwXL
 GROOwFafcyvzg0MaaJM1HrvOzQdOXInbbIz8nP5X0GpnmTBWoLAGcUdej5Wm5vtWi3Or
 8Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767734; x=1788372534;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gfta1wVShaiF7i+tkcCGqAk8FK9EsbJ8xRldVZZ6TEQ=;
 b=D2dnZzrDVUNKOy7bcjd9hp2+G0H4R3lOfmRNl/pAiS7wOYEtJo9Al4JD4bDFPzLyL4
 PPL0XwIZLdBoCWwXizNNzM40fOf3U4DKFiTAoyGXooxB1Wc8DJvOeKDmH5do7opavbw5
 KFwQ/3DxvC484ISpXa/u3EkyeMbocQ7SG6skw3VxEprExKXTUgdzttMGUNVHH6G6RXIF
 G8Syn35FyMTkLlIp/d83QejSwkH3TcNlVpCxN+rXX8sDR2gEsOGPfbFyaX8+a92/LKEk
 V3Whtrx0Xb/0926Iws2TxBxQ3l9eV+MROgm6UZDHAggksvMLmaedCz3/6LC/8YLBGLSu
 PWZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHaZjomSyEY6JjjgJ/XUXg+DOyQupZixLoDNSOxgWGR9yER/zJPnCpq8oUiO3yz93QUMdm63ShnwEk@nongnu.org
X-Gm-Message-State: AFuF++k7hBcl/4VIvMDQ9PvJh78Bis7eJfi0zSDHUoP87RjK4Vi+drvA
 VvrLVLY/DGQCtqgWEdgjJOWDq9MnnygRlohRHaOC99MhAIheJhiCjNzGo0ieuoEg87aOvOeVhBk
 uQUAW/sk00OpB7gj03fy4M0IBnaCOzzCWI9yuUtyAZ0Z527NOw9qh9LUs6w==
X-Gm-Gg: AR+sD13Qk3rmH3s/KDKoMjt5KsOoEHQj/FjEkpFML2Qlr/tg8nKJ83hyaBMJVNphtru
 zODzrCJpFdDJZJzp48/tZRLuZhFuHzOvVudiBwLLNCAVu2qmpT1Q7M2v7pDygnacL2HKJd3gRF6
 MaVHVm28IGiKE7QuDxKtSFXNWdM836I3pa5vLM11YtaEewQSWB77lq9rEN18/ciFCjWWj59DCkf
 8McqW40oUdFF01Ymm02DnsQEqDLazEsI+HFqD18ovDmOmQff25X8aBALrULgkrao1HeCCIMYn4a
 Drhsb2LDfLlrzK+/5MguXBLFUjt76LawIKirbNkGJJqJj+J3S498VBqut4diZQDKhjpnH+45/Uu
 6w+d1+6yEXu+smVyuHXQ46j/nkPz5G3NV8Ef1TwJOc7r7QgEf
X-Received: by 2002:a05:622a:6106:b0:52d:c357:86b5 with SMTP id
 d75a77b69052e-52e4234d4ddmr88700091cf.20.1787767734016; 
 Wed, 26 Aug 2026 11:08:54 -0700 (PDT)
X-Received: by 2002:a05:622a:6106:b0:52d:c357:86b5 with SMTP id
 d75a77b69052e-52e4234d4ddmr88699251cf.20.1787767733549; 
 Wed, 26 Aug 2026 11:08:53 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d62easm624493666b.6.2026.08.26.11.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:08:52 -0700 (PDT)
Message-ID: <4af5836f-c2d9-4ed5-8e6a-fdfe7ca62df7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/16] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn()
 object props to class props
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
 <20260825134320.1039012-7-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825134320.1039012-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HocYnZGyUXLOuOPbNah-aJGw-y-CZK7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX/fVvAXJni/Ba
 KMDJAhW3G85kRFN3ZCtNu60JcKT/qBR9mp4kd7uCcx/j+SoFa7hCFUXyttTxQeLov/lIejcerX6
 EUXeM9UBm/cE3uL15GKJwzf8oEPYtj0wIcgiV6ZMI1FUIPilHhRCf56bx892HbKdGca7TCieFIs
 D7FjNcsBuIHofjPrsnxG2z9vWY1FOl/ZKA9RtkVmNWqMQ7xl4DsWh+TM2EC6oliyGSurrHOm7qF
 euHYptgl+M2jw5J2tUXNjqV+0N6y52r1wGsQA9KMAnio5NLUoEzcOh5xGOhlzZnoISfI3jvEeIX
 0RLgGBGuy1cc34ZvB7oYZw50OfxWaLtkE6FG7LSsAGcW+mKeRQuH3AqwYo+agYmXc5y9l4sLWFC
 x4B7XJggPMNVxKzAm/kTKUhemQ/vvlh3jRO/xgAbFMHDJMgZFMBKAJxxwBLnmtdKJBkVPsKfUJH
 gbzhgerLDNjTerwsx0g==
X-Proofpoint-GUID: HocYnZGyUXLOuOPbNah-aJGw-y-CZK7n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MSBTYWx0ZWRfX0VvVuJWw91Zw
 Nj2B3Ubz3tStbhJcubZTHzdACS95aqixOVIIfOn3UBiOHBgdd77vbNscftuKuala99fKyTYcYC+
 u+ir6akHyV9QZTfCHuTO8qtY7yzM3Y8=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8f2bb6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260151
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

On 25/8/26 15:41, Mark Cave-Ayland wrote:
> ACPI_PM_PROP_SCI_INT can be updated to use object_class_property_add_uint8_ptr()
> with OBJ_PROP_FLAG_READ, whilst ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be updated
> to use object_class_property_add_uint64_ptr().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/isa/lpc_ich9.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

