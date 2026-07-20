Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71833C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlv4d-0001q8-1H; Mon, 20 Jul 2026 16:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlv4b-0001pO-EV
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:58:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlv4Z-0000Dh-Us
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:58:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTcFW447394
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yXvKzkuRVGbi0KnPF83YKFfobJ/BYgNqxZq8H29B9BI=; b=E607B0YNz5K5jpeZ
 jEqdtXqAigBiCaEfBMwN0vJy2sIthhYHYqbhBcNvRHQbO6gQm35Frz172RVPOKxC
 /Wv2IkO79fBNPjSBlQ+tGcjq24b6Fysr2Op8RdkcqJqJboSVqsYt18cE0S13dsCX
 tQRorCxnaDQMbPQ728W6s6Fax5Stxu7bZeU/LoD6VXPnJecj8Cqf6wtpPPB70aPD
 4vkmMvtGT4OxvOLMTd2lkW9NFL66VNnxERJvaabEgzD7tLGGhkNxfDkOpPYMO830
 seGJmiwchQNgxeaSSwpSb+3dFiN/IGKEvyKtitZdUeqZyogjO6QfveIdJq//wxmB
 wsto+Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5rva1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:58:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso213101936d6.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784581125; x=1785185925; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yXvKzkuRVGbi0KnPF83YKFfobJ/BYgNqxZq8H29B9BI=;
 b=EErDQXiPCkCD8vc9UhYzuMJKW6uVIZsxrNNaxd9SOnlx11A8ASuEPTp/x3w//bixaJ
 WpRl3DwYmY2wg3mUu65NXBKXmxcJKZTQNuid5D6pZ2gUcA//zXm9Hx8dcYP0hpy1QcwK
 VkhwxjIhv8Ex8GD4d5AyviaZ7QtqS5jfOcke0Af2iy9jPehxPLsRlAu2BEdniPuyP57s
 wwckIt8u9Id347mtILfB/M2QNPGlj/7Y69hQNvCPoNiYYxrFzaj4xXYpdkwxm9/CFuN7
 IVqS2IUbmTYGRaX+rDsyjhMeeTZ3g8NYnVQpIyhcIyDRsnW4lLywvqCusrg5uEN7uXsv
 0PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784581125; x=1785185925;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yXvKzkuRVGbi0KnPF83YKFfobJ/BYgNqxZq8H29B9BI=;
 b=PlbjnlRdU+RWOR0GoETQqQhTYuR2azDLkoHx2RbSX1YDAVz1o6NLxaYPQVKYD24COf
 yXgGhP1+AwccXyZdgG2p6HAROESNB+lyg+vZuWS1itEfJycCdwoaG0GG3Qsu4mFJvLvJ
 yamnhHade1fg5zZLYpIRtrapYc+2TQ8CrgK3du+U2q84srq+g91Yixco2aFD4VGry976
 TmJW5Ao8BTbqFDotWse1HPl+Qv6AJS8CLQJSjc2KEre6T4CnFc6u1WrlZadzHJPigRtP
 pk7M+guBPbq2pYhQJvAdHHDR42y3Mn1UUIJwLM87uT83OgYOglvwzkGJtvGWu9mA2vwH
 Piag==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiUIrwIQ5IBk7IRrN/aGWNEnQ35LeGHiONoGih4oWyZjGou/vV8RiHVL4Rf4t1Jww5vwuOOc47ZqM8@nongnu.org
X-Gm-Message-State: AOJu0YwAypertz4FgvlIZPQSNOn9PCDoCpc5AGtih2qHQ+jnIHGiq30S
 c1EndOWXNihMuKmiymMQpcv7Zufd7FaPCaKPDgUl1TaF7iAnZb/Bda2F9xdYSjlqcpZPosRu7bL
 qbVe/YvwaMdaOR1pOdpUwRO3fTd7R/6SXJQzYfGdpR/sRiM7wdlFtMXKcHQ==
