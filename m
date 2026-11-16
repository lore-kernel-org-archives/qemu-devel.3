Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C2606A8B3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XUa9kRhr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IjEU5pXP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT44n-0000tb-DE; Mon, 16 Nov 2026 16:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44m-0000rJ-Gx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT44l-0001JU-0X
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:17:20 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfb422135213
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bOt4aZtrllO+OVJcQHILDmfFQEHTsphR8jqf2JlmwOA=; b=XUa9kRhrdb7Qq+IB
 VGw8xQZw4aDH+RV6s4mEr8QLolbmud7SVo0Yh6/FV00Bk1RK9VnofL0mUNVNHK4U
 HnaufGjldRWuH9u9cnO+ce9S2FX3P32OAjkjHeXfdTUGld4uUoxnNNGbQijf/zH8
 o3CIPlx4YIVMKucGfp1ZwFC+gCxFTSd500ooyQaK8ukGCK4hwjpr0aLxFuchDEj5
 Np0xUnZKB6LExq0jwWkLN9P878hWvySVmnN5BMnVpBuA6Q1+v2i2Ddb4F1XGqx/P
 TxHpXfvcPlC16aVVjKqOhJDYttBCULnTVz4JkP2NMNZ8UvAZI6WPdKbs/6fhQPzt
 H53Utw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0003jhgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:17:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so4700822eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794863837; x=1795468637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bOt4aZtrllO+OVJcQHILDmfFQEHTsphR8jqf2JlmwOA=;
 b=IjEU5pXPMgswyzD1bATYKRz6O+HqcMmA1Ko0NNxWYLZPfJnjjjW0/0Ksicl/txzzU8
 tsBmelGifVzWbpFrdhr7WcbdnIWfOHrYsfnW9a0NntSjHE9m9EwbtG9dz3OBf9b2SYRs
 rXxaY5EDQ6sJMErGsmRRbGk1iRWJYf6Vots9qjxRDQKqD92JVYcSUfwYpMhoY9r8zjYR
 po40c484cZpXijwuCKLWcGoj4/7w9WsHXIfBfNFeuZDQVwWEhHaVoUT5F38n+DzWshX2
 A33vHyDXYLZt3WbPE88xVS8rvFMnvBQnCvJBlIDjCViDbgFsapMVGtcE1uM7mFAcW6ay
 VgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863837; x=1795468637;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOt4aZtrllO+OVJcQHILDmfFQEHTsphR8jqf2JlmwOA=;
 b=fpSVvLWFI9E4US5fPuMBr6BbE3xm76+mvCjLiS1Z5EpTupp8u7cKSbwPC+izwLUwcK
 5gtDdXotzyKJUT+9IM8vdJhC5XyujV+nibmLrhj0vG4TMrcTmIp8ERgzR6IQlu4lmsXQ
 FUrvrsmUCVUp/61gsEpKLFDoYvz4giVlnp/o/Aq1CXLsSNX7p5Ciy62l8HsISEEwNOUm
 plmbWtYLhvP8xrxhIiya9PTdiITu9zzRjINqfh0FpCW3Ngar+UQqt1qXJ0DbnEy7Bbpg
 B9bQCw8QHyA2BIyFcumfpD+Dce2XAjEZ5UY6T7nUiJxTW5xZGNx+6ZQhizuoUVREQgXJ
 f6Uw==
X-Forwarded-Encrypted: i=1;
 AL+hErG5Fa5/VYvxUM4vpx/DXWDQ2b1ufyZyG0T0go9PbPklGwzKp7SxgFUi654V6CkvaTKPDSMRipTNdb/l@nongnu.org
X-Gm-Message-State: APuU4Z/9qITQajPrFdNXnuYIDU0nE1Kbc+ZBRSSFxW4DWiL5pDJDCLvd
 0zhp3PpDRcE81G9CalVhL5AGff8D4Vb+2fAGn/mjLN3bgP5nUKe6kcisTQ7lBF84kF5dvNptSWm
 HsZWJOAPy29temmZr/9DDw4a3Fpgo9/i/x6MkttMp/HyyMYmva/eIn8WJvg==
