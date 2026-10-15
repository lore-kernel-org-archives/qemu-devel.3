Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BE2CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEil-0007lh-P8; Thu, 15 Oct 2026 02:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHEij-0007kq-JE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:13:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHEif-0004dN-P4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:13:40 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xKUd1640679
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gjmxI3ex3uuihpaXF3LyN1xBZIUEyL6VQrD/YWpcZ2I=; b=WkwkviQWhjoO1NMA
 he9VrPKEEm508Wqht2ZgqLDuWqnVHKfffzzzB1MlXoTIZXcTfUNciYZ5dfu5//R+
 pmsLeSACLvszlOdwgbRawBzueYYkTEBvig0lj3mq7w5vetC/FYugn+Y/pVtEb3Om
 tFvD0omWTHkpJuSU6OjlOGDtWGoXxvGho2lIntKqRHhR3jr6zxszEfcczCszji4Z
 zANNsaZOxaPLd/puBoH2h+hZ+/whQBdrT22BwxnMqAhrmwmAbYXuX08uPMOV64Pl
 iHGgfHcUh0MYdkszHdy8ZsrNSfogDGxeOS/g1gB54JesENw+M5e/VvWWtvwmT+cJ
 NIzEZA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhgext-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:13:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e93f67358eso14640855ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792044810; x=1792649610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gjmxI3ex3uuihpaXF3LyN1xBZIUEyL6VQrD/YWpcZ2I=;
 b=dD8qnXXbzGbq7+r//VDJWKn2YtjPJ2TMORZ7EeDE7Go8oQa0bXVT0Ew2T4pYt1Z1ck
 LzdMk9z+kso8p77NxWOzZK9u0PmkEB4nXf2+loTosVsK3SLGvpWazs3gr5XhA7IBsd69
 MR8Tn5TcrHvawvCFfHSNmjeddg8tvpG/DY1/IOdkt3BYbwx+HUpQTyZfSgThEwGnMFmd
 75ISYieIsF3DNuEF0jmmkISvRuU5SRBLJ1MxiYZCV5dOryEanLXmzzzhNNQajNIi8TbI
 +nZO7dAh1/NsIObwt0dctR9O1aXrOS6Lxgy/LSu70VMYWUtspDDrolUxbiTp4G9ho84V
 8meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044810; x=1792649610;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gjmxI3ex3uuihpaXF3LyN1xBZIUEyL6VQrD/YWpcZ2I=;
 b=tCL+WzVv+yUHUGssKRr3THiFMsXli9eAU63oYjIyKpUhj1gtM4qlRJENiJDTkhjBl6
 uThrCyhsUuK9lnInEhGHDL7kfLIWsFX6oSjof0o667zF4WJDk9M0FUfIJ/iIAd40dyVT
 //4Kwj6GZOcIuGgPmlApMXqn6B/rYsXHxJihqNBjVGMDtblcz/QRyh8gr8mOMs7rwZQ7
 uKOowBCZ1GXdRxO3qyvDMHwBb/iR3iNBW7p6mKC3Dc54XK8nhVemsTe9yV/VK04lhgUH
 OWGMHQf2ykTs1izryK/9XbF/uiAMckuwOon2/HSYQuWeNcA7Uy9E1tRONhhahBV9KRSr
 fl+g==
X-Gm-Message-State: AFq9FYKUDrwT/847gJjkqTwSZBVFpmiV9sfKqHKyA1TOmFUn0DGdNOV2
 IxgC5xSpG3cEer1LgE038AamFNhKucOn3vkhhbk2QXJKut+Ui/SuE7hfPTuVBHY95uaAlSDKQUK
 Zto4Xu6zaVoP6jP8YSSnSEVVHaExuguKULH1MwzwPfiArM4eOhbkuDU6qFA==
X-Gm-Gg: AYBFou3hgt/j1o6DfEZ43Edr/PPE6kpIigw0zKU2Cd7uSrDOOksQScix2f3yzxddkZZ
 v6acpDd4nLpw7iZHsjyTngjUoF9QNojKKXX3bu6BqDen1KdIilyStwEOa2lGpPkR/g2A4Gjqmdu
 TrePllfqaNohkfb+5BwsOCdWqLoNRbpcaLr4G4mDvbzP2hAOyX2DLPU0CcJdOA41sHKkpfVzQbZ
 IIz0VWBFFA/xb0km/sWC0DzVyzgvq2WnVk82RHDTKXFQRmHCK/6tyZhJcQo0pR4GWAa/kJvSPt5
 vq4nZ/C3CFQVCBXYjWhuK0h7lc7dluAve2W4suTEV8SufYy7nux3Moa9K8ON+eFwytivKv+uZq6
 4S0oMDn8Fn9gJ3w68I7UEPPSvvYdZsrgbHWWEXEp1L7YlvUVVbrYoNekI
