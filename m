Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B9EC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x586I-000791-3h; Fri, 11 Sep 2026 16:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x586F-00077q-1v
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:43:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x586D-00075L-2e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:43:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BHWjPv3622050
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 20:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gr5mnylV7IrtPk4knK7XZ69yOphcQpXVKBd9HWCwbL4=; b=URsfd6+jG72NHxvO
 0Y9Fe2abNYU58+53rt4uW0eTzA6whZ6Q1NIiew4z0Pb0euzye87ntHxJnvRa87yu
 TS98lAh5ZzriNtmYJ5cwylkoaEFNtU8O3K2IaIo8ccYQ9tF6RsAT/F2tDPlYK43Z
 BMq4uV7u+mXIC/obJ3vEabvRCVqN04Hhw7nWpaZTB5UCzHijpLN64LyEZIDHmT1b
 NgjVw6RFerPMuU9nZGcHwPvSWhwQMuVCrPfTd5+JBIwyd7Fzq7Z7SCqYDIc0eKQ+
 oc2gUn4zgZGmmXpbLD64se3H15QLElznkLY5B61AH6SH0WWM3BHuhtWNqKUuZaZe
 aj6lcg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmmubs1b7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 20:43:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so1755207a91.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789159431; x=1789764231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gr5mnylV7IrtPk4knK7XZ69yOphcQpXVKBd9HWCwbL4=;
 b=YpFHF31jFWuqbRpysPcd7cgJD4e/T4FrJ0KW1XTENE7rqzYaxATmeubv5yyp3L7xN7
 Kzm+2yUxnDuPVds4rgvW7DBevt8n5Gu7Juos7zPwgFhAG5tUkUHrM93caavYIgY2obVg
 gKou2g763FWx+miKAwuHK/jYAEMzVWwAGvy/pm14Az+Hz760QBG4PnegB3JX9Vm38abK
 QRLEBToXgFoossvvSBuWGPKZmjssrHV9wgvo3O9K3EDOfHXRBXoa4td8I01IjqvlYffY
 qg7FR53Ak5jrhupt18g0OhtSIdC64dl6ACpWQoBtz+KJ3q8QojYH2vfMzSYWgr/a5bns
 2xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789159431; x=1789764231;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gr5mnylV7IrtPk4knK7XZ69yOphcQpXVKBd9HWCwbL4=;
 b=LbMlMaf53p0N1ZBC5PzOCNNfAkcvLDJs2xIQttZvPDHy5fwMSTcldwBjU+Tb2bwFy2
 6JtgAjav3ZkpNoH83HjRt+1KvL2ZUxxZi0yyMxmgs0CD2aVgrn3IlvhDDVkmckPOYQdd
 TeIlRMONXaIjyu3rLtR9f9ACWh4/uZKYpsMJp5dwNA1DPk6gRW+b02jSdMObEtofzA6O
 AOoO9Jwbqy91z0sCMuHDu88NK5DjsK5Mm6unddJDwDYdteYNwqy2zn6cMk7V3iKMrosx
 l5j38+BO3F8uzLowFDPJjFdzC5mYB/I+hA5MEqYZrhgJYGW0JB8lDMDeRj6eXCXKuqp0
 IRQQ==
X-Gm-Message-State: AFuF++kntNBopglpcxZOs8Zt4UGAnqkLwy7im1odQyBCLkzXhuNGvhU8
 D/msy5pc8DwTwxGDSGzZ2rhJlLu8QcDa7h/c8Kl9rEb7dkcuIwKbIMQ3GdDCooHumurG4/9MMwm
 NzoKTbguYN16weh5D+U0Pz2mMuanZuPt+SEDdgBeYoYojt0SgmSUcJqUvv7fB7mcm3A==
X-Gm-Gg: AYBFou1clajLyddceHnrw/8AEcUCRd6nRoh/9OsRMSPTXFbRZfVbr33D/eWulVImbcw
 XLkB7SpAnFszR5CUjJinSiEx8+pvrJl6eidcmMMHNjSgXefNQLF0IPVK9Y3y3cTWXN1cPpdnGcx
 Tx6r9il9Oybsa9J3aVPl1a0IcVzCpuSrCsBa0XGjILa3rcdLy8p0gtAl9T04KGyZajaknDEpGYi
 cFs8C7C8YRXU1JuF2dF6MtUI6+LkA6w8LKXIYBMrbFBbD1OMWjHKRl6upBBr+t1xhD3aTV1pYrF
 ohwKm9XmhZTziurDoqvWm1afEaoSIXA83X/jOxACiJBcSD9JAfFRra+uhmlmFm5w1jR5CVuZz3u
 YA6RZC7gPlYVm+CMRpfjT5XLmGnT/mZ/pv3gupCzijRgd0gXt
X-Received: by 2002:a17:90b:1d82:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39dbbe8b88bmr4906a91.3.1789159430820; 
 Fri, 11 Sep 2026 13:43:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1d82:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39dbbe8b88bmr4875a91.3.1789159430374; 
 Fri, 11 Sep 2026 13:43:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fa50efsm9735743eec.28.2026.09.11.13.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:43:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH v2 4/6] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Fri, 11 Sep 2026 13:43:32 -0700
