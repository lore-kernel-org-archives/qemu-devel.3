Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDB606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MRBDtEo0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FaWuuxrx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYvM-00063N-DN; Wed, 04 Nov 2026 06:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOYvJ-00062O-Op
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:12:58 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOYvI-0002e2-9d
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:12:57 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4B5ogM1290016
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 11:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 knOQRZNkOlRsXWXziLkcMOLtbl74KQrinK9bEeSYISE=; b=MRBDtEo0c/D/yf3B
 0Xn5sIqHdTFcasoQ9oYj6XKaXmehcqZrSoOMYMGAVlePX2WRFE80f1Df73Gu28Bv
 3urZ/uf5ui65cFkLGHbB0QC2rRxt/3ZMR/qx/Odf7SheWRQpWRV2z0Bs4kpkWV9E
 JE7kCGmid8PULzhAnVxHfrI9EDJbDuNBv4TPGelCfvJZivSs9veifYU6f+Qc2im9
 sXb+ARFEHWA3vrzaDlptPhstUkp8P+yw7u0BWtqidOI0vEMLcrQihigznhtN0a7q
 8sZw068Cxa3rjaf9ia3dTiS/13cmZMA5w55yIG+zT64b54y8cjBklGDGMASpN2EO
 HFyD1g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsg9snb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:12:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7b206156cc6so410308137.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793790774; x=1794395574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=knOQRZNkOlRsXWXziLkcMOLtbl74KQrinK9bEeSYISE=;
 b=FaWuuxrxhGUI/4ImWZol3+CaSASHSZ38+//aPO5VBD+u5P75JF+NAXb++0fBuj5iOw
 AZFxL7dyxf6Um0p+rfx0iaZPUNHgGSWd/TCLyq6dDKp1W4i2rsUPWW5D7I2r3ZUB9ld7
 yTNkiK/TgJ6dWGT5L3b0STC0eEGe9Kc/J/8wC310uN5m25J58MPoBvCokfZeo/IaUE9P
 pQQXe1alc0WLJiJ0hui1yuhpbQ1j/IT3rO+ewDVzsu+e34aFixjkll/RdvkftsJA5gXg
 MOBZarcQwev5TSvin9pq8BU1VroXMzGV/GgRTtEeG313boGuExPn1PuMTySwqRuoI1bO
 txNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793790774; x=1794395574;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knOQRZNkOlRsXWXziLkcMOLtbl74KQrinK9bEeSYISE=;
 b=OgZ0FaomDE51DKy9wVpZAppr6pbH8GW9HBzLTMfvpsM9rvUzCV4k/MLsUGaV87ZZiS
 E5RAuhTEbWr2h4xSwBHJtP8fgyCwvTbXktJ48Yb7N5SmSNZBrgIqXVYYbwMZHxf+Krtn
 keIhm+JJQdldXgrSRWxJPkrpTei7HgQZqf4kV2ahEN2Qt/0GqwsL6OMqF4NPI8o7spos
 5/NesUB21xiCSyNgSZDXtOhiAWOD/rUzmMaRVHOf8V3y/wbPERExL32WwHHiYoLTzszH
 FMCie8WtlpS7AxeIYOjPDPQubKi2j1vh1BqtMhukEBIhx1QHTBmDJkIu7DjJTF2fkohj
 uT4A==
X-Forwarded-Encrypted: i=1;
 AKwUvByvkujMBCNQ++HrIiN/cftSFgUvyDpTtrXImB9KoK6jNto/uHwrIYffXeh3Jq6SRQBRc033yU0+6Kml@nongnu.org
X-Gm-Message-State: APuU4Z+xKZRsWS2VL3rrwZKG1e7Lq8KeTqDIIXMsUUNtneMMnT63t6Jh
 coqHYiiycMCVCyjUomzQekMpzRCfO45K2SWGE2VGy7eWTrXQNkP/aBx8XabPDQTNfAAlOsxFGDR
 Ca6gWTwSXNu9Lkbowh/J1ExNCgrFefhKmIi08zS59hTl/5fYUDDnudTJprg==
