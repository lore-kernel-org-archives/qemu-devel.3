Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5D6C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KXq-0006wH-BC; Thu, 17 Sep 2026 18:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KXo-0006w0-0Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:25:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KXm-0000uw-6a
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:25:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLFm8t3089489
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FcBVxJy6p6O1Wt7EasIILI0Raa9bjTS3aCOEYi4ZbxE=; b=UR5haYjzI8ewpy8O
 FKPA8+rEPH5ucObhGkEVdLqPaeVInTjWRpFkYD1Eghr+/uu1iBHfjBcdDZfVsL1w
 e8Z6pHVmatB8Ki9JI12uYOCzrUUONibpkskdZVPp9wW/kFkBQS6y0U1HlHILUIe+
 lSX+/h3VhGHuoWlwe6xqvMS8WCQGgE+KDPshdxkFVibCZQh3Eawccb4W8vsfRZOO
 Rfy+RyQvzO2Z9PFneAO93dB7NnoYuzRG9Tvovb77ACweOYHids8aOlC789y6WOHz
 qmKWTZDOGPMcgjuOq4Rylf8YzKa3S7gNDAGWlo3fZsArrZoUA88LBzmGjtpvhJaW
 EbS+Wg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grnqe8u6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:25:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso1814555ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683923; x=1790288723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FcBVxJy6p6O1Wt7EasIILI0Raa9bjTS3aCOEYi4ZbxE=;
 b=ad0g9cMyKgtb0ejLdi2tiZ4eUMJ4d0uQpTn7oepb9NgCGefhKtzv0P8kTlCGUdjieN
 KX6KFjzxK0KklQdufMKa4N/sFckuCN5Alz/S662BSw7YpyVfet99sIN3C6uq8azCzyy7
 5JWks7K4gg0DWzXl98Q7lnbFNBOouX9+6/xcy0Ogbpe6aRCEOUj8YV5phHTEjkwfHw1d
 wM017QVdDHuA5RdhlOYKn/NZw5cKIeMpgpkGp+m5j+w4drRJWKe5zlduH4tLhOgAtIxd
 bSlT/iQBH8Nb3MlCwrygn/Vr3UXW701T6FT5hwsHhydUM0L7510M/LT+VmiFM9wh1Wl4
 txOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683923; x=1790288723;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FcBVxJy6p6O1Wt7EasIILI0Raa9bjTS3aCOEYi4ZbxE=;
 b=s7T3ABIL/yxH5cFbfVXkGrNQ6ldb+jOeHuhlcCr3WZ8fFjgXg+7PA6pl5WukDJyrq7
 yGAqPa6HyMq4qaAu7cFeuZey43u+Yn1gtHNAkg5hF8rWfUpgBQtL7IRG7Q175MlkXRiW
 Y+ykj3uUmpUvd+QGQ2eVU65pJUA0I8ZaJZnnVhGn5ZdXeOJ4LwFOTkkRQsjqiCgQM0xJ
 zI28fEoW3rAliVC61CIG890txs4aQERpIs2Ca5pBP8DsM86MnT8AJCEOsLPUCHVCwI4o
 z/P0WY0e6jyu/ll222kmpUx2pQeWf75yUy/z2uqQWpYa64E04DK3N12YPXChRllysGAc
 uqSA==
X-Gm-Message-State: AFuF++klWlMUylIYP9nEF6KuB1Jloj+3KcKHrm+ywkQG+UrBZzvTEf8Z
 81qg1H4DQMD85D3kyAl0woyiweu2k0smHEJTjQjI5yruvGRhltKkrzQ53ZSEnOCKipkHpTtprKH
 aKVQJ8zBRRS+9Tssl3bZQcVs42920cMx65jSRt3VsjpbN8tMwSWYw+eiu+g==
