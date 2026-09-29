Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B7CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXLx-00080w-Lp; Tue, 29 Sep 2026 08:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXLc-0007tI-Nj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:54:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBXLb-00085Y-0c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:54:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqfkC1016902
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FWbDefYk51Ux7scZf6SsOixr2tVMvSroXY8psEagN0=; b=KjVfUlXbTLI3JuUZ
 tJCSj7ciLutSn73uj7/yD4Xk+DJeB1hbAkvjomWllp9yZz8wSgScWR5j9d+ab7jH
 MX9oSzEJkYktU86z3LP0WAHGRfaZFHu71TQZQMd6q4d1BitruJBuLfFlEA74mAil
 IgJ7gkwqvKns0S+Pdwj+lxKyaCxoX7hqSjeZB1JV0iURNB8UIqV2AaTaOP8c3xHB
 zFn/7jToT/hZ3w84K0V6s+g8KUnzdWwLi+OIINjfmcWBmjnpDbqFvTdTjcVl4Ku1
 2TLk7cT/oK89jvX+0xcTwQp5g+o0hMnNwGOo79GYsdlAfQ1oV+2WGSoKNblj+p2c
 JZG2dw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxj1ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:54:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c820cf67dso431341185a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790686453; x=1791291253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3FWbDefYk51Ux7scZf6SsOixr2tVMvSroXY8psEagN0=;
 b=R0LYyWNYNNQAKv7NSXKx5sC4C21PuyOJzsS3x3tHUwyHi6O2+ErOzE69HmUeZwAJSz
 4cwVklOAjYLhTI2JGXnjApDveZfK73AVs6NPeM9nS2ltvAnI14XQct5WAP/qR0W/8r2Y
 IGAeVVQAdaiIjgybzQxB0wg+Rcie1+AFSdaX8h5XKDGRjJKnBYXIGskOQywOLLxBNZxH
 wFyhbygbAUfHm6HDevWAeG5oJUxvRPwk4C/V82us9m9FJBDaCAT0+eAOJqPK3UHNFj2x
 MFDX3npyMInGIQ5lG85NfiRkwcx/FHOvp1K6ZrjUivDLHb3CXZMEW6SUoYsfP0xZlfLy
 ZevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790686453; x=1791291253;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FWbDefYk51Ux7scZf6SsOixr2tVMvSroXY8psEagN0=;
 b=HZUs2tOuQkXqjDtGIDE+Z1o8F0I17WmTfOeAOVzrX7pb8wJUYnGknMn/obUc7eZysl
 FK1kVFzn9P3+9h7HyN1tpw8y5EyWy0KoliljibFXDlSr7dcL4qZN3UDXlF3OjRpNSKnp
 QGgFcV5SLu2BpVrC9fxETrULtVlx1HSBNfbGNC/dcmiRPNk+ByVQN9AnHpQpJk7fkIJI
 DzR25urmKGixpqv9BDCMszxAH/X0wzWKpCLvsz2y9dSPmBZyxZ9FX/DNefOF73BuRadb
 aWkr+0LARbWUeerkWVlkyXvOdEslVCezQY+J+N0ohuDF5T2GVLJHQX6lmdbePQLFPVRh
 F6Pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzStMF53m9vX3eeAnQnFFt/6Dnj1C5QHazBRaJllrhhLPqOi1Zh04Nzq3Aft931vSDihcAdG8on3GNJ@nongnu.org
X-Gm-Message-State: AFuF++miZKbONNqUD/y0PfJM/+tV1UJ3cl2VYn1d77af7KVPU7RkLLM5
 EmSllR2p3PnaXaN26i0xjHhUtYoEJzx6BzjQmPbt+j+uF/VYnR1XGlf3PbFsF014kq8r0ci2V8X
 tY0aFRbmNC+09nEWb96tqXFoUwFQg3Lml0svJeLnJY2vURCC2QSfuyzqeTBRIgj06Xw==
X-Gm-Gg: AYBFou1OgxQWnqyL6JhDG72O7fj8bB74QlFIyYJSD6U2/HYkUoKQ0CQ0OlLIAS2lsZC
 MhUoU5onK9xHtm1yNo196X8pixZlHlwTGtVc94ID8njfrg06XtvirhDmgldRLi8AgTaRTLvWfxs
 KqNkYZeRipoxdK057gxyyHghRx6Sp6Bx9GzfoDJQOp4lKtU9zMILba9XMbVTrJ5peEpLfO9mLVM
 jLJebJ28ziUDFu5npcRnX59HvUx9A4Ru8tUzS6kpAgFkffCI4WUMhix5PxX76LXctukZYXMnpwC
 nc4rkc7jLo0OlVsXqUCT3Uy0+d5UNiaVqZD0RFITbRHyP7qO64bjrHa44ts9n2ta+A3J15fE4Ix
 CcMctKZ7ukV85yz4xGmG1rHWbKNoSVu04Wg==
X-Received: by 2002:a05:620a:a182:20b0:93c:5ada:1cc5 with SMTP id
 af79cd13be357-93c5ada1d2fmr1392787785a.22.1790686453248; 
 Tue, 29 Sep 2026 05:54:13 -0700 (PDT)
X-Received: by 2002:a05:620a:a182:20b0:93c:5ada:1cc5 with SMTP id
 af79cd13be357-93c5ada1d2fmr1392784285a.22.1790686452654; 
 Tue, 29 Sep 2026 05:54:12 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf868b5sm109637585e9.1.2026.09.29.05.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:54:11 -0700 (PDT)
Message-ID: <ecf3dea5-6f37-4746-a0d6-45db494c69b7@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 059/101] tcg: Generic expansion of tcg_gen_rotr_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-60-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-60-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX2AM1n0uEx4eE
 ZHhYFN+w5o40S8iF8F5CmOgY7ACrrn7rKCqaZjakrHBDXxM+ZylS0n01HT9QxdILVs3uWudSCeE
 eQrA+vNOx24ZSvfPFUqRZP2vrEE8pN0=
X-Proofpoint-GUID: R1pj7lcIEnp-fx8OQRLBx0ZZ3eVv5Mvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MSBTYWx0ZWRfX+PyDi4S577uT
 zO1lagM7WhQ1iV7+ztG8Iy0jyvXhIpaTEXEljMREa1r7sWzZxEZ0sI1xBvua1wvTsgQy/eODqSu
 f7cWRZvMmLvxi6Oz9cAsmIVo2zFs2HUic2qD1wX/288h74j8at48M6caSVohCxC/jvLTF/ptamQ
 2D9Aw85xroadfKpAYQSsMbzUSKBWs0MvjWnPWmOFvBbsEcIUwL9zqbZYcMmownoxptD6dQ2Eo5x
 W69w6Oi4WACo9/hPhtGUtjof0Y2riXLUEE7DyjwZCJOqaNFn28qBveN9iK+PhHpKDaxtWeqKdwa
 VRQ1azcpLyGOFhnYq8bBQlCswA6kKSC7OIs8XS8ajutabPLsp2jYlN8ZBqDpGbluhrzHzF53GZ4
 wBn69HrSh7jfuI5OypG0QJrcpdf8VbARmTTEny6ESxFpE8O/gokixHneWH9kgCv3QXFdDYPELZr
 rmrzgSvtk9xyv/Ielug==
X-Proofpoint-ORIG-GUID: R1pj7lcIEnp-fx8OQRLBx0ZZ3eVv5Mvw
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbb4f6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290051
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 62 ++++++++++++------------------------
>   3 files changed, 21 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

