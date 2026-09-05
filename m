Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18347C79F8B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weQ-0001WV-NU; Sat, 05 Sep 2026 16:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weO-0001W1-OF
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weL-00062X-Ss
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hb4103777562
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cqmlRHQGTrZ/xMqXl6+FjJH2PhIlQKMmq3At33MWXH8=; b=fd/Mhvq5+rqEJMXb
 buZrBERloYV3ZS42nMQUFqXRaiV9h0yXYxwTZjap9ySwGmqS9xi8hH2PmN27geuU
 r5ZABWbE6+qmSxoWMLpnjQYtJ31vDFY8EouJl+CwNkStZsxoBcYjxnoQQs/ziThK
 lx24pX09VFygHHQmIg+kqJtHWT43VRiHS0lL4sIUQ3uK7HVKUdBh5ykcKAkp+Bdc
 Y6UOhRbAdJOo8LZKcVBAK/MdRGcdJoOdHPrwlLngxkvGGDMhdp6QcldL0b4CCzi+
 3wVpxS+wpnrHMpuqJF518hfByNeZR8dH18G6GCR7ktAGoRfR6kvIVDBhJY+NBb5j
 wGIcvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s29su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:06:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so3284042a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638763; x=1789243563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cqmlRHQGTrZ/xMqXl6+FjJH2PhIlQKMmq3At33MWXH8=;
 b=dA1j3QR7K4F8kOopbWPvtNiHaAKQFLzAd7KTRxpoTqZZ8dFk2+UJjvmhCz6/yWavxL
 QyVDVVjKWwRbFtXavlZrqkKT+2MQJCAorh8qyvan1nrAkl7JoC3nxpdE1BQdenr4YLXs
 esnc64u1Y3to7W4THUdF244BEpo/yzHEiNw0yHY/Kr/Cn49OImMcXhitEBZ5Mg6sbH7q
 Na/rARtiZCXq2hgAMb1HxhzYZ0g8SAB5XJViZ6XQScfmxo+y4HyEcwSHXwyKlA+fDzv/
 7gK9wzpAIBdzuhtVWcBi/efnLnlE1PC3kel8DqBlaIdBgJmftAP4k8P8DZaaTJLfX3vA
 nFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638763; x=1789243563;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cqmlRHQGTrZ/xMqXl6+FjJH2PhIlQKMmq3At33MWXH8=;
 b=DG7iEo91FveRfOJrh71YX5AWVJrLtRFP1w5KFF8HUzf7w5PMJ/yQo1R92x2jKu2AV1
 8G+MP9WSq15SM8iF2lNTDKBrGfLyYVtE74nbXa9T5NII+5pPS2dJ+goq8GnNgzFEKQCs
 UG2nXXSbaUZOY5PEWeRtJ64yB02MyASGjiOPLO0F3Wna0x6ayOJaLGPSklyDqykEcFa5
 EiFIIj75I5tOcI4WXicSSza5jKbKC5Ub7AtL/REy94Ud3OxCVHzxKdJ6arDUVGh9FIBK
 V8MeLMT2xHooYEjV4gnN/dTQqYQMWbdwHpbj9Jm8djhaU237v0fnwDllfGTmZWwzogOw
 HyQg==
X-Gm-Message-State: AFuF++ktQ9JkE4YShL1jn3PHWnG5ANqr9eltflc/UgQSHwZ0OhnUQCUW
 3DUUIvXQR2Huk+3wQogQbm+6kxmt4zOQjGoH7IBYGSos/8Hv6WwKffI/WmNBVg5KL8Owh5f2fyq
 CQd2pyzctRmGPLg2Sh+xfRVtfqA64/bLu6tSOBJLPvroiDEVOVwqlmWArgkegVu3imw==
X-Gm-Gg: AYBFou2TP5JzE3uhuk6UP21bso3GSVOgEi2rlbU0DcvwSKYYkXAxsTarTMVtN6BJcvh
 Z9mZmswKj7VOj3sVqC/ESpTLquT4ViduuYhETEmZH8hDpiaOG+kQNvwz/ypB29CamNuUcAJMjPH
 UbKpmhnB/B3JqaqOkmIwFJ8Sgb95vSgHrcLwVOdhSVEmGt/qrtq92lfroPgSuZyuETO/VfYOnLL
 DWNIJlxLrZEhceahr8y6csL2ENUCb19gf9jJQ9In/6DKiTW7gnSRUp+WvOPXfAd58ho1t78L1Dz
 hrLMPkCpvUB1NImZhG7mX18dHc1ZMPpk7PJY+qpUgsoWCSZzj70ybMcHjRcHiz3wvEHK45e+jr+
 T4UlxrP9imCy/Imy9qIk9ceehSFab7UzwAmy3BeLrOsZzbvFf
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39b26100e5dmr20137980a91.4.1788638763301; 
 Sat, 05 Sep 2026 13:06:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39b26100e5dmr20137936a91.4.1788638762873; 
 Sat, 05 Sep 2026 13:06:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:06:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 6/9] hexagon: raise imprecise exception for multi-TLB matches
