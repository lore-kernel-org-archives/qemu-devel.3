Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1DCC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3em-00055j-GL; Mon, 29 Jun 2026 00:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3da-0002un-Ps
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dU-0000op-Io
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NG221787623
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=; b=T4rnMon6eYJXtFA7
 byuFFEzpZBwzXA5+9wXvpXbMc+Rx5QOufh4bjliMTat6Hu1m/0eKJZOShOV1kwxY
 jZjdahtHGWBnR3Y1Tfta3DgSUuKFLcyCvOtvDe1KZy58rdgXeeMHS66Z57HP4y0F
 xsU6aBfhfDxJvgiTR5e8aPwDRALGR2MgsaWfPCOopB5xuhGk7m2HrgA6gsSONn8o
 fMsCsFfHapiV4zU8HcSvvimdmqafUGyBMDNW19v6KgfDG1qL2vydpbvgdUcd73Wl
 bJjrKPkUMFE6D1QWeUul+HnSCxMkB7xN8s1Imi2mT5hJ7zSxUtXTQZhCHLmQjSaz
 wBNNrA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tuvff6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso7999304eec.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707406; x=1783312206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=DybMVHwu9tMFg0ngm3j5Mg0EmYUuJZk6lgWJ4b8nhB6sSD1MuCFTz8alKJyZeXXwD0
 T7FWEtFZpCrvfm8DK59VFyknsVldnE/7HyuKhQ/oxgPlvSEP5SoEetecNAde/z2KT/uW
 GoT2ueH4A4eg0O9MovPeCHLTNOQ0IKGiMZg9qCNcAKUiR6VcRORGddi3q1bpzDsL9Kh4
 QZ5x39QC+f5OMx7GSg6a24LsdkdITJf7ysGWdhZczOWQUc4rtcxRwtlcDin/ZBtuoxWD
 N3BACDu4/cN/twJ4JsocP4bxYl0LfAERgz1gu8ucweALzW+eLuJ6NXPN1JG636HaQxYt
 mGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707406; x=1783312206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UuTOFdc8oYjbXiuLSyd2e3M5N5lZKNz6xk5uPNFpGs=;
 b=cgE9u+bBUeHxKdpIjBfasHMVwX6T6ZP5IAtB2PhcRUszkV5QCC3cE1EU1XgXqeqdAJ
 Auwj8U4FrfudhQSmxv/17trom3CfR5WgbBv/Mf7dR+2edza0RXS4VPC5RslJ5WUw/6wg
 N3v20akkhq6eotxEBrEJj1W3aCuT762DlDp6bDfYVUZtJDq0E9Q2XpAI9sEFG3icNpf2
 2tLtUZ4hRIeEuJNqRUvrfN+CsESnE/tGXSjuPFVmLbcibsqrImFVVeSoEuok6jnMNzB7
 u/vIIpYUwQxKCvU9keuroyuBAA6WXeBrySGs2BWpjbobqt+//ykACeRGsZcMBS29AbwF
 1Yzg==
X-Gm-Message-State: AOJu0Yz4HyKWfrGK0h1SqAY5b+oQr2kWcbw5RMEAU5aLItfVoTNYh+cm
 ovxSR8t5nAgbrW/0emSAD/Ra9OpDrwyVBJn2RtCQA5vt47yBC9eO4LyfG9n6F2Jf5dg1V8OMQa2
 JSMkOfY4IgVbb/DmT6DBhGDbSflL7PX4CBTMQIkNll3k8OwUB/rRmlj7otAhl8ns9cg==
X-Gm-Gg: AfdE7clwSc5xKrZI+hLWuWZlGyWfuklNhMNP9xjxL54fYo+wtXrn68hAOy9fPWfTr8i
 Ehm/TwJ7cYnla2bJqTtX0Z5H8cWpiVUPp9Pg4mncs8j5UpGZLpU7adO2UiyN93i4RwXQNSAH8To
 8uu1V66UubjQeF/yw05umKiuzi/PqTU6mqHllhaQ8WRVZUPjJDK8A/cnJLjlQaXVUnetUB3nx5u
 1d5jTqrP0s1uB82FH7ORkmpTsQrKExtaJZcpCw1yw3TikiPS22k4rtoV26gBVLDT90QuTnC9mJD
 3AV6sjuG+HwdAJezlwyu4Do43vVD5xDwilCdCwH8f8LZHR6bEqZWAhuAu7mj+H9rqKRkugyMikD
 Kolisa9i0w4Wj4VzR2xvVi2sHUJz0+AMWU0liv7JG904nNomABM2+/o2zX8Q=
