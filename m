Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D20606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cYWAusB/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OwkAWxnx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvSL-0001Bc-4O; Mon, 19 Oct 2026 18:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvSJ-0001B1-BW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:03:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIvSH-0000td-9s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:03:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZPvX3963955
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bK5VEJEozE4V2EmEgl4PvzYXe06aZDLOtl0nhciRAkQ=; b=cYWAusB/KAXx59rn
 REMiF565/wCosCwKQT8F9hpGHAqv9RIVZXzVHAIW9xgYrli3WFDp64GFFNPAie4K
 FfLi3PpyK/GH6RqgyWoU81L5ZZKJc3Zlj3LQRXxqGTuKxDcsZpZKGEPAo6HcUyuA
 s7D8CLngyq/Mwure1kDbFBWO7WqCRUuhFRKDkMGi9u2H/RMha5E+3yeV5XQGa0YZ
 wz0vlhdhvVizNbSG7r5ODBJsLhDb+a9I2WfBDKQ/0hx/bSub76knCKQaZPG+NFq3
 ZA67dD1IXvjkPPrYzc45Ih3DxHQFL87Eo/JmGjccUIzd2ePS6Jz95N4aOSTJYIp/
 e3yL3A==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbf1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:03:38 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0e757e70eso30537707b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792447418; x=1793052218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bK5VEJEozE4V2EmEgl4PvzYXe06aZDLOtl0nhciRAkQ=;
 b=OwkAWxnx0To3r4v2iPxazS3sMVknp+IzFReTWg2TxQO4K2Oo1NJzp3wZxmtmCQuGG8
 OPC3brnQ/CnJF+pSEkPI1ce1bcOpgNv6Bz0bKDio8eR7xZNOeAfcYK9HRYTi7oWFqf7t
 /VjKswwx/51oSob5X/7HsPS11CxYArGYfT8KuplEAS+92+YNSTPRjP+2DyOR2A0aJ/rP
 1CJtZxbYbSciTIK6UmfXzQyUT+GbK3qZt2mdgbaOyj+2Qy+UII5P3uR50lP5CjT14VZP
 6VVH0kth3AwzF7XQODfEHUkMwNuefP3bHtQcofwxchATc9VsLA5hIaG6EGUcBRk2dh5V
 ruNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792447418; x=1793052218;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bK5VEJEozE4V2EmEgl4PvzYXe06aZDLOtl0nhciRAkQ=;
 b=BFj947YRoyaCWbPTiY2wwrxRnRa/eKGV50U+H5UFIdNkbATJ5fAfRqYdcEx5SbzoCn
 G5mx6SQdNvUzUClN3v01SWs+suDd5ZQ00jwPVDaCJbnzvvQpkzkR8JLt0aWx3Awuly11
 SHZdCl/VliYeC6JvM4RGq8J2yaeKvJHOJEbxRZhZyuoIfWkETjeW47gs4Vjrubwj8SMW
 QGjkH18qH/dlKFvxQTYT8YBRSGDBTIzcjFPRxNj/ayHiuXxL7r/qf618WtG6R0NuNZp8
 VzcVx/4P9KqhZXPC3jyESrK0WPqFonIsNw9zcEHiE+GEFOX6cmhLfG2XNTWBad+kbLFl
 1Qeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwltJ4LSR6qRNSq6nbeDW5zOEKGJNLnPxA5Z42lIAiaL504kAIAhspF+1qqnKMB82B1C2N/7AliMtXL@nongnu.org
X-Gm-Message-State: AFq9FYKg8KJj0EmHBnpI+GCd+rUQyYxB/5WEPG0ynubl8kDbhpO0mcnZ
 XqRbTpCFeQ2awIK1Kp0knr5UbtkFuDFZjsYTgRbAa0GylLQcfDp57ejomNc4x/s2p8umke8OxkH
 HHEyaXs0xEkt26qoJtahPHmgusu6pdYtyZ5m9sJ7wM9B2xQVA5It1pOG+MQ==
X-Gm-Gg: AYBFou1SpIjBKPwBjMYvdhIhhICFTTzIfkq7oPspq7Fw2NQP/Gn0L3pbtaJa9iiPWNB
 MfDAtgSZNqQs73xrkCjNx6W2xDhplGN394J1h81v6O8SrkKLSwfS9iim0lkCEOhkffAydRqoWqA
 3LFF8Q0yWD4LzI0dTcAUcKZxSzTYvbQ7Mow7EbGR9QD1YtuHlEtFDnqq9nCzCbAQUg3ry9jW940
 NBc3/JxrYF5knFhj+7qClRr2sra7fVcOBtVWlpfe5R0ZmdopuUbKBYXZz+CTWstOjbMML+4ClVr
 uQcaNiS0RAioN0Zf56KqJ3lEssOEH1gMTGtW+TzixUbe8EeR9Ekz3Hefws+2gLLOMCdJ0LeKmeP
 pCV9yFacHAET2hmUIL+KdCH9lXnbEhEPJbBsMh+7mHxR0Qvw24pgio6ZRLb6XQaNzXUX65IFvl2
 oous0=
