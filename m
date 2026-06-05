Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B43CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVcxm-0008Ua-HZ; Fri, 05 Jun 2026 18:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVcxl-0008UG-9b
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:24:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wVcxj-00086s-Oc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:24:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655IW3Rn773247
 for <qemu-devel@nongnu.org>; Fri, 5 Jun 2026 22:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xx8qpquMqw9bfnKB/dUWsVInqEsYSbsXNhm6Io5PA5Y=; b=RL2z3YDrgIBmtVSl
 fqvXldbacCOGLVNaDyR6XnlzivT2I5IG3h4WmpZrDu+F12ITiCqvsrY5dh3Rb1aH
 7M+KAgf3mm4Wg/ufvRVCF79RiDlZjejBE3OEZIYIKeVKbhIUrt/qZ+OTXrc+Nf5I
 vS91/N8IkJkU/yRN9zjT+CowRceutf2ssGQWwU5B/UUwEzCsqrEg4JG9EVkz5sUa
 DAtu68+1DGQIcSAvlUJ/j7i5ODyFXlciEQ7w/W+Ty9eXFcwRjYQWhuw8UoVo42cJ
 rVd7z3N68hi+Ecr/o2PwCQnkti1FYoBh0Ij3aj1WBFb1p3zMsgbDr7QC9knZ8xFV
 mqL4tw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em3tg0wk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 22:24:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3074d4102a9so45467eec.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780698260; x=1781303060; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xx8qpquMqw9bfnKB/dUWsVInqEsYSbsXNhm6Io5PA5Y=;
 b=IUrIDymDp/rEx3whMB20S5PQ8F9rZqIhY3qFuLqmCdXfi/B/K+icecWG6iQp3weoIL
 rcX6huz80p2bYME+aYiFXyeC+Tl1/WFSgPvjxhxaBXhesctC6VMPeQA0ZTlfmMp6rImG
 g3m4/yzSKznkKvNKpO89nQ9DtdST9RfwTqGZ9dGRysjgmqdMSACl6qJtiUxMuIR2SQ5W
 K6XbH6e0CDltCmzOXUr/1dz2d4q0Yya34IU2zn+lZqa7ubTliEUP8OV0uWhmoCI/d/eo
 9ar3gCI2ppVj4jWMZso9xzfB9NwTU3nBOD8G/D72hdjE2BWMXvgAmXfmLgG2YhxfyBIL
 9nJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780698260; x=1781303060;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xx8qpquMqw9bfnKB/dUWsVInqEsYSbsXNhm6Io5PA5Y=;
 b=ZZ7uvpiSUlGYhm+cjkjUc8vsrb+2Y0z+iXcrxhyjNavhhLChve7s+9AblqtNVwrF+o
 VGO+dWSPgJHkIyui+4j03kOadna66cjX/LvWMhmfnS65rDdlMZX1LrfxsFsUGGMPElJY
 EnS1K3qPAFmNgk4cy8n3yOKI5ZD0AEiqL9jY+o5/GPZW7JfjqZQskybyOmyXGn3tvCH0
 y6VesDVBkP9DbQ5KSymGDif9QdmBJyx1fssKq0wp7Ifg1YG5TVsS3eoH/PaDAppEc42k
 U5JaJvXNqv5gWw9dHKczfvajnd0zFIwnEnOIBwAMzKSFcBnQEIF5vb1V35nSXhdZKivw
 PTwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iyvSmCyklHC8pBzlxYN1ScUmZqj6BwencdBiGNKE1IbEFPJMzCNbpHAg0RRluo9Nb2a/QSARSLo52@nongnu.org
X-Gm-Message-State: AOJu0YzSJh3/V9hgNF8+W4eijykTWzkCyBp4EBuHjNgJILJWzCX98SZu
 Xt0OshOi0fY3VEHkAMi7ES8KkRk73PphTCReIdHXEQPCGBKPVFIaTF8WqixvgA0I8ANaKuHRPHv
 5pZdUZBCaqakFEGH87rGTW8aKelLXhSlIQFTh49twQwVaZ2no4BwbuXmpkg==
X-Gm-Gg: Acq92OEmfXB/a+wsdVZjvvaGMQDnuZiFj9zUQe7u0CgFyqTdPJRuyr9TpkYkrwhBRby
 NNX9TTm/LVtaMdrf9dlt2e7K5iUDmtifgwPAeVqGacn/R2fhE9dgZ4fcDHgCI01+8rkTzxHWA04
 EPXTUKyFTcpN9embPGAe5SWDFvxOwxhS8tjLt56U07A3gSl1AyeCQN49wlJuigUi35eqYVu2lPR
 KSstyE84G69InrSrGTlJAyQWK1xFbVmOs+FobrK8PNo4Ct+Dq6y118lMvkfZHA67y9kw3ya4xRD
 Voh7A0Y0Tp38+dh9GWmdMvkUXf5ynNzUC6xcs7U+DD5hZf/e01Q1oLpsjTh/n53a7doUWJ3IM9p
 Y2pePhVxxVqa8lF30jXNklyOJnqiHt7L3yillfNTkqQ==
