Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7E9CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDoU-0007RZ-KC; Mon, 15 Jun 2026 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDoQ-0007R5-W3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:21:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDoO-0006Qq-Hi
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:21:38 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxJCU882196
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HxQuhUwvcYZqIvAfAhYdlE6TCtyoRpG7OBTHQHx9TjE=; b=ByBzQOb7CIW4aFIr
 uubAmnyBwa1oRYhT4/2r/zhRPn5Wu9bAQLXMshR0KiD5fI9VPnnP1cV/CeDh28cG
 vETnAm2kQzaKbGQ6cpfiNn3xI5eIawJGcAZgEkKMm0BNkgiJNjnhar+K3qWdCX7/
 zoXHttO1rsxI9ft7I3c1bhkDLWZ/NKDY5PWJ6qX5tvnIEX5Qcpt2VyyDaJmaz3FO
 CGBK9eItH5MQUd8Gc7Tm0MgrLBSzonqKCXtj32DezY1jcQCuU7TUxnqrAqQIlQqY
 j6PG7l9Ge8vV2iBUnOaP5KdMuvuncFKXSssb/Sys6AgRw2AKvmfbhLGRapBJ7ViD
 HuWszw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0juud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:21:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3080bb0267dso429029eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781554890; x=1782159690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HxQuhUwvcYZqIvAfAhYdlE6TCtyoRpG7OBTHQHx9TjE=;
 b=P/X+hH3dcRs246prbVpc6z7ocSOdGTQbM33PbaFf6SBts5pinJhulXnv+EFllVNbgL
 9BIe0wNj70+UUGqLcQKYXzoc55Tsqn0gfQJLcH5i4TRI2MEVIwqBUgkw9v3xGB3SQTk0
 K1ggrwD+2h0eqyNycr1IrMkHESjuXcuS9xpPrYMF3e93wavA64YSSPEtN7ncfS6pivLk
 pku3Hnmmmot+acPFc9XW6JXT/U8WcsPGXqTaxb7GHCX9xPt5SmE1yiUGiw9aUSMRhfmf
 w67i36B4yjHLnUsczqzyY17PUs2bZlJ1hCVzaKJegkr+PfmHQxeEtduDvexKvnJiMx3+
 qg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781554890; x=1782159690;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HxQuhUwvcYZqIvAfAhYdlE6TCtyoRpG7OBTHQHx9TjE=;
 b=IYuP+tAteLtY60M/xYWgkKSNK8lEPU8fPyHj/BvNsl1gOb/gCnKgatp2Gkr9mOPLvr
 kbwCiUMwPhciTwNmUtmOJsI2W5JG5+OwoGeGZPXj+ne+q4vayvl9FX6eun9YzbB9VNrv
 +JwetbjVNFVY9oa8+ciXORfF8Is96i7RZtu68cKlDAB1oF9URvw0CDjIa8lFqEcsBuua
 FCXI711ohsEs0yWvcVW3UkwvITxOX0tFuFbCj5HJxZYqb4vyqINWxUeB6p6Q93DaIkbj
 YJmQIye6yclXobwoMXh7jjVjoY/iE3D29T7KwRrPWQKUZN+Ft+/TTNXWlzeDTSb6Kcyk
 sSUA==
X-Gm-Message-State: AOJu0YzEDThN+A/3UNtxowH8rW4Xw3ZteT00IHhqvU9MhgTUxWV0R/bw
 t7SuEi+TVgI4QrLYhhYJheQEjd+Z7aDmVcRKUf0jU7yXo3D+RgZAnjNkubgmic9LCVmzOlJHtjy
 Jlj5gLhey6NYoKyIQovFB9EHGOK8ws6q1Z9PTMUovww8COl1O/9dnVegICBdfMlFUPOyx
