Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5813606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hoCcvdg/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MzrYdbUy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpIJ-0002bU-Lw; Fri, 30 Oct 2026 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMpHr-0002Vt-VB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:17:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMpHq-0006WZ-69
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:17:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER7wf3552197
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jocv2bgMmIXjkLqpWpSuXg0ju7mAyp8HK/gaRxNyDxk=; b=hoCcvdg/MGvncpsw
 /7iFOWflB1fZ1rzrNzXlSEONaOp9s6+89/8P+v8nEprLvnh4r9cowvs18nSm7CG3
 c9TbIJDPI63FOzqd7pEon3tXfx3uDoGecgYXfXBBMFbIl+Vby4zllPezw+ff9Vl2
 eEYdQlFbGNYii373+75Y9AOppxEwZNPJq3xc8w2Qwkl8urMPZridILGX14xFq8Ru
 2X/0xs8CpmIrqbVWXXaJzAnjQVBH0qa+gswerEwdycFP4upyz3UNxNDwmr86qQhl
 q/KnS8VKg0GvOEEyhxkse/Pq0wWsUJ19xjgfC58tKq0vplhaFehs2hgF5gfSdsY7
 G1LzwQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkvx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:17:00 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso211351241.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793377020; x=1793981820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jocv2bgMmIXjkLqpWpSuXg0ju7mAyp8HK/gaRxNyDxk=;
 b=MzrYdbUyXep68j9KDysZ182l10XECL3I8KoXtWBuIDGQP61ZuCkSLPl54Wx2VomULn
 FyPi+pB2XrGy5qsW5YGoSGptN6Z8/dqtPVc4If0FsrvHuQKfb+W7PupVAnyM4Kzk4ace
 iTZ8VRSX5tmCVc3+hSKTdrmhKZP/0P5af5aYfEi5/iTBRIpE+SocJIBTq5h+KclCUuwi
 /23W8T1ZW9+KLl/fVQOYEkyDfaEJro0WsqvqtrhJ31Q1BbzTw76iGCEuXNsilTr2LaPU
 3VxU+YVB10hl+IPh6qXb8g7mgkSb5UBZAhnqkjgEEwrGs0Cn6LvUfOHNLcEQ0nS2QGW0
 Sv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377020; x=1793981820;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jocv2bgMmIXjkLqpWpSuXg0ju7mAyp8HK/gaRxNyDxk=;
 b=mdL5hz5PQyBahiRb4UYHVkYLf9bGc9NAMM6ItDZ6KzHNRdc26afVPvzRmO0PVm2SRv
 e7LSkgWGNa+MbtsLV3zd1vbLzze4P6Emi6kovgYJPjXAGVSn5Qv4E+yCc09pOrbaKXmH
 +NHS1e0EDu5RIWmrn8SLSPK2Rk5XYHrGEtTSaylP/qckhGtbkl6spKx+1YOs+BBibgCN
 rWcUeVWBkKvJExj/Pm5Z50ajZWw9nbnyjFi9pG55IAqpiKWd57BYnGtcoaqTTftl5Gqc
 +TBmUL61Sz4WmVRm7Ehg9DtdCtUugF6N7/EqoD53P4SDGLMzoNZw/fqf2TAQEE3R2dSl
 VTVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJoTHP8uy2GXBX2s1vjiGAKTnTJyugRi5FvhRC4RIZ3MgB2D15cBSws61JR+aWqlQ70FjJ/2EcskjJ@nongnu.org
X-Gm-Message-State: AFq9FYIsBJ/2HzrKte8ci2Bgyj9MV5PMUjm6+Lc6Gu/KrYTDDkReFMxx
 QeVPCIMskw2BFS9lPtDIofsRaJwugEfwKKbtm5zhmoo5iNKSpPpBqt96YPZmKusljp/g/2H+mMz
 TC5BNZovscYxmqw/pIQ9QiaLsRlYXzb5RPkNBKGzxsHboxq93tK/aXf8O0Q==
