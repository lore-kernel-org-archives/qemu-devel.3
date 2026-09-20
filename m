Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30C7C982D7
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 01:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x86IO-0005F4-F8; Sat, 19 Sep 2026 21:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x86IN-0005Ev-MT
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 21:24:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x86IL-0006Sl-Pn
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 21:24:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68JMpr0a729025
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 01:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HUFu9sYxUYbIVx5Z/Uf0yAeAkvXYJcrgr/j2MFpMRqg=; b=C5n733BboxeErPus
 A3g6bF69Dmp6ktlKZbvt1ikG1oRm+HDIL3ftkkOLhsY5WeftQdXuXfVvhHeOLjEg
 Bq1QbYlc25Wtx2Ph7xK0aYEdE54WQB5TI/txllBqAovSaIBmLpIgI1gHc96fMKuw
 HwgO9RwecS2jndOa74/ZOOWU7DQcDsLURgVzT6py2CAjnlm83VjwzWh3UAvrPLdx
 jKCVB3wafgaUg2nC041cE2VCvcoUGMprK+S5kXBaN0O8hpLtdkoJzh0hbx3qGWqx
 JRW4LHmlPOaSVltZsn9Y7HDms/Ve3Kb1ij1cxw8C5ivsmw5mcErvnvGBt9UZXLBu
 Y4OinA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsfrntaxt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2026 01:24:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc4afc810bfso2937203a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 18:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789867476; x=1790472276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HUFu9sYxUYbIVx5Z/Uf0yAeAkvXYJcrgr/j2MFpMRqg=;
 b=aAEorqPZF8zcmQ/cZ9Vcs7JDGLu31IDhCs74qdK55iMlb7SGuhAYV34wE9nbbBK1t8
 kalkzS1ZdDMglXyxJw4x9zmjVJ9oN7msjzCde18bs2+l4q9JKpSMhnsZMSfm7iX9BpuB
 pRVAdIjMBbdUjxkSvq/CP1naIP4wJjQXYaAApbkL+6Kj4X1MbJMdqEwIxKN8TykQ/Hg0
 GFxmBh2g9zqtnwDrloaGuwX2PCmjP+lKYFnSsjROR8rObeNbHbNxgIcYJZsTHGZEj7GV
 V+JqdQz/GeB+3ik38rf6VNMLbtUl45TOIrt15zpbrCnW/5SDUNBtFWPxzihTo4RlQ8wi
 TOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789867476; x=1790472276;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HUFu9sYxUYbIVx5Z/Uf0yAeAkvXYJcrgr/j2MFpMRqg=;
 b=vdMx5AaYaNSjdX47HPhmxTbOzP95xML4NtUEFPZZJ3pgUMu+qxgujmWvB6KC469ojE
 LbXo+w6yBAgwOWoHKIbZNf+U5J9mXnCgd5s84AMgLSdw4xPm8+pAZwzjHYmwAwwvporv
 Vn/WLOUSv623McN1LYu9D8Cize2L1kRtGWwUv0eWPuoZDPvr98jlVWch+qMxQDa0vhUn
 SSWa77OMvP/xSUl8B21XRjM+F6/Cx7iujTmfVfZGPBoi7QebDGb+QTU6dtIYhRW0h7Db
 zyHPJVdk/jq3gS6s9183COgMh8+h0JfMeKSTidPskEa4sbfuOA+I+6CPOi1m+fxlRHai
 jZ2A==
X-Gm-Message-State: AFuF++lydq2z5Z469RI/yF5CPQFNInQgntcN1xT8LrfEMIP1FYylXN/I
 rwirJWgY1s/Pj/9FC6uctGi/GvxPQW1TLXf6LVAP+mi6M/dxVTysL1bDIswEYYykR7uxF9AK0fH
 V+0BLxkOkpfxtE8TE8j0YTgzY/659yErpG7A+owPmDh4EAWfzQS/FKV6UtK0E6Bmn/w==
