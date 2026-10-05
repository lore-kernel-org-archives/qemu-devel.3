Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308E7CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDocq-00024R-C4; Mon, 05 Oct 2026 15:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDocp-00023y-3B
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:45:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDocn-0001wK-E2
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:45:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKbwr1745198
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 19:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IIZJ+E4cnm9y31NsJ3V6rSn5ddYXDD2dmIt810NP/lg=; b=myJdHQcB7yV4XsIG
 XPv7EYJQuaaIWqL0ZaXGIu0j2nh6/qC0hZAbPaD4xFVmCDK+amIBGtq8lpDgDLCv
 u2MZ3BZgqrH9H0LSKEKZxRm4jZ03ActwPzBLOYbpGr33x3USPw6PBdIXAjFSkrt+
 JzIcqzsBW8GtcW2ilGOUeoGv8ZJXwZHS8DOO3PFZcZH8E3kEKaEPL9Y1AtnRVZvP
 D2Z917LjHi1UkDNqzk6W5w/4RiuGa5C0ssUAp+39F0pmfttiZAX6JUtlNo3XQ6Hm
 Ytng5XLIUbhKuLzW/abU9LXSPb+R7lnZ7zb5gkTxDJbJc0kyqRLinwnCHnP6Jv5R
 JlvNAg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cvnhfq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 19:45:23 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d84114044so8960162eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791229523; x=1791834323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IIZJ+E4cnm9y31NsJ3V6rSn5ddYXDD2dmIt810NP/lg=;
 b=dA1xe9NnCI5DdUG6y+/l0E3LXmRb+fsAqYdS6RhED0KTmRRW8Wcl1WfJGPyCELIsSY
 J5dVOA5aPqz+X7lUCiHAG10rgufnZ/UKSC8z8TCF7u9Ugi783LiQbxfM0rDR0XHrH66j
 nEB0BYVVdowkBGA6y2/qgn85AGfdf8CY6BxFz0g0jRnq0dVIz6WVupj1w0znsCBWkdWb
 oRPPeD82C3v0AyCEna7Y3mh8p/tLEWX7dFv80POiPNSkgr5l7JL4uIt76yFHpvuQYSdw
 Qi3etHs5SDEL2+8gZpfRNbSWDMrIVR4w8OAwSmNrPFzmaE9JAig+z9faeiCz9jlaD5WP
 Atdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229523; x=1791834323;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIZJ+E4cnm9y31NsJ3V6rSn5ddYXDD2dmIt810NP/lg=;
 b=eHUEVnT3yD9fkrKrT3qqFlLfJSbzIxSa8xkUs6VBYc/7yeydEV0hX2Oo6+Fg24XPa8
 t70ZHXbormCgtYYo5qcZgSeBJc8mNIFsOkUXt3mMuxzX5vHsbO3qb0RdBA4tI/QUBCI/
 0RGBwy/1Ur4/r4Mpjo5QkZA34rDia2a/6SkCBdlRbb5B8EsanAwFhRShm1HO1mxN+kp1
 MgfYCUUtXMgtMvTF9kIysI9y8txpV9mcJnJDs8KoRE4knLDX+UC1vC0HAmiZzdz2viJj
 U+GCCviOsyB0NndIJuMuKPmv4gGBOk75QSYuWvQyD/7oRPflqjZDmPQNaBuHNnvTC1/d
 UUQA==
X-Gm-Message-State: AFuF++lm7lgD3FuhXmC95LOZY+3f2nHtI3MFRPhoaqSATJzn1B3m5JLx
 olTI6soX9ormF1WFbCU/4upmfR/P+Gqcy6w48xuu5vYxzlyM4ApXAtXinvRV9D3gsa/v92fRmnx
 rVM9LePbEO5Gq7OAoYs8ATUBb9P3lHBDfsirwxwtFvztbMbirzCxKii+IdpaBea/U3A==
X-Gm-Gg: AYBFou0dTAnG1dfymybSjDmWLJxflFelpw6XC0eB3G9ljYIfeKz9LmD+g7SRpKTrmgm
 Yvuh1oNwUjx9DwWld6fusjP2jmxmIR89OU69os8YjmU6Mg7RaEyb+YmOcDiS9qYpa9uzKsEtcad
 nMbA1U2keJaeAMKp+vpVAsGjb8MgjgykUEpozDhOD/cPjesZErFKhCVVfFLhNSw8BdlGqbOgkDl
 3IDqsS/lUkPQsAUUL+SVTZbdpASFqHEkXcQSPzBIT2cdzV/Ie5lgj0aXvIPUQuKV9FXhUV7VerB
 jNpD7NDv0OB7/v5hGCi3uA2lD9xy5/QX237sK2Hpy60B9zLt+zgndDym3uMoKf4hBVBCGOuwTIP
 /3Ae4Ooy3C5svuihIb3IuX27qzbiru3hJ2puLr/5HEZn4o00=
X-Received: by 2002:a05:7301:1603:b0:351:28eb:8cd8 with SMTP id
 5a478bee46e88-35128eb8d14mr6331440eec.18.1791229522488; 
 Mon, 05 Oct 2026 12:45:22 -0700 (PDT)
