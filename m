Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE6010F6FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xUl-000151-OS; Wed, 01 Apr 2026 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUX-0000tr-IJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xUV-00086p-LQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:25 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631EWo7k3174301
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 otPPk5ra8XbrJcQ4KUod9esGuz0VYNxYDxdeHCKqdDk=; b=OHXFpFQ+xiCx5pHg
 ee0PYtEIDzVNw/Sd/RoHWEQwAft3vRAtFheIq/XuvZgghCo7VWyIuL4ReCg9erfU
 hz/Qq7Qcg/LFgMoXEf957thesA37pVFIsv0esK2XS6sa4TNK5i3sirtWTyNq8rNh
 es0mTqQy4Lhmt8phkhIdYcjSXFbGEtIoenm/ABU5WXW/YBl1E9sEIyguUhV6RsA7
 c5TBqGbVzyHYYoRY3KRLS5bCB8dawwRA4auEmQ6SzUJfrfB2Yu2Sj8bR0/v38cJy
 vr/mErNnqV+ZvabC20yRE09jBZjWlO/X5sJQcii3CDnvCs1qRgcLditeal4s1d1f
 3rrcHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d90gbhnvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so9063640eec.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057277; x=1775662077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otPPk5ra8XbrJcQ4KUod9esGuz0VYNxYDxdeHCKqdDk=;
 b=OjDBfs+sSoRqV+aM7Wb8HlMzSKM4HlnAdlskOzU7OZaGtDYaEW2zcWlWpdY2HCMHDe
 SRW7SRpekHnrO/1lUP3KYBJX/OYeG/jkL3ULoj7BpDzlzWnyh31dsc/JdCRJshc+ywSV
 2JPCA0y5oK/iHyDvHonhFKb5kI96Eiexl2DVOj7dBnMQYb4yuGo6LFbkWErdPgYTX71s
 i1p3VMrZ2j4aQ8YJlJ9Tj9rSODDJYpYZQGAXovYF37CqZOtadMQwZyU0dUKKoXjsb/xe
 WEUzaFyP+tZIHMJkjllEoNmLCLRBr+XL5s8hXViFbcsKVHxsqkF7VlIRWAok6l7ZGGf4
 HNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057277; x=1775662077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=otPPk5ra8XbrJcQ4KUod9esGuz0VYNxYDxdeHCKqdDk=;
 b=Z0VKijmm7mlD+rim4U15RDgCwZ9gOOWVNAD9dujKZoDY1xHOarIWejjlnwIoxfd1oA
 DsQnS+ndQvGgizvFsujH+RgIl4yk8DaLh6Fah1NIQc0YGSifKDrGISvIjClbOCWfIbRr
 wrpD6LQi8tsnsPZVie2uI86USEGD26bkxyz2z4X0h4m1UUke75NjfVIC4ZzMsOzxyebW
 uhWVZ47+36J9RRBtQOInFFgiPw/j+Z7v9IMGj9QzMNPxquqXafP5W9TJHVWViwVMsJJ1
 OgFrX8yrFV2125foy+d+ur7/epAyhnUOxNhUBp42ZxnWarUBDa9IunIT6yzfxSyW/akk
 SBJQ==
X-Gm-Message-State: AOJu0YzLwJdDKFF3bsMGTPE51sCHTlx/ShwE/WVoc857hxncXXdBahcW
 SP+ME5jdwcjWe9RGwMEM6y1eL+Gp8GjtmG3/OR7+/7iScEASH7DOW7ZSA6lV7thqucmInz4zWsl
 L5gl9KUubIYJQOSI+zDZI2BMwr7DHWyisK6J6ViTtwCH4QvEn+D3OBU9pty14tRswaQ==
X-Gm-Gg: ATEYQzxvUE9I4U40RfbkCBi21PwxXVbasBEwxgergaFUzvBlCbCIt7QkublL1NppdMb
 N7oGFj1tF9dQH6efxxx539xzFLeu3pqB6e+2FqNiZbCYJm5O/tHahH+73vZzifMCIeOJ0DekRgD
 hkMyx0xXZZLv2pbyhmkQN7D+zX0cj7IUPkjbjrI7d9QsJLyI9krz5zjrNypRgH4fDiDm2FQc4jb
 OERN2MgXAHLMbC8K0R/wA5PKggD/A8Q+qVgfZwDsP+dtMMDWKO7MXJTYcu1HygFi7WmyPKfmFcG
 V7xksfeeaAMY1x+ksByRsZep8KuiUkFrlqJySI6sK6x1lKVcALFbtLnDcCYEe5uk4uAbzJgOgOD
 lr56pZNwTg2QkhtuAQZVyq03+3Yi6DxJLDWIAR2XRyaFlG65wfl/r+xpgAFHyQgQJfVwjgw==