Date: Sat,  5 Sep 2026 13:05:47 -0700
Message-Id: <20260905200550.2009799-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9c762c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=afvixaqROyvvyxJKKgMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX9QHUheuDB3W8
 1NH7K0XtfXqFHJd3KfyQulyswfAOXWXbucNpgZrcO5EeAaZPAbFKACoHhQMQL083Hkja3aGNQWf
 Ky/ZOwATR0OD/SL9xIn4LbOuKlsojRU=
X-Proofpoint-GUID: 9GyX2rGkRy1S0QbxNidtP52aLldT072C
X-Proofpoint-ORIG-GUID: 9GyX2rGkRy1S0QbxNidtP52aLldT072C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX9ZWqpNv1w5up
 P5QEqu8jekUWMSlwpaqUtEmR3IjTbabW/B/REJHTXlJE+grfbZxVOoSldrpvD0kMra/YMxJSCNq
 h6gN8zXfUbtgNNuWqeGr96ymryYXeI9UbLQvp+w1VFGM79f77cnIIaUFZdkdT0Ey3qqhjq4nUCO
 UabMFzdbRKf5PBb/0VjBHt4+c0zVfDvoRGGdncheIz3sxLBMIYixUBJ/wgK7Gu4gL5UwJKp3Sr6
 uSVzMJftCpQn2P944LW5KWmx8lDEwKI+ZqdIDzJlew6qadrox41LdJigsRQVSSkNvEuXD8zKXhL
 rOBSa3/ECXf450y9m0gMihIfcfzp6GzqyRuYkTEdtcL368VyRiwqQOXmL37nZZhD37z59MIjFim
 oXz/Y5ZMtnFIdEvhkBD42Pq5oGK4F1OiPw6uHM0P9+bQTa+85tDgusoLquT4gQs4J0+mB8io/oD
 8QWHwoS/YSg3ecNPMCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050223
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

