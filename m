Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GfaROQpn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AyjzFPcs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqlA-0004On-2N; Fri, 30 Oct 2026 13:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMql7-0004OY-Vy
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:51:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMql6-0007hr-GZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:51:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERFvx2495116
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 71p35JrtfQDgZgY3R+JJGXI+hoGL1ka9R76eSa4aZFo=; b=GfaROQpnRYjFlOjl
 Gl5lKul5IHLm+AXwGW/LkHM4n4NJNklCQiwlbEqlbhJckifhrzg8MumzclXcIyyt
 tHgtxVq+z+QLpK+AwVYQaH+0OzigVGv+0kE4rKT4No3w2bShFiJ264DVG9xIZpW6
 6J5sGPRPXAwBLJqEiidYFekgQObBpCwFpe5wfuFz6XTo6Qap+2Q2DI4YPx+KlISy
 gzcBCYAHtWmpwDSK1mNy7EqZ1a0EzGlgs5aBRqLeaaIjLE5a97/RoKBmNTBKm8UA
 dJtZFhFtb0RNu8nNzOnSMKRjG5oYOclJPo9xoPetHySbtt6BkbiBW9yiS2gYhL5d
 P3Vcog==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4bdy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:51:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso4451805eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382678; x=1793987478; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=71p35JrtfQDgZgY3R+JJGXI+hoGL1ka9R76eSa4aZFo=;
 b=AyjzFPcsehPwC4xODxr0LypH9XA1hMfvfo+IADJubfc6oUgs+FzU3iSF9T2b6MufUD
 GydZNabFq1A/E/Yy9GVsBk5zW+tV+WdU+/9AmASY4k2Twg1sL6sgkJVRNh+a9RYQgDLl
 7KSPGjPbCrWEIOIe++caKH6n489lTg1KdRwWGGM2MxDvpBNO9WOVUk+JK51KEHKw1l7o
 m8Yi9q0HDz2tTqzo2h1kLroEkwWAcqc2yUFS1lXfj455pbUm2SRv9X9iA9EgQx6yrf/I
 t3kExlqO79uOPAZ2nJ+8CsFNLleiwJSwxndyXHmlI6wc+pM1Tz7vCWwbefv0LR/UHDRs
 V1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382678; x=1793987478;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=71p35JrtfQDgZgY3R+JJGXI+hoGL1ka9R76eSa4aZFo=;
 b=XAsP/TpVGi9Zi7wPyDwuyH39z59EvRXpA3sRvBvBefruDQ6nUcC/DcdgDcLRQXBkFx
 HgtdZT3LsNSJTMtsAH/EIakmECoe/V4BVhLZwzK+fUId4FSQ8OUkBH4689fCadxA3qhU
 SGoqzhAIOuYhpaxjgxBYpk2DXxtZP5lNVSey0sttoCDWRvlV06zquqrD/vNMv+PV8/YS
 lv1ePv2/ewAAKGs3Fej46ojFA6sO09/Yk5agk8yPKdgaVLzWxKYT2EzzShz1HVXhavp9
 UHgJ92pNffr0v0CgMrdwdaDO3fX5iz9Dxka8zPAlzEY74A4u/reRApAdVptXOJIxKQNf
 wRrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwO92Hn+dhOydjlvLkmUvdP3gn6VhCSVLVkKX3Dd/TS6VdJ1BaPkUbi7yZuFE67212DHFTXwBkuhWax@nongnu.org
X-Gm-Message-State: AFq9FYLQYO5cVsuJc+0TLgqZEVeZ1Khbna8Y7bUyjq/XVmVFe9zJBIpM
 2nNcvTYxIIl3Kc1+oGtGmFOmDKPM9IIiKjfFnkFGUdBbwiAR/ivIpw2EVKk9e0abHMVbuyLWnDY
 ZAHzxDlXC5U1wqfzFDI+p6fBHBbont0x9yB8v6EHz/0bIIwSqJ51v0/LOUg==
