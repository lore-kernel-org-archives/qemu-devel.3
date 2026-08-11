Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F774C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtgFl-0000ru-PX; Tue, 11 Aug 2026 02:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgFY-0000rW-Lz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtgFV-0005Bm-8L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:46:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMpodr3552851
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pSBQXzEYuyDcjmx5hDsnhzYgoz+0GlBKVhXcpNXW+Sk=; b=YZdWmG0ER4us2x8g
 31hgJexIZdgP8+OVx5B6/a/rNgrQaRY5xWFgaSkVhndYnJVEUpE/2QkHSppiPi5Y
 HvkErLOeVj9mAMsrJ7SUQ78m7fEagtzSsfuuZ92d9lOnvR6j4feUyLswdQXINVzz
 eJmJK4cBEF3OX3vmo2GvwFtdsfJAS8ND94/M74Iphke7X06rRBTC/aGC8GeKlKmf
 0/TvxUbbLm2yMYgmqmqBXi57CCYeC4CkuEexCSR7TGvCP8QRWzX+Z/8BcYYFD/4W
 9PCe4qG7L3adr/Rd0Oh8EJrlseR6ob06dEt1hMA01b2IeqlX3eXZMFTEj58A3jYC
 naqOBA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyqmk1d35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:46:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so2209731cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786430762; x=1787035562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pSBQXzEYuyDcjmx5hDsnhzYgoz+0GlBKVhXcpNXW+Sk=;
 b=JPLoXrRPOn6A1HsVcbSSLruf/fDc0WlS9lf8vzb3F3FRuCy6Bbjy9WksbC44hIONcc
 IyHbRODwFDHCf6Ww5DD03G93D7l5Y5Raar3VH68Md8c2DrYiDP2XD+CQJdDvVxwZaFIK
 9zzWzQeWXcX0DcAgp4D1i7Vw/HYLsKpc5ypOmXsC61Gt4HAQVN3kcPG524Jmdx9R1ORR
 ZksSkBz+dJ/4AAbURMUVadebPRssNbt6Fxsy56ronDKlR/U/ZSEg4GOHhMaUA8qp3gMQ
 rrw/ZppT6RJ7ZRqMvE7mhCpgWXN9eHOMN/NggF7LtlwFHRe51MFtPKxlq4NlTO2Olr1R
 ZaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786430762; x=1787035562;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pSBQXzEYuyDcjmx5hDsnhzYgoz+0GlBKVhXcpNXW+Sk=;
 b=hVeOgn4xH8JRH+3dd7SBU3bFFMXSlo6InpaMzrq6G2mix85FQZT1IZP0BuxejG4DFL
 J/w09MOHM4grdYc/U8kvEZNn/I0vFKLOR57oeKLSSgCy1POYttiaRuQUcM+AKad7bEv8
 iYMxLVLdc5TjPXvsfb4/9D7LrlFm5rDiJtH4XEMuJfJEuPl4QUJ30oAY3ItbRVoPW3Yv
 oT1pESwPSOlv/RKan+MuNagwlYocQwHkM9J4JsHBUQ0bunBLYC59DBS7sMwSgWJz+FBT
 f01vCg9JMvAHIQHJZBpAEbZ4CX/gPAWKrhwSBH6sbIqpQ1GpU1n9/Jq3KAh0JBbfk8bO
 ezDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RquvR0vkRN4/KgvZfDpSzosGFX+qv8ofGMm/+1reWQ26wANFKZAXCpeSfkdRW3/NHJmHf0A5xQt8uqW@nongnu.org
X-Gm-Message-State: AOJu0YwgD94SZ88MoJ14bbPmVKj8yM6N1jgN7YNFEQtmMy0DWZlS+lId
 sZheTVRUGbeO8GdzObDf/a+H0UryvyRF/Dxll8SS8aNqQa/ucjTNGwKLoCselvhFJvWpH0zsmjU
 rmLYvmf4TD2lmlc/2z9C5d2UX+DAKaEkvBjpE3UjqQFWgPBcSTc2gfsjtag==
