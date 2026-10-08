Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F75CA6009
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEbnD-0002Iv-03; Wed, 07 Oct 2026 20:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbnB-0002HQ-6r
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:15:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbn8-0006Xj-GG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:15:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LuQhX2098818
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QOyZfAQEWSqVJm0Qisn3v4+NwouWsS+/q8nqtl7+UTU=; b=ZLeSbPXahFFGDiKE
 UZrCAJ0cfcLZBC0cyrDrWRmGi3EAZA9bjHIXme2Y3XI+cZs++4225Wkj03ThtOH8
 gHUSxiqKNT+sox9a7+W2HvdlY0ySrWiC3ItWOeu/NonRY6Y+bCMAyVEeNqIXyMu/
 MfHQhAzD04uF9ZpzFeB+1yLRjEj+ThhzcOT15OGTCHrzhrH5pBjFj7MYSAWjWE52
 sf8LD/PSfsEOkyee3inEr+khaEXKmF6Ry+rUic1Z7e/NYA+0frdInbNrRZb+gWv2
 uZHn34bQydp9OJYhv/FXvdSfQNPKQCn4lZl+c/ppZx33++AJrW43Je4UJuh2wgrU
 JX6nrw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xefgbta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:15:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so4638613eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791418520; x=1792023320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QOyZfAQEWSqVJm0Qisn3v4+NwouWsS+/q8nqtl7+UTU=;
 b=KhpMlgEcK8WPJWG2QjbwJToeUw+PfN0W4vEbcqI2Zbc40aTkh4QsrekcWUvzgNDkwI
 ZbYqOreqd41DuTFQoMeBhwZf+/xsbRb6T5+2GawTg2inX8xT5pQpJJxLgr6UwE0On/q/
 XS5TYEnUQ2CTbZw4PG/dDdG2b6qVrO65U2fnviO/B33DIQ6MOyxDsUhbd2fn5DhExrhG
 La1ScO7UaIk5izxtCrhUN6D343ekfV1iresgid3SwuPmktPiDyshtZORdUbEqIOWzA04
 1Ib5tFNz0XyYELtdv9MYO1yGTIaV/0zFki+3CCwQ2rEEX3zyeUtJ26xB46xeBQuNGFc1
 ILRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791418520; x=1792023320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QOyZfAQEWSqVJm0Qisn3v4+NwouWsS+/q8nqtl7+UTU=;
 b=FBteuTZ95ZVTSfVc97hpRk2OkqSoaQVvP8CqTFyxTG577f+h93p0fmYtrEXl45PhxQ
 Vc2zqcP49n6C1pBHIAzDb0TOYUjxLxesYjAMwUbBaEGq7NiU0+h5q/IAwcyB+v2nVjCs
 8bYnvOt4TL6tIPrYscG69OY1DfwUhQvwHPOtiuy8RcUAEU8RjYu1ytQi3Hun2V/aUMBG
 C3169g14u+0CCAHYAG+r34Em/w3faGs8pIIpv129wAMDhLBKeVZZ+tQG3fD3MFOn/UDr
 DcygbwSZv/+Aq5WkNdtv6FQfhJZNz0Dcv302Pe5h1a8Cs+3isxQNX5IYvZPH8eKEcrnh
 4BJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzm1ErTbUR8NF/JdrHnPEglTgOG3heNHvWx60KIyQLLdLwzLBg3SrgfrfKX6tgGG8LEww/fQp3kXntI@nongnu.org
X-Gm-Message-State: AFuF++klU5GIwJ0Mm8U121PqQ+CidNwqKJ/RZQojae8rjYKYXW9Lg4TQ
 pyfqQNQLFjfrwNQgvAvs2ISF7HcrhfUwbHT+I89Kr5R4s/uRrSPUCfwVdjh3oRA3msONKF5koJq
 mN5XFF1aUngpvMjF24cIpfIiwWIY1crtQf4+6zMnRyrrFMF9NVdgX6fuy1w==
X-Gm-Gg: AYBFou2fn6Ye23apOyP9CVVVQQYO4HedOfQu47f8H5sn86kQEnWz31HY6yroIbP4u8z
 mlggsRItQT70bgIsSR18icrS9rmU8V6RRqX4Bap99OncWehKsqaqFlSRbAI/xRGq/nhH2z1OYZQ
 fBUnsIp0OCQCWIeb04Fnu2oTHZ6pWnmwfUsSjV+V/Ta2b3cyzJBrQ6A3cAWMhCiU/73NAp+lCTD
 rsVbp7vznkOEBsXidGev3CXcU24zO/91i/Hg0MA7s2AGpS6zW5IPbg3t4QVueSpLQCn0UUIFp02
 m/T7zfrda6rltAPwiqpQBUDe/+hQJcHiRibNSMytjEpnievay4k9FKT7R+GjF24wxb8WofgF7UO
 nRI1GngXzo8EumS44BNSuef6yupNW+CEzvVnp/pZIyk1uGiVfTzxP1w0zJb5ydqP03uNknA==
