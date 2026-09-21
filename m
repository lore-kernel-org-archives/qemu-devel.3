Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0977CC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8abM-0004Fw-LC; Mon, 21 Sep 2026 05:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8abK-0004FX-87
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:46:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8abI-00071S-QF
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:46:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68L7ENGk759409
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SmOHPlo8Plz4swbW7LCkXqWac/Xo4DnRAdp/V7Hz5yk=; b=mKCZRwSgkPoxXkkR
 Mh9bwVPPKJWQDnCnJfsNFqlbh8nuGScKtUiTuEcr94zrOrCVpdUj04F/s7AIdFEQ
 AGbwCZ/uCoxBw1hzXP8+Y6dTz6qiLzIMy63RbHh2kLEowr+8Dqo6vfo8IgwQBOO5
 a4BK4WdSyCNUUSIGC6yPN+sQF9uIg4PuYaq46pK/gW/dCyKSRPbX8GCoW6VWwtAS
 tUbTZpQD1LSlD52B+wg0B3beQOcRGc+C2sANbdC122IaR4IV9TD/V8pp9WNNByIs
 N8IdLaBI6ymK4WxQHzJYe79LqteCOkb3L+KFScvwbJk4XtsAMkiRVayksMwl6s2h
 usSaTg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0118mb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 09:46:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1bffc2eeso204749285a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789983974; x=1790588774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SmOHPlo8Plz4swbW7LCkXqWac/Xo4DnRAdp/V7Hz5yk=;
 b=kxn7M3PpyIxMwAFHwcXkrwKkG14aVayNrP6sI+GXSKJ3O3jzM0RsODVXg6owtnqLUb
 6gV3r4UKIIb9mdRmaZrI2npBXXZTKMy0gSjdjzcTlQHg2tTo2IzF7cp9vv0B6y7Utmpq
 CkQ2rkcpEH6jJGc4AJKN2RpHXkera22t+hdCWiKQ9ZcB1P4i8lzzn2mmwc4Iy6jBABlG
 l/hL2h9OXjelgLqP3odQA+pmhjfH953AeSkEvAD618qc5mAFgVnNvkQ786PKVUUee2ON
 8nggFsMA122zO2f3XhPU4xUbqFWemefzGFyzzVclKOE9xJH806Y1t74Q/NBFkRDnEEym
 LqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789983974; x=1790588774;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmOHPlo8Plz4swbW7LCkXqWac/Xo4DnRAdp/V7Hz5yk=;
 b=0FMYperamgous4RoqOhALcNSt+qmSXl0+qbVNXEQ/Gm3Yhp/1kDfsho9CcrSJsaVm8
 tJMrqCxYK32b2A7/zTVaxX4mE/tu+NiIn80rGeOl6A1RsX29zdOO15c68wN34DTqrf+G
 R3UNv8Haw8L0D716HPSJn1i5nlT7YDIJsaCndUv4O0xGj0k1jyqqLbl6KA0h9TGCLoUt
 X9KShgtbiYBGYS6/XOhRvtOOn2IDJ9PcwFOWeHi/2d4m5JdE3clR++2/nom+cDz5mAki
 mJt8RbqiS2A+GLRkOJ4ka7GOR3eTQKEG7vGAiti51X009rc5wSBPNhnoH0fJocqmbblq
 MBuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+U8Ul9UA1+chMK2vLqwx/giKyH60ltTdf38iw+3m/l4VbP1nO9y7cquc9YAOx1/s2jvU8JILfeuOu@nongnu.org
X-Gm-Message-State: AFuF++n2rnZiCbgS5FdXat+qu9ccyqieCyLV0+tUasbgFZOQMB/9fND+
 8tSIo4TXkkdtHlahI0uLpBQz7sAhKHxpSsOCMdy4ZaQS87q0TT+BNdEB2bFurCtRfZ+UsH1aV4h
 BUey1PJvJBpd9yDhF9Juk/rxvdxXQ7RGeuyz7GvopaFpWGB1+S6/8lENSJw==
