Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2552ACC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5aR-0000Za-LH; Wed, 14 Oct 2026 16:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5aQ-0000XC-7Q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:28:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5aO-0005sM-Ly
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:28:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbSJO3813172
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T613kuoxjF2+bIqK00TPbllOrhrK7h3/3MWfMH+loUI=; b=kQ95KVczoWA/IlGh
 sOr/ZTxyE6bIiT814JC6fZ8ZKruI+DevyTXuEYM6oYrXWrSxClx8DKRFyB3PsgZl
 zP6OQek1pz2fCcFk7jPbVdG7gl74JYNggIoSS/lmlzWsY5QUe65L8Sj1vve9rml5
 aUKvOy8M6UAfzTlwTpbwjb67uTS/1AgStcik3JlcGLdML8iuMT6lv8ZNvVXNFK/Y
 mY1QKpL/s6d8aJ0EeeExNZC8TJMG/qm2FX7UWZ6lHBDk1A09/IfJK3DUXJ2aMll4
 mF8tDZ+wRCgR3W9F3Bihz2Kd7RbLp+AMzXvxl1rkkCeOlkqZLOgtQCZvrHvCUxms
 tPl2Mw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u3dss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:28:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so12645020eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792009707; x=1792614507; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T613kuoxjF2+bIqK00TPbllOrhrK7h3/3MWfMH+loUI=;
 b=Zowgqx0YfThDzg6Mi93t4UfAHJWl+VfAgn1JTQ/Q6BH7c0YZ+G/OPAIVR8OOJdArrZ
 AiUBNAYGd3IGS/tQthpra3GwXbuS9/PEvVvoa3L+6kCNfTskIU5UJSDG7NGfiB/pZM8L
 g3MISy5j0lKdY9Ae2GKpblwsLIAe/qb4/Zpbyj35tOfJjR7VkfhPPQymXfta+LF6FBwa
 BQXiKGp+YpAKvSFvEK+RCePSxtszmhBX46+e0nNLaq5056NcjyLeZOJD2PsggQY6j6mc
 jIDXWtiB/HTbitsU1EF+Yem4EyJzcG9JVyRBFj3MfaCId/lTKQRmL2qYp10YqoPAbqNT
 2t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792009707; x=1792614507;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T613kuoxjF2+bIqK00TPbllOrhrK7h3/3MWfMH+loUI=;
 b=uor6gleRFsjbGF7jWvLUPQhXVPvvkiQMSU+tpJUTA7L7TC1pUBSHXxpY1egMbDdIKe
 b2Zg5GW2dvsdjB6bAUOgXBHJ9a0tug5hTSMYJiTOzomADHUZ7bx+ORa2r7WIJMFJpxLr
 TSj1U4vN8i3icOUBhx9ja8+AcAMj4rOPzi/T/nN6y6yG0PnNuh9fDJbXTjNw3XTdm3Pu
 AsLITA/O06cPbsUbfgTsjntcE0DDIaCe7PsWRhf4TavmzD/YPfHTEsa7yblPqL+gMPTf
 HUKA2Wejo39phhXWkcrzFeqpEGixKbEGBn/vh7sQJd2c9GDiVK5bnOLsGyu2ExIzd2O+
 C6tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkou0e3woDbircZseIHpWI7OvSIT1BPpdcZICY0F6/tHcaIRzjyV/xxSr6uDBvwW4i059VPMN5xCBq@nongnu.org
X-Gm-Message-State: AFq9FYJ9Ae76FFKakTvg8mu+G5Rxk0sZWFumGeQ9B7xHrwUFrl64PTTK
 YrLISbUKemJnMh7M96gYwWiO/vMayeo2FfZeIyc3NvJmOs7LQXEity9vpyceF+7zkaEPqOauiZ5
 3RubTdzc7Qru/imA5SAASSNNjQSTOECKKMYyR6vp8YBNrmJFLEyrxRMTsuQ==
