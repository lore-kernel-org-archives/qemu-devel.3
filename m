Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D4606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YK2/lxGP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tm1CE9pT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDY2-0007oX-FY; Wed, 28 Oct 2026 19:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDY0-0007o6-8g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:59:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDXy-0007Kx-Ig
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:59:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMA8N73482742
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SkEiu8OrDndFseaYwGvRiXt7lTOjO+VIyMHLiHmPQAc=; b=YK2/lxGP3/kDqAKo
 nZfO8tUezOIO8vaBROlWZyL9kTBRL/sg55UuWmX+nRAiOXqUc/qIQkBUZh1B9emI
 dNARD7cuDO29QKUneo3wMU7LGdhvb3y++Axm7h8rKwa129tcDc46yAGnz7i4eHt1
 +4vkQ1KQBpb/jnPnTt8hnjPr2LSLZADtdp+YSpG3KrrtPNAde9PdRnrq6hBiEXrT
 9hWUVjUh/R5Ry4cWiiQov7jFwo/ti/3zFOvj79QtHlity+zL/3RNC2lOV4nEhB+s
 04LA/FYTS2qXWYNQprEpTc2KpQD/4bGbK8UAlLzRhuWk8qaMQcJud/CxfMS55AJF
 TG+u3w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneuscyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:59:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso3300786eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793231947; x=1793836747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SkEiu8OrDndFseaYwGvRiXt7lTOjO+VIyMHLiHmPQAc=;
 b=Tm1CE9pTFPBvR/EJuUR0nB4bvigSepYPv18YadU3rPAIIiouod3d6r/eFUP5+7DSKF
 iYAdhQHGzznFr6/MqurdTfeJdSily0kjYR08ExO5i7nPBXAVzl9KtVZmCvXE6yR79yEl
 sBiO5b/VwXva8a0YxG0r0yUQRd8FztTgRh/weQnsP8Hw9MN47mdF3jJEDwEB+sYKEjBw
 kHgZMbCtZGJQTt/NwnMqmsRhC1GN6Vpwfgy6Vq+EIq2x4vHPCxFOCF5kIFHUj6QjZinB
 1uK9fJQSrnjbd3UsdBFto1V9c8yFDes+kruE6+13n2yekjEXePYY0U093npTXp5omeR+
 didw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793231947; x=1793836747;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SkEiu8OrDndFseaYwGvRiXt7lTOjO+VIyMHLiHmPQAc=;
 b=ZO8R/lVBsQmevdyKn3dCCsHaLUhLw8fuOO6EJeZMUx2EpKHki5tRgtl55x/wGF1072
 Cbcw9UGmj4cIwXYc2u4S8hrhtgXK/3CwGs3gxut/e+3gRd73U4DilNRtM3HD2MKU1v5T
 /pdffs7FHGouqtctQH7HFVcuDAeqs3wD8Lx72w3Ktzrdwn7okQm+w1HruuuCErl37Ijt
 5ZUC9wKo7v7zFxmI9dWZX0ijZFEjkSg+q1i9rJwN2Qtk2IM4NenA+7WZ+CzIteyUlp0/
 cq8fi+bTScgzNRyw68f7kUREVoUpNc3lhuSjnjREOxWWy5iDGOXvs1rMnlfBXmJU40+g
 n6fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1oypC4cA8ENp430HiXkCxEutfNU3UObd16PuHnDdnCN+bPkLE0nauJrOJHyVCW4MaRtblMlxVuMPp@nongnu.org
X-Gm-Message-State: AFq9FYJsnpbC7SpdayfPvaHTbsBDaSigE5hGSX9YVTDaxqfoE6LjNhOY
 e2FiSIjOanKtahxEiwGwheQSUg0tVNj/7Kfd619b5jlmfkilgzG1Z3AiVscV17Ff0X9bOIt1Tfz
 r4awe2sFdw219QzJy4VJzLQ2wA+h+l/wm6h4A9IQizyF+07XvP8oVU6ITqw==
