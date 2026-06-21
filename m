Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF21CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 14:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbJ4o-0004VK-GJ; Sun, 21 Jun 2026 10:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbJ4l-0004Uc-OB
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 10:23:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbJ4k-0004ee-4e
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 10:23:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65LDtCEM1991140
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 14:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZxNckIRXPeR8iBbCETl9VJQw/2t2ky2qAzNeKRi42nQ=; b=iQ5fZKnOYGzK1beK
 eWFax9JErpnlvGfriWRcsLEtWlspHvmQdzhZnLgv/h0TSXs32LVH+NfCWpQoDrKb
 LRePvyy42gYejybQ9XeRR74+iMn/MkxGfWpVUMf2Iu3tb2U7zHWA0Ew9vQVtO7m5
 xvdqyXA+npRYax53IM3nazazsp0RpCzDcUWyMLFxcB0/e2Ncnlf5fLRuWw0kw3zQ
 B4ivkL7MB4EkdeKC7/oGJFT6y4164SAj1+6/NDrqcpJ15jRC+1o6tsDHAckaZUOE
 LfQgqlyYqH49r58R/pfaRajPNsEtqNfuk6DTxNM2LAgXZwjP9T6FF0YzW7mwXnIZ
 WWRiUg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm5831ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 14:23:01 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5178aed25baso70313851cf.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782051780; x=1782656580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZxNckIRXPeR8iBbCETl9VJQw/2t2ky2qAzNeKRi42nQ=;
 b=FM+tZBSuhr8pITfCiOXb3Aie/zCbMgGbdrrM60zPcJp53DRHzoov0e6TeyNykScrnl
 AABxP7ZTs/NBC/xXcbXeBNDCBF0SYtmMY1K/lybdXVTaYBDWJQHyfjaLZtWgQWnt+MN8
 bHZX+wyfIf1eCPcSdAChDRkU0J42ekdpxSpAlje/JJnrVafbdxArc5VF4pJeFZtObZ8Q
 2Ti3l3/PONEgImA202/uVXPLl37cq8MHQVB4BM9xDRIxfOD9HIrdWIcwwQtfCW3oSjLM
 w2bENVNF1vCqRMhepHyxCMlVA4Za7gXRamYvcmxNw0dXws23vXfOz9Mg+9fyZXDCSYcG
 LLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782051780; x=1782656580;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZxNckIRXPeR8iBbCETl9VJQw/2t2ky2qAzNeKRi42nQ=;
 b=SQRjXJTY1vZaa/LnzBR+4TtWlPUWbrWOEvqCBpq7guUo9aIF6Fc2QJh6yD+Omz/vM+
 9IKPQLNgiRs+xqJnt4ZG6kkvH0docYyuVkj9nN8j973YtG5TSNe3F9h7zWpij1lzkiN/
 laJivLIV2RyedtF2XTQhv9FsYqSHOECiatPqPCHC0GYMgjvFU31pW+l0bIrGmt+Vmeti
 WpAUg6jSeqyliZyKnNVytr6QjqIYvKRuh54WmIdxMdaE4K9bqnF/9L8z3RlYZQbsLhs3
 1dqu644g3n5AOMrbbwPDuEak0yGUXC8vzcHW0hrDyilcziO45aVUJcYndOfgd4HYd5Zw
 oH6g==
X-Gm-Message-State: AOJu0YwRnNCKGwZvJyyZT6PdCOQwrmeaf834brLy0UzaCndulVvPu7V9
 nR70YuW9pV5v11Vf+hrOekNnslBx9Od373MKh1MLvmsMxmlQC3PshSFkgOAonwg3oxToNRCiHGX
 ERGu9qvpP8yfbUZ6gNVp8F3C/oicWvf5jIjAZtCUGSw7KkzjPMiMTR9Ezkw==
X-Gm-Gg: AfdE7cnXz+gMkTj0i6OEOUfT5e+9reP1K+4OZMuNkMQHuTjimdh2yIHU6Vmr2ua9KAB
 azbzTc9ak/ZYe5n09RVlTJljajmKEITz+lRLYBU+3hTOnUAXB52Mws+oiWUOUm1/MYznNuSLWLb
 YNwl97T2I/XmQFHPhjZ3/hB5+UZ7J+mWcPDSXSdH54+M09VPfETsFvwOhHXodNPI7pEXZnsndmw
 NavEAcQcIKpv2pBG1USWSsh9c+anEr96Ddjl0Cd2kzqSR0WN2kDD3S/Vi1vG/j1nRhTa9Ol2FAq
 FePWnzwmDBc+jCcb1t6r2uVCHRG5wG9arCXB8Wwr0RymiIJCcbA195+o9hygOlsBboyINqTSMNm
 BNn7hnlYu0uVY1L5mr2rwLMPdiPqH1yzxy9ch0ph8UaGNRxHmwTrTmmvlK2ruhWI43OB3yfQTVB
 otGz6vmzawmf+WgeY=
