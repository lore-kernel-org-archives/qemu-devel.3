Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7ABAC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokTf-0006bc-U2; Tue, 28 Jul 2026 12:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokTX-0006aq-Jq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:16:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokTU-0001Kb-AR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:16:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEd5Uw2592344
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qg6dwj8cGC530S0tPg1cA/Q6jnS76yhF6KSxNlXN4ao=; b=LeSGAMB/UbSCwlxl
 FybzNgfeLIlyACOWCRoJ80zcKtkvMzFOuUA1WyBMsXlss5DUHUXLltkfx/NXF0HN
 3cxqNlWGn5f/iLzyX2A+U/PF5nhKVXmsg+RThzWSuALZR/rzwZmcl414qlUvFEgn
 W0OV8zDu6RKFuVA0PrMRvaPrQ5uFaCHQTxo0g5O5mrBLbXAFvmK5W7hpn67EUBT+
 8UJ3NXC7x43fnNXMoB7lgy58s8+wVzXoqtSmkw5LsfEwExrlKtcdjTXvMLwYRUOO
 /O6OOhL47B5n9VKzQGvRqzBP0pJgB+Kb0J7/+guTzcjgdrMROOCSaJu4xidCX6Vd
 l9UW0A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpptttxj8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:16:10 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c0fb008616so19926e0c.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785255369; x=1785860169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qg6dwj8cGC530S0tPg1cA/Q6jnS76yhF6KSxNlXN4ao=;
 b=RjHdxA1q//8OqqkAWEFLmphv8P1jZaBzNrSMYD6K6gz1EsoKR1GiynzqWs1H9E1/bU
 +jQmA1hIWCUJ19iQqr5Fg2mJuWgakggcPmADRkfjRypUhrFR5xk89OvMjoL5jwMUKT1p
 etBGBjG1EXc6ufdpqqKMzK2xQ6or5HCQecpNMhChOD61gLNqtfkO3htNapjnzBI1OrA1
 tT/EMz20z1rXMRlcP1aWI04Buyyjfl+Xtf9uluQHC1XPEEbqOq4X9BwMo7tD4iXPCsyA
 b38iOEZMmefTtcper44u9Bb82mEm9Tt7kpKQx6FaFB0ZJIfDAkhsVj6trPn/tBD7BFFV
 dH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255369; x=1785860169;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qg6dwj8cGC530S0tPg1cA/Q6jnS76yhF6KSxNlXN4ao=;
 b=iJiG86Of1+bCE+NhvofEBk8Ak4d/8bUSkUk0kmu/6RNRLYMcZOHjERC6TZyd23AaTa
 t2Py2vuCrDEpnXXWpAsa6XjrGfr083pDaNM8inCgNFdS96jolVqZicwFSe8yGQ44ROrO
 iALoVjG8RXb4/EsN7/zIvcTYvebD/qx0nclXOgzcv+rw8osFbgjxYhHlcGhRAO6jO7f+
 kKL2jyUef4iwIHi7xJwHV+SyN9WzZ2QUN8yTmp/5UxE8/xzwgOP93PQ24hCMnrGW338x
 uoJplwZiz1gU5bHk/G3peCln7lsV9zpMzt3ifoIVpOg/qDZT8YXwHigj04Ncumu21Pgk
 lDiQ==
X-Gm-Message-State: AOJu0Yzgi6nqQ6aXxr28hdXtoV8uf17t87VJ/CO04jjn0xNLEY9daDAV
 OqSnQAah4f3MB9UYM+d/jRr7T3bNiI+UNz4u9zch1AXZeheERsQAQPXbCi5IohB9/03b4Pmfq2g
 4qFqYJTyc4irFjrFm2bpCY/tvrFpVQ9SDiu9TjBChcPeCe4i4eX5vkz1ZrQ==
