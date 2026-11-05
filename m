Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF85606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VoE7ubwC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D3k9CQFE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsLR-0004JB-Fn; Thu, 05 Nov 2026 02:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsKE-0003ww-GE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:56:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsKC-0003dc-Hu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:55:58 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56UAEK3819639
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 07:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YUaDrhIr58GtC15iqu8Bgzha9pYB0xTuCwsSdVwATV0=; b=VoE7ubwCX9dOD4su
 4UAiUx8E31/ayBw2YYYhXxTRpxw4pUb8diiaihGvI8qpGdX8jf1pTBsMGjev9qjg
 o5l8bMV4ydaX/Lnp243vzHRiMyIwyrrQ5ST/0tbGjQh8+78AGHX3Bl/rLvm+fRVu
 uOadioMm8J34p84PCCzdjbdXWc9qfpxyYHaX8B6NIV+TFsmfmiKpKW4/mKblyqo2
 R+ju0jKcvF3oJr7tUuTU9rQXBfJtDxHSlOn15WSOmqg7kBbHCKpPYjggj1TaoEBZ
 7B8ZVacxUcYqoIdrrHHu6yiqnqEY8epssF3Z1Y+D5uZH25us3ilzBxmnfVglv2FM
 Y0laRQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hra5tjt9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:55:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2041913eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793865354; x=1794470154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YUaDrhIr58GtC15iqu8Bgzha9pYB0xTuCwsSdVwATV0=;
 b=D3k9CQFEiPX4DzVcDxoah7tE2EPEER+STcQ8bU2Xun+FLflBMTm5/Vjc0gvMb+gB72
 cjuWCvC6iuDEuJlgkhz+DIlGnm1AivRcMxPtENJ5y3cWTBKBzoRJ9f4gRawpnDBqzkWq
 IvuvS/m45le5tbA6uWSvBsaSiZmfZqlkUnEKPx9tHou84qcglXnVb0dVLIyjKbs4Z8hT
 QCNmdNPJRxxlwPJpFefksE/Zd2hukUrQZvcANqo6czSzOK+5Fl9Pxp4O2vdZjRsTaWCb
 wxLTA2ym3Lp3Nnk7V+SoJYpIkqnR5TTIawr4rpxuHTGN/Mxdgnkzf7Kzb/0e3/y2gp9f
 Ms0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793865354; x=1794470154;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YUaDrhIr58GtC15iqu8Bgzha9pYB0xTuCwsSdVwATV0=;
 b=WCO4g03OS3SZwNqI95mTS3uKN/e+tL5a5Hu0JRwWsGMkCP+1JNjhRMSfdQLlFnqUlE
 7CvV9LvNSYS/41Ma1V+rfYm1DLB+YWIjNuEQF8bltykAMVqkIPEHend+idRLWFmIGabL
 9ERNtRTFDGyuUkiISK3GY8IKGvZWxskMkPT2rtG7E4STOyFfFLOXlRXYnc2rnOvvKK3K
 8Tc7GhC9xYMYR2USGUugH8VZUNJklnRHVz5H/CpJd/aG6uAfvbPrGvMLf3i3kVEHBSKF
 z73lU08xbTQD4m8C/zYb2HGFTF2nM+hRDokYIGAz/2Ps7XV2o1O5gQ93H8OW3uOK6V1K
 cQQw==
X-Gm-Message-State: APuU4Z/+T9vyLr/EsGwjJKN4pQ7gl0m6TiBFWr6t5Hh5ra4W7OODo9xD
 JfjS9soxs7vKE30iCtFPR5Jue2UVZJKmwsRwgx3QDvOydyH9CWAFll/WpBIMHQi5pNew5ZJgp7k
 Zn/Lg18k4gAxzd5OwXCrvr3HZ/cn/DrYhrRs5aKpxHQgpZAWtqCbx2NjQln9dq6UOjcfb
