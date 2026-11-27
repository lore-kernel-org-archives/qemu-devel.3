Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lv4GMMxR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rj68nUNa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzg9-0003ML-GG; Fri, 27 Nov 2026 12:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzfz-00038K-W5
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:24:01 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xWzfy-0006sj-3J
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:23:59 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARFpGgX2032596
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t/zV1n/+g6gXEniwhPwJyWyw3yfxNBEGeW/9XGMCnkg=; b=Lv4GMMxRJer5S9aM
 VKnx0Ma3PBoYr16NJF/4JnZkpLGXNi6NKDjVGJ6biKpwlsf31yjtSAQvxX6V4PHw
 /UgO8lDLrmBifiqmqARFXlj1Dg63/ZE7ztMv60qEdrj8rPPXnmxLxdu1L7JK7Rqw
 q7EhvnMdTsfqs0vqCeAsBDHpngimwYzIwlhYscyKr3Drq7MgfyQGFpsAbIrknK0e
 9Q1sRBjElQBdYLRe4+UmtATMpY55ZRSpZZuBLG+jxtAoHFabQYui7Z3TYCDG4doT
 nubJwN/mrj+6b+2emqteq9oF56s8+E9K6gY643FkHa8kJG8KQNXqiQN8Dw/ULyoj
 mHMQig==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3bhwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 17:23:56 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b588e4bd7fso3397667c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795800236; x=1796405036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/zV1n/+g6gXEniwhPwJyWyw3yfxNBEGeW/9XGMCnkg=;
 b=Rj68nUNawPLcWIep6Dx57+O8X7RFaf9iOvw8ukQ4l3e7D6N59NuhdYFCZzFjoB+Yd+
 CrPpRzcLbSBZnXzxFzHnigLqlpCMEIQ5XQY6WozxCpHjVT5B9sYdzeIwTUypCi8dlAX2
 EJDxx8l7Xhmrd0/kwfl3sY41GdnKZIbuWQuMLhRcLvbTH7+ET9y3KEqIOedHK3JRIRG0
 Knvs1Jaj8LiMfIX4N+KNZNbJz3lweX7ICaEnYl6aFJURvvPhUF5enuBHeVyELdhSXpbN
 ZhXjb7pc9Q/X/7MUOb8oN6AJmhvf8ytMwCSTzY7+vxyqJdm3cRm9S2ttrCoSTdAuaJ9R
 xfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795800236; x=1796405036;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t/zV1n/+g6gXEniwhPwJyWyw3yfxNBEGeW/9XGMCnkg=;
 b=ete89UzLaiCH7G2IDYofBncxJuK1fHS4eVgy3pGjD/oCsnHuS9anRSPTjavPoT0VAz
 qb/zaFCZgdbkTm335sVFkODQyAg8ugHybnvnFoknbq4T5rkqzgOXnYmg6a4mFizuWLBB
 U4zSjPAMrh+Mtg3lXTQT23i4noQVufZbuFvbWLLCj3cQQsM0spX3NC5GWLXh11GFciSC
 MVqNimXwEm9uGfcR0ums/wjMUAwyc9i6kdE6jmbck6hTNYo0Bqwmsx7dv0p32JVDzFmz
 jLD0orDlEloQe9DimsAYEVdi81l48aLLh9I85Tsxz8IJmsLWkmUcRe8K1qwBuZ/v3TOx
 qHTw==
X-Forwarded-Encrypted: i=1;
 AL+hErHHWPH/SOKpxhixorNLEBqStrBBECZ9B0jJ7EawcJFJxmNbH0cBMfmzJa8dM4WJTzkQyx/xewVFhXLl@nongnu.org
X-Gm-Message-State: APuU4Z+QUlErakyresF60EkB9kBZ3JY1l0QouFJ5BSNXVWn2pCauMOi4
 mT5+aXRMOKhxyjk/XdrAMFFbOrnamYunog+vec6p5DPXE3OQfXrZ7cMGSX0OQClWPnZwaRNgkQ3
 V4KD1+pmHkhR0QxohZsL5SnSylkue8eKZZhqkJY51jIneC73UPmbdKs8raw==
X-Gm-Gg: AZFdTZerpNZPB8P2hBQqq+/0vlIlw8Mr+/0yAw6X0rGEkaGJDwor92PIvh2RFr2zypP
 QEeNbfJge+vJRpQyqbBW0z+5nEReFIeVa90APZUa3SzCyrjEm3TD++IRIqYhOdq3leR0bqiV6BZ
 fIBX26m18fbwPYs+/2NVy8qmW74nvq7aCutDhGp3yC5XIxpxjKYUscfo/NPPTOQIaTwerbRflnN
 QsZI48ZQSMNxmqzKy3pTH+tGi8kxb0FaXqGTmcCb+WiEAy+kFeCkaCH+uqbN5sE+wirWwN37mci
 btF+C6mDI+6cYBcLPf9lk/M9Ei5XZ7cQRzBY++8lSYey+Wi4yS+Kk6WXrJWymQ/pz9Q9FUT7hT5
 gBFpnVDHq98DtMhO8S75ikjVeltClMX/cU+wKu1aRyjFNQNpI2Nopz5mvbyYVrXprYn4SkPpN51
 V84rT2fn9GqmiuTv2eTcmB1wkaV3SzDoVtRBrW6hmH1VE=
