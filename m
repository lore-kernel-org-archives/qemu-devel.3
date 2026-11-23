Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144C606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ixcd5ZiA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bU2N1I3X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVB2-000267-Oq; Mon, 23 Nov 2026 09:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVVAh-00024v-I0
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:37:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVVAf-0002Tu-C2
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:37:30 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKwUo1937645
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l9Ecz6RAIJ5I6f55f1eBL9dPrn2qSggSrC0D4zG5oHc=; b=ixcd5ZiAlchRNA4i
 65sryq4o56uU3Ml9XQ8/dcKFcCpG9pSG2Ao6hgskSl+Pby4O5PdO+afi48EcceGE
 xBauRb8TfjlFPXvYNyFOUNmIMVJ83eMVrIuXodD5EbsOWlsJDrMuAaAEr2lb8iyS
 oH7hsPK2sV/wkRZxsBpcCD1Y6JyJUehPVIr4bPG9lFO/i36cNYIdCQHjOsr9owvs
 pZhSnjmRf+AF9kqyy7jMowKNkJXXcGF/kosuFbletADhDTG2CkO2bXZvEtW0luxw
 HYYKlvzZni0ym+wNcCMv08EeH7kt1SNrY01VhqREpE9GfFTpIY4mLQv8j9zkMDf0
 0h/UVA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx2229-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:37:26 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so2977123e0c.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795444645; x=1796049445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9Ecz6RAIJ5I6f55f1eBL9dPrn2qSggSrC0D4zG5oHc=;
 b=bU2N1I3X3eE+RyBieR6PZFSYTRGp6bQwLYKCIvLZlFi8U/nWLd3nXpzdWSWPuk0sYu
 yroDHsR1vhjrCwgmFv03HPP08yLnFIe38i9x2Z45okkxRzMlov9Ab4ZPHxpphbEMvSlk
 0et3UNal30WKudFvySgsdzwjZOeTeCvLatUvjUPAnQOVytgAbHthbbnTncS4oMVyfXFy
 Y2cieksBqK1Wzc5DrCbKIUOW7C3PZOQumIPDNlsFUzrxywJV+aya4Cy2IDQZhA24hde6
 dANPAmvjLicaT+8Xq1qkL0E61E0X8V3X+KU47BO4sbOGdi06bMfz8kcdfuwO2DhQQwds
 aibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795444645; x=1796049445;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l9Ecz6RAIJ5I6f55f1eBL9dPrn2qSggSrC0D4zG5oHc=;
 b=cdJnuUGEAjNDybjpArnXUkvPBKaeX1eAZmp7YuXk7EBf68x2VFF1IynXtlPvZuZ8Vs
 N4Tivl6JXzawrUngnbUJNzCN8ruvwo2sWN29VvwgTj5/FlDU/NofurECeoyO4/9gBOoN
 XyzcJvxcI6xcAOYmq5q1uBaWQrNeZJBUfnBH3o5LmxpUNk6m2e7xY97rkgq1caFehMu0
 2m/4hTunGbEcrvx7Mr/iJy1iWftySewVWDUCkF4WfAzpAc905tKiLikY+AqZ5eexSCxi
 q3ngfD+/Bj3nqQYn5iTQuokTQOlwolllsuKyA9sDqxTucH5dt5qyQYXWihec/rFhVboo
 XuLw==
X-Forwarded-Encrypted: i=1;
 AL+hErFvJDFr2Zx5B4JFrIc30ofG3gKCK/30OoDehEy/lbj24JzCbfcgf2021nYFe2KWspx7t6ocI2C0g42p@nongnu.org
X-Gm-Message-State: APuU4Z/R723lnDEwPkstPYO5dXteVelRPNTogPR/G0KkWvZ5r5K1Gmlw
 NyAo+RCnrhGm5eFjp8CK895q5j9U+N+WzR0c9NOkJDeITg8V27oGSz+bzEJMx/oQGcD8M7nZSgw
 Yjh7HnCg4MlP/IwR4PVZPhNDxb39iCso9xH8IAOBBwWLxZBUqBYfoCWB+Xg==