X-Received: by 2002:ac8:7c50:0:b0:516:d84a:9f54 with SMTP id
 d75a77b69052e-519f04d4ffbmr150860341cf.38.1782051780405; 
 Sun, 21 Jun 2026 07:23:00 -0700 (PDT)
X-Received: by 2002:ac8:7c50:0:b0:516:d84a:9f54 with SMTP id
 d75a77b69052e-519f04d4ffbmr150859981cf.38.1782051779960; 
 Sun, 21 Jun 2026 07:22:59 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a09895ac9sm44025871cf.21.2026.06.21.07.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2026 07:22:59 -0700 (PDT)
Message-ID: <773d96e3-1702-4a69-b9fe-a543334fcd48@oss.qualcomm.com>
Date: Sun, 21 Jun 2026 09:22:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/74] hex queue - sysemu
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
 <CAJSP0QWzQEgoYMCgZX+9jCvrV6O3RqnA+df1DpT2R6MZvVXiNg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJSP0QWzQEgoYMCgZX+9jCvrV6O3RqnA+df1DpT2R6MZvVXiNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bfm0mMkmNnEAWcpjLzrXAMlybvgwkjB9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDE0NSBTYWx0ZWRfX8A4spS3v4vNm
 15cSVoK+JsfpX/EDHCk3LsidpvvDLi6L0U7J4L0O10fLZhP0t4TO3Ofq/PrJYS7pBvp+1F3my5i
 IMf1KLhBN7N3Er00oG7U/Cf7gcD+rjo=
X-Proofpoint-GUID: bfm0mMkmNnEAWcpjLzrXAMlybvgwkjB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDE0NSBTYWx0ZWRfX13w9pIh4CHBh
 dNiG2qyXSwROfjAHW1+9NJuXte6LsN0h0bXsWbdKrCY/hJYziEzrtNHpi3qS0HCafn5FKZKWsNl
 Ag3szEZRP6MY1RBbw+HVDXzU32Cb/n1HQmMbSVlX+zmGD6f3KxzTwNysodcEplM5cIPJPe+t7Rs
 JPk9k5upd5UmupNnViBL2XCKeeiSLVhlxMBPoX1niQA9ezYMnOsHu4W/2XWcc+qAxaD9vSoiHQI
 r1Jf5WPZWX35o1SjiVhJ8hOxjbjnq50zmdsA93q5cKwQm66151kBkETAT5KC2hENi844PhixNum
 i0/HySNbtartL4A4NsApYO1l8lWFBJLIkQT87RZvwl9akeXi6sO6IgZ+3FKgZ6c+9AWDNVl8G/K
 KdqpUzC5NrpIF1USPMz75ksfNbW5vxYq5l9EC6vrVkDLJnIZe4MJ2VMHoCHZ3tBGb2sp1JBOnSe
 cS8948F9JjijytX9LGw==
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a37f3c5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=6F6Z8z8l5zDi8Hb5yd0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210145
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 6/20/2026 6:59 PM, Stefan Hajnoczi wrote:
> On Fri, Jun 19, 2026 at 7:00 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> The following changes since commit 3b50303f9563a42538a1fd5c0ea7f952e23016e1:
>>
>>    Merge tag 'accel-20260618' of https://github.com/philmd/qemu into staging (2026-06-18 16:28:12 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/qualcomm/qemu tags/pull-hex-20260619
>>
>> for you to fetch changes up to ffa57dc3389a85263a3a7c4890d01b501a33ec97:
>>
>>    target/hexagon/idef-parser: open input file in binary mode (2026-06-19 15:39:11 -0700)
>>
>> ----------------------------------------------------------------
>> Add initial hexagon system emulation support
> Hi Brian,
> Please take a look at the following CI failure and send a v2 pull
> request that includes a fix:


Will do!


> ../target/hexagon/meson.build:285:47: ERROR: Program 'emscripten' not
> found or not executable
>
> https://gitlab.com/qemu-project/qemu/-/jobs/14953356226
>
> Thanks,
> Stefan

