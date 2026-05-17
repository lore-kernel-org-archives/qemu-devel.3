Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD4ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 20:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOi39-0007da-Ic; Sun, 17 May 2026 16:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wOi34-0007d1-Pa
 for qemu-devel@nongnu.org; Sun, 17 May 2026 16:25:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wOi32-0007ZF-V1
 for qemu-devel@nongnu.org; Sun, 17 May 2026 16:25:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64HEUCtb172004
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 20:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1dtVfUgUSwwZldZpn0OG7MIF
 TCIkR2/uRuQfKXp3wIM=; b=UHiE7Td9yZP3gQ6FoCWxyxrQD0K8wlGu5K9KGF0W
 B/25GhPwCPgebKNHkqGpwZPhwJ19/qa5vDSJ9loc5NvBYpwk74wds2LTudulL3Is
 bkaY432IA4d1BpHDuLMuMsIYYD3UPZIcDgBnlniQMcxBWK1rDhOJIQYzoPRt81iu
 soN9ei2aI1++QeboQbbSOjSjwfmx3KUDgBj6dpbXP3ro/SolA3i78mTaxfOAH0yW
 hHxrk7lI1VBKQ/cV8r5/qDhlbRpbLYp4GOEg2ht6+VqrqIljZJXsagYMesUjzXEN
 7m9trzF3d0yyDPos3Zyqj/PWxO2SuEVThQ7/8moITudQzQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0g3gqq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 20:25:13 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12dece274b1so1966615c88.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779049513; x=1779654313; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1dtVfUgUSwwZldZpn0OG7MIFTCIkR2/uRuQfKXp3wIM=;
 b=imZSf1Nr6zP3hacQHqxztCbsGY05cedm9s+nhvRL5hKP1BNuoRSmKwlFMsxwyDg6qZ
 M/Fh4utCrF71mFFmkTSO46BYmDBKnr+F5lcYBNdR4SaStUzwPuoED8Po3zhG8GXdm57J
 DcomWlArJhAvvu4eg9O2nSatpmL0HSb4EhjIDJq3I90PaTLKHPBtV2MzRZ1Y4Ee6qtKO
 JH0GDbL18a8/MnlL1ymXcF8fyec6C6jo/9fpob+ZZ9PJHSOHwZ0ZZtpeizG9FReVBdk8
 O02Mh8Lw2VjAHLbNCUEmKrhyKaspPoFsrdWMldYzitTsXcdDZPQbVxom6X2Wq3LK55qm
 U8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779049513; x=1779654313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dtVfUgUSwwZldZpn0OG7MIFTCIkR2/uRuQfKXp3wIM=;
 b=plLmziWG5kt3vEB3hWUv7b0glOGFK78k+GOtMP/d9Kv+B5eeEPHPzKj5JqeawF6WKp
 EOuy4T8rZudVg8a5ovhUF3ZWLaSaoEIiqtAyMxj5977jy5CdR7zu+fECXChmp+0BiCrI
 vObxHl/T1N8/aHaZMoCMGVL3NCN6IGtxd4cz7JhHdUSuaIyxcABJFNGxGGSg32o+g77M
 0/Sb/5HIOibq60BxBqxXKEfIKgIETF7dX6+BPN5CUtJmRcua9f0yavc7sm2ue2y2LCxL
 5tD9ixtoSIG82TXy7O+S1U7qT+aP/mrnKDoq02os9neyPhHi35qdybVAY+Ws11cMb4Ay
 OhzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9puBsS4gnHnUOAzROcld4btuCGoJO/w3aF8GDn/HX6NcfOM5bQnaUhPyybPrIW+dM+2ycecjFig6el@nongnu.org
X-Gm-Message-State: AOJu0Yx8QK/vY3TYc/BI3b9uY1y7Zifd1/VG0s6Sl7K4O3S1WXX0dCVB
 1utilNBxUYC2ZsAP4kn2g1rqVr6qwPk260eGPMz+x4LKhy13h+quZhPu/DG98fl0eD6vQ6a93HU
 sn5K0ARqDFBlel1j5ZbrD2XjS98QZA2Tg4h8pn5RlmerQNTrlMJI+aHhFXA==
X-Gm-Gg: Acq92OFwlnIKczFDcopXHSmnOk4JIxOClU7Q2j3r4tlL7EaSLwB15uXrDdQoYjXDWA3
 fPaGHLDubT5WyGn5ZHrN9O/pUOJGYGwiFICr67lgaJquH1ArNuqpYWpZo2FJSrejyx90KuDAaLL
 36kDvo4HyAXyFX4bI0qXk0K7fsGP7oEjpj3BOEL91wz1V9OBbc3Qf8HSnJ98ioP8D922CDfdLbJ
 cBGNOlDXjZii6/eLFxBfx/3JWIpsoFe5Xi8TyJZ+1ndXIe9ev0et8a7xQny+Rq5x1zPpJtpkjzS
 5P+2NjmZHZOgkkXdIKV0lSNsriEmKW/wjHpS9o8dV33D+3VDQ6vAKpdVPBwJtnb4layrmCtRmEB
 DCv1zL100dzBGZbwBstuYxGPriMAwCg==
