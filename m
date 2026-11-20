Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859D606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DktKkfkT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ur6FMYwo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUEwF-0002FH-O7; Thu, 19 Nov 2026 22:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUEw8-0002Ei-Iv
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:05:16 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUEw7-0005XS-32
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:05:16 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK0GJGN2608028
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9h/IntCyDNj9hB2TSDXVixvL2YenwJLKhpojnzPqYHY=; b=DktKkfkTbHm7SLdG
 gfkFHIEtN5VAf2LqMBtyoGFxT5MVahDSm8fenWVBE0FukQ3+HHCGU/Qbj8f5FxkJ
 N5+Cu5Azy3q7JKtJCNGudzAhddqhHHpdTX6mGXKohxPnG/ok1o+2udbjU+927YP+
 UeW5hsBZUjjQsbNSC9o+R6ill+XkZGBt4RUbXNTFzs/LVShNx+8sZbANzb2SFYBz
 lgcDcGMJCJrulD791p+WrtBPGzi7cYPmZoyamjjY/grYJpA8n9kPJlof4CcwMTcY
 9dWRfWeioqfOEOY5gkOPuYpU6teuldj4oalM8PwqXWXuHA4xNRsxVSU9DlbihlFh
 GKI8iw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugu714-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:05:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-383165e9b0fso436925eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795143912; x=1795748712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9h/IntCyDNj9hB2TSDXVixvL2YenwJLKhpojnzPqYHY=;
 b=Ur6FMYwoxKssQd8PLSLtER5tXDIsIWTeCamvB5ct+ln0sh337A+Kldn9aMRk2JUEcG
 2eesv6aQ8FPWXOyKDLg4QIJ3rf4NHTnMDIPIv0x2A2A9rg3nm/a0m3cWrAPr9BQNwK0t
 kZ201hXjtmLdP6d8BuigoDtr3SvicHIX+l/finVSqRkstmbX52HJNWmjiQ6bLi+8nE/V
 GyR978FN6ISIqfOdogZy82MFsYK2Hh6fyg1SKgmjzhDHJu0gEy3MNLtzbfO6lVIFlEoq
 KYfQtkGonSf8qevGjK9qdLtgLBVbF3M1Bu0IR6DQ2jJ4zvjkDTZc83PTrO9LiEI13U5m
 jtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795143912; x=1795748712;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9h/IntCyDNj9hB2TSDXVixvL2YenwJLKhpojnzPqYHY=;
 b=KcuTBtq3HVk0qB2OyiHXQExr0kqINcqmjcondyDb9/k1a3P3BudDAlUOi+oT8h/S4V
 uDYfP3KK8ilpEqGGQWXa+fYdhJelf6s6pnjwdBRzfaJVv4VnztlL3ThoMKHlAE1E7mFM
 MF0tJw0YyEHOD3F8IKj+bBYnLFO3gSdml0IhzupsfovkmzWEFnG3nssPy4xqiOxsKeN7
 WWEJqfHfNFHs34DrgU4qp7cX2a+DfzC+ApjLZivlZ9kQlG3xgAJf6UpHcqhWo97Ynrxq
 x0Nu8W80ebdjkP1+Xmcp0djl1GaxtIC9PAWnUKpp7K4nh7yjXGAq/EI4NcdwQskVsGBr
 J3aA==
X-Forwarded-Encrypted: i=1;
 AL+hErFFp7EUyaegheWN6+gzXL1OlhRmvEYvvQOO6rwUh0gNHCZnplxIzNZs5p25sV91s6ve0/9/VxhzmirK@nongnu.org
X-Gm-Message-State: APuU4Z+KUn8irtkXdjR2fBkiakUwUPpHYh7DtOhKr9XMsyA8whLQhEhb
 M4XbguUDT646omUTD3ZBweoyI3HIJuLiJziKv9UCgAqHm18TlJIvNOflUHw9pga+PIxC0AGS3bE
 3WTIngCqMgQAbE6JhOyQ45JmmqOE04/5fWfPPiKgEAyqaxJCHEx6m6JaeJg==
