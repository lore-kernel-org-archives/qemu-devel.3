Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24009C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYJC-0008E8-SN; Wed, 19 Aug 2026 00:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwYJA-0008Bo-MX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:53:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwYJ8-0004jb-Sc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:53:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lMxS030189
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IrikZtqmYKRJ/VitVeFEi2+IURvKU36MikEGHCBxKKg=; b=LIWN/mBDWElNXsmg
 rIucOSMQo7CgBC/qJy6X7U0FYkRcN8Eqj8N5wVxxGraoGRREZDGJELiXgEHqllq/
 RnEazl6IK5xqAdb2MG7YR3j3H48QqwWhhvgW4h2dhePPmc21KVmVL9qKKzAXgcur
 B4rN49N3xfcW701yvDKcLOd/7wfALqU2q4gOx3/AmvaW3r5xlyZCZbnLdLbwqYO+
 i0HZ11nLaYVBfnf5GCfsqiWA8ffeXh42A17y/1I5bKo6XF3zSTQ7ljPk2ozeoR0l
 zenZlCWVJgCfjHJh461BnK6+47ccPYb7iU5SBUUQ30+3Gv2lDRvMIyGVjLbBD2FJ
 olvjDw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm1cmu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:53:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so898833b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787115225; x=1787720025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IrikZtqmYKRJ/VitVeFEi2+IURvKU36MikEGHCBxKKg=;
 b=CNWhmWb+3da4XdSwExIA2Q+GDqu6dPxFWBNs0xGWpjIUihdTYbeF4NhZUhyb/ZGXiy
 G5hG6ncmb4Fm5t0kehFEBJfft+/ejbMHCGf7v1Qd3vRd+dM318dP0RGhI/f170ggmyS4
 JWZMz5pzPXRa/WiNnXVnOKIMLGKkPZ326IrgVI2bjr7+/IEaawEO4xvCQUqRC8WFfnhJ
 XgClf4AfR5kyeIqceyJFhdXFqJ0y2r/oGrA1FQxhuck9D7UlkiZ0LsPTR7ir0J1kgz6H
 z/8jJPcxtISmujFA/5Os2Hd0Vur2slzUGQVsgwfmYZlwsWqor4MJ8bgKJ2AlSGk7z2pS
 Oacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787115225; x=1787720025;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IrikZtqmYKRJ/VitVeFEi2+IURvKU36MikEGHCBxKKg=;
 b=iem7c5bYCUASL7O5clPpSNcQAL1ENi+Boc2tZeWZcWfplKWtPnt3B1zdpFYO2xpt4E
 jbtONlte0pGYRXTelzSskpH3GxxZL5/YIn5f65N6/rviFhUGBh8CiYtvjtNJg/woG0ZS
 QGfF0TCD93bQ1Ce1v4Ayxbsfc4MzGXtNlgm0E3kb3lLPhooqfuwu4j/imXoiJFuvsdjv
 qGHaR7H1hxAtiUUUC48bZeAT17DhsAAJMHTZoyjXVIazbeR0p3l4wEJhTAfx1mNADOUu
 RYWusb7h1cZaHm5M9eV0f3IMenjBr1ZFIE6tqQJZ5/wF6lqSPAG+N8lv25jdGqLbMtl+
 37lg==
X-Gm-Message-State: AOJu0YwKDAIW1G1Jgc/XC76kG/gBRz7OUAm0Qi3jv7FMcSmdvaoG09YQ
 8TNWYgMk1GfZq3U2IvD5MP2v0b/G+i+3INqnD0R1K3/LOGdmAESpw+Ibg8bWQuKzfGlu81kZqsH
 wUeV3r/UbclGt/sf1FaJLvmwDD6lutLNxjYyV/NOoubw2u+BHKrVCL+jX5k12ZyhNpA==
X-Gm-Gg: AR+sD10eItfWqNucg96vttyJotLVWHL6r4fDtix3Pnur3k4XGNJuEMvL39EkGaBo6Oc
 zdE4/PDcde+CMBCHLmtDD8szwuaxgr4dXt1WOq2Lo3VVaaWedAfp2ai94TMdRoA8iQzZbJwi1Fd
 sj/aA+WqCR1NpTEYt85WQEX4Bis4NaH3Zl7I5uF7D8kjYHvtjGLjRPTgdTO/eRB3GXeNZFdDKGB
 Ip3ju/b9If2KRJF8Hrd4UdXu61GN8Y+1eAOXZd6R+6ebJu/0tOGusGDAWEeLdtwGUf35oZloxiP
 mIOzA2TOWIJmNfloXufcJAspi4UEIyljaQbTrqe9U1sp5WWRBSvYIQHgFaTU/UJdKwkJFJwVsyQ
 8Mt4EFlVH6o8ddsTi1NcHYDCVcjVTNasTDnoYk3QgWF3Vo1nx