X-Gm-Gg: AYBFou3BDvHvalY5VqOpeDCmXRbFq+Nicc6gwsQngJQqJz/7uEb/O34sdwylJLYHkvD
 T6dyGBGYmU92EtvXB7qbOEalwbpa8bmVMe29mLLwrxwLGEDO5AvmwiJWxg0OH+LPeSP72solc5O
 rsdaV+hYrx69/SThFg49hZ/0gaqVs10HgKE57ZdsJsUhZETVM5B6iQy3Jh9QRbcKHJ86GP63/ir
 JtuCPJy+PCJZ5uDsyMDeSPYWgvs/7EY41s9LkYjr3ee+QdlWIVim9XxW0A/eW2A8JzI64jlMt1X
 t9Iiv0jP64yJ5aJD680GWdEdMRwXeGipSgER42XP4KrESkoyJSI3EnsSc7WXoQe43sgZw23Qo8P
 sNhx6HWnGofex4L9Ow5ucZTvBC9hS43DeevgSHlX4A1bLpLZSs4JXtvU=
X-Received: by 2002:a17:90b:38c8:b0:39e:6a7f:6187 with SMTP id
 98e67ed59e1d1-39e6a7f6404mr3996514a91.24.1789867476544; 
 Sat, 19 Sep 2026 18:24:36 -0700 (PDT)
X-Received: by 2002:a17:90b:38c8:b0:39e:6a7f:6187 with SMTP id
 98e67ed59e1d1-39e6a7f6404mr3996503a91.24.1789867475995; 
 Sat, 19 Sep 2026 18:24:35 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a03ab822b6sm442246a91.5.2026.09.19.18.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 18:24:35 -0700 (PDT)
Message-ID: <0655b277-cf55-4b43-ba89-b17d3f842caf@oss.qualcomm.com>
Date: Sat, 19 Sep 2026 18:24:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg: fix more container issues
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W9mtxhWk c=1 sm=1 tr=0 ts=6aaf35d5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=2EKwIMLOcCYUEStV0NkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDAxNyBTYWx0ZWRfX2cUDKMWzogOp
 h1svh7dBNAqi3QfvTK4ZwfGbRqnLHXPdsxJXEilkjdmlgmhnnaM7AXWdSxowb6k5ZQLORPHniXn
 +ccnVZIxJDfqiI1jCHdzB9IQjisfBpI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDAxNyBTYWx0ZWRfX8B3hJPcFTjBU
 CG9YMIJPYYYdcwvzzKkQBqN7ldfB8x1jPyRIvljtsHhM9PsHEhmZ8aPC9kc0ftv4DY0jxxU0uiB
 kh7lMAwZZDSKNOfavjpigzz2YlyPGY+9Invk5s3wkic4KqtXv9f7RXswQKKHXyCkK8TInwhbe7N
 dJYJ5Aq8GOVtqyZLl8nqSwOEZ7+6Z86F28vaeRMr7aTs49JJ3PMPQsJuZpkpaQgav/alLkdflO9
 /dpWUEMzHel9iLsRvDNpL4xw9t90lMtGx/ulaidQbAJATKPBZQBdHqLMd4NofcC19kDtSdjj/Cy
 NvaAysnaqKeFh6WV2obEnesV1JDPIuxcadVdOPrFDcReYZiILDJGFq7U7+e8jspZsOaok6aATnj
 0Hbg37TUEDnbEYGOsLRVYbFkB0FO0h1ZOmd7uWSPjKbdOQ6zSRpjf001nv6kj+pNm9z/wcOXmcb
 TTTSVlm1vHf/dS3qI/A==
X-Proofpoint-ORIG-GUID: U6iDqGp4rVsIkMfqSEbeRbhFskmYPUcc
X-Proofpoint-GUID: U6iDqGp4rVsIkMfqSEbeRbhFskmYPUcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_07,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200017
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

On 9/17/26 3:11 PM, Pierrick Bouvier wrote:
> This series fix tcg tests compilation with containers.
> It fixes SELinux hosts and dev container with rootless podman.
> 
> @Alex: it's based on the v5 series and can be applied on top of it.
> It can be added for the PR coming tomorrow.
> 
> Based-on: 20260917165602.3405537-1-alex.bennee@linaro.org
> [PATCH v5 00/17] testing: various docker clean-ups post meson tcg conversion (pre-PR)
> 
> Pierrick Bouvier (3):
>    tests/tcg/meson.build: fix host fs mount on SELinux enabled systems
>    tests/docker/docker.py: fix run command with $UID == 0
>    tests/docker/docker.py: do not add-current-user if $UID == 0
> 
>   tests/docker/docker.py | 16 +++++++++-------
>   tests/tcg/meson.build  |  2 ++
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 

This was merged into master (590eaa77847d40a2c837ab79d3fb3d2814c844ea).
With Alex series, plus this one, we should have fixed all the issues 
reported for tcg-tests meson migration.

Regards,
Pierrick

