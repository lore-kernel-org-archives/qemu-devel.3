Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CABC44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkR2I-0000ee-Cs; Thu, 16 Jul 2026 14:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkR2G-0000Yc-8c
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:42:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wkR2D-0007Bh-MN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:42:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GHZbRb3544348
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LkaDelEKNx7MsX/JN2SmKt
 Uf/rAYUFDWAASnBuzrBKQ=; b=oknMzbv50ayut60pM78GdLluVt48Xk5vXbIVNe
 Z13VH8Mya63uxH9dZvdt8ek09OU7Ek0ZVuDTzjwyrcNaS7AVcsweR8QcLFTSWOtk
 2XL46dW7KLUs87jp5Rzp8vHPRS1Pf79rZRXMHL8f1x1k390mayA0uYmrxpWZ22DK
 BfUtjFehZWWWgwV6XFMDP2jqwGt3SYJWxXPNAkIIyhqxMhzCp22Zh4rE9Kxz0Ror
 gBF/xd6q2HTaKadfHJHvlgIZCgCIsO9jKIpsJJwI372VO1ywi8lQK6O92rRi8E1q
 5Fbugq08dqQbLkcnAeNXfr/1E67EJ8dQSKUIa7oz5GC+FEUA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u808m9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:42:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so9983129a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784227330; x=1784832130; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LkaDelEKNx7MsX/JN2SmKtUf/rAYUFDWAASnBuzrBKQ=;
 b=Yy3uQoefrz38Dcz1EGja6rPWhh1nufoxvXB9q/LVyjHktMRNeOaPph+ewrAv4Jtx2r
 YGwthbNFIQAiFURueaazvgKaLOaavUFu4aDOFMZ2qc47ZFW5Upk/jcM6kLazgSvF3s2n
 XEkTLSvyGY/Vig6lo7MPMFHXdzBgNQbon1tzNJEHUBe2ewoI3h2ziWHiZVeu+RPUDOGx
 TlQ0LJ0IgYy9+oV9zmtuGQQ/r0MDoFuEkVk8lUSbb0WTt7cUr6qLqy5JtDo6OBzMvZzQ
 abb1rGFRhYR3tJW+S2L4P7cdrQtavN4G7FYZ2EHEySRWNPxkO0AN5W1+GPHKNXMj2ZKX
 dJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784227330; x=1784832130;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LkaDelEKNx7MsX/JN2SmKtUf/rAYUFDWAASnBuzrBKQ=;
 b=MlXpS1aHxqtOx5UqQE8QnAHnAWELS56eZjckd5Bm/n7QJFtJwX5ASc5IcdiIaNOk+2
 wB7DoZPJ1Ol4SZdoZymyhtqS5oiCIxFtBQzGSUvj/ezFwCAvIvWq0IbUgW4dKZCW3CYr
 qcMQ5MUq20gSRjQOZfrP9pMnGpzq0D0E1/JZ4QtlRA7fjarDfyhz/Hz76L8eJ5ThVC9R
 GI3uFxuIUTexvxSSeGjjTZJbIcBM//E7jCUGHmLxheOeDxFyKhTRBlSaSamftxCu1R4I
 Y+ceOAuz6pzV/yyqi+0RGxDxSjshOOHPFbOKWhUtyN4Z/+cuW0yzA/rgMcpF5cXIpCIC
 6nKg==
X-Gm-Message-State: AOJu0YzFbU7zuMIFC8l7yWuWcR41THHJis9AN0SJScXRWVDiuBPKgIl7
 WQK4uw8/M3xsX6NRb3OEhZ1GjExiCnMcY/oOxTn6aUASpnffcvqkYmUhtWh9Hwv+p0Yq7xN4WHD
 UBrlN8LGSang5xfwzFS+coEA+SDkh/Q4IXeFIXr3WwGtLhZDN/HzR+4TIyDjTUTYyZA==