X-Received: by 2002:a05:7301:6085:b0:2c7:8e1c:9566 with SMTP id
 5a478bee46e88-2c9326aa4a0mr2065459eec.16.1775057276579; 
 Wed, 01 Apr 2026 08:27:56 -0700 (PDT)
X-Received: by 2002:a05:7301:6085:b0:2c7:8e1c:9566 with SMTP id
 5a478bee46e88-2c9326aa4a0mr2065441eec.16.1775057275928; 
 Wed, 01 Apr 2026 08:27:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 11/37] target/hexagon: Add guest, system reg number defs
Date: Wed,  1 Apr 2026 08:26:31 -0700
Message-Id: <20260401152657.314902-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX6NqiYF8KHoF+
 t/3Tzm4OM8lEhSlE6DiBvu91Ten9XwfV3I5ysfScP/SSc1BMW4PiCOROV46fQEQS4iCtSHrKsZs
 dDgrpZjK+1Me3QqiutZRkaCeni/acRr/pU2zLPQwu2J+llLMfHE2wHh/lYLgp3VYvtOtCkewVxd
 +EfaeOfBpk8DRPcVUkdPbn/F7yXTENFWVZEJvFKn8FbXGa6McDt2GPgf5j4YdPmxGF0dCgGf1AB
 gLr7x0n7+xHTsQLfGCHdzi1xU5Z+4dvGhptAvV0AfG9Tcdf0J4EXTGw6/g69ub6eSYTHUOjMnA6
 REDMz0W49GvltkiJMwM9a9+p3tDfdkwdGiIiS8rer/bti/8n1YbwKTfrEv5pzQy5EOzAV26CAeg
 E4OWpgm+IFf4vqdFfwF8/r3YLZZ5M6cVYcX9wd4ehH41OFY9tgCx3AHAZ1ThRMzgoiyQX/JsB/h
 3vVhOBkfr1aUAQkUODA==
