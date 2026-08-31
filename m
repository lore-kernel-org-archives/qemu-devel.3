Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DA9C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0v41-0001pz-DR; Mon, 31 Aug 2026 02:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0v40-0001pj-EH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:00:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0v3y-0003mR-Pg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 02:00:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52aHp2061054
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cx1mfF16N24mRm3e1dMX8wA/WYCMowNZRnFxI7KBlOk=; b=WQbK4/IhPfzBnIu1
 C6v9juWO3Ljgo1HhMr4TFsS6d2MVogcmQMTIb6BvtWiTKMNERGBtkX+d9X1C6SvM
 /2S7x9G+3kyEBdLoGXyNnzYmgTPcD5rLy10VA9nwsZU7KyK6872+pV60YGHF8CiD
 h0rAK+kSwg04/g4xPU63w6Pjt8eNQ5BP6CdQIIApRPgtVu4bmQvhizFDhJtvB2yy
 Vj+bw/qkQeDJWr3HlCwKgB9BmQ/bH0K1fN2NWI1WA/+al9JFY6/5w/bY5eC/rEd3
 IpGTABoa9+gF4Zl0JOolZWpo3+pgHWh+0Q34k6V/3spLWWIUoR5XswUHGHKeQ9Y5
 z3FYxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbr6dvpe8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:00:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934956beec8so529787385a.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 23:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788156007; x=1788760807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cx1mfF16N24mRm3e1dMX8wA/WYCMowNZRnFxI7KBlOk=;
 b=hk0yTvAsVc0YYvZwsJhRDB2BFzYkJVgP7fnUj4tLPUCNY0HylJZrx0w25Woxu4rg1M
 V26KZ2ud5yQaG98fGI7pjIwgu7lBV2Zz7JZc/wMLcX3HLmi/Zbs2C0wgMF2DwnKR17sw
 idV2mm4t6sm91/6ctIWx3UndiUdYej4MLuKUxkF8NDMRiLNLh1poZYroILe6g2ONTgoZ
 DWU+om64HHagzhd2xXutILUh51EFjFGYdshkhSIAtv6qQKy+SoLpijzkoKa7VGAGjD6R
 XvDAeLgDO4+edigp3IfZqRusX773m1hdOQGcDOqAmsNMbRC1jcR+XT0yICYdLJszfcmo
 Ve0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788156007; x=1788760807;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cx1mfF16N24mRm3e1dMX8wA/WYCMowNZRnFxI7KBlOk=;
 b=KKbfH+fOtO5/GuL+53Gi3y/U2xhQhI5s+OOKa2jshtThtaMwOC5jm5f9Z7PSOFkQq9
 ZARTU4dHPrFv0QkDSIZKqT2U8h62pjTr+2h0gS0nFm+E6uwxREXvCbWnNU9JFbcK9hEz
 /8RGXSwG4P+L+TfJe1QefMHxVGkIDjxa/2/YYBAniH/oGy9cBtsVVbu/KqQ564FuXvUN
 FsPSd4LhFqH3yx+9bAlOzpbNzayT5ccOIMBzoWolDHGe5O+yapJfw69N3ZKOxmRZhOU/
 BRWHd2qaQMTvMxHzC1wcTmbyhQCkYr4un9jsa8Zs8OUxzHe54pIAH5yu2yDcdzWZ0sEP
 AzIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiCnFnNNR1Y8W+O/1TtDLZRFEfqDF6SFcm6IA42teyTyNHOGMGsDZDDLUMk2Ja9pR1uIwjU8z9D8op@nongnu.org
X-Gm-Message-State: AFuF++kPsuIKFkjd51CXoNeEJGsRXm5ovVKXwcx0iSvHurrruhdxJCvd
 GJiHGob8OZ8LGv6g2k3WTHwUuMM/Qex5tQ/EI1zFySQv3lPXGW+y6TrU5uxXTBq0SQMjh38N77B
 2Gm7g54e74XZnYxTB/OB721lkXhoqscMmJ8codS+E+rPU80s2A6ggwe/Z4g==
