Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8440CD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZJtl-0004Ob-P0; Mon, 15 Jun 2026 22:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZJtj-0004OI-8c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:51:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZJtf-0003mj-Np
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 22:51:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xpdc1767780
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6le1j4AiD3ULF/0wCrKu5z4qHYidmrxp0EhoYlVFwGI=; b=j/sT+TnPimsRnudD
 xl5cDTzD8d+9KKlqBnQ05ZL7MVzKRDLxFicPPG4XNMRplN3AVzmN/uEESm2aiSQ3
 5nnhpqKhXkAL8NnRyXfwQMsvPks848RfxDS+g+iGZ/UWWdkj7Vt95b/3QyLBQk9p
 rt5HPU5/wa5opPGICSzEHun8VQnX8AMOM3jBtX5Z+Vi/rKENoKjhpeHNtsInxP5u
 YSF6Fu8jSpwWnqy7eoibefsnSILAzjlKqKHazICsgz9x5kmloaXBP/H5JiFNYwIZ
 YHrb3ilmO+HTWWLOBp3l8ao98cNtbToVCpZIPreezWSOQ3PHK9rzqYNQr8rnR/3Q
 RvFGLA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydcae6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:51:25 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso5109413c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781578284; x=1782183084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6le1j4AiD3ULF/0wCrKu5z4qHYidmrxp0EhoYlVFwGI=;
 b=RBRoPyO/wxsqe0Z031d/CKJzeLsge4Y/zdAZ9OeNXvEzaJloCtYtxNz9utvcxWSL6v
 Iv61J3QhfHREyqTRqb/o/5lG1nFqTVQmS87xLaxcP4Ux8up6WlPBnoY1Y03BUFkiDD1x
 CyIvWFR7ry0qXx5W1GXwXVqIx3Aw3uvKRr+rngjVntkSn+fE6TJmgmACLrewkNUhJgi6
 4DhMirdR7+fSSf/7Q3dRS6Ibn45j7kgxIcTZm7W8rZ/ypcpNIZl2rypGmHPHJbCDbAL1
 GjGPJ/GZx3tAan1paoIDaJAUTV19+68N6vYp0s3EPpNrK8qOoWNtdOQnjGhn7LfIoyox
 8VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781578284; x=1782183084;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6le1j4AiD3ULF/0wCrKu5z4qHYidmrxp0EhoYlVFwGI=;
 b=W6fTKd0dtG/OWkmIr8PHfEezRFb/Dw1z7dLz1L94qW9FDKWHkZ8tc/NT0KDjArHmHM
 C+rXItD5DnvCd0g3LaI/gZdw0v9WTnFwMjeewtdoi8vNdck9WzA7sRdBD4y8BRGtCoQy
 W7V+AEWjBYSRxJnUxjzLR2OCUOOSpzG/QgurQWa0tM/WqpYPBVTTevE5UlsDS3ixGRDe
 YlIEq3erWeY9NqFsCDpgzlheUomKfJaVdIQ19qCciaTS1wpC6SiJbDOUwlOtE3Ysg3af
 it3iao8EbxNPuKBuUlbav96Pjd17ymUd+ul0DJ90oFA32jd1xRJ47H1l1UT34O+rLPP7
 udLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HQcOgv4BS+6jUdITKeIEsf2ATGOCm+NRGhjxf4uIzEfa8l5lU3+I2Ic3gGgP1BexroAlC40y0NSYs@nongnu.org
X-Gm-Message-State: AOJu0YxTDK2YafHRo8iairl6vX5+1GMBcjjn8L1H47QePiMkV1NQF8xh
 h1jzKDzYclh9VSIzfddXXOOmsxptTYX2oIwzX0VCcb7dgxTsVJ2yQ+WBYPI7nS+oFxLLiJTnZBe
 ljK45o2s+6BhSVGyZ7iSwsT9MdmnB1XW4/yWZyci22QRgh0eu4jtO+2QmcA==
X-Gm-Gg: Acq92OFjr9jXERPjNutpBWFZxmbnZ4hEuZOHE0qxAs0IU22eNEiaOTReAOApQV134B8
 c8wKeODpvZ4DibDWEneV3EojISCCXGiX1fwm7xdIvM3kgoUfickDlqrqKZe+L8Q3hMtGfwtun63
 Dyp4/8QbV4yEdgTk/9IbS5PUN/Umq8ca9UD94JBzJGK4XIZVQ8elNs8g9acf/wPmTiiob43RPNu
 mBnO2VXhFNqCDY3TQqlG/eVEUJlUyRRMptSKTxWlGp6N2X9YsS4imzfcBphG6ZN3i6YqFu64Bsw
 qKKGqe9c/5Ep3PgI8FRNRZ3HjBLwsV5poxXYNmSmxmDk0Tj/JYfbv5aqLlCrd8KXxSLv0rrcRlM
 n6ElhqwH5SQzRO2pk5Klr37jZ2OtMTzJ79Q+G20rU8vtNyNlFIYiVpS2wlsjSFv5b4J5bk+m0bF
 M6oz4+A+JQXxX2Rg==
X-Received: by 2002:a05:7022:e981:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-13985f218bdmr736626c88.21.1781578284265; 
 Mon, 15 Jun 2026 19:51:24 -0700 (PDT)
X-Received: by 2002:a05:7022:e981:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-13985f218bdmr736622c88.21.1781578283726; 
 Mon, 15 Jun 2026 19:51:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b8f9927sm11723730c88.1.2026.06.15.19.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 19:51:23 -0700 (PDT)
