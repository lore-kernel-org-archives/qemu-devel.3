Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37161CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGinm-0001yS-ML; Tue, 13 Oct 2026 16:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGink-0001y8-Tx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:08:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGinj-0003bD-41
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:08:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DJaL402222861
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rj9r141RWtHB3KYqKxzY/ZhotZnYoO8l4GVKDBqz3qY=; b=bjAfv/x7qiv+PPDX
 sPsDojiCtMpRF0ntdsp+hbuOmtQsCY/yvrBlRqA3m/ck78En+Pl+lNnE1+qtgjC4
 B0qkvN91eCx4wEYmEoGS2zJ7sKZ/mimbb5tvf8en+sZHdna8zHmvtsmJExf8zviU
 t1sdx6W5bv7MBwIi6eoYXtXxZ/N7LtoiWAdnV7Ld2al7USy0S3bOmPSXju5iqUCv
 ttiLX4QwhnMBsYX93Nkh8MVNDijHSNSbvtY58SNz2dYHN+76m+49wzuaAUEVaytR
 /kPj6oCUqaBeicuRCBzPpZlm8fC0z4jXNSjidzNjE5YL4XfdiqsdHsUdlliVFVNF
 dz8z/A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txs83vj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:08:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso6479198eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791922117; x=1792526917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rj9r141RWtHB3KYqKxzY/ZhotZnYoO8l4GVKDBqz3qY=;
 b=W8mPXWjbFTHFOPmy9BqHu5sGy7v8tiFDPIVACJp3qltKQ0hF8ndPBky0GStKJgTJoJ
 3GVqVNpC8sQsse+wOS3+ZIpXPvOglG1zAF1qs93zbZ/0eo6mec0jmIxdw5QBhpNjQrKl
 fneUXnPqcjOACxMHbA+4gCbPSykPyYhGz5r6xM5c6r5xwNM3HJ/NvujsUbW4BNzKvyX2
 rE+nH2eXXqz+AbveB6RZyRrlXO3h0XdQFOUTOy9/0YbAD0wEgts1Kgm3edZIrmJTz27H
 oWNrhVuIH2IUmLu9W2t7il/upPxtWDFGt7kCJdJotPK30H1jXYvNH/N+ZC/j7U7ICmA8
 3vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922117; x=1792526917;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rj9r141RWtHB3KYqKxzY/ZhotZnYoO8l4GVKDBqz3qY=;
 b=fFrn4Gf4P0iINUcqU+5snL617tQL70xnUcqEec8OgVuFztnEql6/WtWHvfNOBfRwOm
 0EAdbAANuXB8Or5iaSL3eqVxueUOqZzC2Ruw0mUQWIWWhxOROwXEFOeIvrHPDF+/Yfj9
 jBpA4x5sDK265SEqkk3aOgMA83xmgZkFTbi/IAYNVbVNMFvoQ4dbRPvv3WGZsOLXq+sY
 xFk5P8/5Fyp7oxaLDSUoXNlA4CtxChcizqiYUrBjzRvf6SkryAggwta69XwyOL04UEz7
 vOyEYwXX3JQtdWuCc13t6FIU8AcI7gqZnlo/0D9NmdF0yK7FCkokbHE4VHNhAfEcv/lt
 hHaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKbdFtlBbN3RYV5871hLP8QpwHZ2jrKEA4YkhM7tjeVx5act07pGehpOhUuXoSdR3YiPZfi8IJR34Z@nongnu.org
X-Gm-Message-State: AFq9FYKVT/pLpLXkhzFUj/22sOvnSMOGN/e16kfDsG5fIq3lktjlb0SE
 LlxtHchhki4AVEtnSuzpX1qrqWv01KTSCmB7HSnuZJH1LNbgVCVzmVe4l5rt0LcP0aAbdwEBnNw
 9Jc/EkCZXLlOYkCI1kuECFHDueD/p6kR5y+ex0xM1Dms214FGvJSk+cL1zA==
X-Gm-Gg: AYBFou0ewCD5wvJosknEC2Cmf1jfelUJTATVrdFnyVEVv2GKjlthrAg9XxZjon6SADi
 zsyuXg+EBzeIBSG/KbB4+724WbFcWEBociDbQlwze4laNd5Rmu7rwnvX9IKAxuPkt8ouB/3Rd31
 Dvt0frZg2w8Gqb5BRLWJp8NqSUQzQkVrZVjsRzjxIT5JJoVfbWehKn+ttD/Mt46OhspMCHt1PAP
 NaCmGey7m9EA1bYb7jFc4GFhRdWb+lUYAftcjYYi+ronk9mndXL9ijOw+Rtv6b+J7nwAtrjkJLl
 FgxkAoPVDBn2hAolA9h2v8GojOtBSbxV1tfuNzMD0kJ9IPA8F+WKnJZc4q5p6eS9Y5/QT78rAzH
 xytyi3BEJoSyv8pn14kNqljuAFcYwrYPzkZWMnBsFrmCeMoC4JTGq/b0xWULdtCWgMhk3xg==
