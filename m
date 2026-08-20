Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F7C5DF8C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 21:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxAfZ-0003G1-0b; Thu, 20 Aug 2026 17:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfX-0003FP-Oj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wxAfW-0004Mt-1x
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 17:51:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7mUo3491838
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TKGechPnxBQ3/7mSMz1smJ4UGynnUD45CKMZ6ekzwMU=; b=OkgZvMQSUWKm3kGU
 V2urOpCotXuksReS0emtZG+t58Wl2Z7VNqGIUqdjzgSYcSh+0KF3eOdxMiqERS4O
 Bii3bPhmPiT3mG+TuLn2nrQTYxZE3Ek4dkMeQdmsv33XWYzYTW+iF3HugdqYc11m
 shnwmA/gFHP0Lu5ufdU9jBX3GbhuSTIpFJMVpz/Ds3ZuH0CIuQ4Illa4Z4RQjgv8
 Si8SAe0sQK5ssSeprDHPVKk7kM/8LqHNUXz6LRwFfUciOY85sYptHOBj7X4fjEjL
 3C5c5NUZgsoxy5U+LXaOTKuZkMtP7Ttqm3EtXo09rVXTBKmvsy6gK5+XgS/GESCB
 CMw0NA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcb19v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:51:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc12e8e22b7so744557a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787262683; x=1787867483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TKGechPnxBQ3/7mSMz1smJ4UGynnUD45CKMZ6ekzwMU=;
 b=MAA+17c9FaTMMFC2wGoL9Z18seRx6DtFITGHscdtKj47eXLRgV0gNgn2p6hl7shUiF
 O60Nxtdd5O8if5nrhz0F3Dp6rrdkU8ka7fhc1yHyDW3kTUun39nAan/nnbYcdNrzus4M
 kvwWUDxD4ZN2XvNHxnDpW9XLfPMZPQw/ruRe5rWNqhWmkmT6yVlLS8FM7M5Z2CcaRSgg
 H0IOTADq3fCoKHqBSRXE+Jjq+C7P/f0+Lr9+oZaq526ZWhfqiiKqgF72JJ+1+jxkcYz2
 pBv67LibXanOGJSlJEqkBvLJEGVEpPaF+VqEKDXctpn2t60yGhQ0QBs9GMrXNCEhpzy6
 uTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787262683; x=1787867483;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TKGechPnxBQ3/7mSMz1smJ4UGynnUD45CKMZ6ekzwMU=;
 b=R8bVVOyQRZGYDdDXzW3ISfEClB9i226IZjMBTlIh0jTMYKB/PvDMuT58OXWzq1R4Ul
 lGTle+vJooNqq07bhLPCUQFBm41btMfVM7QxxQORjfL6JZxceXqMtHF4os+J4LckS+GX
 VXDCY4TmMbTwfoA9vSeKHEk3YpCXZ7r8c46EBFHCXG6f1PcTuKxZ1rSmU2u8RiF9DZMp
 f0fsmGZXdAWRdFjeA+w35dlqsKDsMFb82ZC2xDkTVLn6XyUK5iWuAVK3hRA5sCv/qvkn
 hii5nHKTvnBVKUhIGX5uUoMv5ypiIEMQZv52urgTofLvI3X0rIQk5MHlTZR+HzE3TP6A
 wPVQ==
X-Gm-Message-State: AOJu0YzMcd6mbqsFoLSESkjJYhsun5DPmPofvBHn9ofK+xPFaFrm+qgF
 WcIxVVN17zeD0uZWtVodXBGmjyofdfcq9C1BF8EYcQrNZYPYMu5t5OLm8L2mHfoI51P843aCnzr
 Zzp5hmyYDRufRMOcVHD8C1uWgj6EaBWvXwKyEYy4gJEnl2goIQjYld3ONwk96d6sK6A==
