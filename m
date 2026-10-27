Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BE606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N066n8q7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CdOKYTZl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXtE-0002TA-Hs; Mon, 26 Oct 2026 23:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXss-0002AK-Ed
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:30:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXsp-0008Jc-TG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:29:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F2bh4151965
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VyP/oAu8PP8Xz0Xs/k1x2xnWMK01hR10s0O2XqB1fpU=; b=N066n8q7jd0NJuRp
 o6lBuJilO0MP0544tQ0jNhDyeVDkGBZ3en/HLKXC/IXdnxcmGCJi9dDPiFXRskde
 VhgR5Boht8YaQ0FMJbtYnEmT7m09bxH/GPiznLQbtiYgKm1scfLlDpSLwVFYhvVs
 UtRF/bO4GyyEofOEwEfL60WTeHeKlmLSxTWnXBp6OSLmHbYljhT5rpMvnpC2pnEt
 OHsd6kbwebazqxZ1pftsBtqTrEK6dox5YWInRwj/ztpAt2AEgaGuvV1uwsk4+/9Q
 TRlmY3hlI1CUqka9s3/P7sm5KxTBMVbWo9tMVjvgsZiw729plUxr92psDFLGXBcC
 Px5qFg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u63say-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:29:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f20addba1so732077285a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071793; x=1793676593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VyP/oAu8PP8Xz0Xs/k1x2xnWMK01hR10s0O2XqB1fpU=;
 b=CdOKYTZlTZoCHpdgm4K0JEdIKbadlkvyVsU1P1Fa/TuRyAerGXbokIDgr7mJozzyS7
 WpBd5Ogq85rPP8fXeA2NnYEds9BNx0DiiGQMt23+4djhNJ8eZ4Hy+BdL2jZKmGcusInF
 QvXMJZioJXCZJD7cZtj6QurD42FAVBqpMbPJpydumZ930NnAAzCdWe61Y2LO6OaZGDEp
 dNFZixDzqegHV/ZKPLLqhZnomWdBA322t8qSIqYgJP0DVJFV3W0aHVS32k+bohKR/gOi
 DIFBLjI0c74OO8trlrM/UpBFEZtmoev+Wvptx+P2byWqlMHDbDM2ba9wPejpFBBIJzxT
 xvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071793; x=1793676593;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VyP/oAu8PP8Xz0Xs/k1x2xnWMK01hR10s0O2XqB1fpU=;
 b=tSAjRxZajuI4tsWEg51GPLJpYfNpDNY6vaZP4HyehlNQGBCSk86yrXIFanl1vB5Iod
 G7JNp34r70Qy36FquuCkahRkeafwZX+JAW1C3FL0nK+dSF/6PvOVI7skH+3r95f0fqf0
 gpcOq+DzcqtPWmZUEVAb6eOiRU5UjHrb17FiT0HBl5v/Tfvlgj3ekWK43OMXcEkmdgtp
 hRTQ0UcfPNpEeSZBMPTNNuqP0WnAb9ImbogvYFQHKZz4fyQIN4LqkrVu3nTVTPGRuvay
 KaGPo4GMpFSOxIuTz+50/vQVK2BHGrIvGZkg7uI94akuTcpxQ+r5p6EMWamsocUGhUKC
 Ec+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwX8G7Ne6HWVLeBvEP3JYKtRyr0YrUnoxdLUBA5ZQECDR+2uQ5/JubNZUJWD7jDlmtud9cRjNlDePxx@nongnu.org
X-Gm-Message-State: AFq9FYLOvnAlX8AIGIOtmglVb+u+3Z03E2bsn4orjw49mYluCbxGUxjV
 BKqEsD/Xsy7pZjBELK+UtxKnRWYR0MYWeaNRwZIBxa28gXfKOSLr/AmxlcCyNOuJrOnE5R6taPN
 yYfUyVU7nb9hwlNaDlneLwNoVQvnEm+RWavvUVIvOwbeV6LWvaE6sSMqiMw==