X-Gm-Gg: AYBFou0R70U7EqPVL7dD37NIHEk3qKdAlUvDTeO/7vBWqIy82XED6dlBDq3nLEbnLE6
 nnh2UkV6URA62HLw0xwAOtffc1tJDBkoIOV2z0Rol2LrBlcTOttiiEOBWhY6apxpXt8pUnDnzQF
 RHbXrfWaftu/B9xFyLNtSSEO65iMIn/mG6hfi0mC+XaPVa9P56pRoBQU640BYkzzEQ1iqQvgkky
 +jFiA6jCKEOXeTnDm92iiq5eEgZkhz47Kwbr1tisTz0NLVrDTNqEM42WYNKewGE4fk16USYZdbU
 KQJnoMo+aaKf4vsbzVIVcpOKiXSVehTjyx9HUeTagZgLh//nfAIQ+Qbn67Gdc4wXKlxu2C9TebJ
 tLu/ar3tXXZIXbWGRJ0b1ljpaOqRLLZFLrrscDTUIlJivQUW8b/lZNj5cVHARzScdowHjsuLhQt
 nuJKJKc8yPti2eL7Lsx0n5Rx4=
X-Received: by 2002:a05:6122:e24f:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5ec689702bfmr1495450e0c.14.1793377003780; 
 Fri, 30 Oct 2026 09:16:43 -0700 (PDT)
X-Received: by 2002:a05:6122:e24f:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5ec689702bfmr1494617e0c.14.1793376998056; 
 Fri, 30 Oct 2026 09:16:38 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9eaeesm4079759f8f.49.2026.10.30.09.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 09:16:35 -0700 (PDT)
Message-ID: <0e31509d-78bd-4f08-83d3-0709fc39fda0@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 17:16:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: add glib initialization for SM3 hash
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261030150413.2999685-1-berrange@redhat.com>
 <20261030150413.2999685-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261030150413.2999685-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S5loNBbG8q57fowfvNY7GyEPLJpcsFk4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NCBTYWx0ZWRfXyF33ri9bh3a7
 uzi9YxTqZ3me8rC+6FhOnc7x6pTAdpRrhWTRbG1aHptNqCnPecrimOpiV3bGpMNaqXMjCXASiOo
 jHaMp6v8TcCJdVx6z009xfz0SsM3FfM=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4c2fc cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=MUbxjyihko6WyLke7WUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: S5loNBbG8q57fowfvNY7GyEPLJpcsFk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NCBTYWx0ZWRfXyvpVWJrLEACh
 IcqokwqxRQ+3Us4ahYBuFfnq740WexBDUgR+mPYF0N7MfbCekUKC0z6knyPsobVYKKPhRLzJels
 rEoXY7Ez7FG65brdPENA5zDKMYMZyWBsYjiFUXeSkwRf/lBOvocAIq3kvZPyBmCsUrBJ4CXZR5t
 RuDn9r9CM/XE8Wtegl6f1rqKc3KbiEX30aY25+N7idB0DIxrYUdC0uIwSEhw/YqyUNeW59sA21R
 Kvt7RPszqgqFU/bY2ltQbi2UqAJboT8nLW+V5I+MBq6HSNbrv+1r6+J7F2wuclz94lguAeQfBNI
 UKZqNTQnbf3w1ewylBqNxre21f2KqGAMAo3s7dw4BFCpQYQBBqlD8NdiJp85kqnMACI3o7W7f+F
 uI/KeOaa1tFP7JgWHuCuAj7PKBVCE3hbumcySHJlJeKRwG8wXuLD7nA/ux01B0QcFLtycBl3/fV
 11Shoj7/IxZA1Uo9+MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30/10/26 16:04, Daniel P. BerrangÃ© wrote:
> The glib backend for the hmac/hash code must have an explicit
> initializer for every element, as the default static initializer
> of zero maps to G_CHECKSUM_MD5 and will lead to incorrect
> behaviour. This could potentially be a security through use of
> the wrong hashing algorithm.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4786
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/hash-glib.c | 1 +
>   crypto/hmac-glib.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
> index 809cef98aee..39040f1856e 100644
> --- a/crypto/hash-glib.c
> +++ b/crypto/hash-glib.c
> @@ -33,6 +33,7 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>       [QCRYPTO_HASH_ALGO_SHA384] = G_CHECKSUM_SHA384,
>       [QCRYPTO_HASH_ALGO_SHA512] = G_CHECKSUM_SHA512,
>       [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
> +    [QCRYPTO_HASH_ALGO_SM3] = -1,
>   };

Should we initialize the array with range designator to prevent that?

   [0 ... QCRYPTO_HASH_ALGO__MAX - 1] = -1,


