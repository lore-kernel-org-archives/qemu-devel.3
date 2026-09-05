Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC63CC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2wYY-0006jB-8T; Sat, 05 Sep 2026 16:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYW-0006iP-Sv
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYU-00055y-Jt
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbGQO2356100
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juq5ZinBhPzOSKDUGTfqthO6Pp9zsRWNDrQ54Ur55pQ=; b=eeKSpBKbfX3ADDXS
 dGAypWy6JIDsNvw/hJXAr4D0IclRv9XzkV6N2XYNNXOtT6VTixOu3v62no7oDEA0
 s+q6qLkousU2Cvs0AurAPIbjsIY7RpNNTkF1Lzrystm/Ccrf/R4/9GjaiTPG17pQ
 2j2YHhr9Jc6fLcu2/1epjhJ2DWmcDPSPkQJwNfxdUolSz98wsoPVsHymzve6fCLQ
 CiOMVmgSrxLtOVNIWfJUfi3a7KesxAxmrq1t55J33kCNx/veEfZcJgqxfH1DC+7R
 37r3DhWlymE9FuWJk5OaxFDhZ0zLUfNrHyevghswvkTwPof7duVnv9fAl/QZIc1N
 yltX8w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbf8j53f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:00:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so19706795ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638400; x=1789243200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juq5ZinBhPzOSKDUGTfqthO6Pp9zsRWNDrQ54Ur55pQ=;
 b=EMZh02by8TF39pZmi1io7YfAqwkROWD39wnf4toqz/yu0zsQxWbkXm+l7BJoPQuSfe
 UMv5WjMV281igkINM38SZz8uFvcXr/sFt0Rdzb0mbptJej2Y8A1gonhZ5WOge5YppaBW
 UVRrKli1xj4H8BBBNrv2Id7L2M++ecEVlVkIvQ+Aanld1mqJvN5vtWLAVbeBB+BwM1Mj
 0x7iSkYDzOmqt+UM5HXm6jpg+A4zkBwd8HTK87QFlcrk1rZjDThvS4n1Gbk8yRtW48C1
 iCAkT8HBci5zRz0V+5R5pGVNbOAtcyOTNscc27EiRpLqFW8TcyYgxIycYU9Y9pa4MjC3
 RN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638400; x=1789243200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juq5ZinBhPzOSKDUGTfqthO6Pp9zsRWNDrQ54Ur55pQ=;
 b=JxpljIjNV1VsEj6guyQJFOCihQTEDCLbKxW16fqehwOHb4y2AJ+AkSQe+wlxSK3aRG
 zqH/uIXvpAGrl4RSITGKjQEPMkhQ5Vx2kmn/TY9XxuVLotD/HnhYwLaXesfAHFug4/GU
 mvM7COSNZmWB43vOJuzprRatamP3ZtlhFu3PhIKnh7IEXJgMBgp/P5fBj8lbaQjFMe9Y
 EynpWeSdUpE0VIYHv4+LIuwIqMzyqESmr8lJYyFkYA1B/cjlFgpHYaL9IIUrMdyx8yZI
 a4pcs4jLA4x68IJqH3CiXRXURQSl3p92xIfStc/ysUIr9aQuer/SMtfSVPPtvBPFBkyR
 6I7g==
X-Gm-Message-State: AFuF++lkrYd26l7dqumxLHvyekJVdqA6qJKoV7YCe/jJkYgbiOtwPECF
 9hq5ryW2fkadHG+lxDBP4cg9xFlDadi5p0/azZClz+A8l7L4nlqduPWSF4ICWkQah9GnXLVdi6O
 ZBGAf4wtXBO8Hf/nwVfFSMJEIZEOd99VAyXfOFHLU7UigBMNF/zr5Y0U4y1usxPYugw==
