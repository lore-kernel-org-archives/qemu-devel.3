Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FB606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VG6pUW0l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hq6dPNo1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4A5-0007Xw-2p; Mon, 16 Nov 2026 16:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4A2-0007XR-Ug
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:22:46 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4A1-000633-H3
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:22:46 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfaHu3248916
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6z44vGm4K+tBu8uXkMGmNKribIiYtfVIbFb/P3oId4M=; b=VG6pUW0l+89aMWxv
 KUoQ/IIH0f1Ik/KBIXxu46oPVnaQvYXlLTCHLJRC0ktSMFw4J29o650ektGyHLlg
 PsL4WXXRef9Oq4uAOE5SSmmcmo66ZAtYHNIv9h2lPM7SgdfE4bZ2s/VPDuAfvo8n
 WDh2wfCRm0gdLKz7ovxnfrY9Fm2gelVjZFNwEVLt/5sSCeE/H1kYi+1T2kVERSQe
 qjIKAaSNL+uv/qIqUz+krtg7D8mkiP2Pbz+N58IIKsOy27Qxqb3V9IllD3pp8srI
 el5V/l+hYTQVvpMn58y2VLWI44ZJtRQCfNh6E2rJP+PgCEUDh1qXhX9lN0+J/epj
 E+ZBUQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfjcwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:22:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4828092eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864163; x=1795468963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6z44vGm4K+tBu8uXkMGmNKribIiYtfVIbFb/P3oId4M=;
 b=hq6dPNo1eYUCb86MD5iMS1Rt04qJdLUBrTiywIX2ytcp5czYrQff/j02NrioaiKzLn
 g7eJgz0mkw5FiwZf04i5k0YZcqop3n6zZAPNO+39tlZJFNdL8vUPzLuPnH8dfnFihQiY
 S2MoGfnodgEBvhlI0NBhXfCndqok2F8WW/myu9+voaBwVU6msYC951HNAnJ6WE9an1Sg
 EEYxmLhKabEajccLgqyo8jN3DOqk1ecwb884/lxtS/Rg7rZde60/HESEDRFV5d/dtvSs
 mx50UYcDVBVkPsFoJPWiHwDse/GUbK3GnwKEm6AnCbh5pCkZ9V+zGpPYMo+B9fGfo/Uf
 g3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864163; x=1795468963;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6z44vGm4K+tBu8uXkMGmNKribIiYtfVIbFb/P3oId4M=;
 b=uhRgb234Et0BO1Ubjd/jrRac8eXZxrNh8RmaQDj1SkyJ2hjhv2nBcBIAGfStn2wbe0
 IytXmjLaCfwNlOAYdurG6IaUPXEGJg09pQfjplI2tn1aCfAOzMSMRZ+qKJPoRX54m5uG
 zgqhZeVAl6N3PAzQJhhFIVZ3OLdiQF49dkTtdgsznTW55CGyhTfO3duParPgNXYxWBLq
 CzIfXdfULLYZaEXMI9Qp+XWhOtqtLQzZmAj8Per1WdNWWCDOrF6XPsEc5DOhb1P1CdO1
 qGjqC/ykSLwn7or2/SGXHVdI9TAPKiqCKib2mkc00qDuHZUsUEIJhCaPT48RRH6rsRj6
 Dr7g==
X-Forwarded-Encrypted: i=1;
 AL+hErFJ7HAv/HmweRBl3vJ052zGJBMNoVsxoP7YsNoyb09yEEv76steVBg3Szi9vdw8LH06jzqp1qqfpQLO@nongnu.org
X-Gm-Message-State: APuU4Z8UCwPVa3SGLXaeaz191RBoWcoGVm8GGo3z8PCi/+PPxXccGRRB
 BQXSs2So/9pn/FW3ev6jZd74xA4AGoeLnU8uqUxBkgI+Y+D9cmAIX7p8KqCKcFh97KERn7cl+Tm
 i1AKrrw5kQ6ibG8p16rs0QLgYIvMtjO1j3UZoTDUppAL7P63sJcpMvCtEIQ==
