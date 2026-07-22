Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121BFC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVkl-0007m1-58; Wed, 22 Jul 2026 08:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmVkY-0007jI-M7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:08:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmVkU-0004lV-FF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 08:08:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xMsT412355
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hZ00FU2q+5o6KK/0+Ek74PkBK3QiatBVtQpQCrrtX8E=; b=OTOWenW9dhvebydl
 wXwrIbzeZE3EVgbMXJOKxX3PbaMp6UhtOAnd84JlvF/Da9IwGY/CNVVVeJgfTcLK
 niOZAR/Uk/+0Gvb5O95XE76B8L4JKkH3oKWW5QBxm1rHtLRUooWwR9BfTSpIxsYU
 y71mIk72e4sudw2/Cc+Tbd31XYkVDdaHZyXe5jKFAiH51pl7q4ck4u901Dzi4V/d
 v/PPlEVhxnhRm3WsAH9mOY6piKjNssms9491JpA9mRYWklRoSLsxANj53+UgBicI
 91VPZWGkDMQ58C4oCmtj/ojmpuZiXX65QJoiw3SDrHPOcxfuFY2AJEwzZk1MY5/D
 v9FwXg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjpxdhrb1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 12:08:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bff5c7035so152834541cf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784722107; x=1785326907; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hZ00FU2q+5o6KK/0+Ek74PkBK3QiatBVtQpQCrrtX8E=;
 b=dr9bG5YaRmP7CaFBhx97gbLuqhi1gkskevp1c4rZpgh74sz2APo1HraDZnjjeQoQT1
 QlG7/pdazmdwCwcMSjkJaLkMWcRP7dj2KkbBWS0d61Ob2WoZifR3021NRA5XeIHURhLg
 Q0g/TKDf06PI3saP//PCqbL+4eKsdIwZjD5qv24NdvJhlNHkGQmY40xFpLlcrqjkQc5M
 v8xhMOZvxi6tX7fqFvA795oXyafbltVINHqh/H3nL4mg/c7u47ZvjP3yWxxodhDdhaZM
 ZoeyB9UYiDtxDVX9WvBVCkvtHPnIyU91p+rRqyWzkWUDCbt8UeKDkHjVkbdhXLKspHXx
 lg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784722107; x=1785326907;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZ00FU2q+5o6KK/0+Ek74PkBK3QiatBVtQpQCrrtX8E=;
 b=k9HcKennmvIh30XSmZju/tZVK9iztB3/QzqOfdtnM6kWqLw8WC49kX9/Nezm9PDRMt
 nLPZNXZtHaBay325yJjrTjL+AxwWU4p59KMxU3TahcgiepK208mDK+O9ZRftmt67NaQV
 qgiPdKCh3AkIOxYJ5BuSkh8l5fv25jPMuFU4eyA7uWZ/92+yHVnz/ayWdSlRS5xQVsaL
 CF+0v1i2W4hXBkmPiYRHwF7F53xid3JL/LFL+uqZ5Y1LlIBYlg60ExqCO+3U8cG+2YJ+
 MRp5FHeOn8tkumUM2CmSS3CC/efKRxS3PONY0YEIm7RDS/q1oqijJwsYG6Ys5MW0vGw1
 af5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+hLp6CDT07W7mnyL9rvd5CU86DtuSz5GZngK25PLdtLczrYqeV7h52fpHkEfjvkGthjayaa+Ci/X+@nongnu.org
X-Gm-Message-State: AOJu0Yz9Z3rq8PxyYdKwfTx+oHsOOULQk5n+Pm6ayQprgIsuHvyp6m5B
 BBozv/7AJSiJQRxOKr1L3YJf8uP3gqomOJXOlSSSXdSptlnEGXiyOtEUZXpLTkiKi8SgIbOzuyb
 aodnwj0pQPaVehFORnTQ9POqKvwFddoyxtEMtxLiCXgxq2WaGzOgmeMNflw==
