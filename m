Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4091AC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16Gs-0002BY-Fc; Mon, 31 Aug 2026 13:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16Gq-0002BM-1Y
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 13:58:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16Gn-0000SZ-Tm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 13:58:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VGPcCK4073539
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 17:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vTz958gnS79OoI9st/TWdsA7lCx3UfOS+8am5kUq6kE=; b=KEp4AMIiQbt31K8e
 lNwoUuwGkPIDYoCuQ3B2FdyFJrwdTY1Wz8FXTCLvviCqr/iJoah8v3OwucTeysDH
 MVVlAG32H0bch1I3D8OqOQBABrRPkP3s+/t7BiCQ9dJnTD/Vo9liM7yti+oCSf4o
 h+Ps5I3Q0qQmy50mKWBbAijAWGEXfVZdApESDxfgpMF+K3yo9LyQOsTJ2fe15rjF
 DUeOVG+pIMr+k91gfCoBSZ1vVdhy79FbhQb77oTuNG0b+VmHmOqtcQ7lPabwj3Gl
 1Z3T8sjnk97QQscDg184cwVH9kd9jCi/Q2+JoHydeRKyYVHgzzMj5x2J3eRRjXPj
 d3abzQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4drghs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 17:58:05 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398d7e0f3b4so2186103a91.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199084; x=1788803884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vTz958gnS79OoI9st/TWdsA7lCx3UfOS+8am5kUq6kE=;
 b=H8HAXgsjkeocN5VawBUWLhKkUSofExGUTWHCxeWxhRHMob+gI1IpJMC3Cd8xaoMx+A
 OC7VG+k4IDu9rwzzQSyn6sfxfH48ckUhmuuwTkJ0N4i5k/cYDKkQgRKsuO+HI7YQGX1H
 Hw300MMaw9/Kqr+4IkOrCEcBPDxqVuRcaLQC1RHluk9TYgCjHm2j2A7aymFn3I3f8U+e
 GA0ZgWJnFhb15uY3uO9I/eM0jenEZqyWZGG3egU6Vu8XdrSSPDcMk88l879tRXOMciPU
 x+e8dMfITpsu50+KWy0KVtW+a+O7+noxpjCyxptILvUcl7mLMS/kiMJYcrc1cbQnHt6x
 AGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199084; x=1788803884;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vTz958gnS79OoI9st/TWdsA7lCx3UfOS+8am5kUq6kE=;
 b=OFjL0uY6UqvvfrZD3Qmt5WFW2PBGp7xVmaCc6FnUMsHuhuK4rAYrVqzHSvNvyzzyyJ
 p8v4WlDgjSyMB1Ec1ExR9ll9k5MrDM9VWlzChLPTFc9MjKDT80BtWc5KeChQFzQ2kUPZ
 CLDC4wlkMnZL4S/fWaiIfbQrd9Bz4HpYtXGhLRzLfV0FnHChf5nJAvgs2zXMUCuEk8bx
 /XEsphc8rg1BeiCEN1cV0u/c1rWACvZFnEdx8Lg+ygXPlY3lEXVSwWamh4jxRq+yRfeU
 4ldy/24aoU2D1Rnb4AjVNz+oKG0D9I/IPgSb3NdQcVn+5dYcoKzP99cVeA2D1J6ebMcZ
 c3mw==
X-Gm-Message-State: AFuF++l0qEQuV31gEeZt9BQYASysMF/niHblHj07xJUKyVNL13fgFqtM
 u0By/C+RmoQq9cLi0DP8NY3doXDEG67KruJyI42Z31C+R8JM6L4QHDUYUsawOTDWrnLMF01Kjz/
 sndYiS9n9Fo0jbVfNjBrxp+ggjVDShqZsnWbrk3755RI2I2jxsFBjDUQsOg==
X-Gm-Gg: AYBFou2eNIZI7iia4MVVHWcu1OziiNv1lxtefI8TB9UK3FOBTPb9T7qUY0AxPTQxOfn
 QP3RzzYNO8UDWg5wD3j2Fx+RKwq8l/GGoNFU56YgI2Qva19YO5Dt3q93O33Y2zTU58LaYltc+BN
 3lcTyi+EE6q6SSUlB1vVfVBNaU1nXFi7JqFa1C4KoWrYMjzH9bkUIu9Wkn8j0nw6nmuxWoHcJNB
 8C/QLeoksrLlHR3bl+ze+LAlVU9FYtJhUvPRBCv3zs0co4S8FzB/dsL4GtH8p9B91yMTwrV6mTb
 HxjVbXuSMUFc7J3UpJVnzYJA+MmUZB5Sbab2blutWvV5qW+usGhZpr3MKk7LJY1DNtApD7q2ehs
 gW7VhgsNkpc55Y6+xoEe/t8rye2XHZ1Sfwzc1+Jt9/7LhJFpvnPbENm/NLXokrU+CqyZa