X-Received: by 2002:a05:7300:548:b0:30e:952b:ddf4 with SMTP id
 5a478bee46e88-30e952be013mr5674009eec.3.1782707405481; 
 Sun, 28 Jun 2026 21:30:05 -0700 (PDT)
X-Received: by 2002:a05:7300:548:b0:30e:952b:ddf4 with SMTP id
 5a478bee46e88-30e952be013mr5673986eec.3.1782707404942; 
 Sun, 28 Jun 2026 21:30:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 59/77] target/hexagon: Implement modify_ssr, resched,
 pending_interrupt
Date: Sun, 28 Jun 2026 20:58:12 -0700
Message-Id: <20260629035830.1520296-60-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX54X3dhorhE5F
 B8oKFFnd/tHSNdrAHQXAv1jLxouIgQuZE8hCpCRuqgS1tNf59gr0OMPjpDgUpEhJbn2ctuj92IR
 B3BOYc+r8aUAFlC5hf9Rnk5XCik3hDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX1VECk1CPWb9G
 ZZzvKunfo2/a7deFR5sysDRgTk9JiSyz2Y6hPKdZMtt6jxch26MrKyodYUe3i1PnXTQAxmib3L5
 9+yNAfyDryLqNe8Nie+nLW+zGzdTEirRPF1yk4bHa9Zdr9w0rxqxNPcgMk6qifTirWVjKRKAh2y
 aY9cKDW5PUPsEHv5mJNrpwmYKQoTbDV+eYBoJMFJUykqGCQhQVTTZleeB9rw8CAW6d/z8zdewIn
 RDRnUJSkEHMO7VUYpL03vL754RoVSZJKxylMGZES/rkA/A+p3MqB6rdNMwJtDccLHSgBWVvsLEv
 P+w/aqBfFLW5YiqI9hm0Ipcz6ynAqzn1g+iH/ePPvpjSAHl1xbYAx+yNTTB2zuLTmxgI8r3liLh
 VtylZvtl6G5ch/gT0zJURXunFWF+0JWLrecaeH/xyuJ5jv4x1MxspeaQ65FkpKHREdGfWekd74b
 2YdtQI9gHjH9POhpH/g==
X-Proofpoint-GUID: vVabJusp2eGl7hAy_kQTv2-cwvEOzAyF
X-Proofpoint-ORIG-GUID: vVabJusp2eGl7hAy_kQTv2-cwvEOzAyF
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a41f4ce cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c5yFZwH1WPb9xS9x6awA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMTQgKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzYzI1M2IzOTFlNy4uOWZiY2Q3OWM5ZDQgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC0xMjI3LDYgKzEyMjcsMTUgQEAgZmxvYXQ2NCBIRUxQRVIoZGZtcHloaCko
Q1BVSGV4YWdvblN0YXRlICplbnYsIGZsb2F0NjQgUnh4ViwKICAgICByZXR1cm4gUnh4VjsKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCit2b2lkIEhFTFBFUihtb2RpZnlfc3NyKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpCit7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhhZ29uX21vZGlmeV9zc3IoZW52LCBuZXcsIG9sZCk7Cit9
CisjZW5kaWYKKworCiAvKiBIaXN0b2dyYW0gaW5zdHJ1Y3Rpb25zICovCiAKIHZvaWQgSEVMUEVS
KHZoaXN0KShDUFVIZXhhZ29uU3RhdGUgKmVudikKQEAgLTE2NDgsNiArMTY1NywxMSBAQCBzdGF0
aWMgaW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRl
ICplbnYpCiAgICAgfQogfQogCit2b2lkIEhFTFBFUihyZXNjaGVkKShDUFVIZXhhZ29uU3RhdGUg
KmVudikKK3sKKyAgICByZXNjaGVkKGVudik7Cit9CisKIHZvaWQgSEVMUEVSKHdhaXQpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIHsKICAgICBCUUxfTE9DS19HVUFSRCgpOwot
LSAKMi4zNC4xCgo=

