Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F98606A322
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TbVSiHh+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cvgKRBaQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKi9q-0003xH-PX; Sat, 24 Oct 2026 16:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKi9l-0003wZ-CZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:15:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKi9j-0005tk-Uz
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:15:57 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OITxHJ2873328
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q11J91AX8oOj8GtE7IWU7PcJ0Lj0BKvC3fFmLoUTKC4=; b=TbVSiHh+PH3BbGCh
 OXd9Wd8JYzDbz35UR6+QlSHF01d6RFJWYgiLrn5RJ/CCw0PL692pypCYi2Z5ILzt
 a7E8go1a3L6pBeq6vQY5TY1NCiz8I6OKglsuMIjhn2XDSEBCJlp4YjgxuFo4IV5n
 L2RddpfkDR/dOEFqr21ivUBMMb56mkcvQp5Gi48SrIQGk0/nTCGOlZWao0ZLrDF3
 jUCaepgh6ffJNVUQ/hde0e29//Utihj8fR5+y8zR4bVqiPnOn1YwNzzhl3BcBt3l
 jnaWRHBt2NMS0Wg40AM0wTUlrgLbJNp6ajNwNPb9KXOlyDnhHi8I3R+7jkqFkYn5
 nv6jLg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xhs4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:15:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso2849028a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792872953; x=1793477753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q11J91AX8oOj8GtE7IWU7PcJ0Lj0BKvC3fFmLoUTKC4=;
 b=cvgKRBaQcAzYtv+LhwNCNtYad2SbEbCY6xSZyY6rs/VddHF6Vd6gPzBW2XbaR2gN2u
 vSatGKYxS9eNUlZ59owYfQWkiq8W3OvhJt+ahgFu1k5exZL89C8w96bl6nEdSusaEdRF
 q3d/bYsaZJYj50pXohGt1mGJlLwx8OxEDimuN8pMps6vf/lQkyXaBHPaABnb69H8//ps
 VbTG3whF1veQF3PLiI9LR4a1G1bWIqGkouW2VXyW3rv8xSeGoTnIDk3lRavBvJf4EAXe
 InQ9Hvd2+EVKpndQoxExHgGPCIXgnZYINjm5Kkl8Zm/093ST2oinTLOQBBJmF4vzbbyb
 dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792872953; x=1793477753;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q11J91AX8oOj8GtE7IWU7PcJ0Lj0BKvC3fFmLoUTKC4=;
 b=PxgTUOzjdFFNjAG2Ilf0wTi3w+yleDJAcaAe9N6/gctr1x5ioZNsWW3f39bvHpmQiO
 z6p60t7lnGHpO85/LvPzCFn45LELJa+vHb6/iHTwe0zXtWi1nY9vjniuJwZayd62l/iQ
 fpLxZ/iZz/vZ9Wns5g5A6T+e5aAYz0vZmWWuS5IDJGThv1uJYMZ0CNPPnRYaXBR7sGGz
 0G3hmY0uHC2oaAxzplfSANz95HCFiU2KK6ujCD6qdZF38aMo5dTASYm3PRQv1KYgVW65
 5Q6hRsMl5HbSxt89tHfwYCkIpqMDEGDSaFxnqMo+N7uZGIY4VToDkBCkNZb4kbyLOeNx
 vx8Q==
X-Gm-Message-State: AFq9FYIkV1jNvP4ie5VgBIB5CM91/ozO6vrpwqexuVOmoWrIy5Mjih4K
 mrZG5GIEbSneYna6DvMFojI89E0JalRZmW4ltAmAXZrwTVkg9UTKhV0uxdbO3E0ZDTI0SPEI1gL
 CdBUxEeLYmY4Y0fCSIHxamCYHT73Qk673/5T8aRZyRZOSLCjWbD92itCu3RyImMwdvQ==
