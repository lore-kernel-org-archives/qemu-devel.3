Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22844606A33F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XtrCFA+7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FxyRL7bM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3mU-0004kQ-Bd; Mon, 16 Nov 2026 15:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3mR-0004gq-De
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:58:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3mP-0001JA-V0
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:58:23 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfGCS2134905
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /JLZW/9RRmyEJ2q2eqDnLwmWCgdu25Tuqc9Hs2Ryev0=; b=XtrCFA+7z2e9dPWs
 HHBKioslZvmeBP61phDLQx5KAuULm9p82frmh4Q3VCh+bW+6i8nGR53Ldp6h5Mb+
 aMJX1G5NNex5N9gpAQu8AQ/fAr2oD9ynCFVtxp/L+soyz7dpMjV5LZyN2j7v/5zh
 SOGnxBfNqxY6F1GE27uWbOnxg4ApbxVQKTyThTEwsdvJ15n5lGi+UluWkeYYyNNY
 3qHPP1C8/X+TKQ+bsO6R8TYocY5MuS5JgVmdTg8cJf7M/HjdqQy06q3Bomio2SZ6
 Y/ztEl3xOE2b0Nk/fSRmX293nyUMX2maN5ulCYkt+XkCQ3HuYdCBmuV6aCXzy1MK
 Zid1+A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jfnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:58:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1b3ae327c55so163873c88.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862700; x=1795467500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/JLZW/9RRmyEJ2q2eqDnLwmWCgdu25Tuqc9Hs2Ryev0=;
 b=FxyRL7bMG0xmmNpj1puIHF6shHRICErX9ItrUAitnXbJNhNf0YEdFoTKCS8SAiBc90
 mcws5rjx4j8iJ/ikg7GYWgPLUcOBNc7B3m78Yepf1V1ZmIj14ucNIbQMNFrBVK7exQJb
 cqQ6Gk2OTOwScXYNTUAFWdu5DBIKHhF2cGgMNdY79PgvSdp9kGG3uw+qTRRjTVBqZ77N
 s/PWOa9adYvBM8Ny0krK16MZs5LgWYLliQXFjx7dZfD/PvXU1jIsLVcxXJKYVwyno74o
 APkWSrgJfYmMp+uJRjzZmGQHiIe6iymtiAp+zj2I6Aj0H77/xNOx40oJwwF36je3CYvQ
 p/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862700; x=1795467500;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/JLZW/9RRmyEJ2q2eqDnLwmWCgdu25Tuqc9Hs2Ryev0=;
 b=b2k2t6FuLXAfAvwnwfYYz7e4oCBkdVNwEKRalKZLBdPA/uS2ZURYIWMOrjpc/C4qTf
 wfTWdA6Z/NBNeaMVLqbgPoiuxdt15HTZsVsAclTIl3l5tFX5RH300cXwkX3e55JfblJB
 JwCt/6z0VkGXRnf3YAk1eQs2T+ze9er3BRGlnzWADldJ/tcrU/gTejHEenYHfxoR+ken
 VR1lzwtWyYXQ4vtV0YWGE+p6dmYtcK5mPXPQs3RQPc/yJZJxSFsF9OfD2hHKXyZ1BCt1
 zOGmLtpe7dtsuxCSUQduQhRMVNQ6mc1GyewQTsR/0KTU9a6zBn/dcq55V1xu3X7e3kZz
 UsPg==
X-Forwarded-Encrypted: i=1;
 AL+hErFyOthsIPOHRnJmIu8D7m/ciO3ixhpBnuq26Gg9+f8Un1ofXHqy+PlRCUuvuby6Ldn4nKGyluQW1j/B@nongnu.org
X-Gm-Message-State: APuU4Z9Qnly3DeVh1vmGOsGvFUJpZSimINg0SYaipUGHF/uMm7bYtpnw
 smp79a6wMAi5hIvcyZA/DWoodZj6RJMvviyRUGo4IOlkQp2I1xdrGFJGcVrsUAV2td/cie12YRR
 PB0AUsQjlNVd6xEXGjeWPbp+EauHdfKAUG9+3xOsRHnjv9qKKfhmTSIwKMph4HwQLIQ==
