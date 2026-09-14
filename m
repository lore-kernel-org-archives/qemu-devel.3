Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365EEC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Bis-0001r6-18; Mon, 14 Sep 2026 14:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6BiR-0001mQ-Ha
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:47:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6BiP-0006GG-VN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:47:43 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIW8Jf1761290
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VEknSY6wbOGVcovw0QSltZjbE2fEKSsFnuCeEnEb1VA=; b=LI79a5Gp2fHyt7dL
 C+5N/C8lPw10lfzsVIsFoqE71ksX1aUGsvloJKMGJynp5gxKjztrpFO6LilRgLY3
 l7XSHpV5fVcpi1YzLp7J2RRkcGiPkEezq11BHLWlip6tqidYtWwtutPwymF+PqrS
 /NXvLws1IHWpfoYDhyl1/aN3BZ/rYNjkl8Hrz69c6hlFZWGE8qjj29uz8xMtiX+U
 K4Qsq9g6ZtQFWf4yWM+P/K9lzGTLNEChZeLmZUmY+v/5uacJKnpWiGnpob7MoBQG
 Kcym7a0Hcn+eAH5rKpUubWTdzYqp7E1n8AaFL1pl+Sd698ja8cP2gYsCic+A03fh
 qrdXnQ==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeexa66j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:47:38 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6c1b7981b4eso2496762eaf.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789411658; cv=none;
 d=google.com; s=arc-20260327;
 b=BEkGIuk01dqHQlY0MVsQVYWpAHsRyMj9hHnk1np8nrXCgRYmWOYxJneKRQ1fn7T3ff
 TY1Jgu0ofCYWzOzJ72GEl9ihoyqw0qPtOjVwSGKr5G928GRJV23oPhhAHUqH0EbIUHKT
 AVP+pjPti3BZJ3BgDi9MX/6OKlxcfabSK8eqmxewpVcrYKOVwBgozR5dDC6TKom42siI
 uiMNmDbaIoso5xGJ5WIHLEuGCCJEG8VfwRTyQvOD33E+/2cel0FzOa5j68NsOEPIgOBn
 I3NToSU97Tb2ZXpXEUYoJcsamvVYc0y269JsbK1St9SPp8kjNgi5srAHIE5KfUB5xXYe
 RXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VEknSY6wbOGVcovw0QSltZjbE2fEKSsFnuCeEnEb1VA=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=GVVY8xh2XmXA3TkNwoIsiu4Bm/aALvhvLqDy+cqjVzdXl8kCwqIHBUtM6uabWeqnEY
 gsMENh6a7nqBJtDmUlCULsdOE42XQoC1Al83kgrszSfZiqd/iQwI90uMcaJW2LRc4hqb
 QHmE7y9QgFhPqYS3TTYvtxgAzVL4A4OrULm6YRqKqwpwq0Ns5WOzUDrFU5JZjmWDVCDI
 MCG7Ffak/vLZvHnvdkvX3Zrqb6pzMXiApdhEnQL7FphKhwIc0oyTUFdgeo7OahZHNWrZ
 j6/qh/Hd9+93h7HruQ7VE8ra0v6k8KP7la6bXQkQLMn7/VXi0GBUgdqmnuN6UqqtCiF5
 oNzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789411658; x=1790016458; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VEknSY6wbOGVcovw0QSltZjbE2fEKSsFnuCeEnEb1VA=;
 b=YQ34x5k6IpNgtOwLRNplNEAi2fpoDlsx34eQlWJafaDe3TFUPLeAwq9dvtFnDGxi0u
 Wr3LsZBBzGc7gJsZ3PuL79C1oorI/AcHcHms1zp40N+svpmBdrmdsn1yOy/uXfMTETer
 vBpPR12krUdyLas5lGcL16C9QvsiPnhzb5GAwWpIdPOFkvBNlmOqp8fTT3Qe40DIgz3m
 jj+HN083qah0RTQ3MH1Qsjr0mSaWvL5SUoR0iX01IeLU2X2LTQ9CVMefmhVRaNMKmXne
 VFkLXfsVY3jVzjDyNSvaSyNvEbtCgD7h6MXUHTBalucRAUyMj6c40g7PNvTIzM5PBN7u
 BQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789411658; x=1790016458;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VEknSY6wbOGVcovw0QSltZjbE2fEKSsFnuCeEnEb1VA=;
 b=mgsFuJtEeig0FaVwWtgWeVCpX62RTdj8qmpYUBFSaHNeYeB39TwMTglbXLatj6FPQW
 7aqMamWENnHiaVMBVkAR7W8xfoRy2fzH4b8OZ6m2ZPFH0w3Skih+rQgXMKbHJWdmti8r
 LnftyeNCPmhFa3XLMv8P2jfiCIYHcTXG18Jp0S1ENL2IGXEXWOja5C7pum6Cch+leDH3
 Ch0qwUTfDIg5wmwn3BYjgJxwhG+7STfMFAZscjaOTccH6ttUtNJHCpO4Hzfqta5UhBBB
 gLh9n0KqeCJGxwOz/ZJR4zWwRgM/b6KomokjMMAAcjyzmTwaD7mulvSn06ydJPEtMPG9
 EWhA==
