Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF4606A331
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kVEkRXF5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SF6gBZdB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOboQ-0007vC-TI; Wed, 04 Nov 2026 09:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOboO-0007uo-IX
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:18:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOboL-0000DI-Um
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:18:00 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4BZtun119357
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CKkeKg/4od3Bz4yfXuOA1vibmeQRM8uwA/I0QLGlrSo=; b=kVEkRXF5dNp2emwh
 0n4b75CLrmoIwlryn0OSqyUn/4wfnkE1wQi24ThWYvGNjdKY0mY+CjRT0+8w+Lj/
 FfC4HiyTMdkU9Pr+V+a7AwdEOc6Bvm0LWcmUaRNsR2I+e0Ca6V/sU9H5tEeEqLDK
 TMgVE6uGXPD/fZ9k489DACzYDAc1iTASQvDJsAIMTJaymxt4SrJW5TfDK4lr4DOZ
 5yp3PBC8n6j1d2BF6E8RmDtgVToyWDUyPq4my6088h/6mm+GeN3S8+ww+BCFlWKd
 a7bZGJZTQ5hajcNpwrZrY4vXX6hLqR9al8ugQTzl+y7clWsP2YIVnLsVRfI9Spr3
 LTX/qQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqwb0achj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:17:55 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so723408e0c.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793801874; x=1794406674; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CKkeKg/4od3Bz4yfXuOA1vibmeQRM8uwA/I0QLGlrSo=;
 b=SF6gBZdB4nlHu5XibENZzg6p4dyUuQzgRabUe/1iTy5Ld+ZY5/QOBznnF6xk4AjnLg
 GcGJnvNoBeNhWWVBlvNXCnsbnrJSOnSWz/3bJD2DYN7sZsl8xSmliQ6SjOOHm0Qz9C5a
 TkCExtRZ+I9uCMxgdR2+gGcp09/pT8HOwlnLL1HniINBdCWomj5nijZOKwFODTlkgVZv
 9TvVOQ2gDovAna99FZ7pl6d70RQ8EXEz2xks1UTwntl6+qUki3vUUHJAGTu+SvzLR6cA
 rcbcNFEinpNhDdLq2am/UQLj0ZozmLElp7f+tGjPGpsDFRsrHiRuKwWxX+2gS4qqq1IO
 vWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793801874; x=1794406674;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CKkeKg/4od3Bz4yfXuOA1vibmeQRM8uwA/I0QLGlrSo=;
 b=CgGTdrUfoaYL7GHv7WIIAJ+Z8U7A5frykcYR44cx0XmrN5/OqlWEDvkBvgerBHI6Ju
 2M0OLu5kGEXt2Q8Lt+JQf0m9xUUXP9U0I3DbZ9ge8nnJIeZ516MVocwZ/wUJvODk4QUM
 KmiwUNCCfClqexHCzsulDp3UsdBwgfb+7k5yZ3zHzUa1fARzExpEdW8xTaH2XX+ajgDc
 zOvbExLH16iS3aqRD5MHDui9lHJ8nDSXXjioZYHxlK774HtVYLXX9u/ruWFbws9YjRDu
 EQACMQzUbMV+RVcQI+4b5du7LPU94zttlohsbSepnKNKQD0ontSy4WoLFJkFNHn17zpb
 dWcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSDjSuXoBgerU+P4siALX9mzJ0JwlLZsOgtGJ1N3xIcF37VyTt4EvcvtN8pXvsuBEJuR7+lg6+JMos@nongnu.org
X-Gm-Message-State: APuU4Z+jvQy1ADuDq+Fkv2aZcWY6X+SllDlt3DOg6OqXmOTKK6B9WQEN
 qh8g8Sxq0Pw7JnzU4zyFFlYwUQ3yYBFwz45YkqvcFsei2J8cZZ2o5rkzTA7TlIkCYOlC13/7tgG
 /INXblVLo/yGaDmwyN3kuiZQmnn7h8jYJeHBSS2vFsFpQrx06U/4Rk2LpAg==
X-Gm-Gg: AYBFou1v10YFiqdlthHsjWwEcYotOGq5zPWclzzluwzfaNjKv00cH/QKQRSbC5j4eDH
 vSWaggG5fCKLNLRzR6CBzPmP0djTnWJ1Lg0VSRHHSCQIKqG6V60fJ2yoW5FRFkvXf2BXxkVoDoJ
 cKANUSwPxdeWZiRs1+3Cx1eKIRSgbmXmvIgOrMBm7fiZmGTJdc4PvwcMX9m5uqNK5dFblXyTNUx
 tSBiQY5yMi/u/3ca3GRAAR5KX17Gew0xrDxWlfpR61CEkJTj2TKWB8W02Xay8+PPmGphU25Y6lJ
 DyyXe7nQEzx1AMTY0VwB+glFe84SctGeq3RO3dGNLxUgalZNbVJT5tcCIlP5xEmYIPcbMZlbaMB
 kiojrNEiyBqQMzYE+J73szQL5HU/L4R4BUYPMpmdalDg4QPqRUP9fi0mjv4pkH89p2JccUJAMcT
 jNsBy87A==
X-Received: by 2002:a05:6122:21a3:b0:5cd:590:c22e with SMTP id
 71dfb90a1353d-5ec689aed88mr7465981e0c.21.1793801873674; 
 Wed, 04 Nov 2026 06:17:53 -0800 (PST)
