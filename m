Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A2CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMtY-00016k-Qz; Wed, 07 Oct 2026 04:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEHRa-00045k-As
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:32:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEHRL-0001MA-48
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:31:38 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eBmx1083549
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 09:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjsmGI3+0Kj3QJlqF5qadkvKS9KzSzr08O8yYgXEgN8=; b=MNN0NanlHRusbN88
 z1x496f0bpreQjvwsqth9jjKMWPfxFDkmxlbZzcBSgSkJtxkPfpCvWgoADYGUbWJ
 lxZ9GuP8mtePiZYJu1YhLRH6qA0QjvdS7L2ykPzS1BKlCxOzlfyovvQszmbOKq3G
 BwvOsry7MAeleSU6e+tQLrm7YLsvixmjfMLdCFzOkVIIzbR70LWp/9JDFp79FWmO
 SK9K8i+qlmleMWmHy61mUPhOah/6cnlPQSrn2L2YfbUwf8Ofrqa0SK9IWVJxju7f
 xL7PyT+4ggnWD4ZKm/QO9z8QafDAiOWTPgLXaxv8ZhHOIH2Y+Cpuy3LDFnxYke1I
 VcDyhw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu40qx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 09:25:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a2035a4so15152546d6.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791278706; x=1791883506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjsmGI3+0Kj3QJlqF5qadkvKS9KzSzr08O8yYgXEgN8=;
 b=LH2CyOjuX9+MNKhDxsUKixN0Ebm8JziV5vbzvtemu6hCKOYo5VUC4J3yD/+WmfiCWU
 US94PZ4xSfBE7PQpcDhDtnJBQsGCcIQ0FDTJiN+c8sLUmRflLRaqht+VQHRGF8k2aPzy
 bSFy0cJ8/biSPPr1auRvybRw9NH9iQAD7huzFc9pWwl3qeaQQKTfwohXeTP3quW98Tje
 QbzTgXvgT5CuTMdRFYOi+gCgsnVUx9vGxbumwCyqJl+k1Ddj/M1X5Esqt1AtHBYs/d+Q
 1ridCNy7irFh69lYLLAcgpJOfXS0VTXWtVM89mmx9KIvVpgVa7UJraNLuwZ6g3UGyEa8
 PpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791278706; x=1791883506;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjsmGI3+0Kj3QJlqF5qadkvKS9KzSzr08O8yYgXEgN8=;
 b=B2fQ6exqG5TJ9lHOapCQwwXglRUPmPMsa4xXXybaB4YbHiN6sEk0B6zOVJa5gA4yQx
 egVNC50azoc6wemKuQuxEU0G9Z9m7QpKnwF0zuXAVgsG7q3Jt6MbYsQTXmAEYpxqJkYU
 BxxCnFvKt+6TBw2XZ9tK/n9k/+mj6sWWLoG0nT6s8mTVa/W5/wJzM6ec9V8nQvPPqOWn
 eyzlawNjjJOfHF9l+LyXnRsMBTq8XOSy1+/wuQGYscZyrvzygVjVVp+J9hTUQdTqLMMc
 msqonNfdXQRvSE3nItSwkvLlQaqu8tK7AJH7CEUpQQnyV14yTLR8HhpcRwRW3MivahcP
 2HbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6YArz0nm7oiuAKhiYDw3XdelmOayFBWP1gCwbSTL+mZ0+aOCBN5ofuUX9rVGOWsLenwaL2Js0c6E6@nongnu.org
X-Gm-Message-State: AFuF++mjAawHq1gt0GcJePQRb0qAkoX0Bvgq+dEGg9zrrph6ABlwaEyY
 yUwo7vMrIhXJySSrtAJTcn9dwYL9Q/lPTb+Bh8866wJVp2y9Ag/iocs4ocu69t9pIdaAFHa3lB8
 /k53uXea8drcUEJqb5OThonYZaHprWOnaiRwu72K1AhdKYs+SySGcPQn56w==
