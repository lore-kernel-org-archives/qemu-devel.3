Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7577C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ax2-0007pP-Gv; Mon, 14 Sep 2026 13:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Aww-0007ok-5T
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:58:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Awu-0001JM-GC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:58:37 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED1GqZ1204566
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e7DRZ8kY1amwdbNYG0WiCN4Zt//XaN0S5i9RPrFIOcU=; b=oa0nvSZe7oj4QAoH
 hrJs1hCFikVMTDoL4JjwEC6SCjDBaL30G0hfm6pXICxMuGBFgbQK1efjql0Kt4Ed
 +TqSujLZqIrMBCddaiQJIH+7kOj2kAnHyDLViOceuwup89Lt9ucCvvDtkUiB2FMI
 LEV6qhrUNOKNeGQi7n+7ikRY+h+wO72dFbh96Rw8Y6zTwokDJOap/PPER1/4knDp
 v5OfYVSz3S4/37exYKFwDGpqIsJuPdZH4Vg+MuMqAnbPVVsaDgTWvuJsXZsqxIaf
 xZD+tzF1RwffWphdfP3VMysLAhC0cxcvib/aEtFF2X0V3DwOAeUdg7bX+mJjdmR0
 kyHCyQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevt9n8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:58:34 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6a313ec13ceso5363878eaf.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789408713; cv=none;
 d=google.com; s=arc-20260327;
 b=smoUKDUvMlD3QFTmcmFWDFsxAls8pU/9vP3Q5SO6t0jUho0DHUNEQTrLr1QsRomnp1
 N7CuXks9QCPTc/rsjYAl+1n0BkMCh0dXblpb/ihywoatOVfHUHsGjRlet2EEGbg+1tWK
 54rV4OX/J2K7TohhjIGyC1zKZ6otEVPG4iuaVUrPNREB2Z7di/pox1D90492YVn51Rp9
 jBzy5WwNHcWCy56qsHH9VwzI2NTjzfvGdMtmb5FBHJjaTQdAwyWnOYG8yEjsCBLcY1L6
 lUzHaIkSfMCx6nKLCr//ivHdUG9aYhj4yzZ27i4J8HR1JZ070byPFlY688TEXnYDqsdB
 xdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e7DRZ8kY1amwdbNYG0WiCN4Zt//XaN0S5i9RPrFIOcU=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=jSvXNDDFikzuaFf5nrdBsvBB/isxexCRf5wn9yvHXIqFFcsU5E/1mZv7aYustrIoQo
 h6HFJaXVVW/Hkktsa9e1OBEbhxo27Sl1IKa+fjfbc9zukl7oIiEvKn2/elC75U9FgvSH
 9jFF51GBl0wraCv2Wdt1fRhGuTxMF6bxhupfNSYSTZ6MBJGUe1DiBUL1NdlA1jijCD6x
 PDGlrpNbrjD4tXRopBExn+iCb7+7xw7dyNFr5e2OvqxqV309Ip4UODc6SFyqB7wIggRt
 RWlU2faPf7AdNTgHQiGhJ4yb6OrtgI1HKONefiNOEzOrjvHakA/Yf/w+t4715/ocEDyO
 2lUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789408713; x=1790013513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e7DRZ8kY1amwdbNYG0WiCN4Zt//XaN0S5i9RPrFIOcU=;
 b=UgUla3zhEbA+LYV7MRYmSkrWaCy1INps6szJhQ+kL2VHRUljKmCaFZO2Qb7qgqxSg7
 E0vezxHpj6HRPo7vJ1XuVLHpwaLqw/Z6HAXeWNKG981rQMWB+8PFKZUF+O09VVj25aat
 1pnLmd0nnfXbpWxRstkySS6noMX/R54Sti7F8XuIEy90hpbHA/m/oPZXOSlRftSGprXn
 OdcEiv3KipkHdJl6Lp+E4aWlLViArPDxuuhOKfiJb0+8qayl9lchrxov0l5UvV+n85pm
 zqddFF4vTe70Du3dsHwsNNXEvoRuf+08rcPyXbTayKovhJxxe96qrkpkzLaQXJEF4dVa
 pdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789408713; x=1790013513;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e7DRZ8kY1amwdbNYG0WiCN4Zt//XaN0S5i9RPrFIOcU=;
 b=mby8VmE5sGrLkHwIiHfCt0Okbjs4AesXhJCKUulR+n8O6NmrKmhGR0SxVO8Qf+iGRh
 P4YfqiOKl8CO1DeloNKJRUvndV5XiGGv2q6peDxNLpUudq45ij8odd2PfEKc0qqz9FEO
 RX0RF8X3D1t8NBjrqMkCmM20ROv1kY9nDBcp826ic3NAeukzxCJ0bKHPfvi8X66R1+a+
 UybeiQcpxQQ1DhH7ZPswG+1hWcjcReN4u/6PApuh+OqZifG6G+RNNrfeNJOhIQnYuFry
 xoUOlUIwMMQ/EsmquRJ8C0E+kVrpbonVsyEO1vTz222FhswnXfC2T+m3DZgo4BOAMaIu
 YMmw==
