Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gthrzwet;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cvvqeu/u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzfI-0002Ps-1f; Fri, 27 Nov 2026 12:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzfG-0002Oz-HW
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:23:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzfE-0006nR-To
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:23:14 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARHN2FT1903138
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PSs/NHfzAvWRFkfVgdpoilh43VH+DiWUZefm36A0izs=; b=gthrzwetyPUBth8l
 XVX5mUc1Pi9W8fJbuqgEt9nUqk1M/pEg/cHLFchMkX3y6WvKNpAQs8XDa8NKW8Vr
 Edfo4aB6SxEXkNbeb+d5D3KUmEvN+90emGyQHBehHhLTK5GoGBUh05gJGdbnbDYC
 7KPknsMqk3prjsBKF1GQZwI5frl9KERZcwd6cBnZ8YkJ7cou62oAwCV6K6j6ZC8C
 fS/leV6aviRUr5Z6cNVsILzSbbXkdRnHHrT0y5njMlRBwiTWlcxyT7YNIuMTV5Hx
 gQc2uzwm0FulsKE05pwDrnfmL3sBTWbQU4Ili05WHj21rDX1LVyEansSdZUJdiXD
 9i6CZQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7e7d000j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:23:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-383ec96a7deso8648519eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800190; x=1796404990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PSs/NHfzAvWRFkfVgdpoilh43VH+DiWUZefm36A0izs=;
 b=Cvvqeu/uF06UYIJ1cYoj7spBR38I883xbruugCDH+5Ap20G0jonTkB7hcw4MLCBDvq
 JgjmYLYBiqyMaKEb8dTt4Q+jpgkkIGo1BFZ7w91/pG4JBGEyIJnDgQz+YuYk1PdOxbV2
 g7kSpyNNodlHLR6xv2Ur5SIwux1nJouYOWRpmOZs04GxFV3Q2OevFib9dPoSp1CNQ+GP
 dEmOBerk1lcmmoIOHASLd89dPo6POPuC//uEa53UJk/Ssn9TY852Bw/McakCl/vHVb1/
 HKMfYOp87XX5qjhcd+yezKIZFoTm53erH0YrZS1TlN/q/qF+i/cx/dwQqdtDITOPDQca
 E9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800190; x=1796404990;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PSs/NHfzAvWRFkfVgdpoilh43VH+DiWUZefm36A0izs=;
 b=pGEByHQmYmosKGdIzXANlOEwfXHfgMVuAfxwUOmK3wjGA4BH/U+b2/tL7y6/nE/VZB
 eSlr0lvJmyqNmC0HiILq5TjhLEdZ2UL0ZRfo6SmAZrV4bx67ibcmXJy0ENltZ94YkcwX
 z5N4zYmNV9g8qBR74/2ZqImXzARMf1ILj4kDrvfKXv0OF4YyBdYFMuhw5cCnCC8atVs8
 ClTdTYZjWNUBu10XVfl2gsQ0d5haNMg+zO9SgJmBSh8zxbTYLxR35WvjRGpQa5KmjCa4
 GVqxqjhhwH6VoSJdhOJ4hhBHzOdOdUHCVh4mwVt13HlY9FTiekk/sLxSvyyt6MubRdsh
 3EDA==
X-Forwarded-Encrypted: i=1;
 AL+hErGykKKIJx310aVI/Z9+KKg4/1aTbiAV9BHmQp/N7Wmzt8ysZVQLqE9paM1ohsK/A59Cq0AH/+Ng/qGO@nongnu.org
X-Gm-Message-State: APuU4Z/m4umCNVa4rRbDrRJ9mUgJhLUFhsEeEaKp4wcxt0qaQt0ZFUEX
 UZIibFdqlvUGX+0FDBA0AWiejQRPl93XrAWGEU/a7inQGBw5S9PhJggP9NI32IRDpHnQqEj8uJQ
 N5a4Et/rdLEzb9vx+iIOOOe6xE1zI3gJ3p4SY4cWndOvHs57iK3bb1r9OhA==
