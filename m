Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B77C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u00qo-0004MG-02; Wed, 02 Apr 2025 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u00ql-0004Ln-Ti
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:22:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u00qj-0004A6-Ki
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:21:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532AuAP7014503
 for <qemu-devel@nongnu.org>; Wed, 2 Apr 2025 16:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kgWH8l6GJsM4fRmXzwmaAo997BgYviF8pZKPYiOIaEs=; b=h+ak1RfSzbUaA6No
 +2XkGicZiZNsJThnkfnKCXiWbf+AguMfahk0oQ44tXdPSpgwm9FFcgeaOtv5ma78
 Xa7sDVO76epJOUCh61QDpHq31ffi/Oa04+0zoY83TjAZ83NdrPmOfcJQMhir9x+v
 FcMxLSe22Sj7NKHEBq930pbT0IJ+79dKeMtYbxWl0MTW/KZe10s85SlDUB7mbeqZ
 mevL26KTMKrwedKDlSviJvc8G38AluDgRRV0iPGSRrsLiUXxtBxe5j2rDBPgUrWo
 VpD6SAWLxb4926Gn2iIjRfjvYsGDegFnnPuiLpRYz9bqBkBaGETYoZm+EHPNp3GX
 cfQX6g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7tvm2gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 16:21:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7375e2642b4so209492b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743610913; x=1744215713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgWH8l6GJsM4fRmXzwmaAo997BgYviF8pZKPYiOIaEs=;
 b=sflnAodHjjgGF+b2G2BUmkJH4Jsevz6MjqRRkQC2IsNXhUfpWKDgZIKo75NkDXDc2J
 7SZB6bXbaCOie/8qymxBSubNhNs7AlP3aA3Ie4IW3h5195f3aFU5h8FfrbD2Lvtg/Lhp
 Sv1Hikb42KO8cAM9FdhItln6RlcxhY2EbfzK7YEmNd+z/M6LNh5bPgFXkTLYWaEQx0au
 FRjSSui2CJyBnYsWGfan7Ugg9PXBpcNet0jjm7T4ziXAWwNoBpm8LtEhx+34QRlUJFws
 H0lusqNl5Y61VGTiIkJ8PRm8m+ui1vC9QoiBMG+7WafaZp6Xja2HLfg35GYCHtbwbtg0
 9ecg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsh4F/1Nf61PmyimcEsnWzvci0+dOK9mAHfrM5++MHX4qhUK/CYkWTtZBuFfuZpL5KlUVaNQNZUuzI@nongnu.org
X-Gm-Message-State: AOJu0YzNVpwxVvnsPzJepldEtcgiIXBwORMjszXCsz6Zl5eZXmRRUvFG
 qflV81Z7q9yl6V5mTw1mLrWfUTDlJiBFeKgnpkBhznboTfDjeMByR+ld1ECN4ACiquj7Q086iHR
 CICBUBuTFpAt96eIb7aXMuWrRV20dArgCm9xmtTZiVYZYjEuVnnIE5w==
X-Gm-Gg: ASbGnctD+BDAx6aKHvbTsZvOyjhBjXdjCThjR5xts1DiTH3bx/bTrXMcuiNr4JJdg/h
 kYnn9gLh7ZRHkCOH8w6xAyyw2mI+Pv7lqKFW+MD9pQYty3ll9VgtJAOA89CuPmXHYDqUMdfyQCU
 q1flApvA9Z9M4VspT/ny/aVG8YY8z5A0LD3ggpp1HT/Vilya3lWD/U8RHjfDZy7IhcfhhRGVYDb
 6VozvL1s91o3BNCObwYrcPqSfEG8P4sqpBbcchEkQQI+PqZC15Aidp1dwKvsfXGoXaQ2rXRQOkC
 DAC73TCmoLagRafHcYE5/lBOjbZT712yTe4ikE6EFe9Y6ELCblTIedvEYtRkm1scyto/vFVQaA=
 =