X-Gm-Gg: AfdE7clRZDeCRZKodWvw65PVxpWntFPEjzSEAXbl/cLEsVv8aDTfhdYUjCQ1468CAKi
 WEBJy2Zc7P2nti9GxDzaNODA4YY12cwVcKb05ePuGuJB9nuerGc2Xr7mQKiDSYHYGradi8/khAB
 qO/exBantIuRCnugQXv/FE5AQGxE7j8xS4HTEENcXndCB7b8YjcVa9xu5XzOXO+xZXpUQ5eq/sk
 WmB10DA3FTA2oC2++vvGo+Q+TJ08y9ELFZP1909tC3fvy97gUJrejNWpxMcMlF9BegCUxDg2y8+
 gm1jqtXzl/gPfuA/nmVHg01cPk8/i3OEJ75or2bKfsbuB3Ml5p7UmQ8U4dfEVQCDsRN9r7URaVS
 TK5TZIwkYkfDeRoH2/XtMqyb7B+48NXiiRx0ScMOyoJEgFFRH
X-Received: by 2002:a05:6300:2293:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3c36c34e851mr9436940637.38.1784227329351; 
 Thu, 16 Jul 2026 11:42:09 -0700 (PDT)
X-Received: by 2002:a05:6300:2293:b0:3bf:5539:f93 with SMTP id
 adf61e73a8af0-3c36c34e851mr9436907637.38.1784227328904; 
 Thu, 16 Jul 2026 11:42:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6e9edfsm13993919eec.28.2026.07.16.11.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:42:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: fix -Wshadow=local build error on GCC 14
Date: Thu, 16 Jul 2026 11:41:32 -0700
Message-Id: <20260716184207.3357340-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5MCBTYWx0ZWRfX7DlYMYgohpXE
 Qj4wD7bt3XdggTgveq5rrnenS4zFmDfXuECHdYfFSccqtC4xwHtyOb2dJEoWL0hZ+9yaKKh4w95
 uAcs8ZsF7oa6zIUiEmw93iZGQyKpPOM0Pzh8wj4C0YXhajC8c1rnRWA6Dbwt6S76PstbpQNQkNx
 7j/CKXbCrefdPlrLRQqfdZF4q3IuDkIxa+HLIvOCAZy2nvTDhtIU9ikpU+64D/kkPVmnYkATEVR
 JJgQsbISm/jXSjYr9NaHsQcEzurfJXwhcXredEISNjv1a1IOfv/6/Dz+X5A7ZSnN6ozZNjO1+S9
 mvu6c8IQ1NnSgmeNIicGsAWuQ5dVQLfSFp7OM42wN8aVIYmt37dAUzY1OmZyUSv7A1ZFpxXNK2F
 hT3+d9vCrAaaaaPbPxv1G3sM1WaKz2CktQTCpXN+jdseTEPd5kNumu6Ty9MFV5EbnAOdo2zJYFL
 IExA8CGFDiW0CuvL4xw==
X-Proofpoint-ORIG-GUID: GZWXB5QfGdKHowsIY4YR63lfqhyd0cLJ
X-Proofpoint-GUID: GZWXB5QfGdKHowsIY4YR63lfqhyd0cLJ
X-Authority-Analysis: v=2.4 cv=VMvtWdPX c=1 sm=1 tr=0 ts=6a592602 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BJvf2dmcNa1hIKecAfkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5MCBTYWx0ZWRfX0pKwMwQWnkZs
 72SjkBP/SvS5iUbpTlyhsVwsMl1ZnwdUBXPv15q8QJwpuPz2LMwU6474535KTMTQsSylIz9Xmak
 P9mdZoc0RXZ+B1q1+oE1H3XEJ9S9+hE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160190
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

