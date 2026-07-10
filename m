Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF743C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 19:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiGpb-0006S0-9A; Fri, 10 Jul 2026 15:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiGpZ-0006Rs-W1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:24:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiGpX-0005w0-Qy
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 15:24:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH3iMa1361434
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cOB4apndEktIeqMxxECsFBW9RADdt9JOUD3HTMKwFTw=; b=KGKHvo5/JqDLILaz
 DrGe8TX5gkq90cFXU4gBonbhSS4WnL++u/27IRoBIehU5SR3vgUC8hKReHJYyWei
 fGo/2apGFAa2rRhEKtY8bd0wVx47yDThk11Q+FSK9xO5RyQXHpgid+rLvDNankmq
 awE3fl4XWq+VyYfHCmj9T0YwYQ/ltQeGaj3ee7pglRQNIFCVEOsZRrIqvUi4rMyL
 1NL/q2GyRlAqPo+6TahWusd8VvRLtVW7v8TerbX7yj4I5zj0eAEY8yI5tQZuTc2d
 5CYnoDUzn7SpMuw84GsicypckPuASpyuKdk8pBVvf908b55WFHpQE+ThhCQFesCm
 p/CA2A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc94cs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 19:24:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso124534a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783711448; x=1784316248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cOB4apndEktIeqMxxECsFBW9RADdt9JOUD3HTMKwFTw=;
 b=F3HxYNfUACKe/QZg15dhR2ImAa4k7YIFRuhJIvPPFrue0QA2Crcy34xo8BBTQcb4Ir
 xT5t67pWLTcNmA0Tz7HByVXh5E/WvUWYHh5KN07lP4kGPeYZYNT4eqhxiYI+9MLVrDiq
 Pz4gKCAOQzPK/GGXpxIfA2OxmX8Sj3bsDC/g94ZGJIgegQbUR9pFUkfUlxGUFAhMT/pB
 b4HEnEoXQUozA79IvUoLENJkDmdneKfflvbX4d5cfQdy+wSfhOjALRcoVx2Fx5wHaRwn
 kwZeJiLtJEG6ApjaHBx4OBVxXnNQu+a8U06Y10xxqIW6YFx5UOUR4aikcZAw/5JrNZBi
 9+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783711448; x=1784316248;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cOB4apndEktIeqMxxECsFBW9RADdt9JOUD3HTMKwFTw=;
 b=HiQFLoPnw9320KWhWJFNDY7DPEYXcHWY/XPMB0pZrs9NurxUUyr5Mhlo4pTcP9Aq+2
 VL2HRKo+NqA0SpbCGEWfg3xPXC1kHnFcH/qqzJpBIFJQ5jsigO0AxWl3kP1Gagld7moG
 4BYTWUJxfJ/yFgH2gn2HNoziiZHNwAhozXcNYu+4O72uzPwPmLBFuJNhnHgpYmRo2JQm
 uMQ6kTHLFqdri0B3JyTMsavQfbP3oOkugcsqbCSucRSJyQjauWSFXLkiguWVG/avlWTQ
 noEm2YvbDPuBQCrPCHtL3gNQlpSk/Vy2dKs+ptbwpmgVlKRPkkTkX2BE3Nrh946+c0aY
 L2Lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfQ8OIUVTFD5EfoXatVJgJBNJXSGAJyGTJPJZwCrOCVbA7c1VyL601N26fNYTPMSAeyP7533sMTCjH@nongnu.org
X-Gm-Message-State: AOJu0Ywv9MwkSHBWlCbWpEPQiL0EBUW82vCAFEwoCY7sY96yrNWpXtP+
 mhRqRqGwdZC2FwZgVQuVAyPv8WCawL90j5sxl+VpuVzmJeIUpriLeuWBr6kuGdWrBaACy/b9kZV
 ia53gj6Ak9ePbn5mO9BYbLBxv/F+W+aQaoU1aGdSMI2OI7uwlN3IBvtoLvw==