X-Received: by 2002:a05:7022:689a:b0:135:26e2:9b73 with SMTP id
 a92af1059eb24-13526e29c4cmr4508603c88.5.1779049513145; 
 Sun, 17 May 2026 13:25:13 -0700 (PDT)
X-Received: by 2002:a05:7022:689a:b0:135:26e2:9b73 with SMTP id
 a92af1059eb24-13526e29c4cmr4508591c88.5.1779049512600; 
 Sun, 17 May 2026 13:25:12 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cf44668asm14876417c88.6.2026.05.17.13.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 13:25:12 -0700 (PDT)
Date: Sun, 17 May 2026 15:25:10 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v6 2/4] target/riscv: Add server platform reference cpu
Message-ID: <iglchyedne3jhwr6n4b2ayhqtvyubjpha23kxtobuayjkts4xp@vlzvv3iok36o>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
 <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
 <agdgwnLqvEeMoeqk@lima-default>
 <174f03b2-b979-47d2-aec8-645d797ab758@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174f03b2-b979-47d2-aec8-645d797ab758@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIyMCBTYWx0ZWRfX+IdxIVkimPWl
 DgSVO6zsA6uB1tnqMsy5WTME7TpEZbz8dYmXxgw4HgLR9RfMocKqhkx+1l248zgf6hlMUWskgFI
 x2JMnsKT7LrEf5p6VXIdO0w2ZSStIzpdqBdWgIi+To2vXZtMlVNHVCctInhLA7zpDvaqCjn7nZN
 k9bnxs+wzieRtU/86AF2PAicjd/7inV9HM+JTsCf+ouRka/MZLc8zi03PEkPPeXb0lv/KtE+cbF
 QOceSnaUaP1ndkywfoFDRZP5B7951Tfp+Nr5APBEGIuGACNN6Pc9peK6ft0ifnUptxWFaCkF9qV
 +0cVObZoGpMy2xPVdJRTtlnMp9BnQVTkBo2BML60L/hwHay309DuueGpsrWQ7fgcnPhpQ4Km51N
 j465ROJJqQZcEpQjAn/ykyQtsPX7p6UQcQPyKbqBOhqHcwZuNrhXK43eaYHpo1FQDMUL4fUQSqi
 VCLhiaJupkuKjKqbAQg==
X-Authority-Analysis: v=2.4 cv=W7gIkxWk c=1 sm=1 tr=0 ts=6a0a2429 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=uTRCLKPYAAAA:8 a=UyxrdN3CEDufz-4FsiYA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-GUID: twyBkGYhh5oipeULSER_a5iLK0kRF3Lk
X-Proofpoint-ORIG-GUID: twyBkGYhh5oipeULSER_a5iLK0kRF3Lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170220
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 15, 2026 at 04:54:43PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 5/15/2026 3:15 PM, Nicholas Piggin wrote:
> > On Thu, May 14, 2026 at 05:46:38PM -0300, Daniel Henrique Barboza wrote:
> > > From: Fei Wu <wu.fei9@sanechips.com.cn>
> > > 
> > > The harts requirements of RISC-V server platform [1] require RVA23 ISA
> > > profile support and others.
> > > 
> > > This patch provides a new "riscv-server-ref" CPU to go along with the
> > > future "riscv-server-ref" board.
> > 
> > About compatibility, if we get a server platform spec v2.0 that requires
> > a different machine and RVA28 + Sxxx CPU. Is the plan to update these,
> > or add a new CPU and machine types? If the latter, then perhaps a
> > version in the names like riscv-server-v1.0 / riscv-server-v1.0-cpu
> > would be good.
> 
> Good question.  We can get away with machine props to change the board
> behavior based on spec version but not sure if this makes sense with
> a CPU.  I suppose we could live with:
> 
> -cpu riscv-server-ref,spec1.1=on
> 
> to change the CPU setup to v1.1 and so on, but creating a new CPU with the
> spec version in the name like you suggested (e.g. riscv-server-ref-v1.1)
> seems cleaner.  In particular if the spec doesn't change that much - which
> I guess it's fair to assume given that a reference spec wouldn't be much
> of a reference if it keeps changing/updating all the time ...

How about we make the platform spec version properties global properties so
they can cleanly apply to both the machine model and the cpu model?

 -global platform_spec_1_0=on -machine riscv-server-ref -cpu riscv-server-ref

Thanks,
drew