X-Gm-Gg: AYBFou3evM2UfRTDaobkAF/c41WPQF0V3Po+FOIr2WMs+Ol7+EaFdhbnHuxkjek3G8d
 mWVmsFw0w+29jFpktzgz5WQCiwfBvP2nWyCgvFT97fxSisY0/UmicOqBmVVLWb56ZxQXjU59K0B
 Sy+2RH4MUdRTY6IVuZoiRJCM77/sPAmWU9lMc2HAHztLchGcoaQYCxG8wYYfXYSVQn7jBmzm07u
 B4IWsN0lAcqYuzqwiwDZNcVo+PI/xt+ekRrFQflYuY/Zl94Duq2kfm850kMIjpPUPckjgYmrFvK
 8a6iIyNGvzO/aXuYUWz3qPT8KMfQ7Eo4UxKLfiP3rwKmAhOQQpunfNXqn2ubEO+7MQV19Vjso6X
 poJmH1P47TE4caZi99liB4QQB2DmgM9xTTbSNOi+FL/vssZOsaQfI2RGrpTz2aL91cY98sJVU1V
 YsIimC9j/NqaUyiUUf6GBHx0MKnN75qfaIey1R9enekR8=
X-Received: by 2002:a05:701a:c9c1:20b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1b53a2e801emr485964c88.0.1794862699617; 
 Mon, 16 Nov 2026 12:58:19 -0800 (PST)
X-Received: by 2002:a05:701a:c9c1:20b0:182:d0a8:d1a9 with SMTP id
 a92af1059eb24-1b53a2e801emr485943c88.0.1794862699028; 
 Mon, 16 Nov 2026 12:58:19 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50309b2b5sm29919640c88.1.2026.11.16.12.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:58:18 -0800 (PST)
Message-ID: <a0260fe2-47d0-4f0d-b896-aec621cf2312@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:58:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/48] qapi: deprecate 'alias' field in MachineInfo
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-12-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CfNrhbJstlCwS6BgbiJM51K5eQGeEzXj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MyBTYWx0ZWRfX4y7OBs5XCHv4
 4fT/HiaHBDhyWFjz7vAozOGRpN6gwv+xH9Oy1Qq72PVfkKmyp1u1tT0tdRcsh8Q8V3JrHsbIREz
 QJeLhqxFXKuRPE3t2LYwqz4ooI6GW00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MyBTYWx0ZWRfX8uy/SJbVkfUl
 En15VpGeM4rk2h5Iz05E62ywv/mUIsT8kIZDKhdciIGDMapHY1JEy2Y/Hh3i0HSxx+oPKnexmqa
 zPNooSUs8C54Icint74z+sUaobBEFgqLk6dBatY3pn0l+AZ9kobeB3WmLQ6EQErLIRdqB5DzRrZ
 dE/jpbl5ecds9CjC3aossaIYmes4koAkSpxK26ivcpxsIEqpCZRRWnRKFURv87oP9Enwd0Ajdk1
 e9u0Xb539f6/oUKAihEeABcS87rmuPNiqSZcUNkYndYzxeAAI+QjtB5xE6tA7AZk1R4GZhUt2c3
 8Oj8WE2UaY99s390LSqLCIdIHWs/+V523G43rBn4ZJPT1URZLnhbpPA4g8mGIaAgOUue95FH02s
 oDSPNEwJKguJFE33aRRjsLnT7EApW/ciWlTGND5Q1yBBx+WGV5+K+8Z8K+D4jEby9IfjCAEp9ku
 MmPUbrlipHkHcO4J+mw==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb6e6c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=amYLWC-5k7lANlJDjuMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: CfNrhbJstlCwS6BgbiJM51K5eQGeEzXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160083
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
> It is replaced by the new 'aliases' field.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  qapi/machine.json         | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