X-Gm-Gg: AR+sD113/ZNTSSFuqaHCqjYo1LJbMphHnlp8qVbTvuHhLzKn/1yRV4w2N9RcJRnrD+C
 eqIBH/8CKBSZNRu7QZm0nSAOCnjvCvBm4wbXOLCwmY9hCOE5ZI8oNgfUkNkppapyLrNgTscVGyY
 jQR+pkDl248yRobCAZ2ZsnKQBkLaLavd7TK5QOzogAUDEH6HeEANPSsMKgJ9caBApBwAdUqb8EQ
 WpaEf4DK/jqvBFqsfqXUadLZZHC+TnNGUNSiGYQzyoySsuuIqbO2/LQ02KhmSrma0J+eKwPqDU/
 qGemd7SDACOv6bF25yxZFiOv2VD5dq1IMlzD9iYIjWYzirAaclK0yXoht45cSjT0Lcry9qRS1uk
 JtzJ8kDOoObEEt2cOEdkHGlP1vQGfnS28Xg==
X-Received: by 2002:a05:620a:4b41:b0:939:3c0:144 with SMTP id
 af79cd13be357-93913958c0amr2005520785a.33.1788156007348; 
 Sun, 30 Aug 2026 23:00:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4b41:b0:939:3c0:144 with SMTP id
 af79cd13be357-93913958c0amr2005513985a.33.1788156006847; 
 Sun, 30 Aug 2026 23:00:06 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccae954f9sm195158315e9.13.2026.08.30.23.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 23:00:05 -0700 (PDT)
Message-ID: <5f9b574d-84aa-4220-afcd-a5d5bf80dcff@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 08:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-5-jamin_lin@aspeedtech.com>
 <c8e259b7-3b42-4dc3-963d-2ce8ee680500@oss.qualcomm.com>
In-Reply-To: <c8e259b7-3b42-4dc3-963d-2ce8ee680500@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0OSBTYWx0ZWRfX1uB+muGfY+fD
 4mio/KZ05VoDony+CHMhXKog9Xu+13MKOvBC2gMhPe0pVOegtJmqwKLuItebs7qrS8CFMmsDV50
 118kg3fW8dqX8/tS0MMbY6jJ5VlUE6zOgsNp2K0Mu1veUgO1+a2NtiPHJnFgkAh+t9acwk3AymU
 s8swE6RHmsWrVZk2Yb1UF41LX9mHIvzBT6cVRHIgaiMJ93GADyJKSVxr/Kr4DVfc7x79n2lASn6
 12WvixNPbX/qip51KVumallBrCowkbI8JkpyAJoNM6urTwZQHu0vQpQKd9ZWCHAQVw+yiFj8Q6B
 8YhOB/JTu85ayOJtYX5wy8OUZuTD85Ynx8y/hz09k5O32sEGuOobX1NZShXUY+dFgpIyMR4gm5/
 PSODkpQXubhvmHvH5xLFcRxHdj2Dyp7wtAz31vvhqDOPBC1Y+7lDeMuFLIQXJPpVkqLhry8ijdQ
 2P6L7bazQskSaNyqD9w==
X-Proofpoint-GUID: iBjcySUiwaL8t28j9Vl5W-7ivx9LxjLr
X-Authority-Analysis: v=2.4 cv=Zakt8MVA c=1 sm=1 tr=0 ts=6a951868 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=iSX6IlxhHMlephMWIyAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0OSBTYWx0ZWRfX3g3onBDVUW7g
 acYXRXNnJclNGxBz5DDNxUEbTVrF2UKw+f2q+tcJdhU+ur1z8KQGhMcJ2lHOKgb5dUctvL0Bv4r
 ga6mss1DstIfmOPvWQwv7DYLEAf0Kag=
X-Proofpoint-ORIG-GUID: iBjcySUiwaL8t28j9Vl5W-7ivx9LxjLr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310049
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

On 31/8/26 07:57, Philippe Mathieu-Daudé wrote:
> On 31/8/26 05:41, Jamin Lin wrote:
>> The AST10x0 SoC now implements the SBC device model. However, the
>> old unimplemented SBC mapping was left in place.
> 
> Since the introduction in commit 356b230ed13 ("aspeed/soc : Add AST1030
> support") indeed.
> 
>>
>> Remove the obsolete mapping now that the SBC device is implemented.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   hw/arm/aspeed_ast10x0.c | 7 -------
>>   1 file changed, 7 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Please squash:

-- >8 --
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cd68c7f1caa..eb5b9291950 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -89,7 +89,6 @@ struct AspeedSoCState {
      AspeedSBCState sbc;
      AspeedSLIState sli;
      AspeedSLIState sliio;
-    UnimplementedDeviceState sbc_unimplemented;
      AspeedSDMCState sdmc;
      AspeedPWMState pwm;
      AspeedWDTState wdt[ASPEED_WDTS_NUM];
---

