Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E1606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gcg6JgTf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ATrkBaIh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Uo-0004he-HS; Mon, 16 Nov 2026 16:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Un-0004d0-EB
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Ul-0003A4-QZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:44:13 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJemTn2727621
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3cM5d7qWvpGY/+UeEPyGUQgl15bMoOI+kYsjUoJYy6c=; b=Gcg6JgTfm1YhMbC5
 E650nflpUGwwnMzjmYaWtkVKfp5ec4uTOfZ5+3WUKB81gn5Pp4BEDEeSFzhuq+cr
 z4trx5dMGFZrNbQ9Pabt9u3bwt9x5UduILGtc2bGCFMLvA1V+wYd58TP8SeBX5xN
 XEiAThzMhHdXVz6sNCdfv0DG7s7+RJgW1VWiQRqgpLAzdIuabv2YREZbh+Tear1R
 Ug888VFp0U2CvcF16VhnSIHAlzcsXqLuz1gbmsY+C9ESu3elq208dh95Kqr7eaoK
 QBRh/3SMT396RzUtCZ28iwqnYy0Lye/BwGoH3CsLAF/aP2MYDoSBcOpQssrqLPOA
 lhCK9Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regja8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:44:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b25d977b91so373265c88.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865449; x=1795470249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3cM5d7qWvpGY/+UeEPyGUQgl15bMoOI+kYsjUoJYy6c=;
 b=ATrkBaIhWTJZKAQ7gGxoWQIRZRIsI+vFb/XPl+gguhxCkCmRtCCjwTeuFESSd7JZ29
 6k9dyoKUfHStFR1DBs7Sk56l35uTLgh7PloabWNShgFLA3nXUkESORhoVckserDgF3xM
 j5CS10K7YcWWUNthjuJKTIlzSrErVnBXiRj4DMHz8A/wxePqFkDOVI/rMwarZRG7hyej
 Hmhk3YYENXIxYxN4nnWmg7uKBSSl1gwqgokfnlp1sZiOHjPtZsVuG6487Yp+qWBegSVw
 cI5g+3MaVXtpn7bwh4sB9GF9eN5eaV190/MXJyWfpDVTMqBTq/I0F9yGUVBiQ3UmPFXG
 DSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865449; x=1795470249;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3cM5d7qWvpGY/+UeEPyGUQgl15bMoOI+kYsjUoJYy6c=;
 b=lPmOB+DsQMcTwf8xLDxYdSIIbodtZkB3PYjJv9gz2lUQJVjUhWuBkYNiMhoOvQWsNO
 NDf2um6lRRzJxIP5UCVtEdyknWvIMrCms40HHsNL67EWP7DqNwIAc8S+6U5e1qIdy6+e
 yNJUhV7qZjxMTLQepv5WcTKz312n4FNaa916hUPHT4PKt8malX07b4w7R6c1lkUQVbJm
 8O6dPW18Mcn589/U/+uBJsOa3PyZoGVTApCFhhRw+ARgjI5YVZxOy/y7szsX9TUpBFZr
 Z6zV1QKP/fEI9SD98pIo6R3Dd5IfWUpfzsYZ37J3GC4h4+1IcmQwqycxriEFYIgHcsiM
 +dmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGRBVa3R8xsoI9mnNNnhgQ9YMiHNowMNngEbXk9ZZ53pvW+zVw+317zGKmM0tVMc089QjC/SXc3F9Qh@nongnu.org
X-Gm-Message-State: APuU4Z9ECKbwBB0SKSDHNiHInC+b6Jb38hxTK0S9DIaW+QLpFk7oTt8X
 O7ln9FvJvArKASnnMrjPwtLJ0UXcBAk9vIWHcgRHaxpbaFUw3RDYYVO/vbJAH+7OVDJLr5Tp2pY
 +JaMP07ouLIg70Vwfitbrpqpx3YGbj1uBzM8lMRw5dgAHOuiSW7CKiY4Quw==
