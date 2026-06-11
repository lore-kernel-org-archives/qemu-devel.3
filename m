Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFEFCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 21:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmik-00014M-F5; Thu, 11 Jun 2026 17:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXmiQ-00011k-Bv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:13:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXmi6-00046w-H1
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:13:19 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BJ3Klw1457624
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 21:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fgc90fcbKciA/Cz7xdy+u8fZXTv3HYDuBAcemWboxOA=; b=Hy+1c5MA2qn5bxJL
 M2gszus9ja2crKdKALf4fIR8EQcr6mdRiy/1jf1go30HeFHHlE3IYZEHTSH57nME
 r8uS3CBmJKqEPzFSdJWy12tp1GLGFIRCqrn5UuOujH4iNslQHNK1zRrwoF157Zbm
 WaUEy9DJHOC3lqwYxHBA790B91rkT2C3SZQvGR/0FxFNpCA7QUG+L868E5SXYB0f
 Q3No20sS2pLdSksr6lo3vFWEhLtzzDZvOqEvRCsEV4vpGKN8i0yZijCs2sXsyRZy
 NeZdfyOFnGBtuyxO6c15IN3sr6sVrH9zPPK8RG5z92eIVtYKxCwUcIukoxbP3zj7
 kv6rqA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5rgyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 21:13:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5178fc89b1bso3585541cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781212385; x=1781817185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgc90fcbKciA/Cz7xdy+u8fZXTv3HYDuBAcemWboxOA=;
 b=StVlMIB55aW5CFaF4OORfNdhu/1bKovIGQ/D4oln7z5R28nKQ8N3IYPpZAxRLzzQp5
 25HV0L9bu7M4VB/XwCR+mJ+rXAVszKl+z89Xb8pSBRodvf3i8kFx8cPa7kYlc/ctxIcF
 VL0oaXRls/DkqDJPKI9LgOu3xtROcJX1KRjcRO8f0giuM4525874yhhfLjcLLsvmyok2
 wYVJC8UhcErMRCp4wmMP1hf08YlhWYhBNw2pPemTZ113mnB/OhsvA9sLgiiDb4MxDFPf
 f647FRc2BVhZjfrIV4qkRbVlu5gDqsM/YKFeHRbSbQXq6Bsnc4v/3SXNzZUGaNTKRw1v
 6aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212385; x=1781817185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgc90fcbKciA/Cz7xdy+u8fZXTv3HYDuBAcemWboxOA=;
 b=O+U5Kt2a42VJrgpsuxPy10Zwn3vVdH9ktkt1mdmbsijOYcJmnEa3Q0G8c+OxR3q8Gf
 qKEDi8MciObUQAM0/ldhES3Jcudgii3yfMTFYRIKft5uC3d+ji6c1gL8PCeCcXvAmPPU
 RYGL+CAxOrVhMNW6bJbkeedAez6ii3LbLhBFz6BMRtBHIbc0hkaRtd6aHVcrDGiO0Hf2
 OPlgpqyFtVToFEd5/owoE8NY+azOSpDOPAL1N2orMnwQiB2EoUWQsgFH6WyaQb5b5/J5
 5PihoaFD/Hydr6pZhZ6jf2Iv0f5/Lr3ss1CbWumQjp5fLq9NwLW9Lxr/Vrw7dj6R4wic
 2tYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bz5gDrSz/ixrVZGjiQab2wkHYz5FO3aALS9Xael7RciaYHcw/9C8rOK/bmY6F62Y/+qr2JlMUYFCH@nongnu.org
X-Gm-Message-State: AOJu0YziAmDHyAVcA5XFt1AEI5RcEgJ2syRPUhSNJKTnA/RJiZhPl+nv
 79eg88z2gFg2TaOeeOVtQ4qrGijTTS/JchB8up1i/Ls+VHNvCXDAA5hk7Y6jbrHSHUkArijsT2N
 j2rUPqvI1A4NaqLvz2gZH7xGDJqwmm66eRye+Ij1/gJmFaH9yk951eyetEg==
