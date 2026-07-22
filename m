Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA8EC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZSs-0001Kj-2z; Wed, 22 Jul 2026 12:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmZSm-0001KM-2I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:06:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmZSj-0001ja-4n
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 12:06:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MFYArk1044007
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Og/d/09a1Yf2uR58WTQZqcNtKvH1M5hRTkOp1iXsdnc=; b=It7zKDs8NCcrWFS9
 a9hAFpCD0db9+qixwithXzYcdajM6u1zydbdkwIVSbaw2egrpefdSt7gqaXQ0nak
 3UMHY5fTysGuGjWwxnAVdwHj8KEL8s6eSfLsp2Ktr4WcVqK9LuOfG5adGz4AKl0o
 rfAwh5GZ1y8J9jWWoaEfwgzVQknNZgNQ5pPjYFCxSk3ITMNqROfI35bjuhHnf5Ut
 tdBVZOd6xB53XfIva0EbdiEGLmiYMDxjx6Z7/sCfcxX+xTK57bfnDcAO/rCwOhfp
 k6UBJ1P5WhXxEbCdOaawZihOpYyoieDLnnp0lu6mvSW4TFXybSJUa+JKMaYoHzaF
 uRXygQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4u308-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 16:06:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6ef846b33so3282842a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784736377; x=1785341177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Og/d/09a1Yf2uR58WTQZqcNtKvH1M5hRTkOp1iXsdnc=;
 b=WQnsEeM0HWYATHie+8ExyehulI3ATwYbOD/YeYtOI/4Plwah9uRA1wKjzdbnwxoEl7
 Bq2yaS8KrFqvv3ajKQgT1sWYCRxnWgT5ZoDmQnUuNV35LHvFfd7S7N92lVsxZxv5ZkZ6
 hjYNHWrV/b+TZ68NCACRQN2awvMaP+WcuZHJ2ceC/x2CE3r/f4ljuLwSzn0CULQZrXI2
 uqU0lQ3T7NeCwHlgYUuAwUNooqnf3o4qsH+X+7IrWo8CcJCON9nHQ4IBDGTnbR/L+fv+
 81vVj8H/9F0ZHDmjCNsRi1lRBq8cAGG8vp5eYKi5WnNEks4EwA1XKFpb7dug+nAgN4pK
 RDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784736377; x=1785341177;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Og/d/09a1Yf2uR58WTQZqcNtKvH1M5hRTkOp1iXsdnc=;
 b=AojybAxdS5MRp2MeKHPquQm5hP9UVYn+Z3cGOSQYNMRLuOm77e3RDQUW8kIA9bPgCr
 u6I0nMrhz7qyHVZaAUL4epMZY/M+MEcsxjkeNu17zkBRIGbiXVjp/lGQHzME3RSGWDuD
 jL6CpHLwT16vh52GFgim8DmAhrtolTTP3ddE+CefI3vBwrDy5DJDs2Sm+1n8gFt/ssbQ
 tql0Pxu2/dpZ6Azoetwl5J3pcuFFbhDZDOkrZqQ6Wp9QOiJqDZDT91qLkIntuQahraoj
 ZE7BO8L+6XTWFH9RHY3RbAIP+6zXlA16j9jR2cTlzStWRrB8nT/gVgz5b6ZIGrZKhBJI
 al8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL4gM3VZFS/zUrwbBuH5WGlBIiNvKeJzej7yd0oXojEGRKLzR7uAoyfmui5r2u3++f5hA+oOLz+hRH@nongnu.org
X-Gm-Message-State: AOJu0YxuTDc1xL4Bij/yOOfwILZVtnmQDdbbaN65rkTmiONAlXR8XDgA
 e3RZtI/v4VYewLaR2UEhj5fBMHKqFaSGGTwZoqRtOtO+9orYKx9x/7Zp/j3LaJfFqAKAm34Q0RM
 ZfFl1B0u9zaVI548C3jT1Uuj7yoD2J3iTN6mrvTmXOANASH9hbVopPYQ3xQ==