X-Gm-Gg: AR+sD10lsDqxKPHFSVpzRAWlOQawwWl+p4yx04Ek4Hj8EHMRN+8ahCXfmJT/CL6PIrC
 XiZSh6Ve3d5ABPtxZPTcacrZ6Qrs38cFQ+JZiaghxv6TB+E3TlPtkyzk9mhb2UjrD/bspDfwnwN
 91lG/H3UwK4MWsJ5FKqAd1bzSlPsdqE90LpFESfai3Y9OEj5z8IrgJ02MQZGLKRZQReZmWmmZCp
 m6dkQUFxpkt87g49QBS+gJt6ZHXkFGarrVyg7Etx+uF2Jp5Or9KvhDsfQwfkyr5aRSTVZEfjEkh
 FevuQwj30OKLdTBDECKyT48Tb2uj5zorjywpbDUBx1nvUSN7e9YwrgBYQDXVSbagGArpSaxykAm
 dsT4eJ1d4j+eK/Kkr0MLYaihNdQw+YM6EnKWdvaopVHX5H4mf
X-Received: by 2002:a05:6a21:a49:b0:3c3:88a5:83e4 with SMTP id
 adf61e73a8af0-3cd2ffbf358mr2916196637.10.1787262683398; 
 Thu, 20 Aug 2026 14:51:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:a49:b0:3c3:88a5:83e4 with SMTP id
 adf61e73a8af0-3cd2ffbf358mr2916123637.10.1787262682982; 
 Thu, 20 Aug 2026 14:51:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327d6168e5bsm9226899eec.1.2026.08.20.14.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 14:51:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/5] target/hexagon: fix HVX scatter/gather region-length
 check
Date: Thu, 20 Aug 2026 14:51:14 -0700
Message-Id: <20260820215117.1788954-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a8776dc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=dpjYNSh0uHncNrtL9ygA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX44gZeUcAgLRQ
 4/VJCXEoSvplO06R9HCfifGsLCZ4UhpuqzOaPm1XFJh6sIEpYhUDG/hxj5rEbeIzfk3Aw40wnBd
 adVE8gUkdM/sIFPXZthHymJO9mQD73hztXrqS/ApBcM+A3SctZANFYsZKf5/JQQCUdlAKD7JS9U
 EFse0UCAjzf4NSDZSScapBv8HGdEvEZLBweTMfPV1I5i8J4qFBQ6AvcpvMKuSRRlfuckQHvgd/Y
 B0LElvH2VLlILUe6neeJzCut+4ZOtSLhdfVzP5CflameGgq9rpQI2qIPO6++2Je03VlxLFihXeM
 znuKjFOlonhuknHwxrtT3eJea9UxsFCoewJIhPAG/FDac+fKU/IjpAjezpzACVpoOtgrskFnN4/
 4imIQ+Y9Z8sCcw6a6JX4dZF/9QyE/18WescF3OaX8yfm/doKg5QNmTur9JU8SfgD5KS9XOOYzwZ
 hFBu93EdOHWpffj5JQA==
X-Proofpoint-ORIG-GUID: 2t5xQAzf9ownW-PjrN9-PIC40BMEsFh0
X-Proofpoint-GUID: 2t5xQAzf9ownW-PjrN9-PIC40BMEsFh0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MyBTYWx0ZWRfX4mGX+QrWPulJ
 trU56NOVAFBZh+k3z109Mv5TP66YfWuosPewkFCYj9nGdw4IjCyyuehBynurZ16b5hCr340eqez
 gJziLT7Rubb60yt8QBv5yYjhs62xeYg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhlIHJlZ2lvbi1sZW5ndGggYm91bmRzIGNoZWNrIGNvbXBhcmVkIChFQSArIGkwKSA8PSAoRUEg
