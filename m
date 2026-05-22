Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D34ECD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 23:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQZJA-0001RT-Fe; Fri, 22 May 2026 19:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZJ8-0001QK-B2
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:29:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQZJ6-00058H-R6
 for qemu-devel@nongnu.org; Fri, 22 May 2026 19:29:34 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIERaM3344505
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1181GrsLgltTlhHOZL5FXHPTzAUNQR7Wae+Hi8xCeOw=; b=RVWq3IRN6JZz+H3U
 XFFL2YEXCgVJl1Z3aGZVcS9gNPtABUxZf8ZvqRTjwz9aaxJe6r5kNsH8kBoi/1Jt
 rim2mKG1e8xHzuPjn8OxQOAWIVfOqmNahBZn1BGUqpWS5l6mWAsSNrB4lTArfEKc
 3B6imgHagpbOUzRlq6gBhim1N+fEzlHUks4H/Ry5tCFm7JOx4jSRzwuclWIayEIq
 tKGqZpxmkFK+qpU6xhGBcoYOCVjMsgOr8Fw2HVexx0Fsm4/nMh/kl6QOp9/CV7Zr
 GK3RGhKTldvLbxgDWRfpIJnwxgquFRctVNOO77jcz+hpu3b78Cuf/U/mNgo1hvEW
 nzyS9Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eav87ru9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 23:29:31 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dece274b1so10468470c88.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779492571; x=1780097371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1181GrsLgltTlhHOZL5FXHPTzAUNQR7Wae+Hi8xCeOw=;
 b=iRjrtlh4iFqwuYvZUiQlqVwx4jcNuLVmi3ZJ7NOG6r+qOdJHEMz/XzpEyIwI5uDgIK
 xgAPLBUowx72h4zh1uDcahytgDJA9EaOO77IOuq55dxLOiqmHw/Rs7XkB0a15VE60ZCH
 qu+K8Krh0PfLY+DePtGPlcPd+qWVIr+0WtT889uer/m5Q53HNZLadOJLeYTIAbtXe65u
 WXTBnr2/HhaZ1ScgcFPojoo5CdoSSWY2B1VNTjgdpDq6oVAfQ5GQ8mTTJ/yFUIjtBRDq
 cO8yaChcmmELsCpQ2t46krRFWJIBdTTcMqrUHKNb5SusSVHs71HSjGui3DLlQY3+qyd/
 2+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779492571; x=1780097371;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1181GrsLgltTlhHOZL5FXHPTzAUNQR7Wae+Hi8xCeOw=;
 b=m9R6YRQqGnchc6wHtT/GKVvR2UJpdGupn1qu1GBE1O3En1g/GX945peoaya0dDZw3X
 3wETuZ4GmPkNMiUOyf6LUYMFUcaT/YvJM4zPq+z88va4qjW92ViVXy4mCBUfMcoQepi/
 vVksjj5uWi4JPViPdhGIwueiWB+/Z448yRLLe1HxrSWZLdOhd8jFXrEu6aW0nFPksD4V
 HDaw9i7sTEZx01GIvkBdvH4VEtgMgaI5O4VfSYZg/oa8U2/9lhx6/g/DoKipVxV1eroS
 lBHMUfPwM9WYcD+GQgpfNwKDkaqY8o6CroXEhY7M+Ew/pp5r1V/KDO39U4dbjS/VCClO
 FQoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+r0YohxUfU9gctbDPbgYImC0QjFj3R9aydBa6IwgwmptUSZVGSAwdyWIMsNbI8pTCFiaScP2rzBFU6@nongnu.org
X-Gm-Message-State: AOJu0YzzRdPr87RXuoX4AEnNf8O8+av5OndAKKeaxc0wB/qGaNe37qL3
 1da4s0jIEzYZLz+W9PjfDtQdbmtQyYdywZBDbnt7rgXV19GWdEY1ErnUNFmrPr5cbq2hjUu8NMW
 9Q03NSQorT3go8xYq0JliOBMpOK//zRwoD4bQ7hxQKovySvNn0gc/GnpG1Q==
