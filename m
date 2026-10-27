Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X26gi+hX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a3cj6411
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKg-0001ah-Uk; Tue, 27 Oct 2026 10:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKX-0000ai-0L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiKV-0006DZ-3C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:39:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoXdU1850841
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=; b=X2
 6gi+hXZkuBYScPIzfuI/UDGiKfUFOqdBPR+Hn23qsA0AitQsrVf7c8WQaMzPL0cm
 DhQuijKMKjiMEsBfW97C1hiddaA0jvdwIJGXImhHihTpNz58xGfh9+t3frz39vif
 kqjV6v/MOuTqh/i/HzHiFMtPgr6w/f7LoAxOuo2R6brD8MPA6TxxKsxMeO6PtMig
 MEJC5hqGo5XDXFQVGZAUBCX9Pe4U5U4TmJqEIhumC1cqE7ONiNPUrtFSZPraakKp
 ROpglHoQboPtjjMTlf962sYJEkFhaXcIYQj2qquv91bHrtKVHGklJQBAsiLcvYKx
 KxZDY3VIGYNuo843xrPQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmc4j1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:39:09 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd633da24f8so5137001a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111948; x=1793716748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=;
 b=a3cj6411Ff1hKJ85PaCAdj2qWck4NjRjm09CFTi1lXgdRCXw3W0J4HLftN8qmBpXuD
 LHQ7k0hqeNqchqTjM7TzYftSx2megMLya66izWDwuWPG2YGUhkm51G60EgrHw8qoRp7L
 N7TQH7KlQLscgzqby3iq/f9V0hcb0vdzhHRTvUxJKUVCLZ3eOP/CSBlfCKFFpnZsXt+g
 B6KQsl4NwiMt5loeeRzpehuczSWOiXzxy1GFJa+M4gATlGKAXWcZLWwmFanX7ejzni0B
 LWlMaL+636ZyEQEcHkAo4Fr6z4c5O80+9sNzBRhKJhuCU71KXL1phmennptyx7bU/ztD
 CRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111948; x=1793716748;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=;
 b=waDWVA1R7XP4yh46dGcLcjQSNfWQa+YNYMkbYPixNHVSo+JiUrFTIp2NuUliWZwf86
 ++TFtgQEG+c6z7p1BiAehvrHJaKXjtp7G25jV3W1SXviaXpqHMa93FpsRI5j6pVxTjPQ
 rwPMRqKbpwT9h6O+LMEarv+gH0kQFkgaPMf7w+68I53rrq3V45Av98NedFSLdGsO/h6P
 9r68ZEVfLk1sYyXQ3FYH7mwAOYTt7e7vmzllg8hqQ47CA9XzHxxqtUS6d2F6nthJTHG3
 FbAiDqCv+AYRtZwVd/jjUjpB0A59JTHM7Il8SyS077w5M6Wv5Wps39kVq6un1NgJhYyZ
 HvkQ==
X-Gm-Message-State: AFq9FYI3g7sWnFJwkRSSUiEWsbvZuEzIQ/W4WkQtlDxUgDk6yuOE0XKy
 1NIlvHiMa0qopwvslVdqT/+o5R9ABD+jH0GGntElfetiQIgX6vsKBjFG7kKFdIgwJ9Amk4z6UmP
 SyhkHQk08xerCCt4Fl6IiRYLNvEUvdCyk7m8j//Pxj58T96tsMkYvFldX3Sx3cbGUHQ==
X-Gm-Gg: AYBFou2nXXclIMT2cbQINpReCdDYXvRwC3psAoCEXuyioRp6Q0wYQ7ZMqiKy+3UN47d
 Hh9lmLTnF1qI90oWttuoCj6SGEA31ys3D6Uas/HizF5lqv0C07IFZHGaghAvo6XHqBDT9E40sAM
 ppEgHKbHwKNKY108lcIt/InApjPgdrCVFnegaSyAy7yfMeL6xUCpvVEQCplIwvNkT1+QSbCPTHg
 0ONZQiI/sOy11otWjaB8Qm7QOJ9VRKTId0fb0DzMJReyLD7jm+YGZoj2GnwOgPeaz6MPZU4zZbI
 lV+j/2WFP3z+rjy240/Vidp7huCBLTvet7CVXRrUFTGBPKkPBJDkm4FFKTKS1BXngp1FDO/YlUG
 VRC2+6MIRI+69yQ8tp/imDDA1h87XvBZnRaGkuns88bWj1ZM=
