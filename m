Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44AA60ACCC5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gYWCbWs5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N5o8KbXc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpBv-0001Py-MY; Mon, 19 Oct 2026 11:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpBt-0001Pb-Ng
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:22:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpBr-0003UW-CK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:22:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JE0JjW3401189
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LSg2TF6ZKvzNW9leVn44t/+sSoO7gtN/+8xj3iCatnI=; b=gYWCbWs5z6BxZv4s
 I6ynxstT5n7w9qEadfVlxdLiJn2PjouCc+cpVivt2pF7D+B3LOp0pZbHQVCSL6uM
 bCJcWS7lmFKdoHp5Fv+p0x/IPAwzm+6on6s1dQijwmk3mMKTd+tFCYg/L94SbsNY
 mSuR+RvGh0GRLJRcThlMVHlAf5zaPYdbEyet6co0v4WHLuSjivIC9w5SaefFVa2q
 EOhsAZ85g5ATKwhcnKL1bWiPvp0lKMgCGsiN/Ne2tPwGFZoJbvutqKvlRtMtVf2n
 iRnAUUjrV0F8s4r/na62Obc1PDutAjDe9p598VVmrmwrG5TMBlYJBodMRkIA/3Zh
 Zos+fg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn1p54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:22:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso604312985a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792423336; x=1793028136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LSg2TF6ZKvzNW9leVn44t/+sSoO7gtN/+8xj3iCatnI=;
 b=N5o8KbXc6paKcQ4aEaJaU9yzESAcGjfdPm1b2Btc/FBLELKMBXwagyJId89h6i3Z6a
 S0GZyCZqU9i238bGMoP97P2OYMGWQamPiXOZwcA05Pq5SBYHuONn0fiNTNBWIz4ucUZY
 0GhVXyLU1aia460Zkc+X1Zoauodq6DrD1VrdNcFm7h1meARVc30Sb/XEvPUyzwjsLyhp
 HdgbghEXUmjReu5Lm/8YRDb2pmu+2Ij3jWme7l6hwCq9qrKx9JAjjBJMTtESnmbMNu61
 Hx8fsWVNqkYHdTMMVjodiKmL/8cewij4EAEOOI6fFAGKNoQkU8eJdLe9YOOvWJoSwob/
 RQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792423336; x=1793028136;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LSg2TF6ZKvzNW9leVn44t/+sSoO7gtN/+8xj3iCatnI=;
 b=Pp1DVabkQqFslZqH650CoODhsdkxbcjpoYsFtzIaOLhQRdBHabYfqAxTqVZ+9Vzskx
 inNNRjG1ftGdmoTInt/7biKddovrqslnMdc2Uj4mYOGp1L8hWKi34sRCnmWG2lteTSuP
 IRCJ5qZ2hJVRQt3CV1SfKfiEt2nXRkhsqg4oES1/9pvH+Y+rIuEwdjcr5rbvC0ThZ5SU
 Oumf9tcJ/68sRK9CIwhxledJSAw9FWkld2BQs2TBDLXet2REC/JpI93JCOtQOpc+WvUD
 q8CGgtn2tuDVcJCCYop+lv5eMBY4a8Ygpp3I4jLla8dx2BiccIOzslhZy30mSC/CH5Oa
 tKnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyo2p2Tp1fUr7hpIgvFbJtXNT4qVDEeNnnQFfO+hpWfIuyyJzYpLkkBaqcbSBhwbd4wQVMfufj7n5+@nongnu.org
X-Gm-Message-State: AFq9FYLT2LAiR1ihfHnwPOdazlGlV7fxPAPv9A7Gfq1Px1ctJF3Xcdv7
 b2nTjQeW75Mn4T7/iiWg7ym8GEt7OmtQWIG92/Zd07fyoArskcexmVSBHEfD2yicrPg1zUHyHTQ
 n+qSbjgow0fGi+CJub/ABIfSwoeua1p74qx/K6YFOP/HI04TWq3p8oEubvg==
X-Gm-Gg: AYBFou0wVTwFFU8RMQ36oUAq0wbBsbsIdjtmzen4IPsKLxedN1YYLF8ZzgqwHdmZ1ct
 Sj4AYOtqxBPSCsD39/KCZyQ56xi0iWvT4bXNdCj88eOZoogEBFzfG+wI8egDBeMcYeZNCcLQR60
 J5NMYDvrqvLf3F0LwenCHtBfBNDeaaL8WvjEvkXDhmdUbo+t86WVmyo/HxL3LnDJxi6FcaPaUGm
 GwAZOGu26qrjNzsrBVya+lQDZHrFFfC1DbzJ8FyUCwGSk6N5L+3jXjsf+Sr3AwMRcyF2y5LDNpW
 970DfxLlRgAKHLqh3jSjQgvHQzXEuipi0LBflu7tRoGECPTuWlCKfX1HjoclOS6xJiUwsbwdsm/
 4fzj2BWWrbXUnOSlpMt4L3H72HgEq6tkb7bECjv6l7hlfMq7oVCFUdxX7sspiJe6Z