X-Received: by 2002:a05:701b:260d:b0:14a:8df8:56b1 with SMTP id
 a92af1059eb24-1662477142fmr399335c88.22.1791418519431; 
 Wed, 07 Oct 2026 17:15:19 -0700 (PDT)
X-Received: by 2002:a05:701b:260d:b0:14a:8df8:56b1 with SMTP id
 a92af1059eb24-1662477142fmr399292c88.22.1791418518555; 
 Wed, 07 Oct 2026 17:15:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1615f1ac8c5sm16510220c88.2.2026.10.07.17.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 17:15:17 -0700 (PDT)
Message-ID: <da50c29d-6ab7-4763-9136-3b6a575d0c95@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:15:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: Remove target_long_bits() from GDB
 register reads
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfXy5w/QnsHWUse
 AYm+aEeIDL61bRAxse31XSCXs4c2YMCQzF1pbvII/mTImz9BGQ1my4sjWgcGIrMVkAh13VLGEqa
 NfCQzQZ+JkBfVJASDfbcsq5H1bQAINDDsak3SOBACCigEKuF6nxfqgeaF9NWBLfOd0rPcx0UrxF
 MPH0ojO997rwcOfaWf5aAe84M5GtcRuMJdcAWwg++2h8bZE9RTj/0tYZPi3Urv0Wr7MyQMR+MOW
 Awv5NNoTq7B83nBVq+C5FfWNiiQy13L0ZScSz3CrtY4bqnFT0X0QsoE6jsxc7aFBerVOE2IRs4s
 n9ChiSQAyVEXq7GVytZzr9CjlV2cLsb5ALq1TD7y5Heo7kdA/+H5oxPt7cnTwqoNFttDTtKWppm
 FmT2ARx7SEpiTMr0w2efEXeb7IuFbpjRw7ic68/7hxjN8yk32vLGSty3JZMDFfC+O5hUmGXAI2z
 nN4bH//eg34gk3zAgQw==
X-Proofpoint-ORIG-GUID: RMBE40e0Ty65NiflYE9hvgSXZL7KzPLj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfX72/BATux6zFE
 SSaWfqEeyVBg1H9nStMT7Gn2xwaUARYO80T+N5qmXrRcCKPR/jb4TehdET7vmdFvFGkvhx9juX1
 WsBXGgf1hStdlFXOeuqzezy7JEPFAmw=
X-Proofpoint-GUID: RMBE40e0Ty65NiflYE9hvgSXZL7KzPLj
X-Authority-Analysis: v=2.4 cv=YbwodARf c=1 sm=1 tr=0 ts=6ac6e098 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=k4nKmolST_FcVLJzIUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080000
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/7/2026 4:23 PM, Philippe Mathieu-Daudé wrote:
> Prefer getting target register word size at runtime (via
> CPU state) instead of build time.
> 
> This allow to remove gdb_get_regl() and various target_long_bits()
> calls, and to eliminate the TARGET_LONG_SIZE definition.
> 
> Philippe Mathieu-Daudé (10):
>   target/sparc/gdbstub: Replace gdb_get_regl() by gdb_get_reg64()
>   target/mips/gdbstub: Reduce to a single gdb_get_regl() call
>   target/mips/gdbstub: Replace target_long_bits() by mips_env_is_64bit()
>   target/ppc: Factor ppc_env_is_64bit() out
>   target/ppc/gdbstub: Replace target_long_bits() by ppc_env_is_64bit()
>   target/ppc/gdbstub: Replace gdb_get_regl() by ppc_env_is_64bit()
>   target/riscv: Factor riscv_gdb_get_reg_mxl() out
>   target/riscv: Replace gdb_get_regl() by riscv_gdb_get_reg_mxl()
>   gdbstub: Remove unused gdb_get_regl()
>   include: Remove TARGET_LONG_SIZE definition
> 
>  include/exec/target_long.h  |  8 ++--
>  include/gdbstub/helpers.h   | 18 --------
>  include/user/tswap-target.h |  2 +-
>  target/mips/internal.h      |  5 +++
>  target/ppc/internal.h       | 11 +++++
>  target/mips/gdbstub.c       | 85 ++++++++++++++++++++++---------------
>  target/ppc/cpu_init.c       |  2 +-
>  target/ppc/gdbstub.c        | 38 +++++++++++------
>  target/riscv/gdbstub.c      | 35 +++++++++------
>  target/sparc/gdbstub.c      | 13 +++---
>  10 files changed, 125 insertions(+), 92 deletions(-)
> 

For the series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

