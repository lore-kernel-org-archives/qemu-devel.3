Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB9BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLLgo-0006nW-ME; Fri, 08 May 2026 09:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLLgo-0006nL-2K
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:56:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLLgm-0004VS-Bt
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:56:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648AcPRD2183373
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=29hjXj0O+VTgEBzOOYbnlDvN
 Y33gF+2sjgq35Tb1vOw=; b=nCxNb99hoZOQZUKTpyU22lePnWsdVshPY8STPGwa
 jyfeevPBmgVg5M+UOMCVfXk9SdVzZ7XjOkRgQCJP32eAaaHBTSA7lCDuyDEm7MYP
 /H1AnnmmoPgmWqh5xuVRqqJFTVnhPvxXZRr6ML51IBD/Xwjc8Kqvt9KZitETSUAI
 cyP4VTzbc8F+ldwpfoC6gvowiaxcJep8yvl34FlPwgolS2n3FpG/VIn6BkH7vuEz
 4XbLBWlmZt84nCExucbT0Lf5cjfzhr4PAZ+f8/JEtL9CGrqnivOaLJ/cVu1aXYjE
 QKLFR7pABakA+jDtcsogaZSa81liaHMoxCgjptheuHwuPQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10pybqtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:56:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so2918472eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778248582; x=1778853382; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=29hjXj0O+VTgEBzOOYbnlDvNY33gF+2sjgq35Tb1vOw=;
 b=JNLxqolQdBsEMthYgLm4gYLG1k3xrZbMiCcAZn+pMnBvlFKP3xfPGrexDfbIftlkiq
 Idt3+fKPebDrm3dwy0eTBwylFxrZDNPCOLxtYzDFcX5hxC4WVxv5xWgjjG8NPqH1e/GQ
 qVAGdG+637yr8kI+zx5z5uanggS6vihDlNiZzYnrbOPNBeXWlbV38z5TR0hShkVHVTVi
 JYMcFXzzkYrradZ78yHCLxoyTAgou3q6KwAfjjwW2NeYDzzzeqOQakexv3vhiI5xejnW
 CSCaVg/7RioFJ8sla/9SYgkb6laUVRpzpQvgoxV5Kd+712q3JyKyCQX6QK211qxUA9+I
 j7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778248582; x=1778853382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29hjXj0O+VTgEBzOOYbnlDvNY33gF+2sjgq35Tb1vOw=;
 b=hwFmJloKtperAK/TlnwD+4h8J+HkKTgUVCS+stMH8SEBoGFKEMqDvPA5D31TripALb
 w1x8wQ3WGr/RE3Qs5zrzWq0XQYzP6KkIroZMfWYOMPsgqfEOYlBqreDjQ7Q9EOkYSE75
 2bhA4goWFN9tikbgLbQRO+SeOiMWxt8XJeIA8g2nrQXQGytZVvwH99tuOHI1aTKNAPw5
 9g6n0GL9jDjNANV9GK7czeDMJoTjvjvwgglCZ7ZoxdmlegJqb0vA9djtGlajft/NLZ3E
 9MkIbrhDLg5U9391BpfX1v1tl3XWbm/gwf5exh5mnc9K+QsZ7In48XKWzqD3KixZqgZW
 uiZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AXPfgnp1HTi/HZY/Mo7zQ/HSS3LbdnrfdEGkAY9lUPsEsAQ8n9owRUu54Rr/+aaF7MtGLwAjgKxr7@nongnu.org
X-Gm-Message-State: AOJu0YyfFG3Hc6qxl0LnFOP9TzqIQzE0pef29pC3TH750a8wbuSIXNo/
 E/VDaii4tYOe/zE9rkpVNINa5CC9pz8v5g6sgiNyTXd4cAtC94ja4m4auBNEBqZR52Z9kJbZiOw
 S3mWQBGHrbPu/b60qyLaz6shMnWQvJkcFAWgCOvyOaX2/sbSTpMhm/Y8GCg==
X-Gm-Gg: Acq92OGejWcWfYybYd1Jl2r+f/cGv4WBs6ZYo1SF3NuURcmhmFspwVd29nQLyOqQ8gQ
 kqso23rKnHUuWMY7bH4ijtA97p9PPlZs0dZDYdlde2iN6Jnqx08ss8xNmhWqgak5D2iRXrtfR8D
 bYs4RzugeXKWgisJxkGPonpDy2XnvCEiuQjv04UPqWTKlHUmmE/ZFo6sUPerOgSpvL5Dd3Hx6Dp
 ZjiEvm7A7eN+x50tJgqlqV+/qS3+qXcNT2BaRD9LOv4NzFg8XRN2/VtoxsZwtQyouFNDT8vN4lF
 PN9Pes4T/mgWXBo42IqIaJ47XYGKPuwTe9bhg7sT/ECcCsfa2roMiKG7zxmEGhMkj4pArCnu0ID
 Y/vYLRz0zm7tpy6ayegogQTUlrIW0FW4=
X-Received: by 2002:a05:7300:ec08:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-2f549f838d8mr5656067eec.19.1778248581661; 
 Fri, 08 May 2026 06:56:21 -0700 (PDT)
X-Received: by 2002:a05:7300:ec08:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-2f549f838d8mr5656048eec.19.1778248581055; 
 Fri, 08 May 2026 06:56:21 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafcdsm2778263eec.6.2026.05.08.06.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 06:56:20 -0700 (PDT)
