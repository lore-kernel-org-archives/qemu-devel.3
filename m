Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7873C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4iY-0006k9-9J; Wed, 12 Aug 2026 04:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu4iW-0006jx-Fh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:53:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu4iU-00081Z-AU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:53:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C8YrYR3848012
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vKWR4cRHPL4M5aJB0vX1xWyNM8hX6Ot5uwW2kcGsGvg=; b=hszsvNJxJl9DhMWq
 b04h6mZZmOlu0HvW5CUn61ZedWzibrXr7AOw5SWgwZ30dg10vl/yQivITjJu93f0
 QMejAZP1hjLrLNplnJds2oFIFsYKZRSQpforigrKv6r1+0Ke7AGffNS1026R/RH4
 iMKxJD8YOqCl0urcLNdbP34larwnzBHn20/DA1T9TsYmtW8+jO/eKdxdHatoIcvD
 NVlgzhny+p86pjGphQkBl8VhOVFrPe5EckSlTi4RxX/I7YtpNdOTcc9/w7CU0VVu
 b0kCpXeXmvu843wjiG6Lvom7lSB6uFv8LVgWj9jzMJpbCJziodcsPjSezFwpBGhN
 3L6Gag==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5k0gj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:53:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so7202481cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786524819; x=1787129619; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vKWR4cRHPL4M5aJB0vX1xWyNM8hX6Ot5uwW2kcGsGvg=;
 b=OXSAkQWYIaPOInf0oPwZ2QWtE+SsjbgsORqQmK/ltRWT+Jlrs/x1rRfaVlmimyU8YU
 SNd19bYkMM4Or87gXRgaSvztL+3SlBPoaPhuF1IEiMAloCKREnpkEndGQSiu2O1AXBLI
 t6agu7FN630mje/XZsQXq1WSwqfs2TtweUK30KDzmK3G5pCXczm/xDt6EpuPrHB1HiiD
 gkxrnvrNLOxYdl5VLhaoad0dqj7R+8AO7Al42Q0lilZ3AG5co4OUlhej1NpDUPhuBHYR
 tAU5rg5obQXXMF/u4ZWpZEB0UlnWzcZT3c3AMNDQcUizy/H0vALZMh0yjYtb+c/Ka5Cq
 t77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786524819; x=1787129619;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vKWR4cRHPL4M5aJB0vX1xWyNM8hX6Ot5uwW2kcGsGvg=;
 b=pJ2gxBFMzU4NVJ+KB10bM9VNdk/s/sfJr6gFFl/BGMIohbnB7a7zNv/u7N4rniK+zf
 LzAuavzmzVI8QUxnI0nwy9qgnx9SU+kI5qg8h/hHdM2u64rRFILQ0ZtXbxd21fHj67Kh
 5Q7+UiloVNWuwd7GVqUhUwP+aT1GJcpRx8m5f/w1vsrjJ0kJDwHHgqh3BT6icnzff4gq
 LDTHckBQibHLJjGtp1wrPfKyo7MZGyDkM8hSczpYxcp3Cpfkl/PWjRpwhgcCAGr2ZzLd
 0hXsJ3ynKBOU3jL5kIqdt4vsnDCUownYslD/Z5OBEaoMlavN/loh4K6azFfe3HO2nzIu
 LAAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWr6gLM1MHU5HUIQPJ3W9/aQKglWYYpn1KAXt3iWbyrzpzQKJEh0LhgUnTOMwjEFgH35lWQ7n0ofWy@nongnu.org
X-Gm-Message-State: AOJu0Yx/J7otB3q5rXWYM+ZOusJwUeRcwxDYFN8zciVja3NdZXp6QCEz
 LIeIoqtDUKI0MVm6x0Gu/Lw2txD/y7aFRDT99mCESTwRcse+DdkCpDaX8r2BO20DLob93Ld0SsY
 rvRj5a8/Bot7thXYxLAOG2RuRSBXYGTWGi3m3L9HoIm6IvWcuY09ekFo6nw==
