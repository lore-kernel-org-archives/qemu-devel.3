Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE531C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh1U-00027C-D7; Fri, 17 Jul 2026 07:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkh1P-00026i-T7
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:46:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkh1N-0002jR-Sl
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:46:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HASor81695396
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DOPyOCMsDTdWy5j5dgvAXyMoQtHfzbrtqunbqORHEUA=; b=Nr+kvNfg0HylCffD
 dnMjl9MwHDi4DhxDxfb7iZgfd4oNLjH3MomZXl979KfrcoV8VPFFbEkBm6lE5mFc
 5b4az2p9phiyoQlJR+ZxSGo8Ab455PWlMlMF6F3DHfrYhEoSFZxUKiSrHxHaj/qr
 cLFK6H7ivFqq5vLlJ2+Pei+NW7VqFFRp9RS4sZnKgqnlzEW/fVJM532c3z6EfeIo
 g/nfK9O9QdMlC7Cz8K9PvpfrFqNNqD4dvD4UOGt8d/qeCN8nRmybwRilRB+vCGIY
 fUkwSufhUkvrjSoNTMl1ytDxUUABSCkq8TzAUdnsrxSBLNzWHdQBQJx7z4TJl0WK
 6ScF7w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffd3asm15-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:46:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccbb61893fso165797655ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784288781; x=1784893581; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DOPyOCMsDTdWy5j5dgvAXyMoQtHfzbrtqunbqORHEUA=;
 b=kicXU9+15DkXurVW61phroA5unKRMSti7TiRebWmC9bbpExBeKv0lNOWWf+qfscV1Y
 wJuqt1wOdT4M7ROqs/XSkaRqVSiBMnYbnxhRqU7ztFcaW3MiYyFfIH5uAMSfQu9kGsbQ
 itJA7lhucpqTPlij417C+PCoztbA5/UcC2sCxrVB/E/ODQFKFDvoDejSrK7VqgnCT/AC
 SrWJnhvKowXEp62fSl42PlQE8KK99E8s3VbdNyHDMOGGNzyuOCgQluNjl/BEYj2SPV0B
 0d4r4YuqSqrBcZ9rDD1ASqR9z9MsVrkrXQ8EiiNpjLgqpP9HRJldGUCSnmWhNlC+YytQ
 nKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784288781; x=1784893581;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DOPyOCMsDTdWy5j5dgvAXyMoQtHfzbrtqunbqORHEUA=;
 b=DnowJn8oU/aztPCS+iIKZNbcOrx+2ZOllEULEJtFLv2eGtPE3p9nf1wWjeR9Tk/CGp
 Foa5IBVyd+h/pR9jtqevrMimySwfvxXRzuJ5sT0vsdk2tYn6rfOIJwL2M/DtqsnAXBEM
 vqHU8m9HNEKwrBvqmmH3OXApMOyXFdcngaaNDdBlGiNXMGBMhRv0VPiKGobmiX+0Dx+a
 SzVMCdw6Cxn6oJvgoGd2CmqnizavtTX2tz1VVCXP/QLO2YK8N2cBt3RVZGh8/4UZhXey
 LZUJK2h7KwZpbForuK07GUTGYjYcTR5+LSU81Mepm3arZiL5Es+BRyUzX+eNTOmodNxw
 5rKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1an3tEBvud9PPR0VEPq/INo7TgV+YwkRNFUm3NT198tQAgpeyfZ0+uTd608NMtc85dpSad/KlbVSn@nongnu.org
X-Gm-Message-State: AOJu0YzwMqExnEu88LQZktgp1mylkQWXYN5HYMehcfxZep9/PmrbrKor
 xT9ycPbz8977CNoPU1Uenza3Zq/zyaboG8/XDqlfgOuXEpBeXWk3kWIorjc24er/yE6ytqr8gzO
 Eyb4BTzKnrME7+/lhsf+/VhRzllBHXR5uxjal21CLzzbx3lY3w0OBKjr5fw==
