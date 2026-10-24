Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787A606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WICatm6K;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HyBalwoD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKgLF-0000vH-It; Sat, 24 Oct 2026 14:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKgL9-0000ur-Qx
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 14:19:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKgL8-0003LR-1g
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 14:19:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF1Ebt2374901
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 18:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jOINoLL/ibTykkS1KkDtHnksre8fj1LhbOqNrFvpJZk=; b=WICatm6KYMy+0MR4
 3zeFqK2Q9JPAq7sz1PvsWWO6K/orisy7QuQqWIhP+Sq/96RBF0n1RJH8eqagARAK
 1TFYHgH35zd9Kt1nxpwjptHyj/f0BBspbQlSPve3Nn5WWtQFsJ6+q6p7N3kLOTVc
 seWJJ6q1Z2wxOgrpEheaHLKCQsg/m4N/cCLamrLsRIR0znKPELlUvyEkVxmD9ZoW
 Ls0WZggmyJV8QZFDpzEjBiVYqfLez2AZCHqFMQwna5ZTXOxRY4HJ7D/3Qgcb3cbP
 7ytdh2L3g6hNiMqeWMPK2MNqDARMdBJPyvWCkIltanMY/lhQxAmCQVSvMu/oIx+j
 GlDtbg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hnkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 18:19:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2eaae62796dso1913545ad.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792865970; x=1793470770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jOINoLL/ibTykkS1KkDtHnksre8fj1LhbOqNrFvpJZk=;
 b=HyBalwoDlaZ5iVp8c9og8ui0FIxbn9FviOaqaw57v+p6pynu9XHIa6OzcuSH+XzYBs
 ORtSXKhxdW/lfGmVZEMmACMWIFka5SNz7GXpg9zLPinojFCjklyHWTrE9ZEqa5IXVT6/
 BXDUcP+Mc41wqEIl8r93N0xu+EmlybxKuIWhtFeShC6X4hc8fWKHpdR9IKRToHm3I5jP
 7ZHEidmvLofMapuqdGo1SgRK0Y4BLl47SRO3muH8MwgHSmxIwdGb8USQm8YsxxYD+ak7
 WsJOCFPTixWvyy4N6k0i26Thi26djQcscU4Yflx31NGhFD439HPOf/x3J3UqFlz6W/EO
 ZGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792865970; x=1793470770;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jOINoLL/ibTykkS1KkDtHnksre8fj1LhbOqNrFvpJZk=;
 b=WdNzYT1g881eyJmv5s2Gvpi+prY+5y4Sp4W97d3PbjxU3eSQhf9qx3+0N9AvsZWCDQ
 w7Egj57xJKyjvhFSLaPRdgM7A3zVARDPXY+TtjCjM9mWsYB1xs17opgfkTJrZw7ZOtre
 gHYeaU+S2jsGRRur+20pEqfQMBb0rZE7zQept9Pds7HgyZ1ksD6y1UyHJ3c3cIcvoXN+
 OyiPj02JvPoaI0uy6ZJegHFtiLggz1uNkWh+Dyw6tvffeDrqr2X4ITbv+8JBPiNOoUAh
 2Iiks+mDHtCs79XSLkV4jzz8I43nRwqKQfVABbKSrXv+7MwwQ3eD84MBVRw5lcGPLBLX
 w2RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz95Jq8pLZs69p+DQnu4iJmLw64y7rGslIc83UlqM7OTJsDwPLnoSHWWVaQnF8XfbmTcW3n5B7utXK+@nongnu.org
X-Gm-Message-State: AFq9FYJeaYolAJpDfiPcclwTuGn/axhk+LltZS+CR8G6lpI3DGyMqOX2
 SVh/tulLzWaJLX0OPcGb7sKFeAg/vpV5AQAb2xk2sqR7HHLsNBZjIMMJ88CY36rHXaK5qkmJWoD
 6ojF6h/X9bAG5MRN1avg29zScB8dP//5If1Ev20Gg9sWILa9k8vIbH6UbeA==
X-Gm-Gg: AYBFou0DxFsBH8LlflRvK2FNuMaVF4FKtg3jcRLKNMHaYahxd/aDcmam3VRDklnr+ZK
 aYEo15QpeZBQ+tZ6gl5mdv92z1xy1CgDbz/By+t8wx5tAe4E7d8bpEYHrUyD6hKbo1+5roNrVe0
 VPz6gGORdtORpchigYpU6urMCW0QxSvUJQWW6JJcMITwJsaVvwHX1GDzcwWqAOH2SPGCivXc5Ig
 N6QDkA1cFp75iA0ByGmIwbvLwvpyCw8oomQ47a/he6U0pY9Kuh0tZXD1i95+zc6UAXJEk5sUZOn
 Tc05nHcwgcp0TbuTQ56zKt2iuQJ2SSlZ0rWlAGddyGDBWo1PTWBXf12tjhuBqpQ8hsvgTHoohY0
 hRmA1qynqH985GqfBzdGlmnNjiFE7xwyiO4EhaR9KrHN0prJRI2mO5R4d
