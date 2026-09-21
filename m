Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C59C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8irL-0004XA-Ei; Mon, 21 Sep 2026 14:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8irK-0004X1-GP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 14:35:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8irI-0004a5-Um
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 14:35:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LGUiZe2707773
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 18:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MQLLeL6PCd7kDY3iOV4EtvIPwH/FE2TFBO0kqcGfUWk=; b=gLx//qFqSkFEMVVZ
 K+2xjqCfUHzDe/n9l+JGrU+jvqmBeCjncH12LZSUyHjJMzLx6TwFkirDjK3YLAxa
 s3py2RkmFMbYvkubiVhWZax8r/RJOnzGhpuiibwKCvScG+x5vCLzRHb71lnZOv46
 K4YXgkjh/d5uRJbsgbf9xcKpDLzscaId0pAJ2LSCJdTUJsAOcW/Px6nD4fucpAc1
 TJy72zdxsues9yno/lQKg/3yX5kQ7/eIAbz23kk3/OHe2jr31LYMHXA0m0jVwTFU
 9wljq6nUNCvIjf1Htn20coOVeKsbo0quC7uigY0fjag8TbNLoc+365+r18QOENWk
 47KZiQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu85vghb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 18:35:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so6255373a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790015718; x=1790620518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MQLLeL6PCd7kDY3iOV4EtvIPwH/FE2TFBO0kqcGfUWk=;
 b=Rp/60pCEl/Kt4gwGZlSmEv6D8KESbB4L3i5DR3iG36nZ63q+/i1V8pPgtfw+r20qc4
 2O7r4auMpcsHL5Ouvz0RFIikf1FUtWPoY7Sn6DCtyS3WkvsoUnQJBBnsqu7RxAPolJiz
 EbZlbAxVBFXUrAOFzyJ5TqkuqZeBjoID6Pm/796AUOby7RUYGncSzUWHAHmoo+CzGsB9
 bCT7wGsMFf5VelX9KzN82GAWkm6TbC18Yxh3mNPfAo3fAgleBX0wPkfx98pCMxhkeDQ4
 2frO6vSNZ+WHB/2SR2I8wwM/aK4O3e0l1tKgvVkaMrBxaQX2emHqjRUmiDRKanp3z2yD
 i2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790015718; x=1790620518;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQLLeL6PCd7kDY3iOV4EtvIPwH/FE2TFBO0kqcGfUWk=;
 b=J+G83nyjdQ8fr64oERgK3bHUpmm1T4qo7YUHmJPmS/IFWtXcTxUDh8+izG5nqBrYvJ
 O/EtS02cwwTspa2v8X7ihD3BVHpbnZ+ywQkwt+D5KegqgBRMypsb7dZIuxxNa2zLUsZD
 oy37SIXS4dS1gqlkEv6j+rX1LdXUR2TfSerC0IiNVSdTJcqSVm0Rk9BA6BSoHyMyhqUd
 IArINQNMPUcXWQDMAh5bfKZsg9ZfKWZZl7eW0X/sIPm/S5SboRkP87klI+vFOPon/o6O
 KF+Ez3SWEFoU1FcWE9grYiHiOqjgdD7HiwIcCvT8CqR7axRFnNHse8J1J2KrYEzBPKBm
 y7xA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvTkVCntnowdHYXojSkjdAbGRc9WMwwyb6Xo2UaxMFYhhijNwgo2YeTJ4zj7O5q54HkHF6nGL2vXMS@nongnu.org
X-Gm-Message-State: AFuF++nHWdevstU7SsN8imvIvlAZ1gjaJPhfIGdSHYq/3e9S8v88qvlK
 AypqQhQts9Z1YOHWNlbcCmo2eJCgGPya8GBWIDqeDynIEW5Asrfp5uGHZ/85AFCcIsJbnb89zlV
 v3a+x7rEKxP+spxu5mPsJy385jRBVrforCPYLvgepwjPGYMj0mCqZdPNgGQ==
