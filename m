Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F9606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gepqhdM5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=afYwi5rc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMALE-0004k3-Rx; Wed, 28 Oct 2026 16:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMALA-0004jY-LW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:33:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAL9-0003zE-5a
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:33:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIkCoY2546706
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jOuRiaQGHwhYUbvCCgaU1Lu/IXwNU6658XAeNPbV7fk=; b=gepqhdM5hjRufYeT
 tvD9YqhFDY0966yf6q67ilwAXFvnOE5u8zVfWrQgI3YaiUwMAaCLPezpahIGD6de
 hXa3OwgQnGmrxlb+l9c5mpc5klYlC/U+59C+cdlm6AnGEk4EfiwHEIsj+KIJmyAi
 tzaxqqY5pWwsPFuy0sSD7lg/OkCUknODX0ELPaBrWOy8Imash8yayhcpPVnwVQPN
 9xC7SMaFe/y0f3ESIz197k54w/47kPY2m80L6NzLRDOjgKqZRNACi/QOkG3qXp46
 Wx2AaRxKU3tLESY91bczwsJDiGvDmf3avI7Hp8g57v5dT2yexRtT2p6MjUbKkvsD
 +ETapw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc0d03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:33:41 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so4659121eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793219621; x=1793824421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jOuRiaQGHwhYUbvCCgaU1Lu/IXwNU6658XAeNPbV7fk=;
 b=afYwi5rclcK2pcNne6k8tG64v0VJP7ESQjjnto5zMFLVUq45qdqlJAtq7EE9EtdR89
 Z6HQrwLfX5cHOw7/NyKDrWL3daCflbAhp/qaQ6iiw/AA2vX0vFUB72DMdWNRvBZhSIhI
 uah9YATj7x3ujpQHkVmQfwdeg4FGzAd57oNJf3gILgzXu68u1QsqBp2cj3XLo+4Iz+zK
 PtWBoIHqYIId8nsR/jViyuB9SpEZd2DpSQsiUQKZIx/F2Mx2ycuyFmWtYLKER9WBUeJb
 7j28doYVhyNN9SdstozqY/Wgz4Kw1nEnoLi3mmT0xjUvxZthOtTgbOa7byeOqDrkhtAB
 j1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793219621; x=1793824421;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jOuRiaQGHwhYUbvCCgaU1Lu/IXwNU6658XAeNPbV7fk=;
 b=CRuLp+z8mJCkqhPNEZGGnD7bhISf3liBxaUyl+xQ2cQPGa0EgWhWCSRB9cZsHQX+4r
 YXKaJv8bxqsl3huY06rTXQsA+Ogc5vhjWFhaR0TAGTrHnIEsWoYfNQUP89OpduY3y4ni
 RjtqdxGYNYnTOgD5KcUP05BrbUAjqlWdQHF6PUJeokxRu9CEYMVXENSQHA4GqVEffyKp
 PW2/vgeojY6Vpeio1jr/QoRS+s7EBSrO7WOpboe4vQR+XAe2PaO66H5Xjy22TJNN+A06
 V+i4ZPdGMxyn856JCgUszhjM11vE+X2Uk5Y3dOqo9eEI6abEAyL8DHpb2bYPOts0Gvxu
 z0jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZDFnor9nJy7q7mn1M5H5mqYvQKQZgm+5UX8GD2hRKglpn2Z7CjMTJlr+Pouj06TAR4fFD2DxKFR29@nongnu.org
X-Gm-Message-State: AFq9FYLLFIXEd864ofkGfukfzVOIQhBx1aY7CMU8AXR9+oQowuQK2+k+
 BxLLbzRcg8IWHU9mwBxxomaxfzXBewz3jTA7dXy0ckSemy6ZrXRBqxDPHo7wwnpXa1BzQR1v98O
 gaSgYSFazoSbi5a3GzpmcYgDj8WalmhxNvpF+Du3FZvwTkv96rIqbTWdbMg==
