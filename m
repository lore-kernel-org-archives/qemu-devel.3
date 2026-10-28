Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240060A2615
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RoD1JV5O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jiUFAr2N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAhj-0006c7-9X; Wed, 28 Oct 2026 16:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAhK-0006VT-0X
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:56:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAhD-0006Hq-T8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:56:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPqcw1395689
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E+bS4Z/UayaFlV0ubFkzZ3UN54x4LCng1jcpANOSJWo=; b=RoD1JV5O9mJ9J0BU
 Sa/AyBHHpRL6hiKcf1/WaHVKXltCJ2L/jpdTw1cEHCAbZhDSje6SRAYzFnmPEuCK
 BXuHbjBJtQsBF1sjgMW3QxNG5e4kI6hdLitS1JqD4Z7yzG1NW5wWGfZhL4p3vQ09
 xanTzzITqhhA9tBV4ltubo09+0rirKqceeRiqIMz5rYRv+ZETfB9aVd78ae/L+UX
 KYqRqPj5qPdjtseihPHSjL9Ik8SAykseido3yTjtZpefWenL01W+ESb953xd7NCe
 19JmkoY3+sHJLpyss747ZIu+Q/WZYW95ESU3adxlGppuwzL8/CgdumzX9kXY2Lxo
 QZvMXg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjhxgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:56:27 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3698bd5392cso80324eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220987; x=1793825787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E+bS4Z/UayaFlV0ubFkzZ3UN54x4LCng1jcpANOSJWo=;
 b=jiUFAr2NWJwhfNxOnM5griSK2TRyn4Q7XFhrkLcUATd2MeMtW6qtekvLNG28WhQp8+
 7vn+yanRZmBLAdRc7GusGkDiOiU7vgxYegvcub6A9ltQadBsTJ/CxVARGO6OiUeFieEz
 oZOFbM2oRy6o73PN/Qjsxk7mubSaiJjJRtGPYSfe8PaMf3l5v3CfXfZFp8QJqZebIrEH
 sN9kdDT4NgI8fwtLyywiIWgqKjU069/1wNS64Od2AFVbKE9zheWnJDNWmDh6252Swsyt
 FDpGFc76wvl6Von26CXO/PVOE5xwiiWe/pen6pSh8yXRndEYT+fSxvYEyrUMBp9R65+L
 xf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220987; x=1793825787;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E+bS4Z/UayaFlV0ubFkzZ3UN54x4LCng1jcpANOSJWo=;
 b=giSUTpaR7xM04Rtwz1dX9U8w/+PiJSNqlE9L8/jXovWmwogVD26dmwdG7N9uOMeAxq
 qt/3K9EjAzK+hT2PEgEny3d8+bnmQMyAbssEEBX2Jhm9Tz/NUc2WNqgVg22Jwye8TfH6
 0gnE6AlKl6xS375INDQHDKKx8y1i5wbJ2T6X5DoMb+R2sLQCxCFHX/ex6WuK4dLH9Nwh
 BEcQn3x2bY1NraMrcA0ejLHkqVAxaVELCZ5hzTyPR7F6Em+x8Vxdtx1dip3TCqscLj6m
 3tszUEtUnSiiDkbdt3CxBxQ7F7gHaVdQ+MJgx9+BfxZpld57eQUxVRiDjmIj1iRotadD
 S1Vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/lsNo2eNf+JoG1sQ5xlF+tVCMvDT+vWBmYIcam6VVlBbiAO3UVUrHBV1xdFJ47M7odtXILX6gOUoH@nongnu.org
X-Gm-Message-State: AFq9FYLJNzRD3LtTxFkgkISxYI2zoe/ERg8+rY5CJIH0cijJDJeEL5A7
 4T0srW6yl4C0W6YbpP1C89cCbVBXv6FW67Y60VhAyJvDNcZsl2rJoZ2IPbv7Uh8R3zGc9k3q32r
 NWG8GoZYA+q207C3hWW9BWgH74xLiPdLpUZ9jtkXvQGpvyi4r9wxpS+clog==