KyBMRU4pLAp3aGljaCByZWR1Y2VzIHRvIGkwIDw9IExFTiBhbmQgbmV2ZXIgYWN0dWFsbHkgZGVw
ZW5kcyBvbiB0aGUgcmVnaW9uCmJhc2UuIFRoaXMgbGV0IHZnYXRoZXIvdnNjYXR0ZXIga2VlcCBl
bGVtZW50cyB3aG9zZSBvZmZzZXQgd2FzCmJleW9uZCB0aGUgZGVjbGFyZWQgcmVnaW9uIGluc3Rl
YWQgb2YgZHJvcHBpbmcgdGhlbS4gQ29tcGFyZSB0aGUKb2Zmc2V0IHRvIHRoZSByZWdpb24gbGVu
Z3RoIGRpcmVjdGx5IGluc3RlYWQuCgpPbmx5IGxvYWQgYnl0ZXMgZm9yIGdhdGhlciBsYW5lcyB0
aGF0IGFyZSBrZXB0LiBBIGRyb3BwZWQgb3IKcHJlZGljYXRlLWZhbHNlIGxhbmUgbXVzdCBub3Qg
YWNjZXNzIG1lbW9yeSBhbmQgcmFpc2UgYW4gZXhjZXB0aW9uLgoKU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L21tdmVjL21hY3Jvcy5oIHwgMzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMv
bWFjcm9zLmgKaW5kZXggZTg1YmVlZDMzODcuLjg1OGFmZDk5NWQ5IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNy
b3MuaApAQCAtMTMwLDkgKzEzMCw5IEBACiAgICAgZG8geyBcCiAgICAgICAgIGludCBsb2dfYnl0
ZSA9IDA7IFwKICAgICAgICAgdGFyZ2V0X3Vsb25nIHZhID0gRUE7IFwKLSAgICAgICAgdGFyZ2V0
X3Vsb25nIHZhX2hpZ2ggPSBFQSArIExFTjsgXAorICAgICAgICBpbnQgaW5fcmVnaW9uID0gKE9G
RlNFVCkgPD0gKExFTik7IFwKICAgICAgICAgZm9yIChpbnQgaTAgPSAwOyBpMCA8IDQ7IGkwKysp
IHsgXAotICAgICAgICAgICAgbG9nX2J5dGUgPSAodmEgKyBpMCkgPD0gdmFfaGlnaDsgXAorICAg
ICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdpb247IFwKICAgICAgICAgICAgIExPR19WVENNX0JZ
VEUodmEgKyBpMCwgbG9nX2J5dGUsIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhleGFn
b25fbW12ZWNfZ2V0X2J5dGUoJihJTkMpLCA0ICogSURYICsgaTApLCBcCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDQgKiBJRFggKyBpMCk7IFwKQEAgLTE0Miw5ICsxNDIsOSBAQAogICAgIGRv
IHsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCiAgICAgICAgIHRhcmdldF91bG9uZyB2
YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91bG9uZyB2YV9oaWdoID0gRUEgKyBMRU47IFwKKyAg
ICAgICAgaW50IGluX3JlZ2lvbiA9IChPRkZTRVQpIDw9IChMRU4pOyBcCiAgICAgICAgIGZvciAo
aW50IGkwID0gMDsgaTAgPCAyOyBpMCsrKSB7IFwKLSAgICAgICAgICAgIGxvZ19ieXRlID0gKHZh
ICsgaTApIDw9IHZhX2hpZ2g7IFwKKyAgICAgICAgICAgIGxvZ19ieXRlID0gaW5fcmVnaW9uOyBc
CiAgICAgICAgICAgICBMT0dfVlRDTV9CWVRFKHZhICsgaTAsIGxvZ19ieXRlLCBcCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBoZXhhZ29uX21tdmVjX2dldF9ieXRlKCYoSU5DKSwgMiAqIElE
WCArIGkwKSwgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAyICogSURYICsgaTApOyBcCkBA
IC0xNTYsOSArMTU2LDkgQEAKICAgICBkbyB7IFwKICAgICAgICAgaW50IGxvZ19ieXRlID0gMDsg
XAogICAgICAgICB0YXJnZXRfdWxvbmcgdmEgPSBFQTsgXAotICAgICAgICB0YXJnZXRfdWxvbmcg
dmFfaGlnaCA9IEVBICsgTEVOOyBcCisgICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8
PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGludCBpMCA9IDA7IGkwIDwgMjsgaTArKykgeyBcCi0g
ICAgICAgICAgICBsb2dfYnl0ZSA9ICh2YSArIGkwKSA8PSB2YV9oaWdoOyBcCisgICAgICAgICAg
ICBsb2dfYnl0ZSA9IGluX3JlZ2lvbjsgXAogICAgICAgICAgICAgTE9HX1ZUQ01fQllURSh2YSAr
IGkwLCBsb2dfYnl0ZSwgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgaGV4YWdvbl9tbXZl
Y19nZXRfYnl0ZSgmKElOQyksIDIgKiBJRFggKyBpMCksIFwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMiAqIElEWCArIGkwKTsgXApAQCAtMTcwLDE1ICsxNzAsMTggQEAKICAgICBkbyB7IFwK
ICAgICAgICAgaW50IGkwOyBcCiAgICAgICAgIHRhcmdldF91bG9uZyB2YSA9IEVBOyBcCi0gICAg
ICAgIHRhcmdldF91bG9uZyB2YV9oaWdoID0gRUEgKyBMRU47IFwKICAgICAgICAgdWludHB0cl90
IHJhID0gR0VUUEMoKTsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCisgICAgICAgIGlu
dCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGkwID0gMDsg
aTAgPCBFTEVNRU5UX1NJWkU7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUgPSAoKHZh
ICsgaTApIDw9IHZhX2hpZ2gpICYmIFFWQUw7IFwKLSAgICAgICAgICAgIHVpbnQ4X3QgQjsgXAot
ICAgICAgICAgICAgQiA9IGNwdV9sZHViX2RhdGFfcmEoZW52LCBFQSArIGkwLCByYSk7IFwKLSAg
ICAgICAgICAgIGhleGFnb25fbW12ZWNfc2V0X2J5dGUoJmVudi0+dG1wX1ZSZWdzWzBdLCBcCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVMRU1FTlRfU0laRSAqIElEWCArIGkw
LCBCKTsgXAorICAgICAgICAgICAgdWludDhfdCBCID0gMDsgXAorICAgICAgICAgICAgXAorICAg
ICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdpb24gJiYgUVZBTDsgXAorICAgICAgICAgICAgaWYg
KGxvZ19ieXRlKSB7IFwKKyAgICAgICAgICAgICAgICBCID0gY3B1X2xkdWJfZGF0YV9yYShlbnYs
IHZhICsgaTAsIHJhKTsgXAorICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNfc2V0X2J5dGUo
JmVudi0+dG1wX1ZSZWdzWzBdLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFTEVNRU5UX1NJWkUgKiBJRFggKyBpMCwgQik7IFwKKyAgICAgICAgICAgIH0gXAogICAg
ICAgICAgICAgTE9HX1ZUQ01fQllURSh2YSArIGkwLCBsb2dfYnl0ZSwgQiwgRUxFTUVOVF9TSVpF
ICogSURYICsgaTApOyBcCiAgICAgICAgIH0gXAogICAgIH0gd2hpbGUgKDApCkBAIC0yNTAsMTAg
KzI1MywxMCBAQAogICAgIGRvIHsgXAogICAgICAgICBpbnQgaTA7IFwKICAgICAgICAgdGFyZ2V0
X3Vsb25nIHZhID0gRUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vsb25nIHZhX2hpZ2ggPSBFQSArIExF
TjsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCisgICAgICAgIGludCBpbl9yZWdpb24g
PSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGkwID0gMDsgaTAgPCBFTEVNX1NJ
WkU7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUgPSAoKHZhICsgaTApIDw9IHZhX2hp
Z2gpICYmIFFWQUw7IFwKKyAgICAgICAgICAgIGxvZ19ieXRlID0gaW5fcmVnaW9uICYmIFFWQUw7
IFwKICAgICAgICAgICAgIExPR19WVENNX0JZVEUodmEgKyBpMCwgbG9nX2J5dGUsIFwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNfZ2V0X2J5dGUoJihJTiksIFwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTEVNX1NJ
WkUgKiBJRFggKyBpMCksIFwKLS0gCjIuMzQuMQoK