X-Gm-Gg: AZFdTZeRqVn48if/UTvR2Xx7oJRaRY/xyFR9FzwjXZgweyozEhzvtz6I3RVPSinKP6m
 VAeMVb3CukAFlyiTCQlDqmIPaYoN9XOrG5mH2V1aGmhB/yvb1fBV00UNsZqK9yw+Bv72w0rYwkv
 eUQ6xkPgaWIqkmC7uxjjn2QSUz0c8Vf7vtD29Kn1xS/lQ5d/Yb+xtPqaSqkaXY0CgiF3ee6xb9X
 qrWd3fnq9ZBt1Sgql9Xrf8m22Z4guZWoACyNBirCzoFdMGvehoqLdFDvib00wUUY7bYoCFJeFsv
 QEWTdUkdZ0u1LPcGaV+fA1iofxkxO27zOJ9Vc+lqYtALu/Yu/VjyN0qKQ7a0ZtFyq8MqkBlENFZ
 7BIgG/m0h6YhfiXNSAlcMWXsdnEEAafsGodf48vprZzYuxhFuhm7PaslZINktbuzJIwDWnO6dQn
 1iF+gxBSj1L+cVRgr5RkYjK/VJF4RzEpYrkInJwCyNrVQ=
X-Received: by 2002:a05:693c:2585:b0:369:ef63:ea95 with SMTP id
 5a478bee46e88-37966e3a7e4mr10305435eec.6.1794863837136; 
 Mon, 16 Nov 2026 13:17:17 -0800 (PST)
X-Received: by 2002:a05:693c:2585:b0:369:ef63:ea95 with SMTP id
 5a478bee46e88-37966e3a7e4mr10305419eec.6.1794863836608; 
 Mon, 16 Nov 2026 13:17:16 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-380e0fdcc36sm2278344eec.25.2026.11.16.13.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:17:16 -0800 (PST)
Message-ID: <5e5af4a7-d6c5-49d8-ab4b-8e634a95bb2d@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:17:14 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/48] hw/ppc: convert machines to use AliasedClass
 interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-19-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-19-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2T-wRqpFT9afmei6G3jnC0QLcI62DemH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXzUFyRrwUgID4
 gWznWKd2upImQG9fM2lkyMyvDJR2hg0qoVdVgCNtdw2kz05A1yIjlJQzp9YlWGwbB02tIJ34ujc
 MGEQJWVbiS3uHx81i/X78jeibMUlxqI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NCBTYWx0ZWRfXyKof290xrN0V
 pjjcZfV/qryuZixajhziHuBt/0peAuH5oKxH3R240C/hf7ckjhvBXXw7ywltP1jJ+t0EpGEzKvy
 ub+YVhV8GyCAtjL4TTtEAJp6ORQvHM+e32Dgg4NWMdyzV/d16mJXCcBS5u5ZMuOtZUnbNr8+pxH
 fPUrcac8X6/oPYVG0fdRxZKV9RGNY3fl0Y1jZbJOdHfcc6g94sKo6DjYPcZn9qM2JP2Zez4ZTlm
 i6a9gMOw8L0RDhu6mBXbKlrRQe92TP9coi6j4eskJg8zHpXsVEnY0WCyAJHrq01Ky/nxj6HHO1h
 y8ULru6aWsnSwXTj08JOd7zmfYCzeDkP1sicfiwd5CGvw/8hTwc4GNyUsDUHrsBdOEj1OVkd4JT
 HeTxvp9ZbgJMaIqhd9lWfiFP3Cn8AgH8TbhUFU+EKsA19lxCTbWcbHw6tOe7fyzRiURCFxNTcRB
 SZdyHtTCPYEzH9x0V8g==
X-Authority-Analysis: v=2.4 cv=Z4N5j3RA c=1 sm=1 tr=0 ts=6afb72de cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Kqo8LxV5-QPNKTeuZg4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 2T-wRqpFT9afmei6G3jnC0QLcI62DemH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160084
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
> Stop setting 'alias' in the MachineClass and instead set
> 'aliases' in the AliasedClass.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/ppc/pnv.c   |  7 ++++++-
>  hw/ppc/spapr.c | 14 ++++++++++++--
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

