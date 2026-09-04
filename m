Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61770C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Idh-00079b-Bs; Thu, 03 Sep 2026 21:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Idf-00078i-Df
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Idd-0005J6-Nm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 21:22:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683NbdJu1260699
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 01:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juq5ZinBhPzOSKDUGTfqthO6Pp9zsRWNDrQ54Ur55pQ=; b=pxcODZky5PRHALXr
 EQqAkpISmO0ju5ILXrN8HqMis7HrvBokWowPKARxQgMDA/NazvmyEqi+3q+Y80Wc
 7KZGaEt0SKASqwMpglEYJJBdBLPYJX8/2GDAml/w0S0MpyUgckTBwSriB6GjzR0A
 My87pNByIl+HCW0jAfjDRdR/izZR+GmiMEa40zzMCsTQkhXUPcgYNpcpRcZ01B4B
 Ewpmnhrz5hf1Uc92vrmd0S6Ks4jV0tB61hmJiS59xZ3csAbIusoTnT0Y7qjizBA8
 UZmrd1+LjRYSkGNlyzwlAVKYvyRuDely5d+mxLrTOxXxY4VuPW/jlF4/HZ/OI/cg
 bh/K3w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyp1gcw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:22:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1c18c775eso1859713a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788484958; x=1789089758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juq5ZinBhPzOSKDUGTfqthO6Pp9zsRWNDrQ54Ur55pQ=;
 b=P2R0HSAImxu16JPCc8g0/fNnUWB2aYihO+NwM5qQGkZOLkj+5gyPg6fOHMwKvptubx
 HYLNNqrIkbcf3vQzOKzsFnoey76dlY53Ukfd+JhU+/GJcYSWl+0avU6EkCAKqWuTVZ2L
 viYbAI8E8Ta3fdy+QAyu8hIzLuH5mvwFuQoYl9sdI1yOSCnixeqjRv2DQ50g5y4QbURY
 MGRn0b/bTdH+WDuhUsuwBnOf5HVOI99ZT801t2KB5n+nryrY2k3j6p0sERxiQTFgrFNM
 UPhKUKMg9LJHnVN+vYfrZW4lod1i6JUPo8NHs3MxMjZ9PqXX3zi+0zflqn35niyg/eJK
 rZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788484958; x=1789089758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juq5ZinBhPzOSKDUGTfqthO6Pp9zsRWNDrQ54Ur55pQ=;
 b=gcDpvM3i5pVlaHCznHUxgd2Lld+gtiTh6DuuMnrIMQFXtjrqpGfqG0Zihza2lzM115
 skokwXcnVDaYuj1ueeFFa/TN46mtThwiW/8VkaYgl6/zEYg1EN2TyomCLXhhq+6geAuL
 gaTaHgIf7jAJ9RRn6PJMjJwurwi7RgDXRzTjs5/hL8uGCsoO01YSuHp0MIDmX5XoqqOV
 gijqrkyFgIl6ZpnJVonYb7VaFeQYHrfyt7QrlJ6JXzN/3kRTaf9hTlSfRsdwxSxtOiJi
 ZJajPOeuBLpgUFnyaxVDWGHlGBThIEQEFz4cWq34GLRsYyEGO4jGQ83z/Ig+iHXuwRp0
 T4wQ==
X-Gm-Message-State: AFuF++n4TgD7sFOCUxo/rixB86FFYiQHwo335Ybj9FI9nI3AT+FKHyQA
 i0Jct56XJCZpgewkbpeOYcnLloQsQ+XO66R05tKdUUNSHqM6aU/X7smRDHGjF6J9copVYZspgnw
 gWGN4jUtjnsxWfT/3zJ0+l8NYdW4j9XxlfNGPV/fVtWfBhk3deqjJQhKR1CLhkavZ3g==
X-Gm-Gg: AYBFou07DUtQ3YRygTqNgDqgDEN6PVldrGOhrUovEOSFS+Iir4pv4aYbBFSztXhgcwH
 n4qFSLMbYnqz64MPfUXvinXaovOPjaucWPryOsm0T6jwoW3YGEm3buBVQt9Q3WMlZKL3JUse7kT
 RiAnoKarcwOnaHKXlx8Rya28dHCOuAqkDKHH8IcZwdPalYE1VZpOet63wFYMoOb4eqNhVBKXpQp
 9i1RiHJcudGICytnZvRp96ZB6eLM97N8Jx9Y9ZljDvXRBnPlwfccbE7ktSCKDyuccfM2e7Z5EM9
 pNcNjACjQuhRRcawSCWq+tqCjGgT/ab/wpA4nMmu7WwUtvoEm7DgOcvBXKVk04fG+JC7s47aR7u
 ryFJ19ZxEPYoemm9OJ4S6QRFiWOg/E8dmu1wIFlDLamzYVSgo
X-Received: by 2002:a17:90a:ec84:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-39b07f44dbdmr11643926a91.4.1788484958345; 
 Thu, 03 Sep 2026 18:22:38 -0700 (PDT)
X-Received: by 2002:a17:90a:ec84:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-39b07f44dbdmr11643883a91.4.1788484957879; 
 Thu, 03 Sep 2026 18:22:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339885ca07sm2573234eec.1.2026.09.03.18.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 18:22:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH v3 2/5] target/hexagon: fix HVX scatter/gather region-length
 check
Date: Thu,  3 Sep 2026 18:22:30 -0700
Message-Id: <20260904012233.3607547-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: WQmAJuFTqN21GMz0VhIQIHe6aL-SEhQO
X-Proofpoint-GUID: WQmAJuFTqN21GMz0VhIQIHe6aL-SEhQO
X-Authority-Analysis: v=2.4 cv=Q5XiJY2a c=1 sm=1 tr=0 ts=6a9a1d5f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=dpjYNSh0uHncNrtL9ygA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX0+KDpo5r7fe3
 dg3Gppc1y+UapGfyXgIOdfwJDjZMzQ0btYgGXZ2iNC55DLeg9BPM5mRzQwYFWAZ9rRsvTT4556V
 vgz3Bx6XkE1la0epTSXl1i5KSaPeLUHibjLNHOXfVZVFHr8ahWZfTb/ik1PlT9rX4sVIIMorWtE
 xTHQmzpCq48wDOJq/pZKv1+gO6JfV2cQK2oXFsbUVyiPl87j033vqUE93xAC1lcDCsylGM+4LCS
 LbuOpVdD2tuMkJ8SSQU6x2Csxp82V5DKU+QhoOz6Lbm/ajg6RoScWmjeB5LE3qxmSKICq4wClN/
 bZaNNewt7cpNnIsIHNy4SbUfsxqujZexICAomJtBANC8qN6fdPoTv1eDgA093sWXuYTd/mV+UZk
 Y3DH4+DOa7ILtqkxuk32YvRNSwEB3Fk5+MuPKl/MTpB81vN3ewdOsY3+pTdIg2iw4vd2FORAYdL
 rTQOz1XTsrIWLaXaGmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAxMCBTYWx0ZWRfX/fqYvBATFWSe
 CMlJRQnEwbcRtMGtUKHbrvq91ZdohgkA8SuBQZkIBSJOn/SDZZc0MIrO9HWtxREadrn7XMPaVcg
 RlGMTuAHdPGCU6MKVQW4mcJ+JxJoXME=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040010
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