X-Gm-Gg: AZFdTZdx6h1GYPJ3I8tMqrhkCCAaEe6x7tqZTK9FU8IDlvmAr3o1SPeUFeyIghWo/dE
 8HlxleDOfL3BA5vWwfAqhUwcQuLIjd0noDSp0M0q3LzjZobFBC76zy2yaDsLUPA/I4pINN3E0jg
 jOk3b74wpYKR7q0PuJDpeU+wvXpQpw5zBS9RryY4x45+X5AyO+YmyjN1eqdLGq3xhS8PayLk5wr
 8CEvNnDsGIiqke1g6kTVr4K4TbAa7Uet6ndgK3eLBKNEo2lETf6/wS697MK/YeE4DejCXAtTJyD
 BJhq9RRoH/F5nrc54GXs8h15eJo0Gc/r/oAuycxoZK/RT/k45RA/icrvqPhnqGN6dl01UPXYvbr
 mcfLWzqEYtI09jxbWxwnZ1OA2y47oZ9ro1N8l/PKaVwMCFi1Vbib4ht7f6l2svOl7xt8zRVGo8g
 dFlJm2IEc=
X-Received: by 2002:a05:6122:421c:b0:5ec:bdfa:8f56 with SMTP id
 71dfb90a1353d-5ee8aecd19cmr5403132e0c.11.1795444645413; 
 Mon, 23 Nov 2026 06:37:25 -0800 (PST)
X-Received: by 2002:a05:6122:421c:b0:5ec:bdfa:8f56 with SMTP id
 71dfb90a1353d-5ee8aecd19cmr5403111e0c.11.1795444644955; 
 Mon, 23 Nov 2026 06:37:24 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8960068fsm131363045e9.4.2026.11.23.06.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 06:37:23 -0800 (PST)
Message-ID: <0bf650fd-f998-4211-90a7-824fcde9b361@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 15:37:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Daniel's entries to be consistent
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20261120182200.789086-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261120182200.789086-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b044fa6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HaSdnJhnJc2_BtW3-VIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hH4tw2PJiHzTuIjXloFoiUVvA-pIRh5f
X-Proofpoint-GUID: hH4tw2PJiHzTuIjXloFoiUVvA-pIRh5f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfXwAGDs1a5AA1p
 cL/MbO2dRJSf6yS/desJJlxK0TPK+MBIbuPZ5oQJ8JASiPCLZaZpaB9ub1FGVQ3A+g8NcYRsmFN
 DcaSUZ5WT3wKfiwOdRVjMLA3E3Ar8+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX8H4hfAp3F0uv
 DRxHhkcuJmNgD055u2jkNyr4SatHw1IeYb5nMVGs1G2oT5lAb6AE0KyREnHmShzAKcAPj6kDW3u
 1QdRKdiwiQqSQjgIebrfnJncAitNwEWI3zKuqnixx6YPlD5CgbE3TOg5c6Vzm6sJme5A3u2RsjO
 e62Y+pSQ73SsM2aZOj1XDMjVRZa/A76gWyXCVMF1yDTiZkaKy9mxZ6FyLFYaLXxChzzNIWsxOk3
 pN7dUHO3j75fb2kb2MX9gUCBaIzhZ6eyW3MpuGP4BSqQtrRMlatqkSEcp/l/5TW11xVAitF666Y
 1oIRMKA/Pf2f0koA8f+Hq32Nwc420uatQPlifYHKvfBWh/hkm9+rQKZNNSFq3FqTXymb4JF0xf4
 aJJPciZ5Hb+66ahN4xgY56t6xSZayfFK7bXGWTcVSMRPrOBPfOqONZN4gOaZnnh+8ek1ynNINgR
 1aBuTyEvcYwccYZ6VrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230058
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

On 20/11/26 19:22, Alex BennÃ©e wrote:
> When testing my get_maintainers.py I was shocked to see:
> 
>    ➜  ./scripts/get_maintainer.py --list-absent-maintainers-since "2 years ago"
>    Maintainer              Last Seen   Email(s)                        Subsystems
>    ------------------------------------------------------------------------------
>    ...
>    Daniel P. Berrange      2024-06-10  berrange@redhat.com             QOM, QDev, Seccomp, Cryptography, Buffers, I/O Channels, User authorization, Sockets, File monitor, Functional testing framework, Build system architecture, Meson, GIT submodules
> 
> Which is of course incorrect but tripped up by the fact we have been
> utf-8 clean for some time. There are some entries that are correct so
> fix up the rest in solidarity with my fellow utf-8 using hackers ;-)
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

