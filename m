Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626C0C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 17:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toQWf-0003DJ-0X; Sat, 01 Mar 2025 12:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWM-00039l-8a
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toQWJ-0008R6-4o
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 12:21:01 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5214CEwH027852
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 17:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Aye223KXHv+2kcl88JL/DtaxgHdbL01YAOvAc87FX8=; b=o1P5CpzLl19jDiWm
 pJ+14AgZ/Aw5JikNoh3zPl13vdtND4oaprPkBOLdFzrm2CMpPY04I/AXFgZLYkJ3
 l+ZzHq+yGxkNbqcQNtRSzoQR8WG2OaeZsq7bCYacNq6dKDBSOp7ITbLgk++wLYLg
 4AR9W929HdRmMTFuCUvHn8k1foHcq0rPqtrgu+kLCISwQTPMyLsuTDNv2OfHmXaw
 TON4pjuhN3howqdEeTtyyO4KZpmqIqtt4oq/6MNzk5NalnrAQjd0Lp795S8W5P5b
 C+k2pQP2RmA8QUlmHB2daWWekttRPCank1iWfU/EA00V+Yh/nnparDknyzEXUUKq
 5h/4ng==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453u0d11d6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 17:20:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fe9527c041so6440223a91.0
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 09:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740849657; x=1741454457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Aye223KXHv+2kcl88JL/DtaxgHdbL01YAOvAc87FX8=;
 b=pB1ZVSylQnev6RiIRld/jCOySV4622xPW2fSal8HAR7rKI10oW1B6RzuA1Xttl34MB
 NCARhbHj5HOWzO5JTMROTCHP6SKqqPLysMxECyFYNZztgi0jpWI+h4AhhVO+mk/P09iF
 rtZfo4j9tmkqd9OJlquPFXFAaQ609Pmp2jiW7FChZm4uSVR5e6Ql5SyFU1IWMVlAEw4N
 Ob6m7cJFKKHRs90PErN8D7i870qS7wXkc8grFCoY/hEokDixr2k6Ft8i2cC1usebdwC0
 AOx1n3qS4iDbD5u1gIMHIeUmFEZfdbceZHxiTtgmV42E+JYi4kQiW2rkTDVazqjQrp00
 E/Bw==
X-Gm-Message-State: AOJu0YzSOoRw2RzKGtj6eY1FDTzlYMs/taFTADeOFmTxcOCfrZ2bule8
 OPPdM2c0AxaXdFLK97svStQXRFtfIhwTX8g5FIYrS6nKq88a6EGvKwGHEKqOjHy+50IDZSaQod2
 nd73jwV1yCA4syRb+JfRx9Bo1mhm2fj5KSPItJKkwkvHEa8S/nwldIgta4wd3Tw==
X-Gm-Gg: ASbGncs0ZOMumeAKgjbolx+xcVZLjWFoTy2fIcrRuAEyYWMPf4MdSZaao73QYxewwfd
 YYc6miS6rOTd9V9Lmw4O0YPtsFSyMXZa2mWlAOkrbtG8XhTNeI9QUV3Kqsg61xk7NF04x5N/Qv9
 5RikGQ7kVn/PuUZPLJUTGnSfMEuAuFjWKmM9cbJdwczdK+U9Hq6rdbvkg0rb3aDdAaGlvV9D+DK
 HxZV0KmlTEi4n5JOCaZmO/4jOy/gFPrhToDVhWv/UkW+oHVe+QLRimAy0AqiNYKtFxmP4THvtwf
 l3J1g+n4lsUyE6y5f/sLfskjOi/VnNE21ScIN2r/yI0x1eZC3zRNvlv0ZzOGoDNN
X-Received: by 2002:a17:90b:4acb:b0:2fa:1e3e:9be7 with SMTP id
 98e67ed59e1d1-2febab1f31dmr10872398a91.5.1740849656642; 
 Sat, 01 Mar 2025 09:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxQfhvWO59OM5Yucv7etrTI3cz6x9gul2h4pU4+1L2DJWAe0Il4gxuyKYBt++HnIWnmESFCQ==
X-Received: by 2002:a17:90b:4acb:b0:2fa:1e3e:9be7 with SMTP id
 98e67ed59e1d1-2febab1f31dmr10872365a91.5.1740849656254; 
 Sat, 01 Mar 2025 09:20:56 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9dacsm51308275ad.83.2025.03.01.09.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 09:20:55 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 3/8] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Sat,  1 Mar 2025 09:20:40 -0800
