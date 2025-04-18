Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF2C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 14:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5mNS-0008Jj-2x; Fri, 18 Apr 2025 10:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5mNC-0008Fh-Jl
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:07:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5mMr-0005tK-VK
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 10:07:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IDwmO9022785
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 14:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 STncCyFEt9q6ZJAu8653nv+62uVggwuLBKMXbHNvO/0=; b=iwIe2Fom68JELIm3
 JINYz9E2qmiB6lcVqa8PnAOPQjB48ffoLVYma2tqhyYaPN5wPPb+USuhXuUdJL6W
 yoOKZbFQXgd+tlwk/fk4U9q6pxkhcIGg+RHa1ajLgOBL3Rv6NihaL9CEQEJWERJl
 x87EwLW/cMFuHTNhht6FmUEZX/k5BUvDybdQDLwf8eRK+1AEsg5IwXnTQ2iCwe4i
 ukqOpH7pjPkKGfE4u/VOnMTRDZVnujRp9NWk4TUvPut/1iC5/ENPyiEPIE5Q/nP1
 DONynTTuO1+hiS8LAOnD7T+/ZtqXjBYOorsi7FyGXknI6vsipfO5BgffiTq0Aa3h
 Mzx8+g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq1v97-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 14:06:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-736b431ee0dso1494724b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 07:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985206; x=1745590006;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STncCyFEt9q6ZJAu8653nv+62uVggwuLBKMXbHNvO/0=;
 b=WwOrA1FU7bdum2Z9rB/q3JmtZ6iMFt4bh59Gg7YH8jDfarUrbrupgemwfsE7eadMyI
 cPeERO9pnm+98eD4XwclkVQDBVqCIf1YLomDHRLKi7MJqcPT6ChBb6NXH3JiKpjH1+F4
 rKHJyvDUrUW8oj8Tcwe5aoIlvOLcIyYo/JretsuFoNOsHW5bN1u1KDp9ZDrZmpqWTNXG
 SVRlMPeUlUdEcaBVGRDJsGFnGkHPY+K85mvBmwgLIPApzsdmTp6ELb2qkdDpJ92F/Yzx
 rrbFcOmS73Z+SY4jpsj8Mwupaz29s0ps0uwNIXtwwvEoKLnVxffq/ABCHYZZjO4RElxJ
 j8CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0tZjvXOAPpKlv3RIJGU56Xwwxe8G6Tw6aWN3pFA5wW9TAG7Nuga+T3brg9d51fWeGjfuhCpp/v61l@nongnu.org
X-Gm-Message-State: AOJu0Yx20E81pvg7X4G/FMVvq+YIk33kIGbPuQ7Gk2iW+1HMPSEuTB6E
 KdQ6xCRlAXdEee7hhGDsxNXV+CLFmlWy+TnuePYdOPro2S0NqqI+fVhDUy0ETUxrPt0TXyPbYuV
 PIRd9j8Ead3TOM6AqaWc3XrSEexMwm80erqdQI4fl8agX9AMjKcA/2A==
X-Gm-Gg: ASbGncuckNbY1gLnCUXr0gwt6caa/JVRCEMoTZlQbaK0VbY9TesoMZ6/ddtqc63KIIG
 Ar7+CHeW/3rTEFOVWq8ZKjL4XQQkOhg7N9WeNobSpt4pQLh8jWgwXry/8WhwCpmfEC7QdDkwntV
 6rGhza5jTZ9utVxI32EnNuDxxkAWUJzicyXZaDB111mKLB+416XMRnWmrpMap+/rWLS4idYKFXX
 yo30TC/rnRUqop4P+2AxD8Xf7zDpP0UfSnR7RJ239e18TNBfH7nqysPbr+bAoAhtI9JZRcT4VRx
 wutdKAanap2CqERbEqwXf2hyr+xE7ktyXRODrzbIcH7MJVMo7Ch68yUfxqFwiG57q4Gk1luINKB
 +qDkOi1iRD/px
X-Received: by 2002:a05:6a20:d707:b0:1f3:26e5:55bc with SMTP id
 adf61e73a8af0-203cbd4fed5mr4162798637.42.1744985206354; 
 Fri, 18 Apr 2025 07:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiwMuWXscyDfpB6kvziu128etHTb+q5kkmNsLqW9xC02zKI0mqJk2Ge8n+ap9kkG8xrvkB5w==
X-Received: by 2002:a05:6a20:d707:b0:1f3:26e5:55bc with SMTP id
 adf61e73a8af0-203cbd4fed5mr4162761637.42.1744985205984; 
 Fri, 18 Apr 2025 07:06:45 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db1481724sm1385279a12.67.2025.04.18.07.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 07:06:45 -0700 (PDT)
Message-ID: <e54db241-83fc-46cd-84e1-26336de856c5@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 09:06:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, sidneym@quicinc.com, quic_mliebel@quicinc.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20250416150343.73444-1-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250416150343.73444-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XnToLeYThiAkBVyGPE7IyTFTN86X2asA
X-Proofpoint-GUID: XnToLeYThiAkBVyGPE7IyTFTN86X2asA
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68025c77 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=jRYsZis2M5lLvFiSy7QA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 4/16/2025 10:03 AM, Taylor Simpson wrote:
> This can easily be done in C with opcodes_def_generated.h.inc
>
> Note that gen_tcg_func_table.py has some logic to skip instructions.
> However, there aren't any instructions currently in the code that would
> be skipped by this logic.  So, it is safe to base the table on the
> complete opcodes table.
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