X-Gm-Gg: AYBFou01OXlASHZ0Kb12z9zlV1Js6P4q9P7f6VIUwRPN7FEXW/z7S86eRWa/6qaY+Ou
 xNebXYZ29Zq9kMyxudiMWnJlGJcmdXDYAPWGJCNrSVVhMZVyKxhIAJyjxIdip/z0Tkzv+0bmOIa
 mzAzn9O9PExXCpF26pX3/FOnxLLRNK+6TJHO3EM6f065D2ggJAZoe6JzkCmRL4msLLmySD0nrIH
 hEbx4ya6dnmYTOU5ddaZScMEWxm8f84EIRHs6RLZlm0U1CFcTJEGsV2J0EWdQkZuhZrrZ0jnbKH
 DYsl6R//dz3i/8fAYrT5wvCJ1voCXat4lvpSgpO7L1aPv/wHpkZUeJhKtZ+lGHMi6Yi8fEyydWF
 cru36b8OqLZo9puX1trPiyix1NxSC1P6gmVcSizxZXgzkbtHv1JS8lXvivf7IXGX70Lq3l+tYpQ
 XEP/fcjekZInazTcKsJ5aJf+na5uqa39RTtXGhPuDp4O0=
X-Received: by 2002:a05:7301:4701:b0:359:8492:20ff with SMTP id
 5a478bee46e88-36a20393e95mr4554233eec.12.1793231946186; 
 Wed, 28 Oct 2026 16:59:06 -0700 (PDT)
X-Received: by 2002:a05:7301:4701:b0:359:8492:20ff with SMTP id
 5a478bee46e88-36a20393e95mr4554203eec.12.1793231945494; 
 Wed, 28 Oct 2026 16:59:05 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239338e2sm12191128eec.18.2026.10.28.16.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 16:59:05 -0700 (PDT)
Message-ID: <18d2dbd9-166d-4dd6-ad77-081a445aeda8@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 15:59:04 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/hexagon: implement floating-point exception
 for sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261028232720.3331505-1-brian.cain@oss.qualcomm.com>
 <20261028232720.3331505-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028232720.3331505-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5NSBTYWx0ZWRfX6GoFJRiUC8gE
 MQC2ES1/qwLH8T1gYi4WXs2/5GHG2zq48FtKRCm2jdabmzvEW1WGBfNWTLIWhCeRkQ6U3bJEe1K
 n8THUuOJzKTtiGBfJYa1OwA6kOeKcL7jvZDRp4/GNLd04Mx8Gkj46vg2Axn1QYwojLpUDOdd68W
 6GTu5r7v0XxhrgirRmjTPxL46MXRweXXltoW/K65ovKWaVRgk4j6wAOreWMPsFEs8cZfL9K9f5e
 MOYHMpLZXnMO6LqIZtFnLN9TZAeONrwivG/PkoOviSb/Ui9mPSG9v754z0w9vc1xK0luHVWL0JH
 861jni6oNVV+Ho9b/ykvw3YLqVIocjJToRTQDd7zu+Bb/ChxBQRTqLUwgOIQlhg8nLzKzOiBRCD
 kiOQjbBkAAERB98Y42GOmZYeFK703PVxYI1T/f77lmyyXfB09PbdQI851iZDW8EagTNp5ikBAOF
 N6wd1RVLoA0iG+4QmCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5NSBTYWx0ZWRfXyw9TKFtnV104
 3JpCAZzwxRFkNaVoKAxbLVJ/F5Bebp+qelsbV0u+RGNQ2yjzVnLoTCaqaoMVU4RuhZsZe2x8Yzd
 JSflY4+tc7DMj5XB1tv1NHKCEzrjc+s=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae28c4b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=r93htj4oMzndGgShacMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: _OYaeVyaJxHxqCzgKZadK0bob6EFk5GI
X-Proofpoint-ORIG-GUID: _OYaeVyaJxHxqCzgKZadK0bob6EFk5GI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 3:27 PM, Brian Cain wrote:
> Define RAISE_FP_EXCEPTION with a HEX_EVENT_FPTRAP exception.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/arch.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

