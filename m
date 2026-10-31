Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F432606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VpKyhCJl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ib7pPiqW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvP-0004fP-7i; Fri, 30 Oct 2026 21:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvC-0004VJ-LO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvA-000337-Pg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CEmM1336918
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9vdoJB+bOfJYZR2hWKyfN8SSZt25JALX8XPowdWlNvo=; b=VpKyhCJlj2EldH38
 Fb9tPmrfbJ9bSTT/1IJRtkhWu7Vx79QAXHGl/eTrLjc9YtOjdyJ9IfWUSQmZpADp
 UsPE7VjONnYynhkzm3df7MZ9JlinpfDJu+3X1EcIAYInL1WagtGot2hoJRi3/TOD
 tCuQPjT3MwTAHekqvbJK7zf3vus96O9LUFkJIQuHo+mTHIXZsnd1QZtBPnWHnR0Y
 94ajRlSZy55Jd+gO5LRoRGB35J4+tRpfVBdqT6VKSlxW9KCsTiZ2SHwAnLYEbPrZ
 2T4JjTxXKGyhwOmDPJJ5HUOjdO+Jd/95JXL7hLBofpxuD0oXxTVUqn0J5QGWVK7P
 SY5glA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08n7g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3698bd5392cso1092234eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410210; x=1794015010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9vdoJB+bOfJYZR2hWKyfN8SSZt25JALX8XPowdWlNvo=;
 b=Ib7pPiqWSy1/vRV3CgYTTLHImNvojXxv93RVF2Ap221Djn4UghDaaleqS8sDWbC+ZZ
 WpUfC4jul78gmefnakHNWze02VAoND48dcnEx0zad1d0SYwzm57nvlZpjEDIndU8hotN
 /DdnDpQ7uWDl6odXBqcwNFztHpMh1v60ieCr3P76RP4oNrl71tO6A1G2REGqQ4vJ0O2k
 RVX0xFaRDyB7sPPkqndn2Ku8QP0Xk8hoyuiIgMdNb0RHzGium0XHvqheXd2nILhZ0EkL
 Uln3VOng6wmLy0TibOpfEusMKS+3Z2C4PPjHrb1VyTNml8dUfZBILovAdn3P5S5UyeF3
 MMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410210; x=1794015010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9vdoJB+bOfJYZR2hWKyfN8SSZt25JALX8XPowdWlNvo=;
 b=p6Ufh2vRKlEx9KF+BtctC//xqJaNMVOzrpuqcjN+K4HbNC719PZjj35or+CxNfxVOW
 MskmPiV27Nv6s+lNX3zs4A33YVlnYyE6oGtpH1PceHosSsjDuk0FA8joC6qgrFtRBXMV
 9B7P0WOSGGu2VrHZ5SfZP0P+1sHXwPZM/40jhpbLojYKJnihSNEbownmHRogniobuC9v
 zYognOdMBaUEKSrtLHZukDfn8h7vuNfA9WabcjJoVdA1WQFqcYM35LUwfw9T0rQV0E7n
 SMCQAW++pm4BOUcxZAkM+cylZ8gLkwhJEso6a+hoTeOTazCRwP787ggbq1YslUlvXhr4
 SQng==
X-Gm-Message-State: AFq9FYJ2NJlWvEzY076quLJKOnIezSXDYnk4K8Dc/XlIHyn1ymH0P1qp
 adNItZjfom/6O2VDGVOxIKTeYPzZjDny2F0KB9hlP/pdCi2LTHZQTXyDWTNJW5g18b2C3BntcGq
 zR1PigTsvtnJ5FpGp56EPVBfeT0LXX8UUEj6Cms+9z68/bzZ2UU3t/LlmrRfdVv/ysQ==
X-Gm-Gg: AYBFou0ePndoDKyktmTqqr85ljHGCZjBpGugUXV/A3X9xLfrfoZBWRPwAfW75522sXc
 C36eQh0s3dU+E93R16QKaFvp4WQSQKtnPHw3duwpKMdNXTVQQe2rLSIvC4qciapSLpzftNmbPaW
 fl5OHzfdse3TUnEXe9jr1jg3NTpHKZofci9FGhOET73Wp3BQ/tiIWgFCH4kCZnQCBWmpv540UvO
 1ulwdXmm0rCoUlHdj7kwatgAI2WE04EUjuhCzjJgErSK8vEBnKmIDusbnvJbbCzSZ4KlB7ES4zz
 eyNDtONnVz9GHqcXW3/NUAH0DB7MeeGfaB+GfA73i8thqQISTYHhaiD7qjGDmFjystElIQ4vj/U
 pbuYnWcE/ULU4QN0q+CdWsDLQpt2qPah/jJRCWf3nnsUrpHJFALGf8n7PiU3+yWVi57SLpQgE7D
 SeQe9PYQQps+g0HBhLe5vVIw==
X-Received: by 2002:a05:7301:4715:b0:369:f17d:efb with SMTP id
 5a478bee46e88-36a3002dfe5mr8955873eec.10.1793410210342; 
 Fri, 30 Oct 2026 18:30:10 -0700 (PDT)
