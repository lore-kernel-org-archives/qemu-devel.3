Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9030DC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVgz-0002JK-C8; Thu, 27 Aug 2026 04:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVgx-0002IU-MZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:42:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVgv-0006nS-SN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:42:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6REvs2726744
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eTOp0U6hBPBLp7IWusXAj3yNaChjytvOMMoMQ0I0hhg=; b=kCqXnufVK1shlEJ4
 5UPS+/H239/KEj1HJfFerfxh0oBobJkWDz0FkVGdfTr6VrF/whboY68byyJbZeV0
 cdQD7aoPm8TbkMKrxiFfIj6mRqkT0GraTI/go4xoahp1kW23UVXvEcXN0vGXPXnJ
 NFQ8IqksMC+uXLNbcky9WgpR4IuGk087/1gKCK4U66G8/J4g6msD00gOcEiI+U77
 vvgcShJ9xcm1bCKyYU2hRNxxu1xIQgRNgRxfwhFzruqvTrmgJHxczKd/SukPSnan
 yaGewgvhkRaHLvOI3F8m+tonZjRaVX7dV6kgXBikDSfJQBGKv1FGcshvSh5clLMj
 CoAYHg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga6ettbw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:42:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52f52ccd459so16869311cf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820151; x=1788424951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eTOp0U6hBPBLp7IWusXAj3yNaChjytvOMMoMQ0I0hhg=;
 b=IKdaBmX0qibyYNlQ95ss9emUHTUGkkZ3aIv/EzPNcX75iRkcAzkCj1tEHsY2miW4KN
 T6RkBNtbX2xQBF7ajBZdQtwKQybv0yoFXphIULCPhfM7jt/14NZYc9XN38/w0PQEROyH
 p0l38wxxbqaKcrI5c079xXJpN+DCtcMDl0lIo3gwMmZhw4PpBjbCqLOhoxUV4DIsijRM
 EqjYG4aPvRzx7as3WqEWZfYcgE6ZWGj6mpkUuM2PcnZ+5qY7jE+s7Sdk+fBnV3McVEo4
 sCkHNxB3Me+vXuHwViYzGhB46e8buWoOi3abSsGtz8zjZBl2AYpnJcvD9MAeU6C5F1pE
 O8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820151; x=1788424951;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eTOp0U6hBPBLp7IWusXAj3yNaChjytvOMMoMQ0I0hhg=;
 b=MEtsgd73V6hA1zVDcrg4bUIVtWpcYYewQZ9eq1RFIz1VIFh5HVdseeYU66fXxJv1bN
 EtPlaeUaPiFx1T1MFJWkpA7L2iXl0tefCvj4ufHieE2y7hOcPHuBrNwydhhxNqdMdR4Z
 9nAcRndqBRqq0ew9ecSp+QsfKuS5iIlq1zZKrr4W7ZpTt6gHlOjk5Tw4i3xGnZzgQYss
 0+zz/IqjX62KkUGj4LueJuR7STRAalkZTLSVyM/p7gydPLlgYr85apjFI1UER7OmbcpW
 Lq/JQQKqJbsK96dnbY5WW0JxUqZT9vgmilQTfdd5sTI5OOeEBPTYLs02Bh3sKt6uUQ/T
 8Eig==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzmvKC2tPFUjM0XuX73p15VEa4XsxOPTdMkJvraWZUDLZ0eYOYqWfNg9yWOn27mt4xsLy8xECsssLD@nongnu.org
X-Gm-Message-State: AFuF++l7IBj2UcU1lqE1+FsbKPSXqZU6IyYrhobCzK7b+bB3Wwen9l7A
 i/NeYl8rcFuJXl41vBATQVyJx7M3jNw9fdEpxKNYHlNlUwz4JwCX397FYphKWvX6FACKaN7ZX4a
 GRS8c0CE6ePXmEUuyqoFn8Clinf6AKDl7NqM+2/rEPpL+PuPa3jhMUP6WXw==
X-Gm-Gg: AR+sD12vk6R7TKNKHZMCHL0ZuiOxewst3nDe8cvAn3gfsZtkLsoL4WZN4Wf1khjz6g+
 l9AvmFJRll8dM5YELPNmf5MA24ICvMFCHilJCepKoCguLX9CKXgHAdCw2Dvv9YmnW8778xhBQD6
 Q97exSHvyNwCy6tGCApm2hVoHERiOD4LVdjx7/oRU/4OwuQVS46NA70zEjZw7eH1vSVVd4VS+Zk
 PQY1OIPLFHqQWEaCoBeXHe1chrpFbkApXhm0U1n64PMWPuUFkWxFtOxeYU+LWz0H37zzqTe4Fn2
 2dclbP4lKYK2lcINN4W6HpC+yB19biZxQf5n4sw0We8Le0ZXk2PhIr980vBkoRzen3AMoiGpXrZ
 fm5try4w6zmTAsdgRZ/ZMIBaKRK53/CJPWxpDmxuCTbZheH8u
X-Received: by 2002:ac8:6107:0:b0:52e:2906:9124 with SMTP id
 d75a77b69052e-52e420a0859mr147672261cf.0.1787820151512; 
 Thu, 27 Aug 2026 01:42:31 -0700 (PDT)
X-Received: by 2002:ac8:6107:0:b0:52e:2906:9124 with SMTP id
 d75a77b69052e-52e420a0859mr147671551cf.0.1787820151047; 
 Thu, 27 Aug 2026 01:42:31 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942366asm32395695e9.3.2026.08.27.01.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:42:30 -0700 (PDT)
Message-ID: <3e222ce2-9e3e-4dfd-918a-37a03aced152@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 39/43] qapi: convert trivial intro sections for qom.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-40-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-40-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a8ff878 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: m2nmGm6eetyzjXSe-qD5B6DS5SiAdzXB
X-Proofpoint-GUID: m2nmGm6eetyzjXSe-qD5B6DS5SiAdzXB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX/QTvdiB6kOdG
 CUabCKMgn3IxnjJJGmJj6Y89SD8jzRQJhkeV7tz+v/66vrq4uSCIP32qxDzYmyRPN+xbStcZY6E
 smHOsRpFNApBzVjaQNRz8djq5aSBZuz1TWqI0K5yDX21QT+eSGcS/MssZOg+wAaz70mmE21wh8y
 sfUwGzi9wh4qezlcLQSvZxfLL4GpgKvi/yWW3INEOV95mJVgGjhVTCoaPBBgVPc5qoezgU/XSWU
 MwAueySup/VdHs4be4INGpXwnlsPZjHqOA/ecQ57sUbl5Sin2xEnAHATo1kFV0qmd6guqRRgrg2
 47sK181ACQVTijRkih8PR/sOKHoSsB99TifHz1n7P7pjmvIHYZP9lV4pr5dNW3obsMK8853ogs/
 1WIJgAPPgrGldbW/yvaJ7U4HvWcrq+/w+Phu1emQ0dGOhj1d3SqKhjoNxWe2KKVjBWX4ZaeRHQi
 qEl5VL5e94nt6muLvow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX61Mfvy1nKyEN
 iPFQ5RFR12edxuJH3v8C6uYRr5IpFuP0F4NcT5ngJfUKL49zr/LOkzPYbsDpzQo/yU5tSQvjBdO
 zVtDCxGlEFvGxWG2nEVBZe2D/yVRf94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270071
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

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/qom.json | 150 +++++++++++++++++---------------------------------
>   1 file changed, 51 insertions(+), 99 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

