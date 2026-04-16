Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E96F8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVjY-0006LN-3C; Thu, 16 Apr 2026 19:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVjW-0006Ky-RH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:02:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wDVjV-0003FR-5T
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:02:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GFd4YP701104
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tlWaoojvXntqnVW/8gMR8B6UGtoQzGsQJ8vbQdb4jGM=; b=EG7CqIfxDON3Ifdl
 e7vqqU2Tpcx/D+M9h8F69Jb0KL5gGIiIS+KKUN7NdLzAPCwWa2fvYFPgcbuniVHQ
 aTwY+BDl0iHWgFWrJ9GDcdInSkj36/2Iem0I96c5qxLZpsLf9CKfm0HAGEZ2ibSi
 4xAQjLHNUWLFdLPR2f1hiuNx0JLFu1uvDCzmHaAO49uxCFf1SIrijJlYQ7cJ2mBp
 NvN5cwfXGs2FVzVJ6jaD21nkfg11NfpPslO92l3x23GZl27qJzNhovXpCpgaWwnL
 0yjN/IkMaXEon79oIwqgIhgunA3lHNRN+Yy+4Vy7IyckUuEFLI6z1qYqV1i/2uYD
 7mwimw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2kn9h4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:02:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35641c14663so113536a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776380565; x=1776985365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tlWaoojvXntqnVW/8gMR8B6UGtoQzGsQJ8vbQdb4jGM=;
 b=Uh8TpKzaG27AklPTO+VDKfahlYjLMfw98AhRMqi8trcSrBDG+RoDSpxjJYRSeXdyBy
 e/NTgfjhytpG9u5UQaCuaYOcGJxjxoHmn2NO309fn0RfsNqC3MCqy1skSM8cOFAjGpE9
 pr2lN8Z3HMbrbhqDMapX2VtuTOVidvUT3rCYL6Ug+8pUm0Z6zru4EWTQv+3ska3SVJLk
 w1ETaWDOeAzj8O6Rkzpy+3wsPgsartPi+HYyee35kIQmnFp/0IwSyn4WJVo4VC0Zu86N
 KmwoKi7XgUQyIA5yaNDCrizuVwDl0fW+HQmlOiP39eld/8hW0QsEKAzCwZAvf4M8OVf9
 SosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776380565; x=1776985365;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tlWaoojvXntqnVW/8gMR8B6UGtoQzGsQJ8vbQdb4jGM=;
 b=rv9F2LTL7I/eH9Vmdb78cI2Z3bP5RETVb59PfhWKsV8tHG/Slw0y2FipJipz9KopOE
 9CxUPcjnKpGGf72a013oWY0a+stPVTY7nNHAHRNnaiRnvj3RepM2CL7UQ11QJOrm8br7
 4pvdgQnt60EQw00Gbcqx4kh9YVYjLAyjxvii2AJqONInSH3FOtRIdBmAms4ZPaFYqJiI
 fE15v3PhhRWLVvtkYjPS+GdwdXYibWKcTJ/sAWvlhnxXrDEG+EllNMQe1lHv5VvGXKKf
 XISlB+R8DNoKckSMUNltlSgo8iakOHdW5HFuHB2TcWax6X1kZqd1aSWlzA5J4Rfj6t1B
 MeCA==
X-Gm-Message-State: AOJu0YySktbvkUtBM4wYqNwTwzr+RCjeqgYeAXRwGBvNpGcB8iptD/BC
 iDAcQmh3Hy7/pQ6vV+QysQ3Oq08zR+QT10O6XPHz1Kn52jv34CT2rVbXKW7k7FD4MQCaU2h/U9V
 itIY8xfrvoZp7trv2N2+0eFaJQSS7ugIHDXAYiS+PxMKMPvGCiXsj9oGE3Q==
