Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A00E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 03:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMfJy-0002bj-Ip; Sat, 14 Dec 2024 22:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tMfJu-0002bS-Hh
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 22:29:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tMfJr-0006dh-BM
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 22:29:26 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BF00S5B030404
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 03:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /8dC74CJloYj0vAe/N7HsXW2Xb40Opwj6UWN7CznR3Y=; b=M90mxbc1hEkzvZ3k
 1aJ3ISwocZcw8alTHYUdd09xSpO5bQFVNxVk17gLIBrMfsPGdqOUXZEuquHX4J99
 z1IO1IzEYUFIBaGy3avm7nNH2Go+5l9v2bJCVVK4lh63sX+mJEUGkunGRS9Z11bP
 RgQSZdTq+di6UwZTcElBBcHRkrw+MXCvNXdzcAabkKBUyeVdif8zC61yVwplJtaW
 B5MQeKgZetb/7ueUF59qXAJzcwnk5fiZa6Pe7zgG9QOXu9ENfp7J4zdmXkNNoOKo
 26Vi1k+xoWMkenelZIpoz6bRtPZ5+T9iXvYhboZDkC0k8k0gKteg6MBsg12oifn4
 Bq5AiA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43h31usch5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 03:29:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8d44e17a2so85898046d6.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 19:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734233354; x=1734838154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/8dC74CJloYj0vAe/N7HsXW2Xb40Opwj6UWN7CznR3Y=;
 b=dVFfQ9JKGR0JB7taNu1jQzwEb0AudFt4Nse/oqQ0vCaEB3YeR8mzHqIbPtadZ0sfC9
 9cEJbKOXnu1+DqbXnsmR4noLZOKB7GTzBdAvA4BFwdANkjuoHGM8YGJrPnTFuO6wX8Bv
 gE4P0PAlWBO5eWU0jL1a6hx5rnG569NLYKkJqrlo2NawQMnJrLLi3i9B1dhUgVTPH0f4
 wIRoBZH2fZ2BwejsgYfUX3oJ20WNPXoR0kFFw2R9pW5nOc9z4oL7ygAzCQTxMNJ/p+D2
 id5phQTWWlH8/ARQDOXoj0XjTvdJMJ2iMxm9GASadc23kvKLKxm8ltBIskkADmv77F6R
 c1xQ==
X-Gm-Message-State: AOJu0YxAAXoNYFabc0H5uw1BSi3UONstza+wKVoyt39T2WfOHvaW6n2G
 kJKmfHkgDqPjpKZFaOi1RKxKyNpbdbJjcixEshliC6G1qJBAHvUEcYf/vZv5Uub934nGjwYi7uF
 8MlZOXiK9ExF4xZ/OteDXHfTE86wnZmtVEE3l5Y7y6yKJLn3QhCaOJDOJACR5xA==
X-Gm-Gg: ASbGncuKh5nATju03q/ShIu2glNh5Na7Os5ispiDA0yhYTKBkwXkP8uORAd9cbxhK//
 LwDdKemc3Y53r91+Qxg9vgYdXKamMnTkwqJoTlYtGuMWd3zbvMO0IY7Dy8X0V2IjAx9DznwCyW+
 ostAKHwCREqHRNCQt6hwN82GOmIfohbZUQfuQs8sgZ8Hx4xI7lIxHSrCCXEqxsomn2ChTM22Dcv
 p5vtqvEYtABN0Msx9WldC2B2Nj8UNsk5o5wQyerc1yPtIugdGiLHBXex/Eiom2RVsyoVyojEgUx
 CxWEbVgU8iT7i7ovCIiJgi93xlc8GwFdXoMt7Q==
X-Received: by 2002:a05:6214:248e:b0:6d8:96a6:ec1e with SMTP id
 6a1803df08f44-6dc8ca3e95dmr157395146d6.2.1734233354073; 
 Sat, 14 Dec 2024 19:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0jC7c3jAw+WW6ANe6Yu0UQkE3mhMOPspFbZwNvKii6NDRMNiQttdby6BGqIzEeoVC6KrNBA==
