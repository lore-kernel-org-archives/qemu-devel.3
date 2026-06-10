Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708FBCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXH8A-0003Cc-Oy; Wed, 10 Jun 2026 07:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXH86-0003Bu-SD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:29:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXH85-0007dz-AT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:29:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ABNgOL3657961
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 okXBiK4eKvcq4Rk7imeR5oQ1kv1MyaAvdTZabkUpJYY=; b=hsnkE9Wth3O6MRVD
 7uynxJhGIpZXRAfoc1PRLIYxidoS12JXHRLiKArPrqb6e/gQ+HBc+gpolumznEK1
 cqWnfcoZk9dgnFMQitHsr0N+y9sxnkg6P9n5m4r8oR9BWSX4yDxRQgpUe61FVVCq
 JrMoW5BRIw7VrY0Azfr4XnNwEp3x30oriLpTdF6ClFB6ezt+pJ8Mn4IXfV3MjVQ2
 kfzoope6QDUOo/VyGcqm4FrT6gQ15YvyCp9g5VeZlWDcvbcCRHbLvewZfD9JwwlF
 iIDmLXdH0zrorRV3FMfUZwzNnFP13KrHfDPXWmYWX6u1Ma0WulkRiHfOKs4JMzW5
 bR1KFQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnet7vt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 11:29:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-517c65e497eso12568211cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781090991; x=1781695791; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=okXBiK4eKvcq4Rk7imeR5oQ1kv1MyaAvdTZabkUpJYY=;
 b=HMQMbI7ItHv4JECBvkKGxaWRRI7mHcYQBkvr71wvL2eqmsOxfJrnCEw72nlBeLPigN
 v74Vw+hPnfv+rGht5nydD0la0LMnrkqpaCgc9lxKqmOpuWIR94RZUrH1GYcxQjxKk/Wz
 LCE0Dcuv2wEybEdSxLi5bB7AjAzgCtE4vlJIs1v17CIgxuimzzL6C3Mwogf1p4lqrUjt
 38V4yRHnkIlOLfdcuBKCO8zDafeKFcT+XsyzCWED8m8Ad+4r/h0cVWTIct1DA1uYz5fV
 ntH/rVnrcZ0W3Kh/3vZoibjdwBaLsujE9GkVtqXqOIsdMySQm1UGq0sQXkn4mW+xxB23
 RLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781090991; x=1781695791;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okXBiK4eKvcq4Rk7imeR5oQ1kv1MyaAvdTZabkUpJYY=;
 b=me0jel8dbgNzyQoWQycoNsHgLVzxGx7x0v+WETA2pi3gj3mbHB78fz8HZJVgalJB+C
 evrNIeOMEBk7fyO4BIL0oDR5h6aOX8TVrvWFqYj4/62mc5/Svw1sxWPS0UvKf4yhh5CB
 OYWx9i8FH3AaJ2BdY5zRlf52KQFahj0naiGXsdplU1qiA8ATEWLsvy6PnHGoiyDZqp4t
 WX7/D8wM/6sZQPemXOJouxihTes2toYKf6Fubl3u2RD+xfHnx5AQPx35j1+D2sahquZJ
 EZ/HmtKrK8txh/CHvtHunvGtzrL/HnsRw2Z09WmGhxdNsfTBbyOBzsRSiV8M7nMvN9JQ
 4WaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nieFGcQAquiZw4eoyavtCCIcPmk0l4iimhLy0pd4KeiKgO7U9WeW64g1WINcEy+pn/V/ZBJlEVkK4@nongnu.org
X-Gm-Message-State: AOJu0Yz+MGZS1baQftahiZNar4C2oy7l0vtyDvMgW54tQfFxorB2Erod
 MiCEC3QbNL3OsYaRjOX+7RVPQk+6xwPHuEB4oW61nNKxIcS6QeJszRzzPPk2RtnowCrdPhMuMRB
 BKQ3iH+dXHi1bHmGEGIwPDlJJV3ItPC3TXllx2IOSsWkGaS7bJ0sli3B8UA==
