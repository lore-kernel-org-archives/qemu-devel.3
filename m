Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4FDC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEEP-0007vj-1y; Fri, 25 Sep 2026 18:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEEC-0007v9-5d
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:17:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAEEA-0001TQ-68
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:17:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PIp6wZ2121098
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YOBBt+DQwBDe4/DMpmLPpdLhSkPFSUeTewzLczBbjMQ=; b=T4Q4aCsraeHfMabw
 ENyfcjo36Y8yjkLtbUInqGRBpJ8u7m9vc2iR69z9Qn//AWDm9IHNx5ZX4/9zB61a
 HGsplfi4vYfj0TNm8yZ/rmf7XoePQbg5MreZtSYDYKEXW1vAOIOKBkJG44Ecbk2Z
 R6q69g47+Y18oAesDvPAxol2znDRxhh1D4SSGarDstA1lVImRjh7lUtu54s4NxWW
 2jpfywhcDeFxyfv/Vc/NKXjmmgBgL+4d2YV2G9DLaMKAUaD1kw79ym125wbLS1V6
 m5SdopK9LeqNRZQrp152rTusZnjs3XyTm/LS9bBr1mS4wLv2olox2bMadB20Zg1s
 UhddPQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwv5ysafv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 22:17:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso2198959eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790374626; x=1790979426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOBBt+DQwBDe4/DMpmLPpdLhSkPFSUeTewzLczBbjMQ=;
 b=E/fKaVgeA7vEJ5LBIIl2bx7U8omlbQ6wHpkXY6zF83VRHRs1wjExmTYxaKFCnIl1PT
 af8cmmLpwnToYwhev48gZboIbdK2ITVJxP/NY4BRbauR2HrufeTBUSiJxjdPcCm26256
 coVt79YY7/MFHmXniiYU4F5IRFgY98E1pHHv+Az3Joe1e1Ik8g6lN1A+8KjYO6+/G7px
 Dqa2K9ZkZx3+RDnAxZ0UoxHaCcZFBmNQiTgBlLNToQsB/lyMa5MTOmUlSfry9GpU1wxf
 sHMZuo4Hm7iL/nrv/dWf/DK2SYFXUhEXqH/qNnC1xC8h2B/sMdn89PELmYsrMJbMQX94
 BXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374626; x=1790979426;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOBBt+DQwBDe4/DMpmLPpdLhSkPFSUeTewzLczBbjMQ=;
 b=svEZG2TpDTHDZUJDfEJqiFnd6cQa8CD3aCPP3Vjcy6ZYdAvChxN1enPzOojJECE6it
 ZipWknpzoHFAmHM+NbapH0tyPQDHuX5MJ77I/ZSokPUpyapkcNiPF2OZ/CwtN8MWBT1H
 pfsLYnMKIYNcWDgoBOe8j2nNGNDCI2XKYbuZYIg4MuLuf6kRRNRY0MVqqAyH5DwGjWor
 AaVGKUMwCgJHZhqmRlG4nMp4A1omTFhowuMTF+PPV5OMFJdwi67hfRSOg9jt/hfJO2UI
 hAVy3b1f0bOdC//jH4oDK3PQg8VcVbSx/u+bXhUlEmx7cpnZVHb7E4AmESAaU4+njL4O
 OW2A==
X-Gm-Message-State: AFuF++nTM171kMXgS70gMxAugGf6Mz3Yw7TDqkWA+ha4fApyGDwVnLbw
 kywaNZ60QsUpX50/k45LsN7ne4RryWZtmwPKfh28Vft71EPYdXMQUoSlST4NE7SKp4MFejnH+GV
 i4/9xLX/uCRiKrENeldFJgdwBjIABhFNxEiw2AFAe6cHeHgeROGbkiZ3hVbD5aqs6BQ==
X-Gm-Gg: AYBFou2wevX4bdSlp9WIdPRp7FwpesoOR2y9l7WzQV2gqNK2EjzkqN/XJd6Nuykj6NK
 FFe/V82enSXueL3PmCK5SX4RZXEVzq//SMGCg18cM8d98zQ17ZgMuL0RchT9kTHHymxOM+Wd/VW
 NH54EcpxVUawsLjy+dk4whwEVSeXRmUukp1LZTqa52e7vIoazBm/3VcNw7vK8TP8RMZXYLEzP3I
 uehfqWn7QDwBAr92vJC8G5mrbPUYLVlEWjiLaCCR7VAifiHGKoN1nDjMjgQ6KUol+VsuYtf/s8e
 +ksrQj9u5LvLsYPNNRhKmMxI6k8+lJNnJ9SnYRALMC7tQfO2x0H2o4H3267S0w9HgFPhheWlrd7
 RV2bIZAD92ceBK/VGBLNMyKRrVa6Iwkm0lv5jULkNcECHemVQnv3AInabYqgbQvYwn+M=