X-Received: by 2002:a05:6a21:c8f:b0:1f5:7eb5:72c7 with SMTP id
 adf61e73a8af0-200d155f5c6mr12423475637.29.1743610913160; 
 Wed, 02 Apr 2025 09:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK6qbCbhErJv38Lt7o/uAmM0RI4zsFLXs6RiJU1Gsc1ONOMiQoZh9DShfFX3uErFsPWRJyyA==
X-Received: by 2002:a05:6a21:c8f:b0:1f5:7eb5:72c7 with SMTP id
 adf61e73a8af0-200d155f5c6mr12423447637.29.1743610912755; 
 Wed, 02 Apr 2025 09:21:52 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739710920adsm11138469b3a.122.2025.04.02.09.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 09:21:52 -0700 (PDT)
Message-ID: <9a96af7b-4ee7-424f-9934-ecd37cff5a31@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 11:21:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/hexagon: Replace `prepare` script with
 meson target
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, philmd@linaro.org
References: <20250402114259.21953-1-anjo@rev.ng>
 <20250402114259.21953-2-anjo@rev.ng>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250402114259.21953-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=67ed6422 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8
 a=_8qmwitvIyZaJUrpDDIA:9 a=QEXdDO2ut3YA:10
 a=RVmHIydaz68A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: jWqwWtLy9wGsKpdvbRs0s6140pm-J-p5
X-Proofpoint-GUID: jWqwWtLy9wGsKpdvbRs0s6140pm-J-p5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/2/2025 6:42 AM, Anton Johansson wrote:
> The purpose of the prepare script is to invoke `cpp` to preprocess input
> to idef-parser by expanding a few select macros.  On macOS `cpp`
> expands into `clang ... -traditional-cpp` which breaks macro
> concatenation.  Replace `cpp` with `${compiler} -E`
> and replace the script with a meson custom_target.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   target/hexagon/idef-parser/prepare | 24 ------------------------
>   target/hexagon/meson.build         |  3 ++-
>   2 files changed, 2 insertions(+), 25 deletions(-)
>   delete mode 100755 target/hexagon/idef-parser/prepare
>
> diff --git a/target/hexagon/idef-parser/prepare b/target/hexagon/idef-parser/prepare
> deleted file mode 100755
> index cb3622d4f8..0000000000
> --- a/target/hexagon/idef-parser/prepare
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -#!/usr/bin/env bash
> -
> -#
> -#  Copyright(c) 2019-2021 rev.ng Labs Srl. All Rights Reserved.
> -#
> -#  This program is free software; you can redistribute it and/or modify
> -#  it under the terms of the GNU General Public License as published by
> -#  the Free Software Foundation; either version 2 of the License, or
> -#  (at your option) any later version.
> -#
> -#  This program is distributed in the hope that it will be useful,
> -#  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#  GNU General Public License for more details.
> -#
> -#  You should have received a copy of the GNU General Public License
> -#  along with this program; if not, see <http://www.gnu.org/licenses/>.
> -#
> -
> -set -e
> -set -o pipefail
> -
> -# Run the preprocessor and drop comments
> -cpp "$@"
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index bb4ebaae81..abcf00ca1f 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -280,12 +280,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>           command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, '@OUTPUT@'],
>       )
>   
> +    compiler = meson.get_compiler('c').get_id()
>       preprocessed_idef_parser_input_generated = custom_target(
>           'idef_parser_input.preprocessed.h.inc',
>           output: 'idef_parser_input.preprocessed.h.inc',
>           input: idef_parser_input_generated,
>           depend_files: [idef_parser_dir / 'macros.h.inc'],
> -        command: [idef_parser_dir / 'prepare', '@INPUT@', '-I' + idef_parser_dir, '-o', '@OUTPUT@'],
> +        command: [compiler, '-x', 'c', '-E', '-I', idef_parser_dir, '-o', '@OUTPUT@', '@INPUT@'],
>       )
>   
>       flex = generator(