X-Gm-Gg: Acq92OGdN7UqXII7b1omvzXr8g5aWNHkPx6Az3b78dMlRWefMvWBcL2EkhvsRxdyH56
 4E6zF2+YGnvOFbQ0CUXFErmB51L9/1SuYLMiQl9KrDkv3PfkqdOixxlKw7XBuYTGlz1QgjXqt1D
 xzA34zbYbvtj0jkWnIBaVlb0K4eySEavMHFr75lYHuz23FfVqs2e45bDOUeJ2UnTo0ofOBdkUKZ
 aqqPR35A4FVp++21ps0uiES9Y7L8R/QiRcraOWX0GvBrB7tKIzjjjayUMxZsFJwAleUcSphjPn0
 B/mZG3IzNxSPQ8WQHusJw850+bqQbgI+0jKecC76oSO3st9T+Vk3bntcKOT6+TrnjvJI64/P1MK
 5OKCz5/4zYnItEVDv2Mx5U4hsesd6KPmKfteAdhH9mNN6AJ5Pwcb3CYHNxAiGD+n1sbDjiQ7k/0
 qHuEQ=
X-Received: by 2002:a05:622a:608c:b0:517:8242:5bc1 with SMTP id
 d75a77b69052e-517ca552787mr97935831cf.15.1781090990963; 
 Wed, 10 Jun 2026 04:29:50 -0700 (PDT)
X-Received: by 2002:a05:622a:608c:b0:517:8242:5bc1 with SMTP id
 d75a77b69052e-517ca552787mr97935521cf.15.1781090990622; 
 Wed, 10 Jun 2026 04:29:50 -0700 (PDT)
Received: from [10.156.84.244] (49.170.88.92.rev.sfr.net. [92.88.170.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e05199sm1149115266b.29.2026.06.10.04.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 04:29:49 -0700 (PDT)
Message-ID: <efff6e73-c922-4431-b662-4fbba7c8b92d@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 13:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/22] ui/input: remove double-notification on
 qemu_mouse_set()
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
 <20260610-ui-input-v2-7-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-7-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kfM6PTFDb1l3GVPspWJ5bwnn_MQbtoX7
X-Authority-Analysis: v=2.4 cv=ebYNubEH c=1 sm=1 tr=0 ts=6a294aaf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=YLXAUxGLE6hMr2F5uSHVqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=GW2pR1Yr4Io_S7K71m4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: kfM6PTFDb1l3GVPspWJ5bwnn_MQbtoX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwOSBTYWx0ZWRfXw+nXwBIfF4Ft
 y9RMqChVJti+4w5Sja2N5jAlzt/eOJcuU5h9K35Rg83DSoKsu3mNhEPd4cSqhc4MahKDT1AxAZV
 qLQX9XbMOavBAy7CNR6F0lF6SHgJo+qVPULNa6aOORoIPrcxfTNOfxqTuun6wfPEJPIL6dW2H1q
 fJyPEAWHkyedxJfkQ5ZHAUJi5DCplo45iWT0GmpFJtlHw5lvrX690npEb9FGbJlZRBQA8DUv40V
 JrR4bgqZ1Vad2V9PTbRMq+bq5mYieKkc93DLFn/SMO6QjBb6DD8IsAM2LaV+JQlHaa3fyOXfM2Z
 gByN5XTmdnmLvgN44U+P6+0xyqZ8cGP8slLYHNyFRjCPCvJTj6bobPqTRY1Kpb8mNRy6dmoeJm2
 zXGE4KIq7gUOwQeB8pCoEIgSodxobjMNul84iCruAcEzR2WU389ze756230Ij69q2j6vYtYdRay
 Fe9ydY47qPKFjv3D7hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100109
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
> qemu_input_handler_activate() already notifies.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/input.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