Message-Id: <20260911204334.1264922-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
References: <20260911204334.1264922-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5y0mT3dGA1Zs5YTZ_aVA_CCJx6KUugiL
X-Proofpoint-ORIG-GUID: 5y0mT3dGA1Zs5YTZ_aVA_CCJx6KUugiL
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6aa46807 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI5MiBTYWx0ZWRfX97fJCc1KPpqJ
 Ts0LCfjUVQThMPxT2mpZeuhoql/IwWVMj8Ge4iS23FqK5c49GpL39+E0TziiZZ9t2/i1k10/BA0
 KStdwk6pC2vFLOjVWdR9YDUhHBd/yWcS+FGfX8lv/H8BdiRxtnaCiLzB0FUnNsodYaNR4ww/vb9
 Yzdyu4o6ZKE/OS78RNolrJkP2RAbmJx7i137XyJONs292uxUipa3l7PCm85wmTinJ4JZweRCIVR
 Xj9wBDiwa/CiVPwjw6PY1ez54hnni6db9Sz3Bn1nMTPlmhBI7K7NTLaCjWgQmgELBTn9opzp0DR
 aLN2ZV/EkaVtn2cM57AvUjp2olPDmOSDSo/3ExGnOKg8iYN0c8UTppEXBqtbKhTR2MIkW+uu92e
 P/3r0bWpezUVFCD/AVgHCMu0Me7Lsh5NglBTMDU0pSef94va2Zpf0/3oTZpp2zGC6t78T1ryHKo
 a1Q+RI6Gp/o/vObnOgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI5MiBTYWx0ZWRfX6VkgwqWp7D27
 ZK4gW+mpko9z4vTuTxqr/dWCPz+jtS3CTsff6EHdRQi/tBPChx0W3OC3YffRRIT1pMIeK+fhnxD
 j1g6VW0a2KLj3JGdQbzqlFqP0/ONNhI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110292
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

U1NSOlhFIGdhdGVzIGFjY2VzcyB0byB0aGUgSFZYIGNvcHJvY2Vzc29yOiBleGVjdXRpbmcgYW4g
SFZYIGluc3RydWN0aW9uCndoaWxlIGl0IGlzIGNsZWFyIG11c3QgcmFpc2UgYSBwcmVjaXNlIGV4
Y2VwdGlvbiB3aXRoIGNhdXNlIDB4MTYsCk5PX0NPUFJPQ19FTkFCTEUuCgpDYXJyeSBTU1I6WEUg
aW4gYSBUQiBmbGFnIGFuZCBlbWl0IHRoZSBleGNlcHRpb24gZm9yIHRoZQpmaXJzdCBIVlggcGFj
a2V0IG9mIGEgVEIgd2hlbiB0aGUgY29wcm9jZXNzb3IgaXMgZGlzYWJsZWQuCgpSZXZpZXdlZC1i
eTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5oICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgg
fCAgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgfCAgMiArKwogdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMgfCAxMSArKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4
YWdvbi9jcHUuaAppbmRleCA4YTRhODFkYzI2Yy4uMzJjZGNmZTg1MjkgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMDcsNiAr
MjA3LDcgQEAgc3RydWN0IEFyY2hDUFUgewogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1As
IDAsIDEpCiBGSUVMRChUQl9GTEFHUywgTU1VX0lOREVYLCAxLCAzKQogRklFTEQoVEJfRkxBR1Ms
IFBDWUNMRV9FTkFCTEVELCA0LCAxKQorRklFTEQoVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxF
RCwgNSwgMSkKIAogR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihD
UFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBkODYyODM4M2Yx
ZC4uYjg3YTJiMjBlMmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04OSw2ICs4OSw4IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOworICAgIGJvb2wgaHZ4X2NvcHJv
Y19lbmFibGVkOworICAgIGJvb2wgaHZ4X2NoZWNrX2VtaXR0ZWQ7CiAgICAgdWludDMyX3QgbnVt
X2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDRhN2I3NmUzYmNjLi4xMTA5YThkOTE0
YyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTMzMSw2ICszMzEsOCBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dl
dF90Yl9jcHVfc3RhdGUoQ1BVU3RhdGUgKmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIo
aGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1X21tdV9pbmRleChlbnZfY3B1KGVudiksIGZhbHNlKSk7CiAgICAgaGV4X2ZsYWdzID0g
RklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwgMSk7CisgICAg
aGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VO
QUJMRUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwg
ZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOwogI2Vsc2UKICAgICBoZXhfZmxhZ3MgPSBGSUVM
RF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwgTU1VX1VTRVJfSURYKTsKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwppbmRleCA1ZDNkNjdlNWQzZS4uYjQ0Y2Y0OGQ3NTcgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCkBAIC03MTgsNiArNzE4LDE0IEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQo
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAgICBpID0gZmluZF9uZXh0X2JpdChjdHgtPnBy
ZWRpY2F0ZWRfdG1wX3ZyZWdzLCBOVU1fVlJFR1MsIGkgKyAxKTsKICAgICAgICAgfQogICAgIH0K
KworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGN0eC0+cGt0LnBrdF9oYXNfaHZ4
ICYmICFjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5odnhfY2hlY2tf
ZW1pdHRlZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NBVVNFX05PX0NP
UFJPQ19FTkFCTEUsIGN0eC0+cGt0LnBjKTsKKyAgICAgICAgY3R4LT5odnhfY2hlY2tfZW1pdHRl
ZCA9IHRydWU7CisgICAgfQorI2VuZGlmCiB9CiAKIGJvb2wgaXNfZ2F0aGVyX3N0b3JlX2luc24o
RGlzYXNDb250ZXh0ICpjdHgpCkBAIC0xMjM1LDYgKzEyNDMsOSBAQCBzdGF0aWMgdm9pZCBoZXhh
Z29uX3RyX2luaXRfZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgtPm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+
cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9F
TkFCTEVEKTsKKyAgICBjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCA9CisgICAgICAgIEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVEKTsKKyAgICBjdHgtPmh2
eF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5kaWYKIH0KIAotLSAKMi4zNC4xCgo=

