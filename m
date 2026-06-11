Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D88FCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdV0-0001SW-Ne; Thu, 11 Jun 2026 07:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdUx-0001K2-59
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdUv-00016z-77
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xRkJ174135
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tW0vcV8YamWhpQyUKXazyYRUV/2W8ZpI2T0zA2FSpJA=; b=LpphJ54jL8xelk7t
 Wk09qjSecTatz/Ro+D3/+EBSYEALabUnR5Apoj8W0SMfVahQHKo1x5f3gj0DRwZb
 YzB8nw1hs/ISHG+rCfBpV+XHCgNFvRVDwtDvKayXvFLkLfrBt2M60Dieozla00he
 wtMqISaABI9O+UIWgpIAAdZDLANbplerTrr2tgGUUT9dGymMMciWt3XQmGYfG0Et
 sVLdkL+FCJ2Sz1qPHEawstTlv9CHpkC5i2mopJ0NNMd0qBbQ6HUvQzgXwuBYQ32y
 NVU/SQaWWN2F/sZmYdfXvH+YxrBTWav0br+Fa+t8tNzbMsFgnqQS7epu1P4CQGL/
 Tt/j8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6vb2ns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:22:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51776d4355cso20318161cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781176975; x=1781781775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tW0vcV8YamWhpQyUKXazyYRUV/2W8ZpI2T0zA2FSpJA=;
 b=IcdAR95BXzzr42FrRlZS4fJ6odw42NXwoxzzjw1f8x71ZDi/5+df+3G3Uw+SFNiBpn
 QkMLGnrI72fM41sMtz3Wo6+T//Z7+D5RblkX64QLGU71X71WikgJaHEbLUHdL8gfByyc
 5g4x0othSbNzF0zx5gjSL/8HfnnlZf3naXOzi2DsCcMLPh6td2tXfHm1WMhVPj3sV2BO
 DsnI5kvwmo2vvybxWejCHVEXqlLfVGV6ItpEG3hE+kWLS1rrIMOhhCrSXlMIeoXB4aBx
 feLTtb7m6i6N1KPXEtthnrADT/D5dqPdGbYpa2icE5wGRlqy0u1qOrVDtODCQvM4/pMG
 Gwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176975; x=1781781775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tW0vcV8YamWhpQyUKXazyYRUV/2W8ZpI2T0zA2FSpJA=;
 b=tSR2y+iQKlpsFYvDOzlml2fuAD0anhMcCX25wFjN2BnL2dPonWr5Jphf5kFSKKqaBL
 xZYurR20m35vxlThPdiJWs8fEwoa2hzTlRRvXyY1/nMWLT58NgpPurrP6NtpqdJQpG6v
 0fZC6f+x+D9IwJC7Nwh9sz4Ms4cgIuoNz8dL5a9QrYFbq1RJkwOotF/6EghpaSgZiZ3j
 /0i/PDx+oB8QUmCpCGSgUF4dKI2vCAr/IhAHF54BT8pb//oIG0X90TuCXLIIqjkN+BAW
 ifL8/r0FrpOnmUida/HKas+zyaw00zxJjWhi7Q1LMYzVOZrM5ZNhEyG6YkP3bLXs9NJN
 EyeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+geF2VSrMecOG74aW+xIhw+vbKbUqoBpALlBcULATj7lZy627XmuiIrBxdjKQasNSuenbC8qpx/SPi@nongnu.org
X-Gm-Message-State: AOJu0YwnK1i9wXR7eL6wACMMX+XJ/cl7qpUwdZhYdZtMXYFv74i9QCP1
 r/Z1ttPr8fyEE1YIeW6kFHPviCWSvwd6W4jS7+wwxDlDK3TVtqYE3yCMd5Nn4l60aDQ+9iTt7/b
 xKENtcoejw28zYQPZvgSbO5qBCF86VbEevCiWJxpnu6EK3E1NTDO9+1w2NQ==
X-Gm-Gg: Acq92OFVw1PhC4HoBD9+a934GgZ2TZK+mkcn/gxrdkz5f+JC0bFWXtC01MYktcmxz/W
 xk1RPeETq37LtVsXH5BfX+256a8WicVnnORs6bp/6sbPHWEB613c12Fy+jTgsP+sKQU60f1lris
 BRb84mK5KYHMT5LylTpj1dKgfaX6Bh91xSe6HYYE5V6sAfn7XyzvFXg336adu6/6egs64qspdKg
 Yi80lwfnhgezP0rncMhQe6ZZA2zlK83o9QqUQtcO2aqh1nNwGd/ST6u1XrZfyOtoht2fJlSQTpW
 +pLkxTuKZChtp0IxNB9rOZqP71RXbon+65vrBGeSeYrrPboWYzKDmgBG4M3Ta2RP2K8XfBspQjg
 rug1ewIuEhYBhd+cS6wBL2tyAgoLtPp/DLcXX6s/1qYb/pW1UOJocg4aknDZU87nqg+CJZoaSZO
 buPSqv4JovJKQZ
X-Received: by 2002:a05:622a:1394:b0:517:c582:9161 with SMTP id
 d75a77b69052e-517eefae2e8mr23319321cf.7.1781176974789; 
 Thu, 11 Jun 2026 04:22:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1394:b0:517:c582:9161 with SMTP id
 d75a77b69052e-517eefae2e8mr23319001cf.7.1781176974339; 
 Thu, 11 Jun 2026 04:22:54 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c907ddsm57321985e9.6.2026.06.11.04.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 04:22:53 -0700 (PDT)
Message-ID: <e9403bd2-b50d-40f0-9f1f-b4100334860c@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/22] hw/input/virtio-input-hid: use
 qemu_input_handler_set_led() for LED state
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
 <20260610-ui-input-v2-18-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-18-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HDuV0HGgqwlRcD0Se2DICF9RYMcx5hol
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfXzL9cqROI/eHE
 gps/k/66vTsTCIktmJ70Hf5KjJ8ZGVhFT9lSjAowt3qnYsk65+PFPmm2XF5LLybzUtZGp72W4YB
 EUqaioO3rx6yZj2YqwCnC4uoOdHFga4=
X-Proofpoint-GUID: HDuV0HGgqwlRcD0Se2DICF9RYMcx5hol
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a9a8f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX88nPV3UmAUBs
 RdGmFVupJZxRaI6T5WqLOLzC75fqJqLVZByuS9UDIh7WMNCiq5Ym+hUjm3S0SaK6W1d62HD24ih
 Orfz+cypQIlCj5ak0imLYVB8hMHvwQix/k9u2rjxqqN94Ouj+WmrF37NvlKUBHxz9Sieh0RkCTG
 uvbr3Re3HBJ41yN1BbnBw+Tfx3Tc1EPiyToMaWPxGYFc1pAiB3V2XpIn2gctlyKSeDoMLYoGFgZ
 GGcyGGaqum7F9oHt6KOw3sQ/5vLPKaN1Og3z1LTROKyzekmdcvTrSwLCsHXy66Te1Qu2pTc7LNF
 j3TINtknna/aVa+i4tNQBxLGV7MaikCQdnPKFyDTQ7aiyEK4aYNi84kZvCMAMXie/BHeZ+jlH0Z
 du3+492Cre2W8JAJTebwKFUTeGfR4irsl8kfTtI9001BXq2LRgiQ1wgXqXquvb1uBC8OQ5X9MWE
 JyblldALOk8nZgbrrQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110113
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 10/6/26 12:57, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/input/virtio-input-hid.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

