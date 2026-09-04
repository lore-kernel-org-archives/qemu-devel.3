Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04350C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2U1G-0003Je-6F; Fri, 04 Sep 2026 09:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2U1A-0003Es-Vh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:31:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2U19-0001W4-9u
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:31:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIQ8E3168626
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YCHCsaOPDEzFut0rF2W1TJZ8mECoKOOX+TI0x1GETCQ=; b=YRR+lmjxtr3xJfXL
 RH3dUd3V8EGDHDYKw6bdwMmt+5r7zaeyiZ4wZtyLW/vTXffx/CfvhR75iTezUlfI
 1tOPp/WSctT9lZ/2IoEOo1ltvYHIGYS9qkaPSg8jW7w6nJv4b6anc1U5hT+fgr74
 WtbQdi4LocwtJvBD+9mkPnA6c9UsbJcR+tZmeQydDG+CDKAvc0igYYq+kpGak0Ev
 3m62jjo2lFcspFXiC1ZmbX1LNud/OSKkwWyUVW3+JM9Zz1LN+/nRTKZbqdHrIra6
 0moNtLzvwKeAgdpjhrlCJKfduJ/vudY4PSTUVaDLbYPvdbZ6ZcfcvfpvmKYcv6kQ
 MbbX+g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtsnxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:31:41 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e9e1dd7fbso815700241.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788528700; x=1789133500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YCHCsaOPDEzFut0rF2W1TJZ8mECoKOOX+TI0x1GETCQ=;
 b=dyxyv2fUJHVWKcamUhs1xaI3e8+rvIc7BAosHbJse7zgpQFe4yiZmwhwqMl/9kgW5M
 5QsGo8ylca+SmGVrNJpaTsKxH01d7FK11Kj/Ke1j7iD8cAgiM9TTQLQZzr365ukdrvnz
 hzx2SzIUAr36dvBsPe3TheSPPj7D40piTiCPh9On+scxiN5eFQJdxKFpgjlISXrq7/6A
 MlNa59QlPnn50AtGOQYoQdnxR3vrgKQepp6pDQS2qCFPgoWpAWYUJpL+lKtvycfIhJ4N
 BKarzOM/g94TNC2F2izuCJfXrvke5r0mMKaiGwA8Fa2jYeWmeOsrIL4zszXQFg6FcSqc
 jbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528700; x=1789133500;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YCHCsaOPDEzFut0rF2W1TJZ8mECoKOOX+TI0x1GETCQ=;
 b=rQbYawbh3AkCWUuIiKoB1+AQQ1hPMwiFrTCNUb4OzB7/CuqO9QTyXliiXRpbrk/20w
 lXIGL+WSAtp1XBVfUVqC57V2ReaNH6iW6D7Yo7jfRVK4Q12UQ1NQINgBY2CJGCw2JpP+
 eefsg/cJKrMqrxFq12wna9hkAWapCQxPixzt3LEtj0jE3mR4mEuVYUzeQh2rrDWIC8QC
 7T2+hU82R82iLRh200vpMZlRTkvOCYAu3rpINtaIP+qugePMPC2HE9SeWtg12L9Pj/Je
 snwXIGabe4IneFHddJRmezVLcIv67DRkppJ++bOsirPvYiVUktRhq6WNzB5JeUiKA/Tl
 ly+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA+FeMSjVhgPHzzcYwmR0rS/9sysKAktHE9ySpKTNufxppl6+y+0T6UScPZahs+TAZDxaJKqUqNHow@nongnu.org
X-Gm-Message-State: AFuF++nuLdFyS7Ngrqqmcx16geYSB+SxrPEg1g3fznhqzconzXbN0J7k
 AfiMmPwMYhwQDfrwTwUnipeKLRjV/hDzgpB4qaPPs9cE45hLmaoTPW/+ZG28up3OwOaBvGieM+D
 NV9zFKxeKP0Jr33xM2NjXQDbXVofuA93djdAy74Q4bNeynjll28OpjfugYQ==
