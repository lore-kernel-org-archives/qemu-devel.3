Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E298C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQlg-0001MF-Kl; Thu, 16 Jul 2026 14:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQld-0001Kz-PM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:25:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQlb-0004XM-Ed
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:25:05 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GHZPHf385069
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ni4svG5i0CjTkwQDAeepecbA0VkJRMlzWhogcbXXfAE=; b=Buat5uZIyGl4gUtl
 Wds7hHBhBRog4epo/hK4x7+qoVUDLrOJl2g6ECPMpQUogxXVdmuaPBg03ApCgpLl
 VtY9FCox4Au1/HcqYAe1FnG4k/byUkEbWflVGRTTT9AjKArokycTpq5xM9jHuTbu
 PWGZDaVtlj03i9pycRUB8H0V6drP6VP3g+niN9UJFiWBd3v9iUHt4ix+y4WRNnof
 sNwu8KXkSNfJlcH1T1M+cX+IimxU3N1zCpyAQ1HQDa9wbXuNTqCv38bHI7P2EZbL
 4cwK8XMpYD9+uNgREaQkJ4yAwmjdVVc+vYRIxM3WuhqjXH2mJ5+4VdTWsb26RYYJ
 MqrH1Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6g64a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:25:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dad28e86eso8311337a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784226301; x=1784831101; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ni4svG5i0CjTkwQDAeepecbA0VkJRMlzWhogcbXXfAE=;
 b=Wo7xPl1v02WVsxqfVBO2URAD7dk7GdjcgvUcFwSUiuWBPE4URItFiuvfK0f3fCGE7j
 QDJN7ijuNUjCm4r7XqnFtYq3SZ7/R9ggo3LdAeun8dyul4o2P3U/WCPKXouWSnzH+3po
 MixlUtL/oS7CDqiqb2lwJqHFLvvEk0P2FawMU4ctWqGeP9gEOdSFEpPrPzXEQT8y9Geq
 l47Nn6eOnfRySn1+iXjtKXxrbD1tMOp2tzrrzZL2u/apCkEy7i/Np7lKv7Hvdeq8VQqP
 Trco5zjOEZsCVR/YOqNAMACVrzrQ6qVNCNUdLRkwePPXP8sqGhajOBuw/nJOS+1i1Tpz
 Ojtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784226301; x=1784831101;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ni4svG5i0CjTkwQDAeepecbA0VkJRMlzWhogcbXXfAE=;
 b=qWhjT8jCMHTJ8pm5tOIfsE119omgzBHeCDNlsQnGprM2cZlXi66VyFM+6WLCyKs8rS
 OsjlRYeRbckFdN8TVGyf15NxKzIb4iLbK3rdDZNM+BsA/RA6mL1YsWXo5oLL1yOqgAVg
 ct4ERXIU51uaNX3KntK7KiHbO1bRZcaEdWCm/AvtwCc9iWou+vSsh6EsMhF/q60/OJVI
 KFW2rva4jg1/RCSLPowSYqJShMvpUoak9a3DY+PgvqkhCGI9xYSCH5fnXfwXAqwJCD7i
 Y4RcjpvPrApaIuw6GMMTBU4VZmSoRz4/kkPAzT6HWpc/x8nlPadT82i2HlUn2LNXd1y9
 R3Ww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8VlPsk+jovW2I3EMecr1SuiibJGypLAOfFtYUOd+26o782q5vNFES7fexeMDHMV+BYd59HrIYyXOx@nongnu.org
X-Gm-Message-State: AOJu0YzR7B/vjnvFsmRS1C6/5nuawo/lYXPKZiDYpdeB/OiIUBThqZHX
 MQzCMDFOoh3KK7TSEZBQ19AEcZgAoX4IWv02ONuoreZFyjRK4eG9rpJS34mMTEoMEiknMkY5gvE
 k6XR86Ewb/+k2OWsUobb/HlxzxEb6fcKaM46QLYEwsXk/fU1fi+bWvOQtKQ==
