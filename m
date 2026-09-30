Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1994CCA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoTe-0005y6-P9; Wed, 30 Sep 2026 03:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoTa-0005n6-O4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:11:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoTZ-0008PE-7F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:11:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6oMK82321789
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UuFWCozZJdn86k7gDSo85w8Qy6Z3PfhNhjYijAR+3NU=; b=FQi0Ar2B4vqZ+cGC
 mjU8RWDLqDwKn3Z9ZmQJSZtB9JdriDyV84Xv6UP+/+6gyOD+/A6TLZMSxLM/u8v2
 fAGbMSj7HKjaIY/nnXbd9tnLOPxP9zfPOCw5tmNAoVDltgVawrVxL5EFKTgywJYm
 BaN6+cfEA1lXV6uOJXP16GB6g65MKrtHPtVMu/fgDuboprcXv9DTWJse2NPHs3IW
 c58xCuGyH77vL1KDjroRZlLE092tdoE/Nd40X2l5U/fu4+lENLM6zl8QVdGqeAmz
 lCaPH4Wvl7Rzv5Rjn3vCqDCn15B7ksv4HThQn2jMARrVakG4Fhw+DjWxfBTjn6FF
 iaKALA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0txg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:11:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so68576885a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752294; x=1791357094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UuFWCozZJdn86k7gDSo85w8Qy6Z3PfhNhjYijAR+3NU=;
 b=LtfwprE8OXgG2yG9q1IK2q9Eahp9hYfjH9HMRXeZJrB+qCme9gXDSQsYZt74aPrHFB
 Ywoqukjn965npmYbkxcpxMtroBgwJsX7aNKzXWc6S53Er3tWAfqm9tcSeHDzQ11HnkxR
 lbVLvLWT/edZxuRBbGVEEdVY8iH+7FDKEmrh5lPALwgxdtydkREc/U+S+rcA923LJWS9
 BjE16PsZvKis+vM8SaxevZ3Viv11GcyPv+qnJ2FTkkqX0BIrIcJjCfXNkqDeBNbdbVVL
 KtgPx+9/EzZfAI0roBcEiUSzipyZkRB4/1shNW9Kbi7+hovlIJL+e2fDk4vUFGP396G/
 vwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752294; x=1791357094;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UuFWCozZJdn86k7gDSo85w8Qy6Z3PfhNhjYijAR+3NU=;
 b=Hoowgdpisznr1EV/oR0r3gt5qLRdUyRC9X8Vk98KCXQQC1bPbBVo3KJEN2DBsxpboM
 hpPq4kT1fiAlpS7wPQICM1osXjEVT6FYEjUDlrgc6kwXb8elG29AOgT9SjiJq5b9VJJf
 C/TXlJQlRUit+m65Ok0TwpifAQIqVR1nppNiO6lLD2uPYgY3BI5yX0SxVlGAEr8a4li3
 90uwm8ALvAw2Ud9cjldS5qrZvhGUYiAjh6Tqdr7yJnrGU6yHiH1P8zAxhVh+779skl47
 YyXX7S4o7AZSwvInWzNn3YORvtKqiKoacCNT4h02RgF+EcTlfUDUuNIxG9pL6N/OP0GI
 wamA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnGpm7bhCfmT1yhby9dnJgrFZ97/8OH30YDpH0J9qbjsh7G9Ub3P5A93IfNVRPLeF+5rhWbg8J6HfU@nongnu.org
X-Gm-Message-State: AFuF++mtX+ewBnCIhrj/Bju/mnZPo5TQaxwYaRkcYEk2OJzrnSRP8BH2
 c3i3MqPrwJtsgkBUCP8/uNVBxvkL1Sne4rh8hjJZCAvFkKYelh85xdX8Xl/E8Nvx2XAhwV0FWla
 9eKAMtjZ0ltf0x4+2hzFSBN5aS+3YrfdOqxWXdYHMdL3may37fQG4oedrRw==
