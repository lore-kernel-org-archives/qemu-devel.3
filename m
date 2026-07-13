Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20C3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOsl-0000MD-9P; Mon, 13 Jul 2026 18:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOsj-0000K9-KJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:12:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOsi-0006eV-0o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:12:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9QfS2409517
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P9bk5OcRf8nVfOFHH4qNG+LQcSyhay/iNS8YAtiCES8=; b=JUSzegSyRkvq6Ua2
 S6FYbC5z27nRFbK4dTRBnOwjSc1IjmOyKq5Fo4ode/a5eofF1ws0OUeNXzEvBDAA
 CJto59Aqb8xa+AtKbn2XaaLEaHxw1oeOSlbt1OKnsfRca0lwLmvO+m96yeyAbKoQ
 5EwofFl2GnZmQa3tiQl7XU7OQvA2PHh3M5CPUmNMXDRYYe7Cz31VEWYz0J56fxAE
 bR8m+lBn2oQfQYPk0cJ8V9c27CLAVKXDcEYPtrWdgPKTQXStlHWzjBxgFkkFg/Iv
 k19wz1s31VoDCjbT2D/RGVWFFIrm2W2C5/CBIQip5KdzpYgtC2pfU/avUT+E0BWs
 ohjtJw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj03b31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:12:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so5315774a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783980726; x=1784585526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P9bk5OcRf8nVfOFHH4qNG+LQcSyhay/iNS8YAtiCES8=;
 b=dkqvga836G8jVf38Tjf9UJv8Gu3S0rdoOdxpahXh/JIleJB7UG/h6CANwPSgDv8QX1
 DBDFO73MvT88+RvDblhYnFzHK0cvIYp167RERwaE/IZAQOhUfJS6MLfuNIkIJhrHleB5
 ZSJVx0GarX8iP8xi3QnjscvckIeu4PPxUrAwIC3Woa2mda4Xn6YqpFS9A2TOTMrfKsOM
 5xw1De5F8wh0/YPE7N41jOlLL6daAFOlZHtQj/n5jsbr4zVIsuoKQepPGX78XaTsQQMZ
 NXfGdofQzlIpT11d2UQPdRxczKXi+PolZGUTXK8P4zknqpd8TD0YGIbdz5BAjf3Fviqo
 sZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980726; x=1784585526;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P9bk5OcRf8nVfOFHH4qNG+LQcSyhay/iNS8YAtiCES8=;
 b=qRKaM+mMntmKNTtlCNNdrZPVmcbvVR5itTbH6UIq+7MHDyM5yMd0SV39/WmaQpGX1l
 Yylt6fzXB4j2Gxp7+gmA1B0xHMRljVZhKzI1Umott0huVcLa80G/R95WXRY9gr5wYqEE
 Mk7HZMbsBF+YHerdw66tPiazyFlS0Mzy+3vXjRqzDm4l3PptM5h2NRvlLcn/bFfuUo/Q
 vWHJgCBMgENqetX6ZQkEC4zLYhAqtS/XlbKewRZBymdykrXpJqzEibuJMeLM9fmPv1f7
 wTOSNJDu4pkWGkdvbwVYL48tmxUNbuIEg+TA9KnrRYoh1ju5XDeSx1I1vF09MaUiQkoo
 k0/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqknUAnrqBcfGMRM5nmxtrzahAsmchzh8ycgXCfOvkdWmUM1TjTLkeqc+xOh+pT1zWTFlqEsFZOmuk6@nongnu.org
X-Gm-Message-State: AOJu0YwFWB6ifH4Pj7mBGqYdle6CEkliU5rmzESj7EM79ANvWV8CZuAm
 2REYlvia72hdZvoi9jiavM+1OiYbF4DDKt73FfVsHuR/H5uYb3daE/xiEPtAlstTDMDkzXh5TQR
 RLlJhonQxGviJHA67m2cIKKfv0Y1T93ZS6txMitOP6JnAoLIyBlyrxtzmoA==
