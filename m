Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85903606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mKhJujtv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZlZ/+5WR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvz-0004vB-Km; Fri, 30 Oct 2026 21:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvO-0004fW-LF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvM-00034U-Uw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CLdk1726614
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vT/ZtjgQSdAljG7gtd9O1UBFSOsACZDc+i0Hxob6qzU=; b=mKhJujtvRJlcA8ec
 BnlF821heN7SMl+1/m3fpiKc8g+srGNBAvi0/K6dkZE8+uxsxcEbDzOVKcPebaOj
 wy/FWJizf3UBpoFL2f1XYiaZieCjZLIx8ynE0CM2qv5+n1+0tR9drE3DXt1J3fGI
 A/AaX1s94t42ovfZ6lCtUmiExU/ETVFj6s4TXoj8NmsabGhsL5+J13Uk0O+Ua0so
 z+5ASgquJk3X7NUxBz+4M3yNt7U8ESEKwXyCCbAAf/Vj+2O3965S22YdmzrmIqXP
 nRu2kSljRaRMDtaVSpTw/tzBRMZyfmPAo5MszIgsC3tyP0HbydW95FGrKYY9Z3fp
 Gv7uwA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fr2h9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c3c370b17so2153489eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410223; x=1794015023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vT/ZtjgQSdAljG7gtd9O1UBFSOsACZDc+i0Hxob6qzU=;
 b=ZlZ/+5WRVRhXY9wmCWnNg1NfFFtwoT24wlsDFb3wksgOCUwnFynQfXhpA5AcyMhaeJ
 NzvCR9EFxvbaqyE4DHWtID4VTK7wfBFY2YK9KvSOtdQioZQDcj52oP+bZnCDhAva6Yhf
 N+SPUz7QIMUOCzK3gUVt7nax03iR9IPanRC9xlcVRRNBybtX+w/pjdlVvBOwArcTnPP5
 ODbwVzLBXvf87a8f3qHlubg7GpiaSSnxqx3djnTwXx7eJxv0Y9/5sO94CXezHHhDw1TI
 a4wGTDRJ5sp+oXyRCIk6UWSAr5YthYcLRx9iT6JLFMKqEJPyPyilSKWU/uWVUSz4BCf7
 7s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410223; x=1794015023;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vT/ZtjgQSdAljG7gtd9O1UBFSOsACZDc+i0Hxob6qzU=;
 b=o/hph78Tkgbn5ExudoihrEASjscTwGf5BEO4BEVE7lNSHh0TBrlSnID1gihM5tlCv/
 fn4SaxcsO6swlOahVdUIGY4WmqnVoAsStKNm7Hnhj6LXCnyARko7/dDKhW/QsKw0mxQ5
 34jYARl81NyYkrOWXauZ7hKZJExrcTYKqHkJ/FQswEXtr/zso3tPwRJ2xTGrGB2NBNA7
 SioEqvFnf4qmaUMiC8e/EdFrAwTaTkizkWSqHmlNBGZc8UnAM5GuSFTGWKoFQx2y+EIR
 8M+Swv0rEzHR7ExtW/7OyZu0XWI0EPFcT0mo7Nja27xbTxX2kEHHeTxEBROZ57bRhDzv
 pJJA==
X-Gm-Message-State: AFq9FYI/hFkfv1Tr/yW9PeTW/EVsTcfHu/YPNOCDWAwDvIP73RcuI1h7
 6yaOyJCkmyFKb4pPtZ4/OIv967rKIAPiaGiKIRQJO9jkQ/HvDgsdE+FEXLNmHWw545ZzdOipFKg
 K/ZYKZwwFpCE6bSR22RA0+OxG/pJ2bX0h0pZHN8yPaDtXLBeu4VZFNbnU52UtSCLHjw==
X-Gm-Gg: AYBFou2n+8MAdfXftwX2Y/2LRwJthdy5Fr/5LQNY4I6S3OTIiiFP7kSiGhQ5wBmOmoN
 O3yk+VK6QdC8WZtgmxacaqVtwCrhoNS0mBH6vqUXoGcUxcjrgWyRBeOqv7kRYiOtukjOZY9xWL6
 ZeivQtotxzYkmcXwxptZ2ALYTREPqS8KKKdOCNBxlVkGbq2mEC6/jBG92ozbVgTN3MSP+M2CThs
 JNr4DBU3RSLOjU9f8GO1Wn97p1C/tPeXHfqqNxQ0fZyeq1u2Kg1nXhNmuqKQp0mMJacVAYywdX1
 FMRAWHfTWbGcauuLQPgrQVupb0LbUoHm9SjMmxwmE20jpXeI+DERHswLoWksO+U2abWhlbNZFmU
 Daf+FPLKiP2a5EOE9vGA5R+KuMPBV5+CIP9Aqe+FPgW4OUBD7IZHR74FYXiWB5Zewx/sDdS6OMg
 n32ERPzvihX8fMuyWeeW7ufw==