Message-ID: <36f118b4-8e24-4425-bc45-df2f13651c21@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 19:51:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <05604cb4-6f61-4b64-90ce-505ac87d8a04@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <05604cb4-6f61-4b64-90ce-505ac87d8a04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7SWXRux9VqKsnRfAl7QIVUpVWxR4Z-lW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyNiBTYWx0ZWRfXwewd1V6X3vqS
 bJdsYaYFvpefnX12qjScUsHI6VzFUTRW+O/H1U8oMf1lsvj7lB131cp7+GYHVbxHVT3cnyWgPQV
 c15WeJgyKX8a7GauWjXizuq74LFUf1A=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a30ba2d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=z2WGnw50htpaKr-zXakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 7SWXRux9VqKsnRfAl7QIVUpVWxR4Z-lW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyNiBTYWx0ZWRfX1GKQMyQ4Xa7A
 4aBkb8Hn9RPuEnvebyGFvrcDoAnbev6xWaoH8A1YUHZlN7oqTGPYX7yEt4mmClw3dsRunFFSf6p
 nkQNf0e/Asq/03ijoAFKIJWQoHG4l/H2dkO0vTKl+++YnjU42peZdYXZmc+J//UOs/ErSnlwSKL
 sWzwqgLKuIoewoKz+VQ/KJFw9wjTcvJFXmQcDdcZbRMJkrcf+IXAZPhA0vnHV6Nvxb7iFDuNeXA
 TdeSK3YRiRTr/zWaZjTSkpBIgyITu8j45IeHmeyCcDFCUj9rGX3frbvImfkxr0CuSFRlmqrdp/T
 TRBU6Uri3a6nVejpM1c4TefiaWB1abxYjj11nHz4AWCydNzu48BgVOFYXTULBJkmxYAF64j/WE3
 utkuJQn/2dx25QIA7icoaswMl55TyfIF2t/ud1YuIw6U9OUDc4BT6TConRAYKRileZxEGYD0YNY
 mnqAjFn+YleQJSeFQnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160026
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

On 6/15/2026 5:35 PM, Philippe Mathieu-Daudé wrote:
> On 15/6/26 22:17, Pierrick Bouvier wrote:
>> We add a new script: scripts/check-maintainers-file.py, that will run at
>> configuration time (and not at build time), to not hurt build time.
>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>
>> We can expect things to be mostly in sync since adding or removing a
>> source or test file will trigger a configure step.
> 
> You mention adding/removing but this script only checks for removals,
> no additions; did I miss something?
>
The initial scope was only to check the MAINTAINERS file itself is
correct. But while we're at it, we could extend the script to check that
all files in the tree belong to at least one maintainer entry. This
could have the benefit to force coverage for all new files. First we can
try to see what is not covered at the moment.

What do you think Markus?

>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>> build things from scratch and always run the configure step.
>>
>> With this, it should be impossible by design to have an upstream
>> MAINTAINERS file with non existing file entries.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   meson.build                       |  5 +++
>>   scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>   create mode 100755 scripts/check-maintainers-file.py
>>
>> diff --git a/meson.build b/meson.build
>> index 19e123423b5..57e9c9de42b 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -17,6 +17,11 @@ add_test_setup('thorough',
>>     meson.add_postconf_script(find_program('scripts/symlink-install-
>> tree.py'))
>>   +# check our MAINTAINERS file is consistent
>> +check_maintainers = find_program('scripts/check-maintainers-file.py')
>> +maintainers_file = files('MAINTAINERS')
>> +run_command([check_maintainers, maintainers_file], check: true)
>> +
>>   ####################
>>   # Global variables #
>>   ####################
>> diff --git a/scripts/check-maintainers-file.py b/scripts/check-
>> maintainers-file.py
>> new file mode 100755
>> index 00000000000..b001816a401
>> --- /dev/null
>> +++ b/scripts/check-maintainers-file.py
>> @@ -0,0 +1,53 @@
>> +#! /usr/bin/env python3
>> +
>> +# Check incorrect file entries in MAINTAINERS
>> +#
>> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import argparse
>> +import glob
>> +import sys
>> +
>> +
>> +def check_one_entry(line) -> bool:
>> +    return True
>> +
>> +
>> +def main() -> None:
>> +    parser = argparse.ArgumentParser(description="Check MAINTAINERS
>> file")
>> +    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
>> +    args = parser.parse_args()
>> +
>> +    found_file_entry = False
>> +    found_incorrect_entries = False
>> +    line_counter = 0
>> +
>> +    with open(args.maintainers) as file:
>> +        for entry in file:
>> +            line_counter += 1
>> +
>> +            if not entry.startswith("F:"):
>> +                continue
>> +            entry = entry[2:].strip()
>> +            found_file_entry = True
>> +
>> +            file_exists = len(glob.glob(entry, recursive=True)) > 0
>> +            if file_exists:
>> +                continue
>> +
>> +            found_incorrect_entries = True
>> +            print(
>> +                f"No matching files for {args.maintainers}
>> +{line_counter}: {entry}",
>> +                file=sys.stderr,
>> +            )
>> +
>> +    if not found_file_entry:
>> +        raise Exception("no file entry found - is MAINTAINERS path
>> correct?")
>> +    if found_incorrect_entries:
>> +        raise Exception(f"incorrect entries found in
>> {args.maintainers}")
>> +
>> +
>> +if __name__ == "__main__":
>> +    main()
> 


