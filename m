Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B9510F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xV7-00020Y-JP; Wed, 01 Apr 2026 11:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV5-0001wa-TP
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV3-0008G0-Lg
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FPff61562478
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=+8FXFOgKRG1YjDB+/tWexSDPMPT1dezV348Niq5kkv4=; b=Li
 PXvQ9RZ7KutQtsZeOc+3gWDaKFnVXXfsbTT6+IbuLA8JJam2pIxrDIqrex7tqbCh
 niOqocrKjx58vn7Zmu5V4ix3NhIvBXYlXFAFmpVfr9N8eVYnNOC6dSlyMPn26tId
 7NCpp4OAnxn89D4lXibts5cALkcyM/iw4FaBDo6ynwyCtp2lxSPNqXjTgbrMH1TC
 6DAYk3MXcQPStmeNWhfNpB6v5ZgaWdluiXPgXUPnFvb1Ivf0ls9yz4v+ccdzzTEg
 RirhdJPTmvfGrrYAqWgncIkezz4bIKRyCM++CMSvo8nv0q5Nq9IuKu7wGyhTMKk2
 JibCL25KC0Ca/5EI/fEg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3tqdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdc1b30ac8so13208180eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057284; x=1775662084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8FXFOgKRG1YjDB+/tWexSDPMPT1dezV348Niq5kkv4=;
 b=BTtKT9s7TZ0AmPBnWtBP8cLfs3ehrovHfKn+RZyeNn6cHGBkva9WZ14dZZi4KXyszD
 icPNbJyW87eSLdYjGccMJUfG+dLh4+51t7nba7xL8qqPl7uUyN6PG7cB8bfbso44BpSd
 qtsEEn8E/4Y1V/4GUbWzwxY9vhk+PLuhr4RB6eMJ57Ia2wyiG218MqKGUUcf8ITILTrV
 DC6FMIkBj36dLuCAmw7gREoJVHiSLdThrxYfeuLocvMraVj5fNaOiyOYYtiKoegz+Kcm
 VPbLhkixi32jHFf/twqoez9FVGR30/F3++ZQLLD42SEfR1h5aiVZ1Bi8jETGYIRTz3gr
 +6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057284; x=1775662084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8FXFOgKRG1YjDB+/tWexSDPMPT1dezV348Niq5kkv4=;
 b=Pn0PwkEKuJzLk+ZfwozS7uiLIQA+9G4dhDGd1uUeu9ZQxpQXBfI+ma0pIUSXBmWkAX
 bFfMho6AxaddyUlT9bjq2k0vr3Aq0XqbsHcjgaAphuh5/vNXRapwdUBAl3/UWpM/A/qp
 sfH3A27cvFphAFDlnZjh2S/hMzS6iXBedJuYdmxgbzXoCFB7m85WZMyfUhiiulRXdFmW
 iIUj3JtUy7HUAkpWzIz/2zb+v15BgsOUpwqYXtjLrg4AWz9TiIcd4kJ0fBRGWZgLcOxs
 AHUNF8H6AF9WvBHNjKjAy2RZt4J36fNaw/i1g8HNFymyeIto55Nwj+PH3bSU2yVK3VgR
 htlQ==
X-Gm-Message-State: AOJu0YwhjtXO1OepYiPyPR2Vpf41sBeeLU2Qk2DlEHyd372atZ1cAMZK
 jueCBbpvKH8EdbzsFuaUVPGEMd2l4vLcvNt4w03bzsek72Cu7tAJkyyPb7nQ79W8Et1o5YhgIOL
 j8athWBB4Aajsge3/9/+aW74IKnIRMyTAnl/YKlPaNmMPo/cNFFrUAEwiCiy/VVixvQ==
X-Gm-Gg: ATEYQzwgffaa2+8bsyzUxBup+7pCXp8xtZDHT+ot6h9okCylQ5AghzuAaF5jD746ezb
 ixATES1wxdRgmzEndYXry9atjboTdkQlaxMyyUM4CjTK9GnpIuDwEWCyEXEQHhA6Gje2h/1SBvi
 iZRQZlmCy8WBTOQHmi0ek7xkcP10DHbRDvkpa6BMVpJut/LSRgEN+OZ7gg/9AyLNGSPRY3Vbrgv
 Gu32cckQwQZWIABPRGwLAHMJNtaTeI9YO6yFNNjOreUkEv//ht8M09XiwvpwV9ykz7HhZDmCfvb
 oFg23VPexsU/o0VKlSKUkwKuUtZMDfPyl2oXGVk3zyVIoDF04Tlgr5KzmL3QZyPu/n8zzvsZUrq
 lKijZy2Zr8TMh03/b7Iw+BekMOpk7ZpJ/MI0RJ71hICr1LLOqLFIHiE/cFf6DnGjVDrYMlw==
