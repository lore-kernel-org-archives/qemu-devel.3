Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C461C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVeU-00008q-O0; Thu, 27 Aug 2026 04:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVeR-000079-GD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:40:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVeO-0006Cp-US
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:39:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R5lW2143796
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PAuNdE0+RvBG45FZpe+6E4vVKW9lRTIG1OGafBpzdQA=; b=ofVBmW/867PwielI
 nbOAZqjD4ymUJPkTuWNRiPIpJuLCeOGVsxeqyk/Xsu3xPvLd54HU61R3NWZRqRSI
 P5gUCEUwAT2eZie+nZ8bfADEWMJ26DD7P5GxNAZeCGMA9fNoTrmunTcRYZ82QURo
 Xu8uuFBl4vINGokZcCtkukOGRQychUsla+UTzJNK5AbU0f9fPMNg+RxnoWn1JZ68
 qROB2rJ8Gk2s5R56uvH9K3GmnafBf7pbDut8fcjvl2JiQwRtIya5+C4pLJTuqRkw
 PGb/0V8IWcMWeaJMbbQ/qIX96aii4B/DnF6y3hBEGf3eN5K+o1IxKSbe5XBaKI0C
 41fNBA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gab7t1gaf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:39:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52f52ccd459so16840281cf.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787819994; x=1788424794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PAuNdE0+RvBG45FZpe+6E4vVKW9lRTIG1OGafBpzdQA=;
 b=H+7aS0g3ORKozjTQKJ8jxlKlfz2vlIrdUQrKm4zUO5NEIU+H+kQoIjMBaxrGQnSiKZ
 3m/xtkUGHKaMpwGKTWeGHsbloQTWppa10yaDiNc4K+ZJjCPZqvooXkzs210yFXXgPbhK
 w4SohUvA5TQ/AEe2d5rujh9A/64sUMiz7bs/9jra7mkmxeJeBrCe3DuoCSYOs5LcYg49
 Bm2pDcNwPW/FItt7LTlV+DDhjKquE9hHPpe8ZJVrFMQbAn3hICrvaaRo4bpg1iQ82gJg
 QxnZ03Gzjyh9ehe4kgmN4DDcRG5CT3gS5d+xfU9QJQ4YYvgF2Pd8ZZ316wSZgn1Vv9a5
 AcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819994; x=1788424794;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAuNdE0+RvBG45FZpe+6E4vVKW9lRTIG1OGafBpzdQA=;
 b=e+xPg8y1WiNi5Nsi/dn7zWzblCqy6ECMeaMBjzD+QVa+mljYx/yTdk9cErbGYnkOjb
 PU8cBEybvqTVErBS8B9HdnE1QnKhWX6MAOD6DZcSrF5keQOaJGsADPkKgwppuG+L92LD
 c8ZIJwiW4IWHnbxxTrusZhTwKTWwtrH1u77pOO5yvCommW/6AQR2lBiIFpYUDXXF0CcP
 g2YbSG1Fgj+QcpbQa5VEPc0tIFtlT7iodvGojIKNqn88twnH98mb5dBnhlah84OdyAn+
 +zCl15/YftgvzTSEOKib3XrcEHjmejVRCGLxiTK06zFx8PiAWBOWasWeIbv7fz9+Um0S
 eU+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbWy/RA3BB6VxLfxsW8vk5j7FsWqTubH+Dii6UN5QLRIEeeP2Ow6GGda5uY5kv1e8GdoGvbTfwLUAu@nongnu.org
X-Gm-Message-State: AFuF++lN9zYkA7lSJse9zvRuY28cuKX+lpUuzRM1BDtcDvog6GMY2Jm6
 TAH39G3qSrkgKho9e1/uXeYQR+Tj+FBPWk6r0u739nm6j0gpEB6vm1kEp4nxZ5fhrRQ+fn7CesT
 noXTq7r7D4YIKvYBy4hGcqMRC/YbLiIKDw4TNUwQ1AnxxvYhLlNFXmapTnw==
X-Gm-Gg: AR+sD13kRaDraoaIi8RLse0b7McuRvGukNnXMNjEg86AWfNrj1bf7OxqpQii0FFrRwn
 LwT45drkrtYphFZeTlEj/fCpWF7Vjc32EkQFjo8jLFFV7uL68a11A7kSUF+XHI02laVHVhd47Rg
 bGYEZ7Gx8K7vFpMjj4lTy1ttX57UdoQoVog57PV9plHE3WRDHqI/SsIsUIQHocIX9BVyI5/gHwq
 qvKc0qXGXxgfHmV5HZ6nQjND7bhT86LnmzLHDdVSG4nHe7T/KayITN4zI/bqsZ4QYx9Dw/h+mQD
 AguJCPwDngLswl/Lt+HrYEDEaeZynEbwNDG6g9fQUtsmp+aviKoFO+TX+U2hyv5gaS8iHie8LzQ
 gAxi9FrPdtIEMTiqJNasEga7pNdxpXhkedTWfdPEclMOhDmDd
X-Received: by 2002:a05:622a:1b86:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52e4228ddf0mr128989601cf.4.1787819994642; 
 Thu, 27 Aug 2026 01:39:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1b86:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52e4228ddf0mr128989271cf.4.1787819994192; 
 Thu, 27 Aug 2026 01:39:54 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e279e391sm7271138f8f.2.2026.08.27.01.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:39:53 -0700 (PDT)
Message-ID: <83b91fb7-8ca9-455a-8969-4693a4fe273b@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/43] qapi: convert trivial intro sections for
 qdev.json
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
 <20260826193840.2152000-18-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-18-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X6Bi7mTe c=1 sm=1 tr=0 ts=6a8ff7db cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: efIjqZZd1S95DKgsgYBpSQlQzGCeSleB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX2lyFC5swrN2r
 N9txuwEXngv3d5X3XGxQkZoB6XdyT+0gPRG9Mrt9PoIXFHzEDyvbs6sUXses2aM14oBP7w1v1VK
 4psdsezMNPEzBy+bsNEkMFobNUYojmM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX0E/mhU/jvs5J
 eW/YgTuV7o4aHaEoJAKxr44xLpxMYafn0Ti45EpEr/b6NGD/Oor0WV0L3mDj81DEMD8p4a/SK4C
 i3JNIVLS6bfeUVo3XQPFMqBOz1JtbdO3yVH2UovzcwROGlFmZXgoW86z0E/4ER1BHV/JOqsSd1P
 xGdgp3uQ4J/2BzB8xAWciw9Eoo4HZE7N5HxIaLcZy59lGsA+Nrk6JO76wsZV10XPkX1LFUubJaz
 SZZcJ1MpuAzOE5J06+qQSy8UjhF/NPKl/UKzsa4Q051SRn+G74X8dzhx0Cd09yxpUlcAGkthAQQ
 ig5x54XifJhtGBQhAqvjrVhVds6lXnYLnRaFJRF2mpCyQ+Uwl6IJJP1cLFEItDp0jVCclf/9NCJ
 lssZSEDZUHgHeetUI02zZ448P4ENHom2pFgLeioYKOn6iK6PwQHC/sB3BAJSPQiPtlX3vK1Y1v5
 5bdzcLCQqqI/pfjTewQ==
X-Proofpoint-GUID: efIjqZZd1S95DKgsgYBpSQlQzGCeSleB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070
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
>   qapi/qdev.json | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

