Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A1BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUNU-0005zD-Gy; Tue, 18 Aug 2026 20:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUNS-0005z5-SJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:41:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUNR-0002X0-Fm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:41:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INlbHt2379472
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gEGxKspArMoAZmB1EMqxNamgKeSKRRTwk4N8+6U4zos=; b=Cfx+e67uvvaiiges
 82uVbm2fbyhul+0I7tws8WqloAI/taX5pikAb0gsc3v7l3FQbSQ3GguvJ/L34Rn1
 eSMEhG1NWDDen7PjytwY/yRaH8Gs8rKnlRPc77/c40O15Nt1Gg703vOh1LqCpeQa
 HT/YpJyd0HocoQeCT/mTbb/gXmNinVKLL0SbJ7RMM4dVrz8vk6Lu7IXbKdSMYlCF
 DSL5hE7nQBQ40r0k0+wkI4KWPgfawtMLrWU0exNAw79HoT0pYyT1dTgUqUAIO+OM
 ouNpjBgpwFhD3CnuMeJoZknlCxojSP97iwObesK58g0YXTo3LkkArA94Vnx/NTEE
 0Injkw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yffghxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:41:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9349c5af52bso86241885a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787100115; x=1787704915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gEGxKspArMoAZmB1EMqxNamgKeSKRRTwk4N8+6U4zos=;
 b=LIeRz2K7oSIVGhqUuqQY2qTrT7jlIumV8fLYBaBFuB0bKZcyrUbyNQ4aOZt16YNZbJ
 Ub9nDl8EURcZ7Kr0jpq6mmLxYL+UHLo4oAUfNYxkENt3buHY/3+xvGeWua9BVnjXnql5
 znyVOHj4YqCfNyUCv0CSlFVfxmkwEwRp+d+PrhZF7vWBtpis+DgKrYV9ybx0IO2W4gKJ
 qIoti8FU5bOPNZkdc9qq259Rh1nw2v0qjZtY426ozvbZ95obqPPBlZCORnDCwNk46TqD
 g3IiHGk1TMK8eoIGllNtaxoYFlCrZiDzy31u0myYhquUTQs6XBAf8R3sJ4facoy2imD+
 twNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787100115; x=1787704915;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gEGxKspArMoAZmB1EMqxNamgKeSKRRTwk4N8+6U4zos=;
 b=EbUPoM4tPoPVYWNO21JgxtHsEmOld70Hqibj1Qn6IEZprmNssLhM8+pSao2y+3uaoz
 096UHG2LXZlUmoY5X2QErt39CW5DFq/P/L+9mT+UHGrfz0o5hbRzJyQw467gtz9eKmhG
 08e6KXtzbf0Yt95mNbhgIC/QScRcI7Dvq3xCSxZw40MEo0tc/XLPjZQQpvpRFhdoXa4v
 UbKha1lsK2M89f9ldTms3lJ7pwTA+3bm/y46jjKHHoZ5/43ROBxaF1v7mRy42PdCP00L
 /hktypVDW4JuxEgc8Ast4fdl3Jr4ooIvtXjvy8KV0WXymuQcFWp5obZDA7X9UNUIeCiN
 EoBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEidKIP9XIL3Ib7aBhyFDx21urxzSeW+RbkKci8N56wHv7Cric8E8mo7zpBSMS01zzVXXyjejgoPkp@nongnu.org
X-Gm-Message-State: AOJu0Yzi1FbVQSKmSI1z9vTzDQgV6WUOB+x+2bAagNMJkbIZJyJwjAIW
 wD+ToL77/dLvuVzKtWAxnSq2nzfePPsXmEjhoCRD6MIa4qJR+GPiydKM9r/Stb+samlsCU+Nnv3
 lIckmUTjAwL2nlrvWJCklUtidUmhfISqwvNLJsmxjbTm0hcsH+ez+sYY99A==