X-Received: by 2002:a05:7300:2391:b0:2c3:9981:e8ee with SMTP id
 5a478bee46e88-2c930e75639mr2295871eec.12.1775057283711; 
 Wed, 01 Apr 2026 08:28:03 -0700 (PDT)
X-Received: by 2002:a05:7300:2391:b0:2c3:9981:e8ee with SMTP id
 5a478bee46e88-2c930e75639mr2295848eec.12.1775057283107; 
 Wed, 01 Apr 2026 08:28:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:28:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 19/37] target/hexagon: Add vmstate representation
Date: Wed,  1 Apr 2026 08:26:39 -0700
Message-Id: <20260401152657.314902-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: jIsAEjkzBa9C5DjRT1HkyEm3CdID3pHn
X-Proofpoint-ORIG-GUID: jIsAEjkzBa9C5DjRT1HkyEm3CdID3pHn
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69cd39ab cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Oj8_dRLdxnToIsBgiwgA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX5qaUGS5OA6kG
 9yT1hu1odhDwBPxinz38v0OmvZlUksFleZ/4wNR9xaA1VJODMJi69a7AST62ovZOJ6pWhiMROEl
 LNnGgOcxIdcwCd8mZY/3No+S1tbKjDIqGrcij9sy9j+UpKdWjtxAQLmTb2GU+Fwz1B3zxwUc3GU
 w7meS/Ic8b/ALp57wurrfkvaLUKa3DG9hsmGy0qW39jyjuCfCVbA3Mxh7FxsHh3W8WMLRmTqi+v
 IOTLSEaHaNd7/La0/9pTre09AfqXvvLYl8U+QYYvOFFT2u32b0jMf6dAZytrlT0AUfi2ZZWzemV
 Isg/2kROSJh2gUv8+LgWqEnUMeP++/CbiYR52JRHL2KU1zCXwWjQxqnJG5CoxVo4xuYJdVzoEO9
 jtemX9c8B3yRuuFjxE7K8VLR3mrtCun07OICeGa148cYzVXFw8mp/gqqh1X0MnTFhTDhNCi4Rnl
 3PFydb4kAsGfD3l4Taw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
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
L2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggOGZmNTg1Nzg3M2EuLmM3OWIxOWQw
NTllIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuYwpAQCAtMzg3LDYgKzM4Nyw5IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9zdG9w
X2JlZm9yZV93YXRjaHBvaW50ID0gdHJ1ZTsKICAgICBjYy0+Z2RiX2NvcmVfeG1sX2ZpbGUgPSAi
aGV4YWdvbi1jb3JlLnhtbCI7CiAgICAgY2MtPmRpc2FzX3NldF9pbmZvID0gaGV4YWdvbl9jcHVf
ZGlzYXNfc2V0X2luZm87CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBkYy0+dm1zZCA9
ICZ2bXN0YXRlX2hleGFnb25fY3B1OworI2VuZGlmCiAgICAgY2MtPnRjZ19vcHMgPSAmaGV4YWdv
bl90Y2dfb3BzOwogfQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMgYi90
YXJnZXQvaGV4YWdvbi9tYWNoaW5lLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAuLmNlMjUzZjQyYWM3Ci0tLSAvZGV2L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFj
aGluZS5jCkBAIC0wLDAgKzEsMzIgQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRl
Y2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqCisgKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11
L29zZGVwLmgiCisjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIKKyNpbmNsdWRlICJjcHUu
aCIKKworY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9jcHUgPSB7Cisg
ICAgLm5hbWUgPSAiY3B1IiwKKyAgICAudmVyc2lvbl9pZCA9IDEsCisgICAgLm1pbmltdW1fdmVy
c2lvbl9pZCA9IDEsCisgICAgLmZpZWxkcyA9IChWTVN0YXRlRmllbGRbXSkgeworICAgICAgICBW
TVNUQVRFX1VJTlQzMl9BUlJBWShlbnYuZ3ByLCBIZXhhZ29uQ1BVLCBUT1RBTF9QRVJfVEhSRUFE
X1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShlbnYucHJlZCwgSGV4YWdvbkNQ
VSwgTlVNX1BSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzJfQVJSQVkoZW52LnRfc3JlZywg
SGV4YWdvbkNQVSwgTlVNX1NSRUdTKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzJfQVJSQVkoZW52
LmdyZWcsIEhleGFnb25DUFUsIE5VTV9HUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVu
di5uZXh0X1BDLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LnRsYl9s
b2NrX3N0YXRlLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmswX2xv
Y2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYudGxiX2xv
Y2tfY291bnQsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYuazBfbG9j
a19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi50aHJlYWRJ
ZCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyKGVudi5jYXVzZV9jb2RlLCBI
ZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LndhaXRfbmV4dF9wYywgSGV4
YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDY0KGVudi50X2N5Y2xlX2NvdW50LCBIZXhh
Z29uQ1BVKSwKKworICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkKKyAgICB9LAorfTsKLS0g
CjIuMzQuMQoK

