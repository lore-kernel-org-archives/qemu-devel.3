Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D161EC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx62C-0005cl-Jw; Thu, 20 Aug 2026 12:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx629-0005LL-Qa
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:54:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx628-0006AD-3f
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:54:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KG6oLD3415065
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cRaYGN7M143Sn6+e6oqelPGQQLSBSJRMuXqmt8oXNbs=; b=WgLoa4iReCR3MwPR
 dMyYNQbSskCXmj27FVv0zEo3j4qNsVuCA8/Db7JENqeG0eZuV72bzLnh5r5Bst/+
 WFptZnIufhQVhxubfO1Zx3PfcnHn2G+hnOxdzEEghsfpoOA7T8jtKn55bojGHbqC
 omz9TNIMjZfK+FfE4J4mF8xSRuM1w31IHN5HWrIyI6/jiE/CBnW4rPviIkGzbMzJ
 OE0Kk9prYbHPZQUjt58ZnwVoectFtU3an/rbzDe2eEd5Ii8lDVapcGmMCM9YW93Y
 J2vDme9YAQCaSTbUciydO3CxGpRLY0MhZRhtpC7fc/7mU9frt+BTnwVrriZs5yq+
 kYZu8Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7tjkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:54:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so85770a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787244861; x=1787849661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cRaYGN7M143Sn6+e6oqelPGQQLSBSJRMuXqmt8oXNbs=;
 b=F6SiJzcaw/ClrO/Fn3eCMTwPi+XEm3wmECeIBV6Xy0zafCyVOMm5YwyGYEWnxJEvsJ
 770R9sayuiMAFfK15ekiC1ZNgGp+tWnTKn8XwuAN9aAbfhqWhrrQkUhPaIRSqqIba48U
 /KAd/OIGdpekJZlC2Sqx8YQfNj9I/nLWPvDsdjStqe48S8q/D+HD19m8pAeHdvKTn/ur
 wf0dSUaThzLHxVc8Ffi0MSIRFgRroHwNvnl/DO2USBHnN/iIsmVBwb+ZIRulF78A1gB1
 d4QDGAvlBdleUpNdSq6SGU2R52fXidbl4csQM3GHEF6QfMjcpHx+J6gtvNNRIJAGUWWJ
 DjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244861; x=1787849661;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cRaYGN7M143Sn6+e6oqelPGQQLSBSJRMuXqmt8oXNbs=;
 b=MRYl8Z1k3M/Tpx0Ay63Hy4VTkQmSYkRbL6FDa9g1n/FlEQzA7tJa+bPdltzR68q49/
 uKVnjEkkDmXOKO4IIu/o5mPGF3sWmjDL41DZcS9hXfk5NX3DgJ1Ss031YlwpK0mQKWhc
 5KUsshoLEsA0+LqSprhZcJ3rhZBiY9TTE0JCTeynASx3DXt3Ii68JmgtC5niq7jlarUf
 z3KpDfIMst/SxoOIo+BWz4DrCWZCxOw3AOwCENDSVBKJfyoNa9jsvecHkBS0gQ1DAHzr
 GSF8IKeEdKlh4P1roy19lNychlIJgbjFsAUtg85N1YYbu249PzD1YIDsDv17gcn6lxU/
 cepA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKQPAWZ27hzT9yWQ4uQsTquSL3TR5VSckNhZA/Ukt11TjS/gI/z4UjqHqnB8qHEdWvoGeYzIBlujMF@nongnu.org
X-Gm-Message-State: AFuF++kRpLBufOd+5GjCz4Dt3sGJT9McZCHQhiEgYbwfKCfeAyzHmDxv
 yLrI5eNL4Q93B2iGGh3HXDJFngsvEcbauIe4PBCgrLfJj3EgfI7/alQk3Aoc1UdeibpchS6+EiP
 SoXajpa9flqeudSfV4II/zKNvrY3ukDr0t8qRUlY6SlVeInRYb3UeMncJIw==
