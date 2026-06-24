Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57C9CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQuJ-0006qF-8V; Wed, 24 Jun 2026 12:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQuD-0006cH-DM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:56:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQuB-0004jz-S9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:56:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfRwG1862841
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +EqRj5jMgg8YSg0edfvj261vo+pqDmC5SgvF26S5GE4=; b=BQlX0Ubzl4f95uiW
 wySGot0pe4gP7PbKL/5Fz7K2AlYxJzYiB5XSnfuNSY3zmQgMKdfs4SEIPweef1UE
 ISZNzR4yMFzEfdz6avmbMSEsPYi2DDWS/Jl+BM/iGltjzmEIt28v+GQydo9QE7pV
 ya63+g09VYDn4gqVO7I1n/iY3LYuwdkAFa3eza3X+FG60uEfxvt+N6ZAslUJ4iqf
 B+ZA36sDVLOqOd87VfSauw7zEb6x54m44TTdTzbU1t+HDsNtCfcwsgBc4V1mgmz8
 YSyw4bU/ZlJ4rDF4SEwYLAvVLY/VsI/sUmx4VSxDNwEgMv49pngX1i4TktLsXaSf
 Ig9NEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f06r334wa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:56:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0c489e72so1229456eec.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782320210; x=1782925010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+EqRj5jMgg8YSg0edfvj261vo+pqDmC5SgvF26S5GE4=;
 b=cV+v9my8p8BigXUxU7L6LPR5lLuznhEKfrcirYonSiuf3PuoqCGcGzNP/tI7+DuZop
 Qjh1xqVYsw8XESl3Y+F6Paat834WMFvof9GuFDVqkgaQh+xa8YiH6sGlxE4qOobbD1BA
 t7aiWV4Rsn3uFKedw1AjvXrdc6DV8a0u6rT1Yojl7fJof0TV2MNEsn0n3te8z4QY6G7x
 +1Mdgw2fzUKgxgm+SL2vd5ZEeY9/Ea7BxBi+gd6zEnbzwcN5VX+cAc0RzlrM2KUoabiu
 amhrczIQN5aae6bUrB8L7bH4+6EiWlafq2JgOGNvCZWx0IOOCgdzqOzGSGisx68QhBKJ
 uCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320210; x=1782925010;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+EqRj5jMgg8YSg0edfvj261vo+pqDmC5SgvF26S5GE4=;
 b=aq4rpBoJwxC220OQQvFlHzIGOFUuXYNmQ8oD7TWm8820KSZmu8576r6gpdedVh5GMo
 gG50v5KDhWdvQqtbdZ0+FnjqvgiQIgxZqRTPExf3dvJ8tr/VLfTf+vYbFZkndAFh1Jrr
 KX1xmWduy2IcVtdsH2Ij55YOki/J/KV2E1vZNgvf9VOMHascusUM16RgN6o4dTQEDmHN
 VYor+spNgwV+z0elQmeDJS5wNluDB9nobxMQL01Ll4nw6y9hH0bwweSbJVyfeNLGocD6
 OfmKpKdMu6OBETcfqsJuVN8Qy2GLpCwejz3jyhsnUiHiQcQobVjYk/x/ZSDD7AAJi0GT
 ktFw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6mut3iPJZXtYxs2qOH41ssyMMNINYNW3jGcZs/Luy4XEv24SZT/+3XmMXcLaeCTUX1E9wwXTL4FSj@nongnu.org
X-Gm-Message-State: AOJu0YywiSOQ25Wzb5r4boDJrKGHujB9j2jNBK72d/mjJrip2R5CsCcT
 NFEfBAyYjSiadOHubXLmgbvdrB/71HvA5XqwONOAyW+TvC6/Q0lOpr4pWeufdcDNkwgWP5IpWfs
 krdWx/W1+8tesOMbF1KrLd5v+M5dTNA+VRGp3uJw1qZSBUSntXMTt4TE3JQ==
