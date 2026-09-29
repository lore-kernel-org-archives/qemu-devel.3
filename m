Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B7CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBR5e-0004xG-Fv; Tue, 29 Sep 2026 02:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBR5c-0004wh-UL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:13:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBR5b-000680-5a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:13:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47XRp3654790
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YZUaIeJL1e7TKym6CtnH6O4LjSCUqRp72FT74TOCj0I=; b=fD4aMbXS55XzMAgt
 ZjITL8vL2UsoWU7q+jpJjwZlzKeilXUZL/zaXvuMdR6Cbs5WXZkOZdiV0XtMBf3a
 DvXcFlwP97y6BtW20jPAMqJZss2XhYk4iywzMdQpvb/j9StlR1PeZYc+7RHoCckD
 QnmOvr9kEfHk6VFI/jMgXqBM2lpbcU2troV5kwcvWi2JnseT88wKwYlIqEZ/Humv
 0BM84Tz2/WwW8ke1lf+crbFV+rJClYDRal2nb0k02XQfICvr3L3M+KL+i8dvzrIi
 W6PXQwz8yD7yxFkZoKS2r2m+Y5S3BNtFXvKTEQqfvofvQYc/8TNvm0m4FrO5/m8w
 wCZZaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew0xm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:13:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so788034685a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790662396; x=1791267196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YZUaIeJL1e7TKym6CtnH6O4LjSCUqRp72FT74TOCj0I=;
 b=hZ7lg106+K0jyHF6QngJ4HM4MOvpEIuDgegFRi3mOQr7vJtkcyzcEa7v2y+uNTF71z
 EkdhIdITDFXmxp/58BTH3L19efvrfX5tJ8yWQJ/EpCHOkgPQqpRhFpTzjJc2IfbSNpA4
 bH+5OnIIiMgAR4/oNGGsQxDfO1S9mzx2s9+lwNeO/yqVV/1Pc9Ub0o/+M3gY/nu2Fc8p
 TDZR0+PxWPnAROHk/EJz4H076cB0xaSRtZHHHaEIjRzXdGP1triWFCqVyJebHfcof6su
 pW3SL8MIWpjhN8EEsE5ybMOjwGSmC9xG6oyx+c9K677D5QwSzYIyLt9i/IAiUsy77JKM
 Bb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790662396; x=1791267196;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YZUaIeJL1e7TKym6CtnH6O4LjSCUqRp72FT74TOCj0I=;
 b=ZHJvbvDJimO5T2dP6GSj4asuNk1cKjGQSingeezKgOuzAU5yZZhF7fneNWyyoEFjaC
 bzdItwNJbCJk8bBZ+JlWDbhjvE/wI6w70YRuuY/F1ZFzHBvq5+tN3HfHNPXJForHKIj8
 9ktoI1MmlfTRU92OSinpeF/qPXFNx1p89sVy/j9fncrRLqU1e1c4pZdOyRlMouOOK2RC
 eO+jdQ7jXEjr7PGucO3u/7X51Ll4JGrzQxZEcu6ZSP20N+OyYgAZwN9nk96COmlCIq5M
 GIVW23eZ2nVn5KUUyZxMhCOQBJ805Mb4jw5XlOIGTuv0609cCBLXuu5APHE+ZlcSu1FS
 cMRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+y5TXXkooEAepdpDvog0knsbDMdkXdhr+oCdpD3iGh/DRGfErQVTItThrhq08IJDQhsWBRO4PPN8a@nongnu.org
X-Gm-Message-State: AFuF++kbo/QeJrleWXgLDNIpybcYsfsnseKkai0QOmvq/1O9GyXhvLsS
 QrY6D5g+iYgBWN8NuMgrMELrrk+17/a52TrAyPAqQrLhNqB8qk477K6F6dFtjCYBlExCZr3tWVS
 AjLxixbvMH1EOy+5IgMxEdK//7uUDQRsdu9E6E2NH33JQUGe1U5bXFcABNw==
X-Gm-Gg: AYBFou0PXPylksummIPAdUJGxLIPN+KjzDKNezFIyx4JKHkJSttuAH/D+fIDeeJOaLX
 Wz7GY5Kal72C4964xNxbytExgeJIrI9wV4FxICzQqdCfmvdLDEoECLTsnn3hk2pzsl+vTLsTqWm
 ZmqPhzBCfYxfa27ue2ZNq/2UKsY81/D5yGQJLy0vsV+U4EBSgqBvu7y/fiIyZYjmHZMFtvKftfT
 IgRLRCwApMUbE1pbB46pJC7fOyVZyUMhkjfK4iOINDLr6lWHdL1SIiXDKY/ml6FL2u3/7yL7bDC
 UOHOrJWWjyi/eLfFNyT9QTXy8vclrRsu+rw0Itemem0Xjnn3osssVHoxmGaAz21UVeRMkPjaA/G
 iLkjOCvIZzW/iLFZDqow=
