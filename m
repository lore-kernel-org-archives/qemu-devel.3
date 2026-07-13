Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622E2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOhF-0002G7-An; Mon, 13 Jul 2026 18:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOhD-0002Fh-0m
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:00:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOhA-0005b9-P9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:00:14 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9AX52519318
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9h6ZLEtV3MPxQSeo29efMPQ1A6SN92vwdj5cWigShzg=; b=bGvckLkx3JBce1DX
 7JaNs87T0khpH6qpVE8TkynY5tffG1Qviw6Ze3fay1Liax1tkfGQJpOCKgrzDE7d
 FignjjY6i9axwODOoQTgNyeCNNxrmGHcWA7UnWX0m/M781faWozAiztXQPEDJJhw
 V60XfIqSibP1zw1IYcu+qU80QxgZwXjraK5Vtst6w61yVkHBknPPnyqZKdV7feXZ
 H0BM2So/v/itEKAxK11q0q5xYul1aiUnbuq3y87AaMlCjIjSEqxlauB0ZMw1v+It
 m8vY7vMzp2gnj4zccofGU8N8UkJ0hlN/IO1eJPx8kTPNZOZ/j/baaup+ZnNnBRh4
 uacs7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44crwrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 22:00:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381ed6616f7so5894097a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783980010; x=1784584810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9h6ZLEtV3MPxQSeo29efMPQ1A6SN92vwdj5cWigShzg=;
 b=SDGRwmGhcXQCsLS2H+Zdm8XxcQ1OL8kMidxSJ1u1mrkkroOHMtu2JQICtJGRPeGYcd
 Gq/arUj3O6qTK7ozEaPdEgNb6AZY9bogGKzibQFu4JNWTsfXpst3Go2KMlpoB1t7alo0
 q6rzIIeI98ta/9XKs+uG0oyTSuLzb1VDfkVfCjihtJwGigcO+u9GKCrA5qFSrQd5G1JD
 3cHvM9UXQ7EKWIn6t+2LVHQSOQMQoD4i+uKXlt37f2ROIpRBWhSSYwCg/BiEbXLR/yRh
 BwyAlgfc/wTZn8jA4YrY1seCODN/Ddf34RPUz1GtnhjvxN/fRnzJalYh7x/vguZ+7+Ge
 QYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980010; x=1784584810;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9h6ZLEtV3MPxQSeo29efMPQ1A6SN92vwdj5cWigShzg=;
 b=o35WJsIoIixDzFRTp1Ec3U+jixnuqcE7ILo9hdmnd/cL6vM5/ddrwpx9jEhcOXQV9/
 +gY7c4ngQnsQ0goFTk63GRACVzVJPG7XAenX1H5PIyRc0w5Lp9cRZLu6pllJyX/S8Mu8
 xmpDLCj4ncTXYP6QvCayEsEmSQWeOPaIvTM/bdYIzAyHCzfRuWDglxB5ot0+9XTgss1I
 s892XaKcry63Is56/IIvAxmxTUJbz8fqGf2mW8dp6mUJjcYtdCNVDSvOixBatutj2joU
 IcTYdfNQ4eHeT8XuY467jv7ivb/gjc+TBMD1ncPEGmmLoYhrzDco4xIeHzTIEOTgkeYJ
 UCpg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+vczcYNZGpnQIfNvNaoLY7bk0T2ZEP2guQBoCoyQbIuKvDNNrfrmXAmByDww3+Ccp15PsmHs5pEEv@nongnu.org
X-Gm-Message-State: AOJu0YzwZlWGFsJjiL030nwQYGxOPgNs8Clvw7p8xHwkLqYFralLQGqa
 cfug2Gr/MvitXbxsqCQXLg+glnBvHI5XaNPKuFPznLx0byH4OTRAeN7NzTJUce6vDCKMZlQwSkB
 P1Ksx8WaUT4Z/n3YnWs5GQt/XbMFEObZDwr24wp/qXzsx/HZB3W9xx8GkIA==
