Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D01C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9UDQ-0003wD-HU; Wed, 23 Sep 2026 17:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9UDE-0003ua-Fr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:09:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9UDC-0008OD-R3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:09:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NL89uu663773
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HEyZVvdbaYgiJ8rzxnwYB1x47sZyvErVH/rIu+XkOvs=; b=W6FMChoWvKkx/guT
 bIGkhqLCZGZ8aDI+qRV0ZKDzWg29Tus2keFiK9Zz+OUvrVD4s7T29mhggR3EPRYy
 Ft3voLryEL/e2PcXBjwaf/omi5gAyqC7zWKj1+LbngskQI9Xp8N6lcyQGLugaj1D
 WcQQv4z7yqLIYug8CdMqlLJymPR8MH1VQGmBCpnbdaqpZpWFEqya++RaxbrxGeLE
 bYndCnasnGW9oyKuGTnqxw2YQYzk7MTGlDTTPIjE9Xd+z27K4enTXKwkpWCLJ5+I
 BKc7X3LKFgSxO6GtaErDX7vBbJkbvmL1mD6dmnbeQVyHKM4C8Ft61mPfk9GUtXvZ
 1x3uRA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfkbj0bn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:09:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1721856eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790197744; x=1790802544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HEyZVvdbaYgiJ8rzxnwYB1x47sZyvErVH/rIu+XkOvs=;
 b=hb5zB7M/Xwlm6P2imMmLm8XjRl167mxGw0hpHidofQg33IVFzd94O6DYLl3jF0Agps
 rNYvkhjjAY44tGAIDKQbPaK8knnVDEjHIzq0Rj5iFDxkVEVZnKRfNjVWc1MotO2HUhmc
 a5eMYcH4DBZtQR9JXULEOMrjqgsZvfR9/vZDZXAXVECI2OIbX7ETcqacO8egRmUhWOPk
 ujzgpxH/gqsKBxuov6ck/842jTLrN24+mOmpZjshGA2MGLgg8kT1u/uJZo+XQXxg8NGA
 hjz/b6v1g7EqB2YKmObEchU1iTFw0+v/cnlsb/MNPxRORh9T3PXl8eFnhQ+zSTjQQqYp
 QFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197744; x=1790802544;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEyZVvdbaYgiJ8rzxnwYB1x47sZyvErVH/rIu+XkOvs=;
 b=dHRw2oBcUrSF/3nrx1JioofQk17flWo6olyXoCRcD5tgvT6CMo7fOl+lI/ou9ckfwg
 iPT7cEtXH58CobFkufQ2zVJd8GkTyyJWXt2oKAftMIWHP+JKF0x7XPr3bu3ZFGfz0p2i
 yrnD0u9w9NCWC9z/2UNt48/uXxg0fUUVcclu5tsOymVwLiB5EunCYZNBd6sxIkVJkyjX
 OuUBp4PDpEM6h5L/ZGWPu4ONIpd1DENBmq9NG4N3PftGCpy/of1LNoLL8NNqWTPZUatt
 5lwmg7ZgcJI6nhaNBXvia5scLoct1PcnR2HoDdAywBtKA6kRd4HXgybgj8wHJzHEnnNl
 Erlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMnc2p2A8VjHofrq/9obnXRJioF6wlmeyB69wKy7MR6Zge0HRsUWDv75Sw6YHL54ZT+67RC3Kbg2pj@nongnu.org
X-Gm-Message-State: AFuF++lqP7UpNcBgyZwq6CLNIkA0f0DuXeuLUi/Tj+OYzseC2iRm6iIb
 tS1niPQuFpGi0bszEbkI+4mPk6GcXL+UFF1j3RdEH1/Nq1fA/89lXw6Iizf7lJXGMULyK60UGo1
 xg/TN7ZYwIKoLl16FCZQe1LLac3XagQ34sZY9M7I+Vo1hzQ3cRLW2ugDoBw==
X-Gm-Gg: AYBFou0AX083oLjikVBGeG6T9eUZ7dyAKm0xPZCBRFLnX7LXDZbxnikQrMRZA50PwOi
 z4MaKYsLQCwiwFvIR5ZaM4001qVQsIcfTRlwHv1o7TYjSlL7JoZ/NTGv2Sdful/MdoY98xHGo+q
 A/ApoGKZ8EO2FjdAY6/Zwaf8I8LAroOJGMHH0kVjzZWFSg/jNB0H/bj3ltcWpXSr0thdcBP27I0
 Y1ooxmeQeRlmjZhjJb3WbpHodxy/DH1ztMc7zBgMben7vcE6/nGjxRMhYB5MmlUfXraoRbI3Ilm
 2CvvcqwuDLkvTp3tWPO/xHemdZd74YDGOIBX5MRBPZeR8+R5W6C0BpJnuepPwroORZySZTS2iHm
 7U8zZPJpaMZrIKrTFF/pl+ub06z3X7SBwD87KnxV9qf/c6kahLSlEljlvPS8E5VqKi+c=
