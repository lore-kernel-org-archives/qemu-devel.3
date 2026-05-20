Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4077ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPiVi-0001qh-Q5; Wed, 20 May 2026 11:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPiVg-0001qN-AR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:07:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPiVe-0004BN-Lo
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:06:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuWo53680335
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 15:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LESylkFT5bTaOJEDczF3xX+dRP3/CS8Sr/5y9eF1vgA=; b=JIXtfx/o+tyHi9SQ
 ev70bvwCoJ6K7ODHe6BQ/2C0jRL4tP2SwaTMq6TCFFEYtsJK6IMu8B9XgyDwJcea
 iFbg3IOwThcQjcNF8cT6IdOsx2ZDsjegSnVFKshZ+aKSONGhh5qlVfum68aijcFq
 hDTEAxa36J2By6X+Aj6J5ahSeQ0qbK91a6HRSyh/Pc/V0+JxFtevHYENTBYQWeJK
 285HSwzvjVFn/76f/HW+rFUsNIhpZPadpq6l/+aX6IDTGqrsMLE8/MqgKIDCGJG7
 5PzK7WBNyWaOqJgW7W5LcS+FDO64m9I1r1t0fL+FQ7aUMEJzVzIxcyfKyF8jlui5
 x2w2aA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j0ace-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 15:06:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2eebb099efbso20335619eec.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779289616; x=1779894416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LESylkFT5bTaOJEDczF3xX+dRP3/CS8Sr/5y9eF1vgA=;
 b=kJByTV9ka2OuAgk8+TKYjdteP3LKxc2tuz8rvzNLi5PLwytBTBu+0FBu5wJlY6fcoH
 X5NiyfjdJoTyaM7oo14IoXLgltsBaD0oYxCBcGFo3ovgVVgOxMHrY6aq22k12s+XNvND
 KKt350CG2F0PFnG7OBdHHv6ioOd0hg1ttR7rqu/fXvs25yvYT44WkjXwqypjxsI73j8t
 mDtO+zRGfJpO0I2LvZM4Wy6ShjXXLiv4AaGnfqmDoYxEp7omDzBVacH6rb7s39Vng2r2
 CPtTvphpDWQu9x80iTjVnivq8qmZrMYTK90MXJLKSEElBSfYr2XGDZ32MaXs3zNkxQed
 mN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289616; x=1779894416;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LESylkFT5bTaOJEDczF3xX+dRP3/CS8Sr/5y9eF1vgA=;
 b=CTPaOUD1ne6vB0cI6nuv2hMq4NV4HqaXGKUS4UuOum3DI3UFX6/M/a6IMH7mbhlEaU
 wze+rgXfZ+r/uThbPe7YjN8eBOqLKRIjniO0W3PsNltV+XiVuedjkuJ3cpKyg5QKF5ap
 mtkoK8moutaUB2jI7O+LfLomq7XRQgx9Xp96RM3jWctjNdinfPCQ8b1EqpllMxUROiBd
 7hDKxTnxjmapacEN6a0IrPD9ThQAtZ06XvikYF16u3yYScnMJzhPkZy4PAhzDWzkEHiN
 MN7sSFG47kDfRMK/l2AIsP4k38wqg5OQiZ9g4bJGh1mNr/3oxNrAickoWv58VLH5Vk74
 s+wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xfYmHP77vifRSwNcO88fjkYpPoaVHO/JExoc4jlBLtFOnh/OZViPpOV/54zMSaRAknTbuZIvgV/Ow@nongnu.org
X-Gm-Message-State: AOJu0YzhCEcx3xEBGTYKqAN2pW1virubeu10GK/R8R4HmehisPEJ0YPN
 bzY/UpWlAcG3G98FGrqbjZPMtp/Y56hJsvPpaJ8MXjbltZE/oMJkq7EGZWCTVbcJpsjBcoWEw4O
 PSyvWtL23ZdOkQKaQ4Q81X3c4OQ+51z/8hG0EaJGmPrW6b+SXj7SIsE2GeA==
X-Gm-Gg: Acq92OGCkJgBfxGlCYd7I2AiCuZY84FOb6EvvIRKONzj0hc+vL10QTMlKXyh/sN8xoC
 zk9vN2yl3x13dr8kuMJ9LJVuvaurinNi2gcxhtq7HZParFtM9/QUOoXOPlIPJldmjlFZVvAXc6/
 7pA7z9h21triQ2AtG34V6NrmGhlWWMDYUEDmbCo1MI8s+G11TKVQFwseMDHsxLWC2JEAfzc8HEN
 dFrvJiyf9ZVtLPSc4jX+Oh5DdGzRA3Y0Zkv8yfY18Bbi8mM+2jJM5b33JYkJD4EYJebrfm1i2M6
 JfHlpL63Mc28766oW3KuiRQuYAiDg9I0Y5MMs8rSS//b9YIZDyYnFMZb0L6Xm5wBgZUFvi7iR+F
 gu0T/wcQa6g/MLJB/xq9Ccy9zccqXgeHAL+T2TIITgPwUh1pmgYAd+NM=
X-Received: by 2002:a05:7300:dc97:b0:2dd:6937:79bc with SMTP id
 5a478bee46e88-3039818a666mr12586980eec.6.1779289615909; 
 Wed, 20 May 2026 08:06:55 -0700 (PDT)
X-Received: by 2002:a05:7300:dc97:b0:2dd:6937:79bc with SMTP id
 5a478bee46e88-3039818a666mr12586950eec.6.1779289615286; 
 Wed, 20 May 2026 08:06:55 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm22585744eec.5.2026.05.20.08.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 08:06:54 -0700 (PDT)
Message-ID: <4d7eaafd-2fb9-458d-bc0e-722366d2b647@oss.qualcomm.com>
Date: Wed, 20 May 2026 10:06:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] target/riscv: Move target_long.h inclusion away
 from cpu.h
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-12-d1123ea63d9c@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-12-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dce10 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CcO5rwmO6UB7ypnS3g0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Yr-Ajcn8nKO2dd1oWkLzWbvNU8Dm2rvC
X-Proofpoint-ORIG-GUID: Yr-Ajcn8nKO2dd1oWkLzWbvNU8Dm2rvC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfX2iCOZyHzoeyl
 FfHxdlKNXLRMDBUtISx4m++T6qCgdm7EgmOGzli37oTNSxGO/BRIGhMnvg8iDzP521KyaCa2Tit
 HkV9oo9E6pis4V4FQpkWhR+6F/XBX6veNTmMMo/BTSXQI4phjcneQGuZaKS308AJdxGx/toG7Q0
 OT599J8hADdRNd5yt1iKwjwkATbM70p8mt6wvD746c6i/qG3QhECAvVTWmu9rWzTEbKQYGeLqMc
 X/GHYI8dl9iba+6tyl0E2nNilMQn0rXaKeB8UEKn1D+KnlAqo+fvvuGO8GVwqcLSBr6BHLMmjFo
 vIREc/bC/9boLKzNr5EskZqL/0rxi9C1Y5bUdCagOQUFzJq2zLfyas4KNEP1geNCkNwRLAkzbl6
 hENA/PxHtb6Y/mE6cNr7pB8940yTM4VLjf+jMQ+RG+YpODysa6oRtFMNGoLHUUUwYOPM1WKLK0b
 iqVd6Bh+mD8uN08lOiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200147
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/20/2026 8:13 AM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/cpu.h       | 1 -
>  target/riscv/internals.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