X-Gm-Gg: Acq92OFaMXtd1jpyuZAIUYZ2bgQnvrLFnXc1ShV6kWHCvNbexEdt2xqK1fzTuqI7GVq
 hQdl8DY44WMHw1jjyVa65g2Xjmpo61CN+pJAWkrCVdcR62yO9suougUdVzd5PbGoCNC80oz/EiT
 uvK51S1XciyqyN4XSZJs9jijGjr8RVuFR0ZR5QvDPIEv427VYVv2A1AbjbZ3b29Ijx1YkbVLGpZ
 5H/eMgmgMgbvhYFlzMqRgohpLWwm3NKmxZ2jien1fErpMNEF3ymVz8Q2g38I3vGcxgt1sxohsEV
 0nMSVbK54l7F7y7yR5lMglKAo2IFku/7purLyoh6159Xw5psGpK2nYsQXeZhXyvW4wB2a0dM8rF
 WMrH0w9dreBRDtVGvlZbs8simj2bq2v06er6UHjPB2dCsyJT5a45BRpYZG4+HrBLclhHed4IJ
X-Received: by 2002:a05:622a:1213:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-517ee182711mr73448271cf.25.1781212385459; 
 Thu, 11 Jun 2026 14:13:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1213:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-517ee182711mr73447501cf.25.1781212384966; 
 Thu, 11 Jun 2026 14:13:04 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ea21sm98184875e9.1.2026.06.11.14.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 14:13:04 -0700 (PDT)
Message-ID: <f6c93a7b-b5d7-4d36-b9b9-0302fe912465@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 23:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] bsd-user: Upstream most of the remaining system
 calls
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stacey Son <sson@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?Q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>,
 Michal Meloun <mmel@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>, Alexander Kabaev <kan@FreeBSD.org>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0YywKreXiMNDHEAjbVakdP6CMlrdUjZ1
X-Proofpoint-GUID: 0YywKreXiMNDHEAjbVakdP6CMlrdUjZ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIxMiBTYWx0ZWRfX2UlwUCiZAzFX
 JLLFZX7EN5ORdTXzqmDiDOug9V06Y+iqXVX4pnhQ+M0kijrnxwVG4vfNQJTt+6nZb4XMIWRBuKk
 HgeSS7vsXaWPDCaNqJvaaGAPlc9sy3w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIxMiBTYWx0ZWRfX5u60Uss9PwFq
 fohJ5Lc+nZdc95xODwMkCkpQuTbvhdJUSv6L7axy/6qRjDGXL2zK1YX7ii3Tl73hYNmcWXP0DYP
 ukNzgPkA0z1CkC7LmDh03nZ0Mi6acU3FvakGmvCU5HQ7OX7irmuEYHlVMgMZFl/6yXFu3o9NXCe
 H0Brvc0x5y7b0sZf/f/Gn0GjvR+mj6yVBzPegkPmcHLt2+TYweJXofrEsPpcET6TWLOMmjgVkwz
 TR52ZHUiETThhCHmWyPN4YqMSgbNtjmCgOXH6gOLOPqykLZeznTTai+FudTuvcNc1nVbsdlvclh
 WpRs4UnJuthPWHI4B/HrQMB6kAxOtUeEtdhLu9uAhL/PvnfELkW1tT8K9+3dVViEg4tVot6mOTG
 tbNCoJXsDZGCOFPqmJy4clZlXqPXrO9JIVTJeIEnh+Zs9RpyEYSA8xS7zCnhjWEl0K4EF71hdqu
 rqazlGS1nFZsOQjQaTw==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2b24e2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VfrWkhb2jDIz6cTEUfoA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110212
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi Warner,

On 18/5/26 23:27, Warner Losh wrote:
> Upstream the file, thread, socket and remaining signal system calls (too
> numerous to list here).

While looking at other CPU related code path, I noticed the
CPUState::random_seed field is left uninitialized. On Linux
emulation it is initialized during SYS_fork. Add to your TODO?

Again, this should be handled as common-user/, but that is for
another day.

Regards,

Phil.


