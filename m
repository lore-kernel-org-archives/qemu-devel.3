Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8234606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X87SD390;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dcDraw5I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWDy1-0006zY-5Y; Wed, 25 Nov 2026 09:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWDxv-0006yi-Vu
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:27:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWDxt-0006eC-4m
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:27:19 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEMKBe2955634
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 14:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Npb9Sa/eR45Y7xGqnP0Q3+hk1E+wrFqI2nWtBxrzh8=; b=X87SD390+SOCOQ0q
 bIB2QLgovRqXK9XIC9s+Hsl7yk4h9suvEP/1VGOOQ1cY8Lf747Oie16PuVXpJ95g
 ZKeTMufVmlDi/lmM5mH2tKykaL9UWG/yBEhopZUKjZNLGay43muvfOMKTJ5iv8cu
 euCVdkeaanv+4JgU2n/tuMtwo+Kx98NahgQoQCrUDCfI9qrrBBRFOGBel0x/+zQu
 PhMLRMd1wP10VJR6APoIexEhR1dMeeI2BAMXcLvHt5FTsfVVV/CXDnOz9/fJvEjx
 HP/rYRypvk1vAhnAngbsYsmnZ2eEobwB67n4zmmoGKo5ObuvkvBr7yxb8E0GiGDc
 5dbQEQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu6axek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 14:27:14 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-67bda487981so7802377d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795616833; x=1796221633; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Npb9Sa/eR45Y7xGqnP0Q3+hk1E+wrFqI2nWtBxrzh8=;
 b=dcDraw5Iz0dsgnz1a2GD6/6S1Pzz3Zor17nbgWZ9pt0fHCc2CEMACXxCLZpsR20/J6
 DbYzIGulWItW9s6JoL1jH8T9Vlwf3sFuf9dozQoVoTiab8Drei4n5LNW9wLofQaFtNK6
 T/BdCTTNxzHvVLRq4VGhhTO0FeipRuMxq6X+blJ+ZoIULkfBBA/9YAF3KH+NAxDXWBmi
 oAf8FYhXYMo0idkerp+TDvYoRfXLdq8/JsKsys8ix2RT7H7HzTh4jWs627mVKGLF0fF/
 32tGGf74agNKJ88dPKgNxAEGHg1mkyUr8dSPK2ewapuBg8GtaOYGvQmOnVRC9TH/dytp
 7tJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616833; x=1796221633;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Npb9Sa/eR45Y7xGqnP0Q3+hk1E+wrFqI2nWtBxrzh8=;
 b=eG09JEGN/VzAYuliGO9SFx3iNIb19Iw1XB0YQNXlSWZw/2o0wpIn6Z3y2onUEzJxv2
 QPipqBE1fHuy/HUGamz1WgkdrpgowFAcSjv+qaH8UxiwAyOjRobJbuVDVM/c9QBDvRtb
 4Duyn9BfFJlLtUjCcTTWpeSlwp4nozd7/+KkOwdkOhGz9l1OxWUZL/OCnvJSLFMagQso
 0YLDr4adFqS10LOF1SBRk1WBkQskmnuBZ6hPtaeCqjM1Has9OucZkhXofryyhuOKXEGW
 s1Qz3LEilxERs8pXaFjqlqJsza4fpS6Uassi8knl+/Ha/tt1CK2kFGzy+Epz3DKbLfxN
 18OQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEcCEyhSwRxvvU26eiFzAohNGlbllyUiHYol7Sb+uSc/tnLov11gBh/2yp7z+yW2HXfdcSe/dTFpb4D@nongnu.org
X-Gm-Message-State: APuU4Z8sePw+8Zu4h8SkjQHGINnlHey2tFiVzf/5iTuKETFdpX5URoCe
 Qi5qyqHnNj2RtEykL7eJBSvnHHWIzNGCoIFx+lC1Ae72Ymeear+LHuc5HKmIK21d/+ukdPArAc6
 aWSX65of6yzknf+czXoMWB/L0x2ZJqHIQvjvNlueQaUj8T1fhe+WanRJhQA==
