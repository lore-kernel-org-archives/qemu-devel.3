Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2E7CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 05:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgJW-0006bZ-0P; Mon, 19 Oct 2026 01:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJQ-0006Zw-8L
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJJ-0001Iz-2R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j3o72264935
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ys/aihXAHCGqFpH/VF0KZA3/jEbrPIDAW5i7LAybKgQ=; b=Hm5GKnDjP6RhFRUD
 rXP2hbkikkBsN4y2Vwl4cNb0qc2CrZ6vqRdKeCd1BKhp2604eUfuKc+6+8q+8ii3
 stzF+Qk1rXaXhK0TD2vTYd0Th84mp3rCH7uIFidecy1imhGaDIjqJo5mckbsSmRY
 eyh5B78+lJT/NaS+SR3TVWtn0V+0vfVIw9A+jwBJxTMqrDcSwQ5HDIEYttKNNJuk
 GTaSplCWSkzY0iGb1sajSP4ZIHKBH4STatvlL6PqcuJ2p4YJrtJ7+6EvliQH0kN6
 QjYNh7nSvhdcRcoZ3ZfA16QxYppMHkLC7GIDSCEe6rlQaeXE65USuG1m2dbhzHWY
 aeL5qw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxn5sk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:53:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3886385eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792389193; x=1792993993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ys/aihXAHCGqFpH/VF0KZA3/jEbrPIDAW5i7LAybKgQ=;
 b=NtthG8KFR3YWSz7SwMfoNLplcA93tSdHoC599GxKzePBXKL+bBfnjeEmW9cdxt3JeN
 MNYSRJPP0hHqPtDWMrjp7/BzBZnCyRQ34LPyFL1/ijTJpsqPxSINZZWCgfxWrCnYHfoZ
 BnnMd1GFu5zv7qrk3mrXqqzTk3Fewwm0ZETJ3s6gfTcN12+Ybs5YX6I1gfxW1E7GJLb/
 0/fe4ESqa24mN0ese9Par1KqQL6Rvqa+s+kF128Ehe8hK8V3MaUj/rAxvZqSmyIQeNmq
 VfGeH30rHbXV1NJrTCAsQEkcOutpItpFa07yPSlYFw9CbtXYrCUDKIUKTeo9rGuNFs1X
 NrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792389193; x=1792993993;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ys/aihXAHCGqFpH/VF0KZA3/jEbrPIDAW5i7LAybKgQ=;
 b=cC8lZk1mSzTQDtS9pVE0nBiK/6GJNdvRt6XzpvaGjgMcfcr7O/hCwLaam4R8zjCTIa
 6AOqoVaNB9pGYde+HrNG6NTqqPGDuP4zpI3yOHg/2obC/oQ3CP3bPsb0a1B6Djv6mgD9
 s/LDhS3xXc6lm2P3ZMQbDXKRoeOdXZWMEROJPT+C2/i/do1nK0o4Gg3MNAQ2MnhAJZ+n
 If0SFSdQnWirV4LWELf9gvFv4QQP67kuPM2QN315jyXmbPJuLkSfhCi8Ydce81y8FBYS
 nGi/2zVZJda0pf7bu2DCkIVlkvpWLnYXWgR12pHeGB8ze87w3Iw+XE+kt/wX/mxMUrFS
 SmCg==
X-Gm-Message-State: AFq9FYLfXtymZV0kXHOhkqtTYc7dKGCDlPOPzSlQo/beuonwcAJFPzBz
 XnCkehuttCyrV8CuYEsUNpN0LewZDCNse9EG3vystPKMWlBVd8Gr1Vs17KsZyoxjastoiX4XqZP
 KOyklNnXHSXVyWPX+AYY03lFTaiseZJRCDsKk9X9xZvSNAsoJRTyxSKIgT6tlawOj+Q==
