Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54354606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ad56BbO1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dXqScCuY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKRqg-0006nN-2t; Fri, 23 Oct 2026 22:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKRqd-0006nA-Nx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:51:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKRqc-00060o-1P
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:51:07 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O1tHKt1377181
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 02:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /uuxD0EvKzq17VFvuZ8ElpTT70cUkG5Ut4jk3T4J5D0=; b=Ad56BbO1RtnfMW2k
 4x7aYuEjVibPtwXHbRKlGkx5fn7S98sXgWLSQLTgcB2xqngq0OXmkHquMIuZrf1I
 G3YeADAVkD9efei0h27qgq12E0f9RlgEIuqHoPvcSSSKVgrB/D4smc6JYtsxvdaz
 ooFqXyW3wak+r7FUmYNxyA6CITt0WskHMQLMmovCamJS27IL0inDgHhdeIv1kybn
 IxPa/czSiW/uxImutXVlxJshOcqyaGsXWeuXqxe98laUZHboUmHzN3m0TF3d7YOc
 SMse4eVrA9vzKxn9Odr7dMs3a1t6R1u6qujuQjX5H1IIpyh+HW7oZhu5nGxom9mn
 A/61FQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgr7xv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 02:51:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso199080685a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792810260; x=1793415060; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/uuxD0EvKzq17VFvuZ8ElpTT70cUkG5Ut4jk3T4J5D0=;
 b=dXqScCuYlh57NcTUL5iNvwa3u1t7XdbUOULOh6ld10goa6/BztRNU+3NVbb1s0HT9Y
 gZe27L7mDqvTs34xsxoCaX81po/onWflaIP9fq3VT3RL3Qqt+M+2xCXx5L9s/sh/CLGi
 K3RTePNGZLU9lcA/F8+oDPCuPxAgdJvLuGWq0A7s7vT5dS7A7TW405UeZlSoJIFPgfgg
 SIXQdq8MQ2VQSKbisy/vywWldNjDSusXgJmWST/NJDBqnkfUEqe3mNPGyds6Wko/DDwX
 IUU1l6Kg+YbBL2ZFVWdxO+GFmrIRcnKLqVJIgS3lICXV7GGqhJsTmWdAToqMZQuEua3T
 Lf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792810260; x=1793415060;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/uuxD0EvKzq17VFvuZ8ElpTT70cUkG5Ut4jk3T4J5D0=;
 b=BDHSr2R60B6H5pafYWFzj5/BlgFgsh+sFUEdhmfaqcSlq8vdLRVhvD0wDntNOhMgkk
 xWOH2pSzyEyUbj4est0Vz5fOOBajSClosZupB8/5E6yw/qGOpEO+LkBXtu0sXl/JyUGJ
 TtjUJDLKHY/K3Toi6+CGHqWqP6S/OHSs4rbvM7epclkypSVN1NLi363Ee6EFUOliaXzF
 /0s6C7Yh+rKEhJIXVoSzGHwTgbg6UhKFR1JS5mlgNUEZ46vyYa7ITFbmqhmCehDUABum
 MB0f7yIgH3XioR3MJiqKXM3VdEVORnnW8u7c0qsZMi0aB0YW6OK/x7h3VbSw+eWpfwQC
 87IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoYubaIzOam36wqzG5ZEnRoaCnu79FT2pK6JXQyBvKzu702Q36IBVXZ7XRpkC78FvGG+M79kl1z0yU@nongnu.org
X-Gm-Message-State: AFq9FYKCvMRX6w+dK3KShgBPP/hMiKfsX7LksAFLelHBzIKPlWjsdQeW
 GxG4kWmEg9nUON8D3VXbXuMJLNKmS+yR7NdjkgyCxVrv+ghDbmwXynO9SjgOa/yo3opWOasDQih
 Ac+kSekQogmiczYlBWZ+A0NUjHhTWii2PsrwJGzzhOqbCsf6UccpQkNfDFw==
