Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CB9CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLP3i-0002eT-Ia; Fri, 08 May 2026 13:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLP3Z-0002am-Gw
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:32:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLP3V-0006nj-Op
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:32:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648G4Ldc1094270
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 17:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=dL0FWoPalJAFQQWvkJNFKra7
 OIo6LvcZ+p2Vwqlo1IM=; b=kbYSGR3ux632KuVLAZ+22VlPIybfWO3+7x+aq4wm
 Oua/v1Uh4gibIVu16YJF61rT4hwWzGpaBvtR2QCXqE0wNkj3bkzWEesJ05Dk8duL
 sJLS4NG+IKAmdsW0WncjdqhRfzBc/3eB2yVAv+9QpjsfETXIvSLbKrD2olAjyMIA
 5jqCylHsFTgDxt13eY2sTdwQ5G+gcF1IurKVtwwX8PggqYKVLKO/BngeJmhOO5SC
 cEnMlckGE0CP6nqbBsQpUs9jBGsg7yAJvOJzECrqHKX9McmO8NOCRvwBgJwIYejh
 ksfdO0LOYSPr0bVOQ97eFsItpQ3j/TJ4FUDcE52wpKsslA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d0afq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:32:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f2d983d109so3184567eec.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778261523; x=1778866323; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dL0FWoPalJAFQQWvkJNFKra7OIo6LvcZ+p2Vwqlo1IM=;
 b=QCAwvjyYqImmERcpIdZP3g4UHcu5wOjO3T+HuF7gBBwnsJw5aMeBqPRWH/Bu3XBewa
 w/fpLmEKGSNesVLFQR1ljH2Lo/cT0FWyTzjO01fNTGNojQTYMcY41n2Z2dlYcWXLQAyJ
 40bGONdcf/3yiwWuDk5KUIo8MGRA8AWkpiP0bIkKbXLrOIRAJeRoEkybjeVB/DJjo2QZ
 3gvq3IsTlL9JaR7K7HZYcFWJM/TO1Gi6aDLTQeo4VqpPg4cfvTViESBrv3X+OKzgn8rh
 ML2uI3idDFj4ndA6Tfj7Dbov/X5QrH2RrJutg6Zub00f37mffHbbY21xLC4kGWGxXE8S
 N9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778261523; x=1778866323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dL0FWoPalJAFQQWvkJNFKra7OIo6LvcZ+p2Vwqlo1IM=;
 b=M0FTOPY3Cilpb2UuHMsFbgw+G4jVhCB3cGYGGpAShUXg2vzELe0blsQzZP30R9Ro6c
 HWOtffXMSMD2tZep+wxGnyhXPgNMJg4nu9rkhdOOt3HZ5ec8W+Dr6GYrSPjR02A89msV
 l/IAcrg3MCLdE/Qj4XhdJq3kXsgt9eoLBRILdiwVd9nDiowaIzGgJ5xkx7sxuN/8yFZw
 bHWno0npecGk7E2K2+HNWVSl8GCRMLbAWfFrj6KUrO0OqnBvuelM8JtniVnSNPEE1sIq
 EPmFm+eFCfuOzFWA50hlbpz0JXAwGCH3GT14JyhTMN0DrAUv8oBIWruTSz/NCUA3f8a5
 qb8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+b89L/CfXPC0gDUpEZ+u3mgRB2HRHE3WQFFp59EqNj290/OT9NsUt+qit/FxMA92LVSa/HX/Rbf1V9@nongnu.org
X-Gm-Message-State: AOJu0YxOit0Lyar2A9AN54a9faWdRspkDuYYZN7F1JvN1RxasXdiK1mW
 UIJp67YnsA/toOpM3VeIu39f9IqSTg922jQ2HPS+iVSBR2PbF1mWiI5lrrC/IGYIMIbWzh4IK5P
 3JHEY8jbBm37vhwzFhV/7EvAu51qu1OO+MwPXuXSsQKAdGTSRqiRw9Rumbw==
X-Gm-Gg: Acq92OHx3T0DvXYP76Lturh+DAeBZL79kgzQT/TRixLlsqdJWaqGK46RUfuxL2YpB3p
 WJHJl2MrFExv7p4YJYHIuKxmIoxSe+aCDJuZ4ginJme68PEaHo5BA0twxP1z5V1g7wnhU37PDMA
 gEC9vd+lTwsuq90KzTVKg15MHJXvTQm34nCgCVBPnFmAi9aA7whnQVJhIZjk5d1DC2MXwyi+PXa
 BazGzX4b2yW/P1J3A1EaM/v4vwagzQPeBAyREhRs6API7XJFa5Qa5wotOVN2JTymtbh32o/cZXa
 KQkOCCFDcwLCQNL+lzpC0MFQSLWBrPAKBTU4TRXuAhoCqzW5DNScpwaoLTUf5QXXs9AjDEZP0LB
 EeMHPiGEGPvuC0AbAUtq2Jp0mMHi/ps4=
X-Received: by 2002:a05:7301:2b07:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-2f85bb7309bmr1811981eec.4.1778261522616; 
 Fri, 08 May 2026 10:32:02 -0700 (PDT)
