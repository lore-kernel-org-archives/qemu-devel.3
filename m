Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FC3CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBV-0001dv-TE; Fri, 19 Jun 2026 18:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBU-0001da-J9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBS-0001Yj-VH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:36 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYeGA1907824
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=; b=W8HVDvurz8EiZTK8
 JEzO9M6J2Cz/re3BOAbQOEUI5aGfL6CY4OvlrRl2nyGf68pMIhVQR1E8G/CP3MxY
 ZjxyVGZ5beGLnZ9YCo88oROjS6KDJQInDBYztvxWaRdBES4byqdocLEtOtvUmUSR
 AK4S9tnqGht4XHA/8w5UWkJi28jqhP7PFbyrp4Q3PWwwQMEQtkCEhLYYOnxFRhWw
 5MkRDHn0Cc28Xrin9ITGHa0i3xT5jd0BpDxOMIGAHNEwsjlqDDIcYV9dQ+ZbQfmp
 wWVM735N4zaXbn8567/6EXks4qVwHUVlDT7u7bi9S829zxvfpACwQZb3k90VOFwE
 bKCsQw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewb9wgqne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:33 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1370417c0bfso1904512c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909973; x=1782514773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=M4+EDT7LyX7RWi7NxjQQ7b98zcLnz1OchCrCoxbKAb/RaICDTKlDYJTjZPa+6khFSe
 sClNQHdLCz52RfEVuMK1yPlzsBnoB9JXKTMB52hyQgZR8M/MOiwkyX7KLpdfPIkJFjOK
 JiKJ0FEG8Z1B03JHTFS2xgZCsh0bnSUEQHpfKGYiLIGX5Xek7uCRasaRb1wVlNGj9yHn
 9lSTCxwtvPcDpAeR7nYBKzxpb3lyPwhm7wZyiuv+AcTQL61E8mmu90fABl5LQOfZ3h+e
 ojXReAJTuOmewFE1EnEM3B8t17/uH3FxDDzyI/FsS3+SCya8qOeDglBW967wGE9WqXhr
 Slng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909973; x=1782514773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1535rWHbX3maN5NHx9P8KfIpPdOoals3VppoQq+RNI=;
 b=SbXmcqoZv35isLaAeqDUaL4IuJi3KFRlTFw5be8C6asNXVMunABIgYK9FsdQrvrRlY
 3vCIL/+ykMLs/xGpF5eQjPu/1APZLR3pUs+tQDQECdJMat1Qpg4kpuEEgW6N7pUhBAXH
 cgBV0JU6MxbVhde2q/EgCcbDSwd0XWUbc7TSsFnHi27c4JtRO2p2HX7wY43KSsRbV2F4
 DSf9Sa2WyMaYy79MvsTIxtzkbeejkcmLIysKYoVEWTH8Ns+sF0Zwc8fS7iXG90Xz5PDa
 zDmsZhLOUIA+L0r/EN0LNvYDKJRyhoIU5RubXqbfQ5uWMN8dh1EWfAT/8U6JKD9YL/t8
 QKFA==
X-Gm-Message-State: AOJu0YxyWebOT5JvpqedXETR1O8fw4O3JvVzoRyWSvKwSEa0e+r8WIo8
 9oSF7taEPRddch6Uvby7ZaCnbEGbJsM+qdQROhbm+vVleZ/rMP5DrddNonfuMt5ZLLkJZsKlyqy
 xWYjIgB0XRaVy5jcALJ+V/Vtu2NXL6+ptnh0+3NTFYl+9hC1ySfx4Qyo3YVgNCAcLDQ==
X-Gm-Gg: AfdE7cn/mDlsIWAObJah0LMfhYEe2GvQ8hia3IU3RklsOUuCxAnQROhiqG8ZMcOUUhV
 +L20f5fuiIuDokj6C5WSlDtChNe5v/s2EbNvlgLToXIkSCil5ndeo6wnOKuYQtQKO8SNZTIfWUy
 Ekr9cbVXrrl7bJe+EfFKc8Zu57++TzwEUgN8MLYbwV3h47qynGsHfSJwcfMftcgAqZNn4KdOp+7
 hynsTeX8AnBr512iyYCB3aVwx8N7fJ7SNwRwdVUaaNQTBsNLKFlNMOxcn8H2i9OIUe5TeC4iePy
 hmIcLOl2/+Djf/ggCyaq8HjEa17Er2OJ1z4e1MDMS3pgdVhrXlPRUAaHXppLWjQZ0lWk7shce/K
 ISu+qa+qi1g2vu0DoFjbYszC5cvSij+bGHsfuUg91z6aRCOoNk5NIHSzEhjE=
X-Received: by 2002:a05:7022:69a6:b0:12c:15ce:a71b with SMTP id
 a92af1059eb24-139a31478e5mr2843943c88.25.1781909972819; 
 Fri, 19 Jun 2026 15:59:32 -0700 (PDT)