X-Gm-Gg: AYBFou2Xizqf5mXHRmWvNGrvhRPwHFpQT003FqC14kRBoEybC+TXCKgjoV4inRXHwmn
 zgKFO5eu+pYLP4CE2dZ9gABjz0//9hhQPNovZ5hymrrFyoOJV/dPju3wTITMWli6ZY8jKOmOOpL
 6e7ySAZ6sN7esWCIq8CX+Fq7peVGl7/AWOrouGOiIPUK9bM5xQJze1KX5n0jH9kCb+kt/SmJBeQ
 mUKbxwbWxv4PivQ6a9wQ9xbHB2THk6vFesX6jwIWToR5VjJ7xrEVPEFUgamHMgYWayvnUa9naMK
 vI77O5qZSR0DqBFLN3Zii1kYAzIWRhq5vylcFGCfsmy460d98JO90NTi5uugg8r0VcUOMQf5VDh
 TXcomuwlbA73VHvRRTurY1olSX32m+wpCDoB1AbLaQ0HtEUc/W4ykoLtgbixNxQg1IoRuDLZXNJ
 YhIkAcMA==
X-Received: by 2002:a05:6102:2906:b0:7d0:57e3:d480 with SMTP id
 ada2fe7eead31-7d072bc7545mr6830921137.11.1793790773854; 
 Wed, 04 Nov 2026 03:12:53 -0800 (PST)
X-Received: by 2002:a05:6102:2906:b0:7d0:57e3:d480 with SMTP id
 ada2fe7eead31-7d072bc7545mr6830913137.11.1793790773418; 
 Wed, 04 Nov 2026 03:12:53 -0800 (PST)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea181079sm3582702f8f.8.2026.11.04.03.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 03:12:51 -0800 (PST)
Message-ID: <2fe49ce7-e264-4fea-b7ef-03a438e0d9bb@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 12:12:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/gpio/pca9552: Fix @type of pca9552 property led<N>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 milesg@linux.ibm.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20261104064552.959862-1-armbru@redhat.com>
 <20261104064552.959862-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104064552.959862-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb1336 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=C2CdMa-K5c7WqT7anM4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: rvH3qeyv4GdZrVjGFXfmpNC6Je8erWyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfXxJIEeycj46VT
 2PUzlxg60m+yyVVvap/lEch4szm7MMtEApUu080uOhHlkgpMl8ZCPJJcO3U5tZ0vxvXAB5Jjty6
 6TcAzUL3SxjwBcoCqGaya3rmd6ixsMNtgp4i1vZi0xMZcNntyfYq3kyXrj6mNyXbcy31IXcjnW5
 a+fkPtgcjceGiE/9JSsMsVOxAzjuvkBtSaq9W1eY8wJ/056jO3e2MnZ3WPRV/NBUb42aR4JwX8D
 MazeVFbjLTAIvNInNphXHjjUXxdx8ZoC04cvki2qvsazPl53hwnDTD1bB4jfbO9JQN6opib9JRm
 Y7evAcNjVq6Ia8jEZKdmOt7wrUOodlVK54+YgfdcOwQkbkMfvxUe34zy9i605gC5jUCT9o1s5pn
 0oNOvUTdp8g9mvgWFJU0A3VHFNf7MHPazp7C27oDeHFsc5ovtuFhypkagh61QLQRo7ySQJ9l7P1
 7DRCEyzL+EXw2JeLXqg==
X-Proofpoint-GUID: rvH3qeyv4GdZrVjGFXfmpNC6Je8erWyx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NCBTYWx0ZWRfX/rnQ/qsd4eVG
 XybAxKKpApmEHbB0ogiy6aT5RCPhAQiyF3uB326sufvcW4KnybqHjAVOODqzoX7e/bLt5LdIA84
 vdKU8hxy5JmMXLnHm44BWNJq/LIkGX8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_03,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040044
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

On 4/11/26 07:45, Markus Armbruster wrote:
> pca955x_initfn() passes @type "bool" to object_property_add().  The
> properties are actually string-typed: pca955x_get_led() and
> pca955x_set_led() use visit_type_str().  Pass "str" instead.
> 
> Fixes: a90d8f84674d ("misc/pca9552: Add qom set and get")
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/gpio/pca9552.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