X-Gm-Gg: AfdE7cmBx24vQtL8unyrC4U+RTV2YpaCpZ7HOuVNwMnCYsXLHVsLkyzMjFdDaULwsPR
 NkmAl/xA0Q/36SY8DBpgyBVZ6FI7/d9VYMmdOBtt2hxfGQj0pkAu19oQ4DupI70luQVnUX/fJom
 vUDVOqBre0glxHzYirGlIc8AJXMJRMRt9Xcx30FFUIOCBFgtueTxfB1YQKZoQ/IAL08Iej1MlML
 gJcTx7z8LZCefNBFsqEeB7JkGbsyx0NjEEB7h5oYACz1SHau9Y6yw+j510JOydy2hl7VuOjB/tZ
 4NTlMF4fTZoIR17KqP6vY/bFPieZQ/tiw0yQgzpAP6EYGv563zq4Aq23XM7w+xqPq8Agwrjh6Dq
 Fz9ikHG/usq5ZhAgVMrn5z3g0tEVoDJIaa1A12kZ3iyPwbgLhE3qe2XEd9Sgqnbnv6igfqWxXa7
 RD1yk=
X-Received: by 2002:a05:7300:4315:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c692d7a36mr4396916eec.18.1782320209868; 
 Wed, 24 Jun 2026 09:56:49 -0700 (PDT)
X-Received: by 2002:a05:7300:4315:b0:304:6448:dfd7 with SMTP id
 5a478bee46e88-30c692d7a36mr4396874eec.18.1782320209257; 
 Wed, 24 Jun 2026 09:56:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab28fasm418102eec.30.2026.06.24.09.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:56:48 -0700 (PDT)
Message-ID: <46fd3141-4f3d-441a-a0a8-bdb595459069@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:56:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] gitlab: move .meson_job_template into base.yaml
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-3-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX8Pfq6vp8SW/P
 Ytg/WFYLjZrYcHsAePKDlMf8PqYDMa80C1d72cD8bfZV/ndOhl7k/2txtAVH/8wKicalY7wMFy+
 bwp/+ozygHTrlIsKjk732Ngkl5CHZw7F5nnO7A31D7GF8k+jvqx3xsSeICU+kMbvCtCajxOFSB/
 HfkJxgmZ/mFOPaOnj/dr54MvxIGIMbQdzQj6dwweWi93COWcEKB4P4gPSFA+4D7LDDLOTW+chAg
 GysWhqENZnYakuJLXW5+zOWeDmY7Vic9TDpNT4g43SDwRBYjxNaI2mlqbH0k9jSp/OA9fYUlgmK
 6Ex+pDohKFWtoDh/ktBKGp+J4CpseCim/RlgUV+NIZ3fIP+HLieb8sF7VJGhVQjSvGJjdHekTg0
 m+UTxWQuTQLLDzwmGZhZrB19n8IOR+R/L2StrGqiKPE/E+3+SyIrVkJ62/9gAy8h/UsrQKO1IZx
 NTPLTuM+/+INGUnY3oQ==
X-Proofpoint-ORIG-GUID: QE1KzU55HxH-2qJBs3T_EPmTwP3yOQwY
X-Authority-Analysis: v=2.4 cv=ZM7nX37b c=1 sm=1 tr=0 ts=6a3c0c52 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_V2mMwgddJqp2tfdn-wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: QE1KzU55HxH-2qJBs3T_EPmTwP3yOQwY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX0vwiwrZeKw0g
 WUMtwKuqKqH8CBRgaaS1LZ0qODkib9pNbAXfrGL8A87dJYu4JwR9Uw3iWCJwhtXyId+5cMQCRUY
 GnbaDROEVtDMmG+FPT06Bm50ZMXup5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/24/2026 5:46 AM, Daniel P. Berrangé wrote:
> Rename .meson_job_template to .base_meson_job_template and move
> it into base.yml, in prep for wider reuse.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml               | 14 ++++++++++++++
>  .gitlab-ci.d/buildtest-template.yml | 20 +++-----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