X-Received: by 2002:a05:6122:21a3:b0:5cd:590:c22e with SMTP id
 71dfb90a1353d-5ec689aed88mr7465953e0c.21.1793801873179; 
 Wed, 04 Nov 2026 06:17:53 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm161847855e9.5.2026.11.04.06.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 06:17:52 -0800 (PST)
Message-ID: <7240871b-1ff0-40ee-bcf0-bb15139f6c4a@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 15:17:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sd/ssi-sd: Handle immediate write start token after
 R1
Content-Language: en-US
To: Manuele Conti <conti.manuele@gmail.com>, qemu-devel@nongnu.org
References: <20261104111619.24479-1-conti.manuele@gmail.com>
 <20261104123605.37729-1-conti.manuele@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>
In-Reply-To: <20261104123605.37729-1-conti.manuele@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX7yY3U3NFfAj4
 +w5DPqyRQH1FW594vU4c+baLIAPuC4BApR/0q33uw8vClQ8rx119Fu9Dp+uw5l7xys3/bwDo0qF
 iO+Fvn9vsHx6IqUOVy58vdx2IRmUQRA=
X-Authority-Analysis: v=2.4 cv=OfINnRTY c=1 sm=1 tr=0 ts=6aeb3e93 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=XcJ_MkyiOqCQW5rGCfQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: AvatiZN92Z00NNFoQ6qzEVeLAHzFE-jB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1NiBTYWx0ZWRfX84F9+17ce+4T
 sI4coZeEsBc/Wu3xu3RudEPiCSdmNoybXMAk2HDJUObVOqwPlXb2uccMKRPscS7cXKMzwJRtGDs
 c2/OQf+swbT3MQMxC9mCfVZrGEF/KDtFUN2VLslrxps/4Lv1vUhxDYqngxhVe+IGiSc5FFpP77v
 4SR+wPfurPNuKdWA9+fIDbTHX4nmS3c3eHZ93IVXVl/YfP/Yv3G2rYFlB9MXmbQmOKBAEWJtcQh
 U4I5g2jhNwlvye+Hi3/zOdnYJTvjvvwTi0MdNGDqeaRjt+FZAk8g//Cbj8lOz0e0cWxXV54hREd
 gDftlBGX0hikg7wobkj3sMH/WgsDEhvJj62vqxvJJ4rSWBq2ahnGJzX18XKaijfOtJg9GKsqKP9
 xQmF+wUjg/XeVdZC6DncGHNuB61WAo2BlY7TGfpUvdOKgYiWpqdyAjAHOp/MTsasc/t3o8CI4pM
 gr1IwqTEzmuiCrnpyag==
X-Proofpoint-ORIG-GUID: AvatiZN92Z00NNFoQ6qzEVeLAHzFE-jB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040056
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please keep Bin in Cc (as maintainer)

$ ./scripts/get_maintainer.pl -f hw/sd/ssi-sd.c
"Philippe Mathieu-Daudé" <philmd@oss.qualcomm.com> (odd fixer:SD (Secure 
Card), gitlab:@philmd)
Bin Meng <bmeng.cn@gmail.com> (odd fixer:SD (Secure Card), gitlab:@lbmeng)

On 4/11/26 13:31, Manuele Conti wrote:
> When a write start token immediately follows the R1 response,
> the SPI SD controller may still be in SSI_SD_RESPONSE state
> and discard the token.
> 
> Recognize single-block and multi-block write start tokens
> when the SD card is ready to receive data, allowing the
> write operation to proceed without an additional dummy byte.
> 
> Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
> ---
> Hi Philippe,
> 
> Thanks for your feedback.
> 
> I encountered this issue while running a bare-metal STM32F4 firmware under QEMU, using SPI mode to communicate with an SD card.
> 
> The firmware performs a block write (CMD24) and sends the data start token (0xFE) immediately after receiving the R1 response, without an additional dummy byte.
> 
> In this case, the SSI SD controller is still in SSI_SD_RESPONSE state and discards the token, causing the subsequent write operation to fail.
> 
> I've now added a regression test to reproduce this behavior without requiring the original firmware.

Wow, that was fast! I suppose you already had that qtest written
locally, if so next time better share along with a fix.

Looking at older spec v1.10 I found section 7.5.4 "Timing Values" and
Figure 56 "Write operation - bus timing". The table gives NWR (between
the write command response and the data block) a minimum of 1, in
units of 8 clock cycles (so at least one byte). If that reading is
right, a host sending 0xFE in the very next byte after R1 is outside
the card timing, and the model dropping it is not obviously a bug.

You described the model but not the guest, what firmware / drivers
it uses. Does your firmware work on real HW -- and if so what is the
SD card being used --? Does the FW intentionally send the token with
no gap, or does it poll/read a byte after the command response that
our SPI controller model hides or reorders?

Thanks,

Phil.

> The test exercises the immediate write-token sequence and verifies that the controller correctly transitions to the data-write state.
> 
> I'll submit an updated patch including the regression test so the issue can be reproduced and verified independently.
> 
> Best regards,
> Manuele
> 
>   hw/sd/ssi-sd.c                        |   6 +
>   tests/qtest/ssi-sd-token-local-test.c | 165 ++++++++++++++++++++++++++
>   2 files changed, 171 insertions(+)
>   create mode 100644 tests/qtest/ssi-sd-token-local-test.c


