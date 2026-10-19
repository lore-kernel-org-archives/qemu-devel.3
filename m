Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15402606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QAVseMWO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gr7wK6S5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvFl-0007RJ-8E; Mon, 19 Oct 2026 17:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvFj-0007QL-46
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:50:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIvFh-0008ND-8K
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:50:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZh3s200608
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a/lvMlDiAeyp8g3lv+YMIs1Z4tFUVLS9zznTaQSuFZA=; b=QAVseMWO0WjTWM2Y
 ePbRsaLonfj7a67Bhpo1KMPMfSQJo1XUEtrPsJgu3CR8eMtKvqyNJBkOEFiIKpNH
 knONb7D5j9NlSjRGWNmgWsdKMj5A7ElYXDmvOLsfKzzqhXCXEAvm89nNgqdlfhty
 cfNVK49FuYJMVHtl3QNKiih7tiLATZ70shk5lFS2BhmY8h0BxoqYzUxOF4bkTaBC
 3ApGXXHtZxzA3htOJ5bmM4FNxwGCRCK5qE6oguTI7ON+Kt4j+BcyaEoYbbq714wT
 WwKsrSivirqPHWdzJfR3U/dcx+G/HRHAfAcCPVqgnLC8BwYUwE3MibF2E5xgggqs
 WzFPIg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780rk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:50:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so4313757eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792446638; x=1793051438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a/lvMlDiAeyp8g3lv+YMIs1Z4tFUVLS9zznTaQSuFZA=;
 b=gr7wK6S5SLcW4f/83tYhinz0aLZVJoFjrG8OmTpOarMZw/3v32mCHDPx978jg4hTnX
 coueWs7g7xlH4zaoo5dDJU0h4sqGx5NMcD2S4GG2J4aV2IHf5K4lfIgtZ44THfqrsrFp
 Wxc0WaAWEfCDkUxs8Z9YOkfZp69rF9AIAc6GyIVnI7Ezqrei4FpjDSFrW98SrFg5itYh
 184sg+APEJ6VDl1dPDHjiBkyYux9XC8eB/TtiSiZs0+RLyzCxIpeesnQ47f0exPN7pAY
 0qexxExBc+Ty98W7ja1Da5npluieAid7nSAcyCPFMX8dNe9bY1LGseSBLfGfw/6FvvUP
 vuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792446638; x=1793051438;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a/lvMlDiAeyp8g3lv+YMIs1Z4tFUVLS9zznTaQSuFZA=;
 b=PkDvPpohRcxb1CXGRUJo7neIRFS0WWjKveIdhybbffcO3hv8g+IFyW/rQENJNUZKX5
 KnPU7FQ/iNFziBGc4vu7uT3+YtGmKpAkkwre1+FfnmtNgVAJOv5wgFluKNCbfs5bPjJV
 t5Jjpr/ueDdWjMyBNFjDyBlB1NaWVKsDwsr7P+uKY1Ztm0VqQbAzqZwqL4AELhoPTP3b
 d+QIet9diI+D+nM212bZsY/vyjQKfv3QCMxCDFfnkL25BmFLqe7BeocsXoItbx1ORMCz
 ZQ/JLg1XJHbjD7IILmqsz/YQYsAEtwmFgk9tkXc00mTtnMaaWuUt8RH4wFnujyq8I/Dh
 rAUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/dzJAeal0I6LPwysI1cwawhJxlSxaNT2RTvIxeC41oWEHWBhskKFAlH+XEX9RtUOo5Ylmtt3Ik2bG@nongnu.org
X-Gm-Message-State: AFq9FYJt//yrAfikGXFu+MTv6gr9b6Byh8itaMFpfRkXtR/mN+zbuCU8
 HHvDf2cqrEeCHyZEkGJGG7WhaVJbp2DcqVa3tePsMdPjgqD2Zh2/WnQ/4yAF202o4ErG89B4A6z
 o+3nOZXcDSVpfZUdyqusJzjpY2npQ8eS5gLsuZQRYQBLGJlwV0XVM4XpfKw==
X-Gm-Gg: AYBFou2jwVR9lSfzyjW2ZTYXznUW/53sLEPoim6FO2qlz+RhHpZ8pCy8ArGuP+Kc/rQ
 w+8+41ztnw7l5480V/UyEjDdUmXhTGpSkYQ9OSEe1bnsO5japsvfy1PLXQYc81yqkTjwqxdR97W
 stGbBKyvRurhvBUYXCw024Vncj6sbBjzXGnV+GNWPj4sJ8PHHg1oj0A2legyiYaqWgVil7UeOML
 tVtXZLgRJhXjcAIiOicInKmDXuEcLZ8cDOk9Q1DDLaqbScKW46P9de8ulsRyUpRQ8yxJwV9W7b4
 uHmFYjvvapkkUpdzMNHurq2RgUebO0YGAdnT0+uckNVwzLdRzx6Oo5DwsJzi35kWJQDZAOZmI6l
 I1OVcLMGRQ71U7dv+Cnt/Nhd3jewExBwYBKRaxgPuE3HeL0YrHF76NKzd5g+cLpkrblqH+Q==
