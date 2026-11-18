Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793D606A758
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=etvm/JXq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J9+qp2v7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTjQj-0006bf-Ut; Wed, 18 Nov 2026 12:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTjQi-0006bW-Cf
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:26:44 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTjQg-0001dm-KW
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 12:26:43 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGBT03967657
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eudAYp3K4zw/qcyBhXdZNR66pjGQPZ/1zGAtdb1Y4TE=; b=etvm/JXqzPxk7TAk
 JAH2MK4EzrdOmbJ8U9/u4WSdGakPz3m4wZBoemOjN65DvXVCYrbzeL7gXtffl8k3
 6OnDvLAx0cVw4wyIjOdkMpWmGLIGLtX4JzD6eKquHV+E7lrksBFsjKFCr80A4bfJ
 6XGt8cqceiuZbQHpSYdr4ngPxjzdk+UZAxMY7V4tOxcw4+2eYxkvDzh4agNIpGT/
 2lm8avFIIZ2vdHNRuy++N4Pus2/gWXJ5oj74Eazgq+4qhPFscjHAM0hoVssfQnC6
 80rUGLSYElIczYkW4T916JpvFLNRp/TShgNPkf8/JzuGDOQRtXC7k1WjIR7WcHby
 EIeTZw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fgg09wh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 17:26:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so3725454c88.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795022798; x=1795627598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eudAYp3K4zw/qcyBhXdZNR66pjGQPZ/1zGAtdb1Y4TE=;
 b=J9+qp2v7dnJA+vxOCfHaVlvyd3HrfrZ0uAOui+0XIKUi07j/kUL8fGD2DF9iXhyi1B
 gQTvpuo/QGkO99XVf/FQm93rYGUm9yyqFk13rYH1nZ6vPFZhFiBKBfr2khEUq6nAbOWT
 ZGYn9GDYP9jAhenhqaVndXRfRDiaeWaJpmFN+A77M1mZ3WFPWl3dwmx0b3huZoHmSQOi
 +bcH7Ki3rEmjm4cZN56gkAWQ/iC9b7MbTK0Pm/5LR0Hpn+7j4WzKbyeruP8oJFGfteJx
 JjA82hkXh34p7ffbgukNO0rLDlf1jKY+IEnZnWrNg/64/b1oNZ/enG8tB0TmL5mH6QQE
 IfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022798; x=1795627598;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eudAYp3K4zw/qcyBhXdZNR66pjGQPZ/1zGAtdb1Y4TE=;
 b=1iO0oKeNj4+gdjwz1iNZtmIuhPx54mrZ/nGohRIclgyqjhutxkSfl8phn+gKqShmXw
 nOHQ7gPzWjYWYE7X2Q8OBgLZ5FEQFBU9aSYTIZhz3iIR/9zVl0imVmGDafkcUt+0rG29
 anKs/lL+t+z/WzN6+21Goi3etVJ2W0+M7m06k9J9cxAN6y0fYzJNaVeVqMBHT/lR8I4m
 r9k5b7etSRjuRIu8IX3tZ3jkhW+RIx+eKI3NW1D6EUcvWfOk5RpqAV5u3FdvVQcLkx9U
 j1goEciWrRfxsVBKqOOY+6WexEg/K3Bx0XI9kDMwhlR4YwfIxrYEraf86a7XuPJHmiYf
 TYeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGN+vPF2Z1203pB5ciWdFj/GVe3bcEwRX9f11Wg48j+44l12eoA6j0/aLTpv0RUEPGVmagnwZmdR2Q9@nongnu.org
X-Gm-Message-State: APuU4Z85n0doe6bWGz3D5XbhJQFieLofZNO2FbTCO1bX8QFeeLm6aktJ
 HKGDzcOQVaAHCzkdBT4bbYx57adZuPYA+T14OYMAC7eZQ0DjWuO+0qM4B4PkXDAwAOAjQs+y/5h
 NE2PY+g05I8uRkaRGopuDYtVYx/+l4orvCvA8Lq0PL7nXsebjelbPrp2J/Q==
