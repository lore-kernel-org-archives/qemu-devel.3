Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1306CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 15:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSzWR-0003ZN-Mv; Fri, 29 May 2026 11:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSzWR-0003YL-00
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:53:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSzWP-0000iV-DL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 11:53:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TDM7d02748754
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5hAo87tnQLW/J8zNFYEnLpSZRQipeuS5v5t4WmZQFE8=; b=ddJBHCM39f8QXsG5
 7TGqe2BPSmzpy2rwFFD9UAkNVMIwxmJ+AKFO7KVWCad4v3E2D0CIC2u9TReMg4N5
 oYqTl2LWgRTMLKjGtgClgLdvm83KiKNET/ZXwEEx4YI1aK4VAKTcvCey5YX9vW2m
 ZHMpJzqvobznT/UbwtDITIAHPvTDPSwd53797Pi3FvbufSmbcHDC0G+DPIuJFtwQ
 HlYbNhANBZUcTV+DFVkyZ7PMuUQGgf106iJKsWa83kisFk9wQoydJS3h4DWzWlwi
 Q5vyctLJ8iwzkJXVTRMConZuaKHoNij/DRJDlrQhiu/v09qsrwOvFEvH50m9yEjY
 iSsYgg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevug4fud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 15:53:15 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135f2aa4742so4687471c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780069995; x=1780674795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hAo87tnQLW/J8zNFYEnLpSZRQipeuS5v5t4WmZQFE8=;
 b=i6EGlBCZ53YTWVeyUVfj4R7oO2vBx1OLYjbjhCGIoKm4mSNg8OTEv4gqo2VBmVY5FZ
 /1O6vOWzlASo4MSMApdfVQbnOnCFKqzrAZ0rDEbUatuoCsXMTZsFaOWwgsmy66MiBkRq
 Khh4x6s8m3ZggD6t99zmG7lLWWFgzLNvNsHyU90mJ2FOLFiS7+paRsGBFFhK3F3F8DfA
 1+xu76bR+Kpbv6m17vIc20Dtp5JKox7Ws9K/OOqAUM0SQnCiWximhtSiCeMCGB3MMlfT
 aCOYuSFFYlGGwOacZxdWN8+ZKmpHHaEpqVUxX/eA/TrkToJ4V+78/qshdOKrALqtC55/
 fFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069995; x=1780674795;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hAo87tnQLW/J8zNFYEnLpSZRQipeuS5v5t4WmZQFE8=;
 b=Xu6zTDIBhO7EQr5FdlW0+vGnXULnvVJ1j3UMEeqGwLfik2YDMZrJna1YXWAy4/h+QI
 ekijE7Wd6ldp7nHq8ScCePQlaJImvEwT2JXmHGNBaq0758UlQqPZwWIbRyGD/Kcvyfmw
 grXtkpZ/nDzqC9NxlJtjHUd8G+yuWoCiCz09/Og9LLofWBcnL4XzNMWMUSzLQVFzLxSo
 Xke+xBFSM68h9gGkgoel8V7xgKKGUql1IJKlpw3Pi9xp2dSk0y/RCG+814FUnPrw8X1J
 rgByU/wV1KrK+LeRmBd1T3YN4QOn+S0rZ6quEOSZnFHaSSHVVZ8zWpt/PuCF/ynOUQAH
 QBBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dVP+pyRG/pkE+WT6P7i6VDtihMecsEcp5iXLqHuEsGgQ33loCpH7MvzjhCApl3I9o73YWCKseF+5Q@nongnu.org
X-Gm-Message-State: AOJu0Yy4lQSaDtC+JscmUMFLrmGNn7kaiDJ9sKTLnS8OgdwpjwTH7PMs
 kyG6kAk3MbHLJDgALff3prW3zaFCpLlpFdDVWOHVMpXNzriSmRAuQyY1ZmZ3ZfYZUKG+1w52TxA
 buHvvCEtAyP28ESuo8VsA/VeNz+ZJSkJkPTbi4M+zqjuFE8AQpE6G84cPww==