X-Received: by 2002:a05:693c:6390:10b0:35d:95e4:267d with SMTP id
 5a478bee46e88-361a2645788mr13039229eec.27.1792446637888; 
 Mon, 19 Oct 2026 14:50:37 -0700 (PDT)
X-Received: by 2002:a05:693c:6390:10b0:35d:95e4:267d with SMTP id
 5a478bee46e88-361a2645788mr13039182eec.27.1792446637306; 
 Mon, 19 Oct 2026 14:50:37 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082784ec8sm32794818eec.22.2026.10.19.14.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:50:36 -0700 (PDT)
Message-ID: <1b490155-917b-46a3-aed4-3878869ccd14@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:50:35 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
 <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NyBTYWx0ZWRfX5qFCr749T7PH
 EBQ4vb6ONqbtxkiP0c0ThVGUCOb1A9hEotAg2dsszNQaGlL34CxEpRorgHzXyC5brG3NNwte29y
 HBikNmXKD67dNp2DQGhjlt3pY5HBZQz0EsUerK+YM1S0OsqVDCqCgVRwo36UnsWN47tUvBdswnp
 /fRoXdrtA6zO55/sfXmRSFMPZpAzMUYEeSTgEFCrHiX6yJy4uAGRX+dLLQ4xFMy5NpBMEOYo2SG
 C793f0EaaUAKlHenJtUx3+S/vm5CNR6Cq8QstbgD7Fz+7OB/PUfir4/PjRsqy03au6wY4gLIzH/
 Thn3+2WYrfx6G2/jepx+SaGQNSw1dSLybgajz6TaN6edD3/NMTqx9FiYKAhegAX8o5FKbRcbD5O
 WoflCD7va+h1X4BXyXMjWTKMhpYawDh+rn0ss0ODaF5BTTHi03/rnxcxiCFtLdvD+K7S5HaXlt8
 ij2QX5ziZw7t+LDD+Sg==
X-Proofpoint-GUID: -Ta4ytySUJJgh0_C058W0LE5dWQLZKFk
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad690ae cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=C4cAvmTmPAeJo9ekjq8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NyBTYWx0ZWRfXwchy+24aMtTJ
 cxCDRW/mKlsMJRJayYSHyEMP51MDQAUc8p55PWPoPKjQQXtc0xAQx8Civ9IqL3nUJHcvVlD64gA
 rNA5YjdY5RTsvVlJIS29j5CI0/3LsS4=
X-Proofpoint-ORIG-GUID: -Ta4ytySUJJgh0_C058W0LE5dWQLZKFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190087
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

On 10/19/2026 6:47 AM, Philippe Mathieu-Daudé wrote:
> On 19/10/26 07:52, Brian Cain wrote:
>> Download the firmware and run it on the corresponding DSP machine.
>>
>> The images are third-party binaries, so the tests run only when untrusted
>> code is allowed.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/functional/hexagon/meson.build          |  2 +
>>   .../hexagon/test_qcom_dsp_firmware.py         | 89 +++++++++++++++++++
>>   2 files changed, 91 insertions(+)
>>   create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py
> 
> 
>> diff --git a/tests/functional/hexagon/test_qcom_dsp_firmware.py b/
>> tests/functional/hexagon/test_qcom_dsp_firmware.py
>> new file mode 100755
>> index 00000000000..86a0628d9f3
>> --- /dev/null
>> +++ b/tests/functional/hexagon/test_qcom_dsp_firmware.py
>> @@ -0,0 +1,89 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Boot the production DSP firmware on the Qualcomm DSP machines
>> +#
>> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import QemuSystemTest, Asset, skipUntrustedTest
>> +from qemu_test import wait_for_console_pattern
>> +
>> +
>> +class QcomDspFirmwareTest(QemuSystemTest):
>> +    """Base class: the firmware is the ELF that -kernel starts
>> running."""
>> +
>> +    REPO = 'https://gitlab.com/kernel-firmware/linux-firmware/-/raw/' \
>> +           'd947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom'
> 
> 404: Page not found

This URL is incomplete at this point, it's just a folder and not the
final file. When concatenating sub paths, like "qcm6490/cdsp.mbn" it
works fine.

It's confusing to our (qemu functional tests) mind since we are blindly
used to see the assets full URL here, instead of it being set in each
subtest.

@Brian: To follow the existing convention, I would recommend to
duplicate full URL between assets following something what is done in:
tests/functional/aarch64/test_aspeed_ast2700a2.py

It's a bit "Do repeat yourself", but at least it's not surprising.
It has also the advantage to be easier to replace url if files are moved
at any point.

Regards,
Pierrick