X-Gm-Gg: Acq92OH9jjxSTGGymwA00wPfVhMR7YWZ8OmdzrtQ0ouqubB7wL96KGEws1PQr2b2P77
 BekPYmvnsx004uuf/kM2wbWP3S/jjYer6+khGqzRl4QHqdTNmZ4fypxFaBCFNcFbKNyUq7JfnXp
 YWxJlBV+VQoQrdTPP1yngY60E/jQnT4vDjpTKIJLcGwSln6PgGElpts+uwI49N7T/Kktc1sX/ev
 g3ku5kI+7WyKGxLoGSeJwFp768vk1gBrWje9wCW/WvAm5BroizBtm7ffA9WPko3mZEVc4SMDlwN
 L/5XH70iHQ50H0tmcFUywugX4ktouWHDpMCnHoX24gygrzVVb4Ac5D0QrYUf/7L8l41oof5Mxm0
 zglEwPulnHE4H9j05pF2kohRyI63G3z20nzMwmuM7KcpfrrXzNkicedQcQMWP1vlNQoP11o/tZB
 LaA2p4NUqhfI+uvQ==
X-Received: by 2002:a05:7300:641c:b0:307:42fc:584d with SMTP id
 5a478bee46e88-3093be13b99mr7111875eec.17.1781554890000; 
 Mon, 15 Jun 2026 13:21:30 -0700 (PDT)
X-Received: by 2002:a05:7300:641c:b0:307:42fc:584d with SMTP id
 5a478bee46e88-3093be13b99mr7111857eec.17.1781554889485; 
 Mon, 15 Jun 2026 13:21:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91f88bsm16243459eec.16.2026.06.15.13.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 13:21:29 -0700 (PDT)
Message-ID: <0f2bee4a-21c5-4930-ae49-d6265053cbb2@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:21:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxNSBTYWx0ZWRfX/NsTAAfIT13P
 2pjBJ0vsR/Gc+b1TYmQvUVNqbdpt3sfAhPqsx8rFvskfv+mjGbpn0LldC2d6uS36SyW3uNUm2gO
 v3rblJTMVQw+7lPV0Q1TnrZFm39nV/I=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a305eca cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Ds2MHxTp7O98hlkQ-QsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxNSBTYWx0ZWRfX2dB7R/PpRcSU
 N+NTl6Izhxu3xB0+vxn9eGOvsL6MZOa11Bl+YMdEi9Bq239zpj6WUkC26w4ACAk/sqBJOlhYbks
 VuCMdJi7kbcapBgt46n/3eHetn7an/GoMpfffq61yQzXO1qUzFkgrtjVtcGq5ZQ7PpLhl/D8JWo
 mo9yeP2oy2MAPuRO3f93UFL3xpUvY1tU7naFABhTOoxLWGzF9EQZ0dNTVa0phdeRAslu69W2Jwu
 AfdVtBgpca/MvIVek8OiTIUlmez5npEQBV6r2ReOeC6MdMYo1R23P/uwaamV8eXvNfsJWD3AhSd
 ILAbjAYBcXOkPKngSgRps19N7F02doAkjXPG4YhoERAEc6NsklN/rs81vTOUy6+eJGFui4Su2qX
 /oguXok74HaBkvhWx+tYpJBzbxRQIy/7n6cyvVmjDsj/ql2YYj/+9FWr4ls97u/OZGg2pm4Gqhk
 aGvDMiJbE4Y5zm76Agw==
X-Proofpoint-GUID: k0cJaPs_dFaAdic6CVHXX-ro0fSbEPmK
X-Proofpoint-ORIG-GUID: k0cJaPs_dFaAdic6CVHXX-ro0fSbEPmK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150215
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

On 6/15/2026 1:17 PM, Pierrick Bouvier wrote:
> We add a new script: scripts/check-maintainers-file.py, that will run at
> configuration time (and not at build time), to not hurt build time.
> This script runs in 0.2s on my dev VM, which has an old cpu.
> 
> We can expect things to be mostly in sync since adding or removing a
> source or test file will trigger a configure step.
> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
> build things from scratch and always run the configure step.
> 
> With this, it should be impossible by design to have an upstream
> MAINTAINERS file with non existing file entries.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build                       |  5 +++
>  scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100755 scripts/check-maintainers-file.py
> 
> diff --git a/meson.build b/meson.build
> index 19e123423b5..57e9c9de42b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -17,6 +17,11 @@ add_test_setup('thorough',
>  
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>  
> +# check our MAINTAINERS file is consistent
> +check_maintainers = find_program('scripts/check-maintainers-file.py')
> +maintainers_file = files('MAINTAINERS')
> +run_command([check_maintainers, maintainers_file], check: true)
> +
>  ####################
>  # Global variables #
>  ####################
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

This function is dead code, I'll remove it.

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


