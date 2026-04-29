Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3214FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDsP-00016E-Q8; Wed, 29 Apr 2026 18:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDsM-0000zb-KA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDsL-0007i3-3o
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:59:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbMvv1809077
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rnBp9KJTLWqVJ2q6mDzfDBMbkFIvplkriyMeXB3K4U0=; b=e9eN0k7UEGlhZdfV
 k55pRkeQdwufkuRZjTOVMQerT0iVLsWxXs3fnZnvQVFYth5b4A6Psy2kuWVuEinG
 mnsAsUwXDD72cbBmG4QuO0YjE9/wdybvO0hpLvM4b4xZG/AhkW4wHZIvULznbY6e
 G/K8D2gEjVJ9DVs4cBpNpmAkT+wRjYaIoMqxdRIEpl2uTIaZtbVGHq6WNfJtj02G
 mdZbzejMQdxQCLxC82uODl9Jg2WW2EXrZJaHQm7aEk1tqeH/5Iv0bJeu50Wkqr/E
 qxFzVb81zD9aNzYAh9i47xyvtHUTYZ+HwikvDEtnZDZQwzwAIFVKF4gSa8QcpM0S
 NajKvQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6ta6vu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:59:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdd327d970so248544eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503563; x=1778108363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnBp9KJTLWqVJ2q6mDzfDBMbkFIvplkriyMeXB3K4U0=;
 b=SIYAZ8E/kxIp2LsxkYy3hFagnd8RxRHB9YBPSExcH5XYI4xXetOZxUjJ9+eL1R4ZUZ
 QLLqqv0TtXFY5ZVxKWX+Elf1LQWwogogZedogjywc5t/j0fCmhhW8LFIJK7gP1ATppNa
 0diOq9dQLWDSPpw0+JUbtxYgfgQv8GQY0+efFVzeSqdIKjOzXneKJAL13r8ixY4zxqHJ
 dFMg8t9wEghaN+HzD/N4m4vg4qatHM6JSqrlTculpSSTujpKpsP3+vRclWz3xCFXNm6f
 TZLANH1nXhSl9ZW6yB8wK76+60gTwY6Zq6kSG0w6DTffsB4U99JttmpWQAB8O0MlP6/B
 /mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503563; x=1778108363;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnBp9KJTLWqVJ2q6mDzfDBMbkFIvplkriyMeXB3K4U0=;
 b=LcWySLI7Q2dRxvBEzqWAERgPsDQlh0+P/Lr7nbGQFWCxSdPyzfBMfjFFFx15lST4Pa
 yEn9+K2hIeUQ8cB5OX6H246MT6ZOfOc26cHB8kpKToFZKYuOjYdIhimN8lhSg6PfXtoQ
 U48Oy3ll7osuKQnIDrTX32mKooh9LuLe+3YRYkIfrGEubgWSIN5X4SE2fA7u7vOFOBfe
 JgdcGTtfn/pjiq6WNg6hHn55wwNaQInaBqgUmDIXn2JhN+4tCbO346kVORzr3kmSreFd
 lZXbG8IjYIy/m3Z69tWelslf0/ejpI22uPdgBohHcmOmSUchNa0OdVOAZRd+v2AJVoAU
 ieRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aBi6afAVueARAKCQUl4SO5FaPE+pbf+Zitcxu+TjMFIMcNgaZZFk0TUp24VMqLxaWW0Osdbxj15K6@nongnu.org
X-Gm-Message-State: AOJu0YzQIKiTE0zdgRvoRpifFaziotYfMvVUeksgxOAOrsLhSvDne8Nw
 H8g+GSWs2UZxWcLijqBU7Ridx9zoHzZ70b5v3wvFATp4dDRQW4vkrwJMCJ+fD29Y345sdidXKPp
 R1OEdz/mPokSQy0OTVA99JrsxApOpaE4uu8Ien2ViaigFkRXoRWehp1IVJQ==
X-Gm-Gg: AeBDieuY5P2MzdVX0y135M4Tq6JYHXUhJWb8lOc4VhUpG3+dZ4ZllZZPuPft6R5HAA/
 hs4BRBnXvM747kFfKiQ4m/QpJKg0OonjSoHlS/VVPRC2wNpd7PCoLytgGrRHMLWvfr4VjJDF4lV
 qISY6jyAas4mszOmPraeHUfbf0IiUbCZxUCkl5m/uRao79QbWO4RbvzEXWNqQefgXEc41DwAY15
 wGgZEcbi0a+5s3JTuDFWGq+l/jfoc9B1erOwLPCO4chkIOewElR39U+qFMEiumOBdygPof6EuhH
 YJwsBu7LgIQIXmpzD37FG+e5FBAQWpdqn7gARTr+2vr362FWYnWoz9J58x5Fqn7QbPNW8djzGCx
 mQ6ZUglxfMPUWSaWEm5OAgkxx5JthE1hN/UlTp7lkAAezKflW8vpMkpge7jDN15FH+gWo10X9Fc
 HpW1rQ4J4n1WA0JyPE/OtLxpxn
X-Received: by 2002:a05:7022:698a:b0:12c:6ebe:b458 with SMTP id
 a92af1059eb24-12decc2eebamr31071c88.17.1777503563081; 
 Wed, 29 Apr 2026 15:59:23 -0700 (PDT)
X-Received: by 2002:a05:7022:698a:b0:12c:6ebe:b458 with SMTP id
 a92af1059eb24-12decc2eebamr31058c88.17.1777503562581; 
 Wed, 29 Apr 2026 15:59:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3216e81sm5940695c88.4.2026.04.29.15.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:59:22 -0700 (PDT)
Message-ID: <52ac6d20-2fc5-4684-858d-8a28caf558a7@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:59:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] bsd-user: Add FreeBSD ioctl command table
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>, Alexander Kabaev <kan@FreeBSD.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-8-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-8-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ea4jMFLf23xOd3gn9DDsTDmzl5bk4zkT
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f28d4b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=nT16C9J9BsPuNhUfBLwA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-ORIG-GUID: ea4jMFLf23xOd3gn9DDsTDmzl5bk4zkT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfX5HhgBkSYYzKh
 rTaHzSmHqsoTpXmLa4PmZDg6Ct1vC82lVbMQR0SipxKZ2MU9KvmPTUo6dE6PHaD4d4BsdaWmW8S
 tn7h1U3kxe/9Rn5F4L/cktSdRSGH89PlevMcEGVGIlixCm39nzM3BrSewQw57avhMSBpPDFAYb9
 BKknPCxSPoi7t/1gB3ChqFacfUoV4Hfz5TdVsRuX+UsSh2Pt1V6rhOu/BhHn+HKXWYbCh4rNok9
 wPuMPvKRYURW7tVnwJoGU1U8rHjIGanVbjHNt/APJeJIUf/gfMElkMYCPnen6m30WxtD085s11R
 jGZaFbfU9BpUz37C2dBjtIXi7oZf2kcOxhjovNx/QI0F45T3L29fw4WFKxtdax/+TqlofFfhcS2
 WluUXxn1gTRbJXGr9TSni8UHKhJKa9ANmSNb0tZY8JckuzY4xR22ZlUG35DTDXmJV/23MmLgrKk
 tvSpPP4ecKTA6zK002Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add os-ioctl-cmds.h containing the complete ioctl command table
> mapping TARGET_* ioctl commands to their handlers. Uses IOCTL and
> IOCTL_SPECIAL macros for table generation.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/os-ioctl-cmds.h | 151 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

