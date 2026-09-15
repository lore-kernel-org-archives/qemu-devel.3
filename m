Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC972C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6a5x-0007gp-6R; Tue, 15 Sep 2026 16:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6a5u-0007ZR-CY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:49:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6a5s-0008EC-MG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:49:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FIttU0498805
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xZdMKVMaxURCm+QzrhuuLoUCbueZWZJdafQ6tOreua4=; b=hIQtmkRKizglJRSR
 MJSG/5nTcmXBRuWNuB22h7NShHZFy3mjGHA/s/pa6paDjRVUbiA3kNAes8mSr3OZ
 X6TWzbWWLeziFq2Cx1wTTRLtzMzT6aeEJJVh+pq8mknTi4/LtlYqTSXk969MG2a0
 bnWyWUOWscw4Dli85MPHqrzyLeg5i9DhTE5UGz6VYDM2UJhMBCdwFClVvm1EoyAK
 ilFELHiLA3tuYSRjAlG6HzFHn0QDRZfLc/m4S6x5dzQyA8J1EwEf2/FBGkDCHBDn
 gdtWGkRoan6bmDEd2fYFLkJ0qzdDhdQIbkDdX88A8s0nFnpDnmYOcdFlUVgqNFBV
 3QDVBg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc3ms5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 20:49:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso4645497a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789505370; x=1790110170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xZdMKVMaxURCm+QzrhuuLoUCbueZWZJdafQ6tOreua4=;
 b=c+DLXXoBMHYulfPjzKSrEHc4FX78V+/Gk/tUspjp4OwaKsc5X0sL2VtO7kuJO5dV2A
 xpl7bDodx0F/oA9TE49VSyi+uflhELE7HaUW05JexsbKS3xLQ+1he7N7TYpeh1FoB2+H
 SkJMXkULzBDIwgjrZGcBHYBh4tHjf8Jp0Arkq5mO3pkILqGzKhuN+K60PhwPVnjlPZLK
 5j4+RnkO/8lrbZ1iUFIAtN2RUPy+B3jriwFaaQKg0g/x2ZHCAxb5s/a5DIT39TE80x0A
 WdpzNZNKc9MyEVock9ANkwVWgOdgla+t6yRg2Z0fzXkbbuFRPLYG8oaV1D6i4Np7ZEyz
 WNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789505370; x=1790110170;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZdMKVMaxURCm+QzrhuuLoUCbueZWZJdafQ6tOreua4=;
 b=E5g9MlNXsytOdYOpAgCfzFoi8EM4F99K87QgeDO2nyF7wlqU0YNfDQmyzmuAMxNrA1
 B+MHSHAOpLCVQcjykPQ0KcnIpJahNcHz4vc8cHPnH0/c+/2BLA6H/BqpUycpxsKWHB83
 tPX56/6mWOPjJOy3Ixn+5WWuJw87r9+e2esQC2PqONDy/Zw5ForijTp12JoVucnPb8PP
 JIWQgv4lpQRjZhWTz6NTM+SIZAoFFfXjyuMrNbLAid9ijOQaZAxAA+prDzAC0yWjiyob
 Yagv8lCIEWJAZ8WdtbXe19irnSuXLfN4HfP0SCv+z94p0flCKe7bM9MjoltboujDIlqe
 4jNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYukQqKhcesUteUNdU5pn3g9+UYr/fygziNyugWYcMYKrnCL7GmAiCPQt1mE4pWchbUl+M3oiJLJyt@nongnu.org
X-Gm-Message-State: AFuF++liH5XINcg0HkAKTfx2cx1U5rxaGy0jVn1keBpyW6GpchXOqjPk
 rKFPyKPAHoLwML+yfpmiXSmD1myHui3OD8nYYySXOGyVRkKgoMfPCc05TcVJRb+2UMwtgTzY77T
 cikvgRNIMwx0+fmSTpAnMQj4PEDH353Ra73z0RDED5Ixo+V5FsAiGE38tKQ==