X-Received: by 2002:a05:620a:4608:b0:93e:fcac:a91f with SMTP id
 af79cd13be357-93f17f9f371mr1797055685a.37.1792423335944; 
 Mon, 19 Oct 2026 08:22:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4608:b0:93e:fcac:a91f with SMTP id
 af79cd13be357-93f17f9f371mr1797050185a.37.1792423335374; 
 Mon, 19 Oct 2026 08:22:15 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c01e833d9sm3247196d6.29.2026.10.19.08.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 08:22:14 -0700 (PDT)
Message-ID: <66ae1e1c-edba-450d-9fb1-9ad8cf710dd0@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 10:22:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
 <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
 <9ee17c2e-5f47-40be-8741-cda9390c1e04@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9ee17c2e-5f47-40be-8741-cda9390c1e04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MSBTYWx0ZWRfXyleMXax+g/y2
 SiF2qUS/4AZqz0Gdj4va2ooqoUkEQpvfTdPCTcROpG/fvCKn0eJUo/QCOqn5eVVbnP4OLdoP43y
 ktJ9MQCxhKtdUdHyGO/J0Z73qcox5t4=
X-Proofpoint-GUID: XdrvKvUqVEhxny3GSZUi2M8A5azG7Y-r
X-Proofpoint-ORIG-GUID: XdrvKvUqVEhxny3GSZUi2M8A5azG7Y-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MSBTYWx0ZWRfX97zcnWxWT3tY
 6WCIuf5WbaGWvtPGjL3yz5IMh/jvEnaDoFqtsIIIRLRwThfrphtDv2Zb+mVxPvHVn1KF+QSo+uF
 aNNkBl1s/Qndo6xPxCNqXuEcjP8GfY+oOFHWtYgHE2dY0vR7UnOY5rPPI93IZImc9aqckueREfe
 EPL/+Ibb9l+mwixm0vFC3B1KASSQPqxtl+UuFnmO1IL/ToXnJOCEC2ac3Jy2ZG4UTvrbmE7wi3z
 1HRlCt3fYC/IEwPZs9WJU/MT+UT+R6orGQPKEvhYZUvmQqPrNW1/pqSgxuOM9K3kthu5SIP5nnP
 +HqZ8XhcECh0S2HqynA8Jo4Me6zs3/SXIHwJ4+KjaYw3dV5bRIv6EZXlncDyg3yvmI/4JNcWO9Z
 Fg8D55+gazDO4MHAHKe1Ip4YF7i+OY8jHqMvlClv41sHeBXZN6ZB0SsATLRPS1E6w7GcrpAmXG0
 +Ksz9JFI+PHTS9FFxrg==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad635a8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=NI66SgwwdX6N2Z_EC54A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 8:51 AM, Brian Cain wrote:
>
> On 10/19/2026 8:47 AM, Philippe Mathieu-Daudé wrote:
>> On 19/10/26 07:52, Brian Cain wrote:
>>> Download the firmware and run it on the corresponding DSP machine.
>>>
>>> The images are third-party binaries, so the tests run only when 
>>> untrusted
>>> code is allowed.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   tests/functional/hexagon/meson.build          |  2 +
>>>   .../hexagon/test_qcom_dsp_firmware.py         | 89 
>>> +++++++++++++++++++
>>>   2 files changed, 91 insertions(+)
>>>   create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py
>>
>>
>>> diff --git a/tests/functional/hexagon/test_qcom_dsp_firmware.py 
>>> b/tests/functional/hexagon/test_qcom_dsp_firmware.py
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
>>> +    REPO = 
>>> 'https://gitlab.com/kernel-firmware/linux-firmware/-/raw/' \
>>> +           'd947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom'
>>
>> 404: Page not found
>
>
> Huh.  Maybe I picked a funny commit and somehow the asset cache fooled 
> me?  Will take a closer look.

Disregard: all is well.  A "wget" of one of these assets works for me.  
If I paste the URL into chrome, it downloads the asset.

But if I browse 
to https://gitlab.com/kernel-firmware/linux-firmware/-/raw/d947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom 
I do get a 404.  I think this is the expected behavior, though. That 
"raw" mode for the URL expects a path to a file object that git could 
serve up.

If you browse 
to https://gitlab.com/kernel-firmware/linux-firmware/-/tree/d947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom 
you can see the directory listing that you might have expected. If you 
apply these changes to master I would expect `check-functional` will 
download and run them (w/the untrusted code bit set).

The sha in the URL is inconvenient and unclear so in v2 I will switch to 
a recent tag instead.


>
>
> -Brian