X-Gm-Gg: AZFdTZdiiBrFr+bsUS+MoXVwHJ3Ke0aG9TlgmzrRhGUShTrWWHA1kAa5Vtx/1Ppio3H
 Wf/niB8j5PGlfZlgKlTmR3EQDBcqvJoArsJm0yYsa90JPXKO+ZQCundTchIFQXPkMKblcdWpIE8
 Jw0YoOHtjRsyidfxq3aoqHCFYho9XSJyCnkjqGAZIi5bqfUK5ogamGtkgT5Vx9g2NgvkMVWO+TX
 1TbAZkfuEchGBWMucnGmZzxtqk2y9zS9V/+G6N/JUBosMR35sEFp6Sfe8Cm1q6Xtin9KOCHQnk5
 i+bVdzZHPk7FFjGzwWq1vEiLaXNuLGOnQWgLt2pKL/xWKsB2CcwiwyFuqE13u8HFvX6thB9o/Uv
 wbaSTJyITLvgI+yI0prOgXTSuuCBRa/xu4XvJlXPjAl33TyAdmYAV/jYfJin4qlPI02N3BvA8mj
 kV12FfDJg=
X-Received: by 2002:a05:690e:168b:b0:67e:5c0:d6e9 with SMTP id
 956f58d0204a3-67e05c0d7d7mr5267713d50.20.1795616833325; 
 Wed, 25 Nov 2026 06:27:13 -0800 (PST)
X-Received: by 2002:a05:690e:168b:b0:67e:5c0:d6e9 with SMTP id
 956f58d0204a3-67e05c0d7d7mr5267699d50.20.1795616832705; 
 Wed, 25 Nov 2026 06:27:12 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b33a596f9csm13727043f8f.12.2026.11.25.06.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 06:27:11 -0800 (PST)
Message-ID: <d09586e5-6ad0-413c-8def-bbe8dd2872ca@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:27:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Add tracepoint at end of read/write
Content-Language: en-US
To: Jorge Merlino <jorge.merlino@canonical.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20261125-debug-block-ops-b4-v2-1-ed384499385f@canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261125-debug-block-ops-b4-v2-1-ed384499385f@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jgaQnA0Q-47XdCOlEfvOx6IGuFFw5xZ_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1NyBTYWx0ZWRfX+vHFinLkFYA+
 +tVMDSDvl/axzCIJyvtOouY2qdUT/Jo0c15AqygJe+u+eFZce/UCv9/2nNua4Tu5Dpj9AG/3hxg
 HNRmcpJruMQUD8CYBjNejWM3n3gnf9E=
X-Proofpoint-GUID: jgaQnA0Q-47XdCOlEfvOx6IGuFFw5xZ_
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b06f042 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=EUspDBNiAAAA:8 a=vUTNT2URx0pbJ5QpV98A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1NyBTYWx0ZWRfXzCRiDLhrAYAP
 0p4TMqi19ti99Qjcy3EJD4ypc/P76olzOf4S/MHkX1SNRLmC590Yo+1fa24D5TLer5AcgmVL3SK
 R3snGuYBkLTJ8uOUH2pwCrLtIJXsMrW2ays3gkAnbD/sNcNLPjU4cfcddhRrxlRMFzkcCEcwKEW
 EsJMhDwlovCLt2vu2evl/9nWULfDYdOuNS3ekk29fAnD9tiTMP9JRazljWfL4t1H56iJVIO/r+O
 DMNmvhNlTTmly2Q/iI/uUXnbr8OIQ/Z3IlNtgkSBZl0DT8o56Pdq4oXZlZHyNZWgJFXYgJ4uxbz
 K315IfC0cfQlUy1LXa829K6CYrOPPa1vSV6RYkVqzejC4XXikL3hADVMR1eyP4ewnk9vh7hE4RZ
 VCAC9CG9gfhY9MvbHOML21gmNJP7J4b58QyLnZZbDQSt69iSYxguqAT1BLAoMzR30TN9bm5Y9GX
 /wlo+W8U+kZoZr4WtxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250057
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/11/26 15:18, Jorge Merlino wrote:
> Add new debug tracepoints when block read and write operations finish to
> be able to measure latency.
> 
> Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>
> ---
> This patch adds debug tracepoints when block read and write operations
> finish. The log includes the parameters used when the operation was
> initiated so that the start and finish messages can be easily
> correlated. Also the return value of the operation is logged.
> 
> This can be used to analyze latency issues with block operations.
> ---
> Changes in v2:
> - Updated subject line mentioning trace points
> - Added traces so that the end trace appears even in error cases
> - Link to v1: https://lore.kernel.org/qemu-devel/20260909-debug-block-ops-b4-v1-1-2405f34ec068@canonical.com
> ---
>   block/block-backend.c | 4 ++++
>   block/trace-events    | 2 ++
>   2 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

