Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CCC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqCw-0002Ee-Rf; Sun, 27 Sep 2026 10:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqCv-0002Dx-LR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:50:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqCt-0005i0-6f
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:50:25 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QKckgK263506
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvMCoC4vgmKhTeYSWIR6ZcW1N+ZwWnoP7Ep5gY3gk6A=; b=jrnuvgcfCpUDZrH6
 YNqJgjxEhZydls1XMkakoXehuHXW0e7k5zhx7oqmajrfIe9KYOYkIs4rnaD8aaE7
 VCnwoKehEVmffX7FsUGRzCoI9LIUKs7UFAqdp260w8k+4B1YDyPiMEkioXV8vtya
 XeN6mZIZuSyIVt3ZhSjOtEDXXnDudMwDqOokdIwgQwnlurbw1fkzRE07PeWpLoVE
 4/zxv4yY9qZdwphf3ISTXp2U/RF6AB8yZp2aA9wX7698wP6RUcDSrDkyfx5EXIf3
 CF/jCwCvLvqaxkMi+1XiTi+7su3F6SqjUUJU4DIkmM2Hxb1MJxMTfdjO4G18Cboa
 rvKzzw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek1yw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:50:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939c30aa9a0so236208785a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790520619; x=1791125419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jvMCoC4vgmKhTeYSWIR6ZcW1N+ZwWnoP7Ep5gY3gk6A=;
 b=DUAUcWOqi6HgyVhDlN1Y+IfJrs5X1iywlK8Pgmyop+k0dZFnB1Y/ZyfW6aumPyVr2F
 8oM0lHWn9zufyqSKUEzZ5KEzXdkQY8jEqQH/oSexBchVTBD2c21mMXP4lvjV5//BqmJg
 qENNOE3tD6/mmpbbpSSbgJg5iKHyg2UkL6z3o1FxrDpMcDVzBrudo0riVm5QlYcZe/3S
 mVnH5Z1xLIKGNqhuaSGcSUQCO/NWFsyJgjtHs7QECWPm0jAPsu5eaGArjvWx6kQ/8oGV
 pjZh3Q/UvKK9n1CUT2nXgLqhiS85A1RoKgb7Z5pipZsqdEUbR8GXI/3wtAayBTFv4P/l
 gfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790520619; x=1791125419;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jvMCoC4vgmKhTeYSWIR6ZcW1N+ZwWnoP7Ep5gY3gk6A=;
 b=wAmJgbWCgNsQIIbfEtZuBZYcL7fJezVcjNWXeex0DZVUh2kENKObjCNKj4z29bimTx
 Pn55hHpKyK3k0mQzss9gTSsfXMNQ6EPUAEJb95TZuJd255HpkQLCdK/CJDTfr0r3DJ9v
 4ORePbI5M2v87dOBTDY0SDVsQ4uNaIYZYsIiM/jtCm2QmEYW+K8RWDerL9vkGOmM5Auf
 ywzXkyQky7gs76YnYViqBAGhcahYo48VRU6CoyJoNAdq0H3AKeSbhK556H8HjAT79ZTU
 FZY9PS21EWeTDX3GXFm+xbkUR3o+hjGTAMSHQt2rGKwagE7H+OLOo2JBUT93pYjDQrGl
 jXwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+/wJh7Zje5l3ApdyAj5Ijey7YIIGsLGimXiWqgkDjPjiGc7X4ZAe+GFab2AnjmjxjevjXnfkjAHvL@nongnu.org
X-Gm-Message-State: AFuF++l5281iFagI+JwgfFLS0s8BMyfAxl7sFs7zQPjN2amn1gcOOgTu
 m6/esfTh9ioPugkxieyjFgGg5bGyOPMQ5tOO5lSYtKj4tMj8sljPfcvuyjtVvmPi7Uq+Bggby5I
 DD76OA366X+o9p2lRb6FZO9WZZSNuPBRkc+1l02OoXPBLb2uCKUNqwEKZng==
X-Gm-Gg: AYBFou2Z8qL92d3mNf8neW0I7R0QQtbjJ4ZG5fEhx/ZzTGeMQMsKNzBhVtpGcD/yXSO
 v0WD+gzAeIxCItPMcBJobKuSE6qkGvp0PizmL1qS2MJkJKCv2jUJGiW9/DDGiarjmnw5UVZW/W6
 laCmaHmNbEUObQVrBcjTGQPTOHcIiQPu7ilCsuBQ4vqEjr2oIl9dtrzCQJkfs/T+Vo9MPtOtlpy
 VWQ2zYCV9HlwS6VOjE2BUjgRjOauf5MhR3XEGXJbTDFBCRdHxttZm6YrESB/3nK46mVDdKst9ao
 1eXveJzYbwljGWP1QprVqABiS1UcKVCTZyN/ihgk26VFDH9bTmZhXp9nuI7Aq97iLkn+O5gig/4
 o90afY2xJSVUaeFnQ+bRMUlgAOuPfHelH2w==
X-Received: by 2002:a05:620a:2b85:b0:93b:2d06:c2cb with SMTP id
 af79cd13be357-93c43cb7511mr1393504985a.37.1790520618888; 
 Sun, 27 Sep 2026 07:50:18 -0700 (PDT)
X-Received: by 2002:a05:620a:2b85:b0:93b:2d06:c2cb with SMTP id
 af79cd13be357-93c43cb7511mr1393500685a.37.1790520618347; 
 Sun, 27 Sep 2026 07:50:18 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001904513sm92820095e9.10.2026.09.27.07.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:50:17 -0700 (PDT)
Message-ID: <e6d8560e-d654-4663-bb7d-2426172fd31a@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 005/101] tcg: Annontate functions in tcg-internal.h
 with QEMU_*_NONNULL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfXzrjMmlHreSGX
 qx0JUs3vftS149TuCejWPHuzMbV/HiQCqf9AVB1jcaa/pUk9874CN8sJe9Em8x03ClkQplXKkAd
 JACg69VIE52JvrTGka6gR8T8nHqh7wKoQLU1WnXWOHe2enubOOynwJsWKT+rT5CkQJul7hGBpuj
 5jyMorFletuGmcbO6yl2SrIuMtptgAuTLCFzYr4hGrKMu0mQsyduRkz03R5Xp0RW2nSG/qd8YR/
 3Mb/wuIqDZpRCxbEbzgF+OEoWVNAK+ppAT7XybtNN0KAmJRYnFg3JY69PipepKOv22s8txUeCCM
 2dz5EKznm0Vmkp4jOJQIyfO07ejUnijVCDtWNK64YVo4IQyl+Ory9rybzPEjJ1ybgwvlX7hzVN8
 IbCaqiizjfk659wcfj1ponv69dTMdkaFyQWOvj6o54Ospv+qVVugjUxVpV+eD+xHM5tnlZZnt2C
 r0a8ukzociokhmwkmKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX1PZZ0YphPkSp
 LhIQEWNFyPSscPrhGkp4IKUF1A7qW3CsxVfF8SF702rDyvmjqmPUTwbSxfPw1hODEi2VT/+/d1G
 5e3XnATOvHUP0EnttAcgtfbgpjciqCM=
X-Proofpoint-ORIG-GUID: OWtjWlMkZL7BOWW6HiwuZ-hkRYw8a00N
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab92d2b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OWtjWlMkZL7BOWW6HiwuZ-hkRYw8a00N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h | 38 +++++++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

