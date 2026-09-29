Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448BDCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWgo-0005xY-OV; Tue, 29 Sep 2026 08:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWgn-0005xQ-JG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:12:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWgm-0002Yd-5E
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:12:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAjIjN4118908
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3hwoYybEtjHkHvtaRRwg8pmNKzBZVzj5H2kA++h6WOk=; b=jJdOdJeHejaZjhte
 WlbHDfMdLHpjkt/FPz5E8tI49GCoXGQd5GZKnfBobgr5CyoFVOfGkaa8jQsrJYPW
 v9NVRUPxyT2ATugkLtWPv61NzXGofK90aARxv4c5wVeT8f2R+CkbfC77tirvoFDx
 /GCvccvb2YtH4CKkRCPIpUfAeVkGw8YJUH41mo10mBOcocqIfJIS97lbi5Kw8pj+
 qPt8UlO69KpgakOGSP9XMInye7NqxkxJAoPiU7FPZZW2YyD9wdp0ii1zKPpkhBSQ
 yXh3Vaxoyrrk+vychMVyz8yMyym95OlMK97X2oFbRNsfRrundslypX1OwXIHWAVj
 7JARgw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0144tutn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:12:02 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-790e3ca4c85so648117137.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790683922; x=1791288722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3hwoYybEtjHkHvtaRRwg8pmNKzBZVzj5H2kA++h6WOk=;
 b=V2pLcXxzWbH7DLzLM1awYodIMj16MLJ2L6EE95RGS46busINgObWHJBa4UF23sbr/O
 GoJwcAWO0Yfp34/bwkXlqvEnC1Xcb+6E1FnB/Ky2toJW1HRMLL5aId9ZrpMRH/CNic8m
 UD/r3H5xgkAmMN5akIGRXiQTq8rdwajPtJCjRKDDCpdpy3Z4X0BQkVNC1K7DRZgpHn6Z
 zWy0sH1WKydfnbeCp8b/Pj+NmdkqbdLZSsVCiPJmAS5fpmlY25XxT4T51SZYwT8EyQQS
 iqHuwHjoPFylcPQ1v3fglyGT59a7Z4DS9Ac9nAbH3B3mXBGU2rYBd3bnh6iyyWru2LdZ
 376Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683922; x=1791288722;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hwoYybEtjHkHvtaRRwg8pmNKzBZVzj5H2kA++h6WOk=;
 b=vj/wii2xs9cDthBqhWgzXp/TfhQFbEYcqwZROBzrUSfmB3fzzrgwqYJ6O74edYRnBt
 0A3G1NTwAEzjgNMIPxa9vf3H2ntYj+fj8HuMoJuyaQGztQpt1y9sKFioLCXVGzW2Npf0
 1b1QFtvoR3Hl63zsFQZmAD8T5hF5RgBaLOG9WkPRCccjcVdyciowJfpjGEHsfhJ3issO
 MTDGgHqfAWuxC2Y1j3Cuok4jeRPIOsIjEPIHDWU/nwUNx20HyRGYaSBR4Wc3r4pYo5Qr
 D4L2Knd4vVTG+aR8/59+F6SXJqQgum5zP57UCpuWrLafhpVR3KWduQ7q2a3h6klhSH8t
 90pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3t8ftPHOHxL82XmU/UHyoRRF+PoeIKr+WZiW1VJA/2hWqNgABHZuBnkm79ahh4DevkvU3UU2dyCmd@nongnu.org
X-Gm-Message-State: AFq9FYI2jT0l2u0J9DIjJvrEl0SfzQvBi662UdjRTnK7GR1FxTIJErle
 cD1eglOG8wlIYmPjPEwClQPS4odDDjLSVDg/+bMp+xjOC6oQ5PdQT9qfSQf+jurPYJ2luAklyFg
 mpKJHlkhNKj8hHI290YM6DiADhmfqZQxp+GONCzkWWwDGhGgCroi0dgYsig==
X-Gm-Gg: AYBFou3sVDLFUYaTBzYcEjAPd0mOo2Bk3JV8r7/jgArn+rAo0e/nZTnyV8m8ggpyouL
 X6t9TPWznhHzMrxpWnEQ0xyih5qc+5p4Z1dRhTOp5YOHPEZv0L/lw8lUCVPSIkHPP2ZqIyx2FQs
 /HbwNTe5Xrl5SrgeJTEj3+OBbbX6qGpV3yO83NPng5hpm1pExuLNiruG5vhnG4LCDePQB4f6uuX
 9aT/PXhqKTqL21o/WzUA9kt10MFlklG33/r8inV/YNAzoOnr96zc20xmiNZhQfAx2QYd8BIiomc
 b/BOCrBjE4bVwwvKetPsIBgfyvaTtV6DnlLUXYUHZePOLI/1XQJfYtjJT8Mk4mRm3nyLBce331v
 DwkStMYohFj2OaaYZZuQL6HR/DPP+14IDAQ==
