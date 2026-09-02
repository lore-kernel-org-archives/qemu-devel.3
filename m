Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DF9C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nlR-0002bG-6Q; Wed, 02 Sep 2026 12:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1nlP-0002as-DY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:24:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1nlN-0005T7-82
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:24:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZNTs2067375
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IsGx6AU9jcgRFyfu1y4p7IXrhvd+82rg55iIxrMFujY=; b=TYKimwKF4102fuBj
 e7DcJmVvB+4jIll1AJRPsntSmwWQC3noekhu38JDtWsqPx79hfdZoYhF5+O0G4Ds
 rJ0XYGfUHk4S1O0jypVx3OVa5TBhcKhoQkzgvfVb89MhW9qb9WeNyCiAZ895VUoS
 5hqJswsgvr90F/HePslDbiNz+8gUGFTb4Xws+HVDP3vi+HIrWTSoRrtYR0ZeP1u5
 3XYxoX/lfd6uUNzkeHsAk2+GNGW/s6SeijseEo9NkHPMp6HvK4vftQYM7+p9nJRH
 rgQrhe4IFXpWnjNSbOTY2MiyuUJls5csHqImeBz7/hdudURHXh+o7sxwFa1Vz5Ht
 kSrV4A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv896y3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:24:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso1599218a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788366273; x=1788971073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IsGx6AU9jcgRFyfu1y4p7IXrhvd+82rg55iIxrMFujY=;
 b=Gu5ETM0FAJYXziytt4gFtOdazmGlvFoANcwZaFllFNsrP9FJEh3dVYX7IEbUtAh6ew
 CZ/LgQedrRv9yiFdYF3L7kHTFtEUH/dsepAZYGIcxGAasvN0ZcJeaWLh0+wtPwB80Szi
 plgiF+x3XFpDdXqmplEKNmqYixD40fGE9aF7eCchvxtL4WBqLpF3fx8/bcElI6WgdN58
 Q6M5MbcAr0/rR7u0RbfYtpSykVpxBKuCj/ABEc6OFH7mjnRLFmeetEB8Wkaju/hQRvUl
 J5oILfl6+SapK2QHTXRBvRkMFt4480ZAD50lgic0QsOh7gSNhY639f2GbQ/CfDjVal55
 hC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788366273; x=1788971073;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IsGx6AU9jcgRFyfu1y4p7IXrhvd+82rg55iIxrMFujY=;
 b=o/0GXZYIuOt1ZhJ4u/lvL/bcM3p8lnlcVGgLaq1+V5Y5JrCXRk+e44eJt+cL2jvWt9
 2hJok//+aXiISW2icv9fZ6KILh1JHPD5f1VA4jB2yPHhRJ2LBCzHiFpFZy9UqQRuHWx4
 vURGa3veFHM3s++WrfP9TMxnVc1YR1mxi9TGiqUeE/Kc176RJmEiZJ2VQ8va9wdkNYmP
 zwfuEH0S/n/1cE7CxgcgHEAuvaUmXz/JHOM8tQBhB/3K8xMbphrRSQ/R/Eg9mHs/Tt9Y
 NGwRs2oxPPnh/jTyWcTj8attGVbpKUjgZipA5oRIBYziCPqq9FjqNWvbcJ2kL0XEurkF
 3k4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzck3t+CYp5fyHE5pB5J8WpcxuEq1IRtzNofa1+BjGXuxhjx4nzl9z6Md1Jlis3+U4xT2dWdaetGHdM@nongnu.org
X-Gm-Message-State: AFuF++n4mxZtuNY0MTjewA40xOA5w/fzEuvThX+t7Ma688abPLkbTceH
 7a6Ia1J6TxAsfALyfa+DDIX5ovRZhblA9hQ+PCc9n7jmm/4XwSSOM+QPf0reXf0Aw5SvXzQkjkG
 oMIui1H702sedKIiiJSFVX8iwUSk23Squ0qm2N21cH+37iyIaJ91Pydk5iQ==
