Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F11AFD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaJ-00021F-E6; Tue, 10 Mar 2026 23:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa6-0001g9-2E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa3-0005Fk-6a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3fwh23760401
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w5LEe8CK5a98CywVYut5O9H+/pZlvuY5A2kbN6aZ5lc=; b=RlOI1CH3vtMLzQqt
 wobM1ikxELqFXSo+xwPh4cnSBF/xq6U7UzbKrvSTQTKimX1ECqyfj+4JulRftYNS
 +A/aSZ8F+YFpC6oH2CAFRvbZ0b9I40iXzCjtuVDqHmv88iHTyHcFPOvaOTkx3OeF
 tcMyaqep3BDue3gvsblSjtDvoNE1cILOC8Hqy8Ylb/azAviZbymRn7iO9V8qbkKo
 HyLGRQwNTAB4H/nb5hCaLI5ei6DledyujT+/DSczaJp6OcXAaYPAupqPnsaLq/l9
 8gIUOvNwuf55n0KjlG3+RxanD5OHxXR0iMGrZq8Oi6N/Jl3fVeeGeFIc/7ypYTXL
 1NHJcg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8uk2xw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:52 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d75b6b8500so14278374a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200992; x=1773805792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5LEe8CK5a98CywVYut5O9H+/pZlvuY5A2kbN6aZ5lc=;
 b=GY8eveDL70qO55O4+a5YDDsVpwijQYlYulD6cNwuH3U8PYpf6RAkBm5P62i2Emcntb
 UYJ+zEkK2PgpKVAXG3xGABtpLziU6p3i6qfo7HUlgQ6y9pMH9q9Onxy/FG4PXftWNuFe
 6wqemuHiYajSYwI30iA/rlpx/TH9Vf8//UE6+IiApRky7lwk8AZXtk9obOn341MoIMoX
 Qj+3+rHJHKZuzTrGBWb528sUEvAqMUWEAjpuCgdhxGaWv+QhuL0LKEcu0d+asQ9vGF3p
 EoCxRyF2AoxeQQLk78MFeUO4RfdMQx1KuknLszrVFj+mfhchAM76h9RnxTsJ+gWCw0bH
 a2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200992; x=1773805792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5LEe8CK5a98CywVYut5O9H+/pZlvuY5A2kbN6aZ5lc=;
 b=RCsMbjGkIxyX2YGrUfzucYWrm/9RATA887t4VQhVUt62jrWPVgvW1lPYRmYzEKDAJo
 OeWQYXGNEZ0cOOJyUg+KcoGvgO1CwcYNXGy1aDwxQGHFq4rdIWPfN3jWE4W5MqC1q+PR
 hqgYy+wbqVqTJJhBPpTGvnzuY2KS99prj0VWYTQvskdQMAWDF1YpggzVe+OiCWA97oPj
 m4oSjhVy0Q0MV8Hj2MtuHE5P5Xvfjfy1sOZmv2P/PuhC8yk8go6r9UgM3FJpr6cW0uhJ
 94dRP33PtKadme+pIjkCaS+5BGxaCGKN5eoVtmCciRpk3KLjPpzjuGCTk68AUGYu7SV/
 dF7Q==
X-Gm-Message-State: AOJu0YzlHYn4pgVnk6LQY28MZGbK2xjqa9yxpjWYtuZFFxFBACqYNyWj
 N3xtlMOLv1+g+rc9QWtvwUp85Ri0dN5ffkvRKETC76dW+LowJci9g93/jRaaAIB8hl6MBTl2RdL
 jh+r/viTgWwzDePgDl2tK+xzgfoQm0a3HhEyUC+nMZmHRQ/hyoMVCliub1Kd2rEBhqw==
X-Gm-Gg: ATEYQzyArBsBOe5hybAQWCYyGpWUbqY7X2l4r/YX5uiTHY6/9pLg3PsNSmuyBtsNMMQ
 n59dXsoQui2NXHLLI9WI3zfSKR+ZVAcxDWaM9z9plLEK3Ivbk3P2mkd1Mq9+4KhtQcrsOAhNH0c
 EwQ68f92CyyVpN2rmJSdyZk+Dx697k4aq3Lai7YyAeh7W/JmLXSNA9rH6RtNm0otBdihYyGgY1f
 w6koWmyVmJkgawLbn2oDobw4jYaTkLoN8ULC/2EIw5wXgceNfAGv6a1dPPpZEbdnM6Gl3hhkWkg
 BwCT8SdEepmrwHIzzvtvkCjGOAV7mhCSQ2hG3eXg0u4E412nN0Hlc4fT3R82zAvoyrCnn4SCqrd
 Y8UE8AVSQnvDo97RWqWdhUVmoQ2YkI03qki2ypyKADZ3xDA6UJsPZQge9TjnoM2r/Nb2wzw==
X-Received: by 2002:a05:6830:4423:b0:7cf:d213:7ecf with SMTP id
 46e09a7af769-7d76a8f1e1amr1067816a34.32.1773200991994; 
 Tue, 10 Mar 2026 20:49:51 -0700 (PDT)