X-Gm-Message-State: AFuF++lxGXdrMReV15y+nBdLjWhkxvqV5c0fOw0k4kPxjTCO/udd1mTU
 57YOsoCnwKxMGMJ7hjJ5yhnRYCBuCrvl+w3MZ4LiX6A/SJAK3JFbLbCWluiiWv5CXTX+t/FndH2
 ZyKjMD0U0CTol02wN/mLXxhq+/U1sn1l5H96ZUcbkdRB6tAM7Vcj9H2warEtw5AUWVsxNH7joke
 K8vv7PtCJx+l55lMqW5avNO5LJ61+OiQL6
X-Gm-Gg: AYBFou1SicEBjJ5gJm/6k0B7kKDH4HXtvi8QHwhrma8LanepODMD0HwZLnS0vvpUFdg
 trQsOZMptTPAy0gmb+mwsoWeOmibrzlfwEWmzLrYJZGAZZY1XbPDf3Tcv8bsDekRQrvjLpZAepc
 6+ITM0aBh0itrssGq2VDRtf+AZC1vJRmFuJrL+FL9UK1fBRw9it5P6cxc6SBQ7HY1QDhL/RWhZK
 iYSDOC5wMrrB482Vg==
X-Received: by 2002:a05:6820:f00b:b0:6b1:3534:a5b8 with SMTP id
 006d021491bc7-6c53f047111mr2243427eaf.15.1789411657954; 
 Mon, 14 Sep 2026 11:47:37 -0700 (PDT)
X-Received: by 2002:a05:6820:f00b:b0:6b1:3534:a5b8 with SMTP id
 006d021491bc7-6c53f047111mr2243415eaf.15.1789411657516; Mon, 14 Sep 2026
 11:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-5-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-5-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:47:25 -0500
X-Gm-Features: AcwNN1UX53uRY-NNvxQGP9S7KTw5qSOAASA-zNImr_ulf545xgjNQqCJ4H2KJfQ
Message-ID: <CAJ+KCYOT6EFSmz41wL-LYQdKGpryGmR-8rPQOWejfvwRaRVjPw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] Hexagon (target/hexagon) Check for vreg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI2NyBTYWx0ZWRfXymA7ZD6zDRZh
 BzLsMucIz1RLCB1NgAcn6Mgk/DDqfEEIxqBlI+Mkg5yl8NKZ0Y7tnz+L2b1kgVIo0a6Ld7ir1pF
 yi/Qy7MYxuIdDyNEpTCMqBlhy0jHRasMUE16ipLWWCKu3bantXqqkVAUuSxT4hsBoza+W27yxq2
 v98zKoUpKHjBLHzsafbMnlsffnpI2W292KvAa/59SMkOS2pfBTpdSmYl3vTVkA96aPBUGXXVKyA
 +5s22BFXAok/YgYNwmPtDgKNJI7xAQAnQPUr571zl9qfki+GkAPl+Zl3Rh/5vu0sjBTOcxVeL0W
 RIqG6F+hfEkdasQq12tvjnn1RzmNjwBR8FWtoO9MK92tKzWPjj/vqEelP3UMn4hC9u8Y+dAfd8M
 A7sfZmwH9FrTIasE07Y44J/VEgV2Os2xYZLd8HJd3M8WGP/s/RKYFWOjbwQQj7xNevw/iDaf0qc
 Q/eu0QF3Su5ATgFOITg==
X-Proofpoint-GUID: 10ATY8ZUWsqw1fGMAnOM9cX3YUQfNcrO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI2NyBTYWx0ZWRfX/lxVfiiSTi1X
 b5mJCfxZ29qXqP3VCVnRo/PLM6KCuW5GKqQdenE2Uy2rqknZrdebIvQt7VvRY6qkM+8OhyFp/Z0
 ++4pS5LEo50B4nrtKMdugEaDVyz6/aU=
X-Proofpoint-ORIG-GUID: 10ATY8ZUWsqw1fGMAnOM9cX3YUQfNcrO
X-Authority-Analysis: v=2.4 cv=MsrHeGae c=1 sm=1 tr=0 ts=6aa8414a cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140267
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h | 12 +++++++++++-
>  target/hexagon/translate.c |  9 +++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

