Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC48606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=deADzIeU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BmGDrFSx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaqa-000496-Oj; Tue, 27 Oct 2026 02:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLaqZ-00048e-4I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:39:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLaqX-0000mt-4P
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:39:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5ZJNt3950112
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 06:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iGhIA3nuLqP0sd/oxi7ybGmv+3c8HTvy02P7/8oCRTg=; b=deADzIeUBd313Nsa
 r9c5EK4DbZ35/q/bMn12xMyxH7NKCtQASnyC+vubvXKn4dXwsbzdyEnPYRefPkRp
 xpkWpxT/tDTv9MIyGUmt/qVbaXIL9uzpgs4UDVxvBfTBEBL+kOsGfLwtcDNNA0+2
 P/tJM7uRP/L74YdEXEobd/58YrhOH33ojrv01zKXoGfB/Kutgy45Am6PBRXkryM8
 NXW1p1rB0fsL46lXaxYwvkunQa4GtNC9GOoHIe1E2c6h3pTwFa7Is+3MQt6Qp8TQ
 Bp3NvPDG6Xj6/WY4xBBBjeXK1wJfNe98bdQKydNRslGwctuzuVvvDLnz7xMI2oPn
 31d0Hw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54jesq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 06:39:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so140012385a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793083179; x=1793687979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iGhIA3nuLqP0sd/oxi7ybGmv+3c8HTvy02P7/8oCRTg=;
 b=BmGDrFSx5CW/ICdoznl8zghlWbHQs5GFgZgdSGXa/mVr9PKx6EmGHGGqMc526WSnRK
 0JAJCPriqfFeSO0JoeKu7OvjUNYgtZjZc95xGfg2PYhxSafrha3b1MaM/5J+Bf2197Ou
 yVsUGaj0ZzPlplqXXawxI3F67h6LTV2OBc6XLp2mcZD7Mt+AOTBDU3aARl+uhka3lzEH
 z+dQkl5tok52qp3ji7zDJukD3t17ymHF13kIW11qDEsOlpNh1lSCwJ2Z0/gaMHlaCPcJ
 JVYJUUPbH4GGWDZXC4cI8xLLNndvIWTjM7yDqGKlSjgdv+yiljrIsQiXRU8hUfDu4ZzC
 4Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793083179; x=1793687979;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iGhIA3nuLqP0sd/oxi7ybGmv+3c8HTvy02P7/8oCRTg=;
 b=bYPYpXX443hn3RTteiYlHGrMyBzkkbiF0nxPXVDbeIxeNHuTrAF1AqJ+Rlluu+dgFN
 qiEakwa5a5I+BJsFKz5RKpAMpDUS8fHxT22BR5Cbt488mw65p7hUtnn9OZgaJBeVpwt8
 5QHDTjzaxpWdPmuog6WJ+Lmrj9XtL/P9St3gLTuwm1ol9Gdt8iSFxiwqkBuW2uAQ1oqZ
 JPNJE6cZzg64UX2N4N00rKHomM1fiGCoKVzKZYFKWIkXRDPbIbwVPdubPDYIlY2dxxAB
 l2jjg7ypbnNZSHHfMvn57cizRTNSumjpaWXwBZt2i0O5hvFyrOMf0rpqNcBqJjMPuAWn
 Y5/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxktWl0grZu1s4V1FMD+eYm4rf2Cq6g+/xvlXo/ecu4BlCXb+tEBGGvFuCsflznE0wS/TfQmNLiOYeg@nongnu.org
X-Gm-Message-State: AFq9FYLsghZRxP1eO3UNx6+J4wVuCBY5oE9JQn48b7MmJqdafh5X3VQR
 YZWJDjlSGX9uuOZca7rk8d7pBWsb6p6ZQt9qSx2s/cypcqiHlSg4LbNO+l3xAYV3Zh/N81RyC+b
 9uWWkxdYN62zIZfz+A7QK5gWjJ42J+sgmTvJLQkD+ZkDIGi4ZlalJRaCw1g==
