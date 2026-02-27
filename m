Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95240FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zw-0006p4-3H; Fri, 27 Feb 2026 15:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zv-0006oX-45
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zt-0006pG-6M
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:50 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0H4r131540
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aYnAQp5+e16XfFimqdWu5tDNoQnvxHUBT30sT8aTEfE=; b=fkMYxOjyPD7KigYz
 hxqE2mRLkECts3JVtO9YOoGVm6s9p9e+jZ1R49G4cWbHmlhFES0jntBtCLUNT+LP
 HZRBrYMbxyC6fMS7UWt0H9+F4oLACav6IOl/CSkarvVVSysL6GrTRrMn9yNYQCDm
 EiI9CB8olP7yeEYEfM82iEVM9v7ZU5kw1xtulNqnetPFtd8uFZXhPpTsBileeqFs
 Q4YLb7cjZQQDpYDQc8OFe4iKhG37i4MyR2FhFc+FtiC7blyxImQ3F4khjvSTLpzx
 kLbwNxxdBiiQssHa0zaM1iBligxcf/kzenqO7hxPYr/PG5VJzeSDWXO4yo2O94Np
 fsnjug==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck43rb2nq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:47 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-463c4133ccaso35007139b6e.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224607; x=1772829407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYnAQp5+e16XfFimqdWu5tDNoQnvxHUBT30sT8aTEfE=;
 b=kFqH3OX9c9iTBRpehuC/iAu2Aszv0dyBZc4gQsD6iKapXLuHwHPaes4lP0frH4Sp/b
 NcwdBU8uHd5vAOe57eXkPj2s1f94frBzfazj6LqJzNJ1b8Caz6dPthEJEZrEoDlMNthk
 mV835Vy0FIBZFr0XIKegTrlczhjB39XxcI2ha8PxD/sMuut2evVrKZw1CpL9001bgGnH
 VtMEMicGLcvzhxuD3vCB+5295twJ4PMCWNRTFcvqj2BYfsAigcK1qm3WJI4Z+0SfV2tt
 TNADGrLYtA37GTyBn9WNJ4pQZQIyqVDvl/chetVlVmLOrfjeDLhtEzb/70Ubkb2pAJ/K
 HClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224607; x=1772829407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aYnAQp5+e16XfFimqdWu5tDNoQnvxHUBT30sT8aTEfE=;
 b=IE00hX+tNQCOY1ZOFORknfbRIHkuEYLyHW6GQ6J9C3U1Hc+YRyFVLWPufxMP9yM/oE
 Q3b7TCAty9eLym1ANYRhMe2E6SN3qQM0exgZGRML13iQmUwvkt2ZcnkuZnIKExZC8w/p
 xewQTAXuHImA79RuVXKia5qqB3a0UVYthp3aSH0iHwINwwsbZTHZUzbDdWR5wOjXOl2l
 sqQeK9HrmaZFZJZs+bpPaEVFmZr04q8dyTndb5mvxw/IF77BGcZY2vTdQ0dBkoJOxufT
 6wd0595Ss6Z0rrEfmg33U0S6iB33iCgaaPgKrqFMWytUVkLzl1md0XXgRQa4P44iVrrm
 WfOQ==
X-Gm-Message-State: AOJu0YxKxv4pbbMaeZKGz1pbX2aDnbFPVgr2aYP4LkYArPbJtYrITOwl
 JeY9zjjtzkSK+qi59faWvvJ6bxIAJXCRM/RogF9Tk6NCrQ4GVsJHtsNam3MT1NfKd6BDew2It7q
 SxGNf6wJgpfVmkiugoaP7Ety5ghf/b4N/FBJ6x6/NMhZbyyQFPDTPoJCQXKEYjIPD4w==
