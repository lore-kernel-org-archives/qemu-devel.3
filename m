Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA39606A338
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pmUwatwU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aJ2R86Js
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAhS-0006Vi-FG; Wed, 28 Oct 2026 16:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAgy-0006Na-HQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:56:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAgw-0006GI-6j
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:56:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIQ6qg850036
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NpjWAdeTjnmWrM0/Fb83WiIwqEcXemYsLruCcrzFPEo=; b=pmUwatwU7caB1U1h
 VaizwnspoO/9eoSw9vNsz9QR8eK5BAtcTingIbbApIF2QdbqMQaKkOtc8yR97Ec3
 G3TT9QFL5jBkdzaCmExTnLqPBMDgupptvd7npU2kdoKUJWPr/yrUZuKUzzqiJxsN
 CYscxMvyzqqY43m8i/CZS7CmEVy2KZ1CFCMd3zWbdMVXFydJGJxK6BzTdl6MQsRZ
 5JmW0NZl1X51OZl8nY8/bhQ0u/g/XCJ2GyoUYEf5Gv2ixAdy3o8eD2XIX0lmop3d
 ajvOeZf4suaeh6ZHb0Bo6JFmFWLGwBy0PQ7aY5JP2LTouRiFZxC/R27WJg0Hy941
 jTaiqA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp2v4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:56:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c3c370b17so2213076eec.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220971; x=1793825771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NpjWAdeTjnmWrM0/Fb83WiIwqEcXemYsLruCcrzFPEo=;
 b=aJ2R86Jsrol8QXiAyWDfysodcyGfC42lK3IuvWGlh6mr8Tda4OIwicGB+1AV1wmVww
 K3ezhi9nqiEGMat+N6naAWucLPu3L3EkhR2hasi7vClppcRS0TCLellyOJNgZqvXw6tC
 RVzHc9fnmPLBYDjrZdj4kUPhWWcb5V9olNoVlGG/n1vSCjuKyX+qqZojx6WBsVTbe16z
 bVJjybnsA6d6HvB8F8hnPcSU7ZhQKFZQMt90qE9PCzhvUbbn2oY58BVoX882l5tYnOyJ
 Xxhuz6VfJ0ROeFMQ7Utv0KtPHPVOnCxAPot7p858S1p51dpV4peQeNJDnPLataFj9ucR
 NAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220971; x=1793825771;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NpjWAdeTjnmWrM0/Fb83WiIwqEcXemYsLruCcrzFPEo=;
 b=brC9oOBbpw8k/wxwyQM24OmkOUgUyT2T3YLZrwwEP1c5LCco4zU9grYv4U3MxGKgqh
 pgzru8DPeHojWf3Fo1NicRgUUxE+qN0diy2CGmkN7Rw368Mf72wx4rRKVpDzZ83eSuId
 /0bmHdRIvNsi1Hv46TYkgHnR+dAr1wlUPtsMv+LwSd3yh2Zdf57+iyuRPyvCTfa+pr2j
 6w64tVw9h0cddVsNa8j/nmfNO7qe5hslMuHsGvzRtfFSWH1Gl1/Wg5a4FuKP+K/uK2pZ
 vXrTT4Uhyhd6w/zzleDulgcfFaO791UWxP9WUuLMywZHhkbfkGpFAfhwtZD0OrP2begS
 j+Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvByoc0SgljSaRgWBQPHLoB4C9O0DgksFuYZ1JrWX8QBMrKzdw64OfRNlvia7jqT5T6830pc/mO0Hk97T@nongnu.org
X-Gm-Message-State: AFq9FYLR+vxmWYcmD9R5u2fIOelaoSUpJX3plfV7U2A3C7okbl2GvHCe
 xREVh1wfzHQY3zjI9trs+39TCc2XSpj98xQpwY0o2aGDB3E9krUdU9S5IRYFxm4FxQaoYIIJ3EA
 EKaKAsrzFtp2VCn5i2wEDusy8qTEjD16uarczLYQpoMViIHcCWT6zUvYLug==
