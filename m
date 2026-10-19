Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C9606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZIf3UaSY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fQjElsEw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIw2p-0004Qf-3j; Mon, 19 Oct 2026 18:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIw2o-0004QW-7l
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:41:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIw2m-0004C3-GP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:41:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZb3x200498
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YwSxhhVTsQwI4NF169M+ws74XhOpoB9sxHQEVhHo1tw=; b=ZIf3UaSYfLQEvHj6
 45gX5S90jnGQzhbm0ze4p3bv39oM7qerBwlIzGNWnilq0vu2G2xtNwtj4mIW9dzv
 k/+7imRX5gpLz0qRkc1ed9czEQOF3NZ7YQjO3ytF0CzS8V773n16UEMst/yozS0t
 H5dGDFFwAF16kSauTSujLSfWGjzvNRrP53wAWXDleXo+QxGIWNimM5Ct9U+kMsKv
 7I1zPHzQqwAkCT9oO1bmshMz1j83gAvFMJrKGHThRDgJ4Smf3OwihlTH9HPU/JMt
 fSTBajlKCJvrvMHvugj1kvajqxpP6LQAry6mk741zH0voLSRS/3/43bFNb8XDJBO
 NcoybA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780w5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:41:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so71039eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792449682; x=1793054482; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YwSxhhVTsQwI4NF169M+ws74XhOpoB9sxHQEVhHo1tw=;
 b=fQjElsEwlyNajmNylXp9003SOdNPS7bVsWsglzTIzC6PxQL6I1CO+ZWsxClgK5Cozv
 /reeXzYXe9XRVvaia2gRl1G/py5eoBhqG9fNeniQ6bDY4z8w3pLGni8tZqyp4SqwRnsK
 Zj5CGT+FA9hOUCu9lolsEe0cq5jIuTxMqPc2L+daPZEr2WpjhJ6R7uN0/BE6eMFh8aCT
 eK3k9jyeRo2OtlGUb0kdTCufAwkH3cKyb7hqlPC4g7GYc1Eny/Vs6Q45TRSL3VfTAbUM
 ZVsLthOMpV+Vg7BLDXzCftCUT9dClfnBL5h18FgH6l1q9ZpxWeqYbeCQdjg4eNlWreG2
 TqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792449682; x=1793054482;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YwSxhhVTsQwI4NF169M+ws74XhOpoB9sxHQEVhHo1tw=;
 b=rYH6NoRs0j21U5RIsz91TANf/TM5JE1EsmHKGU/KYj3BE5L+SPm23TU9LKIkWLET1d
 crL1ZaMWTRQUtgx/n81ipg2nslRNBhdUXcMDmFa89p4eYjY9t66tFjIZzX2yA+eIAG77
 cgNIFEAtdN0OndrKbr0lXsaL3iRP5wZnq/Itbj5SiOm2TRaSm8WctluRKKaT6/k0U7Vo
 2RMA7AeaFirxre4bvgpYqkR1GuHYtxS0J3eENo9RJNJHjw5fkKrmB0QhvvjubRYFoxCV
 b0D58AwyNdvqnO85e5N/5GOUPJwZV910nQLzpwQ10RGPEWwTfJbKULUVu6djsYEdE7pv
 M01w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxu9OvSlI7K9NpI7vhLfzo4OQdqJKbjpmqJmt+MkAU7F++a/qbLsXQN+cEZSejduMdlKOxLNXhv7XtH@nongnu.org
X-Gm-Message-State: AFq9FYLE3LJfXL/c+pqOxDGMpJkb10J5Es+f6C8Rz4PpolhO0VNrBQ5P
 KBJK0EkFgAt9KXe5DNSdxPFV+yARCr2JGiRihw0N3LcKqkzA43b0k885qaZy6n0+ERA52oFty0r
 siw0byOfWTCLrjJ+mzhbo/5vWAmZL6fl3oORd30kMSAWkJxB2dimwK2hU2Q==