X-Gm-Gg: AYBFou2p312NpmpduUXzBeDRf6KYomHp+6NrsCiWddgdB5d3M0zW3M7s7zC4YsYS1OR
 LWpT82XTmzIZd/TrcSlE5KSAvRBA7pDl1wqN5ErIFbeWXfbHOsqctpChUeuQ4mHUNwpBsDeSdFb
 fbhiAlrak+grvHr9im0Rv5bDNxP4Sr3/awiwk8fiF8y++vUXyV/kfHG+qHSZfo25XVGTes9+BVi
 zeHj5WUpFnhjP3nQaVW4a9VhxpBouWKHPWYZ7B/qu9a/d3LQDMT+iPJFKXBk09oYpA+jJzW2zPN
 dXw75Z5h/dTM2wi5G07yJ3slpL6Z0qa3K3Oml/KHu/5HGf3fNNBVWBHZnU62QhNKHOOhx3A9O5q
 2P2AMqvtc7bBkFdA0sPpuBrd2S5WkLFjo0RCA7l/SKCa8xqZkgr1cOBqK
X-Received: by 2002:a17:90b:582d:b0:3ac:c024:b275 with SMTP id
 98e67ed59e1d1-3ade9b2ef33mr2412570a91.9.1792872953471; 
 Sat, 24 Oct 2026 13:15:53 -0700 (PDT)
X-Received: by 2002:a17:90b:582d:b0:3ac:c024:b275 with SMTP id
 98e67ed59e1d1-3ade9b2ef33mr2412557a91.9.1792872952994; 
 Sat, 24 Oct 2026 13:15:52 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8cc9b9148sm607423a12.4.2026.10.24.13.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 13:15:52 -0700 (PDT)
Message-ID: <088ee63c-3209-42f5-a692-bb631ce8556c@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 13:15:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/20] target/riscv/kvm: restrict kvm-accel-riscv-cpu to
 riscv targets
Content-Language: en-US
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
 <20261024173649.7405-19-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE91maBskVqb=3XYgjQSAZ3t2=T51DWg01C0Xbs71oRBzg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <CAE2XoE91maBskVqb=3XYgjQSAZ3t2=T51DWg01C0Xbs71oRBzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: D2MXJ_C5jfzQDP0du8vEUfBmrVn9uCmg
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6add11fa cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=RQjOaUW6c1SfanW27tAA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA4MCBTYWx0ZWRfXyXem6HpjcwBy
 u0YGcBFozaKyqtMW+BKvN4JX1RxGjIkuh5uGi5t6bJpcJmEc8DgCY9uC3Ekd6odIVYVvDJiCAOS
 JBp0lDLNNZB7RVZLnjqRfQR7f5HQt24=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA4MCBTYWx0ZWRfXzTg/ZxNsPgWJ
 CIlDWEERBHZ2HitCpVbraPHlEnn/ZeRhhLVTuLTeXCItJYJTCEsVvLg8MHi9mNE7bpJxrkjnk6p
 v4HzcxGe+IC5iyNb+sE63zWKlT+dyTLN8qka/q7MOaY1Vl8uLn4YcsgAhKP8bo4/BYoewksYXsq
 VLAXlRU/NJW1nlBa97cv/Ivi6DXWbXSwztatG1azTQHf8rLWdeqqAfWXGcdyt1PPK83qp9FNFVC
 BECzb4M/+Cn8z4RRFPo7n3XYeV47qgD9vxl4l6xFg8pA9O/wchi7uSBfh4OeMFOo6llkU/Bug22
 4Pi7xksu5nZdSe1X0vpxz5sWoviszHoYZs1LOz/meeTxgGa63Qf7uOZJedbVuJlMpWCtHnNZs3Z
 F9mvb5C2VWT4UFmPlmO49No4ZEWjPzPnB3dWaFgJEppzOQK49hEW5/aR9Zot+6iEUz7Iw+Cjxb9
 /GGtBbV+P47GuBuUhhg==
X-Proofpoint-ORIG-GUID: D2MXJ_C5jfzQDP0du8vEUfBmrVn9uCmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240080
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:01 PM, Yonggang Luo wrote:
> Hi Pierrick
> 
> Sorry to bother, but this has not Review-By yet, is that reviewed by
> others offline?
>

This pattern has been reviewed-by for tcg accel cpu, and I would like to 
move on with this series.

I saw your answer, and mentioned previously I would ignore from now on 
any message with inline patches or external links to branches or 
patches. So that's why I didn't answer.
If you want to send a change, feel free to post a series with this 
change and discuss it there.

Regards,
Pierrick

