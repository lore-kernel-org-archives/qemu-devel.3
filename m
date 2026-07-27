Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E5DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFrE-0003Pg-D2; Mon, 27 Jul 2026 03:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFrD-0003PH-3J
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:34:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFrB-0007DZ-Di
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:34:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7SGpw3339732
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XJlPP6+uPJ9y9V/qPQMBHH272zTYCeTPmDaMF54LowI=; b=FPQAcWCA7LLe/1hV
 1x/lEVobPXwxnjiEZYhqCDHrfnUbeI4Ma9JqtfEkY+cfiO1N4UqURGzzkF9mjq0S
 WaDgbFFEjQ9tQS/0CcmNqpbM3MEpJ7ShJPy+R0+mzvSFhvaClLt8159Sb7DoMoCL
 p6138YI/UmeR2tc8m/FP5pHS4g0K87OnIk54a4jvJE55S0ddT5txBqCzXQg5TCI4
 WDWMRxOm1kbhWabtM3waO12N6h2SwOdXxUMoyJy53uiVgy5+WephyTwGrMIb29VE
 jJIZi4IdWb8dxDCYVI9VsMW8dHBDSZXUpSzLEJgDVFUDsV1bpz4q5XlrixG5JQhh
 jXZprQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sd4hq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:34:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso34339871cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785137674; x=1785742474; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XJlPP6+uPJ9y9V/qPQMBHH272zTYCeTPmDaMF54LowI=;
 b=aiq7s3X6wtOo34xsbGfp7hZNrNaSDW7y3bPP1/5ZeWVxfnYBvM0YQSK57yXsZrJ601
 ZmnGi+4DHZuQYfNAKUmye6AXtulQfG7Tf4O+b1u7DnvNrLy5kH56cW/7tjwoen8ip7xL
 +fXF7pfcweS31eo/dmzywJt2WcrWEZfVaHF72wKnHOPR2mhOPkVrrNAVNs094G0DU/cJ
 hPhmXbKOVfs9QHMDwZMU+Cg1tdrJQqhUaumNOOnz1Z64jLn+Li86YR/ddLHUmfTwws5o
 Y3rcmb1xWoCBW0jjbAdwWY/5jcHZHsIegZ5CW/PZiMpSdwaaexnJetjo9idYqCnIuo/3
 MyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785137674; x=1785742474;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XJlPP6+uPJ9y9V/qPQMBHH272zTYCeTPmDaMF54LowI=;
 b=dyhPWjj9BNOHwTIwAd18VjkwoGqZx9Q3BDXEqHIJhk+y/9H0lezWC3vnMIQfrVRvSm
 pwjKL/NVjJT6/xNK0nuuAHqFVzF7FDEpFYSrgRTtjIBFdYGHNWt8P2GezdQA2bX3c+og
 9VFl0TW8HZIyi6jM6AlIC6szrXr765dFZQ6gOfd6aNWl7pTJAQZd2wT3jcSwX2cuNKdk
 tRT2pa97X/dOs4pqmxHZlRE2pBOOF3ctTdTItY16z9hGLcq1dq0O+jipBuZFj6cT0Lh8
 BSzX7JvIdWih+QS2pGhumZSpWoDrIn7tWHukf9udhHmIbtuIbby5M3lo3BgtQG5nO1n2
 sHMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8VRLpMKPg773+FImRMud9tKzZWlGxMIpmyF+5921RNGHOLnYyAkhkkdADtlTFVaiMfVPkiOPc+KFT@nongnu.org
X-Gm-Message-State: AOJu0YzrF5t5a5sTUoEGe9x3FYVfh5cNz+7QbpJFRDzo/L5oyGtJhOO0
 kWqluqmf3u7INVwOmpR2iHaJxcuwWQQm6bO7ESplI6OlE9VNoXQ5MX9nHn+AfMGTZHNyBPa3z4y
 4fyGfinQsq4MgB1hHpPZOWm1qhUUNyxJLziYSUNY2TY77peeszQC0CRVvDu6Mj3MXcQ==