X-Received: by 2002:a05:7300:a886:b0:2c5:50fe:c795 with SMTP id
 5a478bee46e88-3077b2de88bmr2959054eec.29.1780698260106; 
 Fri, 05 Jun 2026 15:24:20 -0700 (PDT)
X-Received: by 2002:a05:7300:a886:b0:2c5:50fe:c795 with SMTP id
 5a478bee46e88-3077b2de88bmr2959033eec.29.1780698259484; 
 Fri, 05 Jun 2026 15:24:19 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df8076csm9634899eec.29.2026.06.05.15.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 15:24:19 -0700 (PDT)
Date: Fri, 5 Jun 2026 17:24:17 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
Message-ID: <5y2sdlx3pu5oyhrm3yxxkvkwv6pl3bpvuzdpnlqg4xt3l2zrxd@yi4h5x2f2xze>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
 <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
 <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
 <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
X-Proofpoint-GUID: 7qknWBHJRkfStjBY1oBeFhAxCnINFJ3x
X-Proofpoint-ORIG-GUID: 7qknWBHJRkfStjBY1oBeFhAxCnINFJ3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDIyMSBTYWx0ZWRfXys/RoZ3aZCCq
 +6tb3NZQf1qTkCg4CYJ15YvzQME5u4mapzZwKgaTLBA//EzkNZGlLeLZQyIIj1e6fPOmsOu1TpL
 O0ekjASerQcHnSwHktJVVZT45u7vFbDgqrpsoFBmR3Qo9NN4zkbIGzVpMwiWAONsUHuOWB5rzft
 UtUUoA95/DPKQV/gF5c0hkgzBxIRzamMah7pNfL1+vNB4XU4ZK2gA8GN6mH+YDk3Jp4v+SKFHb+
 n2/8PPDrlET/HPAIVV11fTbFkMXahoPA6iqgCk7ySOBMWgY9XcfvH1zB1IA+tcsvo+ljUi6lSpj
 l5ilYUlqVXGjYOsrONB/Xp9J6HSyZjt5wk3vjes4y0d+lrpvkTCBTtDyMqD6odxQ0+wIiQGzazG
 3qHwLGd0tHgBexZs2ewvOP8ZPJpfmrJPPTLZsPJWU2M3jRZQkTGsFQALFvJU9LlZ0e6GnfQIcnz
 5EGQMWsLPINeOtMlBMQ==
X-Authority-Analysis: v=2.4 cv=JPsLdcKb c=1 sm=1 tr=0 ts=6a234c95 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QncaINUWJZKf2jjAbicA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050221
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

On Fri, Jun 05, 2026 at 05:48:18PM -0300, Daniel Henrique Barboza wrote:
...
> > You're correct.  We're not initializing satp_mode to max_satp_mode, so the
> > default value is being set to sv39.  This seems to be the case for all
> > CPUs, not just this one.  For some reason I thought we were defaulting
> > to the max_satp_mode.  I need to understand why sv39 is being set as
> > default (i.e. why not BARE?).
> 
> Got an update.  It turns out that what we're seeing is something that is
> only happening to this CPU we're trying to add.
> 
> The way satp mode is set on QEMU assuming no command line input:
> 
> - "Bare" CPUs, aka CPUs that has just I or E enabled: default to BARE;
> 
> - Profile CPUs: default to the minimum required by the spec.  E.g. for
>   RVA23 the default is set to sv39;
> 
> - all other CPUs: default to satp_mode_max from the CPU definition.
> 
> The riscv-server-ref CPU is a BARE CPU that is using the profile framework
> to enable extensions.  So for all intents and purposes the code is treating
> it as a profile CPU with extra stuff.  Which is good, but then the
> satp setting from RVA23 (sv39) is overwriting satp_mode_max from the
> CPU definition.
> 
> I believe the way we're creating riscv-server-ref here is correct, so what
> I'm going to do is send a couple of fixes to allow riscv-server-ref to use
> RVA23 as a base and honor its satp_mode_max value too.

But setting satp_mode_max to sv48 is not correct if that really means
_max_ since we want the reference platform to default to the minimum
(sv48) but also support the supported optional extensions and sv57 is
a supported optional extension.

Thanks,
drew

