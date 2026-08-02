Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9259C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWzw-0000Yl-Qu; Sun, 02 Aug 2026 10:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWzt-0000Xt-37
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:17:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqWzr-0006Jn-Eb
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:17:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6epw1506336
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KyYGuj1HVLFNFvk5JYVzKwdwwqLy9uyWGqd/1dJfyZQ=; b=oYQ1WnbMwRjWBgpK
 fqmzh0HPJdpYBpFbY32C84mr3CBXd1SDc57RGM211CzKrxmbPHNUYPHI0xvDJQyK
 284o+WFKEcLrQJHrfwMo9XRDfnFZRW7E+NdXXal2QAY5zqsp0hWAoVdzaQnG9Xhx
 MT93TuV0ERSIcBrgeq3+skfZTXB3yn0l7nSnbgB6k7+WXxSTjLOE6TPlJctWUSS3
 mWPGwFrUT4LkIRFLzczNnC9vqI4TtAxTuKh4TrKjC30/GxuASG1Nn76Ko7zxtq3/
 X+JekKmQfRuUTjCdXZJtZxbEyW7iELE6K9qqatPnB4WLirzAYZKRQxdA8KnDiN3Z
 9R4naQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8u9ay4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:16:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso27717281cf.0
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680218; x=1786285018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KyYGuj1HVLFNFvk5JYVzKwdwwqLy9uyWGqd/1dJfyZQ=;
 b=La2WZOlxeFj/LDt+eiEL9vRLI6VgyrCKZRV45JOCHmCftdflBf9dgW0atrLlv2+1d6
 NYkyJntmYxaUs1YRUBQp+YEDMsLFBcwg7CgSGsepvokygh+NQMOckfdNdD8e7iTxGZ1N
 BawM99Jb/hIFGYh66lMPU0Vaf7pa3e8gTyTpU0lMAVQ4lUTvlsGE8BVizqlo8IB+gLUw
 OGEjo24qS6+er3L5QbyWF5GYt+ue/VuAhk3iZRzxiZyYC5QSrZt0DEVu40XOGu1TCIUy
 BViiLLp046jNB92XBROw5T7NH99Kj9tlDcO4HHvX4tpFd0XTbrRTCIkb6yoWTeutGRD/
 5WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680218; x=1786285018;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KyYGuj1HVLFNFvk5JYVzKwdwwqLy9uyWGqd/1dJfyZQ=;
 b=nnANB7mQeqU40PhSUPKEzfT2lQhz7000XrRo0KqKZkjBuVhTih2dhF1o1kFbRNF+O9
 TdoAvryPF3COKApp2u4rnrER6OOYvRqe5reXk3bjWXZyq2GHbvr/tBNUrrxGBluHSOCO
 K9rVKqqVSYHtssTZT1COhlNVFqF+wFKx31stiNvo5tKDhTHaS6QURi4a39dpjhpRpcp+
 NhLUgs+ubwDXl4eotpEdl67TB4r35AZdJVikJA+iY37V/d0GHIdaLyXQ9OD3P68TzUY7
 6A5FUpqmsRvDnoCBvpkxDG6XI9RXCcyJO004Y+bx8yfWNGMI267MSgZUJD2ejf3K2LE0
 VdqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBWmMtvsdyaKT/NFoLoqcRm0Di/W353W/tyquH/R68s2GqMqu2vd9KmRm/jX2jWCVBL1Xy2Nj5sApu@nongnu.org
X-Gm-Message-State: AOJu0Yx/Uojnw0sdEwpYs3vBxV/j092gBv7RlQ8se7Y1rSTZIUkQtv/e
 Tk0c5LnVQRA52zCTbPXepgVaBu9O+m7qWBVu8I/6nbfPx4iXCNedk4VShzgee7omM2mAiloFBRV
 aPZ7VU0F5ZTZUqc7ZdIH616iStxIGEw7T09OMYty2luVfSb76p7ZTTK/oLrhiF5FzTA==
X-Gm-Gg: AR+sD13Mhw5Zpb/tP76eCREwjIhULuJTL2thrA1r80vQLCJWZDkaHm6e5sBx5o+0pKs
 hP9taV5ftlN7DIjv28hM93GEn9e/+aIRdiCvUhGKXpdHjWUYXaLs6hkuFB2kojkxvZ3EoYo6sHI
 0/wuWvug3FGHb1rI66LplnnUb/1lUR16M9y717ZLVR3kSScnIf+JR186xe54tMmMhXqvyeYukbJ
 nnEH1dktTO/rk+HlN/XiBsRfvbHFmRF2xNdNFqNH4oSBF5chUQmAaffMMpTZ4rTlxXtLVtiyGUE
 ED3xjyibo6RdPUSf+fLFkPc/L+j2geCUJ5l4Ft4ApbPa0V1L5pFHdAXHIL9OTLP25tcF52DU8Xs
 qhlhZvXawKuwcZhWyuqDe0f9Kqp60Ty3M2osnIN+tMBLa/XzODPs=
X-Received: by 2002:ac8:5d93:0:b0:528:15e:d1d4 with SMTP id
 d75a77b69052e-52b56671733mr111666761cf.4.1785680217607; 
 Sun, 02 Aug 2026 07:16:57 -0700 (PDT)
X-Received: by 2002:ac8:5d93:0:b0:528:15e:d1d4 with SMTP id
 d75a77b69052e-52b56671733mr111666141cf.4.1785680217053; 
 Sun, 02 Aug 2026 07:16:57 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808199f2csm196140325e9.5.2026.08.02.07.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:16:56 -0700 (PDT)
Message-ID: <52015a12-9bec-4f04-9b89-7ed0ad932847@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/s390x: Convert op_ld16s to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FYZvCvY0lxFYor9cw2WBYY2-7J1zaJxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX6A5jknkPVgX9
 YAxiGYA6X+pczSySzjnPJMQlexE/YnTGvBFM4ZduSji4dlIhbKPCb5c/DrNj8UeVXZQFdDVq9F4
 ZAOIjVujo6/GFr5pRlxU3KwKXbMa49x8Z6OEj5zfvQmfsNWkf1NNFL3L/WrqWbJhWwV4sgwOXdY
 mpjLve6sxBZ5uv2hPiQ7+Nbzuzit4YF73OqLdIZT6zsVlYJaxOpMhX16PeIQgUQRBZWv7F2Bfz1
 v+AO/AIqQ1ElGl5wImR1QA/zKWa6HYugDhv6Whqk+46tBGOI8EpsKuH+yMKyo1Dg4JyC7YYvGhY
 Ykw6gqsGxKTjD7TCKcXnBYMfcvb7jufdESQ+jE91QFFREc1iWhF4bl8fLHac38+RhwW+YIHJ9iB
 EByJsE37919yAgJRSQZnEPVA79x5Ay12QNjEg0NGgxaQbkO3MvIu67Q+IBwrcZy58Vc85Oxe0rc
 pNx+7JsGv/7gVj0UVew==
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a6f515a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX6qwvk/Vxv3hK
 1wvFuL8e5qYRFDGpFfoOkS8Ac+1M8NaJI3MeGYH9KDThwrS4AlViw53FaL1rX9JUFmd8S8satfG
 TgMRXbIXrUhy7Cq31+A4Og3CSAzyc8Y=
X-Proofpoint-ORIG-GUID: FYZvCvY0lxFYor9cw2WBYY2-7J1zaJxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020126
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

On 31/7/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  6 ------
>   target/s390x/tcg/insn-data.h.inc | 12 ++++++------
>   2 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