X-Received: by 2002:a05:7301:1f06:b0:33e:42d5:1d3 with SMTP id
 5a478bee46e88-3427246c007mr1556598eec.30.1790374625608; 
 Fri, 25 Sep 2026 15:17:05 -0700 (PDT)
X-Received: by 2002:a05:7301:1f06:b0:33e:42d5:1d3 with SMTP id
 5a478bee46e88-3427246c007mr1556580eec.30.1790374625015; 
 Fri, 25 Sep 2026 15:17:05 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ad9e097fsm8513546c88.13.2026.09.25.15.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:17:04 -0700 (PDT)
Message-ID: <73a5d1a2-0056-4700-9d01-7467d6aba906@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/tcg/meson.build: detect additional cross
 compilers
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfX+SNvbg09Y9mA
 bxB7jk/uWSXCwQ2qaGjrXLDbCQKy/4N7TVJEja9ya2VcqCqWiQ+ZI4qeF6SEJnAR5jAsm68YnCh
 mL5tDVhEYuYgmRpt7H10KAhPaiR8UVf+ha8ZcNoVTNlHQleKHo1i6MBooZLYGij6Cd6T8KawIIg
 7i4QiH/OZ69BLtT9+PngR+viDg2ckXevcFNX6v6T5TmRNo00kT8XNJnlAOHonCr/YGr7TPmoUOh
 J+eYeUlpPecMNvbX1MDdjaYLAKwWfNagCsZCsLj6wb3mGye8o3Qz0Uw1gfn/qF52tRxdXrOvV+K
 vSjQBXNwwzGRILsiRhu18yMeoLNWT/Qrhy5QYuH1zMQyfw4ILc7fyvoT+FfuEWRlwTIeWLiF6oB
 A7JU4YGO6oYh2+qZ23RclkyKNrO9R8q99IBrbfQ2r8yQ1GONMSEWSdtsC/VVCHdl6+0OJLRCz9q
 Bek+tezTGS+nhU9WN1Q==
X-Proofpoint-ORIG-GUID: jWI1A_87ayOe6ph6H8bnaN0QeW5xLSez
X-Authority-Analysis: v=2.4 cv=EoRHPicA c=1 sm=1 tr=0 ts=6ab6f2e2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LCi1ejpjiGs4dNKQ4eEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OCBTYWx0ZWRfXy1Ji/omScD3y
 do7yf/6oXgSukW0zTw2k1NgIHLnq40/Ap9U5omGWPhNKawAWgK1wgOrxYfmMr0e4zAyGaw8fNRj
 X7L9+O448fseaB1szrSabVeoXRmf4YI=
X-Proofpoint-GUID: jWI1A_87ayOe6ph6H8bnaN0QeW5xLSez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250088
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/24/2026 2:39 PM, Pierrick Bouvier wrote:
> This series solves:
> - detect and choose host compiler for host target on fedora
> - detect and choose cross compilers install with homebrew on macos
> 
> It adds a new cc_alt list field to test suite, to specify one or several cross
> compilers to try. If none is found, or none works, we fallback to containers as
> usual.
> 
> Tested on debian, macos, fedora, archlinux for x86 and aarch64 arch.
> 
> Based-on: 20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com
> "[PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host architectures"
> 
> Pierrick Bouvier (4):
>   tests/tcg/meson.build: report correct cc in summary
>   tests/tcg/meson.build: introduce cc_alt (alternative cross compiler)
>   tests/tcg: add alternative cross-compilers for fedora
>   tests/tcg: add alternative cross-compilers for macos (homebrew)
> 
>  .gitlab-ci.d/macos.yml               |  7 ----
>  tests/tcg/aarch64/meson.build        |  2 ++
>  tests/tcg/aarch64/system/meson.build |  1 +
>  tests/tcg/aarch64_be/meson.build     |  1 +
>  tests/tcg/arm/system/meson.build     |  1 +
>  tests/tcg/i386/system/meson.build    |  1 +
>  tests/tcg/meson.build                | 53 ++++++++++++++++------------
>  tests/tcg/ppc64le/meson.build        |  1 +
>  tests/tcg/riscv64/meson.build        |  2 ++
>  tests/tcg/riscv64/system/meson.build |  1 +
>  tests/tcg/s390x/meson.build          |  2 ++
>  tests/tcg/s390x/system/meson.build   |  1 +
>  tests/tcg/x86_64/meson.build         |  2 ++
>  tests/tcg/x86_64/system/meson.build  |  1 +
>  14 files changed, 47 insertions(+), 29 deletions(-)
> 

This was merged into master (efa3b9d5ac8024078225e1ab434411fdfe53b457).

Regards,
Pierrick