X-Gm-Gg: AYBFou2BU6Qc6wZT8AWGKODCCC9YpRRzrYqtgIe9kYrQub9WGlEhIdTmhS4Ce1yKUpp
 ND1PnaMlhcVr9ZUiuY9ducZhuBT3013wiqxDbhASmAXGeT+jXPPJVunYKotwOUXQS8r119KApqS
 RrW2dVH7wlrSGgO4KwhbRirdrLezw+lqCrAU+y3AIx/5Uaa8roRLqwIogGGQ3P3UPy/D3kSEUzd
 lvdVVoz+zIjLfhnKWCXYw0LjGZJIoXBFRVb0BdE6DOxFv4n0pc0Lg9rm3gjCG0XVAQl96N3lphz
 zoXbbpXj+Ykschp0NN9yA21LIJB6VF7yM9GWmgDuqD5F1ayqvzlIAjGoTP/1YEAkgVDYotmzyEp
 NL2pgyW08edZ2XAUWa9RLuPMROKzBXP1Ybw==
X-Received: by 2002:a05:620a:d95:b0:93c:6390:220 with SMTP id
 af79cd13be357-93ca97ff5ebmr63763485a.41.1790752294170; 
 Wed, 30 Sep 2026 00:11:34 -0700 (PDT)
X-Received: by 2002:a05:620a:d95:b0:93c:6390:220 with SMTP id
 af79cd13be357-93ca97ff5ebmr63760185a.41.1790752293700; 
 Wed, 30 Sep 2026 00:11:33 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bef64sm1593499f8f.10.2026.09.30.00.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:11:33 -0700 (PDT)
Message-ID: <51fcbbdb-a2e1-4f34-8abf-8e2a56928076@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/24] tests/tcg/mipsel/mips32r5el: add msa tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929212439.110454-24-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929212439.110454-24-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcb627 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: EZCtVjB01ZlvxbQ1EJjgbbcm6FyU1b6I
X-Proofpoint-GUID: EZCtVjB01ZlvxbQ1EJjgbbcm6FyU1b6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX1Bnk2zO9AJgU
 bmAiSSvRE+zsjuOEZZzv30M6qh9MBlKisaaW5Gn09Dk7y95cy55BLwe1JnTziR8vUdOEmCurszg
 fvrVAGvjAqy5acscgnmUiJAEAYQfMdpVDgYTBnhyAkq3aYp24jhboE9vGCsRtkKhhl0Ww2DNy/d
 u3GzDbXTWEl9pKW63B4fIt0qNBSl4a6cgGiBPmUFrmIQY5/OLzD6r3GZ2FcKlOPn8A9NTZLwd0A
 zooC1NRkg6tYuKdw2JALoX3d6BXyNWVGy8NcMem0B65ZVOQFaClpB0lDCcoSY+ZV3zeBSCDXaZV
 Q3qGcLDOtKOziNhvmvfvNMLHWx88ehQydIV71instYftZ1AthZBWx7b1xwAGJUcMEcYUKRfTXcf
 QpbCiX1YiUVQOTM57mX+QSMW/SZtr0LXvUs1zhNSA6Sr5dEENlKD/Z2DmfudnJ12srFv1qJCqb7
 yx3Fc5c5KwkeZWBFR6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX7lUAD8+noEOv
 I5X9LPdbQ6NnqvFrQQrUS1HEGeAAWP6OEDuIj27YhibLpKvrvcn7eAvQmuqPngPxbG9ZzMur3aZ
 BbNYp/wK5h3acFJDP3FomarJLbcgqRU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300028
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

On 29/9/26 23:24, Pierrick Bouvier wrote:
> Due to missing toolchain, we don't add those tests for tests/tcg/mips.
> Considering this variant is not widely used, it makes sense.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson_options.txt             |  4 ++++
>   scripts/meson-buildoptions.sh |  2 ++
>   tests/tcg/mipsel/meson.build  | 26 ++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