X-Gm-Gg: AYBFou1QViANwsXGx3Tt327XKSJtM6HfK7lxcfLvrA33wWHRNYlP5D/fIfB2kXaKS85
 PgjBNf4IopwTT0qqWbBbA6g+2nZeFf9NmRcNN7i+XFoaG9ohB3ewhr5dmGHjm9pc+ZpZ9WG5mka
 K1tw2qs9S7SGhq1zlXuDcylOrvAz9+gx2utJctQX1juV6RMkV00Z1nWoHiHBJUbWWfZqR7xWFfo
 3a0wytjLkdST49mOviPQ/e04+UEqzwWPBnTABjPbfOg+6O22WM1uR1Q4/FYATaFv0W5zkihuW6C
 ForUtCy+sXwbGSusX90+v+wkKG+pYhqfxJ/vNmNqReC+x4kvdFXiSuPFHpYRQHtBMgDh70Xj4dR
 RpByNfoXT3CzRLiMex/ilikI+nXdw/yUOkBtu49PDA1KGq7lyGHDQgsx/hmY4aujM4IQmMw==
X-Received: by 2002:a05:7023:a5c:10b0:14d:c7ae:85dd with SMTP id
 a92af1059eb24-16a5dbfee9cmr21858708c88.7.1792009706640; 
 Wed, 14 Oct 2026 13:28:26 -0700 (PDT)
X-Received: by 2002:a05:7023:a5c:10b0:14d:c7ae:85dd with SMTP id
 a92af1059eb24-16a5dbfee9cmr21858632c88.7.1792009705254; 
 Wed, 14 Oct 2026 13:28:25 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm48975658c88.22.2026.10.14.13.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:28:24 -0700 (PDT)
Message-ID: <7cdc0862-6b30-402b-88a9-c329ef3b37cd@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:28:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] Hexagon: add v85 CPU model
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfX24H7llUQlhby
 Ksq5sQ07u2SuaYz836LZz7EOBS7RhoMk1gEBA6RKtUmkz61Z4fRl42XVFTDVytraPHJ/QKm8ujq
 wQjYUsrpoEWfcFqGrDcmnxljBzpQFVY=
X-Proofpoint-GUID: 3sHDO3QwpxE8o8MMJynubWZjRofvrZd0
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfe5eb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wic7VUj_TNXuSK0r0zIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MSBTYWx0ZWRfXzCfNqQdkOYHg
 8EQ+vLnedy+NMJLTdD3kurN5lFDIqOKSpRuD3C/G+4bDdTGvjQ4POfbWFFGFXWwHb9z/bmq6oTs
 IjVaRVoR0WsDRDhKvgU5vKGTj2ncpNRCnUs/vm/3RMbVm3YbXnssba1oAzxfY/C/ALUipF9F7j9
 JeBLMMI0XyxvoHGCdijiS9zKvu3Yl/eMy+EtFpM3EyiVpwfAQOr/ZJLjCHMa5DgZ4cL82aY1Pmx
 Kk6B2I7Avm29drmGjJb7wApdY20GxYi+VmwX0I1LbtFD0FMDs8JsaCyLchji4j9TKhqmd42F9kC
 l+SFLj2uZ+IxNmY+YXDySSWF0tdkx7fvW826udbpdwulhYOTWTXtWKCBPRNsyLu7Gscob5NTBXN
 yuMOBikJcrzj/f8/vbQj3UMMqFBRigObq0vitN22+xLECVPV2hcWOhf1b3dpAHmKAgb4pcey6M7
 uGiiJ9Hd8b2PGbJaLnw==
X-Proofpoint-ORIG-GUID: 3sHDO3QwpxE8o8MMJynubWZjRofvrZd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140081
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst | 2 +-
>  target/hexagon/cpu-qom.h          | 4 ++++
>  linux-user/hexagon/elfload.c      | 4 ++++
>  target/hexagon/cpu.c              | 2 ++
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