X-Authority-Analysis: v=2.4 cv=QJJlhwLL c=1 sm=1 tr=0 ts=69cd3994 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=pUoahe-fvFp-T0RBf7EA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8qOlFcEPuOB1Xl9lHoO_uKBmbdGm3bss
X-Proofpoint-ORIG-GUID: 8qOlFcEPuOB1Xl9lHoO_uKBmbdGm3bss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuaCAgICAgIHwgICA3ICsrKwogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCB8IDExNyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmgKaW5kZXggOTM3MTk0ZTQ2MGUuLjM4MjVkZTQzZWU3IDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMjAs
NiArMjAsMTMgQEAKIAogI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQtdHlwZXMuaCIKIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE5VTV9HUkVHUyAzMgorI2RlZmluZSBHUkVHX1dS
SVRFU19NQVggMgorI2RlZmluZSBOVU1fU1JFR1MgNjQKKyNkZWZpbmUgU1JFR19XUklURVNfTUFY
IDIKKyNlbmRpZgorCiAjaW5jbHVkZSAiY3B1LXFvbS5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWNv
bW1vbi5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWRlZnMuaCIKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2hleF9yZWdzLmggYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCmluZGV4IGJkZGZj
MjgwMjFjLi4yMTRiN2I4ZmRlOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3Mu
aAorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCkBAIC04MSw0ICs4MSwxMjEgQEAgZW51
bSB7CiAgICAgSEVYX1JFR19VVElNRVJISSAgICAgICAgICA9IDYzLAogfTsKIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCisKKyNkZWZpbmUgSEVYX0dSRUdfVkFMVUVTIFwKKyAgREVDTF9IRVhf
R1JFRyhHMCwgICAgICAgICAwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0VMUiwgICAgICAgMCkgXAor
ICBERUNMX0hFWF9HUkVHKEcxLCAgICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHU1IsICAg
ICAgICAxKSBcCisgIERFQ0xfSEVYX0dSRUcoRzIsICAgICAgICAgMikgXAorICBERUNMX0hFWF9H
UkVHKEdPU1AsICAgICAgIDIpIFwKKyAgREVDTF9IRVhfR1JFRyhHMywgICAgICAgICAzKSBcCisg
IERFQ0xfSEVYX0dSRUcoR0JBRFZBLCAgICAgMykgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV8x
VCwgIDEwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzJULCAgMTEpIFwKKyAgREVDTF9IRVhf
R1JFRyhHQ1lDTEVfM1QsICAxMikgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV80VCwgIDEzKSBc
CisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzVULCAgMTQpIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lD
TEVfNlQsICAxNSkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ0LCAgIDE2KSBcCisgIERFQ0xf
SEVYX0dSRUcoR1BNVUNOVDUsICAgMTcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UNiwgICAx
OCkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ3LCAgIDE5KSBcCisgIERFQ0xfSEVYX0dSRUco
R1BDWUNMRUxPLCAgMjQpIFwKKyAgREVDTF9IRVhfR1JFRyhHUENZQ0xFSEksICAyNSkgXAorICBE
RUNMX0hFWF9HUkVHKEdQTVVDTlQwLCAgIDI2KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDEs
ICAgMjcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UMiwgICAyOCkgXAorICBERUNMX0hFWF9H
UkVHKEdQTVVDTlQzLCAgIDI5KSBcCisgIERFQ0xfSEVYX0dSRUdfRE9ORQorCisjZGVmaW5lIERF
Q0xfSEVYX0dSRUdfRE9ORQorI2RlZmluZSBERUNMX0hFWF9HUkVHKG5hbWUsIHZhbCkgSEVYX0dS
RUdfICMjbmFtZSA9IHZhbCwKK2VudW0gaGV4X2dyZWcgeworICAgIEhFWF9HUkVHX1ZBTFVFUwor
fTsKKyN1bmRlZiBERUNMX0hFWF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisKKyNk
ZWZpbmUgREVDTF9IRVhfR1JFR19ET05FIDAKKyNkZWZpbmUgREVDTF9IRVhfR1JFRyhfLCB2YWwp
ICgxIDw8IHZhbCkgfAorc3RhdGljIGlubGluZSBib29sIGdyZWdfaW1wbGVtZW50ZWQoZW51bSBo
ZXhfZ3JlZyBncmVnKQoreworI2lmIE5VTV9HUkVHUyA+IDMyCisjZXJyb3IgIk5VTV9HUkVHUyB0
b28gbGFyZ2UgZm9yIGdyZWdfaW1wbGVtZW50ZWQoKTogdXBkYXRlIGBpbXBsX2JpdG1hcGAiCisj
ZW5kaWYKKyAgICBzdGF0aWMgaW50MzJfdCBpbXBsX2JpdG1hcCA9IEhFWF9HUkVHX1ZBTFVFUzsK
KyAgICByZXR1cm4gaW1wbF9iaXRtYXAgJiAoMSA8PCBncmVnKTsKK30KKyN1bmRlZiBERUNMX0hF
WF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisKKyNlbmRpZiAvKiBDT05GSUdfVVNF
Ul9PTkxZICovCisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZW51bSB7CisgICAgSEVYX1NS
RUdfU0dQMCA9IDAsCisgICAgSEVYX1NSRUdfU0dQMSA9IDEsCisgICAgSEVYX1NSRUdfU1RJRCA9
IDIsCisgICAgSEVYX1NSRUdfRUxSID0gMywKKyAgICBIRVhfU1JFR19CQURWQTAgPSA0LAorICAg
IEhFWF9TUkVHX0JBRFZBMSA9IDUsCisgICAgSEVYX1NSRUdfU1NSID0gNiwKKyAgICBIRVhfU1JF
R19DQ1IgPSA3LAorICAgIEhFWF9TUkVHX0hUSUQgPSA4LAorICAgIEhFWF9TUkVHX0JBRFZBID0g
OSwKKyAgICBIRVhfU1JFR19JTUFTSyA9IDEwLAorICAgIEhFWF9TUkVHX0dFVkIgID0gMTEsCisg
ICAgSEVYX1NSRUdfR0xCX1NUQVJUID0gMTYsCisgICAgSEVYX1NSRUdfRVZCID0gMTYsCisgICAg
SEVYX1NSRUdfTU9ERUNUTCA9IDE3LAorICAgIEhFWF9TUkVHX1NZU0NGRyA9IDE4LAorICAgIEhF
WF9TUkVHX0lQRU5EQUQgPSAyMCwKKyAgICBIRVhfU1JFR19WSUQgPSAyMSwKKyAgICBIRVhfU1JF
R19WSUQxID0gMjIsCisgICAgSEVYX1NSRUdfQkVTVFdBSVQgPSAyMywKKyAgICBIRVhfU1JFR19J
RUwgPSAyNCwKKyAgICBIRVhfU1JFR19TQ0hFRENGRyA9IDI1LAorICAgIEhFWF9TUkVHX0lBSEwg
PSAyNiwKKyAgICBIRVhfU1JFR19DRkdCQVNFID0gMjcsCisgICAgSEVYX1NSRUdfRElBRyA9IDI4
LAorICAgIEhFWF9TUkVHX1JFViA9IDI5LAorICAgIEhFWF9TUkVHX1BDWUNMRUxPID0gMzAsCisg
ICAgSEVYX1NSRUdfUENZQ0xFSEkgPSAzMSwKKyAgICBIRVhfU1JFR19JU0RCU1QgPSAzMiwKKyAg
ICBIRVhfU1JFR19JU0RCQ0ZHMCA9IDMzLAorICAgIEhFWF9TUkVHX0lTREJDRkcxID0gMzQsCisg
ICAgSEVYX1NSRUdfTElWRUxPQ0sgPSAzNSwKKyAgICBIRVhfU1JFR19CUktQVFBDMCA9IDM2LAor
ICAgIEhFWF9TUkVHX0JSS1BUQ0ZHMCA9IDM3LAorICAgIEhFWF9TUkVHX0JSS1BUUEMxID0gMzgs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcxID0gMzksCisgICAgSEVYX1NSRUdfSVNEQk1CWElOID0g
NDAsCisgICAgSEVYX1NSRUdfSVNEQk1CWE9VVCA9IDQxLAorICAgIEhFWF9TUkVHX0lTREJFTiA9
IDQyLAorICAgIEhFWF9TUkVHX0lTREJHUFIgPSA0MywKKyAgICBIRVhfU1JFR19QTVVDTlQ0ID0g
NDQsCisgICAgSEVYX1NSRUdfUE1VQ05UNSA9IDQ1LAorICAgIEhFWF9TUkVHX1BNVUNOVDYgPSA0
NiwKKyAgICBIRVhfU1JFR19QTVVDTlQ3ID0gNDcsCisgICAgSEVYX1NSRUdfUE1VQ05UMCA9IDQ4
LAorICAgIEhFWF9TUkVHX1BNVUNOVDEgPSA0OSwKKyAgICBIRVhfU1JFR19QTVVDTlQyID0gNTAs
CisgICAgSEVYX1NSRUdfUE1VQ05UMyA9IDUxLAorICAgIEhFWF9TUkVHX1BNVUVWVENGRyA9IDUy
LAorICAgIEhFWF9TUkVHX1BNVVNUSUQwID0gNTMsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHMSA9
IDU0LAorICAgIEhFWF9TUkVHX1BNVVNUSUQxID0gNTUsCisgICAgSEVYX1NSRUdfVElNRVJMTyA9
IDU2LAorICAgIEhFWF9TUkVHX1RJTUVSSEkgPSA1NywKKyAgICBIRVhfU1JFR19QTVVDRkcgPSA1
OCwKKyAgICBIRVhfU1JFR19TNTkgPSA1OSwKKyAgICBIRVhfU1JFR19TNjAgPSA2MCwKKyAgICBI
RVhfU1JFR19TNjEgPSA2MSwKKyAgICBIRVhfU1JFR19TNjIgPSA2MiwKKyAgICBIRVhfU1JFR19T
NjMgPSA2MywKK307CisjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8KKwogI2VuZGlmCi0t
IAoyLjM0LjEKCg==

