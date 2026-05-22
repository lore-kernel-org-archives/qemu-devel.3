Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E62CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYiC-0008Rt-3P; Fri, 22 May 2026 18:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYiA-0008Rh-Pr
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:51:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYi9-0001nz-0K
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:51:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIOgIF4007091
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6os3pL7dxuGptef2rfzHinDDugtDyJ+0c/GLUxbk3t4=; b=nkNKL8pMZsxmH5Wb
 Ft0FZhMOlQAJspxwuJikNFcLroZbRFHV94TitpodnqxQmUA14CkIItP9yDlhh7SM
 sKIu2i3tkQpFTfVqJ3bvuFuT6b4pgOz5eCx/t2yXRHsUsrbcn90uOckgQqTsqtO8
 b0n2kMPr3UH2yZpnjwv5ChJWbsrpz6Riq17kzLjOsiKR41vgJ9TUQujTY09kwvtN
 J3GMZgkQqwvsx3DVyAakp5hEP3LvlLo80+IsCE1uJqxZoNpeBc+MxPpa16KfqTw7
 PVnGMKHZ4QcUDFC89nIs2+1rVR/yazE9OushP1JHw078L0ocseXd3Un8z49mXkvi
 gFCWkQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eavd98qnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:51:17 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13537722193so8793401c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779490277; x=1780095077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6os3pL7dxuGptef2rfzHinDDugtDyJ+0c/GLUxbk3t4=;
 b=P5qUL/WvXOheL6wXF8m1NZugxu3B4b0HQ+EsVXEc6CK2Ka3RhyozKSstrVQQes7KP0
 Dhhz+YdYbDBRkqmQx5Efz9xzbuJ4EonYPyqv1GVqpzLb/C/EJC0nlkM+HebX3Du6W1Xu
 YXzfjbZ+Do8f3Roo+fZaRymF9Pqo9dMFR4Y1N+gm9FCk9pHbQpa0PxJ62mF1UXFSyG0E
 zzcUvUe/9hBlkNJr0wKr1qYZYNKBQKpxkMKzaPj0cFZFKdhfESlM1ucx89xnCyLRlGiQ
 JVWEA6pGMoEBVNGDeDWoSDdu+EQDSBpbL0gN20V03KH0BhO8wDyN+ZWUgiIl9/4hShR8
 8dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779490277; x=1780095077;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6os3pL7dxuGptef2rfzHinDDugtDyJ+0c/GLUxbk3t4=;
 b=EbEc0ugK0muOjcUcKqwnBpSHTmbqDGumCShS7ntVh58FwhNFZyBDRa4qaYenCfsPta
 2IwWIYcSpJKFpJRR6hnsIaEEpXuXpbN+16iLUtIYXzOmy9ROLvTxz/uhKm+4UCs/gEX7
 jEp8TiXdDPBT7VZgdRtxYQqsvROUpSZgQPbJu9eFGvSx2X1AksSuHog2RbmwDf4UAy4z
 IBT3QNFEHq+uzBqsRJmxA51/4FuZ/1s4YbrMuux++oBeRJQFbgo7o2ux5QeoNl7SYvwD
 1R1HFAcWVjcpFDjoXmvd1jOhkdCSJZiM9c2Nd8gveCHk8ZCZQYPp+S5sEu3wWlgAuoxy
 T8tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ThAMFYmVdYMuRZ7cgughQLO2PJPLvFXHjuPUnhBXfzx6S6tmEtnpm6nty/ljh0d/anErRBtdnjG+E@nongnu.org
X-Gm-Message-State: AOJu0YyWzBWfdpa4zvlZOCQyD1trrOhxwdOqnQhBvUnrugCckHIjiS7R
 Av/Jjk/vPxcylVmQ+TrB2r2FYefgwA1lboY17MfNqxEjLlr7eRt/5d8qaZtlaeMhBZ+jOHRzwLy
 /w884Z3fMtwjfzpo3TDrpON7saekkWpJwAcSCF9EA78d0cvb41hCLk9Sk8Q==
