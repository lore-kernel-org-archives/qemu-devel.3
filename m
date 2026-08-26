Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9601EC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIpM-0002R9-0W; Wed, 26 Aug 2026 14:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIpK-0002R0-PC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:58:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzIpJ-0005Si-50
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:58:22 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGughh1408689
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7lmloSZLQG3/b881nQZqHW0KWPBFeIBNtuylNVkdMkM=; b=f1ijBeY2o9pWA6WC
 KMyC7GQ+anSgUepI/fiidAfXg40FPGYOWXTFf18KeDXLd/2phBlEJB2Xnv1/FHaI
 +D35od2500NTJbLjj7daxo9qFUnQXQ2ksSrFo6DdKUbNZ3LN862do4Mnvgm7zZor
 FTABmOS5KzWKcgn+qmHt4hN8m4pTRh64mRnm4MzwNzlq5qeP4A1hS9IctFRSYSJn
 ysGlLg/CYGyl0Ik7EkyhnoeBJ9WHKjbjLZpxtoJ5Lqvcbi4GEup671HMx46asSbA
 TVy4djTZ4YWYk4tusakjQZNTRLtP0ADc7Ftfxvy9a47Z83tJV86rR2MnCMHAVGLz
 SVnqgw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9x2n22up-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 18:58:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so13557771cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787770699; x=1788375499; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7lmloSZLQG3/b881nQZqHW0KWPBFeIBNtuylNVkdMkM=;
 b=i8PQBbq2tYVIsR5JGgoqwsrwn/CjvqCTCYBD9GczRwfobtoqgZRJ14OoTmd71hSj0b
 Xyvm+6Su5cAyygtj/nGureLCFfUZUqoEMS8qjp3tXKr1DlxfPuXKKMH5Va/RH7bt/XfX
 6ueyL9abAH84IvN6UJTX9Ad0bV+7etdHhY1dvV6vbjWcCFpMmUmnItn8bDJ5lOD68Cir
 a1LpCDgcYbqJmY1T5qc7R8ruxb4DJL8+ph68cfT0WX+Dc+iEdnO6L+62wsWQuSwk2drg
 Y7Ir4kvrduSZMxK0icDntjP8pi7JHVS/oaw6Hb61XzRuTj34hU7Ewjb9w74kW3/y5G/n
 NMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787770699; x=1788375499;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7lmloSZLQG3/b881nQZqHW0KWPBFeIBNtuylNVkdMkM=;
 b=RpDeVJLHBwmIvFBudMiCNJsdUxsdob0h4ZTlM1k25KcLk9Xjk4FqBhW79Gi2ocbWmu
 YNV0px0ZPe2r2ghAA3TmvWRKPgawdoAcoU7EnfhuYyHOJgPhBikIg2On2wTcvSjCDv4y
 pQXvKJ3q42klY72UonH0ek2HdAJtMIQFiGDE1do0o2IowpJTX080HI0i3Ftr9qJ9/olk
 duapE9Cb1pIcPXCTEW5sXq9DYzwImoLQFaL3EuNx6S7K8yyLhWpde5BdcdpZrhq3kgOu
 98kfDISaDMxzB/LkNxzuKl3dDuC1ej6d11HocUbUBhBF6Jxs3YWLZ2KsINuNcaQbLBJq
 ewNg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1izXDZUG5WGVqBnHUiCneLPAg3i+4bz1mIwsgHU8unTAAAv6J+lsBsrNfTeH7p2QqofhUmpo+JcVd@nongnu.org
X-Gm-Message-State: AFuF++mq2EuaXEIU8DgBmn4vjumE7YIRtljfnh2ED4Kx+E/IieS8bcpL
 lTJ4alhucJxXVNV18i1+TjxBC3ga4rLcsUE0c/Xxz33rX5Zk5FWpuxzsUh0cfCMO6VIX15jS1Ve
 LWCIlaZ0MIouB+2pw7Yl00uCEJ3X1lhX22J3k/PlWu7jr0ndUv2x2D5RS1g==
