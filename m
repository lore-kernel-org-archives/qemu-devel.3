Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE13606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sq4KC2mS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VYVjMjLp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRvl-0003iY-Vb; Mon, 26 Oct 2026 17:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvk-0003gC-GT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvj-0005QH-2i
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoKwE488534
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q/bxOOZXi2ZeYkV2rR4lqZxGT9Qy7ntx1C4Wje0vxNQ=; b=Sq4KC2mSE5FCMlJl
 DKfisIEDfFETJSirzgUqS8eKNb+EWXu+rJ45jQXvW6L6AykOUNL5Jba+EHGUM6gb
 Y+i+clU/68f4/ODUU3tTJJ1kBM3SUUPZFgdwhmEG9mhUh9ezjJdL0ZL3PYSFTgtI
 o+Iy02xldy3K1wSGWI1mUy+G/NP5q/H1/x9P3iWbqIY87TQZ6heQbm7azBl1fH3o
 DnB5ZoC5SBzFHKrJqFFPfy4Vs51dW2crEOt5WoH7VBW+ADORY520Y3zzGq12qP5U
 HzvF0dTXaxsB9vZ6TLr76tkH7y7JmZWSie+6tlM9VWdSPMn0P6GhwmKbA8SM0CD+
 jY7gqA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf2gqs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso3103280eec.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048909; x=1793653709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q/bxOOZXi2ZeYkV2rR4lqZxGT9Qy7ntx1C4Wje0vxNQ=;
 b=VYVjMjLpBFVhRCjUgS58EJbGPX1ocv6956o59yAq5ZkyfUyCsHnIj3QsViMOt0kzlI
 3WkNCD182/u1QKwpjEM7Ijzv7tdVeOpGxVNqOtqMlmv7784a7oAbpcO1YKPY2QxtaIax
 2ienY4mw6PT2N++lvcuvnyqh2ItWJ0icDrDCtzsQ3/cnbdRrM9Sgr+ZVYofG4+5LsRtH
 nMhvUeD8EpL0HNCbwLE84goBPvi9/TgbsQKwJwNgflyzHaZCoLGecNqkQqBus+a2AqCG
 Zw/IFz6s5+5fP2xIkF4V1bH0BD1ouBvNPz7EV+scUNkpaGsAroVro4lL0lbxOeMtjKse
 KB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048909; x=1793653709;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q/bxOOZXi2ZeYkV2rR4lqZxGT9Qy7ntx1C4Wje0vxNQ=;
 b=etXoMadZ2RJTajKdLXUEwt78FZNYLMqZuJuwimEMmmgA2Rvd4xd2nhIIpm2h9AOCtc
 j/0DnOtEG1a/Ab+gCPvd30U+JjoNsUMMqRZYUnsfgXV+LAL0DUI0MGHHTP31zoX7ZrRL
 5DE3VKrMg4LBWBe3K4HYHKH4uFH/nD8Cb5e8iAE/2xoBZ0Pq4cZxLwfRej9v3qA7+Q6C
 y+hkNc1ZXQzkoXc6QseWtuJgJlmWWVl7ZxFTE3DV8ZjPOcn/yupP5Z0uw3Hz1ahrKGqR
 HQ5zthjT4DLVcI7xKBOSLUunnFt/Mia66qEKWzHmDZaiZr20WTxvLVceas+cE8QpaP4V
 BUPg==
X-Gm-Message-State: AFq9FYILH0AnIIruWrBq+2yJrdSvfKfooedROPkssAif9op+ELjmretv
 0RLnHCmk/leWqapAd4/C9BFf9QBJ6i9CmrNokRC+0R4bNghonRWPtggs61orV+jLQHri6pofhTe
 ERaSotyqBhZ3n0MstP8MDhzdbY/VDyVILASU8GfcDGyxT7D83fHFz7GlEO1y4ikeuaQ==
X-Gm-Gg: AYBFou0rvyxqAHpjK65VkkBCHO94vHWZ+GgdMtoYxPOdEIOvzsDO0lymCciKSH9g88N
 Bog3L/GYz3HzikeHaiUpCH/2RePEdcavIq5axDVyCARJcRsdk7a7+NBRDUeHhxKpi1XJ7BSptB2
 qpSFP0iZfVUQrb9DDBfnK6RG9Yn9U8PLH/idzSuCCje32mRmH8tz586BR6htohs6HD/1uN6nXSl
 WMnGpIXJmFqmaY3PbYZZePrsNLDRbngZGSIUzpcxF2QV3PAVYzM1P2tjUlQ5efmuqRXy9tNdYiS
 KHJNkGXi+5OxI7Rtxkj6ACGGzPyyqk19v2ke/Z9K5o/3LLl/b5+T/kXVF8HjfGYYhjSsQzpqbp/
 wCZIYc25dLcB1PArWgQEnZmbnbdK15GvFqj8ybbuc+c9sqeC+YxkNId+eFQf8StaEKV0JVA==
X-Received: by 2002:a05:7300:d217:b0:356:b370:a0ee with SMTP id
 5a478bee46e88-369e8474b86mr12358461eec.20.1793048908861; 
 Mon, 26 Oct 2026 14:08:28 -0700 (PDT)
X-Received: by 2002:a05:7300:d217:b0:356:b370:a0ee with SMTP id
 5a478bee46e88-369e8474b86mr12358431eec.20.1793048908306; 
 Mon, 26 Oct 2026 14:08:28 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369f44bd644sm19512901eec.15.2026.10.26.14.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 14:08:27 -0700 (PDT)
Message-ID: <d663622b-44ec-47bf-9fdf-bb3509568ef8@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:08:26 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] releases: build and run any QEMU release easily!
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, 
 mjt@tls.msk.ru, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>
References: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfXybEbeyXrWOsX
 +LzFQP/rdBlGlTXgxcmNuW5DCv6UTLmy/reXxB/dc5fpXvrwabCsgfov+hKwQwm1PPf4MiTjxy6
 9aoXOvc++jQdoAyyPLAMuAAEb0IN4/4=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adfc14e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=vhBVkoOQvq-hK5ylOCEA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 02svscoyCYDW16_Cpv2_SKQyG4nyItT7
X-Proofpoint-ORIG-GUID: 02svscoyCYDW16_Cpv2_SKQyG4nyItT7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX409hhiayqTuI
 InjH/fTJSHqzTBNN2yBTajILweoAzpmwQQzVqrA5aKRsQ1+CkQ6QI3TgSS74IyqpEpeaF6ie24b
 5A0meRWBIfQuI5PtuJwfwIo/lzPv2twNWTwtYyqNNfDDZMs65pd8Tqe0N7h1KDX8H01BuEGRdBx
 FU08sKHBFOijL21PjLjVwL2ccX1kK/ZYZvN2LaKrQhM31FqUAhXrD7h7LtVoNwKH6eIytB/LPwR
 nTaRsZkVUE3dNipuCWsKHqKojwJ5rTGILq8q6k6BzoDryoyIykr7EsV4kc0HDewdgfl7283+obP
 Ic/zZFmY/37iA6CZkK5nH1JPL+SWrQx02nN2Kwd1bhBJmT1uyfmwgUqYIU+2rB1uVHVi0PZMK9k
 koBTez47rMk2pzyycMTRiMoSOmRzYYhO3Vgm7CxLT/+2IqJIoMygytbuDLuAnC+047K09LlEEGR
 JhAQPCzgb7bsiDVSLkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260084
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please ignore this series, wrong version number.

Regards,
Pierrick

