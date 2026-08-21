Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82759C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxTox-0000fm-Sz; Fri, 21 Aug 2026 14:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wxToq-0000f3-Ge
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 14:18:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wxTon-00076p-RY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 14:18:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LI9xfY2716870
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 18:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HVjJLju+xnp
 P7hP7qi2bizYyou4GP0Lk/jI45yjV/2I=; b=UV2Z/p9wRKsaXzS762V3qZyjYEq
 1begc80PqOr3lLLanenqnJHxqQE6GKRBN2F3tQxDRD74lywVW4RazCDXoAPAHOon
 8/EcSnDDuwsEQTEV4RrQCJDdIEFgFCWwEQGMdYD3mwpRWpq1DfL2JSR8wgxIU6kO
 ncOSM1tDUoaqFQlbr/sGJ67Qex0TvOPLFk8P4MpSYiaOfPm/PUqKPnT0GxdNxFIb
 NvVA3cgRz6UM1iID2GAlbxAC8hfmULJZoEVVvgqw9kjnFZQUly7UF3iDHuJOB4am
 ZlU7MS9cPnipljlrv2mbc0M6gbsvr3fHWwI3kX5pVRg/x0jSUD0lsSCJuAA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6u5jg62p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 18:18:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so2202320a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787336290; x=1787941090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HVjJLju+xnpP7hP7qi2bizYyou4GP0Lk/jI45yjV/2I=;
 b=j5VQGD9ptlG0xgB6xTKpg/dPGBP5ZEHCwnVqLxGdvGDlLzPEpDkg71yG7kn/I9Dmji
 GhQNpEJGxd/UR+I5aThqPRdNw9dtcbrDzbZwDk6N0ih+fbHYNtOX2A6BO61wXlkk39ut
 5QS5oRnURZruWTkAgeuuzd8Siqr6QJUpP6QE+ed1N+KDFOScprN+0uPYW9ax3C4LnjsU
 EDueT98Xp0aCt1H80tI4rtN0ZWRSrlNLZZN/h9zA0R4TrtEBschPK5LCtbNtzxs/wXcK
 JNwO4C7gyUhq2ZSPBRzu2tCcT7zX5gzbT4Du0Z9SrgU6OHHHC6qCGJ3IN0BeuFkdfFQW
 D//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787336290; x=1787941090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HVjJLju+xnpP7hP7qi2bizYyou4GP0Lk/jI45yjV/2I=;
 b=UnHAOwYcjjfAZTpDN62SJGf5k5p9pklV2MpnsWkaJ7eABDU1YSGWk77ooCqHOmIJpm
 XBmfEXgwF60hNteNjYNo4bxxNPm11L6U6ntCxW9VN+cthipC7biKQp4nIZJo+DiqZf2c
 1qrB+tc1XAbyi2P8ZGXWU599zh9swigwlrjf7t7q5T/U9JORBYZOaNVdTvQSn91Ww4Cp
 RmCufUNzYoEv67C6pHaP/53IE53FtAtHe8JYKILAE3rj/Yo9cag+DGcIrYb68DALuY9y
 NKOdonrrmoUCfT8a2KyYGIC45x8IGN/Xl62AsGnNHi0xJFIoSf0VtrsO+5rh4dpffwnu
 zbAQ==
X-Gm-Message-State: AFuF++ni9q0gC5BC9KcBYcRx+c2tCGxduq6507n7aXS8OM7E38QjRGWa
 rtkbh1JN0RejONt0lDUG4qxDEvBDPJYfkw8rYGESzSTc3T/OYz9H6nyMQACMwsNM5ZD5bn0mh+e
 GLkGxrKz5fdgj0Y9HVGPD+LJYtEaz3cIMDLrOiXxOerbk1h7AwLM+Ld4Brw==