X-Received: by 2002:a17:90b:3bcf:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3adeafc1f3bmr8257452a91.52.1793111948393; 
 Tue, 27 Oct 2026 07:39:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3bcf:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3adeafc1f3bmr8257419a91.52.1793111947499; 
 Tue, 27 Oct 2026 07:39:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:39:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 38/42] target/hexagon: avoid negative slot shift
Date: Tue, 27 Oct 2026 07:37:17 -0700
Message-Id: <20261027143721.4125584-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX/d0X8zHymz96
 2p4InzvZUDJMSXAg70+MQ0T4sHZiE9CBqCc5nS4R4dIeoBfONsFz4NFaEjKSTuc9fuajJkoSPEw
 eh2I9B4rrOMC6erIN8ff7lqpqc3WPx0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX84OXE55JM/XX
 E15xP1O5rhcmUutNqUigytHhpHjPym5B762iKSllHyscQfaULMm2HkyxGB/bbXg7DBJisd2D6OD
 O0zloqwUtvU0vCBdDbc4rtN7+Tvh9270XXm//pXZTdlcXcPurMxgVTqn1x/JBtuPdeSvUD7nxuT
 oTjkP0hsyoJJgbewfUOFO4pC5haQBX8/ff/tbB/WHOKszfYMuGd6znsdlQwjlRBwPYqrKnoeaZK
 U4HOzkuG6jpvtRQntp/zxGHCSX583S9Fv51Gy/zpx4d3Aj4K3Pa57uYt2KWXDjt3gILNFBytUzh
 KXMVYkGSoynF/tkckA8dl6mFvOQdob4PkFhSFvCVn9WNpuZgQ+5WfsfPx2ci+jJ1XUVHEEwj1Io
 riu56UQCM21pU3HfqMrp+AH6Io+xwToFm9tbpe7xhGnTXdzcd4sKPk96y3keANSYoau/PtE/0vo
 yx1qIpEI3YzkOrUdkag==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0b78d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: fxAJcwZWaVomqsABNmyzldsP7UZ7CdND
X-Proofpoint-GUID: fxAJcwZWaVomqsABNmyzldsP7UZ7CdND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

SW52YWxpZCBwYWNrZXRzIGNhbiBleGhhdXN0IHRoZSBhdmFpbGFibGUgaW5zdHJ1Y3Rpb24gc2xv
dHMgd2hpbGUKZGVjb2RlX3NldF9zbG90X251bWJlcigpIHNlYXJjaGVzIGZvciBhIHZhbGlkIG9u
ZS4gIFdlIHdvdWxkIHRoZW4gdHJ5IHRvCmV2YWx1YXRlIGEgbmVnYXRpdmUgc2hpZnQgYmVmb3Jl
IHJldHVybmluZyB0aGUgcGFja2V0IGFzIGludmFsaWQuCgpEZXRlY3RlZCBieSBjbGFuZydzIFVC
U2FuLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUZFQWNBOENZ
YUo9akF5YzI5UlNkVU1EX1NXcXVKcXo0Zk5ReVc3b0NyV2l0aFpoWUFAbWFpbC5nbWFpbC5jb20v
ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29t
bS5jb20+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyB8IDUgKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4
IDM1ZDc0MWNlODY0Li4wYWM4N2JiZWUwYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVj
b2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTYwMSw5ICs2MDEsMTIgQEAg
ZGVjb2RlX3NldF9zbG90X251bWJlcihQYWNrZXQgKnBrdCkKICAgICBmb3IgKGkgPSAwLCBzbG90
ID0gMzsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKICAgICAgICAgU2xvdE1hc2sgdmFsaWRf
c2xvdHMgPSBnZXRfdmFsaWRfc2xvdHMocGt0LCBpKTsKIAotICAgICAgICB3aGlsZSAoISh2YWxp
ZF9zbG90cyAmICgxIDw8IHNsb3QpKSkgeworICAgICAgICB3aGlsZSAoc2xvdCA+PSAwICYmICEo
dmFsaWRfc2xvdHMgJiAoMSA8PCBzbG90KSkpIHsKICAgICAgICAgICAgIHNsb3QtLTsKICAgICAg
ICAgfQorICAgICAgICBpZiAoc2xvdCA8IDApIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
KyAgICAgICAgfQogICAgICAgICBwa3QtPmluc25baV0uc2xvdCA9IHNsb3Q7CiAgICAgICAgIGlm
IChzbG90KSB7CiAgICAgICAgICAgICAvKiBJJ3ZlIGFzc2lnbmVkIHRoZSBzbG90LCBub3cgZGVj
cmVtZW50IGl0IGZvciB0aGUgbmV4dCBpbnNuICovCi0tIAoyLjM0LjEKCg==