X-Gm-Gg: AYBFou0qfow5mJ6DNowBFT8PqRFLv82EeYKa+KspE74h+dOcgxgk3wZ4tDtN8sXJwTl
 Q8ir3BIqrQsVgGDD+EC3X5lehsnyTCMIzf017IU+Z/Pqy5s86UAziqYQjAzm/l3EWWugtPS2frU
 ftQPlWnXuzixi/+iLTnjM40Uy1oHC0XBGdp81B/ROhzGQ/Z4fQ8V6EAzRj1hZO34qjcr6Rjhndn
 f/3Q6AEPx3WjyRllSMUoQtzfjspBzBpSlCNYoUz1z2fgkD31vl9deZ6VZ13/3FDzz/x/BThj1+/
 ITgV33sydxH3IaajL0zH0rjgFmWSuqwoM9k+00A+iMfPfHqo9beOkTkJXZ5tpmfwS+pFjALHIE/
 klRpSQhdpARJZM97oW03F+xFOJOR2Q7FsGyHrTIEyAnopXuQsf1lRdMpmno9kWW/zTgE8
X-Received: by 2002:a17:90a:f947:b0:39e:6c69:34ce with SMTP id
 98e67ed59e1d1-39e6c693606mr10621970a91.50.1790015718345; 
 Mon, 21 Sep 2026 11:35:18 -0700 (PDT)
X-Received: by 2002:a17:90a:f947:b0:39e:6c69:34ce with SMTP id
 98e67ed59e1d1-39e6c693606mr10621927a91.50.1790015717756; 
 Mon, 21 Sep 2026 11:35:17 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144e16a7f71sm10005406c88.8.2026.09.21.11.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 11:35:17 -0700 (PDT)
Message-ID: <62cdd479-f94f-4d3c-8387-28522854f9f3@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:35:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] bsd-user: Drop support for FreeBSD 12
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
 <20260919-misc-2025q4-v1-2-ebfa61049bd7@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260919-misc-2025q4-v1-2-ebfa61049bd7@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MSBTYWx0ZWRfX5K3boVvJaHuo
 nlAe3sAfFdeLc1yncwMS/3Mz/xlW5EB6lIR62F/Xufd7QZcrV9iRM5hbKSzIg6VlhSeZf4+EJKH
 /GdvouP3vcQ/QTZx2dA2vxll+0ynUSA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MSBTYWx0ZWRfX56Fq1WYaSSHf
 YmjdHiqOz/ynl1YSHfOGvkjVqP3+m0oLe2C7hphFGBOZRUrtZIYqW6ynVFQAfxGTCXcN4h14sJe
 auOcr55VBcOWMoL5yqaeqgYETWm2kfk5YOmb2j7GzK3hbxwmFMWoRJKeMd5x4ToeNAEdkLzK7Ud
 0McGU5/bUi0io6oz3SZ4onMcdv1Y/QpzM8JGZqraQYzXdyGJYvekJWT/UvkTAl6vUz0PN4l2Lwj
 Jlihdi7V9w5dDX/MFkM0ScXtRPeR7DOS6FL5NG0eFH2PhZo1h5W7WqUYRqwSVtLLLNTuU1DpiAk
 pKWIraK21BvX1xxnMijZpnW2PiJnSV4FzA4cOVmUWN6d30xbjFoaAFkgu20cQi+/rXNkqnr+B85
 ByJN/cQU+xRkgMpkJTIIXpSJYtfFn+M9WOgvfC7uQveFjn1Ye5FZ+xDKcosBH2IHcnexatsozeh
 9TYluGO61iH1GdwC6ew==
X-Authority-Analysis: v=2.4 cv=E8FYNqdl c=1 sm=1 tr=0 ts=6ab178e7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=lkYnYiIoMmx7gjeNzlYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: 3y5xx__IVVnQZbZVkS-HB3xd05f1Qo0N
X-Proofpoint-GUID: 3y5xx__IVVnQZbZVkS-HB3xd05f1Qo0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210271
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

On 9/19/2026 10:20 PM, Warner Losh wrote:
> All supported branches have these, so we don't need ifdefs anymore.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/target_os_user.h | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