X-Gm-Gg: AYBFou1dqu0xYeBJZy9cmUGiAnKP9BUi7gAqQs8uV3xxB95TaZmNLASpFpAGKNFJDL5
 UcUKL1RDusGWUzOQ8Ptd6aeff1aEWVekfgXTsA5dTI0+fMIgry4phBujkh8SxbkwKz0dkB7gmal
 pEEsrT7Uc2xwFl1i2EmTuXl/vLnX5pG+4wedCgGL7OC2eaSKesXc6bIL1Z91zFrQH5BfrZOVlXa
 y7UBRQSNc7l3Drq87+IgORKmXzTm4TuWUu1ZNKWc4PNIqmINfX3ciibLCgrhcUVE/lGaK7DTZFd
 nQvDjFvnhgF1f3Zoex6vteVPpan/wPmUTmgdTvmKGShIn6MlizVSIiCrU7+cC3Ul1wjJ/2pJORK
 +q6rijbe1PETMBfM2WmsIEOiTLMz8iZW3JUW+gPdskn6gtZ0gJLrEFurry0XBXE2duNVGzEBlSv
 n3fonn/j6hgKhzTpiSiR8tGtsxLKtM/mhm269OO292ius=
X-Received: by 2002:a05:7300:e918:b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-36a4247d812mr4079742eec.40.1793382678064; 
 Fri, 30 Oct 2026 10:51:18 -0700 (PDT)
X-Received: by 2002:a05:7300:e918:b0:35c:de00:93d3 with SMTP id
 5a478bee46e88-36a4247d812mr4079706eec.40.1793382677439; 
 Fri, 30 Oct 2026 10:51:17 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6eabbsm9616027eec.24.2026.10.30.10.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:51:16 -0700 (PDT)
Message-ID: <8ba2dfb4-307c-499a-bf5e-9d6994da77e0@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:51:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] tests/tcg/mips64: Report Octeon test results with
 TAP
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20261030174856.98759-1-philmd@oss.qualcomm.com>
 <20261030174856.98759-4-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030174856.98759-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXyOo+HV4LJj+f
 uApxZdFY8Ncy1aXZcBd3RGN1IieXwDb2gMiki/F+wBiPZXKJqAYB3d21uFGPBF4ObbmVBjN6Lmr
 w5x7HGqicOIQwiW7qRZich34a8uScIUeX+OWvaEf+dJck8++ZoemdDo007wcl9YEr+WiXLNAGUS
 aybzqwV6+OEdvWfaRCcFhAUxP7c4ecK8+WTMgL9YcfdzVszn8vl+aW+vNo2yXIWapJ3ugEYckhC
 ZlFnXV0IkIHDP+Kb+oVDxXcVcZWKN4hZ58FG2KVmzmsQde1lvd9nvGqlBC0XRNGyxZQUQ8XAAWE
 6dF8e/1l/DKs+0ipW+MEB/wEAAiJbDwtehFb6PFiF1bVOocg8ROFKvUrml1cVStUGjzoW1ihUGa
 2jH8xvgT8JSZMdM25xvMe4OVfokt9AtYYMtv06S4rsMKfDExVWwCTWLGjfX+2QbJgMzQ/9yYXm8
 7JP1vrwXKl5QOYD5UzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX+oSR0I9JrFn1
 c8XQ/VEAYWdhIiXNc83SMrFzO8EPDHh1t/3nvdc/QpJV03RJL5iVEkM1VzSANnp9MTEFbadABVo
 7Dzq03yLCY155Ga6oiWDWHx3na1Fd14=
X-Proofpoint-ORIG-GUID: 8Uz4sA1KHSp12viI13-oO4EqOdy_ADcE
X-Proofpoint-GUID: 8Uz4sA1KHSp12viI13-oO4EqOdy_ADcE
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d917 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZHPL0eB4cbTO3u5cAfwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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

On 10/30/2026 9:48 AM, Philippe Mathieu-Daudé wrote:
> Replace assert() by TAP_CHECK(): one TAP line per check, so a
> failure no longer aborts the remaining ones. Call TAP_START()
> and return tap_done() from main(). Select the TAP protocol in
> the meson setup.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips64/octeon-insns.c | 65 +++++++++++++++++----------------
>  tests/tcg/mips64/meson.build    |  1 +
>  2 files changed, 34 insertions(+), 32 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

