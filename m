Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D195C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlowu-0008Bj-Iu; Mon, 20 Jul 2026 10:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlows-0008AL-Qi
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:26:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlowr-0001v3-AK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:26:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDrEVG2807551
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xylt6wsFKJvrYyxVqGoSHrKPaMLy/Xg4jMInsdLnhbg=; b=j5ApMr3p6EZG/Nd+
 hGnvGfgyo7mkwOY60sHfUg0uD9QQgMe2JkPYTGznsxjuaiDfZ8VJ2rSORr9y3CWq
 caDSud4jE4wksqsMOUUGXTsYYBrVeOCyQfmq4bM6FX1Kpmnyhf6imeUUFWOP2U+N
 BJzkSNMEMfWgVYG/b3imUbbz072XqVMpsfZhSyEdH57GKm4BDA7noCuqXQ55dgLW
 96meegHLxYsCbkICAapvTJMG6Kiw8bpaH5mj3BFJinHJSel6zePHvTmD3idJaDRQ
 mqYxHTHTu2TZYuKrX1BUUJyLD7AJ8DhbURVs3adYWy1n0SYIdfawGfrvnTQ6T83K
 ZkBp8g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre9c2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:26:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso195904621cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784557583; x=1785162383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xylt6wsFKJvrYyxVqGoSHrKPaMLy/Xg4jMInsdLnhbg=;
 b=IKG7ZfavL+SGhuor7T2pFBj3hhvN5rNRPEqtgAjgySi2qZpDmLEIXZLAOisZqe94wH
 RTW6U/Nt1pP7Ww2+lj5dmZ48oGarWNscfKmcmkF91uwLB7qUh0AS3ocmVu6+LKYXrljm
 /lD28jLVYjPl37oNRom5v2gh5VjD8uqQPRm3Yd9xWZhDDe1pyV2g5LSofjP2R8kR0LNB
 RSRxI5a5JExZkkmAIIPjg0EGKRA8U2Wco7CmN062mCzOegRgXIGSaP3O7AcmrVaO6XQD
 JfJh1yZvxeJmOz8IvAyTU03LRTZTiaDFowawaXI9b+DWki7zcH6wRU58xyVGhZLE0oe5
 hK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557583; x=1785162383;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xylt6wsFKJvrYyxVqGoSHrKPaMLy/Xg4jMInsdLnhbg=;
 b=MHZDNazsubnyKeMckdXi7uTfvR8g5j6rgpQWSjjXWk+7dEcRPCHm9iDJpfYi2/z3vT
 Xh61icrVo4WCjVWwCZChbSQpwT8qfF37Lcr4miSMxS0lmSar7Vugs83wK/UKxKXpksIe
 XND/dihTGVizRR4gL1vVCT3cAslwnUN6xmRyTQP7BNjvClSNCUiPfoHJDV80QM8fgrzN
 8scDVXW0jxBk8tmZSPjhTefZMRmCRVO6eAZ3tF7y8ku9dUw9ozx2u2kDevw7BQ67dhJL
 JFYevHjBF46VGIg6kq1uRpBSlVMu3qzixDrcDeHX6kqW+8qQyr7mCOiZAASdvknQk755
 rziA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrI8EKfpJXQ8fsyDGqKpOzq5XtYAeoErzk4RwVsBDrAK7PauArQtJP+5bAfaIAfS71xG75LAPowZqB5@nongnu.org
X-Gm-Message-State: AOJu0YxP2hBGj27B1CEwa7wrTfGQZb8++IFWBeShV4qOmvTaMIhSpdGL
 8QqcVNDjt8PcOr5WmNnvWUJy6EDSU8bU/e1cWNY5MNP4NNJb42SazDWEqjY/N3cw8iGojcKfPFB
 oXrL1mXlDvKgDcXQ84EneCPRWqM4rUiaOU1Y9M3cmANQ4466HG79s2lnkgg==