X-Received: by 2002:a17:902:d4c1:b0:2e9:5eee:e074 with SMTP id
 d9443c01a7336-2ea9c69b1fdmr20831785ad.46.1792865970406; 
 Sat, 24 Oct 2026 11:19:30 -0700 (PDT)
X-Received: by 2002:a17:902:d4c1:b0:2e9:5eee:e074 with SMTP id
 d9443c01a7336-2ea9c69b1fdmr20831645ad.46.1792865969846; 
 Sat, 24 Oct 2026 11:19:29 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1982d2sm6368845ad.41.2026.10.24.11.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 11:19:29 -0700 (PDT)
Message-ID: <e36303f5-d59e-4936-a167-da7fb6e9421a@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 11:19:29 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: add H2 firmware support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261024180657.2036255-1-brian.cain@oss.qualcomm.com>
 <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261024180657.2036255-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iJlGZsod36bm1PWh5PzjXmCkVzmqGGq-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MiBTYWx0ZWRfX+s2scQyGs+Le
 pXe9bz/F4Bg0J9jzOALydc9J5VRtu1bXnHKqzqdiDTFv0yZ9snFaORaNhEzM2vVp6t+iRdDCvlF
 NPJavy6T9IUyaGmCaxnLmVioANFYpTk=
X-Proofpoint-GUID: iJlGZsod36bm1PWh5PzjXmCkVzmqGGq-
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adcf6b3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=xDyOQ7S2AAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=3OmuNrAOVnsAa3Dnll4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=xG0zjm5BtbRCg84i2bc1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MiBTYWx0ZWRfX/IhMa+O911JG
 wzTYXTk9JMnxlnrC88RGrTj4u4acyEOsypoajeVBkU8fzJ5NGX4fEcMPhOHicq3FDrMajQ6Mmoy
 7x4tQe1iKLQi7lPNvilFlG79Z49XCQ1JE8AgtsbS+YNvH9iQOsfUCwNa8lC1bU1LXe0xOWT/1ok
 vDdJJQq10J0S80U/7eXVEjqB2uMB2qF+qxO5gRgf9K0+YPvP6zvXvhKH8c6DGhxOHx+5sMyFq1G
 6hly1FTrrA/gPyua+uQJygJg6mTBytZfUQCCCn/+ksHehxehkhjhcSHYDoyCDO6ZiI7O8EwHkVN
 gR5/BUhVC+SmeI/bizLlrVsHgei1WskNEBL8YsXXhVNQr9tE+l+r7VUP3+zhHP3b0yeXQL5ZZ8M
 OhY1DOK6tQapjE0vJSyJ2fMBTH9A3+UFgVjsIAPOvXMZpaoYSwo3fwp6eoXAF1vokRMcSJhQucn
 k9mVosj+PFAZoOztE6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 11:06 AM, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                            |  2 +
>   docs/system/hexagon/cdsp.rst           | 48 +++++++++++++++
>   .gitignore                             |  1 +
>   .gitmodules                            |  3 +
>   pc-bios/README                         |  7 +++
>   pc-bios/hexagon-hypervisor-license.txt | 26 ++++++++
>   pc-bios/meson.build                    | 11 ++++
>   roms/Makefile                          | 83 ++++++++++++++++++++++++++
>   roms/hexagon-hypervisor                |  1 +
>   9 files changed, 182 insertions(+)
>   create mode 100644 pc-bios/hexagon-hypervisor-license.txt
>   create mode 160000 roms/hexagon-hypervisor
> 

[...]

> diff --git a/pc-bios/README b/pc-bios/README
> index 2f8a565245f..661feddf3ac 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -1,6 +1,13 @@
>   - SeaBIOS (bios.bin) is the successor of pc bios.
>     See http://www.seabios.org/ for more information.
>   
> +- hexagon_booter_<machine> and hexagon_loadlinux_<machine> are the H2
> +  hypervisor firmware for the Hexagon machines. The sources are at
> +  https://gitlab.com/qemu-project/hexagon-hypervisor, built from commit
> +  23d5bde4313c1e63ba64dd5d7f542b1055188ef8 with Hexagon SDK 6.7.0.0
> +  via "make -C roms hexagon-<machine>".  H2 is distributed under the terms
> +  given in "hexagon-hypervisor-license.txt".
> +

Submodule already holds the SHA-1 tracked, so no need to repeat that in 
README. Also, at some point in future, 100% probability this will not be 
updated and become wrong information.

[...]

> diff --git a/roms/hexagon-hypervisor b/roms/hexagon-hypervisor
> new file mode 160000
> index 00000000000..23d5bde4313
> --- /dev/null
> +++ b/roms/hexagon-hypervisor
> @@ -0,0 +1 @@
> +Subproject commit 23d5bde4313c1e63ba64dd5d7f542b1055188ef8

For the rest of the series (this patch and second one),
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

