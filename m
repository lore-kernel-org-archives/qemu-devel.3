Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kIDCT8JX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AQlBA7Sf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXng-0003Bu-Dj; Mon, 09 Nov 2026 17:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXnf-0003Bh-Mx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:25:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXne-0002tC-5t
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:25:15 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LDu5t315966
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XmbJ/UVZX/+4r+VFsVEWf5ohyWqmrTEa+jJp4UutqBs=; b=kIDCT8JX88CEzuoX
 ooUcBbNHn19ZP9TE8oKIIeyY3DN3DOFQAUXt6xg54giwhHMab41gdhfYFwva0MTX
 tvnulCAxT8uJcExpKXrolrmdttaZOnq/0tTv9ZcBZV2u1iwJQ0xoAY32nAbPp7F3
 SFlpXXV3koylBQG1Lvgj/JLniIaFIsGn9i/5VdjiXvJ6GvvHDIUpwlxz5GM2zDDo
 cYnVXf/+r705+cZ5uVMqNyqSVYSpTR9E8pn8OWg7KqVWUlbKcxUPb8pC/Kdn1siG
 a6mhJEfSGhFxg8+FNkM2dJBUx+d0GWTVTeG1wJzy6x+jhcTuOSsc2NDqmxDlyOh/
 WpCV+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkg7yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:25:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so274439485a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794263108; x=1794867908; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XmbJ/UVZX/+4r+VFsVEWf5ohyWqmrTEa+jJp4UutqBs=;
 b=AQlBA7SfPnxJNzIq6BF+43+jvjcSweBeCndFQTihM76f6lN1OHua1E9qVFWjXbXcT1
 mPYiyGz1DyG+30DqU8Vmlfl0g8sHcHQ+aLqcPyUE15blDjnqKIfHAKjPP8tBHPjd6YOh
 JR+WQN1QywYHlHetDlwpW2RcUeI9e4tuG9bsmnO1Cx3vXs4sdQmaZ9HcwY7EIk0WoRfA
 ZNeWjUFVc/uuUKzd4DhgUsxPL7FntXZWWoQqV1Zc+oteec8bJV461gc39FrpFi6CeV1v
 yn1Zx8v1X8nVCRI3uJ8Rhpo4LBsAXg/QVXcnFGtxof9rX0gcRbUB384mLBPiYkQE6ZwM
 Hvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263108; x=1794867908;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XmbJ/UVZX/+4r+VFsVEWf5ohyWqmrTEa+jJp4UutqBs=;
 b=NfN5icti1GHG3lHsXREm98yDIV6EpMNIQFg5i3MWp4NRrl0jYJT/9TEmOYUfvoLRAn
 Z+OS/uPNSkAR4okD1yg1FkFPd1ttY0b63BsVAcr46KxMY2Cy7HfaTHs7nHYjfTNGYbJo
 JklfLtanlgCjWY1+d/zxm7EoJtA8GAWPpv4fY3zbNhQpZZVbPjNZD4XN1S7rRbMiwn7L
 JqOFh3qroZcAiyYtZQiObeskDXrOCN76yKN1jEu2MszDt7FPohP7ilxgczIuks6QE4wg
 z8RQGANo13LuxfLg4befk+ow9PDXqkjGJkWvG1+9f8w23WYPD5IaSuGrgFEXZu/c3Zzt
 RQjg==
X-Forwarded-Encrypted: i=1;
 AL+hErEzNhK+VCtiYvo+EdWF8Ck9SFqyxZJyNh5EAEJpxls5/mXjTQ/XvpUpC7HKndwfbiRrEFUSx7qCBUtN@nongnu.org
X-Gm-Message-State: APuU4Z99hRawONbPTKK8IBOzID6OhuWFrGOJsZXR3gTTqAn+nUj7XzXt
 ykkUN3ScqWj4CBuWcKhzEhvwN9fZw5ylxfZdCAt436gbNG6+TR0BW1pQ6PDG11zTkjbuCqkVQ7+
 lJk4N/RWqbwkSZ0NF/qVo682hPvy/z4dIXYs7E/+SQIARrp8RHZC5eIhtsg==