X-Received: by 2002:a05:7301:2b07:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-2f85bb7309bmr1811951eec.4.1778261521885; 
 Fri, 08 May 2026 10:32:01 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8893441absm3928207eec.31.2026.05.08.10.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:32:01 -0700 (PDT)
Date: Fri, 8 May 2026 12:31:59 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>
Subject: Re: [PATCH v5 3/4] hw/riscv: server platform reference machine
Message-ID: <3ruuacgtajzzzup2oz2ltmvxfrzpkdnclgqsb7hoe7pvzl6y3l@ojdsprixdffa>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-4-daniel.barboza@oss.qualcomm.com>
 <CAKmqyKNZiA=rYVD6ighyFO+qmhdYVk=UgbaznBHrZ2yt1ZvOtA@mail.gmail.com>
 <wazisnbumueun37qskfnjz7n5ioqhpshesebjsczgucjmxxhia@va7avfk77xlr>
 <e172e568-5419-41a3-8a83-baf30e774f0c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e172e568-5419-41a3-8a83-baf30e774f0c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3NSBTYWx0ZWRfX/SzqCGZRZ7Lz
 rInsef3cNrG0QoA4Wxzo2rMSXM0FPvl3gCyc4euDLshoFRL2L4l4wK7i2Y2hgfr1ND2svvs+GwF
 KUpRU9UDQ7BF1g14BjuLfeU+ewdoesrsg3oh4Xsxn3mXJ1GWbnz4X/GFg9y9MqLPvyNKx0dwtJw
 0Wn8qOcsSkrXBcKYA45wnYoAue2Wjanlu1jgWLPM5H7nPG7soVqSTAfdA8Z9f+1F29H+rbOPzcq
 enC/89X8Wv0b+Tyu3LTK6RHVLxawuZrAGamxjSlYgvNZWoeEZNQbj0/3j1buIIw/pj6IXGxSfkU
 IE5midsGnuf9lbTco0AqS1jFY3IC/j00tbqvIcVpMlbkeeRTSMHDhE6vlMiJs6wCrbGAF6wtKXE
 uBtUuhQbGgikdkncSrTYc6hgncffPYyvW+FZ1PvdIUT4EBiYfU3YLEjYo5Hj2NKKllHjsGwjou6
 tG8iZ79NbYiLZpAjcZQ==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe1e13 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=7rmpSfeYsWEgzqFXUHIA:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: srAVv-q7ckYp4HOnI1sUJf56KrZ4BnXt
X-Proofpoint-GUID: srAVv-q7ckYp4HOnI1sUJf56KrZ4BnXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080175
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

On Fri, May 08, 2026 at 01:59:51PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 5/7/2026 4:23 PM, Andrew Jones wrote:
> > On Fri, May 01, 2026 at 01:27:41PM +1000, Alistair Francis wrote:
> > ...
> > > > [1] https://github.com/riscv-non-isa/riscv-server-platform
> > > 
> > > The first line of the README says:
> > > 
> > > """
> > > This document is capturing discussions at the Server Platform TG.
> > > These are not official specifications and everything in this document
> > > may change.
> > > """
> > 
> > The README should have said frozen instead of "everything may change".
> > It was my fault for not having updated it. I have updated it now, though,
> > but not to frozen, because v1.0 is now ratified.
> > 
> > > 
> > > So this machine needs to start out with version support (like the ARM
> > > virt board)
> > > 
> > 
> > I'm happy to follow ARM's reference board's lead on this, at least for
> > now. I only wonder if we may not want to use the QEMU machine versioning
> > support to bind machine model versions to ratified and experimental
> > platform specifications at some point. For example,
> > 
> >   rv-server-ref      -- new, bleeding edge platform implementation which
> >                         may include experimental bits
> >   rv-server-ref-v1.0 -- versioning ensures the implementation matches v1.0
> >                         of the spec
> >   rv-server-ref-v2.0 -- versioning ensures the implementation matches v2.0
> >                         of the spec - likely backward compatible with v1.0,
> > 		       but not necessarily
> > 
> > I'm not sure if [ab]using the QEMU machine versioning support in this way
> > would cause confusion or other problems though.
> 
> IMO we shouldn't use the QEMU machine versioning in this case.  We can
> instantiate a new board in the same server_platform_ref.c file that has a
> different init(), memmaps and etc that would reflect the new spec.  We can
> do that once every time a new major spec version is created (so ... once
> every 2+ years?) instead of having to cope with the all the compat_props
> machinery from the regular QEMU versioning design every single QEMU
> release.
>

Sounds good to me. And the rv-server-ref cpu models can do the same. We'll
need to get the version number into the name, which means this series
should name the board and cpu models something like rv-server-1-0-ref or
whatever works best. I'm not sure if we just want to do this for major
numbers, e.g. rv-server-v1-ref, it seems like someone may want to target
a minor release.

Hmm, how about yet another idea. The name stays rv-server-ref, but then we
have properties for each spec major.minor that get ratified. So, for
starters, -machine rv-server-ref,spec_1_0=on and eventually we can also
have -machine rv-server-ref,spec_1_1=on and
-machine rv-server-ref,spec_2_0=on. Without providing a property it would
default to the latest ratified spec version.

Thanks,
drew