X-Gm-Gg: AR+sD12qTwOJDJa8ZCMyeDVkd2UbyW9B5Jeo/7rv4/q7k2q+NmV9VlG2mh8X4iGM5Wu
 9Y64bhI5GFNrOjCROkaDulzPXaPRfpE8gpcsEo0akRplHBTo78KJ1/E8y4O0KBLQkWAydR+3UJc
 sfeXn4FZRWLZUeXZUgFncTpszJRzy0NSXJ0aTjRQv2g1FsNmBQc0nMmX0/cXh8+DM9PqZ4JHqU5
 LBZApU6IuS1uf93jw6vTQkidTDsvJn8nAkuysLy9Q9EEUqZYtAuDlqDATYBfibLZlI8NuX8C3eG
 H4pTs7LvpZz8UrYDRrnHi9mujS33BwMB2Q3bNvP88/jEkij6W49Y9fWLonlEkeWyPk5L6O6fGgv
 Yrs+R8ov1XyECTQURGkbSjWGVqbysoquBUuWH0mhziB8=
X-Received: by 2002:a05:622a:8c9:b0:51c:92a0:b2ca with SMTP id
 d75a77b69052e-52e423a560fmr111050721cf.34.1787770699100; 
 Wed, 26 Aug 2026 11:58:19 -0700 (PDT)
X-Received: by 2002:a05:622a:8c9:b0:51c:92a0:b2ca with SMTP id
 d75a77b69052e-52e423a560fmr111050281cf.34.1787770698632; 
 Wed, 26 Aug 2026 11:58:18 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a730307sm528181466b.27.2026.08.26.11.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:58:17 -0700 (PDT)
Message-ID: <b122a57e-7907-48f6-b00a-5eeff6961b27@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vapic: confine the VAPIC region to 0xc0000..0xe0000
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260826181552.848617-1-pbonzini@redhat.com>
 <20260826181552.848617-3-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826181552.848617-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5qiZpBTYQrDbs3sOmr8aC_1YxNWN6Yno
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX+zeYWx5QntEi
 uGYauLnPeJo3gPjbXH1ATEfU38/Ib7hHNW5B2Wo++uJkQ6yk41+rl3yC0Zi/r7fi6fufCNyqo81
 zuRavUjYOoYsXPLewUJV6+Y+0sCJ4qw=
X-Proofpoint-GUID: 5qiZpBTYQrDbs3sOmr8aC_1YxNWN6Yno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1OSBTYWx0ZWRfX1GpOoCYhMcOF
 kRx14KhHgJ0kkqrQdiMQSJ4yHcJVkmMJxi1AOReDHCRQw6QD/s7AvVDWXRs0uQeyAGEKcaSJmeJ
 MwXRCcp2XqlxLlZK+W21ppPffy19jLI60gKhWXWyDgDQ45H2YLquTafEuxny0c6Bgf6/Yyk+iTh
 tOZrGi9PWaJ+gSXBIEHEPOZSLlavDhq6UdyBPLNUrqF1UCUlcBO8EPR7H7dNp0cu8gQnAdiq+hN
 S/rbjGsNVx+189cRY4dVeqr2WrwEKW7/+5y8tPXgZLG5a54Zod7sMmsm7JVp/4p67TpfF8h/r6o
 sKMIetsalhuuoyKsuLeI1UGtrLkkqVjYPV6SSCCwGYnj8JxsvMwX53+8X1sUex2T1vniaQg6t6L
 16FJSInBO1+E75HKE+iNwsP/Wa5iXEC1G+EKE4XBih2YCkS09aQCx6Wsh+ceJiXiRKZf/8FCbr2
 3WvbP/qZp2LcNbH55yA==
X-Authority-Analysis: v=2.4 cv=PPQ/P/qC c=1 sm=1 tr=0 ts=6a8f374b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260159
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

On 26/8/26 20:15, Paolo Bonzini wrote:
> The VAPIC region is mapped as writable RAM, at very high priority,
> above existing memory.  If the guest is allowed to map it everywhere,
> it can overlap PCI BARs or even SMRAM.  Ensure that the whole
> region first in the 128K of low memory that are reserved to
> option ROMs.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4206
> Reported-by: Artem Dinaburg <https://gitlab.com/artem35>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/i386/vapic.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

