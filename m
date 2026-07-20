Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3F5C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlp7F-0003Et-JJ; Mon, 20 Jul 2026 10:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlozM-00011w-6l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:29:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlozK-00026d-Ai
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:28:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqhwh2604546
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3v8X7K1Jdd2Up35z5ZRbHLpJSqQnb68dV+D2c89O4UE=; b=oLRzAaOX3A/eug7u
 mZ7WaOUOeXP0/LysfkLyx3/cgRARoLOxy8JMNj4vHPWa3pKQffeooqO0XcbmityX
 zFAGcvFTlMuqQam60omMxpmKxETtAY4P5YXM6FfGre42DF3TDq6h4Q3OI70YEotL
 Q3vF1kp6e6+50IsCojT4d1tvBP8iWEJYmsUItliNlMlbX5p/7r9f0CxSJAwqO6eZ
 RN6Z9Hy09TLUIQr+SFF0rHA8CHZJmvIqk+WQzUn+iGV6NO9ee0R6lZhr5aisc1bO
 p09gYPy9+gQDnzbgbY3wyXm4sziXjtgYGMZl2QNBZ25PIRURwi/ljIiCJ8sZM5gM
 gbxLKQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhggg9jy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:28:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso76186021cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784557736; x=1785162536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3v8X7K1Jdd2Up35z5ZRbHLpJSqQnb68dV+D2c89O4UE=;
 b=dpCDf6aYfRJXZJw4pefdAFdRm0SCTr8lZkNKwQkjwUJRRQKKxVYsjLzbsgc2zo0ryw
 ZfFsTmMJsMU/cnDEj5VZB71KUeXufu7MZZ6sxS/jVRMdh9+ST9yBjsX2ic8cGOUR04Yd
 EC0L+SrEwvuHHHEfY45rmjS+X3wQsr/5JxNiw81QFuXYJPSRrPiQyL6VTsP/i2PiQZ4h
 fTP2dNPWxeIOoSEE43c5NtzsHd12jUq/gbORx3bColQ7V+dc5dgvytbd9R7SaPf8d3H0
 Jr/HN1H8wC6m+OzIjp2AYmW/x5antj2HG9jrY2ShhbZILRYaPBNKb9jrMVcbrHxLlSRF
 vwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557736; x=1785162536;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3v8X7K1Jdd2Up35z5ZRbHLpJSqQnb68dV+D2c89O4UE=;
 b=Fx3Zjhry0ti1kFipI6g3m2ypiFWBsc37S1g1lIUzw+yQidu4TCWlZRk3RV73DI66RN
 KHtZg17uxziR8puEPfHXFrJ1XtYMPKm7mhXpXGLYqVrqRxwvwrnrtRpcjGc+2UXgkln5
 oqK4bleivzbYvLiShGg9bLfHgLmN00M84j/xmtGtai/XAySMW/pQa/RB5oFzR0Bu6490
 YVZv7gAIZPS6WtK3MAxZ28wa6CcSo82PE/q78lvdLILHxGh7S8aJ2Lu7v9wLFT/NGpos
 QFS60sQSKB+3T+aOG7y/t7PoYpBs9cikHHO+R7ZgF7aS1PgBsFkLAQxfAuW4t4aTB2dt
 SHJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rozu44BPW0Yk/L9dDofElEFs9pGYmA02ogTSTNkeJ6GEVGdnyEPxd3LId1DWE/ZdtoXFRUmNUAgzBY4@nongnu.org
X-Gm-Message-State: AOJu0Yws2qTFSoO6j+36GtGMi+5YRciVRjP2rRvHi3G104wD0fZDgxh3
 +M0dnGe3hPIkN66FKZ8bD4s8kt2IqxsJDZ6Ju4ZpVNWszF4uUeX/GRZi5A+TvyHgjZdSZnTFDvD
 pn3xeRV2ychQlboWqaOIHTbJd4nEzVs9ZnBrXLp0GRTAncwze/ce3VeAqvQ==
X-Gm-Gg: AfdE7ckppI7svPoZSPJRM9f8oZJDwUIcNkWJsHnUlI8sUqbm0Yvl3eo+hQFs/cCNR9l
 TzPsb0c2HVS0bHVPui0a1x7jeYmgzx8ukPB3E8F0k7dE0gdiNuhyZeKeOiLs9dlsdANuVuoR8Md
 XXDjfFCkmsrCirQDsbQXQWC8P0OySPBcr0+s2CwIJ6QKUpWVC2ynNniUIeFGVvp72XpI5spSMUr
 vVrZmK/lNXJUJVIfzqTGxGRwz+xB28iL9ISgXFC61D7KlEyfPeo7UzhrXXjRFziemmFU9yd8qzN
 yd+n2o1TZmJOBff3zqkGdb2zUDZewxviqLxNPWxrJ0e+PJ5TyFLuitNnZBvqWntWS0BoOhIHI5E
 2ihkH8m+UuqKY/B+0XUV7lmM4QmDwQSZc5KpryprxjT8zVYm2FwY=
X-Received: by 2002:ac8:5dc7:0:b0:517:8f2e:5d97 with SMTP id
 d75a77b69052e-5213c7e6cafmr131842381cf.22.1784557736409; 
 Mon, 20 Jul 2026 07:28:56 -0700 (PDT)
X-Received: by 2002:ac8:5dc7:0:b0:517:8f2e:5d97 with SMTP id
 d75a77b69052e-5213c7e6cafmr131841891cf.22.1784557735937; 
 Mon, 20 Jul 2026 07:28:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edcd13sm29900527f8f.26.2026.07.20.07.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 07:28:55 -0700 (PDT)
Message-ID: <4cb0beed-b719-4fa8-a83e-09ede61ac665@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: add missing coroutine annotation
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
 <20260720-co-v1-4-fabb4db3c204@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720-co-v1-4-fabb4db3c204@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GbzmcS6saXM2FGh_DgEHRf7H9Nd1wIpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfX08tjAsYiwovZ
 zRG24mA8KMoiICDAxXExaqnmOtl9BomGTaElO3GMtPiboiGJVZ92yzFXbubLVxam5oDD0v9HugF
 buHEpFlnBYOBOhmWnNayZuL2SRK6gp4RFJx57eCBt1ra6Faj49qRVaJ7G2itVSXZlbbP8MFnRx7
 /M5I3gKrlqynXBlxDMPWGrLBOytOiL7gJEbL7u6tpn3bNySQi+SM6NIipNXm9zj5IJzxxak01II
 7OuQq4fuVwiKzxDFMVJyk5Nj87O2STqfJLzb8vPUT+TE5tqLDDUOnHG1OyGnMKML72foQcj1eeY
 S9UiB5+RgoqFl5jqlsX0+UVbSYYGwV1vdoHtj4JP2JAdhyzxfn27YUsJFC8zwBnbEvaz4MSqhfo
 PHPhalRZhDXxaabUe+xH0FhTIwbjRgb+cP+IAp17RKknEA1Qdun/0qqPRexP12iUqVoy6Al0eLF
 ZpimsDpKXGBhKF3Q9OA==
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a5e30a9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GbzmcS6saXM2FGh_DgEHRf7H9Nd1wIpe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfX0i0obGXbclcA
 GBG5hVOxkFZD4fGjEGxfb8cCRlhyQGvdn/S1zj/6x/XB4/+bLqM1jfYGFjlCd/y10QXEURqRXFJ
 XtjC4uFVw0dxGK1O3gE6q96IHQJrlNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200161
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
> The function was extracted without carrying the annotation.
> 
> Fixes: 23743ab282af ("block: move commit_run loop to separate function")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/commit.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

