Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A09606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pNWCmJR1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jtf7Lrpg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW17-0003YD-Rf; Mon, 09 Nov 2026 15:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0a-0003NZ-Ac
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQW0W-0007Hu-Uf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:30:28 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHKM6562014
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wgs+JhNvl2XPwVbr0SO1ERlwL6AzljtaNttv0oIjdSA=; b=pNWCmJR1g6kapETP
 wD5umIxOF7aicXYXAubg2kytz7pxqQkCvsP7to7iN3Bbx/PRCXsgCcOCho+5UMXe
 gd5JfzlerkgEOdfS4z83RF428zLw9tof34AfZiE9kupjX7annDqqgtKpc7kVWFz+
 i14gUA5S4P/zx7BqVEs1jirF29N6FomekEIHe+I4RNY3lnulfW5SV9XSJIemCluJ
 ddjbYD+hfx+TpLcD24mHWHeCMnMdse0y+EwGA6eEs9Z1VICn4pYrrS2KqjdRI2mJ
 IwSCw8XtPz8DeTQOsabRSesdexrZ1JjJs0ATrXEHevZ6dgY7nOZ8dlOBxI1JQaNc
 tcg81Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydj2yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:30:23 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so1896873c88.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256222; x=1794861022; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wgs+JhNvl2XPwVbr0SO1ERlwL6AzljtaNttv0oIjdSA=;
 b=jtf7LrpgUwGP1Y30x4l9z8ioGYP3JA+9fJcA+RLSdUXq/rQ69mltkS74uko9oNMzn4
 MP+DiJzNOMZhMGMfa0N5ghMskeerE3l8T9xxRYJIXQqqCeb+476Egq87m46eIGS31ipf
 XZsL3Ss/RKeu24p7hdTJd+2ThTlF5JZosItqNB9tyHrt2FzJnKbNNOtTpMhBPcXDD3QO
 Ffe03ySYiUdXJbMhSPWxQq/1JYM2lBybrfmXcp2QGEYu4kqjV2UffF3rVdbMEEbWK0ZU
 FjGRHyPEjJ7hnznNoRs6mU/Kcy6aGE2K7/7oREC2sOu9hvfikp02OeIFPT2UVW/l5oVc
 LwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256222; x=1794861022;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wgs+JhNvl2XPwVbr0SO1ERlwL6AzljtaNttv0oIjdSA=;
 b=iEn9SHPLmhSeSo5k+gmA36vbJhQf0tcBvb+4cGTqxunvTSTpJk81NfTE+JOSzKn2vF
 elaDdVJHbcoi9kxgPigagIPGBv7efrabcze3ItE2q6qM0o9K31fHivnvK7GAZwkmesvi
 ulCOBtWcCANQCxIyGaRPYkRJot9/dXtddtXmGPO0bKBfkhiVgARzeBcuy0radpqVOn+J
 Icu13rkA51FBjANJZ1PTNn+9mu72+3sTnknIaSoC7RAxr9Zm79UyEJ3PCxMUKAGZt59T
 nfqHMlUQoU7eKJ/Kv5HRAP8Nd2X9u9CBKzBuNwGk0GrEzA+aSHwHdDtxHqaMVCRNJLpL
 DDhw==
X-Gm-Message-State: APuU4Z8b/OmU/cc2dHhNWWVnRIzn6nCPIlrHuPbTVqO3XWUUN3OeWfpm
 IAXNz6X3fTHsbz6gvIPY39lOJ6lZL0rZyLX6mYVmJ1RMraSXE2DCbWBQtFk3o5tMQ9tUmToi6uS
 KbLK9mVfiKfda8JOVYfmpofKzoG7T5SeCyFmdZgFsaU/IDyDB58VB84ceJzA8vDpneg==
X-Gm-Gg: AYBFou1Atft3+nhC45WlhIw7ELgqHteiKcbwBh44fXzrX1vaLdlCBqBGiXIjlqxkPJG
 av8YidIkSnyHjareT1m1smo89uAS+s2UesJC/ZKZcLHk94P39XZhWULALpMc0siK4iIwbmDehBE
 AblN12WUBcHgIGHpw2K0LK66rTpcPoyYsNkYeot4wcgTNM9yu4YEQesROs2mtMH5qPQp1uafY7O
 aD4tCRXgBtRvmn2gE61VFgmnGWWM6ND4IuhltVg614qHNpr7bmsqnpPTwlEM1kcnwFgK/CoLncv
 z4ksSO5I5pYebX1MFBmVUAUSRCpPuaB2ogGAvIPdV4c4FhTulaNwlF8e35htJkHlzEpgnMXbJPs
 xISQHq+frHOflgngFrYBSt71a5zwr4Oc6HH+oFhzGvP5yMHlWhh100ghGzv0Hlwpa+SWll8X8kz
 61Nm/haW2FTIVhmv5SBF8X