X-Received: by 2002:a05:7022:69a6:b0:12c:15ce:a71b with SMTP id
 a92af1059eb24-139a31478e5mr2843929c88.25.1781909972343; 
 Fri, 19 Jun 2026 15:59:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:31 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/74] target/hexagon: Add guest, system reg number state
Date: Fri, 19 Jun 2026 15:58:08 -0700
Message-Id: <20260619225911.159473-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JdO34PRIDC-EzbYnJ1FuOkKOeIZ0IKB4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX81pu+lfc0e/G
 6xGlPPG/pH92sdc36xol0u/mxN727ZOLBNl6GZESA3z3WCg4tJPJy0hKTxdbQ2RTLkDETKxvHF6
 wgm+EYJUiXh2SmosEYI5p8zEv6WFQaE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX5nkowvK/0412
 XxyFh/b42goVTs1A/JKRJsTx6aXLkWMVDNWG5A5tAijoGR7B6m0immTl5N0jdftdwjulJ8L4DjB
 MmPUQYqVTlPv/uG0K9aWAd2FUYaO+iakbxWpLJBBGdmcwQmvIIVe50o3xZPQ731nVCHeVdAWOvD
 U0qCeEg3gxnWorKYXFMfV2v8RXyAx55/bKTbd8ojKetl/FFkD23c9iXvYTh0zi73T4HWBnHFlkm
 bIT0cKn86gUvINbJYiadKTEJNtfYmt7pv+2nsuVtmkMPk3BWRFCH0k8oVUMhtRSzf7YAz1RxYHd
 ijWYjbcXtZUzPcpNlpBsgvUoIHiKjFbClEQaSdNmng55Uq5gQ7NlPo0FmyCWknunpKAR8bCgekD
 NXdtxYiiTeZLMueZepNbC4fRhher9yGN/KVlUWoMnQQriRTe3UwK960eqcGyQq8mCkrY71I3rvM
 4Q/fr3PBfGwaKIjVSAw==
X-Proofpoint-GUID: JdO34PRIDC-EzbYnJ1FuOkKOeIZ0IKB4
X-Authority-Analysis: v=2.4 cv=D5R37PRj c=1 sm=1 tr=0 ts=6a35c9d5 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ikZfMmNF8Hme0_TNbpMA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190221
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oIHwgMTEgKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgIDUgKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggZTBjZjg3ZTVhNGMuLjRiZWE5
NTNhYzczIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuaApAQCAtMTAwLDYgKzEwMCwxNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVBcmNoU3Rh
dGUgewogICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydDsKIAogICAgIHVpbnQ4X3Qgc2xvdF9j
YW5jZWxsZWQ7CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8qIFNvbWUgc3lzdGVt
IHJlZ2lzdGVycyBhcmUgcGVyIHRocmVhZCBhbmQgc29tZSBhcmUgZ2xvYmFsLiAqLworICAgIHVp
bnQzMl90IHRfc3JlZ1tOVU1fU1JFR1NdOworCisgICAgdWludDMyX3QgZ3JlZ1tOVU1fR1JFR1Nd
OworICAgIHVpbnQzMl90IHdhaXRfbmV4dF9wYzsKKworICAgIC8qIFRoaXMgYWxpYXMgb2YgQ1BV
U3RhdGUuY3B1X2luZGV4IGlzIHVzZWQgYnkgaW1wb3J0ZWQgc291cmNlczogKi8KKyAgICB1aW50
MzJfdCB0aHJlYWRJZDsKKyNlbmRpZgogICAgIHRhcmdldF91bG9uZyBuZXdfdmFsdWVfdXNyOwog
CiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA1YmY2ZTg1Yjkz
OS4uZDMwZTViNjRlYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yOTksNiArMjk5LDExIEBAIHN0YXRpYyB2b2lkIGhleGFn
b25fY3B1X3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQogICAgIHNldF9m
bG9hdF9kZXRlY3RfdGluaW5lc3MoZmxvYXRfdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nLCAmZW52
LT5mcF9zdGF0dXMpOwogICAgIC8qIERlZmF1bHQgTmFOIHZhbHVlOiBzaWduIGJpdCBzZXQsIGFs
bCBmcmFjIGJpdHMgc2V0ICovCiAgICAgc2V0X2Zsb2F0X2RlZmF1bHRfbmFuX3BhdHRlcm4oMGIx
MTExMTExMSwgJmVudi0+ZnBfc3RhdHVzKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAg
IG1lbXNldChlbnYtPnRfc3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9TUkVHUyk7Cisg
ICAgbWVtc2V0KGVudi0+Z3JlZywgMCwgc2l6ZW9mKHVpbnQzMl90KSAqIE5VTV9HUkVHUyk7Cisg
ICAgZW52LT53YWl0X25leHRfcGMgPSAwOworI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0g
SEVYX0VWRU5UX05PTkU7CiB9CiAKLS0gCjIuMzQuMQoK