X-Received: by 2002:a05:620a:3708:b0:939:abe1:ed1b with SMTP id
 af79cd13be357-93c439dca73mr2498594985a.0.1790662396051; 
 Mon, 28 Sep 2026 23:13:16 -0700 (PDT)
X-Received: by 2002:a05:620a:3708:b0:939:abe1:ed1b with SMTP id
 af79cd13be357-93c439dca73mr2498592285a.0.1790662395320; 
 Mon, 28 Sep 2026 23:13:15 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf8f93csm55229455e9.5.2026.09.28.23.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 23:13:14 -0700 (PDT)
Message-ID: <a3fdb98d-b2b0-481f-819d-d96cca90acb6@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 08:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc/sun4m: Limit max_mem to what the memory
 controllers decode
To: Imre Kaloz <kaloz@kernel.org>, qemu-devel@nongnu.org
References: <20260928112935.19447-1-kaloz@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260928112935.19447-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNCBTYWx0ZWRfX/LzqCDhijQ+M
 vkyix51FZ9A6u/eHplMHmBcYiElEWJZgpZBauA/6ekaGrIqJ5d1Z/fC52mvVvYbCO42J0Glkh+J
 gBFZJTydq3LauErgpEVpQolZ6udHXjo=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abb56fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fvJkX2l8q3xbITQr0mkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNCBTYWx0ZWRfX4e7fCFWkLrh3
 YISYyQ1paCL3HH8MNrsX2jFAyxa/e/TJjNp7zecA4EWVHlPz4qTe//od/5Tr9XW1ihCDyf+1Sfg
 fHu5wKy99voBvKgrelfzYbtmiFzJfj3yfA4yn+5ktgtZfFXn5qJdySPxZWZDsrxajZ7/K6Pm/OV
 jWZxYFLIjDEzrQOTCO1T44kWr5FsNvAjU2ZTPBD8kfQ7R5NHz6P4tSS3aCr1wkIKzeDFvnvasZ3
 q0ggZDjRWBm5L7hcyHaAB5hjtXMA+AyByeevHFkXgA5unIhDJY3AcQlivx1Jb76+G6hZAugOius
 bQBKn8LPI66hGV/CvTVwr1CXpb2TCLZmzoYssN8RuERotSzGo2krb9RRXJeTqt55CkfU5aiURbg
 ux8sEu2TfNu82WWqRc3x30apGz3kMEAsRi7oc3UKJ8g0CRWEWIMy2UEDzKNKT80PaPOIj7Wf++q
 I3N4ZGa5QOWPBnbzKFw==
X-Proofpoint-GUID: PToCIf1F5snLqD8EmulnBqxwQeMxbF5L
X-Proofpoint-ORIG-GUID: PToCIf1F5snLqD8EmulnBqxwQeMxbF5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 2026-09-28 13:29, Imre Kaloz wrote:
> The SS-10, SS-20 and SPARCserver 600MP accept -m up to 60 GiB, and the
> LX, SS-4, SPARCclassic and Voyager accept 256 MiB, more than any of
> these machines could hold. On the SS-10, SS-20 and 600MP, sizes above
> the hardware limit fall into three ranges:
> 
> - Up to 4 GiB, QEMU maps the RAM, but no real machine could hold it.
> - From 4 GiB, the size wraps around in the firmware. QEMU passes it as
>    an 8-byte fw_cfg item, but the sparc32 OpenBIOS reads only its low
>    32 bits, so -m 5120 boots as if it were -m 1024.
> - Above about 56 GiB, the RAM also overlaps the SBus devices, which
>    start at 0xe20000000 (TCX).
> 
> Set each limit from the real hardware:
> 
> - The SS-10 and SS-20 memory controllers (EMC and SMC) decode eight
>    SIMM slots as 64 MiB windows from 29 DRAM address bits, 512 MiB in
>    total (Sun patent EP0571099).
> - The SPARCserver 600MP takes at max 1 GiB, onboard plus expansion
>    boards (SPARCsystem 600MP service manual, 800-5318).
> - The SS-4 takes at most 160 MiB in its five SIMM slots.
> - The LX and SPARCclassic use the microSPARC-I on-chip controller,
>    which decodes four 32 MiB banks, 128 MiB.
> - The Voyager has 16 MiB onboard and two slots for 16 or 32 MiB cards,
>    80 MiB. Its default RAM size becomes 80 MiB, so -M Voyager without
>    -m still starts.
> - The SPARCbook model gets 128 MiB, the decode limit of its
>    microSPARC-I. This keeps QEMU's default -m of 128 MiB working and
>    does not describe a real SPARCbook configuration.
> 
> Machines without ECC map an empty slot so that accesses to missing RAM
> do not fault. It now ends at iommu_base, where memory decode ends on
> those machines, rather than at max_mem.
> 
> Update the maximum memory sizes in docs/system/target-sparc.rst.
> 
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>   docs/system/target-sparc.rst |  6 ++++--
>   hw/sparc/sun4m.c             | 24 ++++++++++++++----------
>   2 files changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

