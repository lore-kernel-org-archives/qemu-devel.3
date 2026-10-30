Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A2606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Eh8xFcWX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=egCL08LN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqji-000203-Gz; Fri, 30 Oct 2026 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqjf-0001vY-Tf
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqje-0007Ra-Bs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERG122495208
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0dmkQRjl9hg0MdglftMlODCJ667etWMgx1pDYyQEtUw=; b=Eh8xFcWXGnwMG2lv
 dNHdla+loYsPX/km0Y/AwKSUuUtDS7P6jze3xFdQPq8/DJPIwhqf7cWB86cQGokd
 O5zqfcgMW6CQNHGQJkUw1cmLqPha5pRVqvKkCJIZAMFv9h3htGkSq7Vt1+oBi1xW
 oIagquk0OtnmjL1mWcIL6qqstljTSerT931xbj5GjEDwz+2V3R6fZWJqCu6NtQj0
 IC95qPUoLda1/iZnR0CkJ8W9fo5DH246w1fy3zLisMMTrE3T1hbX07zNL6VTxZhw
 FPu4sXMLtnIxOeugTfcYQVIS3YPo+ZD9OyjXQZwKyUQWsf0LgvC3cKSTe1wDQr8S
 qXKa1w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4b8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3698bd5392cso852226eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382587; x=1793987387; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0dmkQRjl9hg0MdglftMlODCJ667etWMgx1pDYyQEtUw=;
 b=egCL08LNqmColV7jAsJOOfL6d5OGmUpYoSIJ/zfMI5dFRGHZHllP+yBPuRS1LxgpNY
 mI9mx222oisMt8rFRti34xcuHsxmj0A/Xvfh45qcnk+P31R2uXmdsJUf+11bX2QXhWQ5
 zFSdM2WAYIcnihZ7Wao/LhAvDMHFEQArKxlTSWbByA7/c+mFkvUNOtZlygdgmImoQGt0
 6iQTChUx1v/KwjgV3jdEhlpj7P5wJn8ijhjWfZL/rVp6YYcfSvXhltC5xuS1xX9GNGip
 XACWs0DVFsd8JNDH5EWpPQuokBfp9fDQqKGi/pN3aGnUnOLHXb8G+u2cldHM7U7Agt8o
 qs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382587; x=1793987387;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0dmkQRjl9hg0MdglftMlODCJ667etWMgx1pDYyQEtUw=;
 b=ePSkFKWtd1XawhJzn8UubCEuFbSVA1rbiCsDUpTkGG8dl0A2Li8/eSyhqlMZFsz9cC
 Y0xySYK55QAFMmhGYfsU1cdnWf0RPETilKRyMW0sTEM3uKTMCjuXHc4r7Ctamh9Xs89O
 a8X9dvhbDGsQPLXzmWTNwbGd+nD2M/hM410eBciENlK0vrAaE5/XW7WX9edzlNN6k+qY
 CyO1Rbl9y45h8vvK0vcYYLcZ3dtgMDTnRqGw+YCFELt7qviBYuUgU4opotC0NO0464Vt
 cTRMKIF1tUowpADODdGBGG4HXvEYCdcDXAm416HIF3k2muhzNHGGGbIDp3xjrW7YmwSd
 LR8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBySMWA3A+btFLWGbcOaHfKBbtimJhA2P88O1DAEdte34Urf5xKILUhJN40WKeIxzJIROs/21QWMHrRV@nongnu.org
X-Gm-Message-State: AFq9FYJNcvMBjvxE38DnYtiutjU4focpBlCI50ybLfar9sumatTIuXoC
 qYLGFkRtvNMY3lMEusbOH+TjNwZC5HbHGDSNEkfamXBlgjR45OzCZH5INXjG+wVqhXs+iE1SiSk
 YaysatEiFhfuxOfZMsRa3/HeSZ6hqqvRl5fDtRKZVQxfc3vgfR74sHrzHYA==