X-Received: by 2002:a05:701b:250c:b0:1b2:557a:aa12 with SMTP id
 a92af1059eb24-1b5568b35b5mr21369533c88.15.1795800235706; 
 Fri, 27 Nov 2026 09:23:55 -0800 (PST)
X-Received: by 2002:a05:701b:250c:b0:1b2:557a:aa12 with SMTP id
 a92af1059eb24-1b5568b35b5mr21369511c88.15.1795800235141; 
 Fri, 27 Nov 2026 09:23:55 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm57144143c88.2.2026.11.27.09.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:23:54 -0800 (PST)
Message-ID: <7bb08dc8-4f5d-419b-b8b6-17c07ef637f9@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 09:23:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 2/3] target/hexagon: implement PMU
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261126183812.1366883-1-brian.cain@oss.qualcomm.com>
 <20261126183812.1366883-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261126183812.1366883-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b09bcac cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AdHQGpW_irzzI2bWimcA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: RSNss0htGIgGJ0uAH8puXjoJxQEmGssY
X-Proofpoint-ORIG-GUID: RSNss0htGIgGJ0uAH8puXjoJxQEmGssY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX/36l73neMgSy
 fU3mv3JzPJ/ZuWt4/GiPtrTAC2lSOaGkNPzixuHf9RbF9SGizU2vmSUi7jDaE51CYZINrussEgM
 qWHcYP7UfjcPjdOCQ7j10tMGoLthJgpFhopAyhoi82CsxrUGVZfVvdCAPcz3mf0ATgWaS5HR4y3
 cjBzXei72dUsyl9zdPdiAsnPCHAL5GjLIwttOeBbxl0qfc5p2zc3SxkPqTc90H6juTeIEInNHn/
 1zRkLjCzHPvKXVBTJY+iCJZ+tqu9v+FTsi2BWaWQBNEXgZyjAF7jVmsPD08ok08ZU+DuHYF4q/K
 SSya+78sq6K3ZQYGEAy/xRRaoatKMbDHmvBuT4JSlzQU6lwKNFqxycS0yu1qw1LfOhb/+JC6cJ+
 7uYggpuFz3usIM42NaoeAKgl3Ww3qs7wgnjzYeC5G7hxt+RHZkjmWRRDavCb5S/CsT4J2Vmjjwc
 TKiH7OV16ItbmeP9kOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2OSBTYWx0ZWRfX1Mv5IOkoJRSu
 W6oddLmM4r1Y/b6AmsZrScqYUTYWA95j9XqZrJIuPQcehNJDnZu8Y357RFFYoN+zguaKV1ZF6mo
 /wusAHm0EdqBlr5PZfK3RVxc//KhFtU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
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
> Add a Hexagon PMU with event counters.
> 
> Counting is gated by SYSCFG.PM and covers the events from packet decode
> and commit: packet, load/store and HVX/HLX counts.  Other events are
> accepted and logged as unimplemented.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h        |   1 +
>  include/hw/hexagon/hexagon_pmu.h    |  51 +++++
>  target/hexagon/cpu.h                |  36 +++-
>  target/hexagon/cpu_helper.h         |   3 +
>  target/hexagon/helper.h             |   1 +
>  target/hexagon/hex_regs.h           |  20 +-
>  target/hexagon/pmu.h                | 200 ++++++++++++++++++++
>  target/hexagon/translate.h          |  35 ++++
>  target/hexagon/reg_fields_def.h.inc |  21 +++
>  hw/hexagon/hex-subsys.c             |  14 ++
>  hw/hexagon/hexagon_globalreg.c      |  23 ++-
>  hw/hexagon/hexagon_pmu.c            | 113 +++++++++++
>  target/hexagon/cpu.c                |  27 ++-
>  target/hexagon/cpu_helper.c         | 280 +++++++++++++++++++++++++++-
>  target/hexagon/gdbstub.c            |   6 +-
>  target/hexagon/genptr.c             |  23 +++
>  target/hexagon/machine.c            |  40 +++-
>  target/hexagon/op_helper.c          |  22 +++
>  target/hexagon/translate.c          | 209 +++++++++++++++++++++
>  gdbstub/gdb-xml/hexagon-sys.xml     |  79 ++++----
>  hw/hexagon/meson.build              |   1 +
>  21 files changed, 1153 insertions(+), 52 deletions(-)
>  create mode 100644 include/hw/hexagon/hexagon_pmu.h
>  create mode 100644 target/hexagon/pmu.h
>  create mode 100644 hw/hexagon/hexagon_pmu.c
> 

This patch needs to be split up.

Regards,
Pierrick

