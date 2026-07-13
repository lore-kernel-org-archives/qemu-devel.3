Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123E2C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEcu-0005vV-Ro; Mon, 13 Jul 2026 07:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEcs-0005uo-AH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:15:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEcq-00075N-Kn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:15:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D77Rlg810576
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TtcZIW0RVQhI1EPYeIxA3PQCxlLwT+Z7i7ldq6o96HM=; b=GtEOk4JZ1fFlQjRX
 VvXMsijxF3uoS4zbi69e+X8KXeQbYBvPuL+TZeugtHF3AXo7W5QN4tALYROwAeni
 hJECesxH8ha4y5HA86gMRYyBp0ViWdPBNINENgwmMLonp3K2GPmRwmGtaEd2+9n8
 gd+mEAzGAmkDY+V3jlDmg0cGMPBG1OFctaqScxN1AYMfSyhbmy5KFL/IunFeyJ9g
 3aPHJq5DRlOFNsKoOIJ3Oxst6F3ucMeLDZEzupJs0HEvi9IU6G+ra9BFvc1wL0y3
 pD0PftWSAhB4nmEfv9IwvrtBXjCXEjMISFBXeuk00d3YXx3LSofTiGfeL+QLCaRB
 ECvM6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcubsrvx1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:15:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bf321d786so36176051cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783941301; x=1784546101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TtcZIW0RVQhI1EPYeIxA3PQCxlLwT+Z7i7ldq6o96HM=;
 b=gxfQMp2EH1tGB4FMdIgtlgAW6s41dOZekB4Y8jotBwGxawE0GqkwDct1Tz9EwEWQBE
 9WUeQDDBHfSSMv+jrBmczCzjIKoiM/9wUsb6sKZS7YNwWUlEFw3NpZpaJ38IbXe8y6+Q
 QgNFo4zQ2F01RnO9qFfB4d2Z1BCNvRxqxFvGCXnVHr+FYiElXZ6uiAQnvFUBWDvV63dr
 srImqgB1oK0b+ue+jnyqnOigqYGMfZ85ZWWfI8bddbLqNf/8OMLw+IVKyUvJRb66PWLv
 RbQ0rFLX1BcjGs6CTiLgxTRIaq/VMZndQddS24pZtH1G2iBJymlZVXai0aO03+Dv/+o/
 iRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941301; x=1784546101;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TtcZIW0RVQhI1EPYeIxA3PQCxlLwT+Z7i7ldq6o96HM=;
 b=EVxFvEVOnIIogrnOWtZYpdCaYKlJyc3aB4yuFHfqRRfZPWatwN4cNT/70eNouDikDe
 tW2PCughDgvOMCRg+dmh6YvqIyKDULuUtSI6G+HK7+m4rmZmTXAvsy/jiXaYBYRNbJgz
 0mp4OSmcNzoTBd10AvvxKiQVICukzBPSqv9Mc5QF8H0dobN+W/QI4k8xCma/oeJcjkP4
 KZTbket6cLOmfvKXX+zDCXUZQhU7Hh84+S4KWANGEJda9dcGavciBEx25EwtTdDlqqTR
 e6DW5JQ/NjWK9NXumWst2NeAOk07rXGWZa3FDDLkKSYd5GqvKC26U4AmNNW+QSF05tng
 aWvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqs4mkQCjB0wsq3rMimJ/w3uuhWhEOVI5WHJvkyrz+REEL8d7AaRRq171JffIfd6IEF6XlZZxOMFyGu@nongnu.org
X-Gm-Message-State: AOJu0YwxcDoRpkNSnzGveVFeHrWcryeLzbtXOVdfIQxKfHx1GXYU4/Vd
 rxsvU/Vu13S77RC2Zim2IzlYLoEFGaC+FLKTHjJ14a3VCHtfyj14blKWuuGUslLMyad8CMtvwL/
 xjQL+nESDw25BkzJsQ7iAwye5MoMhNrN3GN3OnmNmiLvdkQGPMDVckFJoJpKVnmD2Jg==
