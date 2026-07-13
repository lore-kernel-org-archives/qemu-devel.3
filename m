Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61320C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJMs-0003NT-NU; Mon, 13 Jul 2026 12:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjJMm-0002xQ-4N
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:18:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjJMh-0000CQ-6M
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:18:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8J5l1803528
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PKWNHD2qkQw5jGhEN9VwLK80axVLSqxGv8SY/A8ukew=; b=DKYQPIutMgsYGVTV
 j2B4bzqPaVaWfrx4kaF6dnmlSueFnTGog0Xcok5Or3WA/OGmp/5FTIBLCPaGbqVd
 DrtG6KCbvCrnpNKo/W0xVTX+tBa8OaCZjDZUk4S3GzTnz2iH/Oo0LgExGpcc+pzz
 cjY2Pteint5oCvREXCcMO/WQno9FCy7GPv4qQJM4qvyVQMt6YFShVy8PslMpZLtX
 E45uBgAezxVptxvtz4i9M7F3vDXywlCQdwIhHYijSvhfn03IuhdpHh+94lwQAmNW
 8llqwRiCvNc1HPcucSm7XeL1ov66mwhwoG8PO97oRg/wcOd2ewdLfKZtjs2wrrn6
 f1Ts1w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4sh4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:18:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso49433531cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783959521; x=1784564321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PKWNHD2qkQw5jGhEN9VwLK80axVLSqxGv8SY/A8ukew=;
 b=Nof6CG5qO1xJQEtcAL9OQBHigeNr8MEZ93sPOAvMYWGotls/33Tyhj1Khzq/TETEhM
 EwDYHfbCYzhMlen1K4D3x3TIzRYtBh9+R1/g+ibCBvZ28Ajd3RNFKjhGPB0DaZSSjM9C
 g35bAQZh+cKrPHHJ5pHaU9/yfxgI1wstkGFbxdGKKIbO+EHQxb2r8z6YhNuu2yVFC1Sa
 CZMSB3itzakupj80IdFjwVbboQQo6EuaZRMQZRsXWt5P3OwQuxUkOcBgGJ0pu8CUfSaa
 zVB6wKe7Gu/EVi3IvbQe7qwmUw0tad4hwaY8InnnhvwThyKoAOrhDA/AwlbWb87XBtmz
 RHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959521; x=1784564321;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKWNHD2qkQw5jGhEN9VwLK80axVLSqxGv8SY/A8ukew=;
 b=gOwQ87OE6wXjAZqLSOZFpTxvoduLPXbBRELpPLUT8JLgzEQpHCO5EGWlvoxKeBofyi
 2MCn3bohG818wbNQ2NPbt8T9lHCWEnMSEskj/0KueZYLKIst3AEJEMUJH5H5oiEPJR6F
 vdTNZVMSdssEV9HCEQLKPcJcL343KiIAco445jkyovFlKoAOf+0+iYgxu2p7bt2aXitP
 q6Nlg574P7UiDGnw1b3MWZ/mrlYFkyBAf1OKe3EJeXTsPqcnI74pudc5Q2wS2kKS+kwY
 F0shkAHNAxwf/hBsODu33XoIM3O+2N4q6JaK/jQhLjhMDcKYBVe4wLov5JUvg3Y0g4UW
 YmiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwtLtKUyJXSdq7+rAxhwYwoo+9cbkdsntM3CjvsRRg2T3qBWRass8+/vi0x7OvIbZPMf5H4fCOvI7x@nongnu.org
X-Gm-Message-State: AOJu0Yx3FG7SfTYwmDko8uIYdukUvc+dXqk2fK4Omj4asliUUhdMqNg9
 h2e40pmStjBsvfhST3MWcAv2Y7PQze5dWEcZoASxZDY7DyrHGqKk2UXk8BL8Ys/D6TGi8kql4zz
 INxgLQ6g9y18sHjr8n8v8DUZlcZRNx4vUpVIk4D+AEK0D+H4zfLOY574Yyw==