X-Gm-Gg: AYBFou1VtKtxHrlD0LZcHBq6IkBGAmnBX2OKt1eBL8FNi9D5+CAkZU7dC9s7qnCevMM
 xfq84lUj18wUvecEg3rlHKZ4WnjKD019zDPoKar+SjEchcENhhgMKxD0D8qWEOPOtoxbia6o6RS
 wBcVC8MpdLAk3qGsEtRqvTIt/p793kLmWJl2gCvydna42OslLinm7t5Ub2xO6/UCy+kJYU1H6XI
 FnOZuixT2OW9Uf0pSt7h9KFAOGkwfalg6XsCx8h7ZP0cgTI1Fonzzy0ScemAjjS5VVVVqjzLarG
 ryhWryesqT+s7CEU179GOsezadZr4HuaGJXIajwT98DFBKRQU2uIAw5XwihjDFoHmy7IOrQScq0
 lgtVizZghEpriQ3vsabk6K2LXhjrwheNbM21KnwFeYElJ130=
X-Received: by 2002:a05:701b:4201:20b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-1850c22369cmr10804102c88.3.1792389192441; 
 Sun, 18 Oct 2026 22:53:12 -0700 (PDT)
X-Received: by 2002:a05:701b:4201:20b0:168:6ad8:e89f with SMTP id
 a92af1059eb24-1850c22369cmr10804067c88.3.1792389191844; 
 Sun, 18 Oct 2026 22:53:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm25672781c88.15.2026.10.18.22.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:53:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
Date: Sun, 18 Oct 2026 22:52:45 -0700
Message-Id: <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX19bsCgXtmJSG
 XyTSEGIlrQcse71GHukxkBYp4pHVRfU2TbCAeZPTRJGKORGqVAthPhOdPI5LeQIwn0+C5KRr5Jc
 mJrekNJtWJNv0MK5o+ffyOh0coeUb9Q=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad5b049 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX8Q0DX8oCjDAj
 3Uq7ZHrmffQ8Kz8ZVQ+1CKZbFRarknw7SrLZ3eYahtdfLPO53XNZfbaQ5IM5jBa3INQNTeu2jzz
 IeDzqGNc+BSENUYyUse9fvfuC+mhl/0SrUrfChHO5hx22I1C20ZDfjvslZ55fEzkpSENtlYXkD+
 9Q7zSMxH8H9yyMZGlNjTEzO5Gs3BX7BpKrIAgDVz7AxVQQNI0Fegls0ioCzaReu08pECKYZWPRd
 qHuF881k6aFLUJfkuvXo8+r4I+zpUc39frOGNFJ9g/fYpzjGavg7Ai54TMKKDheAFbJZ4gIKW4Q
 aqfHBIFAVC56Al3CAvesne1gNSyTWiU3LP780pY2AIauGnklQ0H47JVF1IAMxo1+uGmMUMn/qEJ
 hCVJIBzghq6KDjw1xae3br2uCQhuu60yV7dkIGVi0PB9IB32zs0Jtk/uxiEdj7cspnd2plCeb6U
 ObGp3xByKQ2cO/oj47Q==
X-Proofpoint-ORIG-GUID: kXTWbeHANmRUc6yehvPZG8Buci3THdry
X-Proofpoint-GUID: kXTWbeHANmRUc6yehvPZG8Buci3THdry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190023
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