X-Gm-Gg: AYBFou2ZxITeZ64lgzTOnLi85wH997N2lxRT9rRcRVTFbXcW9TTvudyW88myDXAoBUt
 e4cdnJTjgSWsBL3MWvhmDzvE6PWuPefD5LJD7uQN5en2nMkMxa7NRS7hNfuLzzIjGdQ7ah+WrRn
 SepZ/EsJTamwyCGhl34reBPjc7rw7BbFR5M9GwMYnwH1gKINSnoavqKezccv/fDFXmGq9sG7BcA
 v5AsN0XxO9zOq5DbbwM9rzapQg51K8ctr7BwATX99me5NnS11JeJs68W8s8OLEtBokHY0L8nNXZ
 i7nAbCT5/gOellvPDMN46I8yn5k8bSdYtxKnx4cYL6UdM6MP+/kXKvGCCe5JH7+ARZY/1VKsOi9
 9NqviL8djFdoxS/Irh+7EW7ku8tATMhHK84j+ey5ElF2+i1wH
X-Received: by 2002:a17:903:2a8e:b0:2da:e68f:45b4 with SMTP id
 d9443c01a7336-2db124aacbfmr232627085ad.8.1788638400340; 
 Sat, 05 Sep 2026 13:00:00 -0700 (PDT)
X-Received: by 2002:a17:903:2a8e:b0:2da:e68f:45b4 with SMTP id
 d9443c01a7336-2db124aacbfmr232626745ad.8.1788638399869; 
 Sat, 05 Sep 2026 12:59:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3342af0bc08sm14316431eec.17.2026.09.05.12.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 12:59:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH v4 2/6] target/hexagon: fix HVX scatter/gather region-length
 check