X-Received: by 2002:a05:6102:32d1:b0:7ba:3572:2789 with SMTP id
 ada2fe7eead31-7ba35722b5fmr160456137.3.1790683921565; 
 Tue, 29 Sep 2026 05:12:01 -0700 (PDT)
X-Received: by 2002:a05:6102:32d1:b0:7ba:3572:2789 with SMTP id
 ada2fe7eead31-7ba35722b5fmr160445137.3.1790683920946; 
 Tue, 29 Sep 2026 05:12:00 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec703sm68524295e9.6.2026.09.29.05.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:12:00 -0700 (PDT)
Message-ID: <0a97b149-2222-4615-9331-76ea880919ad@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] tcg/tests: integrate rest of mips tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX7j/KeqbgprLW
 4LY/96j/HdrjIUltm/13qR9txbrY3UtefoYu4a/3SPhdU3bVl5MboxWrVsHwFp3duup4uoiIxxP
 v253ondaPOZSq4yJHFYRAdfTYiFfccC3ieOIxHuk/bI76LsBV6+nvQENtgM3t+N9hG0e+qb6kuy
 IIm8qAVvjFEcknmN0rfPg+qpMnVxFqalT9de+M2cZ7IMyu8aFKk8SHI3fT9yLNiTiwvpkA3hsef
 NfIkBZDHhrZ5jzXO29ZKmD7N5GOGbsuE8mmH+Ix0D+T8gMzwH6xgoqGzTTwpyx9WCgqIfU0+j8o
 cw1sXShabL92lrTfxVC+vDU4HASjoB6Yv0bwwSk1rIhoYU8jDAjZqMHhRsy10nt86TpU9/0EUCh
 IPmc7lHKk0jC/K36IKnyYGFSV/GFjk5TbiM/1Vh4jca5CkChDIc4F+d4y48qJlMUOrHOiMEMxQM
 bErwf+MlwJvHMbiRMZA==
X-Authority-Analysis: v=2.4 cv=FJSOVOos c=1 sm=1 tr=0 ts=6abbab12 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ox0gH5pkY3bWb20Km_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: Qv8fb4N9Qmm4R6ct6U9PJiennLW19sD_
X-Proofpoint-GUID: Qv8fb4N9Qmm4R6ct6U9PJiennLW19sD_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX0gbf2FG3AB09
 +PR8nu/y0ajk1Zg09FozvAhq3ORGx/5egihaRq0XYLWdpbazTw/hMZlqyslo7p85aStIOuauL2s
 s6kSFEXnlMO6R1ihiz8go7U7Vaiad/4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/9/26 09:39, Pierrick Bouvier wrote:
> This series integrates tests from tests/tcg/mips/user/, and also adds
> multiarch tests for mipsel target.
> 
> v2
> --
> - add all tests from tests/tcg/mips/user/isa
> - move octeon test to mips64 folder
> - add mips64r6 tests (and fix them)
> - add README for r5900 tests that we can't run
> 
> v1
> --
> - add tests from tests/tcg/mips/user/ase/dsp
> 
> Pierrick Bouvier (19):
>    tests/tcg/mipsel: move dsp sources
>    tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix compilation warning
>    tests/tcg/mipsel: add dsp tests
>    tests/tcg/mipsel: add float reference files
>    tests/tcg/mipsel: add multiarch tests
>    tests/tcg/mips64: move octeon test here
>    tests/tcg/mips/user/isa/r5900: add README
>    tests/tcg/mips64*/meson.build: remove unused cc_feat
>    tests/tcg/mips64: move mips64r6 sources
>    tests/tcg/mips64/test_mips64r6: fix include path
>    tests/docker/dockerfiles/debian-all-test: add mips64r6 toolchains
>    tests/tcg/mips/include/wrappers_mips64r6.h: add missing wrappers for
>      and, nor, or, xor insn
>    tests/tcg/mips/include/wrappers_mips64r6.h: use proper types for
>      parameters
>    tests/tcg/mips64/test_mips64r6: fix call to check_results_64
>    tests/tcg/mips/include/test_utils_64.h: add check_binary_op_64
>    tests/tcg/mips64/mips64r6: update failing tests to use
>      check_binary_op_64
>    target/mips/tcg/translate: add sign extension for srav
>    tests/tcg/mips64/mips64r6: update references
>    tests/tcg/mips64: add mips64r6(el) tests

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