X-Gm-Gg: AR+sD13DEOfPeDuTIKHOECXNRauVd2y/6ha/fhBUGhL7Dw6n4la/GvLOU9G0Dm/XOnQ
 jPifZ8MibBhcL9+NKRzSl+FYC72bgNk9ipvAaT/773DDhfSrArKRaaBWma3C1xMM74AilD1udfz
 aZtJpPlf3dy9QLJWdsDq7wX+ya8z66TAutARxpF2NmWpiupHCCASamPgHbg76zIiJP2PzALGMs6
 HceDsI/AUWPGaO4Uqta+A8qa3xWc9YiXlxgZESfU5PDanMUGox7vXgGxfAMyi0Pt78MZc08OZMe
 OTjM6mpNv1VvI7G19LoMddr6sq25kCDbwjvr42OaGv99N8qvTMCKESVBqF2Qao6/SPfvQzkQdWY
 Uo4C0zlzP2iq01/Y/R/3Vx9achgPNmfkd8HjktA5ZnfaCjshmszU=
X-Received: by 2002:a05:6122:144:b0:5bf:6dd0:36d with SMTP id
 71dfb90a1353d-5c33fc0045fmr1097005e0c.8.1785255369595; 
 Tue, 28 Jul 2026 09:16:09 -0700 (PDT)
X-Received: by 2002:a05:6122:144:b0:5bf:6dd0:36d with SMTP id
 71dfb90a1353d-5c33fc0045fmr1096980e0c.8.1785255369200; 
 Tue, 28 Jul 2026 09:16:09 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c297dsm86479705e9.7.2026.07.28.09.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:16:08 -0700 (PDT)
Message-ID: <35184c8a-859a-4bf3-ace8-066a66b22dfc@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] hw/nvme: Fix block accounting for compare
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20260724152315.234183-1-hreitz@redhat.com>
 <20260724152315.234183-5-hreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724152315.234183-5-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfX58+f73xu1twG
 2zU7P9/CQDwML2E8fCLG5LZ958JDFzht2MBDS6eEQiwYeclveaJpMwSpg/sgfBRnKTvvfK6KfF0
 bgKc2jYQDp5h6zRL7c8UNDauoiqJ7qU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0NCBTYWx0ZWRfX1Wx61sI31zZm
 YBNdjPKbAmRbnDvGboaygdDsmiH+QRCoguhQNntKOzdLjZhzsfjdlei2Zyvf3mnt8paGlrrGmCi
 tdcHSMK6tEqjD3juNOMxJ6MjOrjKycIDQCqaRT0ugn7YjUyBIWLMEjILuNTfZtEHa5TB96ZM8dH
 pq7I1ICHhHoiLm8GcTx7lfX12fTAOuxwHkbIszddbAExih92oYK+X7bujfMkZb39K78rYB4qHf3
 YkzRK+3STqmZoJwTrsdWt4ILiopI8yMVfNLyZG9s1JXQsLFYZpxcrvYPJ6zqxYrhJbT/aLXrene
 BaT9GFfELZG8SI7ndNB9jhlAd8diQJMbLVumIjT+jiN9ZVs7rfoJxjbwGATH32ZVj5z46YM6m5O
 rQKepFrqqYPmMQ90hZwFvouVSsRpl/XTwffWKN/oBYkIMFuZIQE98jv+hl9akY8M6s+XutBPdmR
 btiyzdrUDIQSP0JLnYA==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a68d5ca cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=5BLo3erDenUu_XDujkEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: GHG-lbnTCyZuk1ZarLbhi6v_Z4PhfC06
X-Proofpoint-ORIG-GUID: GHG-lbnTCyZuk1ZarLbhi6v_Z4PhfC06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280144
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/7/26 17:23, Hanna Czenczek wrote:
> nvme_compare() starts block accounting for the operation, but
> nvme_compare_data_cb() (and nvme_compare_mdata_cb()) do not always
> finalize the cookie.  Specifically, there are a lot of error paths that
> do not call block_acct_failed().
> 
> Fix this by putting block_acct_done()/block_acct_failed() under the
> `out` labels of nvme_compare_data_cb() and nvme_compare_mdata_cb().
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   hw/nvme/ctrl.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

