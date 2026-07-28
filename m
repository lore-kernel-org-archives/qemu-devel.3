Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC36C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokJ8-0002WZ-RB; Tue, 28 Jul 2026 12:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokJ2-0002Vd-PR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:05:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wokIz-0007sI-EQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:05:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SEcoQj3075745
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ISiMW3Tv0ZqwEogAx5rnkltQRqQFBYG16vVU1BnW33k=; b=cU2XO/OQKFibyl/s
 T8HSIH67X4AWryfRuZzNg738LJ4hrHj5GdBWEgpqvL2W9qbnwuMG9kEzvnxS5NvG
 bafreTJSdmkcftUD8Tk3KNCee9duRLWKbeJmgW3JcFyGV/7LQpkZrTQY5dpB6l1a
 FphKCXNepWWm+GPS1sLBc3zrtIL8o34U+Ozo6IesSz8Ivufau+X5qzE4i/pK9o6P
 cF2q5tQDivhl8lf2OW+IAQZRjiA76ZZCKgP7fZvBtcs53xJuNY/dujOXnjRX7U/X
 B5QPUFU8e387s9jSPt5aQr6AciPHiNNuOCwjTsdxjA6XL7QBO0CrAMoH8kRMFTDt
 LHeqEA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19k63q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:05:18 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97747d31e56so1026115241.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785254718; x=1785859518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ISiMW3Tv0ZqwEogAx5rnkltQRqQFBYG16vVU1BnW33k=;
 b=TavS9zOSJGDP9q8Wy6bK49NyQD7+S30kFLXmDQ1xoRbD33VHBiv23IhCv6UCiN9pD9
 ZpmOzM3wZmRRbxYCkaQ3osVGB0j2/4GJ4VkCrF0f/8SCAYbipgj2bdbKnXZPWg+kxmt6
 1g4Hagn3igu3NVjDf6vQJ+8oPFqUazEXQ84JZ4zuxrD4gXOGo8t3LE3KNyJOkbB9ZosM
 paPg/Z3mD5RbeG4/A3J7KLX6T8RyBQQc31NwfOhckYWaS7JOve7Oij0Cv9fdHp6vCRdg
 INy6ZIuv6ug2e4zYz5FBJVvjozYL8JFwjoKtZjE09wf0wQ1ZgutRvvGEpDHl/h+PMdHO
 AYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785254718; x=1785859518;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ISiMW3Tv0ZqwEogAx5rnkltQRqQFBYG16vVU1BnW33k=;
 b=dKCWFq4rLEkqBX/tOmuLy46E8LOlP2ALO8I8HhQ1Aub32q2oulq92Wq7WjZYxolMUv
 aSJBLSVp5kmKZ2Fz1jHW9Fgg3LxWfn68Ewe2Y/2hOf1QpdffEtFNF8JBrK5Ji4Xwgamc
 +4KIq2MVmJAgu+121/z0eHyEwcrvNGOTD2z3+Ps6wXjXrxqQrZnRuGlDahYN2O15TyYo
 Uqko65HDQESQuec+bGUuHCDRkUXZzLiHgUgSYSbplE6CQ+DjtTo4kofeF9hN3fazyclb
 SZkjF0tqpxZdtID69H6oFh22rzXTjHwLZUmHmPUDUzwhuHmfUSFmdNb5V6pKl+lyequB
 FSSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS9WTjYs7HGzKIRslRZueNEQDulbOwe1FwIQWvv+P6Zh2bUMKYGmwTihtszVDdgnso1TdQYbVlAXIG@nongnu.org
X-Gm-Message-State: AOJu0YxtmbDxmbfDN7zhzmGp1yIOeXoF/KEc6UtVaMM9l5AzIVQsbWf2
 /ooiCkkbWPBB3RndYa92sffydW0A/ISVVm1BPUmYXwTttjcmwCAlnz5HRciie5ju6Y+cOmEpwSE
 3LEZC4qWKnBlhzpDxhRzOYI7X04vKkOV7t8n0BUg3wTlcIFV3MVhGunMfYf0yWoV+qw==
