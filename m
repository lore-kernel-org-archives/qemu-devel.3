Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B09DCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dc-0003Ge-Fi; Fri, 29 May 2026 17:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Da-00036Y-Ri
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5DY-0000pw-Tx
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TIQUjV876432
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=x5iwjzaAutgp44W8oVTJ1J
 D1N1k4plxHFgiIwGNQ5tE=; b=Tl1UDFCMyhnX9feYce1n1jPR40HlAqpzro4+sa
 yvuMUwq1AYPwSoQwNEriWDqU9NEN68anYm0Ir/6AUymdx30BD+kW4R2iwQNJ2KRJ
 J7xZnt99TRlWpJ4u79Z4fbC1FKreEVblVtgWoygv6E6rIM4CW66PNIYGlskwdn9j
 qfpji4a26cqFmbEYaX5qYVb68IqXWSxVaMlfoxsubbrW8TpEj4nJFFfZgZXmTMHX
 EmAMlmZGj3FW4CL7WasF6tahLhTigAbmJaDAA3YrmDvBKMZ5l1J28k9x3q7Wzn/6
 dWCxFHOoFTM1vxCDthL5YTorVCiz8H8ZQ6tW3Vl2N5mfTiMA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg340ube-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1370417c0bfso4152063c88.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091890; x=1780696690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x5iwjzaAutgp44W8oVTJ1JD1N1k4plxHFgiIwGNQ5tE=;
 b=i5BuPzT8ptoKfElcG9KuxLPeq+fxuHGpaV9rxNn4TPGwkkl3ccVGg8wNN8UYOnLkbE
 WcXqSYaj3f5Jdca8t518U5Z1IXPDWztaUiM4XRcduQYongwL7JFcBzfyuuWQX3hNMFhy
 i1ZvIEBScgDHslS4hbaTumkhpma0pWCm2Sx2qLgYp4bxLf7u8RWZufXZAgIoLU5BPOjF
 qEjB5o+DD0GBuasEoNZPgau2tTJzGM0wRVNeYMicH3HSuawhSHnBdgx8Ej+xTNbZaXro
 fBNOVjOoG3CgWA8sk9hmgN3MuGlyMJvbaUFu82qunSQCyOkVXq39KqoLp2R3Vg+/dpFA
 2dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091890; x=1780696690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x5iwjzaAutgp44W8oVTJ1JD1N1k4plxHFgiIwGNQ5tE=;
 b=EIreQck3RSJRCJ5/A/88C/iMqUHV0jCHUQVx1mskoodAE0l6S+ct91hweC+wDNNEu3
 S5Ot0jFGugKGPrf0hJDA+bdshISXvWz+Mx3SXfgWuzgt4Du6tssuJXrNnlkdSaAX9ECM
 O54BVGfHjqYUtPRo+HbEyVdG7+4RFDGNFM6LlFfx8e+jXqjaOMFNFzxCfHgdZXuSjszT
 9sShQ68YuaGY8Q0Fv+cPhrcu7BsR+kqC0HqdMMRcECMLyULmHCEzBWRdj3wdHuyJ5uhO
 GGgza20KzcjD1NWHdJ/9k2k4GtdXwtcjZht+RCQAOkteyhbvVUWeGsvcI624Qmb+xDcx
 12kA==
X-Gm-Message-State: AOJu0Yy27MYyxUl/nwSB9caQMAZdnhSZZaz83ZrfNOQHvaIQeFT6hyPZ
 cMAIK8dSt//d7cupKBWnEOMWkNGbJt932DG1A/RYhxjAB9Gjny3/OJbVvm+I6GvXW/7iSkx9K+w
 J4c+J98XS7Is4GeXOOjiF8Jn41cljiNe1Nm0U2mbx7H4ldyUMqKNeFi11yGK7QriBYw==
