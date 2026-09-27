Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31920C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAj5T-0006BY-Qk; Sun, 27 Sep 2026 03:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj5R-0006BI-SN
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:14:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj5P-0002Fl-7z
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:14:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QLEjpw1233329
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hujGNhOWnq0Pub9WYewT/XbgC8SW6JQbnREaVbDqhQ=; b=DnO4trR9h0LUX4QL
 eD1jst9HGFc6gIvdXlVJx9fhCIPx25B7doIbcIaY9L5uutJhIVXUzBjMbtBoecV3
 wABXlwAMK1YeTkUYClO2d2JSXf19Ed5aqcKInLJxQahOpr+01N5K/IVzTkf9Fvp7
 wg4esNAvfZ09EZ9+D3LkkzZ27JuVhS7pcXEZloYKM2IX2ZraMRgjX5Nuk30aJM9s
 nkDsnkaET8+S8OEM8lF82uXJGHys5oO3LTHcLs9MCUXA4o0o/NajTGqGGQZZagiR
 stBVxTFbT1F0GLjugjqxHR/8PudkYhBdn++vO/5qu5uHsgPp05CD+IXcIs3m4JIz
 Is0oZw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526jkdu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:14:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0c7126e7so398243285a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790493247; x=1791098047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4hujGNhOWnq0Pub9WYewT/XbgC8SW6JQbnREaVbDqhQ=;
 b=Z3kMFZfAsBxc+FrdhMjiMkEhUNlhUwrVYNZn+q1kTRqdYSJlKCWJfX1d0Ii+Cd7zjb
 aK4PiyJpPTLeG3/Vu7XePpAk6JdmSpqVph7dPw282Qk60QxZbn5iQP89yQ+CgPfS9Y9J
 wQGJbQ98xwumjN6uPa4uZec1OZNrLI5juI5DtTsNoPo8OJtdYwkOQdWM5tNgByInP3EA
 r+WS5rpTdd6UY80rs5F/cPfWl9X+kcbIFuKzXVCbim/XYJbWXk2zUo+uyzThxyKoxwRq
 ZL6oBbniIBXiBr27pbLc69tr45P/WKLAnzQW0e66fdU8NlpYcYFJ68PVmE1YjMt6LYrS
 I0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790493247; x=1791098047;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4hujGNhOWnq0Pub9WYewT/XbgC8SW6JQbnREaVbDqhQ=;
 b=IcXak7j81urvJ2Yu2ldl4EtDdx/OXyzVgkFhI8lOsSGjNWcGP7MT67kMlgXH4QAD1Z
 7bEgSBjpCBM7pF/7KZRvKR5lev3B9aYVtagvx79okLpyIuhtu113hihyYiBrxuFEewXr
 VT/Gwpjki/DGOHgYt6ND/uKe2omCxjfpXgzwqEC+AaObNu8SyNfe3GdP08FmZ5VXc8Po
 ojbrgpGKNycxd7D3x6BCV2OZtBEnDqRFueA8kLywAcKxEn74BtzJatISu0FudUmpEmiX
 xZlcBN3ngcYLw4rtDfqwfRykZnz7hRoOKD4wCg+exlfi5tY4iwGcpeLaY0XjyDVSseXQ
 dQNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk+DC5ZbO6igPQ55qmitFsUAnceIOjHXmBa0rau2b4YDUUg4VHlOfAr6A0uggZkhIkrb7J+6caPjsU@nongnu.org
X-Gm-Message-State: AFuF++kwZ6PCaw2dqKLwKrC+bJLtUBg8uiA5lVd0LxQjm6d4gQx9M4bZ
 Bb4/QkX3M6O+J/HhplE2Vvv02NbULaIuyoNiuvyLYoNhzfPwxgNaywRnD7RROWX5uvz6x24/c62
 VucXNxbWonRir7CFYYSXErnPXoEX5GvPSA3ABcJJtqDb+J8otoqx+X+5dcg==