X-Received: by 2002:a17:902:e549:b0:2e9:134c:657c with SMTP id
 d9443c01a7336-2e9134c6a4emr71806005ad.54.1792044809983; 
 Wed, 14 Oct 2026 23:13:29 -0700 (PDT)
X-Received: by 2002:a17:902:e549:b0:2e9:134c:657c with SMTP id
 d9443c01a7336-2e9134c6a4emr71805785ad.54.1792044809473; 
 Wed, 14 Oct 2026 23:13:29 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422da9b1sm77628145ad.66.2026.10.14.23.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 23:13:29 -0700 (PDT)
Message-ID: <30dd70d0-a899-43dc-863e-f49128fdc8af@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 23:13:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <87bj8vbj3u.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87bj8vbj3u.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNCBTYWx0ZWRfX7htmakrL8oO9
 lZW8sPBe2GZb45/99uHxM91hA0uVyYRfH9ixOI7e4sxiDfWd4Mve7HW6h7UGCCoEtBQweJ3U5CQ
 hDMBYSDW/UjqkAQYETzGVtCEbRH0AJNDMDvTf6foSzr1ZRdw0ULqyoqwdJOhBMi0zp0oNi/1z0D
 DW4Bhu5eopiUuSFDCvL1Ueu7BkuVzAnDSDXhUMiceJzsbJJJ9YbPkEjLi/JmhA/uX3Pmfrmxl9e
 uOwXwhpSvX1SiIr/O+XVW753abC3d8+b3dAulDeEbEb9347irbiPuH8AQijPKKegFuyOq9ZDAUq
 v5YjSCypxvlhLLpBkILKFveNSESW4eeqJgfId1q2dVExcxrFqKmMizLwVweGJcG1bLpbZy2daar
 XqCDknN5EySv0gRQAwb7yfVUP3R1kaqZ0c/XTBZv5LHEv4iI7RswCNDKKlQbUeV73oBZG5luvvi
 0t7sTXCUb6dZ0ofFp7A==
X-Proofpoint-GUID: 6kjVSor_bmrmJxVdEwFwWDlJ4rLKSheC
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad06f0a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=xbjdRGERY6FnFoWgviEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNCBTYWx0ZWRfX1GOuHxiphqcm
 buHc3bruzrX/hLUNZFpPLUiV8wiG1fhtegG/PAECV79yPj0msIQGU6st+RlRh/wlNRahxWKKb9P
 jdEFoO0zQAPbl31a7B3swUbds6EkhW8=
X-Proofpoint-ORIG-GUID: 6kjVSor_bmrmJxVdEwFwWDlJ4rLKSheC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/14/26 10:58 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This series allows to link multiple targets that define
>> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
>> target-specific ones and a single dispatcher. We didn't use yet the dispatcher
>> pattern, and it's the first situation where it appears to be a good fit.
>>
>> A possible alternative would be to introduce this callback directly at
>> target-info level, which I think is a less desirable solution, since it would
>> ties this API to monitor.
> 
> I'm curious... why would such a tie be undesirable?
>

We have a unique definition of target-info for all targets 
(https://gitlab.com/qemu-project/qemu/-/blob/master/target-info-def.c), 
which is simple and nice.

We could consider adding callbacks in this "generic" file only if they 
are implemented for all targets, but as we can see in this series, only 
a few targets implement this. It would be more boilerplate for the same 
result.

IMHO the two concerned functions (qmp_query_cpu*) look more like an 
exception than a proper rule. dump functions (posted in another series) 
are more related to cpu, and not to target themselves.

I would happy to revisit this if community prefers to go in a different 
direction though.

>> If the approach here is accepted, I'll extend this series with
>> qmp_query_cpu_model_expansion which follows the same pattern.
>> With this, we'll be free to link together almost all the base architectures.
> 
> Series
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 

Regards,
Pierrick