X-Gm-Gg: AR+sD13u/XuAqOm/S5oDL5YFIpIV+cCeX/WmrhA+kdGZt+C9ySf2vQmr5zFHQYN7xvT
 qcQRuOR+avu6Wuea75UgMWvnLqSHkm8YhSjBcCNaHta2yWNrvEa3K9Dwqq2JZ6+6Pj9Da13ScLZ
 DLUivRrDtSPDOQ816zqi/KOU0cAgQ21Vd/AWZm99Z+rGPCgKH49eC/9rZ5MT4x/lpLYzxs992A7
 kqznW00hXVvxoHBPZHdN0mMQyxnu9p5JpV9udPJhTk6C/COfGAMSaTfJnIMJ9Rbz9V5Gb61PqcB
 T8Sh+iaP6RdaRDEz0bCZHvBpayRo27cnbvAFEsgzrgtNYX8yClvSSdzqL3npzbXhwgKqPKAPggy
 s+wzY8H5Z0AD4OSWE419vxQbu9D31PWiVM6IwXynTQ0/yx4Hf9n0YBBsdjesCXs8=
X-Received: by 2002:a05:6a21:7482:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cd301b5175mr17428357637.18.1787336289742; 
 Fri, 21 Aug 2026 11:18:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:7482:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cd301b5175mr17428234637.18.1787336289175; 
 Fri, 21 Aug 2026 11:18:09 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141860c697esm2927c88.3.2026.08.21.11.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:18:08 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, anjo@rev.ng
Subject: Re: [PATCH v2 1/5] target/hexagon: fix HVX big-endian byte access
Date: Fri, 21 Aug 2026 11:18:07 -0700
Message-Id: <20260821181807.401644-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20260820215117.1788954-2-brian.cain@oss.qualcomm.com>
References: <20260820215117.1788954-2-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE0NSBTYWx0ZWRfXxOgm3f/8z1TS
 oPMPIcphOcg9UAdepERSlLcDK89Hkr0lf39+kS8rkMlVMvG+AMT+p/8muvBVuymcKlOq+wRDbkN
 8ZUU4J7Of/PQDDJ+v09IPY4I1yPloRo=
X-Proofpoint-ORIG-GUID: YyGD5OKVX0dLKQAljs8FVjdSDuxIKCFA
X-Authority-Analysis: v=2.4 cv=ArTeGu9P c=1 sm=1 tr=0 ts=6a889662 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=v8w7YoRDcQgudEaQPPEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: YyGD5OKVX0dLKQAljs8FVjdSDuxIKCFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE0NSBTYWx0ZWRfX3q0vKvpRnaRf
 CK5jCCCJoO/b/SKq7XJclhWMfYCPWvdSsmOZgFqjg15hKupE+62HmMNr767MZHoPXSijo0SXKbT
 nXHOJzh9rGqlK20YRWwa/nkWRx4jiMubSC575bFixQSGQ+lcXpKRZPuxbTPK+Lu2Ng3bCVc0fCo
 U+h7ZZ/JiD0QXjMAFk7xcoQbU6qb2tReSyEcL9/z2NprUPpeRlSpa55FJ7PqOve3vunIyGl48Qk
 049NScZ4guKsskbfYkYy5RTdzw7wmom+emsDa9sQoFYuIss0VRPTSIeurvXPWj6ZoXNxu69cXOZ
 T/JiNVDfA9jAXHK2sDU0xZ9XmtA2/ZfOAdN442lVbAjfcbQ2r8bsrME3F7QJuL6jHoeJpaIlzf0
 +WswsJnKGV7Oy7mLKDrxs47FItxcZPcqK+n62QBEeK32NKYziaHjcEYeIT/yOP7HouaA9Hd0Bng
 PkcUK4buEGi1+H0TDxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210145
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

On Thu, 20 Aug 2026 14:51:13 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> Keep HVX lanes host-native while converting byte indexes at memory
> and helper boundaries.
> 
> Also place vector comparison predicate bytes according to host word order.
> 
> Suggested-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h           | 23 +++++++++++++++--------
>  target/hexagon/mmvec/mmvec.h            | 18 ++++++++++++++++++
>  target/hexagon/cpu.c                    | 17 +++++++++++------
>  target/hexagon/genptr.c                 |  3 ++-
>  target/hexagon/mmvec/system_ext_mmvec.c |  2 +-
>  target/hexagon/op_helper.c              | 17 ++++++++++++-----
>  6 files changed, 59 insertions(+), 21 deletions(-)

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