X-Gm-Gg: Acq92OHkf9ACRJcjunhtClanr994HaD7ETKpectxJRIoseWBLL77+vRcIUwD0wAbzW9
 5j0ROcsG1vYqnCFur7jM7tBR3kCet4ow054OOGxP2+iZtlLW/hzrpv2WlNm/Gp9saKA/lGLHXiy
 1OoXaYvVY1irJ/83IbZnemZSoJGCTQZ+K4QlneM+h/Bb0nmYir+fan+K1771b0zVL4KoYRntAvr
 EOowWLlelxyS48j5u2BJ0uERIf+yBkQtyEXXCs9N4sG91w/qsa0fojl3bN7pHOVOPs3RME8DpaM
 +jcy3K1miyz7W/fy/UNaGkxnHUiiA9DlBia2H+OqsGJatcxQblcbIj/BL4UDTgKz+nsph4MEep5
 rypUMljsaEum+17LRkHBO3/ig0+fYNLK12bBTF+m5nmKkZFw9PYvq01oTF0N/Dj4wNCZlwqahIb
 7pLQv8
X-Received: by 2002:a05:7022:688a:b0:134:74a6:7db1 with SMTP id
 a92af1059eb24-137aea880eemr1914921c88.20.1780091890443; 
 Fri, 29 May 2026 14:58:10 -0700 (PDT)
X-Received: by 2002:a05:7022:688a:b0:134:74a6:7db1 with SMTP id
 a92af1059eb24-137aea880eemr1914909c88.20.1780091889904; 
 Fri, 29 May 2026 14:58:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v5 00/28] Hexagon system emulation, Part 2/3
Date: Fri, 29 May 2026 14:57:38 -0700
Message-Id: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: J-btenTNh1fBeQnC7LzYHLHmqVrHXtW-
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a1a0bf3 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=-pfNDhS2WWWi7I-Wrn4A:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: J-btenTNh1fBeQnC7LzYHLHmqVrHXtW-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX6TZg7lKKPH/b
 E1bWv6OtvM/VT4ZDptiiE5sdj8HRNsqqUtzwRv+hHZEq6BvQXSwfJFBxQrfaHC9KPJG+rwRq8ke
 PY4BiAeP3tBY+AN2WNLE/I83Bj5yrCRYKt3YdYK2KTmVUo4IKdjlC7TY+MEtN3M/03D0b7cvwrG
 TiFo7o63AgW1Q/Xs0/sNz5NziQ7d+6Mb83r4LQJpbK5PNcaj2r69ySFoKhg/P9FII8pB3WiyCUA
 84BouT6rAI0QrKhClTXll1EGaYB5Mi+fEJhQe0VcVZsgzUhs3nuy/lcJHN9oO+/mzr3OvhiKtoI
 Um43cv/ia4wlq8W4TStPC59ouplrlWxUOCxnTPcs/RYXj7G7yIoq1RnplOuiDW/FcGnDcOAvzrR
 GdpvcLoWGaNPA05PlzdgQTAEcK+xfCkwx/z1CEyL5xCxaUQ/v+14tt+vi5ZqPbVCTGGfJmpKRtu
 8w02yrJZiv2gFFHrSwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