X-Gm-Gg: AfdE7cki57djj+2ShTnCySVQQclLYsyxEjQ6HB9qzryJlNkm+7GZXu3HId7Bn91lcMl
 DEd+7tEu7B37mmf9Bu4AGYbV+mFojDlhswlE6J3YuxAkKb+4jHAs3uTg17FxHMfWvj5zXU9ERVe
 /oB8dvnEOF3VST2DCFc6zO7RxTzjvHWVPOU5sYbuWdi2pIbdb5lyLtM0paPio/CHAnk8kY8vePk
 K9bzHmTFtLRA7eBrOSivISg7y8eizxmcyF/+CyJitGDn4ml5hg1JZwhL8YlhtC0lHm3ysEB1lmk
 CfjWipha7dkaJdj7Z9XG2o59BTez+rYXMaqiw+ynYgb6GZGBzwrlMZInkCVsamEKE60+WOV9K/W
 cQ5VQQMpSuci1luukX2gswTBT+zQHMfSPaN82mh5ua41tl/FR1a39pNIV/Di1yg==
X-Received: by 2002:a05:622a:2cd:b0:516:cee1:4727 with SMTP id
 d75a77b69052e-51cbf05c1ecmr83526561cf.14.1783941301184; 
 Mon, 13 Jul 2026 04:15:01 -0700 (PDT)
X-Received: by 2002:a05:622a:2cd:b0:516:cee1:4727 with SMTP id
 d75a77b69052e-51cbf05c1ecmr83526361cf.14.1783941300768; 
 Mon, 13 Jul 2026 04:15:00 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15fd50d411sm485511066b.37.2026.07.13.04.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:14:59 -0700 (PDT)
Message-ID: <37a4571f-95d4-4578-9ad1-791680b7bfff@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/vnc: fix out-of-bounds write in lossy refresh dirty
 marking
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260710134921.2321027-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710134921.2321027-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Oq9/DS/t c=1 sm=1 tr=0 ts=6a54c8b5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=6b3zXhvIAAAA:8 a=EUspDBNiAAAA:8
 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=vnv6_c11HO5uxQbMB8V9:22
X-Proofpoint-ORIG-GUID: QVfoG351xQKZSuWIQwFzPIckEqNlYhy7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX0aNCXeDmtYjV
 WQBPnp7TuwEHi0urYeeDz2nqqmc1sQEa4IzGqwX2mIIgzIl0BDM35Ha+oW2gSYeNtf8PcXcMXdF
 Mf0JP6L+M/Q25Kt/g7xnzx6r13qH76o=
X-Proofpoint-GUID: QVfoG351xQKZSuWIQwFzPIckEqNlYhy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX1WJDqcPBT43a
 OdxYry3lnQ02GeZ4MPhBqoYXPuNbj7/P7GHRWLsxsxW6WJNvkQ6t+JpAFoni0+4Ef2w1njb/sR0
 j4UjI4CNBnwImY2+NOUXUBgzeo1cGV2j/dVirsFCjeVeDAuUJ5p4E4r9BGTqCAMIS3Bm1KIjOgc
 X3X+9jN8sGEXNipnPXvXSBAWQ6b/xg4/qeTtMgKHn3AVktXJCrnWALkvhPEuH+5NzngSzeDL7hm
 L3Kj1DJjv1kw389oLhyL5KmXVmHOaT14JmrgoIgMYSMzeoxOp7VbHPg2q9mr+9IPmyZqivTCVFS
 VPuwLm5RfuaN7qPw393uQr9LIeKAjkOM2lnbiX10uLnJWPzNnCNT4Dwlpv6UYmsv6miOOpX6r3B
 +lZpjqyWMP33t35CZEWAW3UOSa17F630W0qYrqgaiMvKTF4GewM/H6CqKPBQbozpoFBR30i8K3i
 qt8qHwzxhEGXBcMlKpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130117
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

On 10/7/26 15:49, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> vnc_refresh_lossy_rect() marks a full VNC_STAT_RECT (64) rows of the
> dirty bitmap when refreshing a lossy tile. When the display height is
> not a multiple of VNC_STAT_RECT, the last tile row is a partial tile and
> the loop writes past the end of vs->dirty[VNC_MAX_HEIGHT].
> 
> For example, with a 2160-pixel-high display (VNC_MAX_HEIGHT), the last
> stat tile starts at y=2112. The unconditional 64-row loop writes rows
> 2112..2175, overflowing 16 rows (640 bytes) past the dirty bitmap into
> subsequent VncState fields.
> 
> Fix by passing the effective display height into
> vnc_refresh_lossy_rect() and clamping the inner loop.
> 
> Fixes: CVE-2026-61475
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3935
> Reported-by: "Vulnerability Report" <vr@darknavy.com>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/vnc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