X-Gm-Gg: Acq92OFlwwWtLAHGN8WKPAIuL6kARzZxDod1FFQjYhlWioHxy5lRBrFdeHP2PxakLfi
 OyN2DozqIIegPQzhPpKdSR/VD3Fd44MDS7xQ3dI049jQH2AJM4lBmEPsKh+nDuUdFGbZgqzPp/h
 G3Nk5XJUDgaYJMHiUa29RvNgWqM0cBuGywvKn29ArUstswncgXq3Yid8TDbbJuL1kQefjj5ZyYY
 I0GYfDsiV/xiLu2hWDltorjikWdFK1g+qOej6osupQDTOIEqp8OpwXfmXgurW+Q9DdLi2NRaMNT
 TYBpinlZR2T3jiQCjO47oit+Nie6n8K5CnsFAILKfghCq11EHQy4GnBRj5UZ+Ozo5VjhuxEUx0k
 bNvHQ7NhsDNZ+G9rw0MbK01vFRS58XN+mDuYyhkKiBVwoOt3vG0fc60EFCFovgUBIRWzwBBhZZ0
 UCuWpjvA5iY8pX1g==
X-Received: by 2002:a05:7022:258a:b0:136:4317:a163 with SMTP id
 a92af1059eb24-1365fa35574mr2084661c88.25.1779492570478; 
 Fri, 22 May 2026 16:29:30 -0700 (PDT)
X-Received: by 2002:a05:7022:258a:b0:136:4317:a163 with SMTP id
 a92af1059eb24-1365fa35574mr2084649c88.25.1779492569905; 
 Fri, 22 May 2026 16:29:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm2459869c88.2.2026.05.22.16.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 16:29:29 -0700 (PDT)
Message-ID: <09ecdbe9-d14e-401e-a1d2-7056a5ef7ef5@oss.qualcomm.com>
Date: Fri, 22 May 2026 16:29:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/37] bsd-user: Add FreeBSD socket helpers and
 sockaddr conversion
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-14-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-14-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzNCBTYWx0ZWRfX58gAT7h1N8dk
 0T78i91QqQ1apx29hhyhjTeZS1Jz0cvJjliJFJ3UXsIp7PcQW0wQNOuJ/ysAyFvbMzwyK2tvTjp
 bMZI7JdGNoaafqlVIlQmFBgdz1WRFG3NioprnQyz0H3D6ZHkLETY5caVyPLNEe2/x2QPQKhk+7J
 BOIMyZnuJeSrzDti5LIGuM+Gm80C+rQGhmS3k9cGAVTSH9c0DfdP9Snl561y9EqgHBbRz5AZwYk
 nL36s1VAvxGkkcT/mKWdV4R1Sig8G9PIsoySeYyeaOIV6X9IbAiSrPX1Thf301d6SPe0G/jTH6r
 0BGD87f7hpaEssPl24TGHXBwV0MljFmA9TPN/9VRKB1DP9AUqeh8cz3un0tIBqTA4S6ipyQRaWv
 GoOjZe04zMFdhiRO6eSwY17irfAFL6YQi2j9ZFYBvv+7+edtshmZd40EzYokZZcpvegscPdKfvP
 J84CRtFQGJqCuwDCq3Q==
X-Authority-Analysis: v=2.4 cv=dbiwG3Xe c=1 sm=1 tr=0 ts=6a10e6db cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=Tq-ztEeptpUqQPw0T8YA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: g5E8JVpg8exdjZte3CCZ_yawK7TiRicg
X-Proofpoint-ORIG-GUID: g5E8JVpg8exdjZte3CCZ_yawK7TiRicg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220234
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Complete os-socket.h with setfib, bindat, connectat, and accept4.
> Add bsd-socket.c with target_to_host_sockaddr, host_to_target_sockaddr,
> and target_to_host_ip_mreq helper functions, and add it to the build.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/bsd-socket.c        | 98 ++++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-socket.h | 85 +++++++++++++++++++++++++++++++++++++-
>  bsd-user/meson.build         |  1 +
>  bsd-user/qemu-bsd.h          |  8 ++++
>  4 files changed, 191 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