X-Gm-Gg: AYBFou3xnWbzl5tFzc9GZrzwRTJfszv8nKdDmSxDtSTdFjP1O8sKDZgAgaU35igLtMM
 5MTPqyGVdF6hrcSX2xhDkrY819PEWuUQrJvqzidBjYW8z5TD3WXZxmAMBc+IgsAzPb+0Hzgo/mB
 xJekSFIr1J0uHUkki2V9OZQ3JuYCBc7P3zVE/8ThqEqrJ3rSMLv2TkiMsFnIVbgQ6Fq7gmsYiV0
 PK04nnCHOyU5uSr5RabKWf4dQFTgLfWckjexnpB86tKpcKoS/8/ScK5aGwB3TUJ5KFuBW4P/BHu
 VXLlB1/XLjjeRcsOxo4Lz6+qPfypqhvDtz5yZ1KxSbwGfYow9PHgkepOtJvbjHZpkzhfTWle8UA
 KUXC4zsSIWGXV618ekHTNW1GrfnbYzpNTlg==
X-Received: by 2002:a05:620a:4010:b0:93f:22af:cce7 with SMTP id
 af79cd13be357-940ef7af322mr1306042285a.12.1793071793528; 
 Mon, 26 Oct 2026 20:29:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4010:b0:93f:22af:cce7 with SMTP id
 af79cd13be357-940ef7af322mr1306039885a.12.1793071793069; 
 Mon, 26 Oct 2026 20:29:53 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8dcfsm19849990f8f.50.2026.10.26.20.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 20:29:51 -0700 (PDT)
Message-ID: <8012de2a-0de8-45c1-8890-f0a1f495ff19@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 04:29:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/14] hw/arm/aspeed_ast1040: Add I3C as an
 unimplemented device
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
 <20261015055642.106204-12-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261015055642.106204-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v0zEyUcovOfab492csPK-Wp7wg7etm0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX4Yd3n2aeZODv
 dkrzCNirJxNHXWzOHTvXlKVmfAovpPNkKT4Iz7PxfOjiwnGir2GxfqegwFHI0PUjzE0f9OsjmSP
 kciWojXq0Sf2IRZfEYILaJElkR+VKlmSrrEwMBbBZPPN2k/J6yfizdXrAstfGGV3GzHahZZ+iiC
 fRz7Ox727MEU3Dxhxxct/k9smLqfvJhJJ1TZwzxJ+Bcda5IJlUESdanYTiAbnvRmOkLblz/pu4v
 PGurRPyv6Gca9PG5QWG4s8+3JSHLxu+1zILBgNoAljdCgE/Tu+8zMd2q0NruZSq/IiQLgslH0QZ
 gnEhmTy2Jh/QLxYrffMEJDFtL66d7/hDgtlZTZ03X7jUQVZ21zrt0Bg06GWUDhXIlCsW3KkZLCk
 9Br50/MM8Uo9u5Jk4osP5a76eUzpxD9/c/mQ+ZVy/BNuDtCkg+mYjEwrri0oI3alfCS4hSn6sJ4
 +rkekXPURd0fCg5oz3g==
X-Proofpoint-ORIG-GUID: v0zEyUcovOfab492csPK-Wp7wg7etm0h
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6ae01ab2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=DD068z39KEkKQDAZABgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMyBTYWx0ZWRfX+lez14wwZXoB
 apW4j0gtkMxI+mDL+0tqiQ0hrthfR5IxlLoaEwG+x/l9FNrJzRUdCZdQalT5DGU1t2X2P3Ce/pT
 gnp+Bt0cf++dwyNNM2ZOwmhoLy3nqYY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270013
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 15/10/26 07:56, Jamin Lin wrote:
> The AST1040 provides an I3C at 0x74c20000, but the controller is not
> modeled yet.
> 
> Add the I3C register region as an unimplemented device to reflect the
> AST1040 memory map.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

