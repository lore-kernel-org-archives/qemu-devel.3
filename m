Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC3FECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1JV-00013Q-Bt; Tue, 10 Sep 2024 09:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1so1JT-00012N-Nq; Tue, 10 Sep 2024 09:53:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1so1JR-0004zR-RJ; Tue, 10 Sep 2024 09:53:47 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AAVJRQ011017;
 Tue, 10 Sep 2024 13:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OS1twHQ3woy8X4StN6DiqEMyf06EgUDt5LIXZAkKjuw=; b=fUmKcGhgK1L750VE
 0eqajMPmRk8d9BGeSss82g+I6iJVrXZ76xhmOgCcKMAlIJbx4LRMY64bOrKLVpYU
 4yBpi9xaQ4OZWkb2g501bDPCPQk+GevgdduKZ9QwpT4UWDnzSAKhx0nfEj1S4gQP
 tldBgtDqydpIACSiTtOFy89l8/kuxPbNN13081qPUT/UekZH/fKe166zQB/Mv/Z0
 ldtWM/rf8ZCwVT3y/tMvRftEbWkswCXF4miE7Srk6FoiIlgtFfkiAdyPuF58lOmC
 0DnL4GEXbWSEUqTqolumg3iWElafuKgZUoct4bVm0B9r+eJ06DUAVETsFeVzLrS0
 6RjU3Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpp301-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Sep 2024 13:53:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48ADrctQ014524
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Sep 2024 13:53:39 GMT
Received: from [10.222.168.90] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 06:53:38 -0700
Message-ID: <83bbc1d7-350f-4fc9-812a-847f63d3a00f@quicinc.com>
Date: Tue, 10 Sep 2024 08:53:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: Rename macros.inc -> macros.h.inc
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>, <qemu-trivial@nongnu.org>, Anton Johansson
 <anjo@rev.ng>, Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Matheus Tavares Bernardino" <quic_mathbern@quicinc.com>
References: <20240910112833.27594-1-philmd@linaro.org>
 <20240910112833.27594-2-philmd@linaro.org>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <20240910112833.27594-2-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: CtTTBFaB1HXFDkLeeWx2RMaIHUhyqJkU
X-Proofpoint-GUID: CtTTBFaB1HXFDkLeeWx2RMaIHUhyqJkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 9/10/2024 6:28 AM, Philippe Mathieu-Daudé wrote:
> Since commits 139c1837db ("meson: rename included C source files
> to .c.inc") and 0979ed017f ("meson: rename .inc.h files to .h.inc"),
> EMU standard procedure for included header files is to use *.h.inc.
>
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented in the Coding Style:
>
>    If you do use template header files they should be named with
>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>    being included for expansion.
>
> Therefore rename "macros.inc" as "macros.h.inc".
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>


>   target/hexagon/idef-parser/README.rst                   | 4 ++--
>   target/hexagon/idef-parser/{macros.inc => macros.h.inc} | 0
>   target/hexagon/gen_idef_parser_funcs.py                 | 2 +-
>   target/hexagon/meson.build                              | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
>   rename target/hexagon/idef-parser/{macros.inc => macros.h.inc} (100%)
>
> diff --git a/target/hexagon/idef-parser/README.rst b/target/hexagon/idef-parser/README.rst
> index d0aa34309b..7199177ee3 100644
> --- a/target/hexagon/idef-parser/README.rst
> +++ b/target/hexagon/idef-parser/README.rst
> @@ -138,7 +138,7 @@ we obtain the pseudo code
>   with macros such as ``fJUMPR`` intact.
>   
>   The second step is to expand macros into a form suitable for our parser.
> -These macros are defined in ``idef-parser/macros.inc`` and the step is
> +These macros are defined in ``idef-parser/macros.h.inc`` and the step is
>   carried out by the ``prepare`` script which runs the C preprocessor on
>   ``idef_parser_input.h.inc`` to produce
>   ``idef_parser_input.preprocessed.h.inc``.
> @@ -266,7 +266,7 @@ in plain C is defined as
>       #define fABS(A) (((A) < 0) ? (-(A)) : (A))
>   
>   and returns the absolute value of the argument ``A``. This macro is not included
> -in ``idef-parser/macros.inc`` and as such is not expanded and kept as a "call"
> +in ``idef-parser/macros.h.inc`` and as such is not expanded and kept as a "call"
>   ``fABS(...)``. Reason being, that ``fABS`` is easier to match and map to
>   ``tcg_gen_abs_<width>``, compared to the full ternary expression above. Loads of
>   macros in ``macros.h`` are kept unexpanded to aid in parsing, as seen in the
> diff --git a/target/hexagon/idef-parser/macros.inc b/target/hexagon/idef-parser/macros.h.inc
> similarity index 100%
> rename from target/hexagon/idef-parser/macros.inc
> rename to target/hexagon/idef-parser/macros.h.inc
> diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
> index eb494abba8..72f11c68ca 100644
> --- a/target/hexagon/gen_idef_parser_funcs.py
> +++ b/target/hexagon/gen_idef_parser_funcs.py
> @@ -50,7 +50,7 @@ def main():
>       tagimms = hex_common.get_tagimms()
>   
>       with open(sys.argv[-1], "w") as f:
> -        f.write('#include "macros.inc"\n\n')
> +        f.write('#include "macros.h.inc"\n\n')
>   
>           for tag in hex_common.tags:
>               ## Skip the priv instructions
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index 9ea1f4fc59..f1723778a6 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -284,7 +284,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>           'idef_parser_input.preprocessed.h.inc',
>           output: 'idef_parser_input.preprocessed.h.inc',
>           input: idef_parser_input_generated,
> -        depend_files: [idef_parser_dir / 'macros.inc'],
> +        depend_files: [idef_parser_dir / 'macros.h.inc'],
>           command: [idef_parser_dir / 'prepare', '@INPUT@', '-I' + idef_parser_dir, '-o', '@OUTPUT@'],
>       )
>   