X-Gm-Gg: AYBFou0wCsw08zxrsgcJG3q/YFIr/kjCDz/skpF7bUFqQTaUg8oPnLXyQTQFfYFbfoC
 Y53fHCMRiYwlANfPA6PJpEuemGMt5dTWdWXJYn4HV78A8H4RPuDsPZx/vGnq4fSh+yakcGxJVgk
 V4kKbamBfmYSjuVwwu2YOkJsuI+ajZdSD/zkipEFZbwOBS32j8DujLF5onQwSVjRy88KzJU1kE9
 6hnM0bLSFQDyIifbKcWIY4RjdDwaugy6h+tJtbE41Om5bfsCIoLtkK507tbTnOCWCXNg5AoLrfH
 LSRnjv4DX0q8OqvhYBpGDTDtgs+5+GjWSAgcw7I6O4jXjvpey/TJpTeLDi+Eq2DIc71ssEHEDZw
 8Sl85AeV6RPHWHETcds8Rt7aCUho+9wrwW83y/T9bg4KkP6x575/WCfV5ekIITjpkvTgasQ==
X-Received: by 2002:a05:7300:b085:b0:341:225b:d6f with SMTP id
 5a478bee46e88-361a234315amr12921919eec.19.1792449682501; 
 Mon, 19 Oct 2026 15:41:22 -0700 (PDT)
X-Received: by 2002:a05:7300:b085:b0:341:225b:d6f with SMTP id
 5a478bee46e88-361a234315amr12921886eec.19.1792449681840; 
 Mon, 19 Oct 2026 15:41:21 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360826875b3sm36972220eec.21.2026.10.19.15.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:41:20 -0700 (PDT)
Message-ID: <2714ccfd-d946-4bb3-ab88-a595dbcb2857@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 15:41:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/hexagon: assert qfloat shift
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261019223253.3243067-1-brian.cain@oss.qualcomm.com>
 <20261019223253.3243067-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019223253.3243067-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfX+g8MWXE/Fugv
 ZKKVNwctWKLKSMmZrIeEKeG2pk1qXW2+nMrNDUb5UvIWsWllfeIQ5+kEFJ8QMYIk0IRq56Cndzc
 /Mf8INDqAmGtSt/8YW4XnpT6/xWv6MnwLHw3d/GzXH0P1EbNKZnwPfE1TK5F/EM2IkYLkuO8G1h
 2EE50B1U2QG9NhC+ZrNLb5URpe00POS2ctVF/PxvIrD66DfQVOPsnqEL5ARCqaR9C4IYlP6Y0ZL
 haoxhhxN25sy1OlOJPwGBl7WsYhxwY9hY5JIQtUfFXA4Vxc24UMLPUfK8mfdsrfaosgxW0ibpHp
 sDA5JLvvTcYtfcnq6464HhRdGYPM7TZu7rlJwUXdrXUm9Y+YMlHz1m37CJxxlX5xmV+B/QLUJxB
 3lmg+/Tiz2G4eq9TGAv1UjznyNqVfy4eJfligp0Bwzq8lERiaq8o8jgyQvCn2vGhCshbmZZRAMp
 CT/uQ9RUyH8JGJmsWOg==
X-Proofpoint-GUID: 81APVfI6sHFEQUAE7UX0VBRP3sXGxRqt
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad69c93 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=eLx-3-Ot0qTZY87SafMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA5MCBTYWx0ZWRfXx0akdhGv1f0p
 jChKTHU0jSlLjbuUhdlr08ept/x0OEztWuFmDB+USWiVgIswfC0WY7hzzfx/bzgoaYgQClHkb2z
 ckoeTJdggc0OP49hZcq+uxacf7zPNtQ=
X-Proofpoint-ORIG-GUID: 81APVfI6sHFEQUAE7UX0VBRP3sXGxRqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190090
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

On 10/19/2026 3:32 PM, Brian Cain wrote:
> The midpoint rounding thresholds shift by "shift - 3", which Coverity flagged
> as potential undefined behavior.
> 
> The legacy add and multiply paths select exp such that the normalized result
> is at most one bit above it. With the largest legacy fraction width of 23 bits,
> shift is at least 41.  We can safely assert this here.
> 
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA_WJ-PYCfiiu44uTQiDoc58_9Ky3uEd-9g14nPgDPT__g@mail.gmail.com/
> Fixes: 2633da1e127f ("target/hexagon: add the QFloat logic")
> Resolves: Coverity CID 1688240
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_qfloat.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

