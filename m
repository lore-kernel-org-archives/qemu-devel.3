Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEDCCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHEn-0006mE-Fo; Wed, 24 Jun 2026 02:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcHEf-0006lk-5B
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:37:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcHEd-0004Cb-Jv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:37:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5u7VS2262249
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 axBoP8hpRxlGK4WUoUwgUf2lYDldC03wXGfKmLGGW04=; b=hlErWj/1xQGLimpN
 s0oh694xxpQIzE9IpGFAq4iKtZSaRAvP921VZD/X2BwbXk5wrTWg/xeKk8iJ33ep
 0A38sJhzQqv+QqPyPkzyvoidbFdlm61wfYwwEMY4wHE4UAMPAbC38A28yw/hRUSL
 L7BkcSA+/81ToQbGMwQ0v5HOGYxsJE5KZBsqfYmGQafd7QWA0lEqZPB0VwnJD6Oo
 x3hv2yyvBtyigWoy58FfY+Rgdafq+nH8fhfqj0TBXIumwCdmXxceeR/ZGNr8uq0n
 PSzSYs87T8LlrEW4atg4pKppa2CR1yGCpGOD0rInOeTa3caxhC6j+WXiCHLbW2Zw
 lUB/dw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yv560-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:37:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915c8347cd5so126432385a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782283037; x=1782887837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axBoP8hpRxlGK4WUoUwgUf2lYDldC03wXGfKmLGGW04=;
 b=STh595joaAOGZekPw/hl5cwdpkaL0NvfQFLnSUoI3XlQ1PmrRTgyg3zZ0NZdThx70v
 A3bt6vFZVvpfd2CuxPPwwWTqk/H+mthLwUNSChnKiG4jNbmMvDMa6b9mNLfHT2rnU51e
 xRN4HTg8opbVXM4aMD/GD9t3J6aTAgb05P2uZY/M0ET9S4e7QPkvpjSSy/wZjnBonr7i
 eGdg2Ok6AkdVO4w5Y9s2wV8JZefVd+8PqShhZuurEK404CKnfgMp8UDJ9v3j5wZTTA5i
 9CzdxuxZIIo1m7sDcFcrjnp44M3QTDZtLt8SpaGLjmHp50maaSDqFOBHQxnPlNDpC9Gn
 wExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782283037; x=1782887837;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axBoP8hpRxlGK4WUoUwgUf2lYDldC03wXGfKmLGGW04=;
 b=GCWk5XEE0BOFd6B4R5xJJ/7epLBUJaPH/y6KvsrfD7EhGmY9OelSn7c8yDH2b+ZSG3
 ofHrACJ8GrhfJFJde/xPhMSxtLNQTrjDOSECcywCCH8urBIckEdlaldF6prpGu7hqV1D
 IHem18reWkmIinS6KN0bqA6UInZqZmSjrJ+jf7nz43Pt+6g6/Xk+zN44iLgg93lSMZXs
 V4r5poTxkf38TcFtYwlMlOGWls4/tsAepiODOR7BMPtQBgM4aJQS2fy44/ITYGY2ptVb
 VKku4PfUHdgHVVD9TznuOeCnLBN1iyxdNpBg9EcwQq/Igt0ME1JI7LN7MDaCoKYqLwV6
 XIlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kby7ob7GVYeBNqNBNiVCB4N1mURo2DQuIu7ExQDYep3PFIlWWf+TB2e/d5K3lK5hzKqtJMNf9wz2o@nongnu.org
X-Gm-Message-State: AOJu0YywbIC2+k9UiS/mqIshfu+UGm3ruIAhzQORA2HbeDoydOrH/WFp
 fYV+5aEGpAd08/iGnEYGQ+g3y7X4pVOH1JiA7BbwHlrXujlfaB8xPK0OZO6Di8r+u2IpygpQNCg
 St63pyWzefrIQJWDbFmXMApWZLwNZ316sbpO3fCapwVnrKfkvzT5ZoePz3Q==