X-Received: by 2002:a05:7300:d115:b0:33c:e82:70c6 with SMTP id
 5a478bee46e88-34000b32287mr281798eec.29.1790197743865; 
 Wed, 23 Sep 2026 14:09:03 -0700 (PDT)
X-Received: by 2002:a05:7300:d115:b0:33c:e82:70c6 with SMTP id
 5a478bee46e88-34000b32287mr281456eec.29.1790197730895; 
 Wed, 23 Sep 2026 14:08:50 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96e48e3esm9202303eec.26.2026.09.23.14.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 14:08:50 -0700 (PDT)
Message-ID: <5f719ab6-442a-4eb2-90cc-0475016a816b@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 091/105] tests/tcg/x86_64: user tests
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-92-pierrick.bouvier@oss.qualcomm.com>
 <935e6ab6-5f86-4f1b-80ae-42c7219eec46@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <935e6ab6-5f86-4f1b-80ae-42c7219eec46@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4NCBTYWx0ZWRfX1J0OUPbILfBN
 aH+wOxlY8NqSdCjGxw4ikn97oilu1YzC7uGxeacr10ZdRoOSzcnyuU+NP3s1jL6prWFeP93srPT
 M/Fdgu+G/ETu2FdBogglCZwxKccNOb0=
X-Proofpoint-GUID: 6hZmgVmqvXL6MBaAKHYSVQU5SR1c4391
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ab43ff0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=r0D9N_VWEkQcCGcx1eQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4NCBTYWx0ZWRfX6+ljJP2ucnEo
 3C8NFpJRIcFSQMx01NDlVRg73b1v9IdjkFbxlsu6i1cSgL54gD0etidmI0mXyCj6H0A+TsFQrZW
 mFWbkL3CG3xnZBuyn8M+Z+4UMit0Fa1Ey8etRomS+LhEqxwI/bWdfz7j2VfLHwBpvoqrm4+Y4m1
 Ke48khNxwOq+Apbpd1D8e2KoCWg2y59QvYwGdBoACr/NVVZRy2oo9n1cQe0hLSDesp/rAKCxe4f
 5qJg8J+xBSgQp/DNQPy7QNVBQ3tG8Aajb9mS/a8OTuLxA1PRvaKQtpG6kn6pNpbrFFcXB5fV1DW
 xll5R4EhC6q1nsW9tXIWHohRhhpxYcMkLrPW6Jsbp9vbMMVO89LatPFTuBZuC2GLMgTcehrBcb8
 mt2JazevAfC4LtUu/cEf7Ua50650PkFj43qkLMvsLp8lFbR8cNCV0UZ4ZWHZXc08u3yW8cRNNf/
 3eeYWsj7QUIfFWlDKqA==
X-Proofpoint-ORIG-GUID: 6hZmgVmqvXL6MBaAKHYSVQU5SR1c4391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230084
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

On 9/23/2026 12:55 PM, Paolo Bonzini wrote:
> On 8/28/26 00:14, Pierrick Bouvier wrote:
>> diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
>> new file mode 100644
>> index 00000000000..2607a1cbcf4
>> --- /dev/null
>> +++ b/tests/tcg/x86_64/meson.build
>> @@ -0,0 +1,82 @@
>> +cc = 'x86_64-linux-gnu-gcc'
>> +cc_dockerfile = 'debian-amd64-cross'
>> +cc_docker_host_arch = ['x86_64']
> 
> Configure was able to reuse the local compiler instead of requiring docker:
> 
>   if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
>       case "$target_arch:$cpu" in
>         aarch64_be:aarch64 | \
>         armeb:arm | \
>         i386:x86_64 | \
>         ppc*:ppc64 | \
>         sparc:sparc64 | \
>         "$cpu:$cpu")
>         try='native cross' ;;
>       esac
>   fi
> 
> Paolo
> 

On debian, gcc automatically comes with ${arch}-linux-gnu-gcc variant,
so I didn't replicate this mechanism.
Maybe it's different with fedora?

In all cases, I can see to restore this behavior at configure level by
setting --cross-cc-${arch} automatically based on host arch, and if gcc
is installed. Would that work for you?

Regards,
Pierrick