X-Gm-Gg: AR+sD10+8DypMdP2YtqCVo//8mXL2PHhkpUQgNd7F9LVp3PaGUcmHnD73jFTgmF7bfd
 Y/abYqWFcuD5HQBcH0Onrg3bRpk3/pPVghTeFF3vLRxMEXr7IjXXvfYNheGtdYKUipy+OC8rJ4P
 vVJo4p+NW4sVkwT4kL8piFYYfrPJk+ewfYnVPnuadXPsb1rWDNBnA2WJCzpx72uI9kyJSpkuDDi
 N6M3N1nSzGLAZ1NZIAV7ZRcOUUT4QxRwRK5FqrIlam0c+M+K7FZMQPUX+r5N6v9i24651prmOGk
 qD+zwcxoDXJFpaXAh2WgtHl1pCECu8Vls8H/iXei1SMecLw2t2fk9TjYhUBmeUoinuf9lTMg5U+
 +cTi2T/vxPtiqQSf/f2lgQC+l44iNrWU+hhA=
X-Received: by 2002:a05:622a:143:b0:52d:47ce:944e with SMTP id
 d75a77b69052e-52d64712006mr20484901cf.13.1786524819556; 
 Wed, 12 Aug 2026 01:53:39 -0700 (PDT)
X-Received: by 2002:a05:622a:143:b0:52d:47ce:944e with SMTP id
 d75a77b69052e-52d64712006mr20484721cf.13.1786524819178; 
 Wed, 12 Aug 2026 01:53:39 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c06ab7sm5234598f8f.10.2026.08.12.01.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 01:53:38 -0700 (PDT)
Message-ID: <80903a3b-f140-43ba-81a3-562d0ca06e4d@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 10:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] sponsors: update who hosts the Arm hardware
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com
References: <20260812083942.3833221-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812083942.3833221-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MCBTYWx0ZWRfXxeqOjQo+5HnH
 ij6bcZtq/TdEJBYMpxyFx4xDOMsJBVd1nRjvujRbXtYzivuzkj8Ia80aoVtYaH6DOMHF7lV1E+f
 ICPmGVeGPLB0+MMWoF7D3mbBXTA2HF8=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c3494 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: t8ynjaT5TW_o-ns0BFpyiXaz_Bpi0EK2
X-Proofpoint-ORIG-GUID: t8ynjaT5TW_o-ns0BFpyiXaz_Bpi0EK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MCBTYWx0ZWRfXweY/Hlyojis8
 zJhFusmRLw7cPok/aBQu3SjpqOgm+HOrD+w7pfJCemlGGkWEFhrfc4mp442hDlFE5S1h0Wzyvci
 6W3tOI//RvuvOtpgsnyGkbGHaBqSUtCodAAPnNgCVPbb6szjvIfVATiwyTEQEZwNCSHVf0HX9La
 SddyI4ADmE1dhfnJwKprDb7uFPlcwrCCkmeYrpFXI3n6sRIbmolzuPNTJec34c8OCRCUaHIVM5M
 Il/LiX4gHQmB4GaE/UOfpxB29ynIFKFIbwMgoCkfaqnTxBF+Aumf8x0awq9Qi9vbs3KYK7iLGyp
 j2Rcykc44zaSl2Gq/21SqoV5S3Mmhxx8WENV15A9u6PGtI/OGROnCKHq91Nlc65X66DczydbVSN
 laP4cdaljKmrqEVx/o8CC+wCAhyEzThAfn3pPov0+ElW5agisiILx+iL+YEMJXFpgEOCMzIyL8o
 8XdG0rgV0xV5vb4J0fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120070
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

On 12/8/26 10:39, Alex BennÃ©e wrote:
> The WorksOnArm project retired some time ago and we are now hosting
> the Aarch64 CI at Linaro.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   sponsors.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

