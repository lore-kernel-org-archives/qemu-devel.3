Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7247CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSUB-00056D-Vp; Tue, 29 Sep 2026 03:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSTo-0004qw-A7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:42:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSTm-00062y-BR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:42:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Th6K861255
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JAsZKHhab4T5hnmdkDT+BWv+Rr5l9RM6UywfmKKG8Ks=; b=jprVabPi2+7/7Xz+
 WAn7BQzXdpy4HZZFmmcyulXZbDtub3tJ30M6nqDsYDjMELLFgFBkxjqQwYExiWr9
 gChSlTurQm0JTaCmI5n24wmYcdcuxQ3RYu/5hAoYJZcSmLAl3mOddilBU2yGB+/4
 uK95WnVxfn3h41Mga2M4bwNw57YgOhKgHrA5O2bHugDPjEQd11TyU4ethpO08yiE
 10pkLrO03ENSpPLTbpB2bR2FOfnYer4cRNt3YpqtMVH4w9yxrJARS4+NGPmQexvt
 lvKavtupMk+0mXfNS0M/kUF9vv8Q90ZWAL997QZWMnN6bBpEuhj9vj+gJ036R/Xj
 4FaRUw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmua9qs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:42:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso3434602a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667740; x=1791272540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JAsZKHhab4T5hnmdkDT+BWv+Rr5l9RM6UywfmKKG8Ks=;
 b=JVRmRZKuOxlEtvXRfR6nbzuUtJrtTxQ7UNgMNE761qv7M5Jn9VwvZcH/bKi1KKLidL
 f+t+w+h/Zq2q2gVdc0rVqEiSSo0je9LAgJMdzA1d4v0pCEDfdtg6xRYShV1eDfncggsP
 K7rc5ZfzqNcdIkPtSNWlFVuL7wQXdp/hBIKWIlDu0MVbDsIR50xU1kut0mKjMXtCZRIT
 2np7yQeJ4viGi3gh2iepXjQi1PyrYF/wTwE87SKCYHmqaxlz6BGLR3PP1YaVo0e2cIpg
 M800pqUAxtb2zyvlgv4dfk+kYoRlFMhdtH+M4rbJBubFkyXv47cJ3zTVI3FGhQOCndO3
 A+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667740; x=1791272540;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JAsZKHhab4T5hnmdkDT+BWv+Rr5l9RM6UywfmKKG8Ks=;
 b=MZtAvjt1hdynaSSRspjmMyULu4gjZDWcUvrYzZ5i5Lk+MkMnDtV21R86JtCfIqvL2Y
 jv2WKRZgvcp7V8eM9+JsI/ShpberqFaEkKh4wh8yUiKLNoAaQhnS8/n8Trqe2XFRAiOq
 ywq4bGM1SGPJ2vtQ0MgcqqjAQOnVEJ1r3MxUEvEsNS5xcS158UwIDoR1t7bUCDLSeKa7
 h2CKepBEl8JmXAMerkMTXavGdcWs/bz9T0fD9/lXgTG4WpyjtSqrElAG7g0HJ0BsjWIH
 RMBiBRNk9rGI912M4Hu23c/l265iVpNxlKM6ZtS8p0i5K4twjmQzV96w2td4+ELW4p0n
 +cLA==
X-Gm-Message-State: AFq9FYLZW6yyy5dQGdFLJEqf8J1rn+KXmTfn7LcylzJI7t9MKmW93Z3b
 5Fx4Ounvy8qxZPe3/ln5DgE190TeXYUgNk3Pj4FOFCNFbAj1+SI5BySXPVakN/6Op+aSJxtmCDo
 bnGghieMb8CL4n7Pd/iTSOXqRFuAcsyg6UpFeENB2rlV6V8XCXWTY4XL78JqJjH/Xuw==
