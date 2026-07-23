Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F91C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 17:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmxND-0005hP-32; Thu, 23 Jul 2026 13:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wmxNA-0005gs-R4
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:38:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wmxN9-00054B-5Z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 13:38:16 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NHWr2O053954
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PGbteny9OrO
 /hADMHgLruHRdiWZIiCYj5vfW4/mxZiE=; b=ORC7pEf8Nvh6D7x7I1n0OqxPsLw
 NUHVpCPDNvvutkMidjg7rVovz6Hi+jgcKGpJDbodYsCurYsx7X+NNa5WliwGWXJi
 uR58I6cdFmPIJJ8CoFaudulrkTqKZznFyOUYRRVG+8PNdQczSHnbh20e8J87PcCX
 II86sYQsfF2CKOLFGy7r9En0pZXuDpTi4M77HGKozR6xX7EPobZHm/N3z83LLOJx
 Ppavw6zyXcxCr2AGaA9VRgn66U1DwfcVOS/25+RoG83XAPTb3CR+qTlVPh/crjr3
 K78bHcqGQNmTqjvg0oGPofLDuEZf9fm3YOMRNpFO5VA1qPBmFUTGjOgIrxA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkeuqak4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:38:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3811ae55313so797827a91.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784828290; x=1785433090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PGbteny9OrO/hADMHgLruHRdiWZIiCYj5vfW4/mxZiE=;
 b=S7Yu9Om4JGEAUodlIrKeHCN5CD6S7pQ3MEPhMOwYDra27cq5+2LY32lpe5YfmWwuBr
 wQmTpFIaTMtPPVzHkmNmB8EtFFTEfTM5gJnvFnv7bwxtYCN7XMyAlpqS7DcepdIgiKDJ
 qZaVSVpiYzXPFBMAUqdEk2LPMLitHnBalHwe6kd3ASLpgmeDIqipZrC0otSUB49wqtV1
 osPHVDKm7q3gQBuPNcl9s5bV9xjtmxP574KaD551fTV9XaJ5k/AAuNv4J9i4Ubitr7PB
 PsOPkpcuPhV1fpQHD51JQ06Hogeoq69/Xo86opk1MEJSKoPQL2SxIat/4U3CYBuDWpXL
 1S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828290; x=1785433090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PGbteny9OrO/hADMHgLruHRdiWZIiCYj5vfW4/mxZiE=;
 b=o0soHKFOoud+C9pugHOUBaq+KlMkLMYkzHakQ7Jni8t6aWeTUcbYt+aPGiPzIkXcky
 7/stFcO3cpUfLdyrWdmtZs5M9FQ+plgiuGi/BbD74vVb9Civ/PSMRWjAURe6HX8wWGJI
 /4Te30aJNlIgCXVei+x7WzHAtuwx0yxi1qKFCGcFhoM3OpiXdAlk4+/o03TBQ+j1F6vT
 9cnA8ZOTdZH27pFfBnSzHef3McRM18OZ0OrEg0vAQp1djDaqHtF/ZbcbDUTOsIs+QpFL
 ZAm6lXN9KCxEiWtlzpZzABTsYXW+qdUCfMtoyaF88b3StE76p9t9podB8DPasYO/rUIv
 Xg8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RokObns19dHMIFEEipILeAeK1/j5bYEOot/Wk6upxV7o4K9ThhlXdmgZ8eamxg6D7KpmOnr94P+vRX5@nongnu.org
X-Gm-Message-State: AOJu0YyOfOTRP2KOaMwgPQBIlr9IwupG/htZga/TIQ8aWVNzB5fYKu3v
 43JSvmgSKWk4IcfmoI6FtOOEauDnC/O+7KqvZA63rBHazULWW+miiiPgBX30t8A2fSKvXhzvNt6
 W3pM45ri6Ijsp3PKEV7CT3g5Agn2HvDx9uS2eFdx7/wFSF2XofNt1wOsIrw==
X-Gm-Gg: AR+sD11HylomXNYEtgdhJogKxgizRSJI22yIBdjglTqI2k8mRgM4SCQsgJmBEhKSowh
 E3BOX8Ocfn4yce/oARemNvdvUwUtPVS7wzqapMaPjPXyVVRO/mUPUOFUePobATPBuSblPB0OgLE
 t1nQBJge4y4Pcg+ig4q4c9+DJjMgMihEaCWwPdKUtZwRNSHwwV6w47tYNlkD7RSdtvNYYUKnbrQ
 BU0Bf0IQfugLbS5Pnf/jfvvW8KmZ8BhQ7pxVZrTYjsRJxT7AFYkZMU1scBkE5CLfWx3Be9CfkZr
 1aXfGUpBvS+S6MN17/9oVAvyJ9IUT40pA+ymPn8EUMOGHXQ3CsEYqfB2wFcbqIc37LEsoArhLXI
 Rc9NFdjOxuOK1Yh2EPAnewkickLR2av9oBxXsAYzkFFbzLKZxdtSYMVRBUITBS/c=