X-Received: by 2002:a05:6214:248e:b0:6d8:96a6:ec1e with SMTP id
 6a1803df08f44-6dc8ca3e95dmr157394946d6.2.1734233353736; 
 Sat, 14 Dec 2024 19:29:13 -0800 (PST)
Received: from [192.168.228.69] (59.sub-174-246-195.myvzw.com.
 [174.246.195.59]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd367a09sm13106946d6.83.2024.12.14.19.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 19:29:13 -0800 (PST)
Message-ID: <db50d106-0b0f-45c1-9bd5-375d27ad06c3@oss.qualcomm.com>
Date: Sat, 14 Dec 2024 21:29:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] hex queue
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: philmd@linaro.org, peter.maydell@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20241213041836.39986-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qSn1e2FTZdPZpIkBOdlGqCQc0WIS177b
X-Proofpoint-ORIG-GUID: qSn1e2FTZdPZpIkBOdlGqCQc0WIS177b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412150025
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

+ Stefan

On 12/12/2024 10:18 PM, Brian Cain wrote:
> The following changes since commit a5ba0a7e4e150d1350a041f0d0ef9ca6c8d7c307:
>
>    Merge tag 'pull-aspeed-20241211' of https://github.com/legoater/qemu into staging (2024-12-11 15:16:47 +0000)
>
> are available in the Git repository at:
>
>    https://github.com/quic/qemu tags/pull-hex-20241212
>
> for you to fetch changes up to b29b11b51f1ac1884a64c5b6bde969a46206263f:
>
>    target/hexagon: Make HVX vector args. restrict * (2024-12-12 21:43:57 -0600)
>
> ----------------------------------------------------------------
> Remove HEX_DEBUG, EXCP/CAUSE fixes
>
> ----------------------------------------------------------------
> Anton Johansson (2):
>        target/hexagon: Use argparse in all python scripts
>        target/hexagon: Make HVX vector args. restrict *
>
> Brian Cain (2):
>        target/hexagon: rename HEX_EXCP_*=>HEX_CAUSE_*
>        target/hexagon: add enums for event, cause
>
> Taylor Simpson (1):
>        Hexagon (target/hexagon) Remove HEX_DEBUG/HEX_DEBUG_LOG
>
>   linux-user/hexagon/cpu_loop.c           |   4 +-
>   target/hexagon/README                   |   9 ---
>   target/hexagon/cpu.h                    |   8 +--
>   target/hexagon/cpu_bits.h               |  21 ++++--
>   target/hexagon/gen_analyze_funcs.py     |   6 +-
>   target/hexagon/gen_decodetree.py        |  19 ++++--
>   target/hexagon/gen_helper_funcs.py      |   7 +-
>   target/hexagon/gen_helper_protos.py     |   7 +-
>   target/hexagon/gen_idef_parser_funcs.py |  11 +++-
>   target/hexagon/gen_op_attribs.py        |  11 +++-
>   target/hexagon/gen_opcodes_def.py       |  11 +++-
>   target/hexagon/gen_printinsn.py         |  11 +++-
>   target/hexagon/gen_tcg.h                |   2 +-
>   target/hexagon/gen_tcg_func_table.py    |  11 +++-
>   target/hexagon/gen_tcg_funcs.py         |   9 +--
>   target/hexagon/gen_trans_funcs.py       |  18 ++++-
>   target/hexagon/genptr.c                 |   7 --
>   target/hexagon/helper.h                 |   3 -
>   target/hexagon/hex_common.py            |  33 +++++-----
>   target/hexagon/internal.h               |  11 ----
>   target/hexagon/meson.build              |   2 +-
>   target/hexagon/mmvec/macros.h           |  36 +++++-----
>   target/hexagon/op_helper.c              | 112 --------------------------------
>   target/hexagon/translate.c              |  72 +-------------------
>   target/hexagon/translate.h              |   2 -
>   25 files changed, 148 insertions(+), 295 deletions(-)