X-Gm-Gg: AYBFou3zRCr7beCA2Y7Oe6n2UNNq784TabEcEdXn946X5UBsi8snOnFFd9b7/djdRam
 iyaPPoEh70ZY4FB+o2j8qvmiK7ohX3i/EZxnj68QAtUTnnWxQdtD+rPA2N1qh32Nk/zjZMNm9Nv
 W3NgqjuDYQABGrC8kNYLPOLihbLG4pk2DJwlnL2SiHXtj1ZzPFb0tQp5C4dHtbPLdM+7BHAqOZu
 gmPhR4I9ES2sQcH42a7dtAhkorwQFDgMc5TAnmYfmHM38R6eiNhnGE12YuolAnmfs8m05IX8PCn
 JIlxM3Rm6VGGTJ0LBn0dJIn+wOkxoVqfdY6RyO9IucGmu5ZH0EAwqxwDz0uOY0za0uQ2yZyjvOz
 ggiPwrpjXH1EZ3E8xgpVE4Nx4YdtsAcZyRp1HiKibE0DrT/fh6Q==
X-Received: by 2002:a05:620a:288e:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-943f4b42489mr324755185a.15.1793083179572; 
 Mon, 26 Oct 2026 23:39:39 -0700 (PDT)
X-Received: by 2002:a05:620a:288e:b0:93f:3193:ac09 with SMTP id
 af79cd13be357-943f4b42489mr324753685a.15.1793083179111; 
 Mon, 26 Oct 2026 23:39:39 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm253882185e9.11.2026.10.26.23.39.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 23:39:38 -0700 (PDT)
Message-ID: <dde68e66-f1c3-4799-b553-4fc0dee786ba@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 07:39:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Widen QEMU_ARCH_* and arch_bitmask to uint64_t
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261027061504.2213-1-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027061504.2213-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyNiBTYWx0ZWRfX6iu9TO6nwtGp
 GMUG2VWGKYZkWiBYXo/XcEh4VB5jtb3eRwQQ24t4KuT1EqIcnraDJ48sBdJmsNxU0zuDSF052pq
 ec+2Pln9sjcFxBFfjMzyWqoqdoY77mE=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae0472c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RbPskAFc9oCiEJBpUSwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: C_-l4-6ZR1mKpOOxMtlwWbStOqJF47vL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyNiBTYWx0ZWRfXzlmRD2m6fP53
 vcdA0oEnDL5DB0PJuM7jRm35zyPYDN2SAZHecV5BOHmrHFQCc3wroaGER2qHYKNQLR0ZGI2LyFH
 LG0VqJgunxLN1CdD+jjRbyeFX+bf9nYGYOvdH0eFpDm8Jrm/hGfiNJ/9hVgyTiZ/4woZl987ke1
 iIQKjYGEGWhkPWDO2d+thuJVzdzrMNiT+S9SEbRsMmeQDx6zVe69V27nFS1bTXgzTfhTX5PEu4H
 DVBdamxVFES2jIDL49gZKmS23tkRby0iL50YgDu6IYqsPazM0f9DTdhZgLAcopewX24hjzUO0DU
 V29MKyVu+VnWoMdrd2vQq7OTkNE3/md0DJZfJaVO3Nf6wEtTMlV+jr/z64BrximQp/CrAcY7T82
 xZ+LC9GHJXmUjEXbbiYz8lCW9dxawf0y2EH8g3DykfScnqy0OjWqmLiAKDIFhXBWkeIO40ffrfc
 4iECRM7bocas+R6rd+g==
X-Proofpoint-GUID: C_-l4-6ZR1mKpOOxMtlwWbStOqJF47vL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270026
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/10/26 07:15, Yonggang Luo wrote:
> QEMU_ARCH_* was defined as (1UL << target).  unsigned long is 32 bits
> on Windows and 64 bits on LP64 hosts, so the mask width depended on
> the host data model.  Define the bits with 1ULL and store every
> arch_bitmask as uint64_t.
> SYS_EMU_TARGET__MAX is already 29.  With a 32-bit mask, __MAX has to
> stay at most 31, so there is almost no room for new targets.  A
> uint64_t mask raises that ceiling to 63.  It stays 63, rather than
> 64, so the all-targets mask still fits in the int64_t range used by
> qemu_opt_set_number().
> 
> Yonggang Luo (3):
>    qemu/base-arch-defs: extract QEMU_ARCH_BIT for QEMU_ARCH_* enums
>    qemu: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
>    qemu: increase width of QEMU_ARCH_* masks enums to be 64 bits

Series:Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

