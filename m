Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE7606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g2puwc7D;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eGp50fc7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT47g-0004g7-Rm; Mon, 16 Nov 2026 16:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47e-0004ZP-DA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT47c-0003LS-L1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:20:18 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfXQN912919
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0+I/SLuDLv73crJBmhE+qStCehHJDiamSpvgPEJHtQw=; b=g2puwc7DYTQdrPjv
 dLpZuWwT0c99yLy5yDxPuORV86I7/Ji5Vf/l8pPTli/SKfJbFZ7S7JV7Mmk5tfYL
 MSwnRGi3tSgmdQNcN0ReLtmd+KQsgLSozftYutx/7hF22+zQiUJaNknWSuyXSs8E
 3GxmZBzgppKhC74zBL8mWPhLOSAbqZ3/O916ZHYV7sv1NiVq4zcGrS59NNQsqeC9
 tnHtKZsuverUfoUoN3pLnEGro+MJ3RGuQ5s2X+qjDDvXFY9YVY9HlMeahVnTh2+1
 ZWMR7SvvXAkh+6JjX3eeESxv5kmfu1w92zPwHXX+IYhyEiEvrxAugIIkGo9lO2WS
 YD1SQQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y1saj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:20:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-375f0fd31f4so2408662eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864014; x=1795468814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+I/SLuDLv73crJBmhE+qStCehHJDiamSpvgPEJHtQw=;
 b=eGp50fc7Mul7z09kwhI8ZcU8t96+TAgwSNpc40yLU2BOkWnysZGF6nfF5Ncjn1O1K3
 W4Lmgk1h+pnWa8TEJtkvYjVgyjw5xb8TtkVl+AZlePrzmtawwmMEH9W/0z3OuE0FOkqE
 Q089R6HSrX6AHWwSfbTTo2tKRmvsVW/ugACk0XyVvm6kJCNO0gnwB5rfCyisu5+ycemn
 xP+VZEQygeU3NsKOgtvFQeHSe7/8RwO2i7AcplvueJNv5Wy0dmVw6v5uYYUjvAr9H/RW
 glO9JfSXCT7FmgwNDr8ReRiIPIVZy5IyyRmZnfKKDRWmkPC+/uYCrAnL2C58SHQKslxy
 CxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864014; x=1795468814;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+I/SLuDLv73crJBmhE+qStCehHJDiamSpvgPEJHtQw=;
 b=o5cletTn2oLIp09G5+NO5+OoyPseZP5X/7dWB64drs3JMw8KAvVdz9pakgnrvm5xm9
 7L/yu9Q8Tgh/0RRIBSYzFkmC6cJk53d7rFndPb8ShCstGQeXgyDXiWGpV40h2M0QayiU
 Qm8d6ktN/513J6xx/VHIlzPycBTh+PjtRTuNkl428DGwqUTmw+toGxaXszGIs4DU8u9D
 R0gxbcql8LkdAcMWczdecPA1HhLz08IdW0dJM+GdJFxIylWO9Yo8g6s1hZIb+hsR1VFp
 ApmVOa488Odj5gO2O2Kpu4TYZMsDI17BMOL0hN30vlAuUM9dDnZD1smqDkKlIqPJqeIt
 Jn1g==
X-Forwarded-Encrypted: i=1;
 AL+hErEStKY5JjOuNynfX4ObvlTHP8ey6Z9ggFUG86fu+Frx+KVPE+DhZV2vC9nU8rp/p98xLrR08pQptrxl@nongnu.org
X-Gm-Message-State: APuU4Z/uB8+GEhIZvxrezYSyo+waUq8s/TfN2prbuOJ4rBSmSo4tdXgU
 rKnM6QPbS9SE4yqKDOPjGz18IIM/VyyFgknlG2UrZrsaK20Emft7Mk8FIF+XuZiYaUeEuW4OAWA
 4Re7/JLYwQ/60gMvFXHq6RqOiqF6Sotc/+X+K09J141/a5mMDwfRm+ZzFAA==