X-Received: by 2002:a05:7301:4715:b0:369:f17d:efb with SMTP id
 5a478bee46e88-36a3002dfe5mr8955845eec.10.1793410209746; 
 Fri, 30 Oct 2026 18:30:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 08/40] target/hexagon: enable MTTCG for system emulation
Date: Fri, 30 Oct 2026 18:29:09 -0700
Message-Id: <20261031012941.339141-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: kMw9iLsAQdAv-VktdGX4CbbVBSrZQV_C
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae544a3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=5Nd4ZycxpyYUJ_pc5aQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXxYWy0RRsKtFb
 lM3alFZOcvDv+QYVeEV6uCQI5VTiMdDO6leGK1U8SyumekjB6HEGSlq6ae8GysKpHfKHsdudG8I
 ig0xZmu29oQQUtomuwC+A49TxQWmZ7XGzzh5a6ThozYDrlzsYsnLYl66mfwiOSu6Hyj05Al6wUm
 a65WUmmWlAsgvSrhMz0OnE/5Fm1OUIXDaa8TH0r3+fyb5JEVUqbfGqsjYYBY5ahaxMVW7CSNBJm
 9PNBpTTSV+HaFM1+OYLbKQWrJrOcS4J0OEuPVbU86sH3b4epx7EJftvJ5l2TkdNT3Y/YIasG6Cd
 cXkM4Q9YylZ2W3zuUMn6EVz5RwBjeVoSz1+eoMBPV+Jc4Ij9xfVytavLvHSGeCi4WdA5UKjjV52
 ufhz86MWkVuk/q/qQGmdQ+ZkZOMCjywc4FvVfQVLPrOwDNdI5xTo8iP+ppEa3fnQsjSKC+RAHVF
 4LFu1SRxNwAqBNjGvLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXwTTHd6lSDo3F
 rXuKUrUl6n2WKXIf2e7sOeXPpDm1kzCJAMds7wkdo1suROHs89l6qg7C034R82KscU3fKcFUbk8
 mZ+dGbqh0qvLdash6E2AQ/A0cdBd/0E=
X-Proofpoint-ORIG-GUID: kMw9iLsAQdAv-VktdGX4CbbVBSrZQV_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TGV0IGVhY2ggaGFyZHdhcmUgdGhyZWFkIHJ1biBpbiBpdHMgb3duIFRDRyB0aHJlYWQuICBUaGUg
c3RhdGUgdGhhdCB0aGUKdGhyZWFkcyBzaGFyZSAodGhlIGdsb2JhbCByZWdpc3RlcnMsIHRoZSBr
MCBhbmQgVExCIGxvY2tzLCBpbnRlcnJ1cHQKZGVsaXZlcnkpIGlzIGFscmVhZHkgc2VyaWFsaXpl
ZCBieSB0aGUgQlFMLCBhbmQKZ3Vlc3RfZGVmYXVsdF9tZW1vcnlfb3JkZXIgc3RheXMgVENHX01P
X0FMTCwgc28gZ3Vlc3QgbWVtb3J5IG9yZGVyaW5nIGlzCnVuY2hhbmdlZC4gIC1hY2NlbCB0Y2cs
dGhyZWFkPXNpbmdsZSBzdGlsbCBzZWxlY3RzIHRoZSBzaW5nbGUgcm91bmQtcm9iaW4KdGhyZWFk
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMyArLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDYwN2RkZGY3ZTdjLi5i
MDk5NTVlNDdhNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmMKQEAgLTg2Myw5ICs4NjMsOCBAQCB2b2lkIGhleGFnb25fY3B1X2RvX3Vu
YWxpZ25lZF9hY2Nlc3MoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyLAogI2VuZGlmCiAKIHN0YXRp
YyBjb25zdCBUQ0dDUFVPcHMgaGV4YWdvbl90Y2dfb3BzID0gewotICAgIC8qIE1UVENHIG5vdCB5
ZXQgc3VwcG9ydGVkOiByZXF1aXJlIHN0cmljdCBvcmRlcmluZyAqLwogICAgIC5ndWVzdF9kZWZh
dWx0X21lbW9yeV9vcmRlciA9IFRDR19NT19BTEwsCi0gICAgLm10dGNnX3N1cHBvcnRlZCA9IGZh
bHNlLAorICAgIC5tdHRjZ19zdXBwb3J0ZWQgPSB0cnVlLAogICAgIC5pbml0aWFsaXplID0gaGV4
YWdvbl90cmFuc2xhdGVfaW5pdCwKICAgICAudHJhbnNsYXRlX2NvZGUgPSBoZXhhZ29uX3RyYW5z
bGF0ZV9jb2RlLAogICAgIC5nZXRfdGJfY3B1X3N0YXRlID0gaGV4YWdvbl9nZXRfdGJfY3B1X3N0
YXRlLAotLSAKMi4zNC4xCgo=