X-Received: by 2002:a05:7301:1603:b0:351:28eb:8cd8 with SMTP id
 5a478bee46e88-35128eb8d14mr6331413eec.18.1791229521969; 
 Mon, 05 Oct 2026 12:45:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351468b2920sm541742eec.4.2026.10.05.12.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 12:45:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/2] target/hexagon: yield on system-mode pause
Date: Mon,  5 Oct 2026 12:45:18 -0700
Message-Id: <20261005194519.2945862-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: SES7Fw3s7JpIAkrZhaRt1Sav46QNfqFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX+gSY0R1VHiPZ
 /CWZkUHq1MEMq2y3ow05QGgYtbVB3lFXj9ATNdIhSJvpWtkk1nkhC/+Vhm33Q3ODFXL5iJNM31r
 z2V5sg8ZA4c/pVwYC4bNOOzoPymTbXrviuNb0PDH11vX+xufcsxG+M8l+lccfMx1oBR49IiplWf
 psekZnX3ftKlHmaRXmI9kNcjMLaZZvkLreZP8aQgUEEpBM4x5wYYG73Isz0dpDC5fBWH8IfRJmG
 JQi/wXsrN6tNpQInNi0qvh/PmOs1TuZTEf9Z5GQxB6bTHvvFmOP7zYMlB9daKmCNKqwzL00gN4S
 5WJeN4LBQqFC0vks1MhYOyYk/k/OZifFZn+Jek/2I3CNyILxr5HzhIPL9Zin0ntbMcLzwda+tn1
 EaAPOGo6moJb35eS7pZKzgoFPunc+gEHjBE5wK1T2lLuT73e1R8qxOs436csqW95DdyVPN6AJ/I
 spAMgL9OmOdOSDxxrnQ==
X-Proofpoint-GUID: SES7Fw3s7JpIAkrZhaRt1Sav46QNfqFK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NyBTYWx0ZWRfX9CoXnaPNFKOz
 afO6AN8/TZYoKiBO6GJTI2B1mTDrcboMUDIDU7Wb/PLf7XzsEw+7hb6l+hTZfoCvgCxz0y3A0hH
 OniTH3kN18JssoLL6ayp5IOsJzvyi8g=
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6ac3fe53 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4R_URXl_t4Iho_Um_bIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050077
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

U3lzdGVtLW1vZGUgcGF1c2UgY3VycmVudGx5IGFkdmFuY2VzIHRoZSBQQyBhbmQgY29udGludWVz
IGV4ZWN1dGlvbiBpbnN0ZWFkCm9mIHlpZWxkaW5nIHRoZSB2Q1BVLiBSYWlzZSBFWENQX1lJRUxE
IHdpdGggdGhlIG5leHQgcGFja2V0IFBDIHNvIGV4ZWN1dGlvbgpyZXR1cm5zIHRvIHRoZSBDUFUg
bG9vcCBhbmQgYW5vdGhlciBoYXJkd2FyZSB0aHJlYWQgY2FuIHJ1bi4gS2VlcCB0aGUKbGludXgt
dXNlciBiZWhhdmlvciB1bmNoYW5nZWQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIHwg
MTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgK
aW5kZXggNWY3ZGY2NmFlNjcuLjgwZDhhN2I2YmFjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCkBAIC0xMTI1LDExICsx
MTI1LDIxIEBACiAjZGVmaW5lIGZHRU5fVENHX1kyX2JyZWFrKFNIT1JUQ09ERSkKICNkZWZpbmUg
ZkdFTl9UQ0dfSjJfdW5wYXVzZShTSE9SVENPREUpCiAKKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZ
CiAjZGVmaW5lIGZHRU5fVENHX0oyX3BhdXNlKFNIT1JUQ09ERSkgXAogICAgIGRvIHsgXAogICAg
ICAgICB1aVYgPSB1aVY7IFwKICAgICAgICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JF
R19QQ10sIGN0eC0+bmV4dF9QQyk7IFwKICAgICB9IHdoaWxlICgwKQorI2Vsc2UKKyNkZWZpbmUg
ZkdFTl9UQ0dfSjJfcGF1c2UoU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIHVpViA9
IHVpVjsgXAorICAgICAgICBnZW5faGVscGVyX3JhaXNlX2V4Y2VwdGlvbih0Y2dfZW52LCBcCisg
ICAgICAgICAgICB0Y2dfY29uc3RhbnRfaTMyKEVYQ1BfWUlFTEQpLCBcCisgICAgICAgICAgICB0
Y2dfY29uc3RhbnRfaTMyKGN0eC0+bmV4dF9QQykpOyBcCisgICAgfSB3aGlsZSAoMCkKKyNlbmRp
ZgogCiAvKiByMCA9IGFzcihyMSwgcjIpOnNhdCAqLwogI2RlZmluZSBmR0VOX1RDR19TMl9hc3Jf
cl9yX3NhdChTSE9SVENPREUpIFwKLS0gCjIuMzQuMQoK