RG93bmxvYWQgdGhlIGZpcm13YXJlIGFuZCBydW4gaXQgb24gdGhlIGNvcnJlc3BvbmRpbmcgRFNQ
IG1hY2hpbmUuCgpUaGUgaW1hZ2VzIGFyZSB0aGlyZC1wYXJ0eSBiaW5hcmllcywgc28gdGhlIHRl
c3RzIHJ1biBvbmx5IHdoZW4gdW50cnVzdGVkCmNvZGUgaXMgYWxsb3dlZC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAgMiArCiAuLi4vaGV4YWdv
bi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5ICAgICAgICAgfCA4OSArKysrKysrKysrKysrKysr
KysrCiAyIGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9xY29tX2RzcF9maXJtd2FyZS5weQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCBiL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBlMTgyYmM5OGEwNi4uMGZkOTBlNDkx
YTIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZAorKysg
Yi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIsMTAgKzIsMTIgQEAK
IAogdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiAgICdhcmNoX3Rlc3RzJywKKyAg
J3Fjb21fZHNwX2Zpcm13YXJlJywKICAgJ3N5c3Rlc3RzJywKICAgJ21pbml2bScsCiBdCiAKIHRl
c3RfaGV4YWdvbl90aW1lb3V0cyA9IHsKKyAgJ3Fjb21fZHNwX2Zpcm13YXJlJzogMjQwLAogICAn
c3lzdGVzdHMnOiAxODAsCiB9CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24v
dGVzdF9xY29tX2RzcF9maXJtd2FyZS5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3Fjb21fZHNwX2Zpcm13YXJlLnB5Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAw
MDAwLi44NmEwNjI4ZDlmMwotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5CkBAIC0wLDAgKzEsODkgQEAKKyMhL3Vzci9i
aW4vZW52IHB5dGhvbjMKKyMKKyMgQm9vdCB0aGUgcHJvZHVjdGlvbiBEU1AgZmlybXdhcmUgb24g
dGhlIFF1YWxjb21tIERTUCBtYWNoaW5lcworIworIyBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRl
Y2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMKKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworZnJvbSBxZW11X3Rlc3QgaW1wb3J0
IFFlbXVTeXN0ZW1UZXN0LCBBc3NldCwgc2tpcFVudHJ1c3RlZFRlc3QKK2Zyb20gcWVtdV90ZXN0
IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4KKworCitjbGFzcyBRY29tRHNwRmlybXdh
cmVUZXN0KFFlbXVTeXN0ZW1UZXN0KToKKyAgICAiIiJCYXNlIGNsYXNzOiB0aGUgZmlybXdhcmUg
aXMgdGhlIEVMRiB0aGF0IC1rZXJuZWwgc3RhcnRzIHJ1bm5pbmcuIiIiCisKKyAgICBSRVBPID0g
J2h0dHBzOi8vZ2l0bGFiLmNvbS9rZXJuZWwtZmlybXdhcmUvbGludXgtZmlybXdhcmUvLS9yYXcv
JyBcCisgICAgICAgICAgICdkOTQ3ZTRlOGUzMTRlOTI1NGExMjQyZGMxYTVkOWNlZGUyY2NlMzNk
L3Fjb20nCisgICAgTUFDSElORSA9IE5vbmUKKyAgICBBU1NFVCA9IE5vbmUKKyAgICBNSUxFU1RP
TkUgPSAnRW50ZXJpbmcgbWFpbigpIC4uLicKKworICAgIGRlZiBib290X2Zpcm13YXJlKHNlbGYp
OgorICAgICAgICBzZWxmLnNldF9tYWNoaW5lKHNlbGYuTUFDSElORSkKKyAgICAgICAgZmlybXdh
cmUgPSBzZWxmLkFTU0VULmZldGNoKCkKKworICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xlKHNl
bWlob3N0aW5nPVRydWUpCisgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1rZXJuZWwnLCBmaXJt
d2FyZSkKKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQorICAgICAgICB3YWl0X2Zvcl9jb25zb2xl
X3BhdHRlcm4oc2VsZiwgJ1FVUlQga2VybmVsIHN0YXJ0ZWQnLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZmFpbHVyZV9tZXNzYWdlPSdGYXRhbCBFcnJvcicpCisgICAgICAgIHdh
aXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCBzZWxmLk1JTEVTVE9ORSwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZhaWx1cmVfbWVzc2FnZT0nRmF0YWwgRXJyb3InKQorICAg
ICAgICBzZWxmLnZtLmtpbGwoKQorCisKK0Bza2lwVW50cnVzdGVkVGVzdCgpCitjbGFzcyBRY3M2
NDkwQ2RzcEZpcm13YXJlVGVzdChRY29tRHNwRmlybXdhcmVUZXN0KToKKyAgICBNQUNISU5FID0g
J3FjczY0OTAtY2RzcCcKKworICAgIEFTU0VUID0gQXNzZXQoZid7UWNvbURzcEZpcm13YXJlVGVz
dC5SRVBPfS9xY202NDkwL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc0M2U5Yzg5ZTE1
ZWU4MmRhZjgzMjE0Y2FlMzQwMDZhODUxNWZkZGY5ZGI3ZjY0NWY1ZWZmNGI4ZTNjNGViYjY0JykK
KworICAgIGRlZiB0ZXN0X3FjczY0OTBfY2RzcF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2Vs
Zi5ib290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU2E4Nzc1
cENkc3BGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6CisgICAgTUFDSElORSA9ICdz
YTg3NzVwLWNkc3AnCisgICAgQVNTRVQgPSBBc3NldChmJ3tRY29tRHNwRmlybXdhcmVUZXN0LlJF
UE99L3NhODc3NXAvY2RzcDAubWJuJywKKyAgICAgICAgICAgICAgICAgICcxZDlkOGNkMWU5MTNi
MGQzYjQ5YTc3YjRlOTYyNTY0YWI0ODExOTNlNmE1Njk3YzhmMDY0MDZiM2ZkODVhOGZjJykKKwor
ICAgIGRlZiB0ZXN0X3NhODc3NXBfY2RzcF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5i
b290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU2M4NDgweHBO
c3AwRmlybXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUgPSAnc2M4
NDgweHAtbnNwMCcKKyAgICBBU1NFVCA9IEFzc2V0KGYne1Fjb21Ec3BGaXJtd2FyZVRlc3QuUkVQ
T30vZ2x5bXVyL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc3YjIyZjMzYWUyNzNkM2Rm
YzVmNzQxYTk2NzgzMWU3ZDRmZDc5YWQxNDFlNmExZWNlZTE3NTA5ZWFjMjA3MTA5JykKKworICAg
IGRlZiB0ZXN0X3NjODQ4MHhwX25zcDBfZmlybXdhcmUoc2VsZik6CisgICAgICAgIHNlbGYuYm9v
dF9maXJtd2FyZSgpCisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2NsYXNzIFNhODc5N3BOc3Aw
RmlybXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUgPSAnc2E4Nzk3
cC1uc3AwJworICAgIEFTU0VUID0gQXNzZXQoZid7UWNvbURzcEZpcm13YXJlVGVzdC5SRVBPfS9u
b3JkL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc0MTBlN2NhM2IzNDBlODA4MzVlNDY0
NTQ1YTIxOGQ5Mzc2MzEwYTA5ZjI0YmM4N2RlNDBiYzI1ZjdmNWUzMjQwJykKKworICAgIGRlZiB0
ZXN0X3NhODc5N3BfbnNwMF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5ib290X2Zpcm13
YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU204OTc1TnNwRmlybXdhcmVU
ZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUgPSAnc204OTc1LW5zcCcKKyAg
ICBNSUxFU1RPTkUgPSAnUVVSVCByb290IHRhc2sgc3RhcnRlZCcKKyAgICBBU1NFVCA9IEFzc2V0
KGYne1Fjb21Ec3BGaXJtd2FyZVRlc3QuUkVQT30vaGF3aS9jZHNwLm1ibicsCisgICAgICAgICAg
ICAgICAgICAnNzM3Mzk1MjQxM2MxNDFmYzYzNmFhOTMzYWIwYzcxZTdiZTFkMTBmNWY3ZGQzNmJl
NTM3NDgyN2IyNTNjM2RiNScpCisKKyAgICBkZWYgdGVzdF9zbTg5NzVfbnNwX2Zpcm13YXJlKHNl
bGYpOgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK2lmIF9fbmFtZV9fID09ICdf
X21haW5fXyc6CisgICAgUWVtdVN5c3RlbVRlc3QubWFpbigpCi0tIAoyLjM0LjEKCg==