X-Gm-Gg: AeBDiev+2uzdQS7q5sN1u9qYZgWM8U2pTOdzlezpxsTibp1YwZaGq2gOkQq0H231Uxs
 MVVOfp6D4nL/P1RFAs8w9gbOzFhbc4Su8A0sGRpRhvs6ba4Tgcx3muFP0vLSDZSJLDkgMkbdBYZ
 lG8LpT2NWMGFxyfUDFjQqeubQSIEtO25TVQ0Gzp26A39Vc6Wst3nT1OBA8JxvCbl5vzHnBS8g2f
 3MWh2oZaRQGv2GHtzTtGYSxQfIh1N+oqiLRzlVvkNdTh6FwyQMxSilamCGeHI0s3peNeFH7oUFf
 ZhlFcQu2bmf/aL8jQ4Yk6xQwDZadUxOpTDGmIRMkIsU8pVVwJQNTSkT4WeW2VaWhvX4He+gmoES
 gn80ulVC08wbvmrJEy/peoIgzhJ4DSfTfeWsR40MIKtTHQO16jsTMDww7u1VbjAVNQSEKHMbxnO
 AwJmpro6+45vQ=
X-Received: by 2002:a17:90b:2fc8:b0:35e:5a4c:9069 with SMTP id
 98e67ed59e1d1-3614048a431mr270935a91.14.1776380565303; 
 Thu, 16 Apr 2026 16:02:45 -0700 (PDT)
X-Received: by 2002:a17:90b:2fc8:b0:35e:5a4c:9069 with SMTP id
 98e67ed59e1d1-3614048a431mr270889a91.14.1776380564638; 
 Thu, 16 Apr 2026 16:02:44 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa59e253sm563295ad.59.2026.04.16.16.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 16:02:44 -0700 (PDT)
Message-ID: <e75629e1-3c14-4f5b-a7a4-a6d0119b186a@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 16:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] MAINTAINERS: update address and add Hexagon reviewer
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
 <CAAjaMXbupsQzscL+cs2R2Vn4R9Ar2jgu4xq0xaX07drYfDcSTw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAjaMXbupsQzscL+cs2R2Vn4R9Ar2jgu4xq0xaX07drYfDcSTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oKMyrFXdPaxFbx8mTJlCsGkB9pzQlglN
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e16a96 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LQurugNXOK_RLtD7mR4A:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: oKMyrFXdPaxFbx8mTJlCsGkB9pzQlglN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIxOCBTYWx0ZWRfXxT0vGnklqBJi
 bW83Ov4V2m9GBUgVRTmq1uVFH/W1TzASPUnQWOgYP0osQ5JT95xIweQuPwnJBX3thWpiiygiR/W
 0BxmCuJ15ei63tx8nWpwh5jZvQWn34KJnayD6d0bhxly2bqxStWz3UjSEQ4KvzMgdFS93SaO3hY
 IJ84D7xCKzGltS8H/k0WUYjdEpQOUuPpMz5h4X/6exqAv9f8prpCxLBEE95HJ5XIpkvlZeRKGet
 jxUWAR7gUgsNjRGFmY124vSz+b2frQEqemDQ9q1s36P/OB3xY2ZYTk0JGQ5unBMbBmzuHXpWiyO
 PI5nJ8998ZYQvtGZ9zfLTsv7lxxJw53CtcMQ1f4gRLEtwWUFgDyUNgC1/8P0ZSPVSdZF1gFeQCr
 5ZDJHIPHp7v5UQPjW91OsKY4C/94aMLS9+w6ArZMHgeqtdf3aamI6js0l1L5R4VyiuMkr6InoAF
 qBlU24/EtISRpVBeSgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/15/26 10:47 PM, Manos Pitsidianakis wrote:
> Hi Pierrick, you should update .mailmap as well.
> 
> On Wed, Apr 15, 2026 at 1:36 AM Pierrick Bouvier 
> <pierrick.bouvier@oss.qualcomm.com 
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> 
>     This series updates my address for areas I was reviewing and
>     maintaining.
>     As well, I would like to help review Hexagon target.
> 
>     For top maintainers: I'll send my updated GPG key later.
> 
>     Pierrick Bouvier (2):
>        MAINTAINERS: update address
>        MAINTAINERS: add new reviewer for Hexagon target
> 
>       MAINTAINERS | 9 +++++----
>       1 file changed, 5 insertions(+), 4 deletions(-)
> 
>     -- 
>     2.47.3
> 
> 

Thanks Manos,
I didn't see about this file. I'll add an entry into it.

Regards,
Pierrick