VGhlIFRMQiB3YWxrIHN0b3BwZWQgYXQgdGhlIGZpcnN0IG1hdGNoaW5nIGVudHJ5LCBzbyBpbnN0
cnVjdGlvbiBhbmQgZGF0YQp0cmFuc2xhdGlvbnMgZGlkIG5vdCBkZXRlY3QgYSBzZWNvbmQgdmFs
aWQgbWFwcGluZyBmb3IgdGhlIHNhbWUgVkEgYW5kIEFTSUQuCgpTY2FuIHRoZSByZW1haW5pbmcg
ZW50cmllcyBhZnRlciBzZWxlY3RpbmcgdGhlIHRyYW5zbGF0aW9uLiAgT24gYSBzZWNvbmQKbWF0
Y2gsIHJldGFpbiB0aGUgZmlyc3QgZW50cnkgZm9yIHRoZSBhY2Nlc3MgYnV0IHJlY29yZApIRVhf
Q0FVU0VfSU1QUkVDSVNFX01VTFRJX1RMQl9NQVRDSCBhcyBhIHBlbmRpbmcgaW1wcmVjaXNlIGV4
Y2VwdGlvbi4KCk1vdmUgdGhhdCBleGNlcHRpb24gb3V0IG9mIHRoZSBzeW5jaHJvbm91cyBUTEIt
ZmlsbCByZXN1bHQgYW5kIGNoZWNrIGZvciBpdAphZnRlciBldmVyeSBwYWNrZXQsIHJhdGhlciB0
aGFuIG9ubHkgcGFja2V0cyBjb250YWluaW5nIHRsYnAuICBUaGlzIGRlbGl2ZXJzCnRoZSBhcmNo
aXRlY3R1cmFsIGltcHJlY2lzZSBleGNlcHRpb24gYWZ0ZXIgYW4gb3JkaW5hcnkgbWVtb3J5IGFj
Y2VzcyBhbmQKYXZvaWRzIHRyZWF0aW5nIGl0IGFzIGEgcHJlY2lzZSBwZXJtaXNzaW9uIGZhdWx0
LiAgQ2xlYXIgdGhlIHBlbmRpbmcgc3RhdGUKd2hlbiBzdGFydGluZyBhIG5ldyB0cmFuc2xhdGlv
biBhbmQgYWZ0ZXIgZGVsaXZlcmluZyB0aGUgZXhjZXB0aW9uLgoKVGhlIHYwLjIuMTQgbW11X211
bHRpX3RsYiBzeXN0ZXN0IHVuY292ZXJlZCB0aGlzIGJ1Zy4KClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhh
Z29uL2hleGFnb25fdGxiLmMgICB8IDEwICsrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2hleF9t
bXUuYyAgIHwgMTIgKysrKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICB8ICAx
ICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMjIgKysrKysrKystLS0tLS0tLS0tLS0t
LQogNCBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMgYi9ody9oZXhhZ29uL2hleGFnb25f
dGxiLmMKaW5kZXggYzc2ODA1YWJhYzkuLjE1N2QwM2U1MWJmIDEwMDY0NAotLS0gYS9ody9oZXhh
Z29uL2hleGFnb25fdGxiLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5jCkBAIC0zMjYs
NiArMzI2LDE2IEBAIGJvb2wgaGV4YWdvbl90bGJfZmluZF9tYXRjaChIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDMyX3QgYXNpZCwKICAgICBmb3IgKHVpbnQzMl90IGkgPSAwOyBpIDwgdGxiLT5u
dW1fZW50cmllczsgaSsrKSB7CiAgICAgICAgIGlmIChoZXhfdGxiX2VudHJ5X21hdGNoKHRsYi0+
ZW50cmllc1tpXSwgYXNpZCwgVkEsIGFjY2Vzc190eXBlLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBQQSwgcHJvdCwgc2l6ZSwgZXhjcCwgY2F1c2VfY29kZSwgbW11X2lkeCkpIHsK
KyAgICAgICAgICAgIGlmICgqZXhjcCA9PSAwKSB7CisgICAgICAgICAgICAgICAgZm9yIChpKys7
IGkgPCB0bGItPm51bV9lbnRyaWVzOyBpKyspIHsKKyAgICAgICAgICAgICAgICAgICAgaWYgKGhl
eF90bGJfZW50cnlfbWF0Y2hfbm9wZXJtKHRsYi0+ZW50cmllc1tpXSwgYXNpZCwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZBKSkgeworICAgICAg
ICAgICAgICAgICAgICAgICAgKmV4Y3AgPSBIRVhfRVZFTlRfSU1QUkVDSVNFOworICAgICAgICAg
ICAgICAgICAgICAgICAgKmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfSU1QUkVDSVNFX01VTFRJX1RM
Ql9NQVRDSDsKKyAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgICAg
ICAgICB9CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgfQogICAgICAgICAgICAgcmV0
dXJuIHRydWU7CiAgICAgICAgIH0KICAgICB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9o
ZXhfbW11LmMgYi90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKaW5kZXggZDYyNThjNjczZDEuLmQ2
ZWU3YzQwNzk4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vaGV4X21tdS5jCkBAIC03MSwxMCArNzEsMTYgQEAgYm9vbCBoZXhfdGxiX2Zp
bmRfbWF0Y2goQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IFZBLAogICAgIHVpbnQzMl90
IHNzciA9IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl07CiAgICAgdWludDhfdCBhc2lkID0gR0VU
X1NTUl9GSUVMRChTU1JfQVNJRCwgc3NyKTsKICAgICBpbnQgY2F1c2VfY29kZSA9IDA7CisgICAg
Ym9vbCBmb3VuZDsKIAotICAgIGJvb2wgZm91bmQgPSBoZXhhZ29uX3RsYl9maW5kX21hdGNoKGNw
dS0+dGxiLCBhc2lkLCBWQSwgYWNjZXNzX3R5cGUsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUEEsIHByb3QsIHNpemUsIGV4Y3AsICZjYXVzZV9jb2RlLAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1tdV9pZHgpOworICAgIGVudi0+aW1w
cmVjaXNlX2V4Y2VwdGlvbiA9IDA7CisgICAgZm91bmQgPSBoZXhhZ29uX3RsYl9maW5kX21hdGNo
KGNwdS0+dGxiLCBhc2lkLCBWQSwgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFBBLCBwcm90LCBzaXplLCBleGNwLCAmY2F1c2VfY29kZSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbW11X2lkeCk7CisgICAgaWYgKCpleGNwID09IEhF
WF9FVkVOVF9JTVBSRUNJU0UpIHsKKyAgICAgICAgZW52LT5pbXByZWNpc2VfZXhjZXB0aW9uID0g
KmV4Y3A7CisgICAgICAgICpleGNwID0gMDsKKyAgICB9CiAgICAgaWYgKGNhdXNlX2NvZGUpIHsK
ICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gY2F1c2VfY29kZTsKICAgICB9CmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4
IDc1ZjBhOWNjNTIwLi40NzA1ZTkxNWFlYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4
c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTkzNCw2ICs5MzQsNyBAQCB2
b2lkIGhleGFnb25fY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3MpCiAgICAgICAgIGJyZWFr
OwogCiAgICAgY2FzZSBIRVhfRVZFTlRfSU1QUkVDSVNFOgorICAgICAgICBlbnYtPmltcHJlY2lz
ZV9leGNlcHRpb24gPSAwOwogICAgICAgICBpZiAoZ2V0X2V4ZV9tb2RlKGVudikgPT0gSEVYX0VY
RV9NT0RFX1dBSVQpIHsKICAgICAgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gZW52LT53
YWl0X25leHRfcGMgLSA0OwogICAgICAgICAgICAgY2xlYXJfd2FpdF9tb2RlKGVudik7CmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCmluZGV4IGJlNzVlNWZkZWI4Li41ZDNkNjdlNWQzZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAg
LTEwNjUsMjAgKzEwNjUsMTQgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2V4ZWNfY291bnRlcnMoRGlz
YXNDb250ZXh0ICpjdHgpCiAgKiBBIHRsYnAgaW5zdHJ1Y3Rpb24gbWF5IGRldGVjdCBtdWx0aXBs
ZSBUTEIgbWF0Y2hlcyBhbmQgc2V0IGEgcGVuZGluZwogICogaW1wcmVjaXNlIGV4Y2VwdGlvbi4g
IFJhaXNlIGl0IGFmdGVyIHRoZSBwYWNrZXQgdGhhdCByYW4gdGhlIHRsYnAuCiAgKi8KLXN0YXRp
YyB2b2lkIGNoZWNrX2ltcHJlY2lzZV9leGNlcHRpb24oUGFja2V0ICpwa3QpCitzdGF0aWMgdm9p
ZCBjaGVja19pbXByZWNpc2VfZXhjZXB0aW9uKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIGZv
ciAoaW50IGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgewotICAgICAgICBpZiAocGt0
LT5pbnNuW2ldLm9wY29kZSA9PSBZMl90bGJwKSB7Ci0gICAgICAgICAgICBUQ0d2IFBDID0gdGNn
X2NvbnN0YW50X3RsKHBrdC0+cGMpOwotICAgICAgICAgICAgVENHTGFiZWwgKmxhYmVsID0gZ2Vu
X25ld19sYWJlbCgpOwotICAgICAgICAgICAgdGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX0VR
LCBoZXhfaW1wcmVjaXNlX2V4Y2VwdGlvbiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAwLCBsYWJlbCk7Ci0gICAgICAgICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2df
ZW52LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGV4X2ltcHJlY2lz
ZV9leGNlcHRpb24sIFBDKTsKLSAgICAgICAgICAgIGdlbl9zZXRfbGFiZWwobGFiZWwpOwotICAg
ICAgICAgICAgcmV0dXJuOwotICAgICAgICB9Ci0gICAgfQorICAgIFRDR3YgUEMgPSB0Y2dfY29u
c3RhbnRfdGwoY3R4LT5wa3QucGMpOworICAgIFRDR0xhYmVsICpsYWJlbCA9IGdlbl9uZXdfbGFi
ZWwoKTsKKworICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09ORF9FUSwgaGV4X2ltcHJlY2lz
ZV9leGNlcHRpb24sIDAsIGxhYmVsKTsKKyAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0
Y2dfZW52LCBoZXhfaW1wcmVjaXNlX2V4Y2VwdGlvbiwgUEMpOworICAgIGdlbl9zZXRfbGFiZWwo
bGFiZWwpOwogfQogI2VuZGlmCiAKQEAgLTExODIsNyArMTE3Niw3IEBAIHN0YXRpYyB2b2lkIGdl
bl9jb21taXRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgIH0KIAogI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZCi0gICAgY2hlY2tfaW1wcmVjaXNlX2V4Y2VwdGlvbigmY3R4LT5wa3QpOwor
ICAgIGNoZWNrX2ltcHJlY2lzZV9leGNlcHRpb24oY3R4KTsKICNlbmRpZgogCiAgICAgaWYgKGN0
eC0+cGt0X2VuZHNfdGIgfHwgY3R4LT5iYXNlLmlzX2ptcCA9PSBESVNBU19OT1JFVFVSTikgewot
LSAKMi4zNC4xCgo=

