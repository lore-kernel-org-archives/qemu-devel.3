Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4846DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ2w-00021C-MQ; Fri, 10 Jul 2026 17:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ2v-0001uV-LB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:46:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ2t-00044J-6o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:46:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3SkV1713369
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LU4qIQo/+FzXiuZJATdP9f/stxNyxbOIRRZc/MFDJZI=; b=okcKR4ceyee41Zg0
 RYWbvHawjrSo14+MWBXtAfYCLX2O/vW16w6nwzeXVBPpkKH1Bv8M82bCbuTZ3B6r
 5imomVDhIIcPtvWSe2s7FumjrOt6SRjLRsEoe2dA/yd34TGaRGgnJmNT+E4COcSL
 PCC0Rz5Nz8eIy4rtwK+DfOPKznS8i19w1G2Ojh3bK14zyihmbNAIuUlU7l8ZRY+J
 drIRoSa9H7LCZHmpnHxWkKfRZ2bTGfKCTcWEgoez99WwWWqB2sHKi+Nj65AIG2Mf
 +jR99L41zwJb1BDc7DxZkWRs4gVrqJ7Ttd00f9VmbXPID6ueuGWwbfqL6rlnlJ4W
 gEQVCQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339s9ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:46:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90410c668adso1903456d6.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719964; x=1784324764; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LU4qIQo/+FzXiuZJATdP9f/stxNyxbOIRRZc/MFDJZI=;
 b=injb/+ZDwTyu+qGp4YaqnnPMMTea2A+g/Wsw3LDqc+he+l082pb5mgLooqvzYP0JT1
 zboaydHN15GzoZezSmA/9UjmHgaI4GSX6YMXhnCpMcW2gedb2K3Slf8I4fpfiV4moTQT
 u5K/AyN3XAlVJ4YNq9KKVOHxMBE85Awe5MR/0SDYL9mSHwcP0hjlkqgJy8ZdMXiu9z7i
 Isu1fmy4wrT3P0eEsiAA5/YOhvL8hsaxNFT1dGzDyiVYRqZ9v6QNjD61IZHHomgoVSRN
 7SThL7ycIZ7ibgHyoxu4poL/UfwRDPcZD27EGav1WN9e1eBT4CNxjBh1e6DGsfM56qZE
 oS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719964; x=1784324764;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LU4qIQo/+FzXiuZJATdP9f/stxNyxbOIRRZc/MFDJZI=;
 b=a5ndoKLdBHbC/wP53hfj5/PLWfFQ/nIjE5Z5V+jynqeZ0rTN3fvV1bJxv73anGXSXe
 IUBqqOVTKc8Wpr3fqlYcOlaXfmUO7dMrZnLr2UXZWbdZIJqOt0q0dPTR44PVWCBQDfEN
 6omniJ5XDO/gXD7a3vk/hFN78ZXBk5VYtoQdKyHKb5xSrpCWlNdOCKDUjMlUDoeu05r0
 lF7DaWMhAoxgbzyIdCiGuPzOGJPa15SArUIElRM+daQGfMc5xJKGuAMzRQSe6nHMDGfe
 fowy4MrzMspQUgDCicUDGnk0ssWev59HOij7KFQSN15Tig7eQJCTDj3RYJ2dSRoRiL5p
 0j2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7jqohWFJ+iwVp6bEdvg4AaOh9ipT19wSL84oCHZS3WxcqAGUrk/JEFjGoEj0i5OlQOpZZ3+x3L61M@nongnu.org
X-Gm-Message-State: AOJu0YxqRFfubfNSgOUQpGhka8PwOlo3dABmy0p5u+Te/aJotbdZnt11
 s6A/bIBPQbqHCKIn1yPiO3H6ulpgZ2q/Dxjd1ZAh0Om/x+H5+gpAM1kbZdsxNnH/bugz7mWFexd
 KXYtE9gyj2Strg27BJVJkS5WmUz4XDcl49C/BpxqAH4qfdv/sKuLexOpO8g==
