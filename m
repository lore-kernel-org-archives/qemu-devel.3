Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661B4FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 23:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOnv-0003oC-4f; Tue, 05 May 2026 19:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOns-0003nl-NQ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:03:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOnr-00014M-0k
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:03:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645KbClY3501560
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 23:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /0/3zS+Fxd2Kl6F4wAjpuhU7hjIKVkRCTX0IXVOpZs0=; b=XsOeFvMiXEPjn2Uk
 FuSskMqUJT+fIKML0DI8ty863iJyvN1lURdqwVwqLMczwrv3aCpfMCVG4QtecDsB
 fFGhYKquWXG3gIoj3yUWf6i7kaqBQjo2xEJFzfhlf+FaANqpqqoQsG8s5njtIWuG
 S5E1gQdRN18e+d+TbTTm41sVBV7hCPSSuGKY3obGVKYVno4k0Y0Ngq4JICF8aE0I
 B80xnoDtouSe8Sp4dCQk1ZJTK2GFUowectiwsBuODSWipxapdGXcJ7PFpJl3XYYY
 YiFOYzlDb3x7TE0UnOCd6tzCyIHSzKu9DmkQ8mPexJH94XfNHsAOzi4XmM39oqQr
 1Ch/og==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqfa3sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 23:03:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f525565b33so739850eec.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778022223; x=1778627023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/0/3zS+Fxd2Kl6F4wAjpuhU7hjIKVkRCTX0IXVOpZs0=;
 b=LrSsz02Ge0LBzXkVL3qxRCVdkPwXvZxs66MP3hHlq9I1wl3KTtsbxqphxH8S6FbA0W
 JjGuAbki5HScdK9VFo4sBplnZEdysUxdA1+TMEjzXXYl2rEBGw/+Al1nC1Mv7r9Ulx7n
 4VU7s2G55vO/SO2/e+gcJ/kP6IsUGc1dQ3xSPD5GwLpAoFsVW2Ext02pW0p0lLVDB7y3
 1Ki97+QXx/gqGLrCo4D32Y2avYeL7a0GLNoOIUG48Dh1bQxIGqB40uz1jOHdhPaouCfs
 KphfXDSi7y0pzsct38Yy42iEEa94rsBOOgxqdzuxNEI7Ko1Ed4bh/qvnZMspsn2UDLVm
 GFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778022223; x=1778627023;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/0/3zS+Fxd2Kl6F4wAjpuhU7hjIKVkRCTX0IXVOpZs0=;
 b=soavH1wB05UWqc8Xpm3ZZ5qg5aiIvY7IU9RyTd+CVdzzHpHq2UzQIfbNleKrh8flcn
 0lqQAb/eUTwya5RrjYzjk9jufIBq2m/GlXtNwKiNDcOzNXpWzfS57hN/cRI7RYteIsfj
 pvgqt+bZG1RlVdBo6cFLOBVhstEoF0OSzezVTvLIzApRUsAIRtvMyfo0unNoqy3ADmSJ
 Z8J3BTjMgmQptpiG8sCDsIPUBVij5j9+ErWipqFrC+ndXzV1I4qDZd20Uzsn0Rs/YoHW
 fr1iSkv2g6P9806RX5H7fSUMR94fThHL8O265xyaao6nBWRwA5aqwX+ic4yCQGq/2Mh7
 H+9A==
X-Gm-Message-State: AOJu0YxIkdPPXhLLk9uH+IiX8VKz959+dtNuWGaidvp4xsKAIK4ZyDKb
 NCFo5BdQ41lR3AWXMfGvVS+6pHn0ZqQVHd4ioogq6jU7CHF/2OiwqUGXoCFuFUqkW2NSBNHHgj0
 jHImdXbsxxDAguSSERXtMtbXkDEyHUtGc0GyzEDGKDrqMOl3cSHa6g5UWrobQNJsM/Qs8
X-Gm-Gg: AeBDievKxpfj41bCkJXQ1topUf3a8Gw1L+U4KAFY6iry/uqcrg94kg0FrqfJJdcui2z
 jKk7A1liEAig7V76I7wLCqoAtwHOyqXgwjoyk8T3TCHz/pVU3tatkpvdLnNx2EBh06ZMd5w2f/w
 mmNDk3MN9DTbiGqWHMZa5b1UYYMicxvuPkAXtDBs+JLBBZdnfWPl0h/QdfeYujY6r18oxRFZBxZ
 +vRGMVOXKgi3o8gwAIirCcGRfT4BSntjb90rZkLFxjmxxeODlXTMxagYPbo32C3cHE15xx1Jw9Q
 pam/uQbwKUCQhW/SeSkOTlJblqGDpL2QSojpFQAUQGgo2Ny341WyC7eHXuEw++cQ8Ixoy7izqyB
 XOQyNpNp48Dqub04LFONud5mKnyBMfLs9yESbVIrn4PM81IhyWiigaZhli0cxHCurXYqUWdC+Sc
 1yxMBq0+hvp5aitknBEgBucsJK
X-Received: by 2002:a05:7300:7c17:b0:2de:2f38:a7cb with SMTP id
 5a478bee46e88-2f54f94487emr664029eec.18.1778022223366; 
 Tue, 05 May 2026 16:03:43 -0700 (PDT)
X-Received: by 2002:a05:7300:7c17:b0:2de:2f38:a7cb with SMTP id
 5a478bee46e88-2f54f94487emr664005eec.18.1778022222739; 
 Tue, 05 May 2026 16:03:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56f88f4a4sm789689eec.17.2026.05.05.16.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 16:03:42 -0700 (PDT)
Message-ID: <725778de-aac2-4251-9d4a-c3dc7926c8bf@oss.qualcomm.com>
Date: Tue, 5 May 2026 16:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/codebase: add link to rev.ng video series
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyNCBTYWx0ZWRfXzH44w11V6JlN
 F5JyEx16Byqv1rEIMqAGFGA7/Yuox2azCx6MvBqVCtxux0XPzQ15YH/veWuVjsw2XRwmtTTeGvV
 aBvjzCA7wahVylo4CZybscfVFcIE0UF0AQuzf+qFXxPo/mhlICrA4zvFQGUO5wQiYjd9y8jK28a
 bfov6k7VIidkepnV40vufR7nmXEsVg9oVLUjSdYAhhAdfupnXlovYghllPFpS9M22wfJViQIGru
 vkRLVKXCH2rGWuHaaksRVUhW9QKP9YMERYiGHM3llI6/fwcy67EqMVxbb8BUwqlnjhu3myAwbFi
 JA9ae10EP7BjY2dtmZJVJFrm2bMtJ+GsqSGMddvF7hlBtNwdWTGq6MCqhyQU5VmHTshzd3YmflJ
 eT6DijPiwy2Xa1Pv6fTKJd2Cbi6yfIWQDiLHM3RUp7u4+tGbPIQjECgUbrXEjHY5Pujl8VkPmnN
 OuImhNNq23inW0EDutg==
X-Proofpoint-ORIG-GUID: f2I9DxbFQfXGIuhKLIekLD4STbY7DJWf
X-Proofpoint-GUID: f2I9DxbFQfXGIuhKLIekLD4STbY7DJWf
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa7750 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=RGGxYAQrNkoKQqCTtcUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050224
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/23/2026 2:35 PM, Pierrick Bouvier wrote:
> Those two videos provide an excellent introduction for a new QEMU
> developer, and such resources are rare.
> 
> Kudos to Anton Johansson <anjo@rev.ng> for creating this.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  docs/devel/codebase.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

