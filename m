Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2D1FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDvC-0003MX-2t; Wed, 29 Apr 2026 19:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDvA-0003MP-0B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:02:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDv8-00009w-Cb
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:02:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbIOp255367
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7o1qYoKbnYwiqT513lxJae5/V401FtYaq70uq3kxGvo=; b=Vp9vkT1LKUG5SWYu
 AdhWrtc88W1QYdxDiAopZ1J0fIDncWri3Jer4rK5X7Qt4O56qr9BPyMB5xp3Be0J
 iKe8JeSn5F35BxUu9g8CGNPVkp467tHH85YxfkXNtnyYz1yZvZt292V3l5JS1KwA
 7TCItbJDVSTE5XQb1hp+TmcpJwsrS718c8lkgB68Zo2F4MT5uF5jWqr/uIgtWqfG
 fon5qT6X5XGKdRHoFRnkigxJeLE0oW0Zzty7+sILMvaZjRfXtH5IG1r7p8NqSrCp
 a414rErTjGS32kmLNhwmQ5LW+NUCPUU17GibCXTnvxjf2huNEEQzgN837XpOEQa4
 0stoxA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71hdha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:02:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dece274b1so23979c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503736; x=1778108536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7o1qYoKbnYwiqT513lxJae5/V401FtYaq70uq3kxGvo=;
 b=EqSTuiTavWWDqkgz3BvIHbWl+Sjj8i7sY7dXMVh/e/CpbZCrmancrxM7wNdZsekwzn
 OPo758N55OmOo/+Xbg92XbH7u/+P5LAqR8uJPXpDohJNRYAp+86AujccPPaKEwG0HQsQ
 YXnLKJpcbd7+WldIfP0ddaOWSIJpcLcrRPq9X1RE1d1/wbiTifoCpRyY4N51Q/O43K5P
 +uJkzOShanNpdlcdIWgjVt0efSI9iJ0whIneyPG0fAnsMc4TnvTlrhOaJeLWWEfvUVam
 MayxivEjy2osAQJhgZ0E8sr6v7jKcP1LFhLlOKuwVwo45qDf9isfFvcDEr6Fc+Yezqdi
 6kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503736; x=1778108536;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7o1qYoKbnYwiqT513lxJae5/V401FtYaq70uq3kxGvo=;
 b=esy+934nTPuEWcBdkmkPrmq7Esnh93g6VEjhfVKhMZACEj34mWaul8MN6eI5PjbnOW
 fwe+pKXXH68JeVwNdUAk6EmHTiM5A2qC1cBNUPEomIErN0iVHfMEXIf1XsaX9ttdxOhD
 DQLJ1FsJUFmWxs22NOWG4zb9tiTlN05bKnOv4hizGlvarkj4n86Pg9EOVW2EFeBIjU6n
 68n0KouMd5S+paeLatHtKFAV5Wd5PMM/xZPu1BbsI6D3kr/EKYz2iE2aylOnokeK6ClA
 aarY6axt6IQbm7mTLotLG2SyG31E/MBAb7Bd9cGf+/XFNDXWdUODl4vdOkJAuIlHMHDI
 1NIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vvaHoeLSQwsD1nwkIifvfG8T6On4AYkAllC/jqrltxLrAcmjHqHr7kwD6quKhWTVhML/cEJU8FQZF@nongnu.org
X-Gm-Message-State: AOJu0YxdFblswmJfodKO9edEaRAZCR4eKNptM+IxQfJ28WR1cO5G1S0A
 GjVpqM3WlLfmrBpujtGKpen2wy6HAisNDMY2QRQjFwcLZBHvJDccOnhBGdmrtu/VRNM0hYw8JPj
 hPUX5M15gg3bqItXyRUB+uTpMZGHhEiAcxxxu60+kXBeQ30e0ZobdrL6GWg==
X-Gm-Gg: AeBDieu766mPuJT/H3kHV5iGRI3QUE/5XbI06Rie5/7c7NXvUSG0TWws1dhOzUIm9GY
 DA5nsSRDgYijCkvP8jVmyZAc1a4a00kPeYTdBsOyK2t/+RfwlVLwlf6f4nVf9XN2jIQRTIBa9Uk
 lTp9QkulX4XYxjZ8gQKOS38rOcaAUU83hQbxFo2FrQz0nVRaP6BY9WNvgwD4l935ralJfhvIZMG
 ZwnDIYav5ghV6YhJ24ZmBKBNZlidRkPZxA7EbF/gR7Sr/2Yfqmskq/TRxkXGs35j1S8qsNhziuc
 RHy4LJaBfvJ0EGMBErJZt18KSrqWxN6WO5xujg/m2cfbbF1sz7yYSi6SkROtHWxbRq9R20p8Dur
 fEqivKXXET5M+YAK0uqFOZOROh5+w/bA3pZ28cvw8OROxRorprM4IgjvlY/kyDmHMkNDRYI7HCp
 CjB6rNmkQJN+Q6kClEibixU0q1
X-Received: by 2002:a05:7022:258f:b0:128:bae0:e044 with SMTP id
 a92af1059eb24-12dead0acfemr244990c88.30.1777503736163; 
 Wed, 29 Apr 2026 16:02:16 -0700 (PDT)
X-Received: by 2002:a05:7022:258f:b0:128:bae0:e044 with SMTP id
 a92af1059eb24-12dead0acfemr244969c88.30.1777503735548; 
 Wed, 29 Apr 2026 16:02:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32615ebsm5365625c88.10.2026.04.29.16.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:02:14 -0700 (PDT)
Message-ID: <61def8cf-cc0e-4426-a4d1-0ece3b0d0bb7@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:02:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/17] bsd-user: Add do_ioctl_unsupported function
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-13-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-13-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: r76PqYAGyBpfLU3espeTN40brjf79gvS
X-Proofpoint-ORIG-GUID: r76PqYAGyBpfLU3espeTN40brjf79gvS
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f28df8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=5JBlHxMgKT1kqhHWC4UA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXzznJif36AnCh
 61MvGun2ZPxkrVWEEomSvAMzcBvmJcWB1f5uaC1e7oZ+fxaQHozaRPj7AMYSpqjpFW+uqJeODEu
 AZW31FasQGC2D1jhXZrIoaZAciKS010K0+z4M/rRx/QO0G1avVgvkLTHyhaeO/4/TXw7DiaVSng
 qPMOakb/y2pLYNojdu4/ivihNw6+/7fitOies3eOAwclwnpDaJw4YJWMJYNDQ0jkTGC1daxQBjc
 J+HAS6Z9A8NmkXwvWYfLMHd+b1fNnTn5GNNXHhnkYqZj7tNK5sORRGHnagbplNFX1PyQZh2EkJd
 EGdyarNJudKD2w/XLIPnXJVbrskmqZ21xYW9n6hhFd/aKUscMg9ioTyFdBlkJMiWR+aRnmB7sMM
 N5LzQqd+46RYeoPuxrD6NNsn3LaXfnAqF34yiutkiLXJ75EnL8RRhH9bMCi+iEUjQItzzJ9AqUP
 Eo0gGBGobZfXctP1PvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> Add handler function for unsupported ioctl commands that returns
> TARGET_ENXIO.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