X-Gm-Gg: AR+sD12lpowgtgjNR6LCmju4YYJ7jpGD5+q6fY22pSkJLs0Vp5okWsm/eNM8x6had99
 mgaoAyjRjedwYkaE+JUeLRyzJCK1+pFBbQnSzhoVDY/eajbLs54mWNUrYj0Trsv+fD3wFmx6Pnx
 mL76qbn2G6ZVXV8LDSQNtnwUEWEwlrs/+ckb/C204mMYu6AbiCINAWQwdLUymRbJ7FmeIbN3uYi
 B0CH2ggCgdwocWMeg/rAr/f3Y1uC6Itht/98DDe7WVSdWdy78b0lBYxENCDOM055BqpwWt0YepH
 p3yo6fvkEUXyifWnG5xHDHGbWfdGGzt8WYzN6zeZn1D/jHa4PkBaTFGZNsW4Li80Sl6ip5F95ua
 ykL9FDdpiNCIpwFcMaUTsT0iaLaUugVa//rYunZzHwbncdcP0f6M=
X-Received: by 2002:a05:6122:8713:b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5c33fab4e07mr1394426e0c.5.1785254718177; 
 Tue, 28 Jul 2026 09:05:18 -0700 (PDT)
X-Received: by 2002:a05:6122:8713:b0:5bd:b47d:1865 with SMTP id
 71dfb90a1353d-5c33fab4e07mr1394361e0c.5.1785254717629; 
 Tue, 28 Jul 2026 09:05:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45dd4dfsm80091485e9.12.2026.07.28.09.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 09:05:16 -0700 (PDT)
Message-ID: <573c7138-5999-46c6-9a5c-288a195245b9@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cryptodev: reject queue counts above the array limit
To: GuoHan Zhao <zhaoguohan@kylinos.cn>, qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>
References: <20260728111135.572426-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260728111135.572426-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68d33e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aknGKDDPbu8t92lPQLAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE0MiBTYWx0ZWRfX361CJyc01uYV
 gnwufvTupJ1fYcqFPnuxavG5dQ3+r+EqFzVmDi6HO4gVeoByQND9sj92tmNtm+l+iQJLwwc3z6g
 rOU0Yb1CPgov/a8rk6oHP2UeRZZSntk48RjkRV3BkMSjaucyTOT24p1RLT5/aTehGrzLTDiPjQX
 /4TRQyzVtUIXFw317c7aSMNz8U0kjQmYNmmFo9snrxfBJGNdCoGwp9gYAfRcsyTdotAb+abJZk4
 Ks3K0gfp9evB462o1C2Pl3P5q2qxlyUKf9SnDD/v8SSFzbnr56BBduFvcWG+z4NLv675wsJKCTk
 p0UcinkS7yX11zU0dgMlit3nILSxLznJPvHxb5CqNHqgNsv2KtXS++FfZJiLQKL/RDz/llPZJub
 zr0mHsMk+tzIodPixRykGxBpys/vriHYA0Vh4zsepo6aIH7KvkWbdfGIywMpZkXAVXJ4WQCcReo
 lSXN7M88NXBFZ/Ugx0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE0MiBTYWx0ZWRfXzsWZcNAhvOVR
 mrMqRk/T456EWrdLY1wBwGpv99nyuxVZb+40b2zHgW8MZXe87zfIWMCAB9hPTrPDrWSrtJl+Rb6
 01i4vyKUjXmT68p2+2cyHJ5idygSuyQ=
X-Proofpoint-GUID: KNIYMZkJWChuzcciTpbWKgcfXfBj2quI
X-Proofpoint-ORIG-GUID: KNIYMZkJWChuzcciTpbWKgcfXfBj2quI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280142
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

On 28/7/26 13:11, GuoHan Zhao wrote:
> The queues property accepts any non-zero uint32_t, but
> CryptoDevBackendPeers::ccs only has MAX_CRYPTO_QUEUE_NUM entries.
> 
> This can make even an error path crash.  For example, a builtin backend
> with queues=65 first reports that it only supports one queue.  When the
> half-created object is finalized, cleanup walks all 65 entries and reads
> ccs[64].
> 
> Reject queue counts that do not fit in ccs[].
> 
> Fixes: 46fd17054548 ("cryptodev: introduce a new is_used property")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   backends/cryptodev.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