X-Gm-Gg: AYBFou17rDqEH5TXgdiYtWR+YttBr5m3GGJg1hLqV/pybXJqNSa7Sxq3CxoMtHdj/5G
 HEuG9n0sE2hnd7SqUn4HiSqB3lqDW9PRNLJ3MhrcwJevr3h+snUN4/SfCjUfCP+xJXgFba1ZmDb
 g9x6VXzmtbY9U6lFrO3SKiSS29FzRqzvfqAqdlREjOt9dOCDUwTONdWSuC5nywcnGBJmhuc+GK7
 TTPnfXjd/BDBXSXbLoqpdsFcuy6a6mCKhgBet8EQXCmGlCTwIY4CNMcGUu3GH41UD1i9d0E6p6S
 ZjSM9ge0mae7ppD24M8INQgPdwPKn7l/eiqd+OHSAxXwdAVyqflyjHrA9s+xPaQgdlekZyaLN0q
 Ybzn3CdtAK8aXasq5GcmhWsok1AK6vlPSZap/LayrUu9XRSGDZzYJpe59vjznR3i7ZJ04dGf9Bf
 tPIbws5zKu2T5OQklPW/KXhRTWp6qlk1zvM+iJ0a1HMYc=
X-Received: by 2002:a05:7022:b0c7:b0:1a0:5c85:d1b3 with SMTP id
 a92af1059eb24-1b50314c611mr10341342c88.43.1794865448977; 
 Mon, 16 Nov 2026 13:44:08 -0800 (PST)
X-Received: by 2002:a05:7022:b0c7:b0:1a0:5c85:d1b3 with SMTP id
 a92af1059eb24-1b50314c611mr10341319c88.43.1794865448347; 
 Mon, 16 Nov 2026 13:44:08 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b524049e0asm15520160c88.4.2026.11.16.13.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:44:07 -0800 (PST)
Message-ID: <18fd2b1f-d2a9-4303-8472-cee92e9f5a0c@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:44:06 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/48] Revert "target/riscv/kvm: restrict
 kvm-accel-riscv-cpu to riscv targets"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-44-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-44-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX2Vhie1nRc4ww
 I6udUi938dd7YhLHhM7cjWUSbQRSohZmM+fG4poU544V/NdK7X0DmSeAS5qD5DOLbBsmkUcAKW0
 N0IeX3lQDfjZv5bLrOoJUxbtAT9wtmw=
X-Proofpoint-ORIG-GUID: LvH4rkBDJddRxi2AARZXAThDaF64Dt9-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX8VgvksGMr9Wk
 1Rc3yGN0HfnBwJXUxJwEMk6AvkoiQ23GB0ghblODgN+ZUKnDGfXd9mSKGEKeYQ/L/yeRTYsU4Wb
 v6SWQXkOdsYsw9vVOU+lY24qO9JTENmZfQluwGgg9E0/Cs37NiEG+nwwPEYhNOer9/OHLjHv29O
 e1q0dc4idoG7kFNJcjMeC6QaKSfq4/TheyhKUZX8OZNFU/i+ob/DLZWFrDE+8dNAKIIKxOyXMjM
 7mXHY9oZ6hobed6tUh9QFixxdusvg3VkhvCgiqQw6XNVbHohNo4XMmXL8aIG32aWNoWSmo56CTI
 kJ0FRCkCxJ134DS1SIg+ATceJz5VW44akpw3rZzEqVDoU1iiet81S+Zd3L9Lgrct5t3ts/sRpuq
 XMwoy4n8bceGG0IaBd0L2vxfEmp3rpgzaueLYq6nWQF9otv+y6skUECE0B6sjqwfXLy6Yd9P/lQ
 CMcDZutGWhKj8YxUOlg==
X-Proofpoint-GUID: LvH4rkBDJddRxi2AARZXAThDaF64Dt9-
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb7929 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EnuhjQ2chKAxP1XGzAcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> This reverts commit 2d3e6b4003d5380c245ce8ffac4b8866f6d10a33.
> 
> The conditional registration is no longer required since the
> base class is now using a target independent name.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

