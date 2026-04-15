Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91ACDF433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8No-000104-Hi; Wed, 15 Apr 2026 18:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD8Nm-0000za-EK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 18:06:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD8Nk-0007q7-Ht
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 18:06:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FEl2n1579804
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mLFSu+ITAfjGbJVas1F6Gnmsq5nybhWoGO8EAvr5vTA=; b=DewrMQK8DBZpLhKg
 OOo4HajEDUr+pYpmx1q1G+ROwF7ZYxip+Ed2rCmnYZNzJNYhVRPv3fxOahossu7C
 Sa5nk83en2FC3rLfLEzEdnUa1cFU/wVjV6Dq27VymzyWCTe+VTWp41Z2g0UoVui6
 gK/HD/2MSEUwN1lwDYYXt+P25L2rP0zoWBniMZfcE6JRotGX7FvTdSEuAhP46lqo
 mQaroqFGU24fb0Xe2KiJEP3qkwH5tZcU9/ZgEorlk/O5/3m3gvbVxja8blJlCKYV
 jfyxVxXBomPSYp2InkVtlBIiout3bG+hRuyaqxc3InMBO1kUH6/HIF2IT36ROjDV
 xEDKtQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcr8sbk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:06:46 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1275c6fc58aso10788191c88.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776290806; x=1776895606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLFSu+ITAfjGbJVas1F6Gnmsq5nybhWoGO8EAvr5vTA=;
 b=M6+2webiBuTRJ8l/2uzBPE4He1bD3Q1A+qffj6FdF5H44291b5/e21qAT1gHkk7fKA
 AoNcbbCVLQTf3yU8jynYrCA+965UX/gY1dp+ErTUUxX7pN188jjOTdhpaZUNFpZburZ2
 WxtScN94Hi1Q0jg4F683kmg2ZhbNZKr7Suknfx6R2axmsx7VXRJ6TSuyTOeyTLUzc/xA
 OwUJ1WvFy5LoAjvP7crQu+KNT+y8U+PmzxCT7xGnBvwGV+QbRf5ADePSgKCXcVKevZBz
 +1qjfOVMvijC2qaUZSJO5cYoPjZxbC4hEaAuNr0cmgbg3NBFJZxv+U2uVS63HdoFx44e
 crSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290806; x=1776895606;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLFSu+ITAfjGbJVas1F6Gnmsq5nybhWoGO8EAvr5vTA=;
 b=HM9oY3hQAyznhj1zk8PbVhbsl4IIKiWaweQBzm4UxhbH+HY1W4zn2mJRemzWtrFCO9
 xziZyisph1CC63dgPUmH6Qw1lBV8KGRtUaMwNl/W6qFt4ihR3qFfJG1isdBemzPuW1m0
 mAD02m2HnA5n7gg6a+LA0gQS0T5tYcjaP9zdULPGaPjGpevpxm9MRTo9HEaTyZmXFX4C
 HiT3ouvWgGMWdVwfjRijffRu0ghkHwW1Kc5zqj8ssW3nhPI8CXJOBzcuKpDGHQbTXe1G
 FXj2Bv9dqLDCkiXZN03QWcPKf0uVHQtJkv2mL0IVxUiQ6uxA0RhGOoXxfarAhBl9MR2J
 /HBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ufgp8mKpOFnP7PcX2EhM+jHIlJxjTnvWmdqNn/Zhr+v8NEJVg9yyvXdjdsLtowHzLnRaf2OP9EOCS@nongnu.org
X-Gm-Message-State: AOJu0YwvaXaccSqLJkifDP17U6VsdUqcv4G4V+3yBdbKGBvRQ0PXzPoe
 CoXYlfk2iRFE88sbVS0bXgAEzoSfxiXajgark5aq1RFbEyj+0Db204uOJzBr8YY14cESWiTU8RJ
 V2cXdKXhN3JTocfbZ6RCql2CrJxB490s3zp+usrXi92oJRosLA8BzTZzizQ==