X-Gm-Gg: AYBFou1+02vOK4GSjMO7hY8Z6uuWaF/cB1D+HSIYogsA7CKO4LngSy9SXtiydbtAKQW
 0xmAq+NWassn9gG6SKmDJYK6OTM2e1o4gyUgD2FHgkq9B3DCASeteTmuyvw2dOZSw30bC16TCmF
 QrRCjfrVdbLjLj+u2udSmx9ZUh0fIaUrBVbX0mhgPyBArmAavVnTGGlkvM5n5NbCfxpV23Ob6zc
 nOskOulFwoIoR1MR49jQlqqMhsWsQ7E160K4Yk1XFnJbMZ+EWrvJ+NVl0bZJN1pV3GCOr7xUd8e
 eNw85zZnr0r2feskwmLVXsVS7W/Lr5Mq/JR/c59v0nVkJofTbgdyRqMP9unWg2K1tTheuGJalEP
 Qr8h+xy3+8tY0KFOmjtm8j06EkonGChYrzrr0+kvfBUnfEHQgv3omRVE6lSH3W/HrvDWp4G2Szn
 cMDl0gT5cDhqMCw8UdSRZJ/lk8NKHaaLFsncGEqzLwWX4=
X-Received: by 2002:a05:7301:d185:b0:35d:eafd:5737 with SMTP id
 5a478bee46e88-36a20418d01mr4993708eec.22.1793220971453; 
 Wed, 28 Oct 2026 13:56:11 -0700 (PDT)
X-Received: by 2002:a05:7301:d185:b0:35d:eafd:5737 with SMTP id
 5a478bee46e88-36a20418d01mr4993676eec.22.1793220970900; 
 Wed, 28 Oct 2026 13:56:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a2392ebcesm9735334eec.16.2026.10.28.13.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:56:10 -0700 (PDT)
Message-ID: <5de0d94c-4bca-4d52-bf87-aeae400dcd58@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:56:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] hw/virtio/virtio-pci: pass is_available through
 VirtioPCIDeviceTypeInfo
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Farman
 <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
 <20261028201557.2688-9-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-9-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x5yZIy2NRt1oGn4YPFO4U8yyzB9xlnbS
X-Proofpoint-ORIG-GUID: x5yZIy2NRt1oGn4YPFO4U8yyzB9xlnbS
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae2616c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=ShjEO6zuZ4VLedG1Af0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX23Lbe3ApxbTO
 TluRecishZDA0XPoQC0OB69PpLKUAYNBFK/m36tXlswOm9eelsTORhVo4URGThRfL8Fqj7XAnX5
 pF+fnUu4ob/HMr3Mps858TM3ly7Kjc+OUO7YgdIrkUBRHuUSVZzhjQKelItKnVg+TMLS/8NcSkO
 maHpcic9OMMSGfLnka+y7MYTvTAPQpovPcZH4bzk2hvf4nWXzXLva4tSbgvfpSXUDB9execZ/1D
 74VTYjb122FdIFtPRnD9Vu1Fi3DlLwT6AbkrMc8a2zQRJmQNC/q+VkfVUrPhqFavdqoDBy4EnAd
 X2hGnCDxvK00DkqroNbgEd66TnexmavTiyhsuOCPAofoJPZAzEPhxVUD4fE7QZ3i2MLyVKDExAN
 fv1HXD0ptrgKGaLJAmwd6ZrAhx9q3WRWJGRjRF7iZTREHh6Ssi4gRPAVtme5TwZOmqt3QWe3y4E
 MNa0SJEDLnFafpHiR7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX7U54yo0l4XvH
 zV0Jtzx8tD8FZfEUyLD1uCvI61WnliXJIGYB69oC88Jr9+18nDxk1ja1cWuf/3A6vDvzbMMkHPF
 GkzugcJETHvABb4vAUiF4tHKmRO+D2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> virtio_pci_types_register() builds the base, generic, transitional
> and non-transitional TypeInfos for one virtio-pci device. Copy an
> is_available callback onto each of them so a device can register
> target-specific variants of the same names.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/virtio/virtio-pci.c         | 4 ++++
>  include/hw/virtio/virtio-pci.h | 1 +
>  2 files changed, 5 insertions(+)
> 

Fine for me, let's see what virtio maintainers think about it.

Regards,
Pierrick