SGV4YWdvbiBzeXNlbXUgcGFydCAyOiBydW50aW1lIGhlbHBlcnMgLS0gaW50ZXJydXB0IGRlbGl2
ZXJ5LCBUTEIgZmlsbCwKdGhyZWFkIHNjaGVkdWxpbmcsIE1NVSBpbmRleCwgdHJhbnNsYXRpb24g
Y2hhbmdlcyAocGt0X2VuZHNfdGIsCnNyZWcvZ3JlZyB3cml0ZXMsIENPRiBkZWNvZGUpLCBhbmQg
cGh5c2ljYWwgbWVtb3J5IGFjY2Vzcy4KCkNoYW5nZXMgaW4gdjU6Ci0gY3R4LT5wa3QtPiBjaGFu
Z2VkIHRvIGN0eC0+cGt0LiB0aHJvdWdob3V0ICh1cHN0cmVhbSBlbWJlZGRlZCB0aGUKICBQYWNr
ZXQgc3RydWN0KS4KLSBuZWVkX2NvbW1pdCBvcHRpbWl6YXRpb24gaW4gZ2VuX3NyZWdfd3JpdGVz
KCk6IHNraXAgdF9zcmVnX25ld192YWx1ZQogIGFsbG9jYXRpb24gd2hlbiAhbmVlZF9jb21taXQg
JiYgcmVnICE9IFNTUi4KLSBSZW5hbWVkICJBZGQgVExCLCBrMCB7dW4sfWxvY2siIC0+ICJBZGQg
azAge3VuLH1sb2NrIiAoVExCIHNldHVwCiAgaXMgaW4gUGFydCAxIG5vdykuCi0gZ2V0X3BoeXNf
cGFnZV9kZWJ1ZyAtPiBnZXRfcGh5c19hZGRyX2RlYnVnICh1cHN0cmVhbSByZW5hbWUpLgotIEZv
cm1hdCBzdHJpbmcgZml4ZXMgKCVkLyV4IC0+IFBSSWQzMi9QUkl4MzIsIHVpbnQzMl90IGNhc3Rz
KS4KLSBEcm9wcGVkIFF1YWxjb21tIG1hbnVhbCBjaXRhdGlvbnMgZnJvbSBjb21taXQgbWVzc2Fn
ZXMuCi0gUmViYXNlZCBvbnRvIGN1cnJlbnQgc3RhZ2luZyAoY3B1LWludGVycnVwdC5oLCBjcHUu
YyBjbGFzcyBpbml0CiAgY29udGV4dCBjaGFuZ2VzKS4KClBhdGNoZXMgc3RpbGwgbmVlZGluZyBy
ZXZpZXc6Ci0gMDMvMjg6IHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc3RhcnQvc3RvcCBoZWxw
ZXJzLCBzb2Z0IHJlc2V0Ci0gMDgvMjg6IHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc29mdHdh
cmUgaW50ZXJydXB0Ci0gMTUvMjg6IHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc2V0cHJpbywg
cmVzY2hlZAotIDIxLzI4OiB0YXJnZXQvaGV4YWdvbjogQWRkIG5leHRfUEMsIHtzLGd9cmVnIHdy
aXRlcwoKQnJpYW4gQ2FpbiAoMjYpOgogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQge2MsfXN3
aSBoZWxwZXJzCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBpYXNzaWdue3Isd30gaGVscGVy
cwogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc3RhcnQvc3RvcCBoZWxwZXJzLCBzb2Z0IHJl
c2V0CiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCB7ZyxzfWV0aW1hc2sgaGVscGVycwogIHRh
cmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgd2FpdCBoZWxwZXIKICB0YXJnZXQvaGV4YWdvbjogSW1w
bGVtZW50IGdldF9leGVfbW9kZSgpCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBoZXhfdGxi
X2VudHJ5X2dldF9wZXJtKCkKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHNvZnR3YXJlIGlu
dGVycnVwdAogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc3RhY2sgb3ZlcmZsb3cgZXhjZXB0
aW9uCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBleGVjX2ludGVycnVwdCwgc2V0X2lycQog
IHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgaGV4YWdvbl90bGJfZmlsbCgpCiAgdGFyZ2V0L2hl
eGFnb246IEltcGxlbWVudCBzaWFkIGluc3QKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGhl
eGFnb25fcmVzdW1lX3RocmVhZHMoKQogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc2V0cHJp
bywgcmVzY2hlZAogIHRhcmdldC9oZXhhZ29uOiBBZGQgc3lzZW11X29wcywgY3B1X2dldF9waHlz
X3BhZ2VfZGVidWcoKQogIHRhcmdldC9oZXhhZ29uOiBleHRlbmQgaGV4YWdvbl9jcHVfbW11X2lu
ZGV4KCkgZm9yIHN5c2VtdQogIHRhcmdldC9oZXhhZ29uOiBEZWNvZGUgdHJhcDEsIHJ0ZSBhcyBD
T0YKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IG1vZGlmeV9zc3IsIHJlc2NoZWQsIHBlbmRp
bmdfaW50ZXJydXB0CiAgdGFyZ2V0L2hleGFnb246IEFkZCBwa3RfZW5kc190YiB0byB0cmFuc2xh
dGlvbgogIHRhcmdldC9oZXhhZ29uOiBBZGQgbmV4dF9QQywge3MsZ31yZWcgd3JpdGVzCiAgdGFy
Z2V0L2hleGFnb246IEFkZCBpbXBsaWNpdCBzeXNyZWcgd3JpdGVzCiAgdGFyZ2V0L2hleGFnb246
IERlZmluZSBzeXN0ZW0sIGd1ZXN0IHJlZyBuYW1lcwogIHRhcmdldC9oZXhhZ29uOiBBZGQgazAg
e3VuLH1sb2NrCiAgdGFyZ2V0L2hleGFnb246IEFkZCBQQyB0byByYWlzZV9leGNlcHRpb24sIHVz
ZSBmVFJBUCgpIGhlbHBlcgogIHRhcmdldC9oZXhhZ29uOiBBZGQgVENHIG92ZXJyaWRlcyBmb3Ig
dHJhbnNmZXIgaW5zdHMKICB0YXJnZXQvaGV4YWdvbjogQWRkIHN1cHBvcnQgZm9yIGxvYWR3X3Bo
eXMKCk1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vICgyKToKICB0YXJnZXQvaGV4YWdvbjogYWRk
IHNpbXBsZSBjcHVfZXhlY19yZXNldCBhbmQgcG9pbnRlcl93cmFwCiAgdGFyZ2V0L2hleGFnb246
IEFkZCBndWVzdCByZWcgcmVhZGluZyBmdW5jdGlvbmFsaXR5CgogdGFyZ2V0L2hleGFnb24vY3B1
LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmggICAgICAgICAgICAgICAgIHwgICA4ICsKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAg
ICAgICAgICAgICAgICAgICAgfCAgIDcgLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCAg
ICAgICAgICAgICAgICB8ICAyNyArLQogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICAgICAg
ICAgICAgICAgICB8ICAgNiArLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmggICAgICAgICAgICAg
ICAgICAgICB8ICAxNyArCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVy
cy5oIHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2ludGVybmFsLmggICAgICAgICAgICAgICAgICAg
fCAgIDQgKwogdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggICAgICAgICAgICAgICAgICAgICB8ICAg
MyAtCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggICAgICAgICAgICAgICAgIHwgICA3ICsK
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAgICAgICAgfCAgIDUgKy0KIHRh
cmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jICAgICAgICAgfCAgMTEgKwogbGludXgt
dXNlci9oZXhhZ29uL2NwdV9sb29wLmMgICAgICAgICAgICAgICB8ICAgNyArCiB0YXJnZXQvaGV4
YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMzYwICsrKysrKysrKysrKysrLQog
dGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgICAgICB8ICAxNCArCiB0YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICAgIHwgIDE4ICstCiB0YXJnZXQv
aGV4YWdvbi9oZXhfbW11LmMgICAgICAgICAgICAgICAgICAgIHwgICA0ICstCiB0YXJnZXQvaGV4
YWdvbi9oZXhzd2kuYyAgICAgICAgICAgICAgICAgICAgIHwgMjcwICsrKysrKysrKysrKwogdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyB8ICAgOSArCiB0YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICAgIHwgNDYyICsrKysrKysrKysrKysr
KysrKystCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICAgIHwgMjE2
ICsrKysrKysrLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgICAgICB8
ICAgMyArCiB0YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55ICAgIHwgICAz
ICsKIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2VuY29kZV9wcC5kZWYgICAgICAgfCAgIDEgKwog
dGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICAgICAgICB8ICAgMyArCiAyNSBm
aWxlcyBjaGFuZ2VkLCAxNDIyIGluc2VydGlvbnMoKyksIDU2IGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hleHN3aS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKCi0tIAoyLjM0LjEKCg==

