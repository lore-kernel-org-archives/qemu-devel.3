Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LT+dFcEZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=am6U1qo+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2am-0000eh-Sz; Thu, 22 Oct 2026 19:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2ak-0000eP-9r
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:53:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK2ai-00014C-Mg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:53:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMEmGa1995989
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b277JF0qHmIn5/PAT5/4L8XfFM5w/RydE5HH0Zw887s=; b=LT+dFcEZvDxCMQNt
 rPBTJkjdrosdbFxp30Ep6vBagsrY+wyduU+KB34hIX0PO+gtu6g94fP4wQACglzi
 ogWok2btV3jTvgPbC0sCrx9Ozch8IummGtnQqauEnm9KPgEBf8M9VC/BfWFDjHe1
 o3jckheQbhxr9eIZkULbxIXsNdj7YgeN04sXjywJ1TEwRsHw+GKpMyOpJEMIycAj
 FEO2j9EoCnYeL7VmnipEyWxy4jaqI1GIARsyfnPzbfyLkcJi61cnnHHYcXqo4ErB
 Wj/HWCZk/ag/H10+gUqmjkB8iDv+sp8oNuNqwCz48TKlrRKwRVfoQMdau/tSHlJU
 spQtag==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr920n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:52:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso292094a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792713179; x=1793317979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b277JF0qHmIn5/PAT5/4L8XfFM5w/RydE5HH0Zw887s=;
 b=am6U1qo+M9vv/7jRvB5nJ8ZPzUAQ+uCyFSzRwOTZPN07JnMR+0Y9qgh3Akeg7xIBLC
 B1nyjX9aTFty9RJtFJnwzXrQrhHPuodOImXRM+rjDMF0iI3N0OepGnw7k1DJAr6azo5H
 uY76rwPwATgLWA30M5siB8rj6wLjUR5m5tzlvTnA5lcsuobMTjj8GTI0ekrO1wakvqTU
 3oJwxGYISMhBZSJ8o49Tr4VRAGOe0PdttoSdrD2LNh6kNnXz1zV3qK+O1aYJ7paPoxop
 YGALdfGer/k7tqgtOXbK2DffXrRnLFsKfA641OnSJ5Oeugq6R+XvY3Qc6+eAkKFLp6oT
 zJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713179; x=1793317979;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b277JF0qHmIn5/PAT5/4L8XfFM5w/RydE5HH0Zw887s=;
 b=fh3cdO1DxZt1Ez0zidLb6WVfHTyvyqQbisK+k5mPGTJVyFxC6R/96q+W4q3pWfrmfe
 Hp8u1lQZygH9BpOVNWZSrMIdQYlTxZseWTQLdLY5/XD2TiPnmy/dagXJNYPCwDeEnicF
 ON+5IYhCrg2gQ9OmtIs0inBtF3kMWYQs4j1SBGG1NaOoUImzbd1SWVPsLZvwhZ6ZNr5D
 7Dt2UtNAnLmjGDmRQT0Lh3eL1tbQCDbphenZh4cXSvN1rFyXHA8RUQqEtNROcvuKtCDj
 cGBCOkc4a4jgKc2GOfsEIv35p4PhNSzcD7coE6MpEvim+2sB828wko+tH6Zn29OiPths
 xCDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGyKXcBJEB+zTBLmwiCFqHH/RVS0c4pAtizA6pOlJrL7SmEiPS2P//brVVpcByHl5Y9FzeDPTK1iJG@nongnu.org
X-Gm-Message-State: AFq9FYJeVFxX4WzP0La94DCieQh6l1ocf1S+9weTrCWBt+DkSHlWYRHn
 ONXQIQku8COrxO3LDJoAfV3Ow1ObeTEQLl7diUD5wzrL2ws3BNqmYpQg8UBqpeAVkW7asUAcGMk
 i5GiSmwP0+Q4uHI5c1gG31tc76BPcIHI6cR331HKxYjv5Bl9S++AmCUx3xg==
