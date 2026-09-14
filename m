Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49D9C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CbG-0005Pq-42; Mon, 14 Sep 2026 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CbE-0005Pd-20
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:44:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CbC-0006ko-JC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:44:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYeCx1904025
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bAkCYBHRGtmbCL4vAwAYUtNII1ZcR3q+rvoO3rlkFdc=; b=lzcuTQizXIRopJHT
 Hc6PnAA4x7KgGFuRItl1kFkqY2Gxfr6ksiNUSdelBhJKlAVeT6UrsI+wPgcRnKLd
 QQikR7twz/Q4EsthKMsJ6ZvL1Wo/hDBTM2w4jx6E4jCPig6ygyxv6SWMsDyA3SXs
 O0PUbLOBKKkEg0qUbkiHqtpjprUldpaxeAJhKP+GOxoMoG6qii/1tr4BLc0dqYFh
 BedM3v0ChLoAnKZYBT7T2f6F1Ck4vHTNSSYrAodJ8AfrN0EZZkOFSjjKXp1eRgSp
 M0GalOzZn+MZU8qVgFwxcteSF5AWK8aa812n/BQAH66uWb1XOwO4tfdgmJUNrLvU
 9l+eUg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5trr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:44:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4683885a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789415057; x=1790019857; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bAkCYBHRGtmbCL4vAwAYUtNII1ZcR3q+rvoO3rlkFdc=;
 b=SEPM2pdbgqbyH/HsBpXraxoq0/Hsgc2itAYN8NJSdgPmXacenPTbbJun8YWdrsDJZo
 jDHL/uad3Js0L5pyDgvyou2uTxQZRM22Jfdn0rXuPvRW/cissgnx30Y64/JdxweN2Zj+
 hRwFWmwXgYHVc0Bhbu3lVCeSVYmj0Ns0/ko7txxHWuw2VHVpN58g0BdAnwoFyeC7A1Sm
 o8sEd1IAvoddANqXSGfBqkyLGJISei7PzZntLbrpLOMX+hL9Ob2YAA69nmhewBG3wZhL
 sKYtm48T1hb67qHrTo3WssyZuMgozYNP8tWtkOV5Cj+3zU8jL5LWK91lowQjW3Sxc6Vo
 cupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789415057; x=1790019857;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bAkCYBHRGtmbCL4vAwAYUtNII1ZcR3q+rvoO3rlkFdc=;
 b=mTmcUeVnDpF0aI5bCFABjvIDRJPpYMJCRhdiGoaLk6m56ukTsldprs+vgI+ymOvrpT
 Oyj9i5bqQRFmnBw6vD5R9ZZ8RNSzo4bl/HAH7AFi4t7EpMeEhW0p50+06n+5juWUU5W/
 dcznjWzsyvnasJNuWOXA17hVLpV/bRlZ6GY3srwFIJhQgbXchTyx8IHbin1+8NXwAj72
 zWlklbN7wOFKIrCj3pVAvDNl/bt09TIgObSZ+Kiw1LzrkU/hktVZZOcmPbDUNvP0oPlc
 1ToES5hnD5jpaA0kLCWFjbtATYBZ6vukfzEYa50kcbq5pMjkTVXs37t+j8VSbk4gUlDw
 d4Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0S8IYOLE+8Cf49ewbZmcyLj0+UsuoHEN+8YYoQSg5v40O0aMqxv3hCFuC56M6lLzw1j85CyI3ISQ+@nongnu.org
X-Gm-Message-State: AFuF++mCL3eUHIObbK950Sn42gdQ2I0BeKZf9KRrYzx4UWGR/bS3oquI
 PtSnk+g7/SbTLsLWqY9EN4ZIyYFt4S4Rg1MCduW3M/wY04KEmJztcWKThDX2p6csG08EBaG85L7
 XiI/vuaCBLsAXQvMay4it7aaJKQqvppd9UpZyANynXQEq+TJ26wANLRKmpA==