X-Gm-Gg: AYBFou2wyzMA9+p0XLTRbYY1uFNTSRJmvTvzcQWjrlPrVZcDn3Zef1O/ecscCbht8C1
 ZmMbUPO8Y6q2ZKVYKdqkvk83gWys5i/8WK6GicV91x8zDH85ombOYaliMvP48WgBbalo12gfSum
 Qt/8qokb+52YMN00Hh5epywilQzvXN1qTbqkQL4dGLw7kKtVVPR7nlIBM/FPh1UpdwKYvpS8uSS
 aU5dUvGkz1K8ct6LDi43nt1HRacYtRw2DCVe1i+ZJ/zO/38ZX6fgFUROtYRYSVQJUPMdsCV/5QV
 lak5FQ5FYNXeiwhpj1Lfy/5rUt/bDAeW1nJg0vaZpc7Qr/f3j+u03vLkQ2ivNbgq0MZehZDsiDg
 CxOtICG3IP5D31y8k/zIyBjg+b3tiEBI2tNQXGxCOUQSDs1fSxpoMJSLHcgQwZknVAJIhAcqV32
 Wts9k7CQ==
X-Received: by 2002:a05:620a:2614:b0:93e:c12d:4ec7 with SMTP id
 af79cd13be357-9479f27043cmr133313285a.39.1794263107694; 
 Mon, 09 Nov 2026 14:25:07 -0800 (PST)
X-Received: by 2002:a05:620a:2614:b0:93e:c12d:4ec7 with SMTP id
 af79cd13be357-9479f27043cmr133308685a.39.1794263107038; 
 Mon, 09 Nov 2026 14:25:07 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0203a763sm18339525e9.4.2026.11.09.14.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:25:06 -0800 (PST)
Message-ID: <32e1df71-f099-4385-a48a-f49ca8b1e54e@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:25:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/26] target/mips: pass env to compute_pagemask
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20261029204609.38989-1-kirill@korins.ky>
 <20261029204609.38989-7-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261029204609.38989-7-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GWy7w8rQKS-E7pZAhCogox0mRWt4Ugf9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4OSBTYWx0ZWRfX8dQyxzi5q794
 /tgIUL5nV/mDf63UPzvRxg2l957NJC6rLvB9i9Ne8bFEpfuczQYKGkQr2QCfs5A65TzidWLmRCY
 HeFsPI0g/RnaU5wGOyyAy0Bf79alUr0=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af24846 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=HjIKASV80REEQwcnHtUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: GWy7w8rQKS-E7pZAhCogox0mRWt4Ugf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4OSBTYWx0ZWRfX01RYRzGZW5hf
 8re0poYRDq3GYfe67+W/dpoD3BtpJdk9Ajhl0a07NnFjRwxGN5kFKr7EyXydEDbM5PkpOvtRDgh
 lQ1zC1U7ml7fKqgYy9DkPuD+7WuIj3e4Xm0liZdq/GxC16Jpag+n91UjdO6tdC2gkrIBmCakPdv
 hfUOrm5E2CHH+jMQVcs5yGscDjiTpiKtqUEJAiDgKbXA8bb5bBlh01XZy9bZTEl/3FmX+g1+0N3
 88JUcpXXzGC5sWiApa3FIOYOFMEA92ecKQQtcbg23H92/+WSBSoMraTxUfla2mH3UoanfcWSuzz
 GYbaApT4fPYzVC9pDZtuJ8c9maRqwB/EdDNdrL/IjxfM5Hszd6D3Xng4gVfybhKp48Dr3s/z7VS
 RQTMXEOTggzDH4wnI0q97PUijZJ0KHgDwU4PFbvn4t8+rBHhjD5T/BdAjLOxrKFp4x9maKyTNpt
 dQkVhi6RwrHOYau21Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090089
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

On 29/10/26 21:43, Kirill A. Korinsky wrote:
> Pass the CPU state to compute_pagemask() and update both callers.
> This prepares for CPU specific PageMask validation without changing
> behavior.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/system/cp0_helper.c | 4 ++--
>   target/mips/tcg/system/tlb_helper.c | 2 +-
>   target/mips/tcg/tcg-internal.h      | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
> index 33fb7365d7..3fc55314a8 100644
> --- a/target/mips/tcg/system/cp0_helper.c
> +++ b/target/mips/tcg/system/cp0_helper.c
> @@ -882,7 +882,7 @@ void HELPER(mtc0_memorymapid)(CPUMIPSState *env, target_ulong arg1)
>       }
>   }
>   
> -uint32_t compute_pagemask(uint32_t val)
> +uint32_t compute_pagemask(CPUMIPSState *env, uint32_t val)

'const CPUMIPSState *env', otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


