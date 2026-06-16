Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DFBCD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZHmF-00054i-UH; Mon, 15 Jun 2026 20:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHmE-00054A-AB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:35:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZHmC-0005xR-7P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:35:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0Nuvk1584868
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iyNHJu2rfq7X4g4ZVHm/TekJwUb8j/sOpMnuWZiFWCU=; b=T5qDopSh77g0BBSn
 UKOgrc6znyKsEJbvxYWM/2KM91ChrBBOpTS+egZGb8FMI0L29puDpXDFaPteNAws
 714PIdkpPrdubCUrdmo8cRX2eA6zPncMnItpIMZG/gb72VOiyMQlH+xOl2Adatq+
 eh4+qRowT+MEwuWDfn95HapAFfEGEqEL+gf2mOM/tX2O2PZEhLqWavLb5elo6Emh
 tXKpKjycpBjXEXXW3vEaCZHP+mQ7l0D4rY4sUCpkAjtDNy7ZB3n1ieZPrwbUmAw2
 YqAFHKI2gCd0pBjIfJdoUa+5cXjfNBwJqxpe3bjasIKBfrTKozQr4x87ngEW6ZgH
 QhQ/hQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0ktxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:35:33 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so60103896d6.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781570133; x=1782174933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyNHJu2rfq7X4g4ZVHm/TekJwUb8j/sOpMnuWZiFWCU=;
 b=L9hK7UuoTj5SRBYHdJ4QvsE10I8SXjSTYKfSLbWQxGXTiQaLcPy3hivcxBjpgB8qz1
 lu0h8lAF7yy5+Jt5SZ7MTu6mZfKAilmsYehrKWDYkmvGHsVOAOqQz+oYuqPYwChKOGrm
 GKhO0yG4JGmY1b3QDXvHItr/ZlAWz6BDfEsix8fTBh8smEsELwiPxTUTZn999C6bkehw
 VQ7EzPwY5+mXOcfNbcHEP37EepXP9J68pVaOmpu8eeOeVv19IcoXFqAO/BbZDcu9xXx8
 97wx67ZMJbnOprW8Q0mY4mzE2rw7CLp3Sgry+g8yrIfs6R2y1FmzG5uvk1Uya2K6QCE9
 wDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781570133; x=1782174933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iyNHJu2rfq7X4g4ZVHm/TekJwUb8j/sOpMnuWZiFWCU=;
 b=CgYzF0CLbJwByKQd2rP8o2J6C7rt80vTZ8190MZLbKoBFBh9/fF6Ho7q9gy6uLiRVt
 9O8Yup/Tb+4kCcmbXA+41EgwPt+oSsRREtCe7NNPy+/UXoFxk4rd/Valpm8jZ96AeN7t
 A1QlxUJcVmDUGbgxdQMqMwYsiwDvuq8SkJoIZcID3hQ2GzRuPFs8cniq+2DFve68LQUr
 zQMUaO06aHLOcNn4VGaBvviCShMLczkDbiD6vJD9cTFXt2yOku0OGOojg9BpzeWXy+Cp
 9ccWsivDSrDAZOhCBLDqRWd3o6xZCqj17UVETz+z79i0FEmpsxGecjPNJe4w/SiqpEXU
 ehxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nkd7wN76OOv0wwB3w/SUuXozG+eM+oi5vPLKT/dGqdAuace/JQoJ4RS68kQ9hLRhkt1jR+BGN6GtR@nongnu.org
X-Gm-Message-State: AOJu0YzUvTNQyXvR1WHP9ULZ2QyNXKSTMCofbTiiCPHp4dvasx1db1++
 2it9qjWDizopKOgRwi3YNnwENqmhqzaU94cWExG16R2EyeK7pFSvF8HlodEeDiuP5MjJbd/jHbs
 BtoMxMvkXqxFgse1LnIWN+or++Q4MVxA4L7XDRw/udMaPnnKpCznMPXv41A==
X-Gm-Gg: Acq92OGz2LU2Vc46SMoY/THfwkhhkeInTLyzoZgQbOBveGutqzuTIER7IH/SKy0g23x
 EIqwIiAqfINKY5Zcm3++/Ld2iJi6/GJLvuls5nbuODUpNhBJ23k+7cnz4UkePsF5WPwvscBCgia
 DlHpSxZ4YefVMYpA9yf66QV/izqETHueXj4KtGQBncILAtEdhsqJFVgxJ44dx9t7h70FgRijB4I
 6lEp9Xm9GxACZ5HbMJsylxm3evMbwC/uv0t63EG2f7fp9L0UZosDtR+adLsN9NPqDchM21Lrj5u
 GlM3CnsgcEhJ63qCVkOBpmeG1L9VS6vFVsM8jCxBd8uZZ3+OGs1cYod6eSzY1l2Wk/578kxUMpj
 KtnarrN+2VA1BVJGV2fiU35uD2knXf0T275bkWOsNc9eK4CjqSBoeahmEcoHstEFiwonllQeb
