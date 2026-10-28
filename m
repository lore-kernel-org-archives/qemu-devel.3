Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEF606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HZs3O+p9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=beFQpzWM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxbF-0007Be-TK; Wed, 28 Oct 2026 02:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLxbE-00079J-0d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:57:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLxb6-0007gZ-5X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:57:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4PXH43382128
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OK6/lvjW3prpUZ/e4pufg7OCh97R0DH1JUuIESj7300=; b=HZs3O+p9ZYfGfQS8
 hlBlxZvS3V9fexhi/eIXCJAiOaM28h9EwEajQdqQPHfSMzHoVkA3JEVWQAQdBK1O
 B/Lbpig02CTFuSnedgvaEf9tu1ZYx0IwBtO1xIedOjvxwN4pdQmBdG5unTcqup4V
 X6pMGw+z+r15GlB4uym7sY+QVKFAOtY1tBBUiA3qQZzYojEd1hxioCIK/1Wj9fRO
 zlfn/304QXMcdmMDD63aFuimZOCp9XYVEy2sP3Uhwpbbm4carp9jaBQCE0yN1Ge/
 1WIqShLama3BAStiNWVw/2KsgD2mCepVkyquzrakKJeUVI9ZdxcIoCYI4Ze1zF9/
 OEOQ5A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6f916qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:57:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a2035a4so38816576d6.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793170634; x=1793775434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OK6/lvjW3prpUZ/e4pufg7OCh97R0DH1JUuIESj7300=;
 b=beFQpzWMB1hLHcfnra16RHCkOvrS1hS60EXNn4Z/gOoEd4HAxNgBKdD1csQGAnBeu0
 yFczmniTEGSDw66E2yleDEWO2vrsjgkzBTktznq261SaPmcEAmSZz7XgcNKetDQElCxv
 drLm9BDWO8QivFVgb+QSQ6HT1N4jiuUrd8dK9uP+ia8O58/EDt3BqvHQbyEAWKkdnj28
 s5OauL+Y217JxhqSGsf/GiFMw4JzsWrpEdqTOr1UMVotDB3FZw1VI+jd/Mb3aD6u9Ar+
 71avy9PaAhbFelXXLgubZ6t9UNQYA/OC7QxLFHs1h2ALJ/YZp5ii4qu/U4QGHJbXQco2
 LZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793170634; x=1793775434;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OK6/lvjW3prpUZ/e4pufg7OCh97R0DH1JUuIESj7300=;
 b=n1G5/ixCNpgi/Tgm8Dr5H+BLlCgKUIpGMTMIrWX5YW6w72fGJtfs1aUDSiQ/fFl23r
 Fl03bbUtSlc4Sfd5Mggla8xoyjT2MvwKP4+Zrnx//bydnUP+yomYdDkb5ovFwKjRBPVG
 eFwjbIYUvEBSMhAEeeVUUG+UCNW+p53KR+LtS6u4C8VUTXaFYk4wXp+uZram62IJhGmh
 M2yTgZrrkFNrEBTx2Yffd6r3qt0GDqQ7A/wzL5NwJWpQrGu/A8yZiStw63zhBvdglk1a
 yOu08CIIm7ldKNy+oKYr6DXcM3cOVtaA9GA8Bf2eIA/+vz9L+gwW+iDBjF3VwXF0LSv2
 lL2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGvKW7bNfGTfDPUgHRvXzuYQQYaIWGsIN+jZMcuYVNePSxMZV5ridS5rzRkHQZpg89n8pkyDV28SHj@nongnu.org
X-Gm-Message-State: AFq9FYKI8O7xmD97BXfzb3LUEY0RkNE4j96bABuNPEPUAxNecT/ZSj0j
 QcwUvYp6K7OM9Pae4ZdyyhJQvlZY/oXBUlXu9eigNWHWqtCvoIDQ4AWQD/uLIDhbEO0T25+uscq
 Amqff6GdpWd7eeKoPLnNAYNnK+dDUHSdtqSFCyO3Rud43mIvabOK63toAJg==
