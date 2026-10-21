Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F42606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QVgkaQBP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIS+7YGA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJYbe-0008PS-I5; Wed, 21 Oct 2026 11:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJYbc-0008PK-E5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:51:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJYba-0002JJ-0H
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 11:51:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFU0iV682104
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5jWKtd3ovY9OTSYLVxbS7bhXuxkkaBp2BaDGgV99C9M=; b=QVgkaQBPdei6ZnNH
 MWBtWjW6JPsCMC8t60iEaAkvVh0lS4/Z8ejGzNXRV79JNoSOrPxaN5Weq9udRp58
 tFPcbCHdOqbMVyvzwvzze1njMhMhPO5bdvcY5rgdvnw+rGexNyyX+k7kwzBc8HBv
 wmyhsEVCTsTgbZeBoZHMn4XjdJm1amHoJNHhYgNId/u+xeQKKcDdQK9CUx9mANko
 mIVit9bvBZGb5hJBK4BDDVHdQ2ymFzO/b0ng8CHZ18uJTkt8bqGmyOZygVM3tRFX
 daAeTrIYuFfEsW2voBvSMhJgyoLOcsQQfyWaSEdut5/Seew00l6pOmKhlicvNXCG
 K7nefw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrnw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:51:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so2076863eec.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792597906; x=1793202706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jWKtd3ovY9OTSYLVxbS7bhXuxkkaBp2BaDGgV99C9M=;
 b=kIS+7YGABr3KT3eAIUUEi3V7OaDGwAANSsqIPmwxPEjiur1I4rhNkqhYJLNtNYjzLP
 tGf29it2kPaHRjXapPunXXnecYEzOBCPQZ1eURDP0D/NdF6fdbS5N/CVWQ7tnqq+C4qs
 0iLnJoo5Bwg5COrMTHWIl8uBkh1VDxR7IKkh6anAqNQFm5oylwnUoxUJNkS3/9nTqWlx
 gUVBIUWZ1x+dZlAiOrH6FlrupPCrFB90VFY447PM58ibDF+IZMrDiy3kqFEaHgcbj7RX
 zox4rwr0X3tUSd5wnHXjYIpgmNWSWdAz7WK0MU9X40nXiZddBUY7sHHxjS+cCriGDxPk
 wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792597906; x=1793202706;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5jWKtd3ovY9OTSYLVxbS7bhXuxkkaBp2BaDGgV99C9M=;
 b=NvZ7ljC9rcH0CoglJjjfavbFooBSuau4jl6oW5tfRKpYJB6uQ0r/2+0nqbuzIlU/y+
 UUiDKs7tHDrggzZLqhekFTag0XV8tFiuiKm7+HYSb8oUJoSd63eyIoieQYX7LOfqjx6+
 FqALZ3QyNukqZADZUAMFgY3hZCcLaLWZPPU4g+b6xBeU9qGm4qIeB0pDCaLGKxAY7q10
 PTl0bM2OQM0G+u4ltBSq44CsZX42aj1ibnzxh18yBSwR7zv2nxKg7AftgM2dfLyUwLO2
 HbxR+3CzwAs3t38zn80YHozyppgQCN2t21W5lp/VMd2s8Qty+0GT3bV5B66PM0hLaSto
 40fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5ReqxWZ8BPod6NsYCWiUsJGmzkTtEMCb4vtQmwUcWnHHNspIJe8dNyHatKCKNJa8JS5fmoH1S5I/o@nongnu.org
X-Gm-Message-State: AFq9FYJhoCaiUbZ/XyBsz6BU+uMNQz0rRiaSE4XurB576w2gn/NrTNO5
 ddlqRJEbXohzQ8rqllNQGLUvH450FQrmszDNDVYn9NA2XGxXN600WIEzawIHmpLxDfrNTWyCngY
 +VpoWTXCMrYgNFfMAFUjs8x4pP1/oMrEvG3hOBlAACF+X0faxfZqKHwxUPQ==
