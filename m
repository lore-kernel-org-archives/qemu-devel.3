Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D0606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qabx8yVF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fUDR+f/D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOfG-0006CS-Tt; Thu, 29 Oct 2026 07:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMOfC-0006Bc-7n
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:51:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMOf8-0005oi-BO
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:51:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vVpA179464
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zXhLATY3CxdInXoRKtibDbd2u0oMchB2+Gkoij7umRE=; b=Qabx8yVFUzBFi2Kw
 C8lVPVoDBjgCsEoMqmboe8n8jKTPLhLyQzdnXIoOJGPrEbLpHxnmh43cSXSaeGUm
 p7uSpyGx/XuPXXG/YWo/1BlQtjHScbiEZhV7HqL+pn9sXtZQfuATQ9QAwfMNoKvt
 aLqvIeJ/aixkpHIAvDlaiQjmyJX3UnF7giB2ipMRsKv0lQT4OQQ6nbxxIfivlpI3
 smwa3VC1GaIN99PnvwgGLBUQZsahnV9UgFwS1hadxVrfGeoHPlkyRBA5VKL2XesX
 AjsbUlIeLHXU04sWJRftHeVk8D1+xR/HoY1rCsMBtRItoFP0c3uCm03yRZD8A/La
 SL6Nww==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc3cub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:51:14 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7cc10da5ad4so458723137.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793274674; x=1793879474; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXhLATY3CxdInXoRKtibDbd2u0oMchB2+Gkoij7umRE=;
 b=fUDR+f/DHWEijy6Di4JtiLT102xYmSqazwgStLRzAqh2O8tPJQE2UlyDbYn3SDtjJS
 TyEjxCJncoWYFNiGzAUkfh+b9P8CBJ4SKcd2sKAFggFre+wNRkbiS2/oms+vUllR6Q06
 UpfYrsTdk+uzSEzZi3B7Qe8sPjcrxjFdGRY1SkHBeyJ8uA8xTlcd/JKO9tSWYve1AVYh
 n6pQ3R0UJkayickOwS1Ud2/1UfdwKoWgflfRSNuTxPGLe14VcyTURI/nFV3pDlfRFjWL
 iQ9ACRrAL3CGoPUQTVYwZNtMYiUigrhMZlDjz05jd/pBtmojMtVRYIHaHyCDjCfVBONx
 sw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274674; x=1793879474;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXhLATY3CxdInXoRKtibDbd2u0oMchB2+Gkoij7umRE=;
 b=HdYnObYWEGo7qgPxD6fAkTFxq0Sxd7zGVa7OYsLQt0i7R5CwOUaucdLyTNCiJINKLf
 Fj9sNnT1rPnItOS2DrlEVvCJUA9ILzNC7TsrteHAtZ2wr8WneZMo/EURVVNoRkGljFG1
 GIhbBvYuOL0+r43iLo28UKni/hF97Wa21HL6f3r22/XCljd59Ut9EPFodEo5GuO4Giug
 QnSyPrrr7nB5N9Aavx45oXG8iNpKipNtrfTkLS0mlq7Veh5j/w+45nCnkqQIESf1NlVL
 auP0LyKHUMTDlniQkP9xaF8Yz+4PJeP8tef8KaovAxv8K8VdB1mXtWmulLvLvGfR59xY
 xYqg==
X-Forwarded-Encrypted: i=1;
 AKwUvByN7TFCCVAJOuGhxQYxg9ZHSFdp4l2Zwbj2TwIOpJuvnVjVsPmD387lBcfr0BctxMTp35/U/3oZtKfN@nongnu.org
X-Gm-Message-State: AFq9FYI7p5UjFd5APPKH6RGkO1z/MWSZNZokvgmkzV3BRA0mJ3qCILqi
 raEuEcgImUOxVRUODPdkgGQ137i9lhIW7rD0IIhl7sz5T/xJnmJ5/YPmkd4FjkVyHDafOf+0VuC
 Ak/j9m/pl87ZEwn0rnO6k4bYygxnXow7CR/udoXtrWwBfxEF6ZmNoLdKpgQ==