X-Gm-Gg: AYBFou1y7WV25yGa1GX4R66QAXd8Ehl83Jt69e13OpWwCzHbsqXoAhNHQsNIn0g2EKp
 btw5MkaxRJHFzHGxhlw5MNsdxEoit3cLS2/J9wXWYkHgJscgNOw2AYpP2P2MgHvFwAr0nHB5dhJ
 /fMWvnvWqdmu7Z9qr0ntfbFby0VYuvLKbPQex0FSg2/phmnLD3+dOFbPPZnYa+KFLPpApHCIZQQ
 w8wjMHzB4+pB/NmXZqh+FWSR2yH3W0+oPxpyQQMJCB98TPhrFGmo2nH//29z/bksxPpILyvX+Yh
 Sk+EkA0QuiTiWwdnJmrhUGWifut3NuHPvoFz59CC7pl1J/MROyItlYO2ThFfMtZP74pYj9AV4Dr
 DOxkrKXKsCP1fiz/rc/NNDNdsXZEkihOgpBbZhOeSvp82gzzVBHyg77j+AzzBg/tCcuh37/i5Ta
 gBgoeYTS6eQGDesERs5feqhiQ=
X-Received: by 2002:a05:620a:d8c:b0:93f:2571:c317 with SMTP id
 af79cd13be357-943f4bc5d77mr898825585a.28.1793170634497; 
 Tue, 27 Oct 2026 23:57:14 -0700 (PDT)
X-Received: by 2002:a05:620a:d8c:b0:93f:2571:c317 with SMTP id
 af79cd13be357-943f4bc5d77mr898824585a.28.1793170634051; 
 Tue, 27 Oct 2026 23:57:14 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97d38c583sm21519815e9.15.2026.10.27.23.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 23:57:13 -0700 (PDT)
Message-ID: <beac1805-b9bd-45e0-8b03-6d4c809dc408@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 07:57:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Adjust NONNULL annotation on *_diff functions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261027230816.201808-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027230816.201808-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=frhJ914f c=1 sm=1 tr=0 ts=6ae19ccb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XXW6PjBa8LV8YPU5GTwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyNyBTYWx0ZWRfXwvgQbfF1dAQ8
 yCacsMkxglLNsbSAwNGJ6hwZk9ZZAFWF25Xc1w1oJjVoub5SZ8gTQevaEoPwMprYFoft83YFYXZ
 73Pn4299wfI+RjV/glxiiWJ0A/ixgUs=
X-Proofpoint-GUID: kOHYAP9mhaX9jA-UpAXaUmKX7uVCudI0
X-Proofpoint-ORIG-GUID: kOHYAP9mhaX9jA-UpAXaUmKX7uVCudI0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyNyBTYWx0ZWRfX/fTspa/ybhr8
 xf465Hy1s6XlM43abqbIeCmSu0O7kBNB9u5TGEF+5eJiTlg/aYOoxGs6AsX+DbCMcR2mO6UYgMz
 yMhXvp6uefej2TOwLylt/ay22X0reDWoi/1jhbO9243NrWQoQhjtYHBru3i5epb7+j5ni9SlVRm
 YWShd24Asn7iBPOKwJxcMB2hwtZgmg2KPK54D4VJP7fejPkiLjJms0+9B8gAztYcD6rIDquBfpC
 d9F/L9kuWzYcAOJXMDDQWlIev5tVqsl/eNL0+g9iD1+PMeFBeGxXc1i+NlvluwH50d/uXt5MgZj
 sdtEKkfhDqrHx9ZkOkX35+sqzRKqMieehd7g/jwxYezZT0v2jb/oxfUXyMPFXG5I8l0vKnZK8lL
 yAl6+cqgSNX4MgdWO634nKayomMZRIxMvABua7hik3cj7z5t28SJvv6JesVzwOfZNmkTIDFEkCo
 +ge0g1XYC56QE02qMVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 28/10/26 00:08, Richard Henderson wrote:
> In tcg/sparc64 we use tcg_tbrel_diff with NULL as a negative
> addend in a relocation.
> 
> Fixes: b0b6701a4018 ("tcg: Annotate functions in tcg.h with QEMU_*_NONNULL")
> Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