X-Gm-Gg: AYBFou3KoUPi3vyC1pzwfNz5cCJHTZXaEGTXkvbD+YxraP+GM+kcbgiRbiI7pgLFRgZ
 4NWVrvMUove0qVzCorpC4P+PqIi4QIso0bNedM4DrfDalZ9Z11fmILvW2HlUN7tW9mFiMfSVtLj
 LjdTBhk4TCKMN3B9gQU+2SsMWbolnk7f/eCck9c3sYXuxf+0VjM1EAELrBGDhYLF/13yr/HkdGS
 HeojgeVK8JOpZdJVobDkQYzX+3hX5gjrBDLrhnoTgaCIijn8fDRXYqE4kOhjRE+qoEg5kAOQ0Mz
 gESl8yquFwaXfhrp2ju7g5TXmLu3rzHH76Yw60xIdUH2XELIFo32A4ZbNQD/GLtAyIymhkhB0tx
 DE+tWvWG/92Z9NuDBXvAaB9etFgZeR7gICopYPFyWyGMvdCh4UhSDZEV2JRvMtFCp7V71rg==
X-Received: by 2002:a17:90b:39c5:b0:3a7:a463:54c2 with SMTP id
 98e67ed59e1d1-3adce07f94emr417827a91.35.1792713178692; 
 Thu, 22 Oct 2026 16:52:58 -0700 (PDT)
X-Received: by 2002:a17:90b:39c5:b0:3a7:a463:54c2 with SMTP id
 98e67ed59e1d1-3adce07f94emr417811a91.35.1792713178269; 
 Thu, 22 Oct 2026 16:52:58 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada493261asm6189807a91.12.2026.10.22.16.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 16:52:57 -0700 (PDT)
Message-ID: <2ed3e873-a89c-4657-abab-1af0a901b3df@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:52:57 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] hw/hexagon: convert virt board to hex-board
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
 <20261022230048.2160400-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022230048.2160400-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cSCBcIpLtgzwPESUxpKuc3rTCO-4wthl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfXyIySQcdFAI7s
 llyyWk5g1Ii9VhSqm8Vrsf/r3K/JB552IhnpJUQHmF8wlwBrvfQKPCW4ALXdUWWv9nO+iYVE+Fv
 StL5fheH4hwGI34WsE/WL+60BW76Wcg=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adaa1db cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=qYXX2ZwjeG6IFCmtEZcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5NSBTYWx0ZWRfX50Po2wkR6sRx
 Fh2wq0uztXT4CGP5KsmSfv5hWvIewDT2zTHB/eCoOdNboimaJ0Fotp1GyEtBeHsj3InmbneVPTE
 0Y0mDOIn4Fm+TuucQAIwZFBFble7bVbX7WUWk3+2ahLg7BkNpRzGo4tvBXRxDauNJIc0NY/zRWP
 ajRMIxnnDfhvW+wMH1OvJsvO+tHy+7hIl93p6K9vNfWQgfFoWxYIfL7VT1FuWe7j+oTTAzINxXU
 +0OapJHqBLVHFgpoUTB9ud91JQt+q30NOXDwvQ5lq+Wmql22ExBUCJD1WDDL1WegjbZTsaKBylW
 FvT2z08FCo3Y++XmklzmXES5k9H2JLBS348e43bpg9Xf5pEdbGidYwwfc2LyLM5jgTd6hUT0taN
 NVjWqRbKQsYfbO+4SIVK7WvhgS0tZQdhKf6HfFMGdoi08k81cTiRO98LPoLpC4TOefOhIjNtCYR
 V5oHHt9JpVTCXX8btug==
X-Proofpoint-ORIG-GUID: cSCBcIpLtgzwPESUxpKuc3rTCO-4wthl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220095
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

On 10/22/2026 4:00 PM, Brian Cain wrote:
> Build the virt machine with the hex-board helpers instead of its own
> copies, and drop the machine state that nothing used.  The machine, its
> device tree and its devices are unchanged; virt writes interrupts as the
> bare line number.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/virt.h |   6 -
>  hw/hexagon/virt.c         | 309 ++++----------------------------------
>  2 files changed, 26 insertions(+), 289 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