X-Gm-Gg: AYBFou0Fszo2xUfxQl3FhhLzkxByl7h5qbimmwHsprVr7Dnk9NQJa7aXWLEnhUhex1r
 lQnpeLuxUQYEcXbbCxxDXh8QmWknv9Iu9TdOjX4+phTGk9F2kP328nolOo/KB0J3hFQ2iAhIvGY
 1GpSb+qY1h6m8/vvWlguyPJtRyjuN3JxAuxjBR5jUyWOvpr/3G6wxChMKdJSUWmkF0vi7lD33d8
 zrhAhTuXRDzZfxzf6zXDC4rmyqDeCszt4nWBB9E0HzRlRzTZCb+S8+UVcnsPzhtYkdqi4qSaDrE
 +7LSJht+aXGewZ9KIYocKmgPyvaCcTiuCbKd3B6JQXRBkse8AqoM+7jatJDFVIqhFoFvLcM8v6K
 Jtkqg4zcAKTK3/yuyQRF2BW/WwbGfdtQlDmLHEaPPhbW+22bftKXTJPc9PyrT1El1U3OT
X-Received: by 2002:a05:6a20:c88f:b0:3d3:ad3c:49a7 with SMTP id
 adf61e73a8af0-3dd5f73f345mr161624637.21.1789505369843; 
 Tue, 15 Sep 2026 13:49:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:c88f:b0:3d3:ad3c:49a7 with SMTP id
 adf61e73a8af0-3dd5f73f345mr161548637.21.1789505369224; 
 Tue, 15 Sep 2026 13:49:29 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a175sm1561983eec.9.2026.09.15.13.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 13:49:28 -0700 (PDT)
Message-ID: <3ae07e71-d806-4413-be16-1a793685e4dd@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:49:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] Revert "tests/tcg/meson.build: implement
 ./configure containers options"
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
 <20260915201601.1207839-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915201601.1207839-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UgY0R7JAESiDlRFd_yZslwCLnd1Ute-U
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMwNCBTYWx0ZWRfX0mtbbDeqJfxf
 y02oGUNZhReSVsc0zOGMreATYTY+6SJxvpEhvxF31fDsAGx1z/dtA9tC0QtC0+N/YGN6iX8u0N3
 Y4CTPhAFCmo3V+fpmNBTbuShBQ41FJo=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa9af5a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-EKpmgBvVfop_6vUGXYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMwNCBTYWx0ZWRfX1Pl8KfgL/Z6I
 XY/XvQmqDILUyC1P4/B7ePBE9CJiBycsL3wqK1BkobSxRFs7QPK3H1F74pZRxnD3S4PucDf9u0v
 S07tP4El2OAmXNd67xofDAG6Xa+ZOh6cPkl75Yqd1dPvsQ8KuOs5adP5h5R0GmHWUnVKnrJwVUg
 YI3IUydbmtkwtPOrsOGnmDetDPBqy+CIwzj8fHj1d7fkiT91/QFZKyh7I73zu4i1lhlX6ESxK9j
 gZalZd9O89W30l+ck8Ml7Dx+zn2uSvgz7x68PXc3JW12DDP5eK+/WZ/Zkwr966B7etVmbK8xLT5
 PmI48scgyz+jhOq3IjL9ReYOnuwb9kjdBpHuBglXE/017IWjU3/cbQxW3s5J6mqJXioAsWoIadp
 Ovj0pXBxM56UZTypnYzHM0tDTbKHxYX4dX1oyGzdgzojVdkzQb7fAeivgqi7vm9XT466z4lZLCA
 2H2+C1gdjHKjSU3Yg+A==
X-Proofpoint-GUID: UgY0R7JAESiDlRFd_yZslwCLnd1Ute-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150304
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/15/2026 1:15 PM, Alex Bennée wrote:
> We want to keep the container configuration inside configure for the
> firmware builds.
> 
> This reverts commit 522b299ca4316d8cad57f9496ffcba87dcc20719.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> [AJB: untangle changes since]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure             | 11 ++++++++---
>  meson_options.txt     |  4 ----
>  tests/tcg/meson.build | 25 ++++---------------------
>  3 files changed, 12 insertions(+), 28 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