X-Gm-Gg: AYBFou1oqN1AiUm8Qwp/fumT2z2iJoYMEikw79+aLywNUMcGnHHuG2tZ66/WBA+52NG
 yf9VP/g1IEsmwb2SQNjndNKbsrdpIaHvwZGSCm5D25TxbIrM9NjF/GXH/6ivR4VTfFAqCDoCe7V
 vp+ynycV3dwDdFypO1K7agdxC80MVpG+Q0VXryS1qm64MS7Ku2cbw+udPTzISBsnyHB+IAu7XzQ
 bH/ZnLIX+tKnZeHLEQztKEZJFy9RzTWkwWezUkWA06nSIE3eKrADdHZ6uGpgqbWD96nDHZze/JL
 rdpqwWXEv502yuA/vgDS+UhuejusHk4Av/w/cajbw3ssg3dBjF7XLDlVWI1UZZ96rQ6WBddfHha
 HG2VsZjV3UhTRUAwfr/2ExzMzODahvqROVxJWUNE5R3O44sKMZavMkSTt1yq7wp1QChAflhWBl8
 yFTryUTcZauO3xweaENiWsu5PTGt0kUavi/PYvKjGpsw==
X-Received: by 2002:a05:693c:8353:b0:369:5583:bf4c with SMTP id
 5a478bee46e88-36a424064a8mr27395815eec.28.1793865353222; 
 Wed, 04 Nov 2026 23:55:53 -0800 (PST)
X-Received: by 2002:a05:693c:8353:b0:369:5583:bf4c with SMTP id
 5a478bee46e88-36a424064a8mr27395785eec.28.1793865352623; 
 Wed, 04 Nov 2026 23:55:52 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39972d4sm25195103eec.26.2026.11.04.23.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 23:55:51 -0800 (PST)
Message-ID: <64ce156b-c12d-47ac-9b70-12fea00f91cb@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 23:55:50 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: reset supported features on Supported request
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
References: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfX+REBqtlkM6AY
 qOJR2tXbb8Kvzq6edyUimXwc0EvgJB9B6PKJjTsR4IdKXn7ygEiNQiDSo3x4/7TTEHBkJKQ7M6p
 feNMwiof2iAFlzebekBc1fzaKSx/BGc=
X-Proofpoint-ORIG-GUID: Rz1Vp4FlHwv51a78Xa3vksyh44l-oPVg
X-Authority-Analysis: v=2.4 cv=P/6vFSAu c=1 sm=1 tr=0 ts=6aec368a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CCpqsmhAAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lDtavSEJtHVKaDUYZlkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: Rz1Vp4FlHwv51a78Xa3vksyh44l-oPVg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfX1gyIYJkTTFCh
 rJawswKsrZunj9WymKZH66xlYvLVdTgaokKTsVHh6W7gQQ++Vw5/E3rdlIwTImM2n7asaA4Sk7H
 t/0IJePa1xkp4sptlBFD8/W2jNHyK9+QtEyjLJRpu7hhvIGYJiFSaVTLT+LD78mMLfSqa3YTeKs
 JEswlkza2UYovcGQ9ZTumYmh2wndWLtAqt1QjPcZ7XE99L1zGYDdaQByKMg4SQwA8Xu+HSsRXoN
 2CBuF0mOSZ5/RuCw7oemvxCHAVT2lGWZ9np8BYqgZpnr658cfel1V0H8VRbeh2abjGpXcc3LqFK
 udEWwkOMPw96FeUTWRIJKgH9YskeP85lzAhGg8cDttDX8/hHUFnBrDDE7DntSnpci+SV7R/1KO2
 Chn5TmK45FspGLsiB8GQbwP2qMt90qtKG69TosUp2if2XO8VPUdUqYLpOWMeDf8GUIA9nRRmWG1
 nX/XbiYSGh073oKy9Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050031
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

On 10/30/2026 2:21 PM, Pierrick Bouvier wrote:
> From: Justin Sapp <jsapp@qti.qualcomm.com>
> 
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
> ```
> Whenever the stub receives a ‘qSupported’ request, the supplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
> 
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
> 
> While we are here, fix the same for fork_events in user mode.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 6 ++++++
>  gdbstub/user.c    | 1 +
>  2 files changed, 7 insertions(+)
> 

Sent v2, fixing the rest of fork_events, and simplifying control flow.
@Alex, I didn't apply your R-b, so I would appreciate if you could take
a new look at it.

https://lore.kernel.org/qemu-devel/20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com/T/#u

Thanks,
Pierrick

