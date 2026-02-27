Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E22510398AD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4aC-00075a-ST; Fri, 27 Feb 2026 15:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a8-0006wb-6v
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a6-0006rB-5D
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:03 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0HFI010544
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5DjSl/WAiUXF3sCokY21sPk5/qzDZaPC8uNY5QkMM1Q=; b=cq1AK2ZbQbytXDUd
 FObYWqeVD678ALqKJCs2zg5EybmcrtrOjWZsBbXSTBWOdzBkvhwq0FIwF72CWy5Z
 muIfpdr7iPEREf9bdxMVH81srW/EZ4Mqt06xl7p9G3BH0Y155wxE9CJlWZIPvNzl
 9LPZJXZNZz+UTCRZwg54YRxgdLmnm5tqScT64Rlz/I6L1WC/f4wJQ87CM0HbGaoh
 jvnA06HqiMr8SEv5KYqVo582xQrdk1VlEpgkNOdMb1MU5zLb83iZ60h+pXW0hdWz
 h+h68T1kDTXbdCWgssLXwXUY+LQQd+b/M5BtVy89BbDo9+Geb3+l9LXA0nZfBb7w
 EI3mTA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuytvg18-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:00 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d194b631d6so1925482a34.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224620; x=1772829420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DjSl/WAiUXF3sCokY21sPk5/qzDZaPC8uNY5QkMM1Q=;
 b=ONwD6dRO1kCgKMc1T5SF+NT7RacbAw3FKJ2si0wQ8ByjvYj3Oj6GVkIvW7xO2bWRu6
 PYcYhFaJIaxLKvtYf50dxu3BkBEaFxqMfy+UIOGP7SJ5R4eON0aWCnGa+WgqBPJntg4E
 ezmVokSWJFtiGEFJng5EVvwCGEYUUgtflM1/tYprcv5jgr0CnasRF8FUVNjxF4jxkOrJ
 FdmkiNgyeZIb9Qmoe6N0WK55/nO49OibyAgyEWVtN/fXm2f562pny8w5UIoJmi2gPBN2
 II11drxLm5en/END98jGnYIv/2o1FoxAi7cdUMXhA7ZowxJxdUGNIcaUmGKVomA0WYjg
 Rkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224620; x=1772829420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5DjSl/WAiUXF3sCokY21sPk5/qzDZaPC8uNY5QkMM1Q=;
 b=LxAjQ4mMiGoO5cghf5o3qSZOGGBwYz0S5YcZy7fk7HH53waAmw6CGOymSqijmmjG70
 HOsaw0nsLbXRgf2jIzr+DJqbaoplaQcS3MwMtcNTZZ6JE0JARrlZkpjKnt2uaoII0ZqH
 eOW3O0uZIfk9JuOU88ls0i6VC0stHxd4k9+lmRnTxc/PB44ml7f/u4VvIPvf8hh+kOIo
 ATBbXNJjHVHVbADeXKhFX7ThsvTBlTcEj1c4B9zui4M0PfGKDotOacyyK7gXl+/JdI4M
 SsI7YzvLT2qhvlXk9Lv5GP2r5bsSKjtjaBHqmqOEjOXtTBasCa9Yx4rQbOlrdKchm+zK
 TnsA==
X-Gm-Message-State: AOJu0YyAlF38pfpkEFG2BhfpauF9tqIS697SGOr1PsEh/Z60P46/+G1L
 wMf3uqETYSzApBdpnt1VQHLc3aPu1Aw8bi50KDslXRcJeD9w7YUUBOyWXWKlz1diTpPAd0GvSh/
 Pjb7tTW7X9G/yfhYTkVud2WWtm2YFSoZtRR9j0Isudv9MjSNR5gDoKrnfNKzaaN0gHw==
X-Gm-Gg: ATEYQzwbwI+wnW59kQbDmelCnfuxWKW8AbgmL3z6VTfqBF2cel57jc5p9+GNqITzkVS
 1wX9383BnipVsvChUEVe+KRMGKIpCz0k0kDYyehbJ43vDf3P2xTSICWY6ruTp2upG5Uj3yVMnf/
 qZfh68Oneq14jeXet5RNaWNjsoLkNmPmDqFXBCFTJiyBGDo+e2HpGKEIer6wsUw6skpv9C8dn6f
 gcZ94JM4UowHIAwQfS7c8ewbJWJuUnixgH1JT4mb6s4d2BD9HA+LIw7I7XTm6bj4olznWy3TD1y
 aIIV7IP6YaJf+AF7CSZpFOhjxJHW+D4BOgRy3KEygD5UCLLRa7j8FlQb4SWi1sQtbVIvEOP3n+K
 2XtVqcMuv/MdxkH6k0B8N2NqLuVy0lIv3F7jZHRPuatT1QNmk3RIJzJ/K+q/51rr/ll5mvQ==
X-Received: by 2002:a05:6870:16d2:b0:404:2e96:8140 with SMTP id
 586e51a60fabf-41626ffd0e6mr2863763fac.44.1772224620023; 
 Fri, 27 Feb 2026 12:37:00 -0800 (PST)