X-Received: by 2002:a05:7300:b098:b0:369:3e30:c665 with SMTP id
 5a478bee46e88-36a423fb4a1mr5277326eec.33.1793410222775; 
 Fri, 30 Oct 2026 18:30:22 -0700 (PDT)
X-Received: by 2002:a05:7300:b098:b0:369:3e30:c665 with SMTP id
 5a478bee46e88-36a423fb4a1mr5277292eec.33.1793410222194; 
 Fri, 30 Oct 2026 18:30:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 15/40] target/hexagon: add an HLX instruction trace event
Date: Fri, 30 Oct 2026 18:29:16 -0700
Message-Id: <20261031012941.339141-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX/JPkI5XXa0vA
 V0kX/oZkvBnvAkGuk8C5+FeNIvFSH2BbXtAOQMJwkMiJBaT4kgarjCs2pWEP05MCj9HAjUF4Pzv
 Q6GOQVkkFQ+PV6ZKjerG8tulErgz17M=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae544af cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IXyAJek13VJD9ROJmn4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: Bw0Jfhhkqza6dfswm-Xjua89wW2DLbYJ
X-Proofpoint-ORIG-GUID: Bw0Jfhhkqza6dfswm-Xjua89wW2DLbYJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfXyyNHH4dIRvqH
 jxGVOaZrp2VZl9x4DddQK1sfXa8pHx8Ej8QlI+kwHlE5jmMJhrxDtq4Vjqj0XM4Kl3guHYyLsVe
 lmxEdycXNMp4hBq6d8P2yjrdmFh3wLpzmMG9C0fDipIaDGufPcI8APETSHvc5qtW2JarTe1HVqs
 TfUHbbI0Vk41mnfYBHSRUfh/BswXQd9G6FbHSMK07RCo7071OPK0oqfRdqWWDP1AwQQwak0pHRV
 6LU2OwDeCcS1DM4bAhdCzcNSHKxx0fLpnwMBH71eJpAkxrIwTZE3Bz2NMRX0ZhkuLbkxbHjtOkd
 e6WxLAmnvv0836EEdtgi1BKDPa0lN55TgahTE87oUBxqwMaQlLhFXJIvo66jdOry1BJICWvY97F
 bfX2T+IFibWMNdsoPmcJ6VgQUuHea4zUfQQLCgzeyTSK6p/RFznQisE9Yk0lC+7lLvE3zCU7LjW
 1pu+me9hNO/bFKVl+tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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

RnJvbTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KCkFkZCBh
IHRyYWNlIGV2ZW50IHRoYXQgcmVwb3J0cyB0aGUgZXhlY3V0ZWQgSExYIG9wY29kZSBhbmQgbmFt
ZS4KClNpZ25lZC1vZmYtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29t
bS5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgfCAxICsKIHRhcmdldC9oZXhhZ29u
L2hlbHBlci5oICAgICB8IDMgKysrCiB0YXJnZXQvaGV4YWdvbi90cmFjZS5oICAgICAgfCAyICsr
CiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCA3ICsrKysrKysKIHRhcmdldC9oZXhhZ29u
L3RyYWNlLWV2ZW50cyB8IDYgKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMo
KykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi90cmFjZS5oCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vdHJhY2UtZXZlbnRzCgpkaWZmIC0tZ2l0IGEvbWVzb24u
YnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCA3ZWMzZmI5MDIzMy4uNzFmMTM1ZjA1MzAgMTAwNjQ0
Ci0tLSBhL21lc29uLmJ1aWxkCisrKyBiL21lc29uLmJ1aWxkCkBAIC0zNjk1LDYgKzM2OTUsNyBA
QCBpZiBoYXZlX3N5c3RlbSBvciBoYXZlX3VzZXIKICAgICAndGFyZ2V0L2FybScsCiAgICAgJ3Rh
cmdldC9hcm0vaHZmJywKICAgICAndGFyZ2V0L2FybS90Y2cnLAorICAgICd0YXJnZXQvaGV4YWdv
bicsCiAgICAgJ3RhcmdldC9ocHBhJywKICAgICAndGFyZ2V0L2kzODYnLAogICAgICd0YXJnZXQv
aTM4Ni9rdm0nLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAppbmRleCA4YTJhNjU2M2QyMi4uMjQ1Y2Q1MGI4OWMgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5o
CkBAIC0zMSw2ICszMSw5IEBAIERFRl9IRUxQRVJfRkxBR1NfNCh2YWNzaF9wcmVkLCBUQ0dfQ0FM
TF9OT19SV0dfU0UsIHMzMiwgZW52LCBzNjQsIHM2NCwgczY0KQogREVGX0hFTFBFUl9GTEFHU18y
KGNhYmFjZGVjYmluX3ZhbCwgVENHX0NBTExfTk9fUldHX1NFLCBzNjQsIHM2NCwgczY0KQogREVG
X0hFTFBFUl9GTEFHU18yKGNhYmFjZGVjYmluX3ByZWQsIFRDR19DQUxMX05PX1JXR19TRSwgczMy
LCBzNjQsIHM2NCkKIAorLyogSExYIGhlbHBlcnMgKi8KK0RFRl9IRUxQRVJfRkxBR1NfMihobHhf
dHJhY2Vfb3AsIFRDR19DQUxMX05PX1JXRywgdm9pZCwgZW52LCBpMzIpCisKIC8qIEZsb2F0aW5n
IHBvaW50ICovCiBERUZfSEVMUEVSXzMoY29udl9zZjJkZiwgZjY0LCBlbnYsIGYzMiwgaTMyKQog
REVGX0hFTFBFUl8zKGNvbnZfZGYyc2YsIGYzMiwgZW52LCBmNjQsIGkzMikKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL3RyYWNlLmggYi90YXJnZXQvaGV4YWdvbi90cmFjZS5oCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5lODg2Y2UwYjYzYQotLS0gL2Rldi9udWxs
CisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYWNlLmgKQEAgLTAsMCArMSwyIEBACisvKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLworI2luY2x1ZGUgInRyYWNlL3Ry
YWNlLXRhcmdldF9oZXhhZ29uLmgiCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IGNiNmE0ZWU3MTMyLi42MmUz
OGM2ODc1NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTM3LDggKzM3LDEwIEBACiAjaW5jbHVkZSAibW12
ZWMvbW12ZWMuaCIKICNpbmNsdWRlICJtbXZlYy9tYWNyb3MuaCIKICNpbmNsdWRlICJvcF9oZWxw
ZXIuaCIKKyNpbmNsdWRlICJvcGNvZGVzLmgiCiAjaW5jbHVkZSAiY3B1X2hlbHBlci5oIgogI2lu
Y2x1ZGUgInRjZy90Y2ctZ3ZlYy1kZXNjLmgiCisjaW5jbHVkZSAidHJhY2UuaCIKICNpbmNsdWRl
ICJ0cmFuc2xhdGUuaCIKICNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCiAjaW5jbHVkZSAicWVtdS90
aW1lci5oIgpAQCAtNjgsNiArNzAsMTEgQEAgdWludDY0X3QgSEVMUEVSKHV0aW1lcikodm9pZCkK
IH0KICNlbmRpZgogCit2b2lkIEhFTFBFUihobHhfdHJhY2Vfb3ApKENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50MzJfdCBvcGNvZGUpCit7CisgICAgdHJhY2VfaGV4YWdvbl9obHhfb3Aob3Bjb2Rl
LCBvcGNvZGVfbmFtZXNbb3Bjb2RlXSk7Cit9CisKICNkZWZpbmUgU0ZfQklBUyAgICAgICAgMTI3
CiAjZGVmaW5lIFNGX01BTlRCSVRTICAgIDIzCiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYWNlLWV2ZW50cyBiL3RhcmdldC9oZXhhZ29uL3RyYWNlLWV2ZW50cwpuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNDIzNWRjNmFjMmUKLS0tIC9kZXYvbnVsbAorKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFjZS1ldmVudHMKQEAgLTAsMCArMSw2IEBACisjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisjCisjIFNlZSBkb2NzL2RldmVsL3Ry
YWNpbmcucnN0IGZvciBzeW50YXggZG9jdW1lbnRhdGlvbi4KKworIyBITFggaW5zdHJ1Y3Rpb24g
dHJhY2luZworaGV4YWdvbl9obHhfb3AoaW50IG9wY29kZSwgY29uc3QgY2hhciAqbmFtZSkgIm9w
Y29kZTogMHgleCAoJXMpIgotLSAKMi4zNC4xCgo=