X-Received: by 2002:a05:701b:260d:b0:157:cbf6:89c4 with SMTP id
 a92af1059eb24-16a5faa76d7mr17283345c88.26.1791922116302; 
 Tue, 13 Oct 2026 13:08:36 -0700 (PDT)
X-Received: by 2002:a05:701b:260d:b0:157:cbf6:89c4 with SMTP id
 a92af1059eb24-16a5faa76d7mr17283293c88.26.1791922115504; 
 Tue, 13 Oct 2026 13:08:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm51705646c88.16.2026.10.13.13.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:08:34 -0700 (PDT)
Message-ID: <f3649d73-1edf-440a-9534-7b00da4d075d@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 13:08:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: defer max-v8 initializer selection until CPU
 creation
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261013195606.152-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261013195606.152-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4MCBTYWx0ZWRfX/nuhEV4fMMb4
 f3oL3LfSsIrqTms4yHUvrXFTUxl4CXxe5/Y1aLXQQ1Ri3sQtqQVrIjMc+593RSrJhundW+xsxJs
 yPOokuTWqii/nvbBSsdFW3IAtBWeqP5eVEleKsih3E273iqwk0VJ9NcT9r8jB2KzNx0BNGMyR+Z
 7DNQ5NVyXkF3y06EdNzhMcZ/U9UNPbPtIL+BNoePQRDIB/GKljBOHm5ID+etFv6DcPAbdejUAdu
 bWFjeMVYADy1Np51RmGF5055vsXn+PSWwpNTETxITwoCQ3NH444uIiwjaZW4Hul0Jyggk1tb43w
 y0mKSIGtzVYAqcOjuWl3BScPIQIM03IRWptmwkGRjRbv7bYuA0i9VxhZL+Rnf82AzUEC13pWw9i
 JsqwyGl+bvwz0XooiDEjV3iJbXZ5nJOU/d//msocScZBu+hnqLz7ywpnN7PTLokr1+tVgLVVCME
 /B9SgV5YdFvWO/D3/vQ==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6ace8fc5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=lC7IDxeUqbZSPR3gfYMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4MCBTYWx0ZWRfX5TN0DO4v9onQ
 p0Qn+dOmm/MqTz1TfL4KdkTrcjF6mY1bp+6skpi2MJNuTimZT5/t1wqF1p7SRkOeUmJmsv6eGpn
 ErBtnMVuuTEzeIqFj5Ga5+/BHtqa/HI=
X-Proofpoint-ORIG-GUID: Op_G5Yb9aC7jUn7kh81Q5opS7hfpGJKZ
X-Proofpoint-GUID: Op_G5Yb9aC7jUn7kh81Q5opS7hfpGJKZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130080
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

On 10/13/2026 12:56 PM, Yonggang Luo wrote:
> This is for avoid "max-v8" qom name conflict in multi-target qemu
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> index 65f851f2006..d7323ab431c 100644
> --- a/target/arm/tcg/cpu-max-v8.c
> +++ b/target/arm/tcg/cpu-max-v8.c
> @@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
>  #endif
>  }
>  
> +static void max_v8_tcg_initfn(Object *obj)
> +{
> +    if (target_aarch64()) {
> +        aarch64_max_v8_tcg_initfn(obj);
> +    } else {
> +        aarch32_max_v8_tcg_initfn(obj);
> +    }
> +}
> +
>  static void cpu_max_v8_register_type(void)
>  {
> -    static const ARMCPUInfo max_v8[2] = {
> -        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
> -        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
> +    static const ARMCPUInfo max_v8 = {
> +        .name = "max-v8",
> +        .initfn = max_v8_tcg_initfn,
>      };
> -    arm_cpu_register(&max_v8[target_aarch64()]);
> +    arm_cpu_register(&max_v8);
>  }
>  type_init(cpu_max_v8_register_type)

It works for the current need, but will require further changes for
heterogeneous emulation. A more versatile solution could be:

arm_cpu_register(&aarch32_max_v8, target_arm);
arm_cpu_register(&aarch64_max_v8, target_aarch64);
/* and fix other call sites */
And arm_cpu_register could take a new parameter, to set
TypeInfo.is_available with the callback passed in.

@Peter: do you have a preference on this? I'm fine with having current
patch and delay further changes to arm_cpu_register until we have proper
heterogeneous support if you prefer.

Regards,
Pierrick