X-Gm-Gg: AYBFou0DGLnMYjUTB2B3H3E2JdjlqbjPyQ75kykeM+BvZuJX613TFbTEki6axob/bX7
 IsZ6PWYT/KXtR4T5T6zwrpr2crFSnLlKztf3MsuuZzQh/Qbcv2cbqQrHQTPKmEUPgEsWrhtQn9J
 YD9VofcRN0Lz6tkXgo6mmmKkwRmhusSV+oF06QtsyM146EAxCL5R36u4JGIco9OO1/PMNt81o5f
 FHWEG0O+cV8d21vBidUqu2JWirBRPkAi4aEHEYq5YRDKaHFqH9yeUPMObCDuUjNGI77+O0eXk/v
 tA6Du4twvpjkt44Fsi/9zqrQcdAyr6hrl+KqP80Dtr7+7nxC3BdL7wNScokLARDjg0QYeNL8t+U
 Sz93nzM7dQQwe6FTDoGUy444PgEvU0EF1T+mb4HJdR9tTrBSoOXPAqb4H9SwmLpuU91pybV4bPV
 hQ9/Rb4wvKZ4ORrDvqPbn28SvL7DdhZRjhys+2Iq6nBMs=
X-Received: by 2002:a05:7300:ce81:b0:357:ee3a:267a with SMTP id
 5a478bee46e88-36a422062e0mr4361853eec.2.1793382587333; 
 Fri, 30 Oct 2026 10:49:47 -0700 (PDT)
X-Received: by 2002:a05:7300:ce81:b0:357:ee3a:267a with SMTP id
 5a478bee46e88-36a422062e0mr4361828eec.2.1793382586785; 
 Fri, 30 Oct 2026 10:49:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a5fb97sm10292939eec.23.2026.10.30.10.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:49:46 -0700 (PDT)
Message-ID: <ae973db4-0593-41f4-bfba-c696eec69480@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:49:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/tcg/mips64: Report Octeon test results with
 TAP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261030145218.58385-1-philmd@oss.qualcomm.com>
 <20261030145218.58385-4-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030145218.58385-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX7x/i/DxX3GXe
 UvqjFRPJPtFpDjXCojcP8nPW5RCmn9QpJn6bEHMjWNrnWGNt7GFF0UP6uggpKjYpGrCn7AFwlO1
 04HGliKHKZa4G1Z924JBrb7BT4GooOi2BF9AmC/4npbb8pl58oaeNiZ8SS1jNgu8SAa/4mAspnb
 tGPFix7bFjPwa96eaWPrpBM/IModKeXI1sq6i7j3Kd4imMsgT3FvI50rR3D2CIZ1gzG4XUqOxHx
 UScT52DliPwgBpW6TutLnRjzavZWGYpyBVtJL8gSdaUwDGzU0pilLlDc9hUjc01EOoNe+UHsyHK
 /lCkjfTdCgZaQjKmgwJU5bxsL0ERgABjfra6QbraMcuCzQhcyPwqfGbloMKzGmzHLQSPd9vrRPY
 ZEvDG4v3vrP0IdAkMrMYpHWRLrlpBQpJVY5NiKISgECercBEnuH3NyRzesQym3Ce1q/WUtf6ymv
 QhJ/6Vt0r9FwjzhiyYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX3sZt4sg/bAMw
 icrsn1Sx487d3FxV6jjrlVoEF3aOQDTp9cFRHIwuXA5zlE30iFTVAPPeQhVstPZhCtiM2rf8/ko
 yFuZ89znQt4n5fJfyud/zxkaWc9YiVA=
X-Proofpoint-ORIG-GUID: M2q8D_L1-Mu25OPmhemsul1tAS1MUbHV
X-Proofpoint-GUID: M2q8D_L1-Mu25OPmhemsul1tAS1MUbHV
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d8bc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZHPL0eB4cbTO3u5cAfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
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

On 10/30/2026 6:52 AM, Philippe Mathieu-Daudé wrote:
> Replace assert() by a TAP_CHECK() macro printing one TAP line
> per check, so a failure no longer aborts the remaining ones.
> Select the TAP protocol in the meson setup.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips64/octeon-insns.c | 65 +++++++++++++++++----------------
>  tests/tcg/mips64/meson.build    |  1 +
>  2 files changed, 34 insertions(+), 32 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

