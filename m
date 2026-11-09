Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2325606D825
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LObHHCpw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qiz270Me
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHwN-0006Lh-O5; Mon, 09 Nov 2026 00:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHwL-0006LT-V6
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:29:10 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xQHwK-0005zh-4N
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 00:29:09 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A93K24t2745930
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 05:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sXecFnhrW6opvjakJ9x+e+xJ/AApQ3Vdb54DNOHgs4Q=; b=LObHHCpwmM6JW3KO
 VLKcu59Q+OkykemzezxgF6vPKUh7X7Z2OQmwiAsIkvEAUbU611Fe1Evx/SXwpykq
 qOd54jcn2tfO4ImWGd4XB1YWYXzIdxvoRAMRMQB2++6fFX1oVVzZdWLaaQqQsQqh
 4mzSh46wmnaf3/MsUZF6IJqj39i52XXEwdnKa39lkc3uJsG8GBerDx723t7UmIxV
 /3Z19qxRMlJ/RdY9En3L9vBWjIuCyxSSi+fXDqRg0YFSw3Ok+7Zsvwe3bRQXv1JG
 +++bRleokXXH7nhYmmq7t4rWjWNV4hswKTa2kmkBEWQsQec1+Hfn+a1nqVYP8Ljg
 gH3KYg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvrevnra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:29:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso852487eec.0
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 21:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794202145; x=1794806945; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sXecFnhrW6opvjakJ9x+e+xJ/AApQ3Vdb54DNOHgs4Q=;
 b=Qiz270MeA6QBUOM1ZzhSDUvr25OHOCEIeU49qNHBsgziyjvjrQ6sM2CaYfpS3Vm6pu
 2+PtG1r/a+XIx5Zwld7aTjEUzkVDahx5RReDo4HU/z8ezyiEfIDWoUUH1MkM8rWjtMFr
 X/qEJeThlDXtztCy68ure+XOw6Id0NzfP1+F3qmAprZKba/EQr+l8Pr87vmC2qaOOKUX
 xNME7Esq+GIDGh8knN/6i30Q2/U79vSM6Crbq8ehmlsIlKv991QoNORVw3UCV+XYceJT
 GgHxdjmIIvpsOyrcj++CBPZfi7BTLYvrTl1qMpktwbgvKyCa9ZZXRQaIgCbTSDCX4/qb
 0HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794202145; x=1794806945;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sXecFnhrW6opvjakJ9x+e+xJ/AApQ3Vdb54DNOHgs4Q=;
 b=g6KCV7nz0EbL0MoYzWSu7I2hkVOrLMyB65BL6uuRVRHwnaOlX1DVz8e732bFo54ROt
 4sALXgeZoCcJIoGhgaJGYWUlTdbI9rHOZnQVLs0+QllG0AA4DruFf/ryB2eyPnUNh9Yd
 tlsl4r1pkcZ45RbRgU8hOHpaXc3td3n1csM8C6AgtgP35Sr7UVffC0i6RhaPWNsdWtgq
 V2jxMAKbcazIamPb7peQhqVVmcRbkQRTwq3O7VLulieV47MmnVs9Ywdcvb6jKxlRkFMN
 APS2PQpe7TY/DEM7LCiEUOMx+vh/6dy/LKVkEyjGKy8iSeIhXvCf38n7XxTsU9JOK+7g
 3P2w==
X-Forwarded-Encrypted: i=1;
 AL+hErEDLJ9iCAwADbDee9Ahy0B+3o6GmVEMvZx6JJaLGpvk5fUauNctjv6GuyKBmCbfovy/+iseJY2wBiJv@nongnu.org
X-Gm-Message-State: APuU4Z9+X2lszELOVgpZcD+SqLmBl4act6oaWy1HDkg1XKJzmMDwjE7U
 vxMTHmJ9C3a87Gym0rBNcgptIR/n4h7xq0D9sFQy8FtDsqDE3UIpXBIffehC1bJJ5eQ7onS1nxi
 e0AAMFWnBdUB3cekevYPmw1rw5UGUPo6vBW2+VA0kTjH4RdwrweAvLhj+rA==