X-Gm-Gg: AYBFou3xmT/iaV/SEVo2fwzs6XetPWeyRehmZz5lM5gQ31C3IFwZktRSaEEetUmpTnq
 +eCJxxIxjFihTjxRnNxmV63UJV7V+JJnK8G8gm1YZPL37KbvO+c7mLUfz+FhviztiN9sMYRLMlg
 GSBE+26CrcxSlv+pvI0p5ZQdrBzAVTuBn3h/dHpV82Q1vj54dWffNpLKN+LrWmr0S4KIn+DP01F
 MfEs8KIrLKMqsJP/oKLm8JfEqrdqE05luR+t5noXuErOTnrKYZiNbxWN9AhaCfkUq4Uu9lNgllt
 oi9Lke2sc6FFh7A5ZJmkW3Q3APF4isj6eX0XG45UJA1mz+rMnfm2r00UsVslUPLD74FKGFYd5EY
 96trxCELEjoZhccWWWOzRpJ5Y/mFZ5RiU/czIm7AorEgwd/4X3utXOw==
X-Received: by 2002:a17:90a:e7cf:b0:3a0:e243:28fd with SMTP id
 98e67ed59e1d1-3a0e243355cmr4448670a91.36.1790667740126; 
 Tue, 29 Sep 2026 00:42:20 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cf:b0:3a0:e243:28fd with SMTP id
 98e67ed59e1d1-3a0e243355cmr4448652a91.36.1790667739607; 
 Tue, 29 Sep 2026 00:42:19 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4986e964asm3929107a91.15.2026.09.29.00.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 00:42:19 -0700 (PDT)
Message-ID: <7449520c-cb10-47fa-a81f-014975079d73@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 00:42:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tcg/tests: integrate some of mipsel tests
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfXx9XHow9zMjKP
 c2HLiPQusrBuSNpnQmcwlaCT/JtFeFKUyCNiMG8WvIeKJPvIdpqmrWGajMMyY7OHHj6jcVTLZHz
 D2HhMx9pOSAFcVcd2kyYW8Sbo9sBwgr3KsvQqtKB+1sjgFPMAUU2DgI5zpt9cXCqpTumIw8mhf/
 qlkbwndTwkfEbUnWoSkIdcNryn6V83t8/QkbCISfL0vMk2gdJ8h77Hf18D/mFalA1AVX1HUczzc
 8t/xVii0eR3AaalICwNhnGw+D3M/Fa2KypqpLhQKeAI4wAdsIK8oKFSVsRLpNRmmj6Tmpxvnnaf
 73C8ZN3TrUKYrPzJ/UU5v+CZhMiWua4Elm7+y7A67HkKyxlPNbdQj/sBOjxP2G+PJw5LLRBLO7D
 f3Ex6CPptgQhD1jkjOP5HcC94Fl77RoSCaltapQZeAYj5J/DrZ0p9vlWRi0FKCmKDyDKU8B5L3r
 wCjPwHcT6yBM9gnlHCA==
X-Proofpoint-GUID: wIMjQvqJkeXR_8Xt9i2JK-fScwppx_cV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX64OR9rh/jjBv
 +AQRkdjlYKGgUDO+QrhfPevluOvXA7cLFS/fDGO6e2tf4wEV1LdqWzai4nmPJtO2IF0FovRfTp4
 cXXMbsdMK66A7d5QuvZCPmHDJUyUsq8=
X-Proofpoint-ORIG-GUID: wIMjQvqJkeXR_8Xt9i2JK-fScwppx_cV
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb6bdc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bHJvpfPbjyP1Q3kwbLoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/25/26 6:00 PM, Pierrick Bouvier wrote:
> This series integrates tests from tests/tcg/mips/user/ase/dsp, and also adds
> multiarch tests for mipsel target.
> 
> Pierrick Bouvier (5):
>    tests/tcg/mipsel: move dsp sources
>    tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix compilation warning
>    tests/tcg/mipsel: add dsp tests
>    tests/tcg/mipsel: add float reference files
>    tests/tcg/mipsel: add multiarch tests
>

Sent v2, adding tests from tests/tcg/mips/user/isa:
https://lore.kernel.org/qemu-devel/20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