X-Gm-Gg: AeBDieuNd7tRp9Wb9F/bY6sLgViefEz2xInnPQIxh7WqHDjManwdsbQxWwkNJNAEBtB
 tPNu1NOegmvqT5/qo9TMsar31qVt8qzSXoishnyrBFQElFo1iCihOb4woEJS8aeISvNBU3PlMeN
 dQwD8ACY2xrZREomgR49TLdDEz1Jok01chTwxOjJdaLpz8SQwbxBkY514J6afyvEGqIP3buckqF
 raE3QNiH/M8mQu6eR5M9ffr8FYWNVbw7U+6rBubFW5+jY2N3ZYTWhOvRx9f8d2/EfJBSSecTdO0
 X/cJ5aSJS5WtO9ggvUmN/wukqJ4MS1nlrtTazjLxIn5flnbplwVw9/lAzNsxkRAq4VJBRJFfExL
 WmAIPDav74Nov+VrZM14Od9uAFS7tgmFFJW3JDF4dYrSevOdVl47Xggx6oFw34CHwOvpCX5UTll
 wjeulCLkXW7g==
X-Received: by 2002:a05:7022:327:b0:127:9e95:a2f with SMTP id
 a92af1059eb24-12c34e714e3mr11772841c88.2.1776290805809; 
 Wed, 15 Apr 2026 15:06:45 -0700 (PDT)
X-Received: by 2002:a05:7022:327:b0:127:9e95:a2f with SMTP id
 a92af1059eb24-12c34e714e3mr11772818c88.2.1776290805203; 
 Wed, 15 Apr 2026 15:06:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5e6b4fb8sm3639301c88.12.2026.04.15.15.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 15:06:44 -0700 (PDT)
Message-ID: <89118a80-f303-49ec-b2ba-e79e15b9040e@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 15:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Prefer MO_128 definition over magic value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20260415220358.93063-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260415220358.93063-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gc8nWwXL c=1 sm=1 tr=0 ts=69e00bf6 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZsUDtwrC3IPfZBtdUEwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jD6jOJ7x532QwzY6WO6uoDeUTMlkiauY
X-Proofpoint-ORIG-GUID: jD6jOJ7x532QwzY6WO6uoDeUTMlkiauY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDIwNyBTYWx0ZWRfXwqxiAiU2zNTd
 XYN1KctFHy5E9UfaFTlr3wNICJ7wO+2j7y5O77M9Gmu7oVdH1aVXvBcvho8f+CAVyBMBWVZdmMs
 9u2MLrO4eqNdw4FxU7ijXwBSSLcuqNgid7310enM480n4IPphq+KqhDqgpa8T1EKYHnje0/sZ7y
 8Ypb2lm3IE+bOMxokSURdENxT4eaH38klOz8nVwtIKVNTYEQ+laZlWAC/KztRkjHaRuBqFiKF5j
 qG404t+60DcpIDhy6bq43AoXyvtCMrtqKpr5ogD6MTpZ8UMjwbEeQQ2CYC18WZ58jtF29M6JwMT
 gbmiPWc5eXKFiFzw5fwVfW7cz+xyL4dH8o2xicA60c35lAD0hZOozJK7BEu9sGcknh2TywrQFde
 t9cZRcBCHiTtCF33++n7a/3doEzKdjBLC2V5Hb38Q4JYOvKG2/PecJgLoITLoGdZQYSB6TmWxc6
 ld7WZAk55eAfXF7KvJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/15/2026 3:03 PM, Philippe Mathieu-Daudé wrote:
> The MO_128 definition was not existing when commit 6d841663be8
> ("s390x/tcg: Implement VECTOR GATHER ELEMENT") introduced the
> ES_128 definition. It was added 2 years later in commit 4b473e0c60d
> ("tcg: Expand MO_SIZE to 3 bits"). Since it is now available,
> replace the magic '4' by the more explicit 'MO_128'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/translate_vx.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

