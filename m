Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D0606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ocZWK5yX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j9Nqt1xL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPSjT-0006Ke-ER; Fri, 06 Nov 2026 17:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@oss.qualcomm.com>)
 id 1xPSb6-0005d0-Fr
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:39:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@oss.qualcomm.com>)
 id 1xPSb4-0003Jy-H6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 17:39:48 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6JLVOb620731
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 22:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OrvMJ1xyvN2i/CjVxAUaiDjE8iaiPNk1P8XsM9KAwTA=; b=ocZWK5yX9XsAYPDh
 gYKsM33qlPhs5UrdBtkd+/EvB5pR4TKT3dccKBx2JslVQYBj4LQJHreKau9wh2+s
 Xk91yKrikIkfz7RloizO0gaodXK/S75HAiP7XvCKIkoRU2Y4IXMXwWtgKAGlQhN3
 1wPgtzN8UJcxBsGMUU3yzH4kB098UY5JfLGP/QGLud2GdsmFeYXGtYJTa7K1g0Yh
 8ljWTyF/krXdxlEiWsquWIol/Xaz46PjfFsd3Dqf3yOChdx+YaX3R5LObxkLc805
 9aOXM1x2wtB7Tx32FEn9fOyhS431me+iXk+Olp7RxA1lH9Jx2mYRKf5VZ2RAgPqs
 /UE3hQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyv0myg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 22:39:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso1523280eec.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 14:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794004782; x=1794609582; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:organization
 :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OrvMJ1xyvN2i/CjVxAUaiDjE8iaiPNk1P8XsM9KAwTA=;
 b=j9Nqt1xLFPuS/onz/0ujhene3UxF58hmp1lxgrfNXKurfOf8CWc4VOSAP1DA0dxEI8
 iR4lVPfDvr37RZEUvFCjs2fh+luy30IptoRjHAP60ImWrfY6P1PkXhJetLiUocMS1147
 Q2nyQqG4D4c4yy17yKNi8DJc97FiCZdxde98i2NFdSmc/2WruYvdGu8P1Xu1F5vXiVan
 z9Pt9fPIyKgF/BhWktYAVquHaALhireCYw7OseLgBYZlssspujzUi4PnWfjRRfHi0uAh
 LqGkJKaxBndD5EDIt9paVvoRTWcP3JQ1giuJzTo4V3nDYe8V6BaKbP9ZnpdSj6m41Awr
 drTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794004782; x=1794609582;
 h=content-transfer-encoding:content-type:mime-version:organization
 :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OrvMJ1xyvN2i/CjVxAUaiDjE8iaiPNk1P8XsM9KAwTA=;
 b=ifrV3jw1kWiGFa3sQYQ/UchYEKgPoq6vXHZk+ZIkG8CqGwgFuuqPaGlKzLob4ogR1b
 tS+tdoBtHpUp3ixUSJjM8vHikuS3SugYqJ3uK866frD05D00fXR24OkTrqfdvlUK89jr
 aAX7gHHa321KL7jxD/ykmus3AWxU4EsVF4XdWOtRRJRNNUr9owb1eSvVyCkwGwO5Tj+B
 eBUjMMUeT9KRC9TvZDFoppaCYfNpiCX+otep1RR7pf7LHiHRPoHLVWokNodu3YUzObJE
 nUZx3jgbc+DWeaImwuFz85HgrQ0A1achxSoDy00IhLkbBFrCW+14d4kBKvoBuPqC9Cmf
 E0Rw==
X-Forwarded-Encrypted: i=1;
 AL+hErGTztMhoijasj4X8mCiqNSHAE9UksGKpOKkuVxhe4TzveHF9wls6wctPdOfnyfkdT0gaPfVx9UG7WGy@nongnu.org
X-Gm-Message-State: APuU4Z9k4u4saVKOUsBmY1qRVTDYDuV3FWKDWQ/hmtN94enYGD3Ru8qZ
 ncC09gAMtpDJJsaPH+Yky4I6fg5oyNNDqVZS57mmPPs0mHwD0wmvMwPS2Sc11W6H2EVeogzaJWR
 IHqXklR7WfR3Pe8o7Ayi+jSIS+EuVDOMzI8T0urMmPTFGc/iUh0P5w+OICw==
X-Gm-Gg: AYBFou2w/NyyuJOIydK4VZht/aPmJ1D2oilwxUebUmOBvDEiPrmNq8QGQ2D/za6iiBM
 pgjK2TUfzJMMIJfuiX/+jiJWkeOoOm1I7JyG61ZycYl0tDKTynKshV3UPS1H69GCv8SexxRDog9
 qgxTwwUzMB57Fme5bRZXAOJaOzq7F8AsqCP7+nLHJ9ST3GGFDAo6QwSqjX2YKuvCPygRI3xOIh5
 VQjwo8Mjm+ystvyXEm8nDuBZwMc79BTq40FtELcL6fF+EGQK+NJWIQKdEgK/7CwOtuaog8WMDJz
 PSUHNPInOYlBQsRUlJshIrbzA13D+4k4kOWLmHMVjx57yAlkoFckoxVtLkPCt1ELzDAR6W5ZhgE
 snlNaQ0Gq189ZKDEbFnl4EhKzeVC9E4gRXKWUKaVMKuKKoCjzG5s1ms0LmlgW0X/UiXegeKqjpI
 LPne+Xo4H2u2TbbcX0f26iryOgrQs=