X-Gm-Gg: AZFdTZfeunqzd969GX3VjcHqsyAUx29/f0ASMGvYgu3eK5JkDESvN/J7jwWJGK4/jO9
 J/o7HEvNvR6oI2NxBNZbpGwoC3HUI8uRWdQ6cXVjHkr/SRnVzv4VHXKTGo3cmLFF0oVt3QseiYX
 nNneh1TJ6Ew0XndebQagRDLSEW18EJl11xhGJZMmW6+heSbZJuEs+ZVr3E3No8QvoUhLnOHSySV
 BKG2NId21ka7M594+7Il5uhiGJ9R3v2FuUHz+SjHKxq4BDjwFsiwp61ViWNtSSiOnauyQ98zDEm
 TCXM4NjX4vj7ZMj2GQNNKjxwjTI3H0ip7dUShs+SyJWGbOf0GXCHBDUcN2hFUd28/rEXAFskiyU
 YBgoI0WAHe24XoGpHEN28yxbhjo7pMtAR4MN8GzPQB2rFaKNcUMzNadJ1TlZnNM9+u4fB4ZtK6/
 GLRaBWXd/B65pbHUVvbpwsiyY0Obmsgd7T32EwJOn8Ihs=
X-Received: by 2002:a05:693c:87c9:20b0:381:1580:cb4c with SMTP id
 5a478bee46e88-3811580d02dmr519470eec.24.1794864014383; 
 Mon, 16 Nov 2026 13:20:14 -0800 (PST)
X-Received: by 2002:a05:693c:87c9:20b0:381:1580:cb4c with SMTP id
 5a478bee46e88-3811580d02dmr519454eec.24.1794864013860; 
 Mon, 16 Nov 2026 13:20:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d07b3sm35450830eec.22.2026.11.16.13.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:20:12 -0800 (PST)
Message-ID: <f262f9cd-dfbb-401d-8113-e0660aa7fd36@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:20:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/48] hw/hexagon: rename the 'virt' machine to
 'hexagon-virt'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-25-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-25-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AIRwaVzsMjp-nbJI-Au8Y9pMQgTY0ixN
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb738f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=vX_OHtA2jq_LGBKDobQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: AIRwaVzsMjp-nbJI-Au8Y9pMQgTY0ixN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX7gN8nYn9+5xn
 VyKVlI9uJEKKb9KoJGekO/g763mdkZjU2tArqMnR2NUyOjWevFWGMMxZts3QUp/41v4d/TRB357
 vYR/sEW122+DDp8H+7Lyd+KxRqhSeD4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfX/m6/mgVe1c+2
 GjVT6GJtzSzMMRRMNQ1lBH0gjcGQWD77ECjaqBd7HPjxqsWULpH8KneMNXa9nulotljZZxszxAL
 rhdi+IGlD7mQUvWY7w1pOjLeV7uX7zdYNupcbCuw5jje+eZ1SPr2hmhqXmBCzKGoxOuCqArDpW3
 t/zRd863zacF1zMenXVxF9uu4OZBXnfPaEr3A7KNpKDW0Dqm/qAmF6Aj7RLBxY5T0NKbssD9wHY
 UkGx7qH68BqudMf/ejMDHeJ1BSrWSsBXwGmnbBmZz503JSWanCy2fBBZYI6BPO273iG6EznL/lC
 NH/79Euf8d4sWvgodWlqJFvYfEjUO95xf1QuHy9LvG4Kya8FydcxgWOO0YrrCdioMBrSP04zt69
 Tzo8BqknHjKg+WbxO3zUNEUdpShLYESFt/S79jKvA7eT4yI9bwraGN8m2nrON+Fz3j7FJm38lhn
 GAH2Mn/ZeTq5mVu1CAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160084
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This introduces a globally unique QOM typename 'hexagon-virt' for
> the virt machine type.
> 
> An alias is added to resolve existing convenience name 'virt'.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/hexagon/virt.c         | 6 ++++++
>  include/hw/hexagon/virt.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