X-Gm-Gg: AYBFou3Klv7WkKcfY2SilWf90+kmg+XCUC2zv1ZOpdOzujK1BIiTGhw38xWiDl5UMrq
 vN7LK2dQ8K1BA9qtQaLdu4LtbkD3F1e6cIIl220FWKd8zJkUxXKeZKUuI1/9JF0h2393qpCIlg4
 Wh5PfcULBzrxa2NVj1s4MHFj+/P+emd9GcqF6eSDXBSXN0U2gu6Lil4j08RXeB28NKR3Pr2Q9PP
 8JCCZ7762OhbtSVxEjm1exBQbcKSaQ6aheZ9T3YjIgK/7mxdMx2wYqsTBLD5HzXtDWXaj24qyqd
 kqnMrAvhloBOMfnkIr27WgshpQSdP97hv34jcbtm5OOjAu1iwsmGoYMcN8b6RU4uE22cs6Z3sp4
 9CDjm4kOl4rbqgCgZz8p1d7dDQDd9kPeXsvx5hufaeirVyN0HsXWUfj2/LZ5QBN3Ou4NOy9dAE3
 VQjx9+cObKK3QRxM1eHHO21kw=
X-Received: by 2002:a05:6102:80a6:b0:7cc:1f46:65bd with SMTP id
 ada2fe7eead31-7d03a55cb8bmr2331673137.19.1793274674152; 
 Thu, 29 Oct 2026 04:51:14 -0700 (PDT)
X-Received: by 2002:a05:6102:80a6:b0:7cc:1f46:65bd with SMTP id
 ada2fe7eead31-7d03a55cb8bmr2331656137.19.1793274673549; 
 Thu, 29 Oct 2026 04:51:13 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8d5sm35816260f8f.28.2026.10.29.04.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 04:51:12 -0700 (PDT)
Message-ID: <527996d0-4a94-46eb-98d8-23ef795dea8e@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 12:51:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qed: fix incorrect denominator in qed_bytes_to_clusters()
 (CVE-2026-118594)
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, oxsignal <awo@kakao.com>
References: <20261029114312.1502759-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261029114312.1502759-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae33332 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=FEb2vtIbAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=KmgiNEmUdGjwIXoRk7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: MgjwreH8aSSgJwINiS-u66I30nfBS3Zy
X-Proofpoint-ORIG-GUID: MgjwreH8aSSgJwINiS-u66I30nfBS3Zy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NiBTYWx0ZWRfX9DK0P3v16Dnv
 pSAVDymApCnIa3vhatMgv2Us0dd/AJDvksrknfrT5Jowr4LmiyLsMHujjM9r1EhUDLg4zp3t3Nh
 ywBy3ehKqekb65ra0EuQdRTSXamtJ3t0wEuLzY8ICk8+R4lBH1gkmLyH3VPF0MJ0OIENompgJ2k
 bUgrx3+rH0VsljDEGLqkJLoVo1sqlB41T9WTget5K5luu0Tu1frVGyg3Qjk1beRUFe/fcslHDw4
 IVZ7EIDrS9PjWJLgi87E9CzVRp7W8rUgdgpiJ/C5rkjHEfZe6gvwAYVlVz5JT/9vGqBWgAExXAa
 T6TZBZsxBagdDmcmJZA8LON2auOpdgxiBHPbCxiQT5ywmTBh5Fr9c4QmddQ1CTjhGPESy+w0/cK
 K/78Ywv24nGaGlhkcWIYIrVY86yn6pCq3npag2AXA0kcJODooAHk0FRf35jEDu2nXfwX/hFSEMT
 Hy8BeYYIBID7rJczdcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NiBTYWx0ZWRfXzjwc3tX35eui
 qje5YHHpJN3rGh5n9wAVpCC6woXd4yPSH/osvcxHZD0Zyo0JLSeCmP1gdt+EB+t3s0lDF0IpSVb
 LCFfbeXL6zrhhs2LxKTXyqTekzCSG4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290046
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 12:43, Stefan Hajnoczi wrote:
> cluster_size - 1 is often used in bitwise mask operations in qed.h, so
> this bug is probably a copy-paste error. qed_bytes_to_clusters() uses a
> division and the denominator should be the full cluster_size value.
> 
> This bug can be used to leak heap memory to the guest with a QED file
> where cluster_size <= 32 KB (the default is 64 KB) and table_size = 8 or
> 16 (the default is 4).
> 
> Fixes: CVE-2026-118594
> Fixes: 298800cae72e ("qed: Table, L2 cache, and cluster functions")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4737
> Reported-by: oxsignal <awo@kakao.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/qed.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