X-Gm-Gg: AR+sD10G7Qi5Zp6okMvmYEqEmmpTAs3NbjyucCj9qfD4wusW1N9O4SZ9U33LP9wTxwL
 ukjBsqdPY0ToUYngkJVvW+Sgwju/DUDL7jt0XC6SOqDPCeVdilLlhWnwtiXDJcDqMTpM3KtWx2M
 NzAx5tkkmzGf33P9CoHZRXAJUpjOwCTxhxpZxgX39+mpsOOadyTl0pZy506dAAZUK/dbG2wTw9Z
 fz2rkBOwjF124ii+/PlUk/jkZiDiMeGkd5VYd3SCks8QVriZ7xQLOFrV06Nb8CcbVUkvoOdVjdp
 NoBRIpLPAHk6Cw1JOTm/nD/LhazOUlp69Vb4z5O+GGgihnQnVw+NdDaB2IcDBf5KX4bfxflGh5+
 ychxtrSoRtE4+VcrDczRnRk208kEOL45DzvqF+joBETSDPcnKS8A/OFj2RAWpdrv+YciJ
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-3958110cfc4mr27198723a91.9.1787244860875; 
 Thu, 20 Aug 2026 09:54:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-3958110cfc4mr27198632a91.9.1787244860338; 
 Thu, 20 Aug 2026 09:54:20 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad3dd15sm16289354c88.2.2026.08.20.09.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:54:19 -0700 (PDT)
Message-ID: <cebd94f1-1fe7-4621-bd9f-2c8fbe16711e@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:54:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/hexagon: decode an empty TLB size field as 4KB
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260819130201.4067696-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819130201.4067696-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfX0ezMivn9Dqrc
 S1hik6d6X5L+r0oEZCk8dWohs0Gd9Los9jeRkiO/1Y3pYyHNhS1fYKeyyjftL7mRc+TFYchAe4Q
 156qoQFfsa71rNtW7dpipmKOWqHLnvrN+6tn3xJwhW7qgJgO8nqAQER0dBGkAXezYtV7MtNiQFd
 SUTpf3/mg+4ozMVkqs1iEJ397+THvPXRPj1pQlkbDv2BF9B4QsiuAtyaQqLA+jHUCp4el0oplco
 lUOdTsvxBVxOGxuS7R+ouLTF4V6W7C/FyzFhpYwkebDWdQDUxFgMG//6I4Nme3/GzEZBh0qI371
 jkWMROZBbgwA19SIygP628al+F/a2Q0ibAnHIar7RNv4mcYTWwai9nyiLrWj0v+Hr6vxidjiY0a
 Xn0Koa35v9B2AdGgUyqbvUK2KEJIKDlAoT9f8QMCLuGB8a5+79CoqKwDdhzZDhGORkutJNaRtbN
 kcO5rjaNHXm6M2an+9Q==
X-Proofpoint-ORIG-GUID: XmWwu9RfdE3jQeT46VQF04RqUrZ_Rq2M
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a873141 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xIL2bMJ6wpxkYZl3OccA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyNyBTYWx0ZWRfXwn9spEJz3I4n
 DnMPT/upu/CMs95CK94R6jhKC83r3B7/g8eGcMqqtcNg61BLBDgG3IW6dcBWaCUzpSvrEXbzYuc
 KvNlelptAD53At9zEqtJWclpmXz+4sw=
X-Proofpoint-GUID: XmWwu9RfdE3jQeT46VQF04RqUrZ_Rq2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200127
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

On 8/19/2026 6:02 AM, Brian Cain wrote:
> hex_tlb_pgsize_type() decoded a TLB entry's page size by scanning for
> the lowest set bit across the entry with ctz.
> 
> A guest TLB write with an empty PPD[9:0] size field but any other bit
> set caused an assertion.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hexagon_tlb.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