X-Gm-Gg: AfdE7cmi5qXi9Mje5wug/u6hAT5NITv3NONxfq/qkGCxq0RxC7rjwivRBh+aBUimI9H
 JGw+6f3pDM7cwssanuOfzu2/ciFLAIZ4s0b5xUP/F5ZuQ1IAPp+7FplH7LJGZbPjq1YXeverEhh
 ZfH0Tds0Y6stUWsdMRyG4LpxdkmR4Sc0HW+pl5i3v6gNOucb8cnIv3c3uU/8cGnLY0O1iN9lqMT
 2wwSCGG9iiVe9rKdXj0j6pg43TXsxYG66bPjg+qr1xOmggPRxIq+uf0UG6CQjX9vPhL/yHOVMoi
 JT+wAJYiqHfHHn7hOhRmc9TuYUbWJv/TMtuwjxQKZ/IQlrTODVZhORgBvKtiEuvp174BDztFhPQ
 Q4tDwWPoLfHK+dIPxChAdNQFXPOryELBS19Z3M4o9p6T5Q7HvTIUAwNE7U5d/tDU=
X-Received: by 2002:a17:90b:4d91:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38e467020c3mr653684a91.17.1784226301405; 
 Thu, 16 Jul 2026 11:25:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4d91:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38e467020c3mr653652a91.17.1784226300803; 
 Thu, 16 Jul 2026 11:25:00 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3141dc5154dsm4077555eec.7.2026.07.16.11.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:25:00 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
Subject: Re: [PATCH 02/14] target/hexagon: fix PC advancement for non-COF TB
 terminators
Date: Thu, 16 Jul 2026 11:24:58 -0700
Message-Id: <20260716182458.3644994-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <0ba08125-d396-477e-8b8b-061954062a78@oss.qualcomm.com>
References: <0ba08125-d396-477e-8b8b-061954062a78@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfXxHMdYdS7T8V3
 +inCIDzt20PvA8M8hZ52BwexlbWwrVLR//ItDckZu5bQRNalW/xc2uHnpgZ4g5HpWi+7ImlOtLX
 JCB79oqPN+D8XUNZdnCjg77B+DABZw3kbNrOsJg+L77GMbMZK8LZbVF6iYdFhA/dUXAiaiObis8
 2U5RJxj2GWbCzQ7EROC3X9W4TG/xcRAAFWtowNbWe7GbBMCkP5vWk9G1pc0E+2pqL/h+m8pkcP+
 rrPHVfQwHxxIUbvjcif1R484uTOcvGYM/UFw4Q43XBNrwQTbaLciRtN44w5lhXiEInb0kgmsKgG
 VEaGDzcqp8yES6ovk2+o7UaVlsDiBcphGQWBB7hwI2e+A4IenewStpfb1e7xRolbfHMTZn34Hio
 V4UFeN+tzMs/R+xauc8RdgqnMe8gJu7ipzDbgdYK5KRfCilr5VqCwDqJtCUXIH9snU4vrxMW0CT
 e9M6V8ya4uOE6C6bO9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX4/sCVsfEhsP9
 +rv9Z985oJYswzKIZVF3Zh6lxAwS3JHYEki87cv3pPiDBgrHnoZU4/HgbkGbddj48yDmKjtT4On
 4ZNiY3GI2xAlmHAes9Hc4tK4RDJonlk=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5921fe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Au4T-wFq6BvrhHgFApoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: E8XmjALcVUPR407hP_6aqrNUUwucn7wM
X-Proofpoint-ORIG-GUID: E8XmjALcVUPR407hP_6aqrNUUwucn7wM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160189
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

On Thu, 16 Jul 2026 00:08:57 -0500 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> On 7/13/2026 3:07 PM, Matheus Tavares Bernardino wrote:
> > Some packets end a translation block without a change-of-flow. These do
> > not update the PC during commit, so gen_end_tb() leaves
> > hex_gpr[HEX_REG_PC] pointing at the same packet and the block gets
> > re-entered forever. Set PC explicitly to next_PC in that gen_end_tb()
> > branch to fix execution of next blocks.
> >
> > Note that gen_start_packet() used to have a special case for
> > tlblock/k0lock, setting ctx->next_PC to the packet's own address. This
> > relies on the tlblock/k0lock helpers to properly advance the PC, which
> > is never done (only env->next_PC is updated, but that never reaches
> > hex_gpr[HEX_REG_PC]).  Drop the special case so these packets advance to
> > the following packet like any other non-COF TB terminator.
> >
> > Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> > ---
> 
> Can you try 
> https://lore.kernel.org/qemu-devel/20260709230645.3033240-3-brian.cain@oss.qualcomm.com/ 
> to see if it works instead of this patch?  I think it should satisfy the 
> same need.

Yes, that also solves my issue. And your version is more complete, so please
feel free to drop my patch in favor of that one when applying the series to
hex-next.