X-Received: by 2002:a05:6870:16d2:b0:404:2e96:8140 with SMTP id
 586e51a60fabf-41626ffd0e6mr2863740fac.44.1772224619603; 
 Fri, 27 Feb 2026 12:36:59 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:59 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 20/37] target/hexagon: Add vmstate representation
Date: Fri, 27 Feb 2026 12:36:10 -0800
Message-Id: <20260227203627.932864-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=bJIb4f+Z c=1 sm=1 tr=0 ts=69a2006c cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zFM9_BfjGYtbIq66ZkUA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2z32UvPJaSd4R1mFiy4jKru_WARBKqcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5pwJuDQQtP7m
 EQRVx9DthnZqhTKoKy8KzGz4ZlhAJlwlXxPJsngtHCy4aGzDwqJCn+pYMB9uw9hr8sNeeXA6KAt
 02tnMMXU9u/294wyw9bphZwxyH6pnCfc8pU+VpxOHtg2Z99WsiNvaLIjWkRZTM3j3+sMMYgj36T
 PkAdsRG6RJBLEAEOunInBSWL1Pys1lz2QxAfgrJ1VSobxTwkCQ80Bq/TwVqKVmlCb/cUIAZD3nc
 TC2jGNuh+wEjjHyzSDOGcgQcc+FH+JKljUH1qcSdQjFbzexK4LmxbN/BhaKHz/WxNRusFr4tiqv
 BZSQ3RTzX9TSee5bq31OWF0WutiWrTKx5SawezHKpIQSVmuo8MDB2BZHHVw4oGuyJgJwhqP6c3a
 WvlycVgINM851z/piWMYo60UAVCwR0H2oFGseYjJfPv/GcnGJk6KBT0Ke9CSncXqqj3YbbQUVH4
 uBzh4oyvc8oNIDXLniw==
X-Proofpoint-GUID: 2z32UvPJaSd4R1mFiy4jKru_WARBKqcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysKIDMg
ZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdl
dC9oZXhhZ29uL21hY2hpbmUuYwoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFs
LmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCmluZGV4IDVmYzgzN2FlMjI5Li5jZDA2ZmY0
MWQ0ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQv
aGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw0ICszMSw4IEBAIHZvaWQgaGV4YWdvbl9kZWJ1ZyhD
UFVIZXhhZ29uU3RhdGUgKmVudik7CiAKIGV4dGVybiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdv
bl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JFR1NdOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKK2V4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2Nw
dTsKKyNlbmRpZgorCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggYzRkZjdjYmUzMGIuLmE4ZjJmOWUyMzhhIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpA
QCAtMzg2LDYgKzM4Niw5IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9zdG9wX2JlZm9yZV93
YXRjaHBvaW50ID0gdHJ1ZTsKICAgICBjYy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAiaGV4YWdvbi1j
b3JlLnhtbCI7CiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gaGV4YWdvbl9jcHVfZGlzYXNfc2V0
X2luZm87CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBkYy0+dm1zZCA9ICZ2bXN0YXRl
X2hleGFnb25fY3B1OworI2VuZGlmCiAgICAgY2MtPnRjZ19vcHMgPSAmaGV4YWdvbl90Y2dfb3Bz
OwogfQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgYi90YXJnZXQvaGV4
YWdvbi9tYWNoaW5lLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjg5
YTJjYTBiZDk0Ci0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCkBA
IC0wLDAgKzEsMjMgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2ll
cywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqCisgKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11L29zZGVwLmgi
CisjaW5jbHVkZSAibWlncmF0aW9uL2NwdS5oIgorI2luY2x1ZGUgImNwdS5oIgorCitjb25zdCBW
TVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9IHsKKyAgICAubmFtZSA9ICJj
cHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwK
KyAgICAuZmllbGRzID0gKFZNU3RhdGVGaWVsZFtdKSB7CisgICAgICAgIFZNU1RBVEVfU1RSVUNU
KHBhcmVudF9vYmosIEhleGFnb25DUFUsIDAsIHZtc3RhdGVfY3B1X2NvbW1vbiwgQ1BVU3RhdGUp
LAorICAgICAgICBWTVNUQVRFX1VJTlRUTF9BUlJBWShlbnYuZ3ByLCBIZXhhZ29uQ1BVLCBUT1RB
TF9QRVJfVEhSRUFEX1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlRUTF9BUlJBWShlbnYucHJl
ZCwgSGV4YWdvbkNQVSwgTlVNX1BSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UVExfQVJSQVko
ZW52LnRfc3JlZywgSGV4YWdvbkNQVSwgTlVNX1NSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5U
VExfQVJSQVkoZW52LmdyZWcsIEhleGFnb25DUFUsIE5VTV9HUkVHUyksCisgICAgICAgIFZNU1RB
VEVfRU5EX09GX0xJU1QoKQorICAgIH0sCit9OwotLSAKMi4zNC4xCgo=

