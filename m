Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FA0FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9Yl-0003DQ-G7; Wed, 29 Apr 2026 14:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wI9YT-00030Y-QI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:22:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wI9YO-0003pM-CM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:22:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TF3se02094208
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jYsqVqTLyyT6Qht+Lkyah3lXSvCtRvkiLNRsk1CInM8=; b=OFrTM1/PdsJCEmNS
 O+5FDFHphWpLPATXDAnMvQ9c1kC2j2hKtbmqcY0LXwA73B2nQV/Z9el7wGQoKxUk
 1BntRcIYZWaV3NbbWktOFY1qp0QGw7a+gI4/ydn6u5Tmlgs1+Tusq0coHnBuH75O
 D0dUP4lLfA5QoM5LljUlo4tR3VBjyT4ccipQTR8XDBaDr2+5jwdT0JLsdGSXy/D4
 lleJ+oPWALWaiCVNoCkEkp4TJG16kujyPrkF9fHeNjXeAfaQId5dlDIG4WRJavXk
 vuLgNcK7dOG2wIpt6f1cBcnCmD51LsQJvS/PwdnViloBrGQsIh5jdY1GeZgZlwpB
 E7ncmg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3tqnk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:22:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2e60238adb1so439568eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777486949; x=1778091749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jYsqVqTLyyT6Qht+Lkyah3lXSvCtRvkiLNRsk1CInM8=;
 b=DLn0XENNSU88q07RPAsafS2Q5j2ZlGQPMl1RHzaca83T+IfcSvvTBT4gtIEZDg7Hlj
 4Q8cFtajpQj373Ve0yIe6/O4avv02+QB5KVex63pCjbkNXxi/+byvcOwgAp0WD7rjolp
 BNAlNpChxIqB4ZDK3z6BERmv2pt7KNUnKXC7Di/0puhOmlrBziUCsN5bp2uwhfMZVAuC
 kqEMwcNGqh+i+kD8gF9fp7b2di/GNYJVq3vCfJeofiCXEAhteWplmpDSIZZp6oe5aQfG
 3l2y+yFY9hwIy9KzoJYt/7D/taX+h6e00DI1ojEuRqSJGWnIGkjvtWDwfI3wTAuIhZTf
 ZVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777486949; x=1778091749;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYsqVqTLyyT6Qht+Lkyah3lXSvCtRvkiLNRsk1CInM8=;
 b=LNMY1X4pWRoGObhcm+Yo39JdJ5JO2ViX0naqXJvNKxBebKHsC4khhMxnN/RClpDJ5u
 E1xXH6cAqOEeb1lkWOcVIbveZn7XAkY8utkUtKw2AMeDBphHMlphPGRQnWPdL1lPVPJe
 nEjfptPUb8AUvVjhEZglAbHARm4IyE/x2GUT9x/yTofDvz92QOd6F5QXKWkxCcda6CB/
 JYFfddYqS5jKQj3TD7awLt12k7GysuzBfjXzSTj6LVc0pGQEBnWpcgPGFv6ATPhve7y0
 h2HIKvu7oYGGoZXK8ODNOB/q/S99TG9oCwpKdNnOBn1ojKftTLDMJhRZRuQ6M4Fmp+ew
 ACaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pFIneJJg6kL0yQaxElkpg68v2VnCWkUEpWNS0TM0/bFtVJkamHaUFv/BEkLmz7MTzHJGcLANF45Jy@nongnu.org
X-Gm-Message-State: AOJu0YyLpC6TJH3isf/L41e3LDUhzRRgUnq/HJVNOmZHbi9OCGebA9g3
 EjEyTk4W21B9jKf5NUsxCyullqWM74jhGEg1qEO9nsiaJ4ovXG6kg3Mdaj7JDQdABBGRPtOF5p+
 blnBIXSMUXOCZV1u5hWgbPUSMqIuFqvNvaYE2R3IqEqSTcC09wRbAClln1bbU7vZC76C8