X-Gm-Gg: AR+sD12c+mu/RKYf7/VgZURsah4PLXqSUDGpva9X8fD9LJgn/IZtZFHitwLZSD4GThf
 iHbKWbjSESZiePjCl/B+s3b24uHR2nsnZ3WvcX8cE6x7Ruh50Jo7E12vXRR2aqzzTsswtvokimg
 AmUmBFBUd2uKeG/u7Igp4pgazk2qIgvuK4finG7d+9T4/OMU2k41bDkxkITR7XxfQiRCgtkPICM
 uTDH5o+a9NSCBdy93/IEFB8i0ToRgear8/+3cb/7Ebnv7v9l7gBbt3MlkL/OWKBVhEcRgibFhJe
 cxQb7D7fR9QTWLD3t6yDljibt1JlcYQpn3eki2QKwYtR/NQpyuvkWVVGDYaM/WhMGl23NKNCsDJ
 l+Wr+f8HR+38rzKKtdo8dhcmArrtW/G+QXFU=
X-Received: by 2002:a05:620a:28c6:b0:930:f129:1a45 with SMTP id
 af79cd13be357-9371e2ccc34mr138466285a.30.1787100113744; 
 Tue, 18 Aug 2026 17:41:53 -0700 (PDT)
X-Received: by 2002:a05:620a:28c6:b0:930:f129:1a45 with SMTP id
 af79cd13be357-9371e2ccc34mr138460985a.30.1787100113166; 
 Tue, 18 Aug 2026 17:41:53 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e09905sm19360885e9.4.2026.08.18.17.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:41:52 -0700 (PDT)
Message-ID: <3021133e-b8d2-4920-8cab-d38ab4fd1da8@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 031/104] tests/tcg/meson.build: use full path for QEMU
 binary
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-32-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818192309.22169-32-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwMiBTYWx0ZWRfX50YSUEB3LitY
 Y4wwIxpzJjYpTdxsZszgwocEp+jHC8LfiIBYX+g5dtJTMPF3xVcGh3qtEpIXKjMsfsOKDqFWBLz
 BGUfUw497o+xvcAhCCL7eXNjzuwEUZo=
X-Authority-Analysis: v=2.4 cv=H5PrBeYi c=1 sm=1 tr=0 ts=6a84fbd3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ddsRQldYuJUNmx8muG7JNL55yMj2w1j0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwMiBTYWx0ZWRfXyq8QqioJ6oHV
 C1bqOygvtrTTSUAj70LkfnLV+V9KdoQPKoE7kWh2q+zIYfZ/Box2gWC5V4I7PZ9rLgBwiZbKcVP
 FrjfURX2grvZmm8qMPI/DN51lTj/+sDmc7HJtTyFrRLnt0jt61Smrz6t2hfO49A0CYuNHElOtOG
 6cWbM+ROt07NZY85sz0F8K7MIOdMiWoCq9Ub7Ds4K0nqpGRAxUlxsftJfpAxTbcY5m0bhI03yWI
 1FEcod/O/k1vI43gRlIW8x3jV78Ln72WKMFIxd1hctHItAc+daW5TF43EuGPkO4EzifgWpesqbU
 iBRZotLVq7DeiW8nf3gJ6ET7lo4B90i+9f4xVwQT/y4lbpJcM8j0JUygbEX8rXOipdT1eCYk2Ja
 gfmZwl3S5KeFQ0xSvw7BPR4rRq3yGTHb7ilAOGYgfN3ZiRCK/A3qVuT4zuT18gbeBvW5hFlLBos
 e04LOYunP7jCuLtEz5A==
X-Proofpoint-GUID: ddsRQldYuJUNmx8muG7JNL55yMj2w1j0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190002
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 18/8/26 21:21, Pierrick Bouvier wrote:
> On MacOS, meson does not find qemu binary. Use full path to fix it.
> Also, add qemu binary as dependency for the test, to ensure it's built
> automatically.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