Date: Fri, 8 May 2026 08:56:18 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 6/9] target/riscv: tt-ascalon: Enable Svadu by
 removing Svade
Message-ID: <dzh6agsjq3aibcqjrtoft3d6d2gjlsslt4d3ta5cgrwa4v7aso@lphs5lq445dj>
References: <20260507043838.45652-1-npiggin@gmail.com>
 <20260507043838.45652-7-npiggin@gmail.com>
 <dic5owmgvmaoqhiinu3v6kcdyakwt6kj4ryfw5vm446w3pv6mj@77kcjokjpnem>
 <af1UmCFaLRERlpwa@lima-default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1UmCFaLRERlpwa@lima-default>
X-Authority-Analysis: v=2.4 cv=DZUnbPtW c=1 sm=1 tr=0 ts=69fdeb86 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=2j_Cf0FjVnBi8qf3eVkA:9 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 8rbUxo72VqfITLcBRS9pExN0sMhCMe9b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE0MiBTYWx0ZWRfX5EvAn9M0O6c7
 qHJ040sg5FvJIAfFFt4u3YTXJV7O8NlBWf29vdWSL02Eo5lCzmIiWQShIC/JmcQpULUMi4jVEdM
 hBjM6OCi2IYldq22RyL++bPdukMlzNfgKejkXYdu5Y3DfKBPUbz6p6xy+n/MQauL1wMtK7ubbzp
 M5/yFCRTyh/Q+aFp4kmveBFLId9paRRpnSBMgQZeIpAo15o7xmBOuthTzKX+xw5vgATHE+8jexK
 lyjfCWH8jsTkSPDjoSuiay4oEm/Epy9eoRykCbmyljtFfnQw60e2LVpHOefSoT8G8e54gdksDq+
 O7d3IuhGHFb34BsaMo8jfqRy9hAZ5nEcLhX27sJkGjxUNFC0zun5dapkqnvqua9+X4GsknQGcp1
 6emRXVbskhygGHHvIU96ski44spzWAI0Af53D6WshBeaH146GUKtWZuCmMNNspgmvI+ii5Y9zPX
 OAj5OzhjMHeMZ5NZlJA==
X-Proofpoint-ORIG-GUID: 8rbUxo72VqfITLcBRS9pExN0sMhCMe9b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, May 08, 2026 at 01:54:30PM +1000, Nicholas Piggin wrote:
> On Thu, May 07, 2026 at 01:57:02PM -0500, Andrew Jones wrote:
> > On Thu, May 07, 2026 at 02:38:34PM +1000, Nicholas Piggin wrote:
> > > Ascalon supports Svadu (hardware A/D bit updates).
> > > 
> > > QEMU makes Svadu and Svade mutually exclusive, remove Svade so
> > > Ascalon comes up with Svadu working.
> > 
> > Hi Nicholas,
> > 
> > Svadu and Svade aren't mutually exclusive, you can see the expected
> > behaviors for the pair in the commit message of commit 70d22fd92c3b
> > ("target/riscv: Gate hardware A/D PTE bit updating").
> 
> Okay misunderstood what QEMU is doing. What does it mean for an
> implementation to support Svadu && !Svade? AFAIKS the spec says ADUE=0
> means the access is performed as though Svade is implemented. I'm either
> wrong about that or miss the point why Svadu && Svade is handled
> differently in the patch you reference (or both).

Your question inspired me to go look at the Svadu chapter again and I
see "If the Svadu extension is implemented, the menvcfg.ADUE field is
writable. If the hypervisor extension is additionally implemented, the
henvcfg.ADUE field is also writable". I think at the time I wrote the
patch I either assumed ADUE could be hardwired 1 (which it clearly cannot)
or I decided to preserve the out-of-spec default behavior that QEMU had
been implementing in order to avoid potential for breaking anything
depending on it.

So the four cases in the commit message of 70d22fd92c3b can be summarized
as follows:

(1) Not spec compliant, because commits 0af3f115e68e and 62108f05e74c
    effectively hardwired ADUE to 1, but this is the default QEMU
    behavior for a long time. Actually, thinking about it more, I doubt
    there is much (any) risk in not supporting this case and instead
    defaulting to (2) below.

(2) !svade && svadu - this is fine because ADUE is not hardwired to 1.
    This just configures svadu at reset. I think this is allowed by the
    spec since the *envcfg registers are unspecified on reset, but this
    is not what we expect platforms to do.

(3) svade && !svadu - clearly fine, just the svade-only config

(4) svade && svadu - fine, and what we expect platforms to choose for
    their reset.

> 
> > Does the
> > Ascalon support Svade? If so, then it's probably best to enable both
> > and leave it to Linux to enable Svadu with SBI FWFT
> > SBI_FWFT_PTE_AD_HW_UPDATING in order to maximize the amount of
> > software supported. But, unfortunately Linux doesn't yet support the
> > checking for and enabling of SBI_FWFT_PTE_AD_HW_UPDATING. We still
> > need kernel patches for that.
> 
> Our docs say it supports both. If enabling both bits is the correct
> thing to do we should go with that for upstream.

I'll be happy to review the kernel and qemu patches needed to get all
this wired up properly.

Thanks,
drew