X-Gm-Gg: Acq92OHp/ScU0AB8HvS4jaG9niYPlR1VuQTw2gyG3T/abuCnL19ryNLsGnqzpGhY/An
 +XkkvW3d2edCC0IthhBla7gIIQ1u74jAWSBhJod71mkzRkah3f2RJqXov1KMd/SmEye63BIJhip
 Bgz6YRRvPIVhc8RqQKeE1LDpYziXG6bKm5PoRxP0f8/0TuKMes1jti0KeibLTgFgJNk+Kh1RxZy
 1ply4+LOJ4UTEJzlE7UPZolav5ZCTbLCOKGuKOPQPFm4JbxlvCPDqVWVAsF6AE0+5AFHQXtey86
 CmucCB2wi/wCGJbJZFw9gvJNi2Y7DBB9/2CWfHEePu7YQp8wX9xcQ+Ccddf3kWc5V60mvrrW2WU
 QsseQK2IiX+RpdvD47xyZC6BS1gPh9GArY1SZJxUZErQNZabWslBGNA7dH+M1oxr2l0OUCbDaHw
 GMBy8yMf/gznCP+hT7mE1t2E1s
X-Received: by 2002:a05:7022:458b:b0:135:d7ab:7ebb with SMTP id
 a92af1059eb24-137d426c048mr74800c88.29.1780069994549; 
 Fri, 29 May 2026 08:53:14 -0700 (PDT)
X-Received: by 2002:a05:7022:458b:b0:135:d7ab:7ebb with SMTP id
 a92af1059eb24-137d426c048mr74777c88.29.1780069993844; 
 Fri, 29 May 2026 08:53:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3d8f839sm1248684c88.15.2026.05.29.08.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 08:53:13 -0700 (PDT)
Message-ID: <0b037d9c-90f8-4883-914c-a7837a5b8690@oss.qualcomm.com>
Date: Fri, 29 May 2026 08:53:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] linux-user: implement fsmount(2) series of syscalls
To: Xinhui Yang <cyan@cyano.uk>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Mingcong Bai <jeffbai@aosc.io>
References: <cover.1780036891.git.cyan@cyano.uk>
 <193e73f7745a086b99ba68e28b665f9f22444b06.1780036891.git.cyan@cyano.uk>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <193e73f7745a086b99ba68e28b665f9f22444b06.1780036891.git.cyan@cyano.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1OSBTYWx0ZWRfX8KaD9Y5T0FaQ
 Cb64ehFMyWr9GAiWSCCZpPRrrUtrwrkEZlhc3KYD4GBPeXHHVwJ+8utgCoQH4NeQ+E1YOZgKsaE
 RzTojAGNjDQubBMbMfeI2G2DHrazlNgYz1veqi1RGNcmSamraUZBFZEE06AuavOnXH0IdDVz6+F
 Kvf7tTeQou0pJhPX/SA/5HC2frCT3a96JYbYmQi30UKT2SXRpUI7CAKz7knKBcwyR5URJ/8Qw8j
 3UKriT/q9WecawLq4/M0YVJKZHsfDG0CA7hU6V9R+6ZGE8Fi/v44Ji2mJAoLWPnCJRMC2iSCoVc
 GBBUvEEOoXY4odsWH7zAOP2S9Md5aJHmd4UdtHTHjvDhODtsNr+LHIxvtX3wj49BGyxKSwLt7Gl
 8uFj69Lop2DmWu6ObiWV8Z1DQ9c8CcV4wvkyw08OIiFl7wRqdP0B0XnIwWvCAXg5PkNciU34H76
 lhkW9wkBjjcogP/E2Gg==
X-Authority-Analysis: v=2.4 cv=SNBykuvH c=1 sm=1 tr=0 ts=6a19b66b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=94FhayaHJYdwx2da-gIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: pXL4udmmVW_Wfmp_v_VdsRuTr9aWWPOZ
X-Proofpoint-GUID: pXL4udmmVW_Wfmp_v_VdsRuTr9aWWPOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290159
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

On 5/28/2026 11:53 PM, Xinhui Yang wrote:
> This series of syscalls replaces the old mount(2) syscall with a series
> of syscalls that operates around a filesystem context. This series of
> syscalls is available since Linux 5.2 and glibc 2.36+.
> 
> Their users include systemd since v259 and libmount from util-linux, and
> possibly other widely used projects.
> 
> Preliminary checks are implemented to ensure the validity of the
> interface.
> 
> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
> ---
>  linux-user/syscall.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