X-Received: by 2002:a05:6a21:748e:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cd011f30b6mr4409106637.10.1787115224515; 
 Tue, 18 Aug 2026 21:53:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:748e:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cd011f30b6mr4409043637.10.1787115224056; 
 Tue, 18 Aug 2026 21:53:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3ce17sm3763421eec.1.2026.08.18.21.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 21:53:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/2] tests/tcg/hexagon: add icinva test
Date: Tue, 18 Aug 2026 21:53:39 -0700
Message-Id: <20260819045339.3661773-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
References: <20260819045339.3661773-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzNCBTYWx0ZWRfXxD/3gKF+XwRb
 9LcDccXgMmKKqTtuMfHGThr45UGCe4t4h5CxyxRSVhbzhi2eJm2XySeAWhssafMfV/khAjuYt4o
 zaBlPdNOefdMIBn0HXUUpXJ5+hvEGrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzNCBTYWx0ZWRfXwR+aoSf+9juB
 0vSjfuRozTOvYeZqhqSDbjdXyvrnj/lJ+E0qno1CiZCPTqi4GWjovwL1iU2TEq20dSHxxRLuMfQ
 XCUD9Q9E9eLwhIZqKZE5lQ4HOGCPP4F0L9N//hwMnjehiNM6XzUD/GnjoH6nThfiL2d3Uy8mMDf
 F6ljnDaUPIxlP1xbLIO5IYz5gN2NaoEARuYyHVjioTruYrqJ0cl9+NKgFhDyHdUjSWcftkVXhm/
 NXR195NWlDCm4tR2nJeTY7WvmMnMV4yjyfCONbZo27dD+KWcMWfAfMfYdEMDONgso7xwISedBYQ
 diBtShOH88UJdo2lhdSRyzavwxveBWYk44WwqMVd/8xT2v1jDXHvjG7qLLIU+/iknXSFoblvB8M
 lOryY6osuvTFRTroeCvenOLltz0lpruYXjmOdtNrOPXTjTSjEAdqN4HXjIeu30eNk7wdVnKT9p7
 XXsY1E/SArgLNmIlU9A==