X-Received: by 2002:a17:90b:48d1:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39907e07947mr3334847a91.21.1788199084485; 
 Mon, 31 Aug 2026 10:58:04 -0700 (PDT)
X-Received: by 2002:a17:90b:48d1:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39907e07947mr3334801a91.21.1788199083955; 
 Mon, 31 Aug 2026 10:58:03 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm41646508c88.12.2026.08.31.10.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 10:58:03 -0700 (PDT)
Message-ID: <99f45844-4ef4-4b46-8ba4-21593a0cad29@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 10:58:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/47] hw/riscv: remove machines-qom.h
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-23-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_HU9RO-pQVmrAv76k-oJshpNEgNE64fWb7AN+-eySvdg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_HU9RO-pQVmrAv76k-oJshpNEgNE64fWb7AN+-eySvdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a95c0ad cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=D5tzaz3PprbddFQoL8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NSBTYWx0ZWRfXwzvvLBu+/QdD
 t6LfG4+4I2uvK+CA+Ot7roMVM3WWkr+x4zGVNIGqC3ZcFFIPR0lGKxWRIuCHihG6kuj8e2uNLJO
 XZC1OjybJhnQYoiv8XM8UYrf4Gfk/nIbzq4+SbykDATZhDzRL45Xs1PO0g0vUs4wDD8+q9EYXQI
 PHNkvRGS0s2DJbTSvmZA4a6ZfQ+F7xtzrVaPuB4419PpUpQIJYUU1yxbC4OINzg7I0AuLwevGfj
 slECFFKbcp04Xpg0UaCE2Bodd142N1kxbCAGQiofvap9jgFigBTmXtCAry/ApSQk2S1pQvOFqvH
 hxkJUXkHgGCsXXqfUp1lOlx5vCJE39suRMPiXETeZIubF7+JRkfuOiDDzlFkUd+s5y0M2O+E75t
 BWL/lH1vExH8VxPU+MtZacypLassc9pYe4TDgs4Ze4G4AvXZxDh8b2yW27jyo+f5I3B8M8XLXTp
 xLtA7gQPU2cmUVl61Ew==
X-Proofpoint-GUID: H4-kNgGo7toxou54EN-4nfj-U54DxSnp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NSBTYWx0ZWRfX7Lxk+hRdyQUG
 eA7025hjwC06M770bElUcPskt1DvEaG8GuO8zWhT4lYiV2I67rXmkkd5M2IiE+kJrEDH0LNbisf
 SvakYrmnJQpDFRtzyGINgHbtMOnnwIM=
X-Proofpoint-ORIG-GUID: H4-kNgGo7toxou54EN-4nfj-U54DxSnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310155
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

On 8/31/2026 5:36 AM, Yonggang Luo wrote:
> The changes to DEFINE_MACHINE_* is too much and redundant
> 
> They can be simplified by preserving DEFINE_MACHINE_RISCV32
> DEFINE_MACHINE_RISCV64 DEFINE_MACHINE_RISCV32_64, along with ARM related
> macros.
> 
> For example: for riscv we can do this, we can do the same for arm and
> other arch when use  DEFINE_MACHINE_*.
>

We went down this way, mostly because Richard asked us to factorize
interfaces array to not create static data duplication.
Now we don't need this anymore, this is questionable to keep this.

Since it requires to duplicate those macros/header for *all*
architectures, IMHO, it would be better to not do this. That's why
current series removes this.

> Pierrick
> 
> I've reworked the commits at https://github.com/lygstate/qemu/tree/
> s11.1-riscv-arm-tmp1.0.1 <https://github.com/lygstate/qemu/tree/s11.1-
> riscv-arm-tmp1.0.1>, you can check the commits there, I do not post
> patches to mail-list to avoid review burden.
>

Be careful to not do extra work for nothing. We first need to agree on
current filtering approach, before dealing with details on the
single-binary itself.

...

Regards,
Pierrick

