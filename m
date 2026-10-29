Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W0ZiXBPo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dGRB1gbF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJdf-0004TU-G6; Thu, 29 Oct 2026 02:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMJdV-0004TF-B0
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:29:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMJdS-0004Eh-73
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:29:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5H3w92974719
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s6v7CVCB8o7l7Vkj52MtI4RcULCff/mbUWoVtkbRMD4=; b=W0ZiXBPo7KbwwYDZ
 mB8ugsrRwYt9GWpEGyF0aPuPVtps/aPH4mKAmUcaaXEFOjfjUN6/a/kIcB7KAXzF
 RyDt00xPm1H+WuAzbVOD4XP4wYYeeKSpOikw6tqlLDZY0r3aovxr1OLutxAU5t6f
 G5wINelCW/v3Gbak+VeH19fEqBWHgOOd/zl7EAyAaptVHfXMs2s8uv1vq74IW5ko
 5UoNDMB+rZDbAXr0HLvF+wTpDn893u2IPcmm/8D2JDR7YFGWIYYl3uvstzcmUoME
 fXtrosijNdaXTDKrQpwMc3/JZ3cjHRhokrL9uB35V+c8ZhCuEgaY6ji5CfhO69WQ
 7s9h5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkpag3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:29:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso80229385a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793255352; x=1793860152; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s6v7CVCB8o7l7Vkj52MtI4RcULCff/mbUWoVtkbRMD4=;
 b=dGRB1gbFjszPUXCIr+IoNBJSTUvn5uawwDu1LHYhEIie2+pT4/8Vax6ZnTkIl8+M91
 eVhJYrxWONnoXozuU8ZwyO8pPuKVweUyMqNPeN4dIBa5HG+rmluNWevfOdGnXcAhOC+1
 FN49WRNC6MIaLb5FhPVMxeNsJQW/RanY+wjmy+7/Ufkmeis8NwCRtdAmIZNwulo09pOO
 +lT8V13Vp9yaJ0FKyV8p2gk1rE5RSAq0Y14SyQkGJCZuEcHR2AJIHbPLhm2cYseIVqaL
 OQcKJsTzcEiCJY4sWLjTUr/bN8uzja98gCOyyCBGuDqgYHgLKEkayY5vDBHfTNNstX4O
 fHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793255352; x=1793860152;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6v7CVCB8o7l7Vkj52MtI4RcULCff/mbUWoVtkbRMD4=;
 b=KW/Y1MmlHjdi/eL76HgLwCH6u4t84K86mm/EeNPskjkGHqutdxZR66KxH+9348Uvrr
 UW0yDvuqsHQQ2QtG6PslJmcpUbx2fnCyCP5TVn5sGvVn56egyu8u4DUp6qhSiCKh92GH
 yoZsoclr9cQqfm0SN5onxtVccZgpL4zz7SJjAyhHng8tCDdQ/dCBw0zC6hELWhuVbKTk
 aglr1YJ9MFY31sq+zWsxtXCH0ASt5O4fRbiHviNOuUZZPP6lrJ/YbVatK5E0qXfAnmDZ
 TSHODxmNqJ0OM/E66mdY2iqMhu97t7MA9g3NpfcngSZUFAXhD3Nwnjn473vQ6q/8miYz
 NITQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqW4Xh55B2MkNTvByxxZ/j+RkQlNVcqOoZscBCG9PwR4pBlBTlHxPzg4cZ4FTVbMUS3JQH2eokjqQO@nongnu.org
X-Gm-Message-State: AFq9FYJzMkz8HcheMkKsx78CGSFzkTWDqMhZNyue8u7sjzQAJb+4SkBs
 DbvypcttwPQ0a0y80QmhpKcbmrPh5aHsiRgn+LBNxl0GsRBWVPi5YxVSKTMGbPwmAPfZrUVBlaV
 aLyx5VyVvahUu7MRpNNR7B2w8NIqZIvGOcgxuuc7ig+7M6T/J2bLD8UIvyw==
X-Gm-Gg: AYBFou0NNyi9Ye8cJLAPVGwmbIjDvzZRpde2D9bCNhwyBflrfnfu2MpoRKYPuzThYd2
 M/gN+TRxXMLJSO9BFe0c95KumVRP49Cqz9rGwKrhl48F9FXGLwQNLb5WJd06rgiAFN+GaKGjdWw
 vPwWdLReKga/p4jZAidCowXz4usXvGzrJOBviIomxK1DKGxkbCVXqSV+btpkv4HjMLgioM0uA7L
 /w/UAtXEU3F8HKLD03yNOE5PxfbpOQbluVMvZupVhBCoeqLmSFik4KYZca6xXOWgn2dwX6uqGKK
 SAfDM1ryaH0GeVcoYV2pHj1PpsEqnTiZOWoXAy0r32z5GcSB4UJYJIqoC4HGYU0go13dCm96u2I
 Xdrs14tpKXgVFULisrXzIM0aNf9SB+1pMfxP6eqoK49LLdbO1GZdQR1F/eFkYNvQw+h1Z0VXKET
 6+EhOv+G6ywt4cuGg1ay3XxE0=