X-Gm-Gg: AYBFou03XUHB2zj++O6Jm5t8IJMXjGIbzwRXV0/q0WBplB+4USU0w4Q46WAclgWdo3X
 pemJwSVYEWH24R8sh/XUhbynUYbxuFp8pWx5aQmmmIRky7okC64spu5tWVBCnMDNEJpWkUf7PdW
 9/UZARTHGa9yrtFxE9K1APgULkW9soH5pIgxVaJ6VEEiME99FmTZ1Q3dGkLIdBiSo3PG9QPts48
 rO0NPOldv4nrEWRkgTa5XgG8oZq0ruHkw+atFRuJNWlypbpIXbo+ku27RsYWdYYyjnqKPYKlexI
 jm2alo/Jf1zmzVQ8fI3ChsAjs/JoKS7pzRRlcYaeL7HXzLypMZC73py78K1ZYY5xHb1zWndmA8D
 FZTErA/ao+2XkCJ3azqleoPuykd3ZRFNGMg==
X-Received: by 2002:a05:620a:6287:b0:93c:7861:675 with SMTP id
 af79cd13be357-93e85ea76ccmr398861985a.1.1791278705812; 
 Tue, 06 Oct 2026 02:25:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6287:b0:93c:7861:675 with SMTP id
 af79cd13be357-93e85ea76ccmr398859385a.1.1791278705341; 
 Tue, 06 Oct 2026 02:25:05 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62100facsm9680689f8f.0.2026.10.06.02.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:25:04 -0700 (PDT)
Message-ID: <e539b209-29db-494d-aaa2-a04e0af06e5c@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/31] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by
 default
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20261006083445.30362-1-shentey@gmail.com>
 <20261006083445.30362-10-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261006083445.30362-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfXxzeuPuekcxZC
 erUBVm521KxNrhUKf3nxGr9sBUCCqX76AtRrDKZOL68ImKSLlzscoXWcSVo1ipR6rBRDxNOWso2
 1ZO2rn8iH1ZwBA+5ksiU7jXQ04p3jpw=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac4be72 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FRSEYCzRAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: W6FWMbFIO6SAPcyODncJTSE0Y_NPw7ZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNyBTYWx0ZWRfX6m/3GZPzKDbu
 wzMqMFFiue6aCUuYcZKTbdgt0Qm8VLFLI8tQPxJHT9mfh56Xzyow0nfZzzCK9LIokor7sSoj97d
 pjpAbqGOoDSB+rGdVso6wfGxmUVIBPgy0K75BrA1MAT+hjGkv0rNjEYEOqoMrxeJfdyDiX81BCp
 35IKq9rXKw8Uq7NbKQOTl6W2uddsd729uTLjINBowh0uGdSH/iqawiEOwRLPAgzxIwHUWEV0DhG
 QxG+eVXaGox/ZcBTb7SA5qI3V/fs0nD3sLKmASHiOf8BLhPHSXxkxx4nVk80Eg/OJlx0VNZ1V4V
 R4OnvtSet8XUFspqMliyp5KptSvBwnH0x0d8MfwG3K+HUehndU/JcpoHCK9yFJhGD39VKsZLlYl
 bIG1GQ8ccLb4C8GIFlKG5swTcCGwHVCF2o+ZeuwFbb4cCIY9e88gDwkvHN6C2EVKADaQyh7iHlo
 P8dLWJHmLGf1BUu6OVA==
X-Proofpoint-GUID: W6FWMbFIO6SAPcyODncJTSE0Y_NPw7ZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/26 10:34, Bernhard Beschow wrote:
> Having 512 MiB of RAM matches real hardware. Fix the machine
> default to make its use more ergonomic and less error-prone.
> 
> To reproduce the old default behavior for e.g. migration purposes,
> `-m 128M` needs to be added to the command line.
> 
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/mcimx6ul-evk.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