X-Gm-Gg: AYBFou2AD8qumco13iAPUFbu3wzU1u2IL+Tu4mRdPnKEzwlZr7cPHbPJs25LKphcSJz
 sYJvMIRidnXtmyz2ry7ORrkhd8XhUeMcCHH0VVl1c5tspWqopt3QgpoX/sUIa+RBn+g8JoamLHv
 3gpXwPQvjo0qzMGLU96tcMEAo+iRoy/i4vRBe2cCiPvqheb+9FiVWh7K2B7KcGfpWCtHzGf08+s
 bXpnfA+R2okNvI1NGtvVPIoymov1XdemI2gLcto+TVAZ1aKIn0gLw7nMW6ITj1s8gDkngo4deDB
 tyc+NniWeZ3B3Xpbp/+J48oy7KOc6A59TyKcJbRWDBmyB5jGqwI4CkSBoasUYExQj4sm0uLRUS4
 jLBBR5lHTdQ0NR8n72ZlqbG1cEnfQnMZIEp1Fq1kUc3PmKPuu1Rr3GAqMY5DYrbtblIw1E734oE
 vATwNA4wuH0yGXqFPAZvbBHoAVV/LanJviXjECjkwR4ew=
X-Received: by 2002:a05:701b:4511:10b0:194:b2e5:473d with SMTP id
 a92af1059eb24-1a6c7e20d4amr4486675c88.5.1793219620832; 
 Wed, 28 Oct 2026 13:33:40 -0700 (PDT)
X-Received: by 2002:a05:701b:4511:10b0:194:b2e5:473d with SMTP id
 a92af1059eb24-1a6c7e20d4amr4486625c88.5.1793219620000; 
 Wed, 28 Oct 2026 13:33:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75fdc1031sm8219801c88.19.2026.10.28.13.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:33:39 -0700 (PDT)
Message-ID: <a7f45adf-c36e-437a-8ffd-fc361a136570@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:33:38 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] target/mips/tx79: Fix PCGT* (Parallel Compare for
 Greater Than)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-3-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae25c25 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dB0wuP3aQQf3GVAz7oUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WtNNP1D90EoqLKvCkDcxAbr949BTL9PL
X-Proofpoint-ORIG-GUID: WtNNP1D90EoqLKvCkDcxAbr949BTL9PL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MSBTYWx0ZWRfX1ULVIF+yDCmK
 2/C3I/dCkE9DSRLIzWT6nMR4RYkA+wKwAmRYtHL8TYrK1ny8kKzT0g2xJ7RvSp9q2B/0lZS9apH
 z2uUZGrNDin1CHcNKMj6Onf0cpWjqNBpK/4f4sniezHPTsxrVW6v3im5hLDrAvWnwk8btRvgAtc
 /kyCUSg0qrdgwCEvy1Pom+hrk5E+/Q5Blf3xNXCH1GL8LNFCVlCAN63GmEMi9R76T06WzK/UXv+
 aKLSkFratTG4+DE388R7WBA/JJnmDWbxMG9+TgUGHjHbkegS7XrQErc9tWb8qi/dYDkLr7kBcF1
 9W1RZgfcvudotgJ50PfR3liUBcpTn3+5mKVQ9S0qPvX6RR7hTqMDNwtfOqYKfk8zT+cw5axjWQo
 v3ev696DcnwOySu9CrQgd7dOjTQ1BFGxwQ3V9XYDIWH/SeqyHouQEUte8BhqzoN8A8th8woQybz
 XDTDpNJGpRqfUdTE7tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MSBTYWx0ZWRfX+dmgFTZmSOYQ
 yQfKH3CnmTrfBoGLr7uSF9xJNCJRe9ujVcI3vUdFQVG953cq1wikD2+K5svwIaofxPioLbqThRz
 MmAbCQxU1fMd77j/EI4A5FXZzCDMm8E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> PCGT* set each lane of rd when rs is greater than rt. We compared
> rt >= rs, returning the opposite result.
> 
> Fixes: 8bd42c00f284 ("target/mips/tx79: Introduce PCGT ...")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/mips/tcg/tx79_translate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