X-Gm-Gg: AYBFou0uMUTvE+lIogO9WrGvc2ARSyF6iA+Np28W8nvRBF9VVJerAeYTuqMre4wEgLj
 ompBwNTCVimaBH2hWk+CYSqhHcroGnBBHnaFMSWrjscKbV3TS5mbVXQHFYH7hRyrSIxU97x0Ioc
 y1cac7+rBzGLifi5TiTbCXsRu3ihVrq5Dfx8I3oXb4nMrXad3P1jvQ1yL1gpOE9Li+38LI1mMry
 147xKKtyJt2h/7I3ybZ2ANKOpIuee+liykzbf/k5vfiDLByat/BVgNj4OJY9T81wkfnCkpbjswM
 6QtREI2IGN5fD6YeXlZrYmDM9xtY0sUt4EEAjdYV0gGn/dqHQ80v3SuZG4tR+IJo4ly/kiMxSkv
 X5o8GJW94yO/F0xxtsvE0ku4QhME03nMzMU1dQCAc3RhoaQHrEgYedCivlWXgEZsGDsYaj1ssHn
 qAtWNVsHXErJ1xrh/C9uYFM+qYzQ+yOoSFnN2oGpkctmU=
X-Received: by 2002:a05:7022:5f19:b0:1b3:af3a:e784 with SMTP id
 a92af1059eb24-1b543c32e38mr2815155c88.32.1795022797681; 
 Wed, 18 Nov 2026 09:26:37 -0800 (PST)
X-Received: by 2002:a05:7022:5f19:b0:1b3:af3a:e784 with SMTP id
 a92af1059eb24-1b543c32e38mr2815129c88.32.1795022797055; 
 Wed, 18 Nov 2026 09:26:37 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447f4e19sm11258552c88.13.2026.11.18.09.26.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 09:26:36 -0800 (PST)
Message-ID: <123e38cb-7839-47c1-893d-5b505a199b58@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 09:26:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] roms: record the H2 commit in a file
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20261118171410.3753915-1-brian.cain@oss.qualcomm.com>
 <20261118171410.3753915-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261118171410.3753915-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3KH6mYtjxLzzyYxzm7KeUlOewZ58ZfrW
X-Proofpoint-ORIG-GUID: 3KH6mYtjxLzzyYxzm7KeUlOewZ58ZfrW
X-Authority-Analysis: v=2.4 cv=fOSsTpae c=1 sm=1 tr=0 ts=6afddfce cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=FBupLFHXFuiYXz7gH4sA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2OSBTYWx0ZWRfXyd+Mp7nQvwXZ
 aGNvHO21cP2kmJYETia/Ti+gb6tBf8SrIF/DK1Ry36Pqgz+C2cI1E8RMDFJArtjw22Gwob24NaW
 ldetxLJerFUuEQJ0zGmH8Xm+Tj6jloI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2OSBTYWx0ZWRfX/XcNRwhH/bxt
 i4jNiM11FZB2D2uaTWVur+QD1XZLKVbxZT5VL7kuWkT0dDfB2KPRgYP0Xj7nUisDgqD0Lo6s+wa
 3uB4q8RLF+mBIy0IcAhq88lIEi7Tt8VO7g7PSamaCBbfVF4Iqm7iZIrH+LD7PuBc64BPZn3hleL
 R5SEEzah/ZDpiYrwqC6F4YyD21zIkztd+fhspdYRNj5OVBSRyhCtbueHee0JwGqnZKUCNbN66Hf
 cm9HUnsbKht0ozJn8WY/M46XLYTzKKatYwk2KsWym8zQPxBsFuV7H5jKrsqemdpsTfIxLRFHiEy
 7sPv/TsiR3vRUjq/3SL+B7C080vgEYoLAJzc05tLtliiw98WdAQPKRa4w/+d50ZoQsn841Cu92P
 05DYNNyI2Og6Z1VEWNo/1e/pYvJY7hbGU7DvbPNCrRLpjm/ZpHdXVVgBssoA68BOpwebueInDSj
 7diUEbptym+qIET5JBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180069
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

On 11/18/2026 9:14 AM, Brian Cain wrote:
> The H2 build ID was derived by running `git rev-parse`, which fails when
> building from a source tarball.  Leaving H2K_GIT_COMMIT as "0x" does
> not compile.
> 
> Instead, keep the commit in a tracked file and always build from it.
> When the submodule is checked out, fail the H2 build if its HEAD does
> not match the recorded commit, so a submodule update without a matching
> update of the file is caught.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                     |  1 +
>  roms/Makefile                   | 22 ++++++++++++++++++----
>  roms/hexagon-hypervisor-version |  1 +
>  3 files changed, 20 insertions(+), 4 deletions(-)
>  create mode 100644 roms/hexagon-hypervisor-version
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