X-Gm-Gg: AYBFou0jMNd04HeX5vmM6B6C01Fwhfu5FfSI9+tPLay0V0BvjIxgWd3WPVo7HbYo8EJ
 9TLrChlDS6+mOleFvMx8/W4HQWKw1qTT6oQQKyTfS6oYcI3R7hnnN/zkagerdkrkXf1sxN9EMUz
 mb4heEUhKQPm4dVOeJCjUrowhyVZomZbdxwwkCC3sl+pqPqUnHOh8MTXP19aoOuVRwk2SdUNaRp
 IWM1DBXqyJKSnJinBTz7iEbPVknMuBZS6yYcKtgLLx3SZNPivmmUmb1UJ+j35iC1zwc/NMVFMHJ
 tdYu382jiNqzNUhFt5ftzBJEm6gsqafMjkulkSTPc6FYNIK/86dofEtBhMHqUQlkk8Q8XNn6HOa
 ddYXVL0MkR/BaB/i1Ixdjr4dpa7ns69U8VA9snRJspe1D1W48ipYTPCsYQbm/wQYhFM62Uw==
X-Received: by 2002:a05:7022:b054:10b0:18a:8164:ce4 with SMTP id
 a92af1059eb24-1909aadde56mr3277203c88.0.1792597906060; 
 Wed, 21 Oct 2026 08:51:46 -0700 (PDT)
X-Received: by 2002:a05:7022:b054:10b0:18a:8164:ce4 with SMTP id
 a92af1059eb24-1909aadde56mr3277172c88.0.1792597905404; 
 Wed, 21 Oct 2026 08:51:45 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19035926fe9sm5825214c88.2.2026.10.21.08.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 08:51:44 -0700 (PDT)
Message-ID: <35ae96a4-e3f6-4c45-8bc2-182dc62d4f0b@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 08:51:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/intc/hex-l2vic: find the next pending irq a
 word at a time
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261021031554.1942011-1-brian.cain@oss.qualcomm.com>
 <20261021031554.1942011-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261021031554.1942011-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: driRiayd-SqqM01pYwrXxn79ohYsEyC-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX3eghgp/KCSD8
 bfqSf3XJuinnbaZtb/VPPD6Vh/SnV9GX/0LiEBoH2H9wxw6ME4lz8u8vnrdRHRRs2soNWhOXAw0
 Ipr/gYkSXKRlym0ZMzTh9nVFiP5EeYM=
X-Proofpoint-GUID: driRiayd-SqqM01pYwrXxn79ohYsEyC-
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8df93 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=8fQjqy5ARp1ca2tc:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=U6g294X4aUJeJVjxo4sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2MyBTYWx0ZWRfX73ZoQ7EWghox
 bYaPzgS7hKJ+y3sY8SDygKcLJvlLTRIyfOZ5uf2lG1nhb9ldCkOIRD7NsZfBgJfsUPP4XsNlEs+
 ya6SsB1p1Ahsyy8y/aTxiYY97DjriNJeWB6OYSvXci5YYuktjVGoTLrZx+iCqkrCF4PFarCcP5s
 yClD/UPbT7uM+oO36kx+oTkoraWXMdxWfJrUmtGvBYTJmrNpup7WoCX4Xwa59+sgnShsYQAWoWd
 8gEghiCZWc4SniVCjrQ6Qgh1+amqBjTS4tAmgfUpsTs/lAORZqA6uesNDxaBy7mdMjRSAwxuGIr
 Aa3zlaJjbjN++FFPuvtoB0fv7LWz4o4vof0hx6sxBtVH+Ei23qp0we4NrD7VKqAL0bNE6EljWl2
 o9U2sLvsLPBQjCjQb/B+XDewbvQXfs0LMmFAyR0bFeQb90TMTeD0pMJzn/n0hD5m/Dd1bUKRxxP
 GZMSput4wxmNK4Q87Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210063
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 8:15 PM, Brian Cain wrote:
> l2vic_update_all() called l2vic_update() for each of the 1024 irqs, and
> every call rescanned all of int_status for an active vid.  ciad runs it
> on each interrupt return, so this was a hot function for an OS boot.
> 
> Check once whether a vid is active, then deliver the lowest irq that is
> both pending and enabled by scanning int_pending & int_enable a word at
> a time.  The delivered irq is unchanged.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/intc/hex-l2vic.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