X-Gm-Gg: AfdE7cmXohqFyB0Y2+IustXDLqEJslWHPd58OWqn4rqLdOQMz3Y2yy2MkF7jvH0QocC
 IHsE8kEwbUU1EwzG6KiUL3JOP4YhePl0nFFKcLKFHSKDK02Cwq6oLkCZFAYFLyh67DwhaV8Cj5R
 texzp132iyWHUypcEDtb6K9utHsBLQMmjU+uqnx/jh8ddK/XwSy/EkaRpGtF0LWs3YNtfPZ7lY8
 cxexTZrKz0A1dhlzfLJy9BrnDqWqjtJ4WofnoP0oHIvdj9Jhyb0HSXLsiuUk9waAvTcM8T4FQUB
 xBtqWIKQRJ+Yi4VBePmnBsOho9ClEcSPt+g2Xws7IejIUkPR9NWfuVyiiUTvOIW7W3OQ//Y3DOi
 yT02hB0gQdj7LU57cLP5zxxk9+70ZJmS3S9j4+PMfuaCnfRjJRYgRkG+YhmjUeQ==
X-Received: by 2002:a05:620a:40c2:b0:912:8fd0:4a5d with SMTP id
 af79cd13be357-9277f1f4f11mr365453885a.55.1782283037102; 
 Tue, 23 Jun 2026 23:37:17 -0700 (PDT)
X-Received: by 2002:a05:620a:40c2:b0:912:8fd0:4a5d with SMTP id
 af79cd13be357-9277f1f4f11mr365450785a.55.1782283036588; 
 Tue, 23 Jun 2026 23:37:16 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c680fasm3915521f8f.34.2026.06.23.23.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 23:37:15 -0700 (PDT)
Message-ID: <79339ec7-bb84-47ff-9de3-1dd1692fd787@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 08:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL 27/27] ui/sdl2: Set GL ES profile before creating
 initial GL context
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
 <20260617-ui-input-v1-27-79e9aedc5899@redhat.com>
 <1abc987a-a077-4140-8aa0-df67e298d038@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <1abc987a-a077-4140-8aa0-df67e298d038@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3b7b1d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nQfwVWDWVanOvruN9ssA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: hTPcVAEgQL6HhEzwAUFfjuU40zSiAE0H
X-Proofpoint-ORIG-GUID: hTPcVAEgQL6HhEzwAUFfjuU40zSiAE0H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA1MiBTYWx0ZWRfX0I7w8OJogOQy
 hIPDmE7sRCNqVeoHEcN1eqYOX9tPFBKHAh4zuOrBueMx/gHn6eyWw933I5626iqXRi4Iwm2iSpU
 a/SOsMR6LQ758nYNe+fm7HYNlQkqFJyRwNiuNNEBDyuMQnQ5IEWwRS57LiaZh72D5I62j2720FM
 WIq/Zx8zGVeTJbIx1TB4BdlnLHv68GCbtXUUcV2tsN5ZmH38gGqIZx9ebaU2FDDot7Ah1nRsgsd
 tsm2sretCzb2Rfisd4tXD0lt5RFCN7KeC5HQ/rJqO7s7TkJ2bipWZ+YH3BJQr8aqxi8d97SDUrm
 M4NIPVQLSC/rSD1nIAx5gUnQaKdbcdpbMg1xwrek39QYIR7qkSB+DsVuO8PwZYQZQUGN536MS/s
 k88A5xTJKchgt+521ikBxyKR6BkibU270srpiexyaLkbLXxdv++eHdiyCKetSSKZgLyELK1leVG
 70nqjlOmjUTgK549v/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA1MiBTYWx0ZWRfX2eqN5+5ZBgBC
 /L9eIQ2gJmlW2MOjIObPRFGKRFVyaqmSk69wE+CAMzz/u1AYllkJyd8BWfp+E7wgAzXz281UWMP
 ABXhYkJxZ2EqkaVCFC0iQPX+WSOAtcA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240052
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

On 24/6/26 05:19, Michael Tokarev wrote:
> On 17.06.2026 18:23, Marc-André Lureau wrote:
>> From: Ryan Zhang <mailto>
> 
> Oops...

I sent a fix:
https://lore.kernel.org/qemu-devel/20260619071422.99061-1-philmd@oss.qualcomm.com/