X-Gm-Gg: AYBFou06XP+3dOtPqy8bTqhP10LhtytBg3nc1UHwky4qYDh/Venqcm5vXA0ASwsvsR3
 mLWs0R45dgcVo2KEZF/TDZd+fl29n+GD494n0RheWNg222j+Fx7JiWgtoCmzQO9f6AI2TaAipn1
 59fANcbKA64pdTxf+WPhM+Au7QGkzfNwuusQOTcKvCGA7ceMHnSJBKyUZV4rXJ+W0FllTOMzb80
 zXS7Tcu8/QQDJVBcDM0oxXLNG/9V0yjaXOttOPX/Djbf+GI+pAXG1NfmuzdZ4g4pbxJx0pAwtGv
 Hg88CuW3d6kso+8n+ywTLBu6OaqGO6Ak9P+AWlfZEQBSahy3l48INzLzd/PkhUIkw3mSlPiTdG9
 XH19MwflEr78gcRUHKtYYkDmscdQB+TWNZEHE/Boo0CTIukZ1lrr1Svc2wswpobmNti4P
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39aee1f9788mr10278979a91.24.1788366272511; 
 Wed, 02 Sep 2026 09:24:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id
 98e67ed59e1d1-39aee1f9788mr10278867a91.24.1788366271950; 
 Wed, 02 Sep 2026 09:24:31 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430eb22012sm7317167c88.12.2026.09.02.09.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:24:31 -0700 (PDT)
Message-ID: <b816dd20-cb50-4e41-8e99-2559ffbf801d@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 09:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] configs/targets: remove target info definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-6-pierrick.bouvier@oss.qualcomm.com>
 <12afcfc8-e2ca-4d1d-89c0-54f8252abcc2@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <12afcfc8-e2ca-4d1d-89c0-54f8252abcc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BaFJXknjqwVf-cCtE-J7L8vqY_myFsE-
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a984dc1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=uwjLBNy7l8EhXSs-GDcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NCBTYWx0ZWRfXyJUqA5Zpsmuc
 OCMf8/uLxMwPKatGHTNlRlXsv1qC+EXejwdM+uX98c1vrGFjtQlEpQoeohC4T9IPpjAnDkMtwbf
 m4qqkIOkoKk+2rRPItUpgGg9A/9ne/USrAcMD0ER0pf1Le3+prZGtD3cZU5p4ypNDluoXTHcfph
 eG0kxLX58B+YvvbqKkPRcbkc3VCOVD7sBMQVsv5OL9PoHGbV0SYJ05FoRdGWWcHL/o9tYtaFRy5
 ADlPsPEVL53ICqWwx+E9OJHq9e1rIx+9cldGeG5nd9rUFAr+jSNo4NtOQaFpYsjj970CFjsVioR
 35ptUMeyCle2yF02s2mCVZZsfCeikgGJXMW3KcYouxqMBkLet8SeYa4uQnyBAYZTttlHwzzxiug
 X6t+EhCbrwDFS68gn40KiQe3DdtfYyboP56L7cR+Mb5RnQm9bgyjlM5hhP6K412Lqar7klExZd6
 wElzkD2I8wcNicWNN0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NCBTYWx0ZWRfX2hXvA0lnjIth
 CUR+NplvAA8wQWtsPBCwNaVPPZ/POeFeG0XtLzc8bJEMDT0lXmujInLhj00C0BhYePCELIBYZVE
 uJ3hw6mDok1SU9iIaQVvT1Kj6zHhLAo=
X-Proofpoint-ORIG-GUID: BaFJXknjqwVf-cCtE-J7L8vqY_myFsE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/2/2026 8:55 AM, Philippe Mathieu-Daudé wrote:
> On 1/9/26 22:20, Pierrick Bouvier wrote:
>> Now that we remove machine_typename, we don't need to keep duplicated
>> file per target anymore. So we can just rely on target-info-stub.c.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   configs/targets/aarch64-softmmu.c | 26 --------------------------
>>   configs/targets/arm-softmmu.c     | 26 --------------------------
>>   configs/targets/meson.build       |  6 ------
>>   configs/targets/riscv32-softmmu.c | 25 -------------------------
>>   configs/targets/riscv64-softmmu.c | 25 -------------------------
>>   meson.build                       |  7 +------
>>   6 files changed, 1 insertion(+), 114 deletions(-)
>>   delete mode 100644 configs/targets/aarch64-softmmu.c
>>   delete mode 100644 configs/targets/arm-softmmu.c
>>   delete mode 100644 configs/targets/meson.build
>>   delete mode 100644 configs/targets/riscv32-softmmu.c
>>   delete mode 100644 configs/targets/riscv64-softmmu.c
> 
> We also need to update MAINTAINERS. Anyway I rather keep that for
> now (including the following patch). I'am squashing removal of
> "*machines-qom.h" include lines where appropriate.

I don't mind this too much.

Out of curiosity, what's the reason to keep it?

The only reason it was duplicated was to specify different typenames.
It could be argued that writing them without defines helps to see
definitions for each target, but not sure it's worth the copy paste IMHO.

Regards,
Pierrick