X-Gm-Gg: AfdE7cnmgfMnn3AjbZ/kl9V44evk6kkv+9GhSq8LwJ7l/TTix2AxhvaC4+GgcxSU+HS
 KzB+WBkwosFVAZ1rS9HazZSAh3ZRnGHoPvELazT2jJ18nrUNOGAxJtBbVBS5gqFVcXbT82XU4KN
 cuaocvjDWNAOs25uNJyds2mA9IYgRRV59tM65ZvdqyG/69UGxp/sN5/2EfoCsVOXOI04Z6IwxbJ
 +7rzDry9DQAT4wbl/FkfGe4IZgFkRoBw5c0oYFO+Hp+YHmXuZMt4C4F57oatd+VyBEzsU3b0SO9
 jTFzp+pjXu3C8T0ClHHCSumJ4eoKffJu6Pxy9nvSYv+NTGjeWozZbUz57e/fESHxuZDTboZnxxV
 c3TmGtWWUFoTuQ65IuOKiIn5YfIyO9KCGkQ==
X-Received: by 2002:ac8:584d:0:b0:51a:8945:3141 with SMTP id
 d75a77b69052e-51cbf1faa3dmr94762111cf.55.1783959520986; 
 Mon, 13 Jul 2026 09:18:40 -0700 (PDT)
X-Received: by 2002:ac8:584d:0:b0:51a:8945:3141 with SMTP id
 d75a77b69052e-51cbf1faa3dmr94761811cf.55.1783959520553; 
 Mon, 13 Jul 2026 09:18:40 -0700 (PDT)
Received: from [192.168.0.138] ([79.127.134.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15e353d2f8sm643488366b.34.2026.07.13.09.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 09:18:39 -0700 (PDT)
Message-ID: <fe431b68-d60d-4391-bbfc-22a75d25f323@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 18:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/usb/hcd-xhci: Use qemu_log_mask() instead of
 fprintf() statement
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260713161406.361197-1-thuth@redhat.com>
 <20260713161406.361197-4-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713161406.361197-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a550fe1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=NafPQ6+GGz8L+AY99u5vTw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE2OSBTYWx0ZWRfX4RY8J8JaAQQE
 mZzzrgQLz/RVsJ+0aiQJWTBP2in9YU+EO/T0zggNfQmj/xB8QOxnSGMSUrX4cTBwnH7fb71DLrJ
 4HaHwAelf/nGMgRI/Mgl7cw6a1J/BBw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE2OSBTYWx0ZWRfX0FDlDE7j5L21
 IuBIBzVwe2H8o5RMYxJKzb8F/FLM8zdbUmSIhf0siYBVdez3tnGW7BRvJZVrwzoEZ+N56XaSDEq
 qo/St4FE2vLIWNFkWbEBbKfKJ0xb4GXUTzahzeVSTEVMbhQWQ50jcpsIrSb3vvCrVFeN0D/sLUn
 zkym13Rwu9sb+/SmLMZ3nD1Dou+drDkmEsJ/9u4o3UhQtPBZzZ/Ql+zIkoeO/Gvd2C/VhtS09dd
 fsciRL2OTVotw8LxBn3i5hT2vKomQT9wbJs1ox+NxFNeQDDiv+TxJIw5KaDac/kfFsBi6UROLm7
 8SdXX/sD0Mc1Fk5tnlMwJm3SStecN8zQiVFqF59VnjxR++BlfSwdZ/0AUZxJvK1UY9hwEL9zjUi
 Rm6Jo/kKxxTYifVrflbijwWLhcRGflQ9yJ9nYWbBJqdSo7CoZxK/B3qG7c2LHI3X5H3E1tC8khS
 jFJFgo4aT1LvhQApGMw==
X-Proofpoint-ORIG-GUID: Hb_Su13rJIbI4vs6a71OFuS_mwGr5JUJ
X-Proofpoint-GUID: Hb_Su13rJIbI4vs6a71OFuS_mwGr5JUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130169
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

On 2026-07-13 18:14, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got a proper way for logging unimplemented hardware features,
> so use qemu_log_mask() instead of the fprintf() here now.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/usb/hcd-xhci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