Tested-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/genptr.c              |  6 ++-
>   target/hexagon/README                |  1 -
>   target/hexagon/gen_tcg_func_table.py | 66 ----------------------------
>   target/hexagon/meson.build           | 10 -----
>   4 files changed, 5 insertions(+), 78 deletions(-)
>   delete mode 100755 target/hexagon/gen_tcg_func_table.py
>
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index 2c5e15cfcf..330170ab44 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1453,4 +1453,8 @@ void gen_add_sat_i64(DisasContext *ctx, TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
>   }
>   
>   #include "tcg_funcs_generated.c.inc"
> -#include "tcg_func_table_generated.c.inc"
> +const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {
> +#define OPCODE(X)    [X] = generate_##X
> +#include "opcodes_def_generated.h.inc"
> +#undef OPCODE
> +};
> diff --git a/target/hexagon/README b/target/hexagon/README
> index ca617e3364..5af298e3ed 100644
> --- a/target/hexagon/README
> +++ b/target/hexagon/README
> @@ -47,7 +47,6 @@ header files in <BUILD_DIR>/target/hexagon
>           gen_op_attribs.py               -> op_attribs_generated.h.inc
>           gen_helper_protos.py            -> helper_protos_generated.h.inc
>           gen_tcg_funcs.py                -> tcg_funcs_generated.c.inc
> -        gen_tcg_func_table.py           -> tcg_func_table_generated.c.inc
>           gen_helper_funcs.py             -> helper_funcs_generated.c.inc
>           gen_idef_parser_funcs.py        -> idef_parser_input.h
>           gen_analyze_funcs.py            -> analyze_funcs_generated.c.inc
> diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
> deleted file mode 100755
> index 299a39b1aa..0000000000
> --- a/target/hexagon/gen_tcg_func_table.py
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -#!/usr/bin/env python3
> -
> -##
> -##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
> -##
> -##  This program is free software; you can redistribute it and/or modify
> -##  it under the terms of the GNU General Public License as published by
> -##  the Free Software Foundation; either version 2 of the License, or
> -##  (at your option) any later version.
> -##
> -##  This program is distributed in the hope that it will be useful,
> -##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -##  GNU General Public License for more details.
> -##
> -##  You should have received a copy of the GNU General Public License
> -##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> -##
> -
> -import sys
> -import re
> -import string
> -import hex_common
> -import argparse
> -
> -
> -def main():
> -    parser = argparse.ArgumentParser(
> -        "Emit opaque macro calls with instruction semantics"
> -    )
> -    parser.add_argument("semantics", help="semantics file")
> -    parser.add_argument("out", help="output file")
> -    args = parser.parse_args()
> -    hex_common.read_semantics_file(args.semantics)
> -    hex_common.calculate_attribs()
> -    tagregs = hex_common.get_tagregs()
> -    tagimms = hex_common.get_tagimms()
> -
> -    with open(args.out, "w") as f:
> -        f.write("#ifndef HEXAGON_FUNC_TABLE_H\n")
> -        f.write("#define HEXAGON_FUNC_TABLE_H\n\n")
> -
> -        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] = {\n")
> -        for tag in hex_common.tags:
> -            ## Skip the priv instructions
> -            if "A_PRIV" in hex_common.attribdict[tag]:
> -                continue
> -            ## Skip the guest instructions
> -            if "A_GUEST" in hex_common.attribdict[tag]:
> -                continue
> -            ## Skip the diag instructions
> -            if tag == "Y6_diag":
> -                continue
> -            if tag == "Y6_diag0":
> -                continue
> -            if tag == "Y6_diag1":
> -                continue
> -
> -            f.write(f"    [{tag}] = generate_{tag},\n")
> -        f.write("};\n\n")
> -
> -        f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
> -
> -
> -if __name__ == "__main__":
> -    main()
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index bb4ebaae81..b28aeddb85 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -41,20 +41,10 @@ hexagon_ss.add(semantics_generated)
>   #
>   # Step 2
>   # We use Python scripts to generate the following files
> -#     tcg_func_table_generated.c.inc
>   #     printinsn_generated.h.inc
>   #     op_attribs_generated.h.inc
>   #     opcodes_def_generated.h.inc
>   #
> -tcg_func_table_generated = custom_target(
> -    'tcg_func_table_generated.c.inc',
> -    output: 'tcg_func_table_generated.c.inc',
> -    depends: [semantics_generated],
> -    depend_files: [hex_common_py],
> -    command: [python, files('gen_tcg_func_table.py'), semantics_generated, '@OUTPUT@'],
> -)
> -hexagon_ss.add(tcg_func_table_generated)
> -
>   printinsn_generated = custom_target(
>       'printinsn_generated.h.inc',
>       output: 'printinsn_generated.h.inc',