X-Gm-Gg: AYBFou3mm4Pa4+79TfI2YWOU00yZL2pzL+UG8ZeBqSz86Hysm3tFdd22iSyps/gvdkQ
 Zyt47fUOQmDIfuDv+1ZxNKlaP5OcdG1de+uos8KGtJmiiPjoWgJ4CZBk9L0uLrrqE8jVwdORINs
 dpnBPt/IzdcbM3cPAV+7zUlv175cg8BiKjovb1JFp3qsxKNRZdVKvk10V836vcI8Q1pKFDZu8n5
 MHMhqsKcGD3pk7cL3kW2Ug00VnBz5ZG7H2JcbguUEi03wvq5Oxcw3MFQBohBGrkkFz/v4dIKa5G
 ixgXd7lE3V0v7js5/8DD8RsAdW8hv2kdq3A+uW5aKFV2Ggg4RPGdKKagpcCLi5uZOZgak1hw8Di
 TEHWJCyhAa+bFIF1RjiFyZeSXaEepnp8k1xmhxPyqXN9WWsn5hbuDASZSJU6OGc12VuM9
X-Received: by 2002:a17:90b:35ca:b0:39d:fb87:569f with SMTP id
 98e67ed59e1d1-39dfb8757a9mr2914109a91.12.1789415056626; 
 Mon, 14 Sep 2026 12:44:16 -0700 (PDT)
X-Received: by 2002:a17:90b:35ca:b0:39d:fb87:569f with SMTP id
 98e67ed59e1d1-39dfb8757a9mr2914065a91.12.1789415056222; 
 Mon, 14 Sep 2026 12:44:16 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f739b5sm27771608eec.25.2026.09.14.12.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:44:15 -0700 (PDT)
Message-ID: <9eafc633-5401-4e95-8327-2ebc71b66436@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:44:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] tests/tcg/hexagon: add cond call, tstbit-jump, and
 endloop01 tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4MiBTYWx0ZWRfX8wogS4vJhA9o
 wXHFwFfxLkfZucBL+2UoiPRLymV5pyv1wXfGGFHlkWcIDEdp6u/YeH2QhmAgB+2XUAOBGQDhIG0
 xqCcyroyzz0pMscVPIKq6VwTaeRgwpI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4MiBTYWx0ZWRfX5JGrpoUz4VAp
 K69B22qDQaO8Ks7TrLaaHs5+whqJdCzNvfB+lDrTOeOZpJixC9T3v2Ag9pWsc3G0goY7t+imeKb
 wkMjXES8biPG8YXoeqGyC8zZIQhOtPV5LM0bmq95rw+4F3Gb3d7+/YhA5CkBdo1K13JbX4oY2So
 20HV+c4tIsjv85XkdYxnkNFfAD6zO+j4lPpR9VfAfz2/iJcKLPzOFJRoGe1IpVMoAV5Gvvz8Htq
 9/tmcgDpp49mK8SL+dE7QrPXfJ3pysU3MGmUhpsUtHjZsY8Cl25Bq+fEl2Ypq4maKUSonZG3iBf
 t7AOyx7OxmoTw1AqMW5e41seAXJPyvn/tZYVM4oxxX0bnK6ui1BzP0yb2EV0fG7Z3VA2hnv8BsS
 Xuj5gQt0HLihl3+782WwdwC85SaR1iUedmtlPX0gzJwoS7gvZ16+YU/V13Yu1dol9hDOY6RE6Ht
 zUbKxqtAxzxj40KfOXA==
X-Proofpoint-GUID: cJEV93RqhN_X_sbkskykbE-jG-pkhhWh
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa84e91 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fUAdvlw0cwO5HCP4248A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: cJEV93RqhN_X_sbkskykbE-jG-pkhhWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140282
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Test conditional callr, compound tstbit0-and-jump instructions and
> endloop01.  These exercise previously uncovered branch paths in translate.c.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/test_cond_branch.c | 162 +++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build        |   1 +
>  2 files changed, 163 insertions(+)
>  create mode 100644 tests/tcg/hexagon/test_cond_branch.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