X-Gm-Gg: AR+sD11kz60tDAAM+P6iVzvSCDDnixr0nGTg1WNQRSjxwuYPq5FciErD6EbqOrM64bS
 FlUWIyZdZSTnvslk5hgd1bHTbgzZcx15DGFLhHsupKOVGahj6AxpzfDKtB7swBiyUo2mk5/h6tY
 4XkH022FO6sJKINudXknHiCsQqjkUSjtGdgcSj2wdDEaOUtpu8h8Yfvg3bnl5HW5H1ySptLS0DN
 9sxgxhnk50JsNHqYtEeS+S1kKqxMBlCEojaw5H0kkeD+YpkRh07Qg4/U1KA0fEjupXfspI2Riru
 a8hHPLEGUOIZUwc8yUWLgn/RWkXnz4GTydczwS3bPH2On5FCAGcai7JKULzUgF9Y4a52AGkLs1F
 aY6wf+GO4JfXB9LAFv2sK/mXKddcHhwKe5UhSVRtp5ESPvhmyYKFNXFXYspYV4vTMCQ+k
X-Received: by 2002:a05:6a21:a06:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3c429455fabmr4847879637.19.1784736376675; 
 Wed, 22 Jul 2026 09:06:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:a06:b0:3b3:a66e:3911 with SMTP id
 adf61e73a8af0-3c429455fabmr4847846637.19.1784736376167; 
 Wed, 22 Jul 2026 09:06:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09a9dsm10541375eec.19.2026.07.22.09.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 09:06:15 -0700 (PDT)
Message-ID: <73c6c4f0-9d3a-4160-a124-131e82ad1bbf@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:06:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Guard local FUTEX_CMD_MASK definition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260722123545.743792-1-clg@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260722123545.743792-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0_HVesYCKGg_KFSmog9fGtQ6deQL7H5c
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60ea79 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Oj0kIYrAwerdPWSseroA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE1OCBTYWx0ZWRfXwmE/+S9GVJ9F
 fRczsuE2669DTD8QJ20jw+kPAgta681n7gauqpVxpaTE5ObYf6k5nM72ORx8lM/Oe99T1p6uiz9
 iCP3oYGgLHJzlA2RVPF52tyPgwL60fpQvzHWDIraaroKfkOF/G5ax2rOUgpwdXQl/KyHjuRbMQB
 URkyT/BtjPea8eLQdhFf1opicwUV0rVdCN4Yr7y5wvCPjrFrAtwUT4CX6I0uMQNOLA6QVZb2TCH
 RCJlNWbShFObo0DQUlotOJIkIJYd4jRgD+cGxIWo8Be9ftoEcJMOfElZEGKMj2Yl50kk1Cz7dJ0
 0w6YauUEFVccMhXjfytdFbbiKromNsqsHEBM2wZ9yHQofUmefiHQBxsn0C2gBvR+SzKNWdEFvn5
 /laOnn1aKvovR3Boha9fJ1aY+F4NXcdygneBjoImeNZfdU91+SBE873u79xK2RADIdbBV/zxxfJ
 FVLy1zPhMeuEjuj/cRQ==
X-Proofpoint-ORIG-GUID: 0_HVesYCKGg_KFSmog9fGtQ6deQL7H5c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE1OCBTYWx0ZWRfX6Gw1NiRGPcQX
 bpXjh0gp5a2gTuQ1xMThHVuXYfQWCtml9rUbuILGQGLTH8vq+dmbxpHQfZbqCNy1oDpeq15MhHA
 wkSzzSmtwl7mRBxW0rP+RAnaYmQCdC8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220158
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

On 7/22/2026 5:35 AM, Cédric Le Goater wrote:
> Building linux-user on a host with Linux 7.2 kernel headers fails with
> a macro redefinition error for FUTEX_CMD_MASK. The kernel commit
> 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
> expanded the mask to include the new FUTEX_ROBUST_UNLOCK and
> FUTEX_ROBUST_LIST32 flags, which conflicts with QEMU's local
> definition.
> 
> Add a #ifndef guard so the host definition takes precedence when
> available. The local fallback is kept for older kernel headers
> (pre-2.6.29) that lack FUTEX_CMD_MASK or define a mask without
> FUTEX_CLOCK_REALTIME.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  linux-user/syscall_defs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