V2l0aCAtLWRpc2FibGUtaGV4YWdvbi1pZGVmLXBhcnNlciwgdGNnX2Z1bmNzX2dlbmVyYXRlZC5j
LmluYyBmYWlscwp0byBidWlsZCB1bmRlciBHQ0MgMTQgd2l0aDoKCiAgZXJyb3I6IGRlY2xhcmF0
aW9uIG9mICdIQUxGJyBzaGFkb3dzIGEgcHJldmlvdXMgbG9jYWwKICBbLVdlcnJvcj1zaGFkb3c9
bG9jYWxdCgpUaGlzIGJlY2FtZSBhIGhhcmQgZXJyb3Igd2l0aCBHQ0MgY2VkNjUxYjc3NTdlIGBj
MjM6IHRhZyBjb21wYXRpYmlsaXR5CnJ1bGVzIGZvciBlbnVtc2AuCgpBZnRlciB0aGF0IEdDQyBj
aGFuZ2UsIERFQ0xfRklMRV9TQ09QRV9QIGlzIGZhbHNlIGZvciBhbGwKZW51bWVyYXRvcnMsIHNv
IHNoYWRvd2luZyBub3cgZmFsbHMgdW5kZXIgLVdzaGFkb3c9bG9jYWwuCgpSZW5hbWUgdGhlIGxv
Y2FsIHZhcmlhYmxlIHRvIHRtcF9oYWxmIHRvIGF2b2lkIHRoZSBjb2xsaXNpb24uCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZy5oIHwgNCArKy0tCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAg
fCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCBiL3RhcmdldC9oZXhhZ29u
L2dlbl90Y2cuaAppbmRleCBhMjhhZjBjMjQ1Yi4uNDBlMDM3ODFkMzYgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKQEAg
LTQxNCw3ICs0MTQsNyBAQAogCiAjZGVmaW5lIGZHRU5fVENHX1NUT1JFKFNIT1JUQ09ERSkgXAog
ICAgIGRvIHsgXAotICAgICAgICBUQ0d2IEhBTEYgR19HTlVDX1VOVVNFRCA9IHRjZ190ZW1wX25l
dygpOyBcCisgICAgICAgIFRDR3YgdG1wX2hhbGYgR19HTlVDX1VOVVNFRCA9IHRjZ190ZW1wX25l
dygpOyBcCiAgICAgICAgIFRDR3YgQllURSBHX0dOVUNfVU5VU0VEID0gdGNnX3RlbXBfbmV3KCk7
IFwKICAgICAgICAgU0hPUlRDT0RFOyBcCiAgICAgfSB3aGlsZSAoMCkKQEAgLTQyMiw3ICs0MjIs
NyBAQAogI2RlZmluZSBmR0VOX1RDR19TVE9SRV9wY3IoU0hJRlQsIFNUT1JFKSBcCiAgICAgZG8g
eyBcCiAgICAgICAgIFRDR3YgaXJlZyA9IHRjZ190ZW1wX25ldygpOyBcCi0gICAgICAgIFRDR3Yg
SEFMRiBHX0dOVUNfVU5VU0VEID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgVENHdiB0bXBf
aGFsZiBHX0dOVUNfVU5VU0VEID0gdGNnX3RlbXBfbmV3KCk7IFwKICAgICAgICAgVENHdiBCWVRF
IEdfR05VQ19VTlVTRUQgPSB0Y2dfdGVtcF9uZXcoKTsgXAogICAgICAgICB0Y2dfZ2VuX21vdl90
bChFQSwgUnhWKTsgXAogICAgICAgICBnZW5fcmVhZF9pcmVnKGlyZWcsIE11ViwgU0hJRlQpOyBc
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDIxYWI4YWU1YmJmLi44YTMyZDVmNzljMiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTU3Niw4
ICs1NzYsOCBAQCBzdGF0aWMgaW5saW5lIFRDR3YgZ2VuX3JlYWRfaXJlZyhUQ0d2IHJlc3VsdCwg
VENHdiB2YWwsIGludCBzaGlmdCkKICAgICB9IHdoaWxlICgwKQogCiAjaWZkZWYgUUVNVV9HRU5F
UkFURQotI2RlZmluZSBmR0VUSEFMRihOLCBTUkMpICBnZW5fZ2V0X2hhbGYoSEFMRiwgTiwgU1JD
LCB0cnVlKQotI2RlZmluZSBmR0VUVUhBTEYoTiwgU1JDKSBnZW5fZ2V0X2hhbGYoSEFMRiwgTiwg
U1JDLCBmYWxzZSkKKyNkZWZpbmUgZkdFVEhBTEYoTiwgU1JDKSAgZ2VuX2dldF9oYWxmKHRtcF9o
YWxmLCBOLCBTUkMsIHRydWUpCisjZGVmaW5lIGZHRVRVSEFMRihOLCBTUkMpIGdlbl9nZXRfaGFs
Zih0bXBfaGFsZiwgTiwgU1JDLCBmYWxzZSkKICNlbHNlCiAjZGVmaW5lIGZHRVRIQUxGKE4sIFNS
QykgKChpbnQxNl90KSgoU1JDID4+ICgoTikgKiAxNikpICYgMHhmZmZmKSkKICNkZWZpbmUgZkdF
VFVIQUxGKE4sIFNSQykgKCh1aW50MTZfdCkoKFNSQyA+PiAoKE4pICogMTYpKSAmIDB4ZmZmZikp
Ci0tIAoyLjM0LjEKCg==