X-Gm-Gg: AfdE7cmNdaZy1rvciXjUMwy0Zeynv3ARHkR3u4dKpcioB4DMDDPQoMFxIz2uVWgyRMv
 ds69dh+Byx0qcCbtub0LrafYGkwqfheENj8hG9XoxpfN+2Lpl1TY6RI2IoZ70uiGZFbRIIudNKb
 obS7H06rrLfC8x3su1hK8NrcPAA/KnniXIKgRDixOtbgipKoPxHtEzIFNdNJ+LXEDPXqFL3K4vp
 MkPfvo36OyZOrzf3yeRdx72KyYC22iaaKmth0IB2iLyqO7JuCUC22tTk8Ef4N/DV8BahQbEg+kA
 ACNalNyYxUFODxC+EyBRInmiV9GjvXZtex0ZadfYgNf9GWoY5C7iCfcGuUmWHDfHcKS4hhy3DcU
 6KMe+858g7NeTnRtkuZwC1iqHYGgUERBA439mzcGr6/sosJoOodAYDR3bzsqGNaI=
X-Received: by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e4b3e1424mr2189791a91.2.1784288781189; 
 Fri, 17 Jul 2026 04:46:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-38e4b3e1424mr2189755a91.2.1784288780690; 
 Fri, 17 Jul 2026 04:46:20 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm4862255c88.5.2026.07.17.04.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 04:46:20 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, pbonzini@redhat.com
Subject: Re: [PATCH v2 08/14] target/hexagon: add semihosting support
Date: Fri, 17 Jul 2026 04:46:18 -0700
Message-Id: <20260717114618.140638-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <3cd3a419-ee2c-4d7a-9396-60eab8d26908@oss.qualcomm.com>
References: <3cd3a419-ee2c-4d7a-9396-60eab8d26908@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfX8FhIBU7F/B9H
 ttIi06+2aPWrV1q4QAMZ9SlJjUg/zkMu+7+9mJUQBrykZXCgAyHv0quZ5QijvRWfZGimuqfIRG6
 tyIkvDwJIHoaJo94bLaWklUQk2v6mLQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfX92JaZyBKjmrG
 R39BezjvaUq15/xwZVVZrArBsjdmsbG/tsEHXmFz+pQVsB4Of/MulKzXb36d2xlBOQ2yLSG2UBp
 6kLT2JV/mma4I2qLjHFEhUIuJ3eAPTZrXJT+C93B9mv/yFrQ0oWh1NrFsSv5hOWuOZjVICUsIST
 8jX5tLsLS55ML14JPCJCRQi+JMVmX55HW0mzJlYs39/T1Ec1dLHO168CODK/mJAUapK61zIkHCI
 aS1DSJCW2OblaqpyIh+6en6Jnxl8mf/cGyKejCj0naaPfofrwHaD/XYX3uJmzwixHEmrgMBI9N/
 wpS4RrEffzljo0nkDRqv0YYihOeOgKqgDqe3/YV9150sno7x73LaesWj+s7UkGO+QbJ6Zr5UgqN
 vTWNOV6di3ANNffxxmKfLhZO3lESji+yvwP/VNAykyYsMu8nLwlwIMK50VsWhyA1DQGd4ocXriB
 3Tc5dFch7JDbqo9bAvw==
X-Proofpoint-GUID: EzMZ09DOuBiSu0Q36xyj9xej3gubY_ly
X-Proofpoint-ORIG-GUID: EzMZ09DOuBiSu0Q36xyj9xej3gubY_ly
X-Authority-Analysis: v=2.4 cv=e/M2j6p/ c=1 sm=1 tr=0 ts=6a5a160d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=86x5i4uHXf9FeOCPnK4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170118
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

On Thu, 16 Jul 2026 16:08:42 -0500 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> On 7/16/2026 1:06 PM, Matheus Tavares Bernardino wrote:
> > [...]
> > diff --git a/docs/system/target-hexagon.rst b/docs/system/target-hexagon.rst
> > index 416b8f7be76..36115137626 100644
> > --- a/docs/system/target-hexagon.rst
> > +++ b/docs/system/target-hexagon.rst
> > @@ -91,9 +91,11 @@ Semihosting
> >   -----------
> >   Hexagon supports a semihosting interface similar to other architectures'.
> >   The ``trap0`` instruction can activate these semihosting calls so that the
> > -guest software can access the host console and filesystem.  Semihosting
> > -is not yet implemented in QEMU hexagon.
> > -
> > +guest software can access the host console and filesystem. Read the
> > +`Hexagon Semihosting Specification
> > +<https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html>`__
> > +for details. Semihosting is enabled on qemu-system-hexagon machines by default,
> 
> It's enabled on most of them, but not `virt`.  So probably mention that 
> exception or just describe it as being enabled on the "hexagon-sim-style 
> machines"?

Ah, right. I'll change that.