X-Received: by 2002:a17:90b:2c86:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-38ec64f1a1amr3720016a91.12.1784828289954; 
 Thu, 23 Jul 2026 10:38:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2c86:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-38ec64f1a1amr3719985a91.12.1784828289413; 
 Thu, 23 Jul 2026 10:38:09 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1302659fsm18350147c88.8.2026.07.23.10.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:38:08 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: brian.cain@oss.qualcomm.com, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, pbonzini@redhat.com, lvivier@redhat.com,
 farosas@suse.de, matheus.bernardino@oss.qualcomm.com
Subject: Re: [PATCH 3/3] tests/qtest: add qct-qtimer qtest
Date: Thu, 23 Jul 2026 10:38:06 -0700
Message-Id: <20260723173806.2696163-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <2b79064b-2cc4-4f29-afba-964db80d7652@oss.qualcomm.com>
References: <2b79064b-2cc4-4f29-afba-964db80d7652@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfXwQowR8RhM5Z/
 svtaED4xSMqPpVSk9jPTYXDUEclISpKhgpN6HdaI0asgQw0EEQ9J5vivTb939j5chtW9jDrSaA3
 9AjwZTMjvnyzBtPHkme1qUIRk5QIvWU=
X-Proofpoint-ORIG-GUID: 2nLxY3S57Ok4n8Q1A4HLk3TNEKUXCNBV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MCBTYWx0ZWRfX1p6G88sabUBp
 A9/ffFXsVUCoVpw+9dZ7xiBmYLkNwsecjb/IjlVNZTexMFqs9m8lK4Dt/VfxWi2O+vjPDvA/jFS
 /VUUbKaTOa0yTLA0vzak5iU2trqPal+2xZUmGkX9N8ctlXGY3Y8ZFTahXQptP+XNfSjQVLSPZW3
 FbbRVPhi+jWM15vRxgbSGbc50oGCM8IxhuuuSbow+pzFquYsJu+mPV07ZobIYKwEEpKIGxBLqPY
 PWQFq7YH5xaZ3ljZ0lc5TSMQ+IGAdOj0dSN5VOYp6gL23/5/ifi9ybDUNmB0ZV4N3jFOPQV2DJ6
 xv4Amb6D5c96m9wJo9y2EblrbL3ISzkmRd7eNCDlaJbfgUY43ObaGMhcxWUtngm6AjOifexzIAb
 8xwsXl6fzXZ/kfbYy6SaR3o1COWnJmY5YqQLFGjlsAbUVO74uUPV7xVyxE11uhVy+J0Wpy9lZnf
 Z3cW1HWbsmVdYS596Tw==
X-Authority-Analysis: v=2.4 cv=cPDQdFeN c=1 sm=1 tr=0 ts=6a625182 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=zosWNQRQVQVyB-GJazgA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 2nLxY3S57Ok4n8Q1A4HLk3TNEKUXCNBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230170
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Tue, 21 Jul 2026 08:07:59 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/17/2026 6:32 PM, Brian Cain wrote:
> >
> > diff --git a/tests/qtest/qct-qtimer-test.c b/tests/qtest/qct-qtimer-test.c
> > new file mode 100644
> > index 00000000000..146d98126ac
> > --- /dev/null
> > +++ b/tests/qtest/qct-qtimer-test.c
> > @@ -0,0 +1,213 @@
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * QTest testcase for the QCT QTimer
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "libqtest-single.h"
> > +#include "hw/timer/qct-qtimer.h"
> > +#include "qemu/bitops.h"
> > +
> > +#define QTIMER_DEFAULT_FREQ_HZ 19200000ULL
> > +#define QTIMER_VIEW_BASE 0xfc921000
> 
> Should this be properties, in case another sec maps this at a different
> address/has different freq?

Yeah, makes sense, IMHO. The current QTIMER_VIEW_BASE value matches v66/v68
machines but not sa8775 (0x263a1000). (Though not sure if we want to add a
qtimer device to that)