X-Gm-Gg: AfdE7cl/CfLkLXN5y3XXmn2Cbju82sGVwN36pTiEXldcuh9IY8r2pcfZFbTEh95upaf
 4TfKItp4ClsNEOBmZZDt4qfbuz8v8Zq8n5TwRKiuUOU2wUHzFR6fZkv3MrqVwMsfiy4UCOPzFub
 bpeV5k/0q0BEsRFbaZYVhOoylAFkQUXliSfVLHqE3Hv5vcK4EdXzK8BogKItt+K3TcUzsw6cIem
 WhC+RL1x/QIHUdEb1U9eU4UY3ehEGlsEa2v9eAOxNoNOSCSCaToXJHPGJW7dDXFCqmMNf4cIroA
 Hm0PUEFxnUuc7n9Vf/bYRlsoOnb4pR7XEazChoH0S9Hi7J9eNFAJ/ny4Z0rXFTosO6fK5l1LWKT
 UX5to/b0/GAz9hB/q28efOj9RbC2ZwRV13X9/ZiNcxIQd96fiA1P9gH35PVnsuBnocpuqFRd0hD
 ScHgA=
X-Received: by 2002:a05:6a20:a109:b0:3c0:9c18:d5a6 with SMTP id
 adf61e73a8af0-3c1110784f4mr11625702637.67.1783980725786; 
 Mon, 13 Jul 2026 15:12:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:a109:b0:3c0:9c18:d5a6 with SMTP id
 adf61e73a8af0-3c1110784f4mr11625679637.67.1783980725304; 
 Mon, 13 Jul 2026 15:12:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76116384eec.30.2026.07.13.15.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:12:04 -0700 (PDT)
Message-ID: <c3b3b70b-6950-4a5d-80b6-86ab98dab804@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:12:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] semihosting: add ftruncate helper (to be used for
 hexagon)
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <8f1099dc944079927f8709ec8156eb76c2c04f63.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8f1099dc944079927f8709ec8156eb76c2c04f63.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyOCBTYWx0ZWRfX+IIupq1HMvTH
 2wgjWICNECkJ2R110a5q/ufG4wnkjahk8UiizMUGo3rPkOZO02baGktty74jk+MawvBPYORVA4t
 AEgXJTTqHK96HVK09dxFEIoKp7WRmck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyOCBTYWx0ZWRfX2bB9uvKWWYeh
 wyilp6IIcnwevPspPIb59BaFaXd92jlylc9o3MZRkVpHd18WVrbVf0+IZxF3MJ/L0zqx3tYnfdn
 z3JnM1vnjokmXEaNLs3fb+Jh+uRptknYeGweWD0n9LLZ/iJGnG63ktvNQYoW/J49fgqlZChnLGW
 PKhOhYMCSnZu3VF/ur2KaoN8SbddsZxQOBpDUqcV9JhjadsVh/obniFmY2cSh2oHyeeCT2vM+50
 xWyLclFu2zIIORHFUkIwZQ/DPyQU94AOVLs8jkmWgpbb5pT/MqRGXPBmgo/Sha5MU98qcFwVtKy
 SEsbVr960dMl9obD/+wvCwOA53u0v/1YV22ouOgKWhhBSkX81TN2RlbqkqEVl6AWRXN3dX/kPL+
 mvVF/v45QDeKzi9UgChUZvx6mVn6GikhTmn19EtnUsxv457QWBWYrAm1NjLh7S1Mb5UyQeudvmx
 TkOBE9HsjrpOOsZyujw==
X-Proofpoint-ORIG-GUID: YDBB7fnkcVVM-pQ8YSbKbWHvsn_Y7Gxd
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a5562b6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JgIzhNMTC8FFGNfq22QA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: YDBB7fnkcVVM-pQ8YSbKbWHvsn_Y7Gxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130228
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> The common semihosting syscall layer has no ftruncate
> helper, but the Hexagon semihosting ABI includes an FTRUNC
> operation.  Add semihost_sys_ftruncate() so that Hexagon
> can delegate to it rather than calling ftruncate directly.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/semihosting/syscalls.h |  2 ++
>  semihosting/syscalls.c         | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