X-Gm-Gg: AYBFou1ouAYKB/sLAHvQCGsMSkPeWZp8jJGlvyiWsLRpP32DOQ69u5N4WQGnvcA2U6Q
 1PrxSURlAnAKTuazmorZEGc5Rt35BaF2PivPT21CbDtFNbVqQs79XeIvaeWDI4/5+nClZcWfEuj
 lClWDn8eAmAtxnQTaoC4ogxA4brJ5thMLSJK43TpIlcYlFOa8VoBjYI8HoFBj0wHIRJLyHA5+jz
 xds9wH8dY3hSCOO6II05zQTB3+2M7HeHP7CXyb0SodxP1Cw64aGZq0CiAFlV2Vk8IDDg6cRe6N4
 sO+cF6Bh/P+G3cUjLcVTzzHmQRmK9kSqLqi9mQJM5uOpdHHnGz/n5OvwhJpkxYkUqXHPxk97AFe
 WPFj5UCImYHVffOGJ3RHFI7mJgyrLMMdrJA==
X-Received: by 2002:a05:620a:1a09:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93c43d7a705mr1317840185a.66.1790493247518; 
 Sun, 27 Sep 2026 00:14:07 -0700 (PDT)
X-Received: by 2002:a05:620a:1a09:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93c43d7a705mr1317838185a.66.1790493247065; 
 Sun, 27 Sep 2026 00:14:07 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0019057cfsm43212955e9.11.2026.09.27.00.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 00:14:06 -0700 (PDT)
Message-ID: <aae26d79-f20f-45e4-ade9-74eaf5a47d81@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ide/macio.c: use pmac_ide_transfer_cb() for disk DMA read
 callback
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 den@openvz.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926074425.468348-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab8c240 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pcZqCyVeAAAA:8 a=IwJ3tlH_nAB2Dj_2-tsA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-GUID: S4AyQS7Lj4ibCoYCaRM9k69oPhrwq8GE
X-Proofpoint-ORIG-GUID: S4AyQS7Lj4ibCoYCaRM9k69oPhrwq8GE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfX1Rlp2+hPHxPl
 1J4g26vAJA3AhWrngDf+1DqHqm3pP+uUzlLkFb2Hbf/OEks/yLy6xO/OZk6TKdGeq2kJ+TI8M7A
 G55bj0ohvlPI+53atZGlOXQrLkYic8urFSv79j0Hda/Lo7okuiSHGDE7YyFi48eq4+rvxuWRyxe
 sdcPKqOeMjN4HsTgvSbibnJg/Yt0HIUCjGcqKtViImxNcEq4aDf0ZYpGtZbA9rEZGFadPYtVGYp
 fzEgkAdzKiQEtX3NxZaFUdN2PSxjfgPteBEJKJnyBOb8jaOp+JyJGI9bYkikhIu1N1atkpj7q8v
 HH9PK4E9jbOyVzTg9WOqAo4GVaFxZSz7dCFsJQFdHM6f2jjbkw5kIaBaSJlqDpdraFTya8/ysuT
 7tOMeMSjOwquqq8E/5skjXUhYSMiI1zAezs4wrGHzEqa2LLMWyITHojFrfOw3Q6L5tvxIuF7Hjx
 YUR6VjHhCN/6llaqdbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfX3h/+6LVKl6DW
 dVGiVqNVNHwzN3JkWnsQItl5ux78bHuaq0xFs7bYSKr5TYaFr5pgg+Z4i/dpZq+e6y4MXj3SL8g
 Jf5FvOrd4SYcpMxhbkMN/JU0SEeeWN0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 26/9/26 09:44, Mark Cave-Ayland wrote:
> Since its original implementation the disk DMA callback pmac_ide_transfer_cb()
> accidentally made use of the CDROM DMA read callback pmac_ide_atapi_transfer_cb()
> for disk DMA reads instead of itself.
> 
> Fixes: be1e343995e ("macio: switch over to new byte-aligned DMA helpers")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ide/macio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks.