X-Gm-Gg: AYBFou30tM4ATf40KofU2XjnEzeXJCvFHVU55RkF88luIv31UGugMxCDxINuNfcZnXm
 3Co9KJXzFVM7IvfL5nXclp6pF1oUIqW/4poioPQA3nUHqnfe7o8j+BtoB+HSiX6Ydd1HWr+gsnS
 zrjJkYWk/ttWEIoUR91s1Co8MOs9Tp974DUa8ubIUv9/6jf3HG/xFQ9Q7RuE1G8eSW7eJBxFsAj
 0lNislBYELCAeNTGePlPCxAj12uZlNynKl74CPxZcrjuBOGgjtYkdfJEuFT6TvSC0Ph77zhFXxQ
 mMSgrImJpeoqNlZzhpiUcSTUZyV+VTfCXt7/4KqwQok2lubv1MUhtEpSPfXC+Y1YYOwJHVIQkjS
 G8MEQYmF2XFLnZsgkXbVqJbur/XlxybbOnQ==
X-Received: by 2002:a05:6102:2d0a:b0:779:c38e:de53 with SMTP id
 ada2fe7eead31-78a4aabb603mr2405237137.10.1788528700552; 
 Fri, 04 Sep 2026 06:31:40 -0700 (PDT)
X-Received: by 2002:a05:6102:2d0a:b0:779:c38e:de53 with SMTP id
 ada2fe7eead31-78a4aabb603mr2405198137.10.1788528699955; 
 Fri, 04 Sep 2026 06:31:39 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7febb4sm167223945e9.14.2026.09.04.06.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:31:39 -0700 (PDT)
Message-ID: <b9964492-5e54-4f32-915e-dfe192d8c476@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/intc: name the L2VIC edge trigger check
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-5-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903185622.3234171-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9ac83d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gHPne6YqgEI5AgDLG5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: EvR6H0n4e79_OaUbyyzp107GaSe6-G7u
X-Proofpoint-GUID: EvR6H0n4e79_OaUbyyzp107GaSe6-G7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEyMyBTYWx0ZWRfX2BFLFm1s8cLA
 xW4CJ3OLh8Si+sVcXzIhq5gRB+gIZEcvkkLt68ZR4bam9b/Z73KH+NHXDcKoRS4xmnNR6Jvs472
 NL69VSamifg6HUFsumNt0eLieEH51Pw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEyMyBTYWx0ZWRfX11qYnDkLg010
 +ZHsGc4TaloW44bl7XyXtfJr0wzkIxE8thIg1zcp/KbXS5xiy+Ila1J0jYWljymap63hgaRZ9Wd
 DiLGAPdSSd99EHF3zSmVo8/0569bU2dMYLsp3sOw9e+UizlbzZ4rxSM+3wABkCtAIqP+iV0tLlw
 Kwi6lFhZszgKuwJMhGwyJw4aRuNqKBvjlRbm9lb8GLErWapE2YdXFRZKkR3jNPoG/g5jor6Jfls
 b7YpSr2db2uqIfwYwX2xm+YSZTuQiPm2ug+9152h2uv+OQWKb6Jhec9TfTXgnhD6HqjWSC1wWkC
 z9fQErcTCEGOuoKXsrVnwo/WWV9KUM+a/33vP6kdCcOsbFkuOEunSb3yom3AKnA5z+oXDufedsU
 XH0soqCD6r4LjR4Vjdl0gWb9oshDwmUjSR0QavksFl6/X3s4zXl5KY7iqyu/6n9NwfDvQ3g601e
 44p72tEP1T66d7hkuEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040123
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

On 3/9/26 20:56, Brian Cain wrote:
> Link: https://lore.kernel.org/qemu-devel/c3f2f4e2-79e9-4b3f-8bae-88c669a34c0b@oss.qualcomm.com/
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/intc/hex-l2vic.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