X-Gm-Gg: AYBFou0/Kl/KCEzX7vgE1lBxakRb+Er20kCHzKUu3UjjgL1wxVd3A9eiEi9iKP1HW4k
 0sr3uab8c0rakCzJUSK1wo9r1ACdlVYuoep4JoOM0WUWpnz5KEDKhGMWEZwK9JLDplezjb9OSKE
 dSPE91wu4CLKNpLa5X2PQb8qLr+qXzYtJfy8Qus1Hj30ZX4187Fs4U4DQwm2ofPkX8sMVbt4uQL
 IbU5cntpsoAuX6iWc1roJpz677/+kvQRZXpeCo15YxtO8YmAMdBVlcTMihK6T1h0qDX3ua6D/+H
 +FhnpKf7UGDourVS6K3G1CbNLz3UmxED858RklRxS8QanE7lnS6JlE91V/bpg5AgKWH74nfOeM2
 yGlL+JIRcqOVAg9GyaH0RovhLQG3X6/c9S/4UdpXzJdC3VnN3rv34DWsMK1QGxDTLIx95GnRzw0
 ximwF9+qasJCFZWiLHCiSJWIxfvroPcMDbYUBnXohaeVg=
X-Received: by 2002:a05:7300:d20f:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-36a3002ea6amr833574eec.13.1793220987078; 
 Wed, 28 Oct 2026 13:56:27 -0700 (PDT)
X-Received: by 2002:a05:7300:d20f:b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-36a3002ea6amr833538eec.13.1793220986505; 
 Wed, 28 Oct 2026 13:56:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a239d3073sm11016865eec.29.2026.10.28.13.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:56:26 -0700 (PDT)
Message-ID: <b59162fe-5f8d-4923-b6ff-133b8fbf1a41@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:56:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] hw/virtio: register s390x virtio-blk-pci and
 virtio-net-pci variants
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
 <20261028201557.2688-10-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028201557.2688-10-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfXxkyiqrO+R+8f
 XXRS5NYZpFSWZkeDC5uJwCNkDV4M9jDNzmvXuf+gNJKhvXLmAgRSeSYHC2PdI0Kvo+HT++WObiv
 qi8ZndCmkA2CYDqGQxcVmPTjjSVX9ioquFA2W5U6PaWuVOio3tYmcLa5v/9edFHaoQIP/YAKkqC
 Lm7YZJRd1MAkHBQzMi/l4k4rcRtR63WW/Pdp5Gk1uUXPtP8+qdDaqP8ofRtI36xO9kTgkAyrw31
 6Ii7vEaFgG1zs1gnNP/bdBos+fuvGnfLWOJ3USeyii8zX7H75ObjDalKrtPvCuAYRtRiKZvEOFW
 EJm9Weh0PSHqPQHbdxKEAUwU3LchFkbsAb4yoYrHS4OqsLYH9sRngp9Q2BCHsw0eV0dKYeVV429
 zLhkEujueafuxCzYWN9jlVP6xpMX9CViDCe/9BXBxBAQ3bx6TJ7LjP1rsUQ4fwoba4dGXYHegVb
 F/C18EmxHEsAvgEnNtw==
X-Proofpoint-GUID: lu0xKsTa6LaswBHcRTbzTzZicxx4_GPD
X-Proofpoint-ORIG-GUID: lu0xKsTa6LaswBHcRTbzTzZicxx4_GPD
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae2617b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=aQfS8rmGAwVBHlETe4sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MyBTYWx0ZWRfX31c8ArE4oJJn
 QYFleEPSUn4l5qjmLeD2dO4bMrw/lszU+5agwXstF4pC7xsi2/kWCWqktVkVrR5RH0My8bZJuXQ
 ORXRO8QkbB6z9KuVErVXYjtjRhPT59s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:15 PM, Yonggang Luo wrote:
> virtio-blk-pci and virtio-net-pci added the s390x loadparm property
> from class_init when target_s390x() was true. Register each
> VirtioPCIDeviceTypeInfo twice. The s390x variant calls
> pci_qdev_property_add_specifics(), which now always adds loadparm,
> and the other variant does not. target_s390x() and target_not_s390x() select
> the two.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  hw/pci/pci.c               | 13 +++++--------
>  hw/virtio/virtio-blk-pci.c | 22 +++++++++++++++++++++-
>  hw/virtio/virtio-net-pci.c | 22 +++++++++++++++++++++-
>  3 files changed, 47 insertions(+), 10 deletions(-)
>

Fine for me, let's see what virtio maintainers think about it.

Regards,
Pierrick