X-Gm-Gg: AYBFou3ZVnPgXaFDhXweH66Amcm7hbGfPN1E3Ll1PVhF47cTHJNgLfarmwoB4Cqs6Fe
 xq9/Twf+okk1KrgoVFAm6v2hGNcN7kuS2WOjy1sGba8TKZU/Es7JNkPR0AFvqHCYsSC5y/mkRso
 1jwoLhFCNkgJ8MLFrKoEECztuUlpkwlNEYDmxCSh4oB74jhMFHBiUcfycbptichH/S3NfE+4ViK
 ty+MtJd8LsM1vX20NMBEoXXVjdU82S9WmvcAcHE2O8ABaXvi0IyFVJmu22nmH8TijNLakSrQiu1
 2CaCi9/GAtAswhiOKXnicG+jr/7GB+nwibPwQdNeMsMPFXvvZrlNTCdEavIfxE+zYyku3Lz+tZW
 B8G8MRA1X7iXYnt/o28FWNkEffBbdTs+KnGd1jQ4FgMAvfrYt0JhHtQ3OFyo2NCaFICJ7
X-Received: by 2002:a17:903:2f8f:b0:2dd:ad74:ac32 with SMTP id
 d9443c01a7336-2ddb1baf0a0mr11162585ad.27.1789683922968; 
 Thu, 17 Sep 2026 15:25:22 -0700 (PDT)
X-Received: by 2002:a17:903:2f8f:b0:2dd:ad74:ac32 with SMTP id
 d9443c01a7336-2ddb1baf0a0mr11162315ad.27.1789683922559; 
 Thu, 17 Sep 2026 15:25:22 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89e930d6sm32710665ad.17.2026.09.17.15.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 15:25:21 -0700 (PDT)
Message-ID: <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:25:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XBap8yzcxCqVIGp_jax-aKzfYDBKoyiu
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6aac68d4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Fk0B_iRn3N5X-Hb4rsYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: XBap8yzcxCqVIGp_jax-aKzfYDBKoyiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMyMyBTYWx0ZWRfX/2U7ePV/XVnJ
 osVo0lA01SMdoilF2zaVzG9WV3DChNQEGQoEUEzXSMuQgDL/OvvIqukXPgx9sM9ZjaiL8b28uMn
 qPWrrxG3DD01kRiK+/GbN3agkYpHvC9sjIwVOpuK+V3ks1LLPy0h704Y241X1dnFxKB/GnqgEHd
 8cBWmslz38dz85cTessg8bJG3kglx+fLhyKUKfhTpgP6E6ha8Z/jPo0/vrIGyY2VLfUvir7fYsD
 a7sbd0cyNxh35PAgW7SaTsWQFGzsV5u+qHZ1xdbY+MbnEW/R78FdIFOUs8PVb4pyS+EiRKoXLQO
 hRdETKBYbXRXfQBLpWuWxT7pUDpwS9KuP4ndLyxm2xbwPIsdl9+ScxAgJplBOeCIqs1BOnQcoXH
 RV3Pc8rFAESr0AO/EiCE0eZZimYfanuLpV4omylY7WbrXATSzwpaCG8A4OroqeraU5Hj6076j7o
 MZc1lbzade1ujlCBR9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMyMyBTYWx0ZWRfX9CwcCIYqEHzA
 l/SfN8yQwz8dFqXW46MR+g4/m/64tOKXbg2LhwwPhifDZElEkFOZtLUzgKzf8GFqR65uFJmq473
 MzR2HJGJKvPJmmL/yoYuq/kUTTIDFFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170323
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/17/2026 3:18 PM, Richard Henderson wrote:
> On 9/17/26 12:00, Pierrick Bouvier wrote:
>> On 9/17/2026 2:49 PM, Alex Bennée wrote:
>>> how much time? it flies past when I run a rebuild.
>>>
>>
>> For a no-op tcg-tests build (i.e. with tests already built):
>>
>> - With current patch:
>> time ninja -C tcg-tests
>> ...
>> verbose pull and build
>> 320 lines of output
>> ...
>> real    0m15.817s
>> user    0m1.342s
>> sys     0m0.840s
> 
> The variance from the middle of the pacific ocean, and associated
> network latency, is between 20 and 27 seconds.
> 
> Amusingly, with the network actively disconnected (airplane mode), the
> no-op build completes in 1 to 2 seconds.
>

Funny, on my side if hangs a long time (timeout 30s), then retry 3 times
per image. I tried it on WSL on my windows laptop.

> 
> r~