X-Gm-Gg: AfdE7cnJDMIj8WBZhyXVKE1Yxx5+4zqsNGrQkFcv/UAjVjiO1g3r+faQmYfvh9MLfeE
 uKcfZzgj/AAgrV+pPPLxIl4kiqStlcgW1nv0jO1GbZ4vgeZxfm9mfrph59C5IaA32XhPrJay7Bj
 /8I7r3MRIrxfzmsIq8MtrU4TvLW/0Q/S0R2NjcD5eXX5/PNkGxKaTXuWhQfKvtYG3W9eaouTGHv
 45nqNd7bmddbqzHDCrxgpr5DRv7QXk7YDvn8nfyDgoHeo0RBnj7dndPqhYHHZ5NoGJ/RPyeqVi1
 ftYKZKFaGOy5IU6lF022N+LvIF66IVDCcjGLkPxcfNVs2Rut7tbQx/WWJw8AaNj/2/XI+eTfvon
 VWkWfpSAnLwzZGYrxbug8T2zKya4idiRzckRfk1KR5iIiFkWBc11FmSHNNGTMWEu4rFfS4H8QRa
 AL2ic=
X-Received: by 2002:a17:90b:164f:b0:38d:a150:ee04 with SMTP id
 98e67ed59e1d1-38dc77a2253mr9924698a91.30.1783980010036; 
 Mon, 13 Jul 2026 15:00:10 -0700 (PDT)
X-Received: by 2002:a17:90b:164f:b0:38d:a150:ee04 with SMTP id
 98e67ed59e1d1-38dc77a2253mr9924659a91.30.1783980009596; 
 Mon, 13 Jul 2026 15:00:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b0240570sm40618538eec.28.2026.07.13.15.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 15:00:09 -0700 (PDT)
Message-ID: <a90c95bd-8364-421f-b5bb-386d045d8e13@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:00:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] hexagon: cpu_helper: add reg reading/writing helpers
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <636d47e381c5370c38c058f324c290c39265b10f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <636d47e381c5370c38c058f324c290c39265b10f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KwEQLt5Z5qf9ZhSRHHudyY5sKTyQ3zMI
X-Proofpoint-ORIG-GUID: KwEQLt5Z5qf9ZhSRHHudyY5sKTyQ3zMI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyNiBTYWx0ZWRfX+V+ZCTtylyKR
 jaCkalc2vTdiwiw90rP38wL5KMxBHxQzrKOxt68ph0zNwVZdSjoKSYc7gMkLXZUO9moei6Y6HqF
 6rQxGm/+C6LoHMr3U/eofE9f05Wc3TU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyNiBTYWx0ZWRfX4PiyuVVz7JWA
 SVM/mk+gIERgPsPKbzP048wTlONhZ+etvgGmW8zE+EdSQXhj0Lx7QRNONnl5fvf1k62ZQgLHvuL
 HWiA2GyGITAMctf6Nwa4LzJWMJkJad/biR4TXV8OsXOkHR8+9I+u4UjeIRiWqRCyjC5dUnmYiP6
 0BZ68QyoZtPVG/1a6W75vVKkNPa6SeRncG0xk23lZoMU1hydP+pA9tAWQ3PQnJISikwnUXLDid7
 XbhrRvCt97JHCeO0KYwULX8lO+gDVrLr/kPIxw0km6kcIR8Y11/S5RS3V//YzZ13IJ50k+qQoF9
 3C1/0VCbGc0QWgtYzssoeaZtaNrnc4vcfrDyrYXYlGINIhkov99F3ehMeNPewhBiAz6C//9c/Xk
 GSmCwFiB2XBVgC4q7hUYFFrKfho7skuAxvXpCPQ0mIIO+3xogJVM5LD+ou7vvx9QKdB5s+TZp72
 FxMyqwcHVYcMg5UMRUw==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a555fea cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=416cMAK6EGqak-BtVJUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130226
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> And adjust op_helper to use those. They will also be used on upcoming
> semihosting commits.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h | 18 +++++++++++++++++
>  target/hexagon/cpu_helper.c | 40 +++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  | 18 ++---------------
>  3 files changed, 60 insertions(+), 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