X-Received: by 2002:a05:7022:23aa:b0:1ab:6b10:461 with SMTP id
 a92af1059eb24-1b3b604a557mr749074c88.45.1794256222028; 
 Mon, 09 Nov 2026 12:30:22 -0800 (PST)
X-Received: by 2002:a05:7022:23aa:b0:1ab:6b10:461 with SMTP id
 a92af1059eb24-1b3b604a557mr749011c88.45.1794256220969; 
 Mon, 09 Nov 2026 12:30:20 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060dc0csm823737eec.14.2026.11.09.12.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 12:30:20 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 2/5] docs/system/hexagon: update the overview and emulation
 limits
Date: Mon,  9 Nov 2026 12:30:14 -0800
Message-Id: <20261109203017.262225-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
References: <20261109203017.262225-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX/ISBRx9QkWNC
 1xfcqR4qRbm0/fJLxmbDouDvxnkidXVVLTzGjJGHJR1Y+8nNDzqdjCUZqS1Qr6aHQdgPFqFl86n
 DLG8zcdg+slneoOma4ibqBJ+nrwcPt0=
X-Proofpoint-GUID: bnhyIomcFpb-_oLTrWAx5su7Y9qgdoln
X-Proofpoint-ORIG-GUID: bnhyIomcFpb-_oLTrWAx5su7Y9qgdoln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfXzqWFjNLtxapM
 DCNMTYYPCf/XyxBqgw5P1wi2QAGwJmx+m+BQ1SKfw8vd4+NDzEIY0E5/4kMXJN6ZxfzrtMe03eC
 B0p9yvxnQD+vWVJ5T+aoTT+lxwxOt3N8grWEjZ+Qo0loVbmOAT8xbsxwfScrhoC596FvRLI9z//
 1vAg7K7TxfnkzJ+OHC0HWbEH0GQllme4PYbpI7XK721W5RbzVsS72BvUFdTVyqfOUlEs6jlZzPE
 8vgOWtT+wQV1YQxk44jnGjbSN1CBiu7Lz8cmNUjVe0oR09YThhTKM764CS96t8Vc0DLjEPPwn3u
 3fvFrla9qKCM4arP3HqpdZO+6nK7i+6KhDcUYQ5Hvc/CuUBRjuq39kifCgnWrk/ihU08/h2UC/Q
 y9J0u3TK4xq0ZmRwzb1S/QUgmkFZwkOCGKuokB8JGbYldvDwvgrLSw3PTE9GN7YayCOjMWJU9S2
 rlNLmngX9IGIRiow3Mg==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af22d5f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5uMcSSmQ1h4GQFTkCBAA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RGVzY3JpYmUgdGhlIGRldmljZXMgdGhhdCB0aGUgbWFjaGluZXMgaW5zdGFudGlhdGUsIEVMRiBi