X-Gm-Gg: AZFdTZe3QSp84nQL18IgZY8h+ivh0o8I8QmXmxQoJviesNR6vsuV5fVQFal59j1fV8V
 d2dr1lgxgVjLTcAg5QItTn2cVxYZgpmjv14O5U0Nyhkt/lnhTsE9b6zMynw+Z8cbKYAr9jrNFQw
 I6kR61f1EiqZuOOJEztGFG/+RDh5MrVAMw+7AwqDZBRtZIijeKBlqEefUhgDH5fwfTn3jKoBTCe
 ThHGqrLUsMEYhA/NfoTiV41ix7s9omwI7Gjjai0JuqyTkLxh+uHlAbS1D7qEptSkTmiOxaYGEdH
 gKrCV1euCkwMG4udiMW7a9rj+DqYJJMrGrNFlNtj7Ysz7gCKMxL0vDk7eFLCRbr9Rx3lp1QKAJz
 nwo9ghgZGv6Nd/Rt9B4kO6zh9kXLqCSeFaZ7VIekYnl9KDbKaZ3dO8Fxv18j54v/Ufrl723olwj
 0ibleXF64hfX3ByzhBnAWdoMRudO9We1yaF2+qgzqDPO4=
X-Received: by 2002:a05:693c:8105:b0:372:14fb:2573 with SMTP id
 5a478bee46e88-3796676d198mr12097940eec.20.1794864162955; 
 Mon, 16 Nov 2026 13:22:42 -0800 (PST)
X-Received: by 2002:a05:693c:8105:b0:372:14fb:2573 with SMTP id
 5a478bee46e88-3796676d198mr12097921eec.20.1794864162372; 
 Mon, 16 Nov 2026 13:22:42 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm38326687eec.9.2026.11.16.13.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:22:42 -0800 (PST)
Message-ID: <3f5f6c94-5140-4337-a840-927adb2c81e5@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:22:40 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/48] system: put machine aliases in alphbetical order
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-31-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-31-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afb7424 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Bf98UuyWDuK6b6U3mgQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfXyHEbWD27VOe7
 rxN3LlNNaiRtimjHOAk8XKvexdJ92QFzyzM/0Obu0Yn7Tn2LIadXjmKt0jGd71R9rA4buX4gxdS
 DWNfJnHLQOp6y8nnIDn/CtPFTGhH6GU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfX8qCQLZ38jLsH
 nyLZaeU+717Kv1LcqH9bl83L5AW8Zr+l4e9C5eb3BQqBzJC+hpI4isEhwGP0JnrXKVZaZbDvqCc
 Ieurz8d5mT0xPX9+qbCKu3FMb0oFwBuqQhPxHWAel9FsnZAjNWGEQIFSPgrhv1wugMFzMoNBMAN
 pHLytDFs2by0ALyaw/PRxqcA+GO3APwg4nSJi8jPEIBd6+eQouCVsZKQU2NG1WPNPiCi27GN38+
 /YAc9ZJD+hNnes5RMwlxSfbvdDMpoqQCg3K3dTf8vspnBcte+viY2B2OSU58DQlBt/TIuIygQ90
 9oCKUhKoUwAVhzRBcq/0+N92sEa1eGAhieweLDK2OEnoivOHCl82516GsbbxDcGBlVefYb1IQnQ
 N4DRFRdZAd9FWzXsJo89Rrhg9W76aJmQtBG9RPWMVW42V/oExv5BeCyuTUutJmHWjX0WUErm9h+
 h4iO4HSxrt82kz8oJyw==
X-Proofpoint-ORIG-GUID: qlndLa0EYw2H_jw3_ty37MOADdjhmxwx
X-Proofpoint-GUID: qlndLa0EYw2H_jw3_ty37MOADdjhmxwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160085
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> When outputting machines for '-machine help', the machine classes
> are sorted by name, but aliases, are always printed immediately
> before the machine name.
> 
> Mostly the aliases share the same name prefix as the main machine
> so this does not look odd, other than 'q35' appearing in the
> middle of a list of machines with 'pc-q35' prefix.
> 
> With the forthcoming patches to rename the 'virt' machine classes
> to have unique names across all targets, the positioning of aliases
> in the output list looks much odder.
> 
> Change to fully alphabetically sort the '-machine help' output
> so aliases are subject to the sorting alongside machines.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/vl.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