X-Gm-Gg: AZFdTZcboRsr9lBINp1+BjeBPu6JPntenGrouDsxxMNeWg96VzSbSEutCKJ7mris/Do
 7XTDYxbKb2v98wbYQ12oemQiJuc3ONdYPuo4LQ0mRMMBzEbVCTq7Kn13vlYWs87ZcHIyzbuBpRi
 E1qRk44nSJTkjEPmrfo9kpGS7tH0qpq6L7ulf1ElFhJU4eg13nLJkvOAuBkSzFQVp+Vc6swARKk
 hzB5ZwP4fn3igmMbjPjNCk1aLg6gqjhn5uhbgqYaShOQipJS6zikqtz5Cbw30a5z98qcb7pBGq0
 SNVmYK9EQtOv6/f8vrqpLjI7yZSmY2d2WTwj6fIcaxzFllIInh4gjJj0Bc8EBwebNgdG7iybm4K
 zqP2+IQ56McT2SRMEhiC18vrHn7EzBgmRuUq7E8BTMzeTmgC62Z15IleZdX/TSFSTjuKBCi9QJB
 pUDcmiUiXdAZ6xGF01yyusso082D9DU8wE4PJh409bvoA=
X-Received: by 2002:a05:7301:4201:b0:385:b8f4:755d with SMTP id
 5a478bee46e88-385b8f47ad3mr25250944eec.20.1795800189583; 
 Fri, 27 Nov 2026 09:23:09 -0800 (PST)
X-Received: by 2002:a05:7301:4201:b0:385:b8f4:755d with SMTP id
 5a478bee46e88-385b8f47ad3mr25250925eec.20.1795800189042; 
 Fri, 27 Nov 2026 09:23:09 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385d2b93dd9sm83418410eec.24.2026.11.27.09.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:23:08 -0800 (PST)
Message-ID: <695ae4f5-33dc-4f46-8b58-83aa05212f7a@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:23:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 1/3] target/hexagon: remove QEMU-private
 execution counters
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261126183812.1366883-1-brian.cain@oss.qualcomm.com>
 <20261126183812.1366883-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126183812.1366883-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jzt9VbERLWIHQ27MRAgC67Sl1tz2z50_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX5S38bjI50n3L
 MAqq9ToZL1Pje/eZZBoQdpN8zhnSNFybsSuzhBL+LhTbW+QNmlRCQxYhE4QIK+plb2QsKoBkNKf
 4h8/AFsaMWamHUzhjcKGOPCXg2KkWhwm0v5LI1Q6keiheByyEBjaTRa2GhN82WyfXIzECsy5W40
 YmIdHre9s4iqjmGBhNFB+8Wrsq1f5jgES8t0h9OgBe7dvM+WS4VgIw1HSGdvdx+5f51ZpO9Fs+0
 DPhWYYO8xgyIOmYe7eXDmGvXPT+ajzW+y5u/TaEteZe2lkp4m/Kc9/HcRQphoT5C9PtHFRoyOzS
 l1NBFUknjmGquW8EaoCR7swcVMjUPY6NJk7glNFOLTdfLI5gUO1XhmteWoJhdu5bfqLCgg5fDXy
 /pcyNDd2ErmABVygt4JrKJHO4uutFg9kvvaiYJylVJtQh3F7+Zk9w28yCG+0U3g5sS+ESqozgwZ
 BaPH81vaJrDKmmRJhFw==
X-Proofpoint-ORIG-GUID: jzt9VbERLWIHQ27MRAgC67Sl1tz2z50_
X-Authority-Analysis: v=2.4 cv=cJh1IVeN c=1 sm=1 tr=0 ts=6b09bc7e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=faK4bv1PzxNB5_XPIPUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX1Bw0SeVNhe/H
 MBv5ZBOMMfL1ey9igM/2w5Nb4O+63+B5gOjUhEM9ERZMfp07KVszPuUzXIOFGs3In6Xma8wtYOJ
 Twuzd55WOSLtSHJTnC7ZjBVckXUtrOo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270069
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

On 11/26/2026 10:38 AM, Brian Cain wrote:
> The instruction counters occupy user control-register slots 52 through 54.
> 
> Those encodings are assigned to UPMUCNT0-2, so remove the debug-only feature
> before adding the real PMU support.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_regs.h  |  4 ----
>  target/hexagon/translate.h |  3 ---
>  target/hexagon/genptr.c    | 35 ---------------------------------
>  target/hexagon/translate.c | 40 --------------------------------------
>  4 files changed, 82 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