X-Gm-Gg: AYBFou1W9A2KiFgGUcbKrr8qfB2h+4iy36nmcXUCxtWgsJx1dOQWJe2E9DTjOYCjlUL
 ey4ndMqaxiEuf0ovrTZXXTnd5XpTrmTngxZ6o/YxB70N+tNNBXzp6cp9OunQesxNUsRdmDOfDho
 IjE27ajdGpo9MtaHgXqZ94/OdlpuQHt4MKWLQZMrUh5i4rdrG9rNOdejJ3ZDnqDhy+dMLquurjs
 NtrhgRP7Ndsnggb5l9GSZaXQN9eUdAPJaeSVZQurOS5F3fd3mrWoZ/9ySh2E++9I6iQjH/x19f6
 eGKxYgYgNxexsmeAC2LiFNSQY68vAscnjFqYWMKhE+fsPWSUb22NgmXEv1idG/JxI1Sub/CvsDs
 ijm5PJpac4NhHxHCiD+KkObJGckiiAJgwBHrjeW3aw/fwPEP74tGwmuT3qA5/AKRMpxqYAqNmMq
 nGN0UqUN4NXWrp3ia2AxubY4UHc2XxvHAd7rvmkO5SLQ==
X-Received: by 2002:a05:7300:d581:b0:36a:1fa2:fbbe with SMTP id
 5a478bee46e88-3725ec1a263mr6507939eec.41.1794202145292; 
 Sun, 08 Nov 2026 21:29:05 -0800 (PST)
X-Received: by 2002:a05:7300:d581:b0:36a:1fa2:fbbe with SMTP id
 5a478bee46e88-3725ec1a263mr6507910eec.41.1794202144716; 
 Sun, 08 Nov 2026 21:29:04 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372666d2fcbsm10015693eec.24.2026.11.08.21.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 21:29:04 -0800 (PST)
Message-ID: <fdb76b42-e7dd-4888-8693-21b2808efa09@oss.qualcomm.com>
Date: Sun, 8 Nov 2026 21:29:03 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs/system/hexagon: document SDK semihosting
 workloads
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261109042307.1301438-1-brian.cain@oss.qualcomm.com>
 <20261109042307.1301438-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261109042307.1301438-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMSBTYWx0ZWRfX69dfo6U/Jm6X
 pImCbgo49g6R0KGx4WQNF5Pr8o+sGFXEw163031I4wOuuVzFuynfTendHCbc/xfloMi5smBvAFK
 aIcI0U7SSe+MPzeKB/+9QMJeLbrVT4k=
X-Proofpoint-GUID: KejZ_x4KoazjS59qvDUbZlz8x8G9hKNB
X-Authority-Analysis: v=2.4 cv=FrKQbGrq c=1 sm=1 tr=0 ts=6af15a22 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CRtTEJtiJkWVpWibKusA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: KejZ_x4KoazjS59qvDUbZlz8x8G9hKNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMSBTYWx0ZWRfX1Pzf/ZJYRgv6
 EgVokyrPoYAlnAAcD/L1XDafdPdnonI1agpEfUA/fmcJtVIgeLxwTkeEvuTcdkMY6NqEjHKFrwt
 x0c+ZC0gTOxI3ZaZCJ8r9zqO/of47QjkiU36/RB9N4RyZSunmOoZUui4GuKQWZRoCw0rjyzbXjJ
 KyTvMohE6QoNhFsNtGxZZ8y8m2DwpXYHF2GVSIsldqakt4vzxFr4uPHjt/cX15k9m6Iq2XabLNI
 9MpDSt+HfU2kxd59xAnQtpcpkDs/l8qv9jmWkZClyduR75tV0xd3zK9vYSG/M4KOhpxYAUdtcMW
 1SX0su2WOXgEp+MFq8jYE4oYyt2YZZwv5iyo2p8pTBra+7/Ixpvl2NOOb7YBAGdhxqVH6ENcrDe
 bgdqLEAABqJzlBiCGmG1cqJYWdWx5gEN4c/H19vZDu3wL0Ybq8WcNquxJgDKw9fNQ090puXqJEG
 kMCGMvmqhVxkELi3o7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090021
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

On 11/8/2026 8:23 PM, Brian Cain wrote:
> Show how to run standalone SDK programs and the QuRT loader chain with
> an explicit v68 machine.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/sdk-programs.rst | 155 +++++++++++++++++++++++++++
>  docs/system/target-hexagon.rst       |   3 +
>  2 files changed, 158 insertions(+)
>  create mode 100644 docs/system/hexagon/sdk-programs.rst
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