X-Gm-Message-State: AFuF++lKHZk2CHVsEs25MAdRSxLKeZv0D7l40a7DbvEI8dB+6uuYZc7u
 XNjhlE87nR+E7Vo9zbvdJpbpP3r6dmao0a9bLmReWtrrvDvZbcUaJmmvuS4ITMAvpRxQfvbDKVi
 Tl9TbH8JQKz2tgxaDoGz2XtLsCeI4xI+cZHIoCyCyxYWFuZGtR2JzL7QxyhzbYNwiWCL0rxegB9
 dlrl9QdUVAFJvbMcLrWUF3ZsZbZIWB+G5d
X-Gm-Gg: AYBFou36aYUU9VIdZ9YUQtnGPoxL9atO1wiQA93nSflx+ckLToZ9+iG57rX4VYNRILa
 ndXsWtWaEibmvmDMVz5EIli8zVENgdUwz3n1iTFs8syWRW/QKs1q6prOT5HKt99bduVxkHpQqAH
 JV+q1xR8Mp1DalVDwNCOyxarbID7g4JDtIkNrYKLeeVs+d1a5Q/T8eaEd4dGc9ofUDu85Tvg5aa
 iW7+fLg69uSKwcwGg==
X-Received: by 2002:a05:6820:4def:b0:6be:1570:73b6 with SMTP id
 006d021491bc7-6c541c4afcdmr3032021eaf.20.1789408713403; 
 Mon, 14 Sep 2026 10:58:33 -0700 (PDT)
X-Received: by 2002:a05:6820:4def:b0:6be:1570:73b6 with SMTP id
 006d021491bc7-6c541c4afcdmr3031990eaf.20.1789408713023; Mon, 14 Sep 2026
 10:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-3-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-3-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:58:22 -0500
X-Gm-Features: AcwNN1UrZOQuxuurUZu1an6GMBs489662v3Qt1R0A_1YuvrhUFw4j_7tnOma_Mk
Message-ID: <CAJ+KCYNXe7ytQxfAQJipX_=g+s9g85kB_23LEGEDp4ONHiWxHA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] Hexagon (target/hexagon) Check for GPR
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5OA5w3I0oFTyHtsrx8xureu_pTKH5V3M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI1NCBTYWx0ZWRfXxWSXA82mAQ2m
 wHUm7tKC+XZAhwpwhJyHDgpg09bsygefUCq+UdifpUuw0m7BHuGjItIonw8n6iTY/q03VyknaUp
 HAyqZY2PSgbCVz12uoDrFlX0dCFLHb8=
X-Proofpoint-GUID: 5OA5w3I0oFTyHtsrx8xureu_pTKH5V3M
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa835ca cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI1NCBTYWx0ZWRfX3OKLs9NzzOgt
 JErXQaXbZBC/zajogNf8IRuoUvKbmg/WvuH4eTSYQGvmLcH+A0CskUSJbxtNIic8ir+hJnzJyIk
 alYVFOTaC58ftMnAQF9U0v8PILLrs3Qw9FzeDbDswq87Lt5ACupcqBOnrtxqmasian6pp5ssozP
 yGKuSVRUhSPNh1deDLp7rEh95Y4LRkHK9WUav8FOVCBT34eqXzrYKhLFcpyEkaq4wlyBshrXjE/
 zuj9tDNBj++IULbsD8FBkFoHtOl2mL+5t9q49Wes7D5mSyRTFbR4HZufrubw9uvS4Ncwr8+CNYQ
 D3tCpbsCG9pt1AXTYybygNULu9CfYmKAH0Z5NrZSJx/GTh7QPP/u/ZPZANtarnBokQflBORbQp8
 mgWdWgXueF0cWe0joR6JIuAcoQ5RoMuWJEBYGovT9U9S3z3FbyaEQ/vTPe24mQJosj0BDsQzkJf
 ZFXCZTqghTpfh2c1GWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140254
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> For now, assert the new method is a superset of the old method
> We'll remove the old method in a subsequent patch
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h |  6 ++++++
>  target/hexagon/translate.c | 23 ++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