X-Gm-Gg: ATEYQzwMsjfWGZk5+Es2E920H2FqyuZg2Wxg4q9YTNR2Byn8ttqiPx4+lxA9lZ05jnr
 zJf7OuK5ZE4hGGtt1GBUZsF75rralxENwHtG25fDMH1TVDFTIVxPBdOgc496cVVwRmbrAS2x9Ce
 zXaGZyNBdA2/ywJ09B7M22cCJYbnXAUV0PxtBEEuVx/coz/6Vw8TsnbPhdgo6WCad9NPMOBpMqy
 CBWcgYuLpXIjfIzzM+f9PFP18vKDcpZ3tR5Y2/IeUf9oCgw894fryil0UA/vEs88eG4GFbGZy0Y
 Ph/pDrSPFw2Xrr61lGkgW/BWySkbG5nWQE17bP/ibLrglx+qikfH1YikjF+Si/Z4VrouoQKPI8x
 S5Bd8h6Lx9YE7JaVI5EFSVfj0WFSOVxnVqYBFnNvh2Y3mFQKZq/VCONLZhTLyI83nzuj4rg==
X-Received: by 2002:a05:6808:2292:b0:463:b5dc:11ea with SMTP id
 5614622812f47-464be93c96fmr2334175b6e.5.1772224606875; 
 Fri, 27 Feb 2026 12:36:46 -0800 (PST)
X-Received: by 2002:a05:6808:2292:b0:463:b5dc:11ea with SMTP id
 5614622812f47-464be93c96fmr2334155b6e.5.1772224606436; 
 Fri, 27 Feb 2026 12:36:46 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:46 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 09/37] target/hexagon: Add privilege check, use tag_ignore()
Date: Fri, 27 Feb 2026 12:35:59 -0800
Message-Id: <20260227203627.932864-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: f_vBEV0_nl5QTezkZjGpEgTNtQkGj30W
X-Proofpoint-GUID: f_vBEV0_nl5QTezkZjGpEgTNtQkGj30W
X-Authority-Analysis: v=2.4 cv=DOqCIiNb c=1 sm=1 tr=0 ts=69a2005f cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VlJJRYDoeMviBMv8l8cA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX5D8bYgfCXNFS
 Yck4+I6jhGgf78vgnVJQo+6XLWPI3x4im33PO74tYFlFjxa6AmCQMB22KZXLcbHxOl5Kttnvdb6
 /I4LlZruu5vYRn7oYGF0Eo65qOB3l9Jd2HmOBbAldC012GxM91IonT5tQa2q2MXvnDSYnxWL1Vy
 tcbgG9lpVTbOzWuhhiD2c+VZT/6Ln+gJDUpFuznnmbeGAy7oMBbGTRqyNSGSP/gw1Vo2Hqogqoi
 2EDCNirSqnydMZlVO2D9aetGX1Ux3FicPudvAF54mLm7hnC0MHaFUNnKzgNnSa2iBKxYvoS+1MP
 oJj5nwyHPlHpn8pPZPqi76hOLtEWTLtP6F/FF2jEdlfXyPHQNiNPifRacVs8d0o9XhT6msRfbUj
 R1ZOGmRd+cxUif1YtGpAOgd6DRyUg5U54FBpapRiwcKdsk0yDcVZkRwRW5jm4CQ9yN6ScRsQ38G
 d5aSdr1Htol/Zrb+XSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgICAgICAgfCAgMSArCiBsaW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYyAgIHwg
MTYgKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgIHwgIDEg
KwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICB8ICA4ICsrKysrKysrCiB0YXJnZXQv
aGV4YWdvbi9nZW5fdGNnX2Z1bmNzLnB5IHwgMzUgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tCiA1IGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1
LmgKaW5kZXggMDQ5ODU2ZTdjYmEuLjlmZDY5Yzc0NTNmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtODUsNiArODUsNyBAQCB0
eXBlZGVmIHN0cnVjdCB7CiB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3RhdGUgewogICAgIHRhcmdl
dF91bG9uZyBncHJbVE9UQUxfUEVSX1RIUkVBRF9SRUdTXTsKICAgICB0YXJnZXRfdWxvbmcgcHJl
ZFtOVU1fUFJFR1NdOworICAgIHRhcmdldF91bG9uZyBjYXVzZV9jb2RlOwogCiAgICAgLyogRm9y
IGNvbXBhcmluZyB3aXRoIExMREIgb24gdGFyZ2V0IC0gc2VlIGFkanVzdF9zdGFja19wdHJzIGZ1
bmN0aW9uICovCiAgICAgdGFyZ2V0X3Vsb25nIGxhc3RfcGNfZHVtcGVkOwpkaWZmIC0tZ2l0IGEv
bGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2VyL2hleGFnb24vY3B1X2xv
b3AuYwppbmRleCA1NzExMDU1YWZmMi4uYjYzOTkwNjYzYWIgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVz
ZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5j
CkBAIC0yMiw2ICsyMiw3IEBACiAjaW5jbHVkZSAicWVtdS5oIgogI2luY2x1ZGUgInVzZXItaW50
ZXJuYWxzLmgiCiAjaW5jbHVkZSAidXNlci9jcHVfbG9vcC5oIgorI2luY2x1ZGUgInRhcmdldC9o
ZXhhZ29uL2ludGVybmFsLmgiCiAjaW5jbHVkZSAic2lnbmFsLWNvbW1vbi5oIgogI2luY2x1ZGUg
ImludGVybmFsLmgiCiAKQEAgLTYwLDYgKzYxLDIxIEBAIHZvaWQgY3B1X2xvb3AoQ1BVSGV4YWdv
blN0YXRlICplbnYpCiAgICAgICAgICAgICAgICAgZW52LT5ncHJbMF0gPSByZXQ7CiAgICAgICAg
ICAgICB9CiAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgY2FzZSBIRVhfRVZFTlRfUFJFQ0lT
RToKKyAgICAgICAgICAgIHN3aXRjaCAoZW52LT5jYXVzZV9jb2RlKSB7CisgICAgICAgICAgICBj
YXNlIEhFWF9DQVVTRV9QUklWX1VTRVJfTk9fR0lOU046CisgICAgICAgICAgICBjYXNlIEhFWF9D
QVVTRV9QUklWX1VTRVJfTk9fU0lOU046CisgICAgICAgICAgICBjYXNlIEhFWF9DQVVTRV9JTlZB
TElEX1BBQ0tFVDoKKyAgICAgICAgICAgIGZvcmNlX3NpZ19mYXVsdChUQVJHRVRfU0lHSUxMLCBU
QVJHRVRfSUxMX0lMTE9QQywKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworICAgICAgICAgICAgYnJlYWs7CisgICAgICAgICAgICBkZWZhdWx0OgorICAgICAgICAg
ICAgICAgIEVYQ1BfRFVNUChlbnYsICJcbnFlbXU6IHVuaGFuZGxlZCBDUFUgcHJlY2lzZSBleGNl
cHRpb24gIgorICAgICAgICAgICAgICAgICAgICAiY2F1c2UgY29kZSAweCV4IC0gYWJvcnRpbmdc
biIsCisgICAgICAgICAgICAgICAgICAgIGVudi0+Y2F1c2VfY29kZSk7CisgICAgICAgICAgICAg
ICAgZXhpdChFWElUX0ZBSUxVUkUpOworICAgICAgICAgICAgfQorICAgICAgICAgICAgYnJlYWs7
CiAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BDX05PVF9BTElHTkVEOgogICAgICAgICAgICAgZm9y
Y2Vfc2lnX2ZhdWx0KFRBUkdFVF9TSUdCVVMsIFRBUkdFVF9CVVNfQURSQUxOLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUjMxXSk7CmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDgyYzcyNjEz
OWY3Li5hMzg1NjhhMjg1NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIv
dGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMwNiw2ICszMDYsNyBAQCBzdGF0aWMgdm9pZCBoZXhh
Z29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKICAgICBzZXRf
ZmxvYXRfZGV0ZWN0X3RpbmluZXNzKGZsb2F0X3RpbmluZXNzX2JlZm9yZV9yb3VuZGluZywgJmVu
di0+ZnBfc3RhdHVzKTsKICAgICAvKiBEZWZhdWx0IE5hTiB2YWx1ZTogc2lnbiBiaXQgc2V0LCBh
bGwgZnJhYyBiaXRzIHNldCAqLwogICAgIHNldF9mbG9hdF9kZWZhdWx0X25hbl9wYXR0ZXJuKDBi
MTExMTExMTEsICZlbnYtPmZwX3N0YXR1cyk7CisgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VW
RU5UX05PTkU7CiB9CiAKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvKGNv
bnN0IENQVVN0YXRlICpjcywKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5j
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggODc3Y2IzOGFlNzcuLmY0NDA4MDYw
OGI1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNjUsNiArNjUsMTAgQEAgVENHdiBoZXhfdnN0b3JlX2Fk
ZHJbVlNUT1JFU19NQVhdOwogVENHdiBoZXhfdnN0b3JlX3NpemVbVlNUT1JFU19NQVhdOwogVENH
diBoZXhfdnN0b3JlX3BlbmRpbmdbVlNUT1JFU19NQVhdOwogCisjaWZuZGVmIENPTkZJR19VU0VS
X09OTFkKK1RDR3YgaGV4X2NhdXNlX2NvZGU7CisjZW5kaWYKKwogc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX3ByZWRuYW1lc1tdID0gewogICAicDAiLCAicDEiLCAicDIiLCAicDMi
CiB9OwpAQCAtMTE1Myw0ICsxMTU3LDggQEAgdm9pZCBoZXhhZ29uX3RyYW5zbGF0ZV9pbml0KHZv
aWQpCiAgICAgICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIHZzdG9yZV9wZW5kaW5n
W2ldKSwKICAgICAgICAgICAgIHZzdG9yZV9wZW5kaW5nX25hbWVzW2ldKTsKICAgICB9CisjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBoZXhfY2F1c2VfY29kZSA9IHRjZ19nbG9iYWxfbWVt
X25ldyh0Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGNhdXNlX2Nv
ZGUpLCAiY2F1c2VfY29kZSIpOworI2VuZGlmCiB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnX2Z1bmNzLnB5IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weQppbmRl
eCA4N2I3ZjEwZDdmZC4uZDkxYmJjZjFkYzggMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dl
bl90Y2dfZnVuY3MucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weQpAQCAt
MjEsNyArMjEsNyBAQAogaW1wb3J0IHJlCiBpbXBvcnQgc3RyaW5nCiBpbXBvcnQgaGV4X2NvbW1v
bgotCitmcm9tIHRleHR3cmFwIGltcG9ydCBkZWRlbnQKIAogIyMKICMjIEdlbmVyYXRlIHRoZSBU
Q0cgY29kZSB0byBjYWxsIHRoZSBoZWxwZXIKQEAgLTQ5LDYgKzQ5LDE4IEBAIGRlZiBnZW5fdGNn
X2Z1bmMoZiwgdGFnLCByZWdzLCBpbW1zKToKIAogICAgIGYud3JpdGUoIiAgICBJbnNuICppbnNu
IEdfR05VQ19VTlVTRUQgPSBjdHgtPmluc247XG4iKQogCisgICAgaWYgIkFfUFJJViIgaW4gaGV4
X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106CisgICAgICAgIGYud3JpdGUoZGVkZW50KCIiIlwKKyNp
ZmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaGV4X2dlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwg
SEVYX0NBVVNFX1BSSVZfVVNFUl9OT19TSU5TTik7CisjZWxzZQorIiIiKSkKKyAgICBpZiAiQV9H
VUVTVCIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ106CisgICAgICAgIGYud3JpdGUoZGVk
ZW50KCIiIlwKKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaGV4X2dlbl9leGNlcHRpb25f
ZW5kX3RiKGN0eCwgSEVYX0NBVVNFX1BSSVZfVVNFUl9OT19HSU5TTik7CisjZWxzZQorIiIiKSkK
ICAgICBpZiBoZXhfY29tbW9uLm5lZWRfZWEodGFnKToKICAgICAgICAgZi53cml0ZSgiICAgIFRD
R3YgRUEgR19HTlVDX1VOVVNFRCA9IHRjZ190ZW1wX25ldygpO1xuIikKIApAQCAtMTAwLDYgKzEx
MiwxMSBAQCBkZWYgZ2VuX3RjZ19mdW5jKGYsIHRhZywgcmVncywgaW1tcyk6CiAgICAgICAgIGlm
IHJlZy5pc193cml0dGVuKCk6CiAgICAgICAgICAgICByZWcuZ2VuX3dyaXRlKGYsIHRhZykKIAor
ICAgIGlmICgKKyAgICAgICAgIkFfUFJJViIgaW4gaGV4X2NvbW1vbi5hdHRyaWJkaWN0W3RhZ10K
KyAgICAgICAgb3IgIkFfR1VFU1QiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddCisgICAg
KToKKyAgICAgICAgZi53cml0ZSgiI2VuZGlmICAgLyogQ09ORklHX1VTRVJfT05MWSAqL1xuIikK
ICAgICBmLndyaXRlKCJ9XG5cbiIpCiAKIApAQCAtMTI0LDE4ICsxNDEsMTAgQEAgZGVmIG1haW4o
KToKICAgICAgICAgICAgIGYud3JpdGUoJyNpbmNsdWRlICJpZGVmLWdlbmVyYXRlZC1lbWl0dGVy
LmguaW5jIlxuXG4nKQogCiAgICAgICAgIGZvciB0YWcgaW4gaGV4X2NvbW1vbi50YWdzOgotICAg
ICAgICAgICAgIyMgU2tpcCB0aGUgcHJpdiBpbnN0cnVjdGlvbnMKLSAgICAgICAgICAgIGlmICJB
X1BSSVYiIGluIGhleF9jb21tb24uYXR0cmliZGljdFt0YWddOgotICAgICAgICAgICAgICAgIGNv
bnRpbnVlCi0gICAgICAgICAgICAjIyBTa2lwIHRoZSBndWVzdCBpbnN0cnVjdGlvbnMKLSAgICAg
ICAgICAgIGlmICJBX0dVRVNUIiBpbiBoZXhfY29tbW9uLmF0dHJpYmRpY3RbdGFnXToKLSAgICAg
ICAgICAgICAgICBjb250aW51ZQotICAgICAgICAgICAgIyMgU2tpcCB0aGUgZGlhZyBpbnN0cnVj
dGlvbnMKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZfZGlhZyI6Ci0gICAgICAgICAgICAgICAg
Y29udGludWUKLSAgICAgICAgICAgIGlmIHRhZyA9PSAiWTZfZGlhZzAiOgotICAgICAgICAgICAg
ICAgIGNvbnRpbnVlCi0gICAgICAgICAgICBpZiB0YWcgPT0gIlk2X2RpYWcxIjoKKyAgICAgICAg
ICAgIGlmIGhleF9jb21tb24udGFnX2lnbm9yZSh0YWcpOgorICAgICAgICAgICAgICAgIGYud3Jp
dGUoZiJzdGF0aWMgdm9pZCBnZW5lcmF0ZV97dGFnfSIKKyAgICAgICAgICAgICAgICAgICAgICAg
IGYiKERpc2FzQ29udGV4dCAqY3R4KVxuIikKKyAgICAgICAgICAgICAgICBmLndyaXRlKCJ7XG59
XG5cbiIpCiAgICAgICAgICAgICAgICAgY29udGludWUKIAogICAgICAgICAgICAgZ2VuX2RlZl90
Y2dfZnVuYyhmLCB0YWcsIHRhZ3JlZ3MsIHRhZ2ltbXMpCi0tIAoyLjM0LjEKCg==