X-Proofpoint-ORIG-GUID: 8oGCEiBuvqPF_G7zrMimfJXvfrfzq5-G
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a8536d9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7vJHg93iHWy1kEV8rwgA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 8oGCEiBuvqPF_G7zrMimfJXvfrfzq5-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190034
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL2ljaW52YS5jICAgICAgICB8IDcxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCB8ICAy
ICsKIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9oZXhhZ29uL2ljaW52YS5jCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFn
b24vaWNpbnZhLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9pY2ludmEuYwpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAwMC4uMDI1MmUwZjg5OWQKLS0tIC9kZXYvbnVsbAorKysgYi90
ZXN0cy90Y2cvaGV4YWdvbi9pY2ludmEuYwpAQCAtMCwwICsxLDcxIEBACisvKgorICogVGVzdCB0
aGF0IGljaW52YSBlbmRzIHRoZSBjdXJyZW50IHRyYW5zbGF0aW9uIGJsb2NrLgorICoKKyAqIGlj
aW52YSBvbmx5IGludmFsaWRhdGVzIHRoZSBlbXVsYXRvcidzIGNhY2hlZCB0cmFuc2xhdGlvbiBm
b3IgYQorICogY29kZSByYW5nZTsgaXQgZG9lc24ndCByZXRyb2FjdGl2ZWx5IGZpeCB1cCBjb2Rl
IHRoYXQgaGFzIGFscmVhZHkKKyAqIGJlZW4gZGVjb2RlZCBhcyBwYXJ0IG9mIHRoZSBzdGlsbC1l
eGVjdXRpbmcgdHJhbnNsYXRpb24gYmxvY2suIElmCisgKiBpY2ludmEgZG9lc24ndCBmb3JjZSBh
IG5ldyBUQiB0byBzdGFydCByaWdodCBhZnRlciBpdCwgYSBwYWNrZXQKKyAqIHBhdGNoZWQgdmlh
IGEgc3RvcmUgaW1tZWRpYXRlbHkgYmVmb3JlIGljaW52YSAod2l0aCBubworICogY2hhbmdlLW9m
LWZsb3cgaW4gYmV0d2Vlbikgc3RpbGwgcnVucyB0aGUgc3RhbGUgZGVjb2RlIGJha2VkIGludG8K
KyAqIHRoZSBjdXJyZW50IFRCIGluc3RlYWQgb2YgdGhlIGZyZXNobHktcGF0Y2hlZCBpbnN0cnVj
dGlvbi4KKyAqCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBh
bmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50
Lmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c3lzL21tYW4uaD4KKworaW50IGVy
cjsKKworI2luY2x1ZGUgImhleF90ZXN0LmgiCisKKy8qIEVuY29kaW5nIG9mICJyMCA9ICM5OSIg
Ki8KKyNkZWZpbmUgSUNJTlZBX05FV19JTlNOIDB4NzgwMGNjNjAKKworc3RhdGljIHVpbnQzMl90
IF9fYXR0cmlidXRlX18oKG5vaW5saW5lKSkgdGVzdF9pY2ludmFfc21jKHZvaWQpCit7CisgICAg
dWludDMyX3QgcmVzdWx0OworCisgICAgLyoKKyAgICAgKiByMSA9IGFkZHJlc3Mgb2YgdGhlICJw
YXRjaF9zbG90IiBwYWNrZXQgYmVsb3cgKDE6KQorICAgICAqIE92ZXJ3cml0ZSBpdCB3aXRoIHRo
ZSAicjAgPSAjOTkiIGVuY29kaW5nLCBpbnZhbGlkYXRlIHRoZQorICAgICAqIGljYWNoZSBmb3Ig
dGhhdCBhZGRyZXNzLCB0aGVuIGZhbGwgc3RyYWlnaHQgdGhyb3VnaCBpbnRvIGl0CisgICAgICog
d2l0aCBubyBpbnRlcnZlbmluZyBqdW1wL2NhbGwuCisgICAgICovCisgICAgYXNtIHZvbGF0aWxl
KAorICAgICAgICAicjEgPSAjIzFmXG4iCisgICAgICAgICJyMiA9ICMjJVtuZXdpbnNuXVxuIgor
ICAgICAgICAibWVtdyhyMSkgPSByMlxuIgorICAgICAgICAiaWNpbnZhKHIxKVxuIgorICAgICAg
ICAiMTpcbiIKKyAgICAgICAgIiAgIHIwID0gIzExXG4iCisgICAgICAgICIlW291dF0gPSByMFxu
IgorICAgICAgICA6IFtvdXRdICI9ciIocmVzdWx0KQorICAgICAgICA6IFtuZXdpbnNuXSAiaSIo
SUNJTlZBX05FV19JTlNOKQorICAgICAgICA6ICJyMCIsICJyMSIsICJyMiIsICJtZW1vcnkiCisg
ICAgKTsKKworICAgIHJldHVybiByZXN1bHQ7Cit9CisKK2ludCBtYWluKHZvaWQpCit7CisgICAg
bG9uZyBwYWdlc2l6ZSA9IHN5c2NvbmYoX1NDX1BBR0VTSVpFKTsKKyAgICB1aW50cHRyX3QgcGFn
ZSA9ICh1aW50cHRyX3QpdGVzdF9pY2ludmFfc21jICYgfihwYWdlc2l6ZSAtIDEpOworICAgIHVp
bnQzMl90IHJlc3VsdDsKKworICAgIGlmIChtcHJvdGVjdCgodm9pZCAqKXBhZ2UsIDIgKiBwYWdl
c2l6ZSwKKyAgICAgICAgICAgICAgICAgUFJPVF9SRUFEIHwgUFJPVF9XUklURSB8IFBST1RfRVhF
QykgIT0gMCkgeworICAgICAgICBwZXJyb3IoIm1wcm90ZWN0Iik7CisgICAgICAgIHJldHVybiAx
OworICAgIH0KKworICAgIHJlc3VsdCA9IHRlc3RfaWNpbnZhX3NtYygpOworICAgIGNoZWNrMzIo
cmVzdWx0LCA5OSk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CisgICAgcmV0
dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdl
dCBiL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldAppbmRleCA2MWFkZjYzNTZlNC4u
MjcyNjhlNjZiN2EgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdl
dAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQKQEAgLTYwLDYgKzYwLDcg
QEAgSEVYX1RFU1RTICs9IGludmFsaWQtZW5jb2RpbmcKIEhFWF9URVNUUyArPSBtdWx0aXBsZS13
cml0ZXMKIEhFWF9URVNUUyArPSB1bmFsaWduZWRfcGMKIEhFWF9URVNUUyArPSB1bmFsaWduZWRf
ZGF0YQorSEVYX1RFU1RTICs9IGljaW52YQogCiBIRVhfVEVTVFMgKz0gdGVzdF9hYnMKIEhFWF9U
RVNUUyArPSB0ZXN0X2JpdGNudApAQCAtMTAzLDYgKzEwNCw3IEBAIGNpcmM6IGNpcmMuYyBoZXhf
dGVzdC5oCiBkdWFsX3N0b3JlczogZHVhbF9zdG9yZXMuYyBoZXhfdGVzdC5oCiBmcHN0dWZmOiBm
cHN0dWZmLmMgaGV4X3Rlc3QuaAogaGV4X3NpZ3NlZ3Y6IGhleF9zaWdzZWd2LmMgaGV4X3Rlc3Qu
aAoraWNpbnZhOiBpY2ludmEuYyBoZXhfdGVzdC5oCiBsb2FkX2FsaWduOiBsb2FkX2FsaWduLmMg
aGV4X3Rlc3QuaAogbG9hZF91bnBhY2s6IGxvYWRfdW5wYWNrLmMgaGV4X3Rlc3QuaAogbWVtX25v
c2h1Zl9leGNlcHRpb246IG1lbV9ub3NodWZfZXhjZXB0aW9uLmMgaGV4X3Rlc3QuaAotLSAKMi4z
NC4xCgo=