X-Gm-Gg: Acq92OHE2awBfJ48ESKvvidj0CIE2NX5pI0X2tVnaPzu9OBaeTMZZ1w5+rVlYXt4g5j
 RyzwrmpaQq+9xB2JnkXeei9KO4XW68Y2qob34x651vtONt0kKAzsUr47HvqxFXE58XoqBA5Ajol
 kMIC8ZiDm1aMJCUlSc1DFeRm/7+aerD3Xv6vsnE5LJeiY+UkoFwKDfqSIhw20tO2Mz7c9z8I6nG
 1uFYE0PUCe+2BU34CmY9RvQTVpdyWQnHmXXaQ9pYN3ZFpYYdrsVID63OOQIfcKDfqOUXYvSL8l7
 XRx/wjUBtUTEWsuXOscnbBAi9zLSOvjvbHA4xfONUOsrG5xEACdkLMFiwTiImk0Gi1taSYob0jj
 Uw/LfQNFZNFsINCScnbizdGg5C5Pf3CaoQudy4UVHDF4Cv4F84w91DTY0F3pVn68WIXEc5j0+1L
 f4hI0bY6aM1dSfVg==
X-Received: by 2002:a05:701b:2214:b0:134:cbed:2b35 with SMTP id
 a92af1059eb24-1365f920ff0mr1368315c88.18.1779490277198; 
 Fri, 22 May 2026 15:51:17 -0700 (PDT)
X-Received: by 2002:a05:701b:2214:b0:134:cbed:2b35 with SMTP id
 a92af1059eb24-1365f920ff0mr1368310c88.18.1779490276688; 
 Fri, 22 May 2026 15:51:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13669c6a2adsm1977653c88.0.2026.05.22.15.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:51:16 -0700 (PDT)
Message-ID: <024d0bb5-dcc3-4841-8cdf-c9b892918361@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:51:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/37] bsd-user: Add poll, lseek, pipe, and swap system
 call shims
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-6-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-6-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNyBTYWx0ZWRfX6Kfuy9PDLtrT
 60JPd5Q7B9FzrSkuup5/+R72BsSYj+Id50DPnLb6+CXnIPBdfalbUwABViIB3lx3WkBTSwNBwo0
 HEz2s2ZfKD2KPnA69k8URpNfZTrGpB3gglhqhDr8EXrNxOUluGOy82bG45v7CYt0eahMx5b9wAf
 SBbxxsS0WHXbDK0uKObRZmZjCG299wWHFCxqZ6ZTnWOvKtgtK3B62U/6Pm56ALxgAyeTq2UUPbN
 JiglB0N4+fy7mAhmAEEkCeS5TjC5S0cnNnM9XOqZDhieZLi2hklQwrTr/cq7t4frM+f0nv9hrNO
 aQGKJRGk/ofA+i/cYFPCZm3Id1ZZJKm7kGZyjxCq0PQd60XhXAlJiLSWKxPDk52DogNBE1/S7o/
 vJKdLML0F4U982dUDdUv6XBOCDDqvW6/Qz/8kRD4X26NWpcBaLfD5bpfLk2J3whjGhHz+uvdkKD
 wWpAOQeU8H6nVCnTd+g==
X-Proofpoint-GUID: fS887uNO6xbjUB4UDWsUlqkziPpDaoJx
X-Proofpoint-ORIG-GUID: fS887uNO6xbjUB4UDWsUlqkziPpDaoJx
X-Authority-Analysis: v=2.4 cv=F+dnsKhN c=1 sm=1 tr=0 ts=6a10dde5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=ookr41irFlOYbUjtx58A:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220227
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add do_bsd_poll, do_bsd_lseek, do_bsd_pipe, do_bsd_swapon,
> do_freebsd13_swapoff, and do_bsd_swapoff to bsd-file.h. Also add
> target_pollfd structure to syscall_defs.h and include poll.h in
> os-syscall.c.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/bsd-file.h           | 136 +++++++++++++
>  bsd-user/freebsd/os-syscall.c |   1 +
>  bsd-user/syscall_defs.h       | 458 ++++++++++++++++++++++++++++++++++++------
>  3 files changed, 534 insertions(+), 61 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