X-Received: by 2002:a05:620a:1999:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-944133ab8aemr246405385a.26.1793255351711; 
 Wed, 28 Oct 2026 23:29:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-944133ab8aemr246403285a.26.1793255351309; 
 Wed, 28 Oct 2026 23:29:11 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm32343537f8f.1.2026.10.28.23.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:29:10 -0700 (PDT)
Message-ID: <ffeb9d35-33d2-43b7-8fcf-b06b41da76c4@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 07:29:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] tests/guest-debug: Allow placing the binary within
 system QEMU args
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-4-philmd@oss.qualcomm.com>
 <efc20a14-3d7f-4a07-ac18-418176dce90d@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <efc20a14-3d7f-4a07-ac18-418176dce90d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae2e7b8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vblQO43M5LkMa_b8vGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: nNXzrHBpcnnORE7jn1Tbv3LQPMzyTtWh
X-Proofpoint-GUID: nNXzrHBpcnnORE7jn1Tbv3LQPMzyTtWh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXy4jPipWqbU4q
 gKDSBNale2uoQ/x6v7Xnv0BL5eEmxs+2mJzSzNqEH+hWS/3K+PS4LnWWIbVDYxMzrb9qjj4Zn9F
 N1/J/PXmX7lTBs/v7/E6sSgGQcFISv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX1HLdukXLwHnZ
 +px+akUNdzJNOp2+lreKPUQRgrzbRVlVEq09/MW+65rS3/TMCK/Z1aIuHLUPfs13OQRBdG97YKw
 YdZFeZ0x8k5eLCAWIloMi9UA+eQCiBDrcRhd282pKftJsh+Q/meLRapduUmxrIw6/ODMLYOsM9u
 TTrV/IAPYdBUO8RCi/mDxFJAA7C+w/vBcnc2VP5wlohQIkBgRQcL2RJOSHk7rMvV/16S7G42YqA
 xszEUuJu/1Ub8G9LadQZ9XIWi4MS03cdqWhpA0c/fPyaMmZN5NRb+fFdbrslemgJLV/lQQb+Hrw
 RdRMeb34GIqFhBZ/uQY/6GT8rpRiwDUV5mEuvCd2BWx2y9g6IHCvW1rgZWgtCOre2DY76iCbmvQ
 d1U/ERosho0ZvfdYECq9hK0UslwJiR8GN8WNzv+L3moWUun+CttaQUjif0OuTQzjfLG8qRXJ9J+
 GOUWbb8+KYmQr8Lpbtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/26 21:36, Pierrick Bouvier wrote:
> On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
>> In system mode the binary is appended to the QEMU arguments, which
>> must end with an option taking it, such as -kernel. Machines without
>> -kernel, like 'none', load it with the generic loader device, where
>> the path is part of an option value.
>>
>> Replace @BINARY@ in the arguments by the binary path if present,
>> otherwise keep appending it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   tests/guest-debug/run-test.py | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
>> index 9fdf05b55d31..e6911300e8d0 100755
>> --- a/tests/guest-debug/run-test.py
>> +++ b/tests/guest-debug/run-test.py
>> @@ -87,9 +87,14 @@ def format_cmd(cmd):
>>   
>>       if "system" in args.qemu:
>>           # for system mode we assume qargs has set-up for binary if
>> -        # indeed we have set one.
>> +        # indeed we have set one, either ending with an option taking
>> +        # it (e.g. -kernel) or using the @BINARY@ placeholder.
>>           if args.binary:
>> -            qemu_cmd.append(args.binary)
>> +            if any("@BINARY@" in arg for arg in qemu_cmd):
>> +                qemu_cmd = [arg.replace("@BINARY@", args.binary)
>> +                            for arg in qemu_cmd]
>> +            else:
>> +                qemu_cmd.append(args.binary)
>>           if not args.no_suspend:
>>               qemu_cmd.append("-S")
>>           qemu_cmd.extend(["-gdb", f"unix:path={socket_name},server=on"])
> 
> A bit implicit, but good for me.

Indeed; I updated the script help output:

-- >8 --
diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index e6911300e8d0..74844a64d42b 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -23,7 +23,12 @@ def get_args():
      parser = argparse.ArgumentParser(description="A gdbstub test runner")
      parser.add_argument("--qemu", help="Qemu binary for test",
                          required=True)
-    parser.add_argument("--qargs", help="Qemu arguments for test")
+    parser.add_argument("--qargs",
+                        help="Qemu arguments for test. In system mode, "
+                             "@BINARY@ is replaced by the --binary path; "
+                             "without it the path is appended last "
+                             "(so qargs must end with an option taking "
+                             "it, e.g. -kernel)")
      parser.add_argument("--pargs", help="Program arguments for test")
      parser.add_argument("--kargs", help="Kernel args to --append")
      parser.add_argument("--binary", help="Binary to debug")
---

> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Thanks!