X-Gm-Gg: AeBDieum5aiTdx49m+MqyFk3v+2vFjChwC0dsBUCcqKGHoe+SIZ/U1eLYWQlsr5U1Pw
 0EuC/w4NaGzZREiFyDvRfIsTcKJdLTpB26+qgyjkQC4sXF/ityt04iMWCdW6ngwSFZ4t2cDu8S2
 G0x0C9vBlFJypsyUpjezca0IbYXOuq4x9uGY6375ye9NXQ1W3aIk8XlomT5bQQjW5Cu7hGU3w8Q
 iY6rZzkXR830WBxN9oYKdPUifPWNNtNLTWelD77i99J0UrhIyXwTCgMbTcYT0Sh8jLx5c2j935c
 lDwOMNl9gflOhaRpjlfjoiRMaUm0C4RcIUbMKtPzQD4vJOR9J0erHq6cfiLb8gN3K6tGHGG+5U7
 KCJGmfvQ8eL7TFe6yKpqG6GalZMszfOsE+3KuTZ0R1HxUMWIDTYvbnl44gwy6zJxnPllNR4z3KZ
 bEqObXVHpl3wpzbE4xxz4PvRnE
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-2ed09fcf030mr4297745eec.7.1777486948808; 
 Wed, 29 Apr 2026 11:22:28 -0700 (PDT)
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-2ed09fcf030mr4297721eec.7.1777486948269; 
 Wed, 29 Apr 2026 11:22:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm3488820eec.1.2026.04.29.11.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:22:27 -0700 (PDT)
Message-ID: <9bac61c0-cea8-468b-85e4-4764345dd1d5@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:22:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target-info: introduce TargetInfo in QOM
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-3-pierrick.bouvier@oss.qualcomm.com>
 <177745176382.2166241.2505852709346670944.b4-review@b4>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <177745176382.2166241.2505852709346670944.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yQqK-xnogT-x7SjtnyG8rNrfxpCA1BUF
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f24c66 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=3R7k_jIcLOV8o9l05CEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: yQqK-xnogT-x7SjtnyG8rNrfxpCA1BUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4MyBTYWx0ZWRfX9LW7kPpoD5HP
 DiBvC7y1BImSi4jQ2CTVRR0fEJi2aLNVpeZMlgHfx1K+10bqQp09Mky/8mFEHygtAhX+w63iIWF
 08chHODRYxSRG69GWthxH8J2wXymF2p828r+Dto90j4gQEoKXkkY20DW9ZSofbnIsV3SA+xFCTr
 baQrbgSGYZMq9O/lIZG2Rnr9IrgnfUg3PwVRCZSUpEjE/HexGZD8TKi1FwL+V0lelFOmCeuJu1f
 qgUw9elij2sLGUpy1MDetKAhus83d6bU7FLFc9Wpz/Z9vg5q+4xsBsC8BmFGOqkkw6JRF56uF5U
 OrAzyqxzB5d4Orf+OqrdlC+DpKxXx4aRoIGO2sREzSA6qz9yw/gijBgLFnzBaAerd9zWH9+ZjyL
 I37xMWq7OjF0FtpIualMoHMki+VqVSLDtQBaXr0WuvvRHaJnPT1q6EaWZjQdKdTFMWZHSbaZE93
 Nx0oXAOVLJBTZ7oCXJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290183
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

On 4/29/2026 1:36 AM, marcandre.lureau@redhat.com wrote:
> On Tue, 28 Apr 2026 16:45:15 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
>> new file mode 100644
>> index 00000000000..db069db718a
>> --- /dev/null
>> +++ b/include/qemu/target-info-qom.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * QEMU target info QOM types
>> + *
>> + * Copyright (c) Qualcomm
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/target-info-impl.h"
>> +#include "qom/object.h"
> 
> Missing include guard. Add:
> 
>   #ifndef QEMU_TARGET_INFO_QOM_H
>   #define QEMU_TARGET_INFO_QOM_H
> 
> before the includes, and a matching #endif at the end.
> 

Oops indeed. I'll add it thanks.