X-Received: by 2002:a05:620a:2681:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-91c468c8dc3mr245971585a.16.1781570132777; 
 Mon, 15 Jun 2026 17:35:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2681:b0:914:7b4f:cf5b with SMTP id
 af79cd13be357-91c468c8dc3mr245968385a.16.1781570132354; 
 Mon, 15 Jun 2026 17:35:32 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619fb12edbsm2463045f8f.17.2026.06.15.17.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:35:31 -0700 (PDT)
Message-ID: <05604cb4-6f61-4b64-90ce-505ac87d8a04@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX3MMK1t9bAHoY
 AxaCmwGRStaNkoq+0O1ZP3ZNbmkXJ9U6TV1NACgEm7vthl7a5NwjXgG2EcShd2JGKhrCsQ1Xrh4
 U5dSlKpbgexPANSv7jWUToYj6KBToGg=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a309a55 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Ds2MHxTp7O98hlkQ-QsA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwMyBTYWx0ZWRfX0K54Zu4bZvRv
 HM+qTS8KLGa5+4NF0DfCfL98zYs/5mt9+JaFEax29RqCzkiXgCuYu+K8pzpy0lLTH8pQKXit0Iq
 eSaFRNioFeiig3z3wIMzhBxVivgWCSlSb91SS0vkagcn04euay04TlKt7gFp2LwD4hVNXUUv2Oo
 HsBTLgnSU5Zf2IldGtGN2PwfXh7hpj33LghK0o9ZDIyoRb0xm+/PX9ZYQvw5RjttNLzyt25z8Av
 QWGuGq6agNM1q8ViCcfGjkfsiteEalCKQdjpptYb3yN/b7PWMtZ2ORqyt82WuAarpeDsKL+VYxV
 KgxKxWBuC6cwe2EL85Kh7uY+QfVu+dYEFbw7aXsc4wM3lL9FbhVtTseuQbn+XvhKH5CnRCJHR5w
 G3szEvL43V+qKV2Mh//guHOLzbA7Tp5WprF2Tfl4FcqadivkBzxXfMcmJk/ps2zmwpBCH5GmXst
 mT2LcRq6XmyBBk0zVuQ==
X-Proofpoint-GUID: QJaOVQ5tJNaG2kYbhXGEtBFBVA-uFCOv
X-Proofpoint-ORIG-GUID: QJaOVQ5tJNaG2kYbhXGEtBFBVA-uFCOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160003
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 15/6/26 22:17, Pierrick Bouvier wrote:
> We add a new script: scripts/check-maintainers-file.py, that will run at
> configuration time (and not at build time), to not hurt build time.
> This script runs in 0.2s on my dev VM, which has an old cpu.
> 
> We can expect things to be mostly in sync since adding or removing a
> source or test file will trigger a configure step.

You mention adding/removing but this script only checks for removals,
no additions; did I miss something?

> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
> build things from scratch and always run the configure step.
> 
> With this, it should be impossible by design to have an upstream
> MAINTAINERS file with non existing file entries.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson.build                       |  5 +++
>   scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
>   create mode 100755 scripts/check-maintainers-file.py
> 
> diff --git a/meson.build b/meson.build
> index 19e123423b5..57e9c9de42b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,6 +17,11 @@ add_test_setup('thorough',
>   
>   meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>   
> +# check our MAINTAINERS file is consistent
> +check_maintainers = find_program('scripts/check-maintainers-file.py')
> +maintainers_file = files('MAINTAINERS')
> +run_command([check_maintainers, maintainers_file], check: true)
> +
>   ####################
>   # Global variables #
>   ####################
> diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintainers-file.py
> new file mode 100755
> index 00000000000..b001816a401
> --- /dev/null
> +++ b/scripts/check-maintainers-file.py
> @@ -0,0 +1,53 @@
> +#! /usr/bin/env python3
> +
> +# Check incorrect file entries in MAINTAINERS
> +#
> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import argparse
> +import glob
> +import sys
> +
> +
> +def check_one_entry(line) -> bool:
> +    return True
> +
> +
> +def main() -> None:
> +    parser = argparse.ArgumentParser(description="Check MAINTAINERS file")
> +    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
> +    args = parser.parse_args()
> +
> +    found_file_entry = False
> +    found_incorrect_entries = False
> +    line_counter = 0
> +
> +    with open(args.maintainers) as file:
> +        for entry in file:
> +            line_counter += 1
> +
> +            if not entry.startswith("F:"):
> +                continue
> +            entry = entry[2:].strip()
> +            found_file_entry = True
> +
> +            file_exists = len(glob.glob(entry, recursive=True)) > 0
> +            if file_exists:
> +                continue
> +
> +            found_incorrect_entries = True
> +            print(
> +                f"No matching files for {args.maintainers} +{line_counter}: {entry}",
> +                file=sys.stderr,
> +            )
> +
> +    if not found_file_entry:
> +        raise Exception("no file entry found - is MAINTAINERS path correct?")
> +    if found_incorrect_entries:
> +        raise Exception(f"incorrect entries found in {args.maintainers}")
> +
> +
> +if __name__ == "__main__":
> +    main()


