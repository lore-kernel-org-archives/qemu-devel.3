Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C955ECD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNw52-0002iK-TZ; Fri, 15 May 2026 13:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw4Y-0002PA-Qx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:11:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNw4W-0003YQ-Ur
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:11:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGn41c2691746
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CTqlng+Re6V1OWyLhgwh/Jt9ychNxPv3L7tYy5+m6H8=; b=ehfx7WFudJIzWZO4
 Yk/R7C43ar4NXTTOeUVSoJRQaYr0EqMJEQIQHenajP6Mn2gY5dTbCfpK2HywP8tG
 BXPZ7dGDnHk9jp119BL1LrhtKLTcnZXhSUpprXXVR48pSZNfIlwloFi3cprokw/A
 awxKX9KqmnBZMqcR1v7TSqNDD9SPKE8SK3XIuSpYBunQDD60KNqFI0v484f3QAYz
 sWYx3Fip5ePsQ2V4GMmELG4DvoGFBbRCNxXI0JLiLCMqvw0sN6IxWdkdNUD4tbUl
 5NTeX6nfI//9tgPfk9sYypCL48RYDwuoRGmaKpkNy9iioKkMPAllkBTl9ci6HnSi
 6vAHiQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67ber2fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:11:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f3eb8f3419so221411eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778865094; x=1779469894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CTqlng+Re6V1OWyLhgwh/Jt9ychNxPv3L7tYy5+m6H8=;
 b=XxAmRGmtL3T3xBi9fcTrt06yivdfaBUfZIvSLxd4hxyVouYxuwrx4JTn+ywVS4yJFv
 gBO3G8vJxx5MxcCC0gqruV7g5ZgG1LC8ZR4vcPetvp5lkKn7NaRyzvkQ3WaocUINWOFO
 F1LCc8B1hlNjoBxA59EkzdShjqvlj7t3jeNZMF47jwzv208Epa3he8m0QO7t4yIJ0wJ2
 R/YaYVa5B9B0rbOTdmbM3lKsuFJfuvfmxBxCmhggKK6x+OyXUihDDSGZJrNUWmzkRAWb
 8lwJvwjoR77jzlwGZq4Obxcd/+cghtxMdJO8SzKRuixXF9/z2DmWmkd+A798DgQapx8x
 EbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778865094; x=1779469894;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CTqlng+Re6V1OWyLhgwh/Jt9ychNxPv3L7tYy5+m6H8=;
 b=o8Y2P8nPqWyKddy0yhcpHC78bX/rRLEuTzM5drWsI3hA9rncoNRBhoQGdwdqOJJ1CA
 fJPLVZE/Gi+sIdzC/ySGObEhW1sYuqI2McokzaKz5+WlCP1gv1sGtIMSBjG6l5rvhk1h
 8AbH5JDMQaHIKzFV5kDCbWqVFzNicBQfpZ9So/sC1bYXAMiqWWNcWnS3KpUSuZ+U/Sm+
 8s6hiTJUtDAX8CFU1MlcevGgs2kKENQSvAHgTYqMIv4ZmvTq7tPbRE+4BFWBWlpLEW/o
 wIidPfERTOWEgbhJ6k/kOE1ieEl/hCBSfdvdLHV7YdfwxgVDgpxb+Le1r54DdrPM4/k7
 30Rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YWYykY6XD0mlerJ/XCjk8hTS+ccyS5f0JtqV6FA2xw6PyK4CyeOMDodaFa9irIm4Rq8wlDb3sCgiN@nongnu.org
X-Gm-Message-State: AOJu0YzG5TtTCmZvGjvYOS5b6a+ZlCzUaeGxJU9uX8LddXhZCmAQdWRP
 1zppf4ft+3MlyiUY5ecD3hH8zXRmRqwpTXQMAQnOxE7RCchnfcn6wYswQ54axDRz8zJdwzDavKi
 vezP2QmcjAix3XBEhAZUz78/xvybKeTHql/4BLBZb0EYRyy/Eb/cpuNsFzw==
X-Gm-Gg: Acq92OGQZ5Z48EOEj5XXDyku4T1Oft647j2uwndi/ncg24xrAGfNiZDcOhXt/0oyFpU
 8pezigBambFcnFMZsr+8mKR62/nTd8J2v6KKTC0/z8KoRMFjbgOxA0H+b+QZ+JH4Mt/BCJNjfEM
 4p8nv7jAWBMzUOjbE7ue1s5qCCFDz3jJI9Le0Xejk9wRCSjGlIKuxPuWxlBS5rgEQ7NK0vvuF3c
 1NnHg6RADyVrvboKUeUwcZRW2HEugQxSptqqE9aLTHKvtvBeZvhCwKeOeRQhzzHg3gYrc8w9VVc
 uBW04QKHdMDHBXvTkFp/cbkgBxjoaHxNXHo6WtY7WEjxvqRot1LfQ5dn05NkNVpItwVkIHPrUkw
 Ya327I3CCrbD2Y3w63ui2DBm/VFHffNfwBpHl1MC8+jT7eStcYRq56airHVpGFUnChOd7G25LGr
 Q/U2v35BqfSPIxPQ==
X-Received: by 2002:a05:7301:3f0a:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-303982be43emr2435910eec.14.1778865094086; 
 Fri, 15 May 2026 10:11:34 -0700 (PDT)
X-Received: by 2002:a05:7301:3f0a:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-303982be43emr2435881eec.14.1778865093529; 
 Fri, 15 May 2026 10:11:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30294500726sm7206849eec.10.2026.05.15.10.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:11:33 -0700 (PDT)
Message-ID: <281a0267-b6f5-4834-86b1-78d2143caf5c@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:11:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/20] target/arm: Only set %kvm_target when KVM is
 enabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JVIf1bR8hx-x-6aI9ld6cGHOL8QZoPZu
X-Proofpoint-ORIG-GUID: JVIf1bR8hx-x-6aI9ld6cGHOL8QZoPZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX42oKdv3kEz/W
 rCiQ3H46vjQD/PBw1zlza+zNDW6mkCZ8vl10gmoBgQg4S/vxNKsP7t5lv50OvxpSvovos5fbsHj
 G6xkSsVXELpreUL/nkuI7QWXCt57cnr7w9ID+9/3k1giOwpIPsHdi8McwH8ZAf7ibQZ7CsYMkuI
 FALGYWKO83j7YMjz0LBAqTDKBncBwoCCiN6cShMlf2JUJDELgZa84Y2wlKsAZ2bJMi+Ta6NhPxo
 R2uGyLLIO2x7bUR/XdjdnN7Rpx4pSopNNZZVe8ecq6wH9pvMSB7PqU/8U7vpqDubt7zShkm7WSV
 PqVemJay2f9BoTRHe1TBdOsJotGr3biq8z2FXgmmQSRJr0OGanC9mppz7v5fTumzE1j0bWASJeI
 kBv+wkQyv9AfPr4HgYKnpjeuNxND6htpFUZnlWgk06vOsQ/orAwVGiu3ANq3KoVy1HorFMY6CQT
 VPoaxS3iSYc17qw+alA==
X-Authority-Analysis: v=2.4 cv=IrUutr/g c=1 sm=1 tr=0 ts=6a0753c7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=HdABU3Qx0y_7D81ylAIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OtGS-68oIGAA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/arm/cpu64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