X-Gm-Gg: AR+sD10Z5QOwYDGu1cFeXNunsXa0VO/80BHT77codgr/QzbD64C+WKFWaSIxpejDlhf
 QUrJ3eBie7lpQjEdp/7X5hLwkDs82jHcZpGH5r1wSyRAxKhKUwtmk2QD+bmyFY5MkmEjxn6TefN
 pvbv2cRGd8yIDFEUgaT0xbmEZ3H8DfhuD7XFiyWUtXulW7oX35lWjpRGSx8lbwqMkYE5lqyqLfB
 2HrlCYYbzuqBl3DukXNzOfjqvsEuPZBxhmMEU+Y6YvwSEZr+CcqSrpqchwyZ7mw9u3tPLkRDUhN
 rMq/c9sxthJh5oMcc3KTG0kD79d5G36sAx1ZIMjj0rr0RQnUGk9pCjFtjeat1usjoZ2huOJU8kz
 SBtJ1ABUoJNCNsO1jPHJF4DVCMVZZA5ay+g9QQCPg
X-Received: by 2002:ac8:7d47:0:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-52d586603a0mr7546261cf.39.1786430762454; 
 Mon, 10 Aug 2026 23:46:02 -0700 (PDT)
X-Received: by 2002:ac8:7d47:0:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-52d586603a0mr7545981cf.39.1786430762073; 
 Mon, 10 Aug 2026 23:46:02 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788a5be9sm25844745e9.4.2026.08.10.23.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 23:46:01 -0700 (PDT)
Message-ID: <3a60689e-f645-487f-b5d4-2fc3e9193d3d@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 08:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] target/loongarch: Use generic tcg_gen_revbit*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
 <20260811045605.1246543-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811045605.1246543-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA1NCBTYWx0ZWRfX2e1lqNXjXQtM
 eoHtWOtrlpiRaqL2CHiDtJL4VHRhNRvDkUFlXWrVofHbMcEYvzhdfxgc9LzBs2USwSHxQ3N4MmB
 Sig0YxT2UBLTyv/XfGKMvuq8YnrESIaiQHthlmIudqhoK55zZXROJd1EBGl9dAAFuMpZ8EJMK8L
 JEdDdm6P5pq4nlk0y7jVscRhsciZcwdjG07mbffGt3OU1doVsurKzxV8CiCtywAPGHDs03xezlq
 FlDnXOCz03AvIScojpGy3UByeVjn19QvaXDbF21wFPg3H5wqkc57CEX4AHZh2MHD0Sr04j1J4zN
 7XOjmDmKwFWMRWkKbCBKvQ9jurcDlXm8en2PxCWOXcKrt7IQt6cFDsrFXnkapMy+rP6RckbrMID
 XOK5/9UPvtcvhYURNggt/WeLqjAsxu5vMtdbI4iSboKM5RQK2EDmvB6MKXSAuZ3UKevXJm+VZky
 4dc7wS6jyAvT4P8eQlQ==
X-Authority-Analysis: v=2.4 cv=O4YJeh9W c=1 sm=1 tr=0 ts=6a7ac52d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Byx-y9mGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=c84O9gL3BWOmBE3jjZwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA1NCBTYWx0ZWRfXxJOaIwHdNiOp
 PquKCVlUT3slDl9fV6ergy9rkWZJbBE+6L8OoiBKtVXK/Ny/aN06acmw1/emyfDuy58LSBmDREX
 grmZzDCmFmeUDEt66EenUN7owljmfwY=
X-Proofpoint-GUID: WScjoGe35XviGOzRPH82D_9SkuywGvxL
X-Proofpoint-ORIG-GUID: WScjoGe35XviGOzRPH82D_9SkuywGvxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 11/8/26 06:55, Richard Henderson wrote:
> Reviewed-by: Song Gao <17746591750@163.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/tcg/helper.h                 |  4 ----
>   target/loongarch/tcg/op_helper.c              | 21 -------------------
>   .../loongarch/tcg/insn_trans/trans_bit.c.inc  | 13 ++++++++----
>   3 files changed, 9 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