X-Gm-Gg: AR+sD10Gt5tGXdvdcEakbHRqm9hSPQIfLobVHRMyIhHTYtyGixilTEreM0MIOVcYUb9
 stkMfDZLUEiOsnp+D9+Xuv7fkjCv/3R67M84iv8xlDkgUM6hboiJaWLuNWNAaNB876o050KU7F9
 MVf27H98g/6w3pdhf53nniEMEXNH5PspF+w3lF1Da34vPNkZcNUQYxKBtdJMBKPeLU5y+VZkELQ
 2tOxNae11zuQ2BS3AGxq+VbRcx7oshDFybbM14R2nJ4wkodyO54dmrEPiDgIlU1rDEscKW29f2s
 /oLOs9CJjvFapM3qlaV/MO2WwmnFL3KBwAcyuDjo70Y0OmiWuhI7ai5tZ5vGKoaTvwgfOQuEVX0
 iGyjAwUMho10ptjBtNPUI0x6pfHcboFxKdzfm6iLKkErGWpaYfxc=
X-Received: by 2002:a05:622a:2515:b0:51c:7b12:1212 with SMTP id
 d75a77b69052e-529a8758e57mr87086311cf.80.1785137674210; 
 Mon, 27 Jul 2026 00:34:34 -0700 (PDT)
X-Received: by 2002:a05:622a:2515:b0:51c:7b12:1212 with SMTP id
 d75a77b69052e-529a8758e57mr87086131cf.80.1785137673897; 
 Mon, 27 Jul 2026 00:34:33 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6ef25sm42900744f8f.36.2026.07.27.00.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:34:33 -0700 (PDT)
Message-ID: <47566cde-0739-4152-a9e5-1ff13904d9b7@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] block/blkio: fix compiler false-positive warning
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfX6X84F88riI+Q
 2Nib199uvJ9DTI+UFxiGqZ0d/cOXnnteXTBBJ1h9mqB8QDFHiB5FyK0r8vPypOxzAEVa6hjm51B
 IPbjqWPOJXy/cJ06PKwsy8vgLl2kutr1uBo8n11/ZKEI1aega0SIME8yA7ZqWhpF61rhkHh3zid
 Uz2aObQAIfymIw0qAgub4AkeY2jiTzReAvBp5Dp2LFBH1VBSRvGLQri/AjHyLe+V8dlYjzh9EQm
 l/xm6biFm3eMds2PDTro3g34Mrdtay6LUDNGmDnuKgRf2HT86vhcCW0HDGwTrCyQFELjj+8Vp7h
 E/N3ndu+ABjB8TO3TM/Z/wT05b/ayLYoelN9oZxJ9SVGo7KY7ND/5RvYipxiI3HNxsTG5uFY0nr
 cFmkfCQw4xbhjp3v1DSC5vb0cyNebbOMsFptWuP/8/sjk87goDeBAp6tMMyYOlqQe9ZD6ASvJks
 6e8YSUt4wE0Aqnk6Ehw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfX0p+3L//n2mD8
 5ARdUEdW/5kFJ5opaFjZbz/pTyLgn4thj9c5tQSLbHlbtLcfraI+UCBylPvVO2bU8O0gFgiU2Ku
 +sGxAtiGHz02IWfqOIQRv3ZkjaRBXcA=
X-Proofpoint-ORIG-GUID: k1qcUyz5OjpAaDL19NEpOWUsl_dvLLzl
X-Proofpoint-GUID: k1qcUyz5OjpAaDL19NEpOWUsl_dvLLzl
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a670a0b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270074
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

On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
> Under some optimization, gcc produces a false-positive:
>      ../block/blkio.c: In function ‘blkio_co_getlength’:
>      ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>        943 |     if (ret < 0) {
>            |        ^
> 
> Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/blkio.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