X-Received: by 2002:a05:690c:a5d6:b0:8b0:a08f:2ad0 with SMTP id
 00721157ae682-8b0f2164cb7mr18590337b3.21.1792447417784; 
 Mon, 19 Oct 2026 15:03:37 -0700 (PDT)
X-Received: by 2002:a05:690c:a5d6:b0:8b0:a08f:2ad0 with SMTP id
 00721157ae682-8b0f2164cb7mr18590267b3.21.1792447417184; 
 Mon, 19 Oct 2026 15:03:37 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040d4cedsm7325856d6.34.2026.10.19.15.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:03:36 -0700 (PDT)
Message-ID: <da67ede4-637c-48b0-ba0b-967d00961ebb@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:03:33 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
 <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
 <1b490155-917b-46a3-aed4-3878869ccd14@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <1b490155-917b-46a3-aed4-3878869ccd14@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b2UYAS030c1n69CdAUWca15rLidnrHvC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NyBTYWx0ZWRfX1U2Z0C9vaulv
 Px1VENPz7nn1N0zHkoHBiXyqkwj0pan/S1gq11HwIocg07144H5w8mKKNdNRUmXMqEoWUYov99G
 KSJDBBNv2qxTfDIdXMgx/B79uM7en4Q=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad693ba cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=NI66SgwwdX6N2Z_EC54A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: b2UYAS030c1n69CdAUWca15rLidnrHvC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NyBTYWx0ZWRfXw85p1YKLztuM
 1jZrWGIpbBY8EjfC3mmFQzDiU1cJCYLHWitJ90ddUON8WNS4mUp9c4Ty9Y4jurukVbQ+E70xmjt
 bfe60Wcz1ACCTZM9T4nWI/6g0Cj9eNHGhAer3W3zRkOR+ZnA5KANEP63mkd5Xzpf015zB1s+t+K
 oO027P9AlFXfTo8scLbMWid/lR3mIu6EMhTla7EbmGX/LxkR7d4rnumjF75599d+CjwKByzUj7M
 rMNM/9fNOZvSTZe/ZDzfUzOy7v51Cikn51K5uMj8eZtd6uKh3QoMzWAGr+kTOS7QQYf1A1+5JOD
 om5Tgd0NqPdi1aP+VDaOby7HwIGBb9utDnBJOIHHK/l02qgr4/nLnMaF0uQzOgPl7WKj+3ziKTR
 KG2I/V7C9yJRD8jzot4zaADfssgBeOb3BRVEyFhUeGiVs5MhmJgId5E6yu2Pn0XqlDqj//Lzp3v
 xAFwc6p2RzG+JaCZdvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 4:50 PM, Pierrick Bouvier wrote:
> On 10/19/2026 6:47 AM, Philippe Mathieu-Daudé wrote:
>> On 19/10/26 07:52, Brian Cain wrote:
>>> Download the firmware and run it on the corresponding DSP machine.
>>>
>>> The images are third-party binaries, so the tests run only when untrusted
>>> code is allowed.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    tests/functional/hexagon/meson.build          |  2 +
>>>    .../hexagon/test_qcom_dsp_firmware.py         | 89 +++++++++++++++++++
>>>    2 files changed, 91 insertions(+)
>>>    create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py
>>
>>> diff --git a/tests/functional/hexagon/test_qcom_dsp_firmware.py b/
>>> tests/functional/hexagon/test_qcom_dsp_firmware.py
>>> new file mode 100755
>>> index 00000000000..86a0628d9f3
>>> --- /dev/null
>>> +++ b/tests/functional/hexagon/test_qcom_dsp_firmware.py
>>> @@ -0,0 +1,89 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Boot the production DSP firmware on the Qualcomm DSP machines
>>> +#
>>> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +from qemu_test import QemuSystemTest, Asset, skipUntrustedTest
>>> +from qemu_test import wait_for_console_pattern
>>> +
>>> +
>>> +class QcomDspFirmwareTest(QemuSystemTest):
>>> +    """Base class: the firmware is the ELF that -kernel starts
>>> running."""
>>> +
>>> +    REPO = 'https://gitlab.com/kernel-firmware/linux-firmware/-/raw/' \
>>> +           'd947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom'
>> 404: Page not found
> This URL is incomplete at this point, it's just a folder and not the
> final file. When concatenating sub paths, like "qcm6490/cdsp.mbn" it
> works fine.
>
> It's confusing to our (qemu functional tests) mind since we are blindly
> used to see the assets full URL here, instead of it being set in each
> subtest.
>
> @Brian: To follow the existing convention, I would recommend to
> duplicate full URL between assets following something what is done in:
> tests/functional/aarch64/test_aspeed_ast2700a2.py

Ok, will do.


> It's a bit "Do repeat yourself", but at least it's not surprising.
> It has also the advantage to be easier to replace url if files are moved
> at any point.
>
> Regards,
> Pierrick