X-Gm-Gg: AYBFou2ufNXnpMS5TMQSl55uLG1q6E9EbsJKhfKmE/on8x9OGt3PRwc0+FvFL+3+kSQ
 km45A+v8j2mau55z2veRP4tXa8EAEct+lFYOtW79TRtjjYf3YID662xsWyX3OdmiddTYbOuF6U8
 ekEJzDfBeDM2tB60AzZ00JLken8OQ2QMWUfsEsxssdnwzh7FtbIbAAGAdnSozPOEzPk125guk9w
 k1Vjw6mu3uNzjaY9Y7ykNyde0U8cPiEgnAjAx/EphdZCbYTScq3L5danvbjtwKid/xUtWawut6q
 VUWVZ9KTq0Em9GUilLXvnSRvFFD7Bhaun7bWm7SGOErHv5PjoLh6A9bTI4Ro6j8eDnWJKf15axy
 Ca0U9qjRMUtJwst/WV61TJkkq2lrpxmsl6kQuHP94zNkWLl4BgAJ5AjmZF5If8DM0fimyg5yYUg
 FWSNE=
X-Received: by 2002:a05:620a:480a:b0:93f:3120:6c71 with SMTP id
 af79cd13be357-940ef956f4amr137328585a.44.1792810260508; 
 Fri, 23 Oct 2026 19:51:00 -0700 (PDT)
X-Received: by 2002:a05:620a:480a:b0:93f:3120:6c71 with SMTP id
 af79cd13be357-940ef956f4amr137326885a.44.1792810260023; 
 Fri, 23 Oct 2026 19:51:00 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0787f33sm72154885a.25.2026.10.23.19.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 19:50:59 -0700 (PDT)
Message-ID: <485a1e1d-063a-4f8e-a1a0-dfcc57c19029@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 21:50:57 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/tcg/hexagon: tests for v{79,81} HVX
 vcvt2,fp8,qf16
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
References: <20261023225820.330905-1-brian.cain@oss.qualcomm.com>
 <20261023225820.330905-5-brian.cain@oss.qualcomm.com>
 <ec4e8c96-f82b-4cc5-83cc-a80574cc1e01@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <ec4e8c96-f82b-4cc5-83cc-a80574cc1e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAxMSBTYWx0ZWRfXwrRULxjZQtEj
 se0nvaQ5qOJU26pNObwnxu/hBftFlitobRoiZKiTL7bWUaAYS5/Zb1hG9qu1UH7WmDN4HjDS65m
 V2ZQgUMjx1NDAawM9cZilK1QtpUgnUk=
X-Proofpoint-GUID: TdFKjMp7QXqGJD7fCb2ay5NiKEFkp9eb
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6adc1d15 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jDYh71mHBIHKOrmpQT4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAxMSBTYWx0ZWRfX3Npfx/N6rqG7
 zKWdUvIc0eETgusyVj41mB3RRzjF57+7wK1szUPmTbtgvkxdUskJk5wxmOWps6OMhaixaWp4rtv
 LDqCvHQqph2XbGFzxVKeK0BAHI+OvWJ7ctN6StWfi2z16Hwi2m2ti+HGjbLZ+yoSHuU1TN+OEu4
 3nQa7u0TWVbJwwAlYAY8WqNT0+SemCELWDxXRDu+3ydhVUY8XdtusQys63nNDazTXjlfQMvppp8
 ymvLN7nHAx/fNr0qBzklCLLty1Ca1qVl62Tj9UtcC0eTD2jgaiUnsLX78j/ZAwoWnxsxgTq931x
 ez+fdW9SJVu5/FMpQcPlpCwijDTRgld2qBnf7lJefjXtIHjWD9/pyaxo4S6PNWS1u68OvxaY+r+
 tG39ZmjeuHAhMa4lX+sGd/iv8SAJ8fDAhnf21fMjR0mdo32d6oT2dNvvDRn4KGZh6GUH2WxDADz
 dGZeSuaeH4hlhSV5W9w==
X-Proofpoint-ORIG-GUID: TdFKjMp7QXqGJD7fCb2ay5NiKEFkp9eb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240011
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/23/2026 7:17 PM, Pierrick Bouvier wrote:
> On 10/23/2026 3:58 PM, Brian Cain wrote:
>> Cover the V6_vcvt2_*, V6_*_f8, V6_vconv_qf16_f8, V6_vconv_f8_qf16
>> instructions with tests.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/tcg/hexagon/check_rev_gating.c |  30 ++
>>   tests/tcg/hexagon/fp_hvx_v79.c       | 478 +++++++++++++++++++++++++++
>>   tests/tcg/hexagon/qfloat_v81.c       | 121 +++++++
>>   tests/tcg/hexagon/meson.build        |   2 +
>>   4 files changed, 631 insertions(+)
>>   create mode 100644 tests/tcg/hexagon/fp_hvx_v79.c
>>
> Would that be possible to split and squash that with each concerned patch?

Sure, makes sense.


>
> Regards,
> Pierrick