X-Received: by 2002:a05:6830:4423:b0:7cf:d213:7ecf with SMTP id
 46e09a7af769-7d76a8f1e1amr1067798a34.32.1773200991678; 
 Tue, 10 Mar 2026 20:49:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 19/35] target/hexagon: Add vmstate representation
Date: Tue, 10 Mar 2026 20:49:07 -0700
Message-Id: <20260311034923.1044737-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 1p4srV8h4ru_XhhYkITHlq3D_DKOA580
X-Proofpoint-GUID: 1p4srV8h4ru_XhhYkITHlq3D_DKOA580
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b0e660 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zFM9_BfjGYtbIq66ZkUA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX1wdcwJAs5Nnf
 AMXrJcN7jdfxyJ+SHvJkrNPFKeq5R4YKsH56EX5fhFeynhJXJ9kF7FLU97V/ZvgdBgv19V4oFaI
 wCUgyIsnOuJ23qWXeAlJXTAGI9Y8GiBqy9JzjiQWcdUbXIQgc2PY9+Ql3yC2AXVCh1YcGZFycTw
 p6GhjbxJv5yRgu7cdaHo8g4PJnBQoVXxMvPftYvXkY/clI30GBRWHkwVRltHro11CQYujp2z3FG
 4tK47JuAcgBnhkiHFYX1Howq91HhlhDemzi1lOsD6sR8TWma0X/q9HFEHh+7Zc9QfC/3zA/Nflv
 /r+07uE1/uvj2eV8EOzLhpbTAhhr1p+hrhbLhjqpz5LKzKSShDB6ohN4r1gw19e30i69Xpp9KNr
 GYX7qGhBzY0LklYMQs/jKpIK09yUe04X8ub9r7GF9VIRHONqNOUTmc8cj2vufcfNKYISJUONSaX
 xudm1HtOSK8tzTfFz0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgIDMgKysrCiB0
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCmluZGV4IDVmYzgzN2FlMjI5
Li5jZDA2ZmY0MWQ0ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw0ICszMSw4IEBAIHZvaWQgaGV4YWdv
bl9kZWJ1ZyhDUFVIZXhhZ29uU3RhdGUgKmVudik7CiAKIGV4dGVybiBjb25zdCBjaGFyICogY29u
c3QgaGV4YWdvbl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JFR1NdOwogCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKK2V4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9o
ZXhhZ29uX2NwdTsKKyNlbmRpZgorCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNmZhYmZhYWQ2ZDIuLjM4ZDYwNWIw
NmJhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuYwpAQCAtMzg3LDYgKzM4Nyw5IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9zdG9w
X2JlZm9yZV93YXRjaHBvaW50ID0gdHJ1ZTsKICAgICBjYy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAi
aGV4YWdvbi1jb3JlLnhtbCI7CiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gaGV4YWdvbl9jcHVf
ZGlzYXNfc2V0X2luZm87CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBkYy0+dm1zZCA9
ICZ2bXN0YXRlX2hleGFnb25fY3B1OworI2VuZGlmCiAgICAgY2MtPnRjZ19vcHMgPSAmaGV4YWdv
bl90Y2dfb3BzOwogfQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgYi90
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAuLmQ2ZGNkMDdkZDRhCi0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFj
aGluZS5jCkBAIC0wLDAgKzEsMzIgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRl
Y2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqCisgKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11
L29zZGVwLmgiCisjaW5jbHVkZSAibWlncmF0aW9uL2NwdS5oIgorI2luY2x1ZGUgImNwdS5oIgor
Citjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9IHsKKyAgICAu
bmFtZSA9ICJjcHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11bV92ZXJzaW9u
X2lkID0gMSwKKyAgICAuZmllbGRzID0gKFZNU3RhdGVGaWVsZFtdKSB7CisgICAgICAgIFZNU1RB
VEVfVUlOVDMyX0FSUkFZKGVudi5ncHIsIEhleGFnb25DUFUsIFRPVEFMX1BFUl9USFJFQURfUkVH
UyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5wcmVkLCBIZXhhZ29uQ1BVLCBO
VU1fUFJFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShlbnYudF9zcmVnLCBIZXhh
Z29uQ1BVLCBOVU1fU1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShlbnYuZ3Jl
ZywgSGV4YWdvbkNQVSwgTlVNX0dSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52Lm5l
eHRfUEMsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYudGxiX2xvY2tf
c3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYuazBfbG9ja19z
dGF0ZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi50bGJfbG9ja19j
b3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi5rMF9sb2NrX2Nv
dW50LCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LnRocmVhZElkLCBI
ZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmNhdXNlX2NvZGUsIEhleGFn
b25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYud2FpdF9uZXh0X3BjLCBIZXhhZ29u
Q1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVfY291bnQsIEhleGFnb25D
UFUpLAorCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9OwotLSAKMi4z
NC4xCgo=