X-Gm-Gg: AYBFou3+Bms7O2aTP10xqcA/16++a+tkShHObulBy8ta3KF/jZiF3JOck5trORSMC4d
 qcS89SbwYr+YfCQgWWF8mC2hjMbjob0cRqnz+SKv/BR2G8cTnU2VOa7N3T5WIJ+yPrWVQO2BBdG
 Zlh/dkvzYoGeITmMdXMV2fvIGYT+CRBzPmTyZFExKDpNihsP0EciJQZuZXaHLJ5/MSryc4eo7Bi
 BIy+ekV7uumdn8uYQwxmLFebNYxyYSD+jurwjdPDpRIKk1NUrRCe/QXyv/2obekv5RSDlet309o
 vel2lU2WBtVNb+MvO0ni3ZXaCWXHEMQen8SWq7dE5Z1AMy3ocRAQAnEHPYpHssNF56c3z2GcElK
 DeeG14pCO15RjOfD62OiiIbUA6rqzxouBXw==
X-Received: by 2002:a05:620a:40c4:b0:93b:c3ce:9056 with SMTP id
 af79cd13be357-93bf551d083mr860891885a.1.1789983974433; 
 Mon, 21 Sep 2026 02:46:14 -0700 (PDT)
X-Received: by 2002:a05:620a:40c4:b0:93b:c3ce:9056 with SMTP id
 af79cd13be357-93bf551d083mr860889485a.1.1789983973940; 
 Mon, 21 Sep 2026 02:46:13 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd0f8563sm248155455e9.6.2026.09.21.02.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:46:12 -0700 (PDT)
Message-ID: <84b214fa-adc2-4999-b8ce-84a5aad8364b@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: qemu-macros: remove redundant clone()
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20260904124801.1144707-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260904124801.1144707-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PPIkOnlSPZIhKBHLmNO7lq0C2IGLbot2
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab0fce7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE0MCBTYWx0ZWRfX4Wxl4bIyW99C
 ZgJJaT/MadCwYr27VbXHz0FGTErX4qnz2lJ0IvjJicOY8yfdJcu1T67DPN+QCj3WYnOuwjFeeXb
 5eVcTJCFUgKV4I8gBfZx1Q8OawvvIzc09tvrGctF22DmZ0QSEeudW4q188qiAQg6fEKMKyhfu8M
 0/q5hcXWOYTVQxCx1xl/v+rcTfd7LbJQECmGtFCdycMzEBSn3gYt2CwyUGLvMFguQedU7Z3kp/l
 p7HyGmlyntna6F9WbbcQeZEBDfa8NzEN1T5s6qZjTegkhDXjINBGcp2O8/hJGLZRoC+uV5Nzl0X
 3czQOyzZ1XbqWKHxhd7OqHI3h8/j70lubQZ2H9nsSrW5gA9kcarOJ8brgMSkz2U1hqLkWFaWXpI
 +QWRDyS/yYPdXked4L9WhALjvALxkeQeQfCTgvStQtMBIeVVqeT0y9tgmXI5/SKAbizVl1RXvXF
 Fr60mYs1BArm6vGadKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE0MCBTYWx0ZWRfXw2vtwR6NcHX3
 t358NrrWfzK7QLHdCW0kGw4zUIm+BFhjUDbWt+pyZeyD2AoQdb7QGSvzOGK/7ORGn2EzdVLZDcz
 5iOWe0BEGQq4ZRxpy/Y7bS+wq1ShbrY=
X-Proofpoint-ORIG-GUID: PPIkOnlSPZIhKBHLmNO7lq0C2IGLbot2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210140
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

On 4/9/26 14:48, Paolo Bonzini wrote:
> This is reported by Clippy in the latest nightly builds.  Take
> a reference instead of cloning.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/qemu-macros/src/lib.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