Message-Id: <20250301172045.1295412-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: VDpjght-QvRnIwnWy_SkwV5418A-YnNM
X-Proofpoint-GUID: VDpjght-QvRnIwnWy_SkwV5418A-YnNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 mlxlogscore=795
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaHcvaGV4YWdvbi9tYWNo
aW5lX2NmZ19zYTg3NzVfY2RzcDAuaC5pbmMgfCA2NCArKysrKysrKysrKysrKysrKysrKysrCiBo
dy9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y2OG5fMTAyNC5oLmluYyAgICB8IDY1ICsrKysrKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspCiBjcmVhdGUg
bW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVfY2RzcDAuaC5pbmMKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y2OG5fMTAyNC5oLmluYwoK
ZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIGIv
aHcvaGV4YWdvbi9tYWNoaW5lX2NmZ19zYTg3NzVfY2RzcDAuaC5pbmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uZDhmYTk2MWY2ZAotLS0gL2Rldi9udWxsCisrKyBiL2h3
L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0wLDAgKzEsNjQgQEAK
Kworc3RhdGljIGhleGFnb25fbWFjaGluZV9jb25maWcgU0E4Nzc1UF9jZHNwMCA9IHsKKyAgICAu
Y2ZnYmFzZSA9ICAgICAgICAgMHgyNDAwMDAwMCArIDB4MTgwMDAwLAorICAgIC5sMnRjbV9zaXpl
ID0gICAgICAweDAwMDAwMDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAweDI2MzAwMDAwICsg
MHg5MDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgMHgwMDAwMTAwMCwKKyAgICAuY3NyX2Jh
c2UgPSAgICAgICAgMHgyNjMwMDAwMCwKKyAgICAucXRtcl9yZzAgPSAgICAgICAgMHgyNjMwMDAw
MCArIDB4QTEwMDAsCisgICAgLnF0bXJfcmcxID0gICAgICAgIDB4MjYzMDAwMDAgKyAweEEyMDAw
LAorICAgIC5jZmd0YWJsZSA9IHsKKyAgICAgICAgLmwydGNtX2Jhc2UgPSAweDAwMDAyNDAwLAor
ICAgICAgICAucmVzZXJ2ZWQwID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnN1YnN5c3RlbV9iYXNl
ID0gMHgwMDAwMjYzOCwKKyAgICAgICAgLmV0bV9iYXNlID0gMHgwMDAwMjQxOSwKKyAgICAgICAg
LmwyY2ZnX2Jhc2UgPSAweDAwMDAyNDFhLAorICAgICAgICAucmVzZXJ2ZWQxID0gMHgwMDAwMjQx
YiwKKyAgICAgICAgLmwxczBfYmFzZSA9IDB4MDAwMDI1MDAsCisgICAgICAgIC5heGkyX2xvd2Fk
ZHIgPSAweDAwMDAwMDAwLAorICAgICAgICAuc3RyZWFtZXJfYmFzZSA9IDB4MDAwMDAwMDAsCisg
ICAgICAgIC5yZXNlcnZlZDIgPSAweDAwMDAwMDAwLAorICAgICAgICAuZmFzdGwydmljX2Jhc2Ug
PSAweDAwMDAyNDFlLAorICAgICAgICAuanRsYl9zaXplX2VudHJpZXMgPSAweDAwMDAwMDgwLAor
ICAgICAgICAuY29wcm9jX3ByZXNlbnQgPSAweDAwMDAwMDAxLAorICAgICAgICAuZXh0X2NvbnRl
eHRzID0gMHgwMDAwMDAwNCwKKyAgICAgICAgLnZ0Y21fYmFzZSA9IDB4MDAwMDI1MDAsCisgICAg
ICAgIC52dGNtX3NpemVfa2IgPSAweDAwMDAyMDAwLAorICAgICAgICAubDJ0YWdfc2l6ZSA9IDB4
MDAwMDA0MDAsCisgICAgICAgIC5sMmVjb21lbV9zaXplID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LnRocmVhZF9lbmFibGVfbWFzayA9IDB4MDAwMDAwM2YsCisgICAgICAgIC5lY2NyZWdfYmFzZSA9
IDB4MDAwMDI0MWYsCisgICAgICAgIC5sMmxpbmVfc2l6ZSA9IDB4MDAwMDAwODAsCisgICAgICAg
IC50aW55X2NvcmUgPSAweDAwMDAwMDAwLAorICAgICAgICAubDJpdGNtX3NpemUgPSAweDAwMDAw
MDAwLAorICAgICAgICAubDJpdGNtX2Jhc2UgPSAweDAwMDAyNDAwLAorICAgICAgICAucmVzZXJ2
ZWQzID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmR0bV9wcmVzZW50ID0gMHgwMDAwMDAwMCwKKyAg
ICAgICAgLmRtYV92ZXJzaW9uID0gMHgwMDAwMDAwMywKKyAgICAgICAgLmh2eF92ZWNfbG9nX2xl
bmd0aCA9IDB4MDAwMDAwMDcsCisgICAgICAgIC5jb3JlX2lkID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLmNvcmVfY291bnQgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9yZWcwID0gMHgw
MDAwMDA0MCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMSA9IDB4MDAwMDAwMjAsCisgICAgICAgIC52
MnhfbW9kZSA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5jb3Byb2MyX3JlZzIgPSAweDAwMDAwMDA4
LAorICAgICAgICAuY29wcm9jMl9yZWczID0gMHgwMDAwMDAyMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnNCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzUgPSAweDAwMDAwMDAyLAor
ICAgICAgICAuY29wcm9jMl9yZWc2ID0gMHgwMDAwMDAxNiwKKyAgICAgICAgLmNvcHJvYzJfcmVn
NyA9IDB4MDAwMDAwMDYsCisgICAgICAgIC5hY2RfcHJlc2V0ID0gMHgwMDAwMDAwMSwKKyAgICAg
ICAgLm1uZF9wcmVzZXQgPSAweDAwMDAwMDAwLAorICAgICAgICAubDFkX3NpemVfa2IgPSAweDAw
MDAwMDEwLAorICAgICAgICAubDFpX3NpemVfa2IgPSAweDAwMDAwMDIwLAorICAgICAgICAubDFk
X3dyaXRlX3BvbGljeSA9IDB4MDAwMDAwMDIsCisgICAgICAgIC52dGNtX2Jhbmtfd2lkdGggPSAw
eDAwMDAwMDgwLAorICAgICAgICAucmVzZXJ2ZWQzID0gMHgwMDAwMDAwMSwKKyAgICAgICAgLnJl
c2VydmVkNCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5yZXNlcnZlZDUgPSAweDAwMDAwMDAzLAor
ICAgICAgICAuY29wcm9jMl9jdnRfbXB5X3NpemUgPSAweDAwMDAwMDBhLAorICAgICAgICAuY29u
c2lzdGVuY3lfZG9tYWluID0gMHgwMDAwMDBlMCwKKyAgICAgICAgLmNhcGFjaXR5X2RvbWFpbiA9
IDB4MDAwMDAwODAsCisgICAgICAgIC5heGkzX2xvd2FkZHIgPSAweDAwMDAwMDAwLAorICAgIH0s
Cit9OwpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMg
Yi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y2OG5fMTAyNC5oLmluYwpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAwLi42MGViMTEyYTExCi0tLSAvZGV2L251bGwKKysrIGIvaHcv
aGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMKQEAgLTAsMCArMSw2NSBAQAorCitz
dGF0aWMgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB2NjhuXzEwMjQgPSB7CisgICAgLmNmZ2Jhc2Ug
PSAgICAgICAgICAgMHhkZTAwMDAwMCwKKyAgICAubDJ0Y21fc2l6ZSA9ICAgICAgICAweDAwMDAw
MDAwLAorICAgIC5sMnZpY19iYXNlID0gICAgICAgIDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3Np
emUgPSAgICAgICAgMHgwMDAwMTAwMCwKKyAgICAuY3NyX2Jhc2UgPSAgICAgICAgICAweGZjOTAw
MDAwLAorICAgIC5xdG1yX3JnMCA9ICAgICAgICAgIDB4ZmM5MjEwMDAsCisgICAgLnF0bXJfcmcx
ID0gICAgICAgICAgMHhmYzkyMjAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRj
bV9iYXNlID0gMHgwMDAwZDgwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisg
ICAgICAgIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMGZjOTAsCisgICAgICAgIC5ldG1fYmFzZSA9
IDB4MDAwMGQ4MTksCisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAgICAgICAg
LnJlc2VydmVkMSA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkODQw
LAorICAgICAgICAuYXhpMl9sb3dhZGRyID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLnN0cmVhbWVy
X2Jhc2UgPSAweDAwMDBkODFjLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwZDgxZCwKKyAg
ICAgICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwZDgxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9l
bnRyaWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAw
MSwKKyAgICAgICAgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jh
c2UgPSAweDAwMDBkODQwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMTAwMCwKKyAg
ICAgICAgLmwydGFnX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9
IDB4MDAwMDA0MDAsCisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAor
ICAgICAgICAuZWNjcmVnX2Jhc2UgPSAweDAwMDBkODFmLAorICAgICAgICAubDJsaW5lX3NpemUg
PSAweDAwMDAwMDgwLAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmwyaXRjbV9zaXplID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAw
ZDgyMCwKKyAgICAgICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJl
c2VudCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDEsCisg
ICAgICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9p
ZCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAw
eDAwMDAwMDIwLAorICAgICAgICAudjJ4X21vZGUgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29w
cm9jMl9yZWcyID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MWYxZjFm
MWYsCisgICAgICAgIC5jb3Byb2MyX3JlZzQgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9j
Ml9yZWc1ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MWYxZjFmMWYs
CisgICAgICAgIC5jb3Byb2MyX3JlZzcgPSAweDFmMWYxZjFmLAorICAgICAgICAuYWNkX3ByZXNl
dCA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgxZjFmMWYxZiwKKyAgICAg
ICAgLmwxZF9zaXplX2tiID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDFmMWYxZjFmLAorICAgICAg
ICAudnRjbV9iYW5rX3dpZHRoID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkMyA9IDB4
MWYxZjFmMWYsCisgICAgICAgIC5yZXNlcnZlZDQgPSAweDFmMWYxZjFmLAorICAgICAgICAucmVz
ZXJ2ZWQ1ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MWYxZjFmMWYsCisgICAg
ICAgIC5jYXBhY2l0eV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuYXhpM19sb3dhZGRy
ID0gMHgxZjFmMWYxZiwKKyAgICB9LAorfTsKKwotLSAKMi4zNC4xCgo=