X-Gm-Gg: AfdE7cmsj+ogBZ2tSy73FpEEDgrgGEcFBTMb+95WTAucc70KKYGs7F4fnqfFzlG2o4J
 3oM4uMdT5kZNzZReXcT2VEE+6vELBCsJAGXV0IE7jglKzp+fNYUSX6MT4A1sdBwMDBYLUKDfEGl
 KHIOCR4pMnb6YgU9BWSJ9wbC3hcdVuqSL25httVB190+/NMBzQty8/pxCWUTYRDtW5buHtkEnCN
 tJCLl8ez7mkax8b65i31OAVUjkZ9gqIh1/MQETWuY2IHttsAUXFZh1TLoBULsmNfOYF0ssU+nS6
 XzhKPNEztgPN7aLdsVcku+HTT8d7KpGyw5AQ8K38i+sFRnUJqFXotDnQ/laEwI+XxgqzfjDjj7f
 OfQg8ey8qWObtyohVEwoFiE2aR5aiuHF4TwYh2Eb9iY4R+hsIIvY=
X-Received: by 2002:a05:622a:3d0:b0:51a:f94e:ce51 with SMTP id
 d75a77b69052e-5213e28f161mr133654271cf.50.1784557583295; 
 Mon, 20 Jul 2026 07:26:23 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:51a:f94e:ce51 with SMTP id
 d75a77b69052e-5213e28f161mr133653711cf.50.1784557582784; 
 Mon, 20 Jul 2026 07:26:22 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955d6d9e71sm104268275e9.14.2026.07.20.07.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 07:26:21 -0700 (PDT)
Message-ID: <bf0bb4a3-bcf8-44a2-b3da-b9e8fed68a5d@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] monitor: annotate monitor_qmp_dispatcher_pop_any() as
 coroutine
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
 <20260720-co-v1-1-fabb4db3c204@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720-co-v1-1-fabb4db3c204@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfXx3nHL/KxNWZU
 T+rEam7O94ivAC/YL8b3JxmXrfrsHaQdsWGi1ix3Hg50F9crhhYwQjOWuM0ZOepHM1VxZOv2phx
 cIN4FP22scbu2UXTB1F2l0cWSD8IMDI=
X-Proofpoint-GUID: Btv9DCf-oNoS1H_7ztJO54D6Ko-hf4nd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfXwz0UB3n0wQ+g
 IxdrOEKzsgUNocEl/mYtM/FH1gQPXqF28ZsU6FeLtx8+LImH+i3/DiM4O//G3VGIuRkhBaCqfFS
 fRttJjNbmPthDqwtjMJwnVnrxttY+BjlPENN3+9D+MAxWyb8irOx55FUrVIZmXqFJzhbDzHMNp/
 Btc7SAhqkUQsppLpZn3fC1A1hfHJavI0EDtYBC2r2zkBP/aS7NN8PkyCj2K2mTvrT5CsWRBpB2z
 04HctHRWl7LiGpnlhisGurqRcGcw+PRW8UT4+x3guw0eSjgsJzAtKtu1TVCM1dBdwEH3WUDDlJt
 EWJJpehtcVgPPSOdsequS9GKfldrkr4qiY05wrIZc7MJgJvHBfQv9ohCp+RdJSD0x+QPgyT5FAy
 Lw85hq5LXHPzNJQ15VVdUrwp1NBRu5skhwaf9OmEJHT1mnW2C1Fe0TpF1Ovjg8s5IP/af2x0iaT
 xm8aNJuKKOfiObtEqEQ==
X-Proofpoint-ORIG-GUID: Btv9DCf-oNoS1H_7ztJO54D6Ko-hf4nd
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e3010 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200161
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
> The function calls qemu_coroutine_yield(), and is called from
> monitor_qmp_dispatcher_co().
> 
> Fixes: 60f4f62efeb ("monitor: extract request dequeuing to a new function")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   monitor/qmp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