X-Gm-Gg: AfdE7cltlnkzW9IUaQTfc/uIvDooLoD6hp4uMapNMWNIYmstMvqoBlmZf/qGjqDgZWs
 jkR2dgS+pr0Wj/y63kKOacjQ2lhJhZ/YtrOQRMZH7rdX4jqHnXMBydE6yY8APOMdoVZ6ryTTTQD
 DK38TvglmeIruJ8gzSrjZ+WlpgLk2ghPB2TZJsK0sQmXZVWUyEeyTAbUTOQdDtbNlFL1Xkq+MZQ
 YFIMyWOdUmRdfVgLjwsPXu6unNkjqNzIQc+4nadjYijbSX2yVmzn4gcKmqjVRn3s+joFiryoAm7
 Ah613js/clfiYNPcsON8+3aD42VuThxF5MfyApzryKbOirEFqOt3OWasMEWG6T6UeTZ90DqGt2r
 HFA1941X+DnBu4or333cOsdM/GRr/niA=
X-Received: by 2002:a05:622a:1f19:b0:517:71d2:37d2 with SMTP id
 d75a77b69052e-51cbed6d58bmr8436871cf.0.1783719964455; 
 Fri, 10 Jul 2026 14:46:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1f19:b0:517:71d2:37d2 with SMTP id
 d75a77b69052e-51cbed6d58bmr8436601cf.0.1783719963955; 
 Fri, 10 Jul 2026 14:46:03 -0700 (PDT)
Received: from [192.168.69.219] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccdbbsm172404615e9.3.2026.07.10.14.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:46:03 -0700 (PDT)
Message-ID: <111e1ab9-dd7b-459e-836a-ecefc7ff0b74@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/51] qemu/typedefs: Declare CPUBreakpoint and
 CPUWatchpoint globally
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXwpMptpDa92Pr
 dEtqa36kcoi4nUGqQAznELpkfo3eTelNQrpllUjMEY+aOjztMVzaqKeWJZVT0yon+u74X8KxT56
 j3oPmR8FBKKT+oL7SqiBH0HaROa1JmE=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a51681d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PbhqQL-C78nWseOilJq--i9v10ahLFA2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0q5N5e4ivOYT
 x6aaIu4wtMZPqGurCYFLb8PFuFljG6uw9vnr6JNOxQROKdEnDQtZke8NWSQ62TE1jHZJXDv0mjh
 nfKcXKa0T3HXwTPx+vOXQ9CtmsQEyC6I5lem9LP0g8dMWICc9LroDqQPAyhDsWB4FQG6o9vDMEE
 FRjpLQRkoFXOUHBnAeVZ6DFxb9PxHXNqaOk2M40nBjvXDG7qye4jNIc2E0ifhH9bP5+OBoplZVs
 4YT4KaXn8CYt9qhJenwc/M1UwYm4Wmum7R6n3GFo5yomVyZqwlGIdKd75CBjjsfabLYLETrFBFa
 IseJqW4GKaNkxbLgRZ4lTBdSPXk2AZQ2fydXT60u3nsw36XXQz1+8GQpPF+ZqofhnTcIgVT0o8c
 oeKke3s2Lzr0l66QH4MipiQ8aOnqUekYLEqVMpQQAdzDP5L8ZM+djd4us2JeqBjkmL/GyTs3uBm
 FJiAkmfspucbu0HinKw==
X-Proofpoint-GUID: PbhqQL-C78nWseOilJq--i9v10ahLFA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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

On 10/7/26 22:53, Richard Henderson wrote:
> Adjust all uses of 'struct' in the uses of this type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/breakpoint.h | 8 ++++----
>   include/hw/core/cpu.h     | 2 --
>   include/qemu/typedefs.h   | 2 ++
>   target/arm/cpu.h          | 4 ++--
>   target/i386/cpu.h         | 4 ++--
>   target/ppc/cpu.h          | 4 ++--
>   target/riscv/cpu.h        | 4 ++--
>   target/xtensa/cpu.h       | 4 ++--
>   target/riscv/debug.c      | 4 ++--
>   9 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