b290CnBhdGguCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWlu
QG9zcy5xdWFsY29tbS5jb20+Ci0tLQogZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0
IHwgMTggKysrKysrKysrKysrKysrCiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgICAg
fCAzNyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDM5
IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVt
L2hleGFnb24vZW11bGF0aW9uLnJzdCBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJz
dAppbmRleCBmYjU3Yzc3YWU5MC4uNDFhOWE4NDY3ZjkgMTAwNjQ0Ci0tLSBhL2RvY3Mvc3lzdGVt
L2hleGFnb24vZW11bGF0aW9uLnJzdAorKysgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlv
bi5yc3QKQEAgLTExLDcgKzExLDI1IEBAIEl0IGFsc28gaGFzIHN1cHBvcnQgZm9yIHRoZSBmb2xs
b3dpbmcgYXJjaGl0ZWN0dXJlIGV4dGVuc2lvbnM6CiAKIC0gSFZYIChIZXhhZ29uIFZlY3RvciBl
WHRlbnNpb25zKQogLSBgSFZYIGZsb2F0aW5nIHBvaW50IDxodHRwczovL2RvY3MucXVhbGNvbW0u
Y29tL2RvYy84MC1OMjA0MC02MS90b3BpYy9odngtZmxvYXRpbmctcG9pbnQuaHRtbD5gXy4KKy0g
SExYIChzZWUgdGhlIGBITFggcmVmZXJlbmNlIG1hbnVhbAorICA8aHR0cHM6Ly9kb2NzLnF1YWxj
b21tLmNvbS9kb2MvODAtTjMwNDAtMjMvdG9waWMvaGx4Lmh0bWw+YF8pLgorCitVc2VyLURNQSBh
bmQgSE1YIGFyZSBub3QgeWV0IGltcGxlbWVudGVkLgorCitNYWNoaW5lIGNvbmZpZ3VyYXRpb25z
IGFsc28gc2VsZWN0IHRoZSBhdmFpbGFibGUgSFZYIGNvbnRleHRzLCBWVENNLAorYW5kIEhNWC9I
TFggcmVzb3VyY2VzLiBTZWUgOmRvYzpgbWFjaGluZXNgIGZvciB0aGUgbWFjaGluZSBjb25maWd1
cmF0aW9ucy4KIAogRm9yIGluZm9ybWF0aW9uIG9uIHRoZSBzcGVjaWZpY3Mgb2YgdGhlIEhWWCBl
eHRlbnNpb24sIHBsZWFzZSByZWZlcgogdG8gdGhlIGBRdWFsY29tbSBIZXhhZ29uIFY3OSBIVlgg
UHJvZ3JhbW1lcidzIFJlZmVyZW5jZSBNYW51YWwKIDxodHRwczovL2RvY3MucXVhbGNvbW0uY29t
L2RvYy84MC1OMjA0MC02MS8+YF8uCisKK0VtdWxhdGlvbiBsaW1pdHMKKy0tLS0tLS0tLS0tLS0t
LS0KKworVGhlIHN5c3RlbSBtb2RlbHMgdGFyZ2V0IGZ1bmN0aW9uYWwgZXhlY3V0aW9uLgorCitI
VlggdXNlcyAxMjgtYnl0ZSB2ZWN0b3JzOyA2NC1ieXRlIG1vZGUgaXMgbm90IGltcGxlbWVudGVk
LgorCitTZWUgOmRvYzpgLi4vLi4vZGV2ZWwvaGV4YWdvbi1zeXNgIGFuZAorOmRvYzpgLi4vLi4v
ZGV2ZWwvaGV4YWdvbi1sMnZpY2AgZm9yIHN5c3RlbS1yZWdpc3RlciwgVExCLCBhbmQgaW50ZXJy
dXB0CitkZXRhaWxzIHJlbGV2YW50IHRvIE9TIGFuZCBmaXJtd2FyZSBhdXRob3JzLgpkaWZmIC0t
Z2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0CmluZGV4IDVhNjQ2ZmQwZDA0Li43YjdkMGJjMzFiYyAxMDA2NDQKLS0tIGEv
ZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdApAQCAtOCwxNSArOCwxNyBAQCBIZXhhZ29uIFN5c3RlbSBlbXVsYXRvcgogVXNl
IHRoZSBgYHFlbXUtc3lzdGVtLWhleGFnb25gYCBleGVjdXRhYmxlIHRvIHNpbXVsYXRlIGEgMzIt
Yml0IEhleGFnb24KIG1hY2hpbmUuCiAKLUhleGFnb24gTWFjaGluZXMKLT09PT09PT09PT09PT09
PT0KK0RTUCBzdWJzeXN0ZW0KKz09PT09PT09PT09PT0KIAogSGV4YWdvbiBEU1BzIGFyZSBzdWl0
ZWQgdG8gdmFyaW91cyBmdW5jdGlvbnMgYW5kIGdlbmVyYWxseSBhcHBlYXIgaW4gYQogIkRTUCBz
dWJzeXN0ZW0iIG9mIGEgbGFyZ2VyIHN5c3RlbS1vbi1jaGlwIChTb0MpLgogCiBIZXhhZ29uIERT
UHMgYXJlIG9mdGVuIGluY2x1ZGVkIGluIGEgc3Vic3lzdGVtIHRoYXQgbG9va3MgbGlrZSB0aGUg
ZGlhZ3JhbQogYmVsb3cuICBJbnN0cnVjdGlvbnMgYXJlIGxvYWRlZCBpbnRvIEREUiBiZWZvcmUg
dGhlIERTUCBpcyBicm91Z2h0IG91dCBvZgotcmVzZXQgYW5kIHRoZSBmaXJzdCBpbnN0cnVjdGlv
bnMgYXJlIGZldGNoZWQgZnJvbSBERFIgdmlhIHRoZSBFVkIvcmVzZXQgdmVjdG9yLgorcmVzZXQg
YW5kIHRoZSBmaXJzdCBpbnN0cnVjdGlvbnMgYXJlIGZldGNoZWQgZnJvbSBERFIgdmlhIHRoZSBy
ZXNldCB2ZWN0b3IuCitRRU1VJ3MgRUxGIGJvb3QgcGF0aCBpbnN0ZWFkIHN0YXJ0cyBhdCB0aGUg
RUxGIGVudHJ5IHBvaW50OyB0aGUgZ3Vlc3Qgc2V0cwordXAgaXRzIG93biBgYEVWQmBgLgogCiBJ
biBhIHJlYWwgc3lzdGVtLCBhIFRCVS9TTU1VIHdvdWxkIG5vcm1hbGx5IGFyYml0cmF0ZSBBWEkg
YWNjZXNzZXMgYnV0CiB3ZSBkb24ndCBoYXZlIGEgbmVlZCB0byBtb2RlbCB0aGF0IGZvciBRRU1V
LgpAQCAtNjAsMzIgKzYyLDM2IEBAIGhhcmR3YXJlIHRocmVhZHMgZGVwZW5kcyBvbiB0aGUgbWFj
aGluZS4KIAogQ29tcG9uZW50cwogLS0tLS0tLS0tLQotT3RoZXIgdGhhbiBsMnZpYyBhbmQgSFZY
LCB0aGUgY29tcG9uZW50cyBiZWxvdyBhcmUgbm90IGltcGxlbWVudGVkIGluIFFFTVUuCitUaGUg
ZGV2aWNlcyBpbnN0YW50aWF0ZWQgZGVwZW5kIG9uIHRoZSBtYWNoaW5lLiBRRU1VIGltcGxlbWVu
dHMgdGhlCitpbnRlcnJ1cHQgY29udHJvbGxlciwgdGltZXIsIGNvbmZpZ3VyYXRpb24gdGFibGUs
IGFuZCBhY2NlbGVyYXRvciBjb250ZXh0czsKK2xvY2FsIFJBTSByZWdpb25zIGFyZSBwcm92aWRl
ZCB3aGVyZSB0aGUgbWFjaGluZSBjb25maWd1cmF0aW9uIGNhbGxzIGZvcgordGhlbS4KIAogKiBM
MlZJQzogdGhlIEwyIHZlY3RvcmVkIGludGVycnVwdCBjb250cm9sbGVyLiAgU3VwcG9ydHMgMTAy
NCBpbnB1dAogICBpbnRlcnJ1cHRzLCBlZGdlLSBvciBsZXZlbC10cmlnZ2VyZWQuICBUaGUgY29y
ZSBJU0EgaGFzIHN5c3RlbSByZWdpc3RlcnMKICAgYGBWSURgYCwgYGBWSUQxYGAgd2hpY2ggcmVh
ZCB0aHJvdWdoIHRvIHRoZSBMMlZJQyBkZXZpY2UuCi0qIFFUaW1lcjogQVJNU1NFLWJhc2VkIHBy
b2dyYW1tYWJsZSB0aW1lciBkZXZpY2UuIEl0cyBpbnRlcnJ1cHRzIGFyZQorKiBRVGltZXI6IHBy
b2dyYW1tYWJsZSB0aW1lciBkZXZpY2UuIEl0cyBpbnRlcnJ1cHRzIGFyZQogICB3aXJlZCB0byB0
aGUgTDJWSUMuICBTeXN0ZW0gcmVnaXN0ZXJzIGBgVElNRVJgYCwgYGBVVElNRVJgYCByZWFkCiAg
IHRocm91Z2ggdG8gdGhlIFFUaW1lciBkZXZpY2UuCiAqIFFEU1A2U1M6IERTUCBzdWJzeXN0ZW0g
ZmVhdHVyZXMsIGFjY2Vzc2libGUgdG8gdGhlIGVudGlyZSBTb0MsIGluY2x1ZGluZwotICBEU1Ag
Tk1JLCB3YXRjaGRvZywgcmVzZXQsIGV0Yy4KLSogQ1NSOiBDb25maWd1cmF0aW9uL1N0YXR1cyBS
ZWdpc3RlcnMuCisgIERTUCBOTUksIHdhdGNoZG9nLCByZXNldCwgZXRjLiBCb2FyZCBtb2RlbHMg
cHJvdmlkZSBzZWxlY3RlZCByZWdpc3RlcnMKKyAgZm9yIGZpcm13YXJlIGluaXRpYWxpemF0aW9u
LgorKiBDU1I6IHRoZSBRVGltZXIgY29udHJvbCByZWdpc3RlcnMgYXJlIG1hcHBlZCBhdCB0aGUg
bWFjaGluZSdzIENTUiBiYXNlCisgIGFkZHJlc3M7IHNlZSA6ZG9jOmBoZXhhZ29uL21hY2hpbmVz
YC4KICogVENNOiBEU1AtZXhjbHVzaXZlIHRpZ2h0bHktY291cGxlZCBtZW1vcnkuICBUaGlzIG1l
bW9yeSBjYW4gYmUgdXNlZCBmb3IKICAgRFNQcyB3aGVuIGlzb2xhdGVkIGZyb20gRERSIGFuZCBp
biBzb21lIGJvb3RzdHJhcHBpbmcgbW9kZXMuCiAqIFZUQ006IERTUC1leGNsdXNpdmUgdmVjdG9y
IHRpZ2h0bHktY291cGxlZCBtZW1vcnkuICBUaGlzIG1lbW9yeSBpcyBhY2Nlc3NlZAogICBieSBz
b21lIEhWWCBpbnN0cnVjdGlvbnMuCi0qIEhWWDogdGhlIHZlY3RvciBjb3Byb2Nlc3NvciBzdXBw
b3J0cyA2NCBhbmQgMTI4LWJ5dGUgdmVjdG9yIHJlZ2lzdGVycy4KLSAgNjQtYnl0ZSBtb2RlIGlz
IG5vdCBpbXBsZW1lbnRlZCBpbiBRRU1VLgorKiBIVlg6IHRoZSB2ZWN0b3IgY29wcm9jZXNzb3Iu
IFNlZSA6ZG9jOmBoZXhhZ29uL2VtdWxhdGlvbmAgZm9yIHN1cHBvcnRlZAorICBtb2RlcyBhbmQg
aW5zdHJ1Y3Rpb24gc2V0cy4KIAogCiBCb290c3RyYXBwaW5nCiAtLS0tLS0tLS0tLS0tCi1IZXhh
Z29uIHN5c3RlbXMgZG8gbm90IGdlbmVyYWxseSBoYXZlIGFjY2VzcyB0byBhIGJsb2NrIGRldmlj
ZS4gIFNvLCBmb3IKLVFFTVUgdGhlIHR5cGljYWwgdXNlIGNhc2UgaW52b2x2ZXMgbG9hZGluZyBh
IGJpbmFyeSBvciBFTEYgZmlsZSBpbnRvIG1lbW9yeQotYW5kIGV4ZWN1dGluZyBmcm9tIHRoZSBp
bmRpY2F0ZWQgc3RhcnQgYWRkcmVzczo6CitVc2UgYGAta2VybmVsYGAgdG8gbG9hZCBhbiBFTEYg
ZmlsZSBpbnRvIG1lbW9yeSBhbmQgc3RhcnQgZXhlY3V0aW9uIGF0CitpdHMgZW50cnkgcG9pbnQ6
OgogCi0gICAgJCBxZW11LXN5c3RlbS1oZXhhZ29uIC1rZXJuZWwgLi9wcm9nIC1hcHBlbmQgJ2Fy
ZzEgYXJnMicKKyAgICAkIHFlbXUtc3lzdGVtLWhleGFnb24gLU0gVjY4Tl8xMDI0IC1rZXJuZWwg
Li9wcm9nLmVsZiAtYXBwZW5kICdhcmcxIGFyZzInCiAKIFNlbWlob3N0aW5nCiAtLS0tLS0tLS0t
LQpAQCAtOTcsMTAgKzEwMyw5IEBAIGd1ZXN0IHNvZnR3YXJlIGNhbiBhY2Nlc3MgdGhlIGhvc3Qg
Y29uc29sZSBhbmQgZmlsZXN5c3RlbS4gUmVhZCB0aGUKIGZvciBkZXRhaWxzLiBTZW1paG9zdGlu
ZyBpcyBlbmFibGVkIGJ5IGRlZmF1bHQgb24gaGV4YWdvbi1zaW0tY29tcGF0aWJsZQogbWFjaGlu
ZXMuIFRoaXMgY2FuIGJlIGZ1cnRoZXIgY29uZmlndXJlZCB0aHJvdWdoIGBgLXNlbWlob3N0aW5n
LWNvbmZpZ2BgLgogCi1IZXhhZ29uIEZlYXR1cmVzCi09PT09PT09PT09PT09PT09CiAuLiB0b2N0
cmVlOjoKKyAgIDpjYXB0aW9uOiBIZXhhZ29uIGRvY3VtZW50YXRpb24KKwogICAgaGV4YWdvbi9t
YWNoaW5lcwogICAgaGV4YWdvbi9lbXVsYXRpb24KICAgIGhleGFnb24vY2RzcAotCi0tIAoyLjM0
LjEKCg==