X-Gm-Gg: AfdE7ckcZfrp6XJRvZUBxuNpRbpdJU1Hntl8PWeoL8ZpiHlqutnQ5f59Dxy0bB+YBp/
 2USESV2Tnuww8dr5rGoQxISn4HMEpg6TEWtYwcARkSXvWrv30iSDiPAWIMu4d7YIL4r99sJNxoh
 8cg+MpJ1S25Nyu3DewOtEwmRF9JuPAdycztaqDPn4rrB/ySbVE6dW/9uSe8L6E53xM6AbifOdZO
 ZLFjGB+DII6cmZK46/BRQUmI8abLQBzAOkAxZX8wkr/uOvceGnnWynH0g4L5ftY/1gqCNSeC24X
 EeR5ceVBIgcMzkKn5uXassIH88wDGaU2x5Q0wP6t3J1DjD4kYAi8T668407z/bRsH9okmBqBEE7
 mOXnhSV0g/w/BllYVCZ0dMavSMh0nrKCpPujaQS1CE5aAG8BbSL1jlfae7pLezrF3wR2kbmpL/B
 Bs0os=
X-Received: by 2002:a05:6a21:9216:b0:3b7:aefe:4367 with SMTP id
 adf61e73a8af0-3c1102cf806mr395544637.33.1783711448305; 
 Fri, 10 Jul 2026 12:24:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:9216:b0:3b7:aefe:4367 with SMTP id
 adf61e73a8af0-3c1102cf806mr395517637.33.1783711447923; 
 Fri, 10 Jul 2026 12:24:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f72a6sm49798103eec.1.2026.07.10.12.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 12:24:07 -0700 (PDT)
Message-ID: <15185eec-4b19-465f-9269-21bf59567a2b@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 12:24:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/vm: update to FreeBSD 14.4 image
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
References: <20260710105833.84195-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260710105833.84195-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5NSBTYWx0ZWRfXzVRqU84SkcTR
 sC9uYDWbknlX+0DQLwhUDfMA5gGTNEtR5MknokGNTyz/RlpDWNhgUG7bd1AvGY8LlURX9LNDctU
 Aj2ILsJZY0SlDdJgwWp1GpBDmGjZn7Ci6JJ8AowO96t19xDltSZaHfW2Ob+OgWlYkh8uxxtuSfL
 /qKpKmdNfqXw4zSeCMvSxlw5H7UnS/7+bkAYAAZg6qNddZo4F3Hm6p26xnn5MTKp4YBvSdJDRBO
 KBV/nFV/WYMvyBo9OkYH7qmt4cGVNrPKWOA0J61BKyLGbs7SI9RHmvLBsZec6ZheiS72t+r0Vqd
 nr4j/LlRG5IvOso4NUCXAfLeOQBzsiS0iPYPOhSOVUkeG0OUANSMX+ygeGn7w5LBD/2UTGPcnNK
 gP8IVXDOi4hk9AzIw88DHbbZb3Ywq8KoP6i0iUJT5pETOaA5pozwmpIMY1AhkZqxFcMgiXmG/kv
 8GNkrbpStDKDcKbytAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5NSBTYWx0ZWRfX61iTPqRJl478
 j+smaBWwEIiPCohhWvH7+XF/5R/+I1Dw1ZO1muJiV3zW8KEx0AKZVP4gfIXNtwPSE9CwPXKNKF5
 Y8A35lD7mQ+wge7igmYtvhQ27IrSEBc=
X-Proofpoint-ORIG-GUID: 5NUAp1f_HLigOXrCnspBx3v4MSuwZa6s
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5146d9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6I5d2MoRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0tNhjLOszggVHpvFoHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 5NUAp1f_HLigOXrCnspBx3v4MSuwZa6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100195
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

On 7/10/2026 3:58 AM, Daniel P. Berrangé wrote:
> This avoids an interactive prompt that halts execution when
> attempting to run the FreeBSD tests due to outdated 14.3
> base image:
> 
>   `Bootstrapping pkg from pkg+https://pkg.FreeBSD.org/FreeBSD:14:amd64/quarterly, please wait...
>   Verifying signature with trusted certificate pkg.freebsd.org.2013102301... done
>   Installing pkg-2.6.2_1...
>   Newer FreeBSD version for package pkg:
>   To ignore this error set IGNORE_OSVERSION=yes
>   - package: 1404000
>   - running userland: 1403000
>   Ignore the mismatch and continue? [y/N]:
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/vm/freebsd | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