X-Gm-Gg: AfdE7cnfjeZlaw9zwh7fzWlVr4DxBI8maOyALe7/rAq9NeSmKBEED7BuInBSt6SlsDh
 UdUY4HoraMaeLchqmAbL/8lgYNLO8fplF7PsV4UR4r08ZQEsy2H8eHcdSLGleRdGkOyv0Etm1T0
 dO/JJL1Or/DZamjAiuk6Uia9O2IksDd+9Hoy0DgMs6HA/Ua1DPqSCh0xgHwRyYL8NUw7lLR/COF
 oryZBpeBDNTdg1TF/7Mbo6p/ZDv/lpLT4QP4iyO7MzMxOG8C2b5SiQA123wdZM9d1rkHKQo798q
 fPYSGh5/Vk+yBBza2kjEx9PsEspjlqMtaLBxzodthGm2yO2hNLTHhuRAOOBnxOhgB/PmOmQtfwU
 nhNHiHknLBeYnxFBYUUqsKLSu+KeGRn1OBLAMI/cgeXg6fqctHTM=
X-Received: by 2002:a05:622a:5cd:b0:51c:a8:51cd with SMTP id
 d75a77b69052e-5213bb21707mr147059611cf.1.1784581125502; 
 Mon, 20 Jul 2026 13:58:45 -0700 (PDT)
X-Received: by 2002:a05:622a:5cd:b0:51c:a8:51cd with SMTP id
 d75a77b69052e-5213bb21707mr147059411cf.1.1784581125140; 
 Mon, 20 Jul 2026 13:58:45 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfed7sm17139495e9.11.2026.07.20.13.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:58:44 -0700 (PDT)
Message-ID: <985035ee-2577-4b99-8eaa-948a56ad62e0@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] block: add missing coroutine_fn annotations
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-6-fabb4db3c204@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720-co-v1-6-fabb4db3c204@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iltVZ8qClpb4MduNLklc7WzVeKDv4nOV
X-Proofpoint-ORIG-GUID: iltVZ8qClpb4MduNLklc7WzVeKDv4nOV
X-Authority-Analysis: v=2.4 cv=e+U2j6p/ c=1 sm=1 tr=0 ts=6a5e8c06 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=1BCzUFiEGB2mR181h8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfX0TDTR8rFA3fp
 79+SkVmEM8BHsVFCgi0rtJ7WDYlszN13X+GuGAZqnG2D9OrFQsKdPRTbWBn2JLzVEj8apRQyIuA
 9+TmZQ2fC5emkkOuv+s8dL/0aK/NO34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfX2TkMCTRjUQjM
 bJdHmV2Irrl1Jlr72/4BDJKDGC4RIlnB7Fpy1uLzSfGFHCYDSfw53nI6l96vohiQPJ7ckJAsnYU
 SmaoegS6CHXr0gp2dg0aZZaxAEfK7AGDQH6vvzJOhBUS0pd3SyIyOgf4FUC4Z3K/B8uwnvV6BZC
 EV5379KJ27tas6S8NiWHc1UXDruANryBi47ENjNqs74+q6Bew3a7Xg+ykW6eeAsb3eVjFUUksxV
 qMygba5XM37oY+CbOzzQOzn7ugMmENkVd3ZVPoohocKm3G17v58s3cHOhC3+Nkgd4sKvJz0AXV6
 FCRJnSXSf8IL3mDk42e2fuBD4QVzeMP65681EOqZawsC9ZaXivfKVRs4fJXoaMUhVVWZ9v2+3Yo
 IoeaSp7D1+2xeh3BUWnw/giK7egrV6Kw9D2xMTOu8tv+DGgPo0v5J7RzmCCE7nHIolaYZ8y9Pp1
 95gLdpYqAkUeA7YsVSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200229
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

On 20/7/26 09:55, Marc-AndrÃ© Lureau wrote:
> The functions call coroutine functions or are called by coroutine.
> 
> Add an assert() in qcow2_do_close() code path which calls a
> no_coroutine_fn bdrv_graph_wrlock_drained().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/block/blockjob_int.h |  2 +-
>   block/crypto.c               | 13 +++++++------
>   block/io.c                   |  8 +++++---
>   block/parallels.c            |  5 +++--
>   block/qcow2.c                | 11 +++++++----
>   blockjob.c                   |  3 ++-
>   6 files changed, 25 insertions(+), 17 deletions(-)

Too many distinct code paths in a single patch to my
taste, I'll skip.