Date: Sat,  5 Sep 2026 12:59:51 -0700
Message-Id: <20260905195955.2001304-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
References: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMSBTYWx0ZWRfXxgwmF5sxxerx
 nsge2Mc5+EzlIUlPDavPDYXWTvKVg7n08obR+Ytxt7BQBL01daywDFa8sl1IeivQnhvX+ZxygRz
 gEh4eZKLKqeL/+xolGAbR+ZvjEzgcHc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMSBTYWx0ZWRfX21Mf029CZ80N
 p+cC8N4JiZd0gN3jjU2O2HyiAJQ8G6fGjz3mikJfgUl5e4kDzGOAgYKujiS8OsTZCp/6CwzDj9q
 A7ALg/ui628fmlhESR/gl3DXVR/PiAqNYvgunqyMdsNQqSjM4xPtNJVmi112yVhxQL9ExRLCY2F
 nGDVsaGmi+LNvznu9kbJ1THAVYtL0yYyfxs1ZcoXHE1wgfQJx8VY5qa9e2lb8zJdf3Nu3a/+wD2
 5csQtFNiuaZfFH5gUXoz3bmk/Wf4XhUo/5WCY2SpjaTkS2mo+rwJ53diHKpqY0PQHBgIn4J8nCE
 F7fOHoN6i8s25II2KT9PxLJR78tCNBIh9oNCauIbHTRVs9pD/xTo0Xyjx8kH1kKLcJoIDkLavP9
 XX6eEZUyCM+SrTbErc3NPVaMr2ddUDpb5cNvvvUEXFZWgZ/LCRFoDleqSLDDI8BoWxnzXjpSmQW
 AePdcHTP+huyWp+TcPA==
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a9c74c1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=dpjYNSh0uHncNrtL9ygA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 3NOMGtq5-b62nYQIhTQwGqM2IHfJ3EJV
X-Proofpoint-ORIG-GUID: 3NOMGtq5-b62nYQIhTQwGqM2IHfJ3EJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050221
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
YWNjZXNzIG1lbW9yeSBhbmQgcmFpc2UgYW4gZXhjZXB0aW9uLgoKUmV2aWV3ZWQtYnk6IE1hdGhl
dXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxjb21tLmNv
bT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oIHwgMzEgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oIGIv
dGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmgKaW5kZXggZTg1YmVlZDMzODcuLjg1OGFmZDk5
NWQ5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9tbXZlYy9tYWNyb3MuaApAQCAtMTMwLDkgKzEzMCw5IEBACiAgICAgZG8geyBc
CiAgICAgICAgIGludCBsb2dfYnl0ZSA9IDA7IFwKICAgICAgICAgdGFyZ2V0X3Vsb25nIHZhID0g
RUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vsb25nIHZhX2hpZ2ggPSBFQSArIExFTjsgXAorICAgICAg
ICBpbnQgaW5fcmVnaW9uID0gKE9GRlNFVCkgPD0gKExFTik7IFwKICAgICAgICAgZm9yIChpbnQg
aTAgPSAwOyBpMCA8IDQ7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUgPSAodmEgKyBp
MCkgPD0gdmFfaGlnaDsgXAorICAgICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdpb247IFwKICAg
ICAgICAgICAgIExPR19WVENNX0JZVEUodmEgKyBpMCwgbG9nX2J5dGUsIFwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNfZ2V0X2J5dGUoJihJTkMpLCA0ICogSURYICsg
aTApLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgIDQgKiBJRFggKyBpMCk7IFwKQEAgLTE0
Miw5ICsxNDIsOSBAQAogICAgIGRvIHsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCiAg
ICAgICAgIHRhcmdldF91bG9uZyB2YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91bG9uZyB2YV9o
aWdoID0gRUEgKyBMRU47IFwKKyAgICAgICAgaW50IGluX3JlZ2lvbiA9IChPRkZTRVQpIDw9IChM
RU4pOyBcCiAgICAgICAgIGZvciAoaW50IGkwID0gMDsgaTAgPCAyOyBpMCsrKSB7IFwKLSAgICAg
ICAgICAgIGxvZ19ieXRlID0gKHZhICsgaTApIDw9IHZhX2hpZ2g7IFwKKyAgICAgICAgICAgIGxv
Z19ieXRlID0gaW5fcmVnaW9uOyBcCiAgICAgICAgICAgICBMT0dfVlRDTV9CWVRFKHZhICsgaTAs
IGxvZ19ieXRlLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhhZ29uX21tdmVjX2dl
dF9ieXRlKCYoSU5DKSwgMiAqIElEWCArIGkwKSwgXAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAyICogSURYICsgaTApOyBcCkBAIC0xNTYsOSArMTU2LDkgQEAKICAgICBkbyB7IFwKICAgICAg
ICAgaW50IGxvZ19ieXRlID0gMDsgXAogICAgICAgICB0YXJnZXRfdWxvbmcgdmEgPSBFQTsgXAot
ICAgICAgICB0YXJnZXRfdWxvbmcgdmFfaGlnaCA9IEVBICsgTEVOOyBcCisgICAgICAgIGludCBp
bl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3IgKGludCBpMCA9IDA7
IGkwIDwgMjsgaTArKykgeyBcCi0gICAgICAgICAgICBsb2dfYnl0ZSA9ICh2YSArIGkwKSA8PSB2
YV9oaWdoOyBcCisgICAgICAgICAgICBsb2dfYnl0ZSA9IGluX3JlZ2lvbjsgXAogICAgICAgICAg
ICAgTE9HX1ZUQ01fQllURSh2YSArIGkwLCBsb2dfYnl0ZSwgXAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaGV4YWdvbl9tbXZlY19nZXRfYnl0ZSgmKElOQyksIDIgKiBJRFggKyBpMCksIFwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAqIElEWCArIGkwKTsgXApAQCAtMTcwLDE1ICsx
NzAsMTggQEAKICAgICBkbyB7IFwKICAgICAgICAgaW50IGkwOyBcCiAgICAgICAgIHRhcmdldF91
bG9uZyB2YSA9IEVBOyBcCi0gICAgICAgIHRhcmdldF91bG9uZyB2YV9oaWdoID0gRUEgKyBMRU47
IFwKICAgICAgICAgdWludHB0cl90IHJhID0gR0VUUEMoKTsgXAogICAgICAgICBpbnQgbG9nX2J5
dGUgPSAwOyBcCisgICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAog
ICAgICAgICBmb3IgKGkwID0gMDsgaTAgPCBFTEVNRU5UX1NJWkU7IGkwKyspIHsgXAotICAgICAg
ICAgICAgbG9nX2J5dGUgPSAoKHZhICsgaTApIDw9IHZhX2hpZ2gpICYmIFFWQUw7IFwKLSAgICAg
ICAgICAgIHVpbnQ4X3QgQjsgXAotICAgICAgICAgICAgQiA9IGNwdV9sZHViX2RhdGFfcmEoZW52
LCBFQSArIGkwLCByYSk7IFwKLSAgICAgICAgICAgIGhleGFnb25fbW12ZWNfc2V0X2J5dGUoJmVu
di0+dG1wX1ZSZWdzWzBdLCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVM
RU1FTlRfU0laRSAqIElEWCArIGkwLCBCKTsgXAorICAgICAgICAgICAgdWludDhfdCBCID0gMDsg
XAorICAgICAgICAgICAgXAorICAgICAgICAgICAgbG9nX2J5dGUgPSBpbl9yZWdpb24gJiYgUVZB
TDsgXAorICAgICAgICAgICAgaWYgKGxvZ19ieXRlKSB7IFwKKyAgICAgICAgICAgICAgICBCID0g
Y3B1X2xkdWJfZGF0YV9yYShlbnYsIHZhICsgaTAsIHJhKTsgXAorICAgICAgICAgICAgICAgIGhl
eGFnb25fbW12ZWNfc2V0X2J5dGUoJmVudi0+dG1wX1ZSZWdzWzBdLCBcCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFTEVNRU5UX1NJWkUgKiBJRFggKyBpMCwgQik7IFwK
KyAgICAgICAgICAgIH0gXAogICAgICAgICAgICAgTE9HX1ZUQ01fQllURSh2YSArIGkwLCBsb2df
Ynl0ZSwgQiwgRUxFTUVOVF9TSVpFICogSURYICsgaTApOyBcCiAgICAgICAgIH0gXAogICAgIH0g
d2hpbGUgKDApCkBAIC0yNTAsMTAgKzI1MywxMCBAQAogICAgIGRvIHsgXAogICAgICAgICBpbnQg
aTA7IFwKICAgICAgICAgdGFyZ2V0X3Vsb25nIHZhID0gRUE7IFwKLSAgICAgICAgdGFyZ2V0X3Vs
b25nIHZhX2hpZ2ggPSBFQSArIExFTjsgXAogICAgICAgICBpbnQgbG9nX2J5dGUgPSAwOyBcCisg
ICAgICAgIGludCBpbl9yZWdpb24gPSAoT0ZGU0VUKSA8PSAoTEVOKTsgXAogICAgICAgICBmb3Ig
KGkwID0gMDsgaTAgPCBFTEVNX1NJWkU7IGkwKyspIHsgXAotICAgICAgICAgICAgbG9nX2J5dGUg
PSAoKHZhICsgaTApIDw9IHZhX2hpZ2gpICYmIFFWQUw7IFwKKyAgICAgICAgICAgIGxvZ19ieXRl
ID0gaW5fcmVnaW9uICYmIFFWQUw7IFwKICAgICAgICAgICAgIExPR19WVENNX0JZVEUodmEgKyBp
MCwgbG9nX2J5dGUsIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhleGFnb25fbW12ZWNf
Z2V0X2J5dGUoJihJTiksIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBFTEVNX1NJWkUgKiBJRFggKyBpMCksIFwKLS0gCjIuMzQuMQoK