X-Gm-Gg: AZFdTZds7s+vU1irWb0c/75IYv60uoZc3IXbIuq/UPG5UA/4JXsuYSYiQ5wwstrsm8E
 afQt/KflI6JS07oLf5h57X+W1IKrUxwB31Ll802ex/dH4MHK6thLxcgjrTWCtTnI7nftuQ6usRN
 uUvNPQLGwthxGqbichcGIn9IS+eHr4uIgT7HBQrbqf69AiK1p0nakBLTtTUjdNT/00KZqzhq7jq
 XfNJiUAayi1uxmPUh71RwVMO33sfBMmj7YrGqdkkMhAinjxXNiKaWEyamso/xWT0NTZsnGo3Sj8
 VmmD61qgXFbYbmty+/oitbyKY4aCob5V6z1tt7BdbUtNsUv9qYVGtDOtmk91lZs1Sk20wGjOHw6
 lUTc6sk2PVEqoZLp7jiznAF925ng7KL1JfdnYarnuWDVy33cETxE3gCMIehU0VHCQeCJfp0O0pN
 JD33Zc4qwWuxVwGGAfk5RtXCLMABh7nsx4fvztyo/VAEklsXNJToRF
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id
 5a478bee46e88-3856c2c4a0dmr1437927eec.5.1795143911993; 
 Thu, 19 Nov 2026 19:05:11 -0800 (PST)
X-Received: by 2002:a05:7301:2e30:b0:376:19bd:2af9 with SMTP id
 5a478bee46e88-3856c2c4a0dmr1437900eec.5.1795143911382; 
 Thu, 19 Nov 2026 19:05:11 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385646633d0sm5226743eec.3.2026.11.19.19.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 19:05:10 -0800 (PST)
Message-ID: <f25824f6-e312-49cb-9717-f953aa992098@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 21:05:08 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] target/hexagon: bound packet lookahead to the
 current page
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
 <20261119215853.987158-8-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119215853.987158-8-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yRvnXYkSfX3G3FZRNgsgAJ-3M-JKaESR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxMSBTYWx0ZWRfX66TZSzV8oGen
 7J23fdS6NInHnbUjtir5aDR8Zyjf0gUIOler9V302PAdej61y5RcWparUnKbw97Sx6nD/1IQJ6k
 Vd2IK0wAWWkig4PGjC6x7EKf6WwE9YI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxMSBTYWx0ZWRfX9wlGNF0Rn1Cq
 r+twg94xA/MZBtxIXrqFMskxqqVXCU98/5QkKlblsfPLZOUxwHxnq/z0hHPvaDOBAZfqj/iEhso
 nXQJa57FmGwwQ9QCkNSioLLNypE2ESse2LYXH5diAZSvz+KTGHidqwCqFtITEnVS8rhAzi0otHS
 m0WD59fjFqBB94XU3of96zBHqiqFJXfdLPqGUNUMzx2+Fwa7OyqKXYrkcfUzNEJQ3i2iq7Ho1sP
 /sExaso1obba0o7tE4RqilYTUauoSONdoYc7QxXA8lUS1orzJ5hl/qLglyLLw2Lra9+5EXvuk2I
 U9+cU71M5l8pGICTnyu6UeyhEW8/vIta66pldAdhJPkt09heVfLXA7qvH0b1BjlxwBnEbbEYZMc
 afKmTktWBC/3NCSCroGzJNkNT/o9KXqlmkTvdgBmkA/08LHwFl3StJsyjlIr6cwYxLi7waSwf72
 uPILzZ/d7eu+pYYenbw==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6affb8e8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=S1nWZMA-WZ7S3fAz_zIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: yRvnXYkSfX3G3FZRNgsgAJ-3M-JKaESR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200011
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


On 11/19/2026 3:58 PM, Marco Liebel wrote:
> Do not fetch an unmapped page while deciding where to end a TB.
> This lets complete packets retire before a straddling packet faults,
> and preserves the correct packet restart address.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/translate.c | 5 +++++
>   1 file changed, 5 insertions(+)


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


