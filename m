Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09316C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVeE-0008WC-Vo; Thu, 27 Aug 2026 04:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVeD-0008V9-5b
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:39:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVeB-0006CF-GS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:39:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RNg0088541
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a7+AsBvBDO3jYmBzGBNJcGR/R409Qb1IgeySkVV9Er8=; b=ZA3qNtqSf0GF81Fc
 cP5eYIqZ7dmwGa4lVZ97KF4nxVfM8KTsLbPnurQ4htRdns7LOH1OCYgzMbTLvLM4
 yxYlWfmLP7JwHrhgFcF8QsGuQ/tsaz9QWDPrNcHRkPjf3WeQfmLeZu5pBXdoiR3z
 9T1eDEQYvWEVuVxyLNynjTMED4Y6mywYQnkAOIpWtxmHFT/uDxIa9tnj8DQia9mF
 MuYxLMcgMDN+sasL3dP+oskh4VX3uyyB6MVuItDhVlg4aOg/rhadzGM1IPmH3bXF
 xblYRUqYMVZqcwLsCj6JIQFHWsrlC52vD4K7p7PTX8EId9jQutV7NrcdPT9mIXQt
 1O+V5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5hv35-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:39:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d30035dso13353071cf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787819979; x=1788424779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a7+AsBvBDO3jYmBzGBNJcGR/R409Qb1IgeySkVV9Er8=;
 b=BGPd0taQaC8DMVmWXFw/JDL5dt5kwhwUc26UVzt2YAVtHjhzwQ21Bs2ZzmTV/qeGKK
 OsAio2ctqNp/ysyQnDg5jPBNTiOvSKGtVX59o6nCCdiJ0lZMMXOijVuwDrASfrSRlz/L
 Jbj4bwcMCfTXA/Am+Ytbi8Vzegt/9vP31R3EJY1g1KrCN3esqg65LQ0k7GejXCZ9oNbm
 Y885BCSStkMosYdETS4qJs3Ek+5Z8LZaKnCVcXYYsf0joEviGXZcGHrPDW7Yq/C2IFrm
 Ap0r4jmyDN4E0CKdgAUE6DSWDMjhjdOQoDa4NO6gLZBUo7W3siArfmzhCxw04Acgjbob
 voQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787819979; x=1788424779;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a7+AsBvBDO3jYmBzGBNJcGR/R409Qb1IgeySkVV9Er8=;
 b=clJHOppdGIXTHjTe+ChlQVZFyJxb4jtomWY9GSTZo5ojSt7SvbmdZj2Ri2SqhovcFb
 kWE4oEgsuxUO5MNxJAtk0dvyjLSJemwfbPLRuJ+dqtdLl/uIG1yREGzF+dDtnz2H8Z/Q
 5Fz41xRXF2Gbb1aN+0t1l4Y3IKTVIAklMlj+BzG4xbtT83rqIwGaoF14tkxYV4qi7Y1C
 tiU7XjvE4bYaPEsHKokWe0yIt8rTydxQnoU1ZVcrYDEsH+yFf7gjjhLKqRAEG+jUDIDn
 RN6h2Vf7H30PmCR+eA3/02ObHU9vsYcWrCCQXEMzf+3R08s82GGwkH88LvFW49DzkRLN
 777A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH82j3TVoCvVu2b9Fp7Bc+k2kwy7ejgddDRY4cRnrX3R/7o8Rp85bdv6gg8chKS5xSm6+Sio6iFMK0@nongnu.org
X-Gm-Message-State: AFuF++lBYdRIaw5OiLPEr/IqRWWTyn/8m+X7og8myrXQ+xTWwGxSRrrP
 nQ4VbDb/Yv2A95w9Pe54ep88q58AKjHSOW/iE+K3OTsd1Yt3fyMcmcJCM2nHfMUA4Tv1vh8wKdm
 825kqIufz5Svgl8RcCAXrbsZlHQY8fSqHnah/V7wMmLx4ZrBEakAPfq7uww==
X-Gm-Gg: AR+sD10Y4gOP1t3Lky1rAXfqEku0kKPSP3616O/ZYbO6l86KjYRYphCzN6/a2eJNIxo
 OuMLervrsDhLLT+R3rCmToY9hS7AVer55/QTD9IvM11DHuM+oM7zDOgOaWGEOY7DE0sWa7gI2Xs
 fkOg5mTvh2TH2MI5xWwtCEga3khPQm8aIDWuurHOHPCxuD/Ew7pDz7r8vJdVPmBvrbUeVXTdYCa
 1dCv9owLD9bCtZ5fIC7JR3Q1oK3CKNEXDHODIdcpMexuXhDbfiRIRFFmv0ix5BS7FDFg8/TxXZD
 mJNfoeR8tKfuI4qWkW+2EdtT0oVL5nv3aITXiLAnxpsEtofnEWpMiqZ9ntG2pXta7hc4RSlWrfx
 QDMCO8nF0G9+XFF0Pp4Mltd5BNBH9uuIfhRyGi37HDtIY7LQI
X-Received: by 2002:a05:622a:a0a:b0:52e:f66:f1a4 with SMTP id
 d75a77b69052e-52e423f6de2mr137305341cf.38.1787819979266; 
 Thu, 27 Aug 2026 01:39:39 -0700 (PDT)
X-Received: by 2002:a05:622a:a0a:b0:52e:f66:f1a4 with SMTP id
 d75a77b69052e-52e423f6de2mr137305021cf.38.1787819978860; 
 Thu, 27 Aug 2026 01:39:38 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dc3f5sm7529973f8f.21.2026.08.27.01.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:39:38 -0700 (PDT)
Message-ID: <09c2e2b7-fda4-4a94-bd23-202e7f021002@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/43] qapi: convert trivial intro sections for
 accelerator.json
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
 <20260826193840.2152000-11-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-11-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vvyDnTWp8YQTWmfriJ0SYjjPMWdUhoS6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX9beEAF/V8u0X
 Jq1es6qRN+vRJrInCTiCB/NdYH2wP84iGHu+RkYQ+FQeR2HJonhHbvW2JR6rVqJV6+b4+PctLvV
 /Q0e/mlJQma2YqvRIVEYkRmZCiUiw4Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX43lI5Uf1HXSA
 0eOJsjSyoeWN8MwZ+g4zj4u3Uq4ghYdeRryqVKcVHh50dHl1Sw+y7VRzaLKMNt5hVZgmK+/uZMw
 SkXMEGJ5KFHZw+13lV/81IFD8SgCL466xhq2+Dsh49qQYUJqc6lQHlHJcCxJjgQ4jbencpIT7jc
 CmlROIPlgkRYAvPZUdQxsPykPiMYx4A3otvtVd6q+ZEdbuDj7uEJ824JmII9oeENHmP5RqMfkud
 Tz1CoUR4v7sCexhc7oeEuaQtsxYxeiu7pJVbIvz0GmfCpL8xhAOqUbMm82/V3x13WaaxnIRI+a/
 okeYHUhdBx6ELkqvvYtmqrHG+8YbSuIqYr0TVgPWQOuUwyqUF74ptA7VqZGbwrwbzBjdtoP5lWT
 +eUwUBUEjHQchmOV3Pba3y128VJU0OMJc4LdJKU5I+apHde3l2PNj6fKjHGoobg2mp0yymTeeDv
 rdkbc/JExX5AI2aLapA==
X-Proofpoint-GUID: vvyDnTWp8YQTWmfriJ0SYjjPMWdUhoS6
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a8ff7cc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
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

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/accelerator.json | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