X-Received: by 2002:a05:7300:f3c8:b0:36a:1fa2:fbbe with SMTP id
 5a478bee46e88-36f76918e5emr5028686eec.41.1794004782199; 
 Fri, 06 Nov 2026 14:39:42 -0800 (PST)
X-Received: by 2002:a05:7300:f3c8:b0:36a:1fa2:fbbe with SMTP id
 5a478bee46e88-36f76918e5emr5028649eec.41.1794004781446; 
 Fri, 06 Nov 2026 14:39:41 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa651e6b1sm21274432eec.3.2026.11.06.14.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 14:39:41 -0800 (PST)
Date: Fri, 6 Nov 2026 14:39:37 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 37/37] hw/arm/mpam: Implement query-mpam-cache
Message-ID: <20261106143937.00000cca@oss.qualcomm.com>
In-Reply-To: <tencent_B7E4F1EE8A5BDAD20424E2F8AD9AD4E54C06@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_B7E4F1EE8A5BDAD20424E2F8AD9AD4E54C06@qq.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6aScTdWKfYCXLJZE4Bfxst4t4L9E5EHX
X-Authority-Analysis: v=2.4 cv=IdYSymqa c=1 sm=1 tr=0 ts=6aee572f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=dZbOZ2KzAAAA:8 a=i0EeH86SAAAA:8 a=D7E5GI0eq5GKvOykQcwA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MCBTYWx0ZWRfX5P09OeDpC4HG
 IeHVQSO7L5NzwsOnDWDvi4L+kov+M2AtBC7ezB8CS+ByeP6CFq8vt353/5S4rZFh5tk4Bzset6Z
 UhVabj5jDY78pbMAcStBUh9rXN57ls8=
X-Proofpoint-GUID: 6aScTdWKfYCXLJZE4Bfxst4t4L9E5EHX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MCBTYWx0ZWRfXwRQvoDndFdjN
 3WBLlMFJYWhXVnoE29FKhBgONDxRCFEvanOxZRhVRGguu1Cjnhy22s0nlaN0c/pwghCE8XVKe8P
 iFWrs6p5FzKIh7B3K3rdZN34fTZ5MiU1rJU+5zQ/QyI/oy4YCG6+IEdqJdDPhBNN6uZMCE2Q8ey
 L6YUvh0zfCNqwB3IbEe3iCiYZ3PfSsgaURcadlxQu+mZz9+/QxtSIPVYZeJpAKx0bHhR+K6on1G
 GdJL+atzKESOypqCHykq6ltzGnDrHsTOxiH2qOlo51/g4N++J+3vO4TST3azWAO38BPD5IKrsDu
 mEdXsus3Yj1iPkn2uq4tf4gCMhedH8vRLtWb6WKo4hqQH5vaHO/OnQLsnU+vyn40z3LtIQaZSzF
 TBNpzDe2L++EnTIQFu1UpYUVOYMgSuvfkDJ66cuhSvyqFxhi08HeWt3GgmfqWSZ3kAlMTJ/AYNw
 Ccn+qfJ1oEHx/sSQmww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jonathan.cameron@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 06 Nov 2026 17:48:25 -0500
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:57 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Implement the query-mpam-cache QMP command: walk the QOM tree for
> mpam-msc-cache devices and report each via mpam_cache_fill_info()
> (with the per-RIS register state and the configured CPBM bitmaps),
> building on the generated header now included from the device
> contract header.
> 
> Based on an RFC series by Jonathan Cameron, adapted to the current
> qapi documentation rules.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/meson.build    |  5 ++--
>  hw/arm/mpam-qapi.c    | 62 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/mpam.c         | 66 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/mpam.h |  3 ++
>  4 files changed, 134 insertions(+), 2 deletions(-)
>  create mode 100644 hw/arm/mpam-qapi.c
> 
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index adf9146..da73546 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -106,8 +106,9 @@ arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
>  arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
>  arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
>  arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
> -arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c'))
> -arm_common_ss.add(files('mpam-qapi-stubs.c'))
> +arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c', 'mpam-qapi.c'))
> +arm_common_ss.add(when: 'CONFIG_MPAM', if_false: files('mpam-qapi-stubs.c'))
> +arm_common_ss.add(when: 'CONFIG_ALL', if_true: files('mpam-qapi-stubs.c'))
This doesn't build with non arm targets. Needs an update to something like
drop the last two lines and replace with

stub_ss.add(files('mpam-qapi-stubs.c'))

Also I'd squash the previous path and this one to keep the build files simple.




>  arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>  arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>  arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))