X-Gm-Gg: AR+sD12BrSVUwWCqSkzs0aAxKmzUUX1IXJD6Xwen5Goh7emzhV6OA9GD6bTklfhDaxp
 u0aOlD96S1hESPVo2blFvfJznlFbLsQpBQpEqdiiQa40hIct0DTBsMK1LS6TVhc8ZnXLPPGQOUR
 VCrBQ8VUYJv7mKpRZIRxp1lxGyujqCoE6cOMteptNmaqic6x0G+zba5biwJkvdCYRQEWNsiT/NI
 hzr+cqVTRKKFHUm/6sQaJLOgSYl1ioqff01uO70zkGn3yOIz4r9PPccv73MKb0PzUrGHjTMuDIV
 M7nfPgYcZQtBzIuwsm1tijbtokOtA3APVbjI5/fVpJTUq7Gmmx1m/b8vKnoZro1Eyxe4M/YL/KC
 FGqwJ39kdgag8juaYbo8hBMz7AmUQh3DPRWlyLvpCAECfWORoSM4=
X-Received: by 2002:a05:622a:4d4b:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-5213d3ba87emr226221551cf.86.1784722069451; 
 Wed, 22 Jul 2026 05:07:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4b:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-5213d3ba87emr226161691cf.86.1784722009146; 
 Wed, 22 Jul 2026 05:06:49 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f9a1csm67128035e9.5.2026.07.22.05.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 05:06:47 -0700 (PDT)
Message-ID: <ed6fa97a-6f71-4341-846c-4a98da02d81a@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 14:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/virtio-net: check packet size before VLAN tag
 access in receive_filter()
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 qemu-stable@nongnu.org
References: <20260722115008.1570510-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260722115008.1570510-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDExOCBTYWx0ZWRfX64DNkFle34hs
 h9HN972lEl8uBZOhrsTFGzBU04iM+jLgS1eR8gniS2uRN9LaK5wc3voB8XPCnjZr97KpnbOEFXx
 dO16Q0/vqhoatg5nqUIjo9xY2OIEdYjq9UmzzhSEnlkMDxV7OduqewI9g8LS7UmEaBNgfAT/CVc
 5ZzyxULCKLukPQKwxxDVUkdGxeUOpCb1pwQ5nJ+r85xMGDnJHfZdn7ZSyHmvXKHmTd3YH+ne1gP
 LYHhDeEgnaAlTeTX2mcymzI7YkLAMHt+NXM5yZzjfZidlwIDoXoeJFblOq7Y536ALv+StdaqAUl
 t5lfjJBKuwt4dIJForOX9WAOJLNBL6wbsUCNQnX+mx1N6sNs3MUCzhulZus9Z7efJ1YmnyjcBre
 uyzEQum64sUoPu6sDDKvUehDBP8CWX3t9ZjEjMjkXJq8beNgbLyRSMwQ+e7gJtn8QcmgvjZwIiW
 KtKyxp8qt95Yy/P5INw==
X-Proofpoint-GUID: WVudS_CetmP74EugcJKU7nXFKe5loZiv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDExOCBTYWx0ZWRfXyevpzEcnRubt
 HMrIEGigXz17AQOwxhrJnuzltX/EU/QP/uTmT+IJFOEOeP0k8fdkGqCb8CD5vsZtrhfOOR0UVzc
 zGBVogVB5hksrGK9hKF7YFYSbu4n+UM=
X-Authority-Analysis: v=2.4 cv=b7iCJNGx c=1 sm=1 tr=0 ts=6a60b2bc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=Od7xHPywqgSLGS_NIKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: WVudS_CetmP74EugcJKU7nXFKe5loZiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220118
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

On 22/7/26 13:50, Laurent Vivier wrote:
> receive_filter() reads ptr[14..15] to extract the VLAN ID without
> checking the packet is large enough. A short frame with VLAN TPID
> at bytes 12-13 but no VLAN TCI causes a 2-byte out-of-bounds read.
> 
> Add size checks before accessing the Ethernet header and the VLAN
> tag fields.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3788
> Fixes: f21c0ed97c97 ("qemu:virtio-net: Add VLAN filtering (Alex Williamson)")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/virtio-net.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

