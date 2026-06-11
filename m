Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EC9CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY37-0001oo-92; Thu, 11 Jun 2026 01:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2n-0001a0-9W
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2j-0002dT-Ml
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GE5V3724528
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4EM+UIGlG3Y9zev600+fYgRTFgH/Jj6ovukjiVYu1J4=; b=LBJWcbNu/UeOygf8
 ai5kGBfCXUJzAAaZhiwLuR/o59RhApjJAzvU97oEaoPZrW/Yhfxmaabq8483qZkV
 AZWy2cd1/QZ+DCA1xm8ugSvuHhCAkBkrKBKlIGc56OXAk0vtnHGWCmOr/vJ7LXZG
 Nr/lXmn1IpsV8FQbL9rhChpHpQatYvrba7IYbD9HIefFYHE0P1VLLvBDF8EuVPP0
 pajquHYqmuI5M4a2VslEQnRQq834MxH403pLoFb+MPAbCxRKDfts95lKFCys6PSS
 B/WrOZi7HwzcRmef8i9/k189/CeP2qmhm8+iBUxWp/fFZiL4rHCLhoK79gkGEg36
 ulCPOw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qtm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so7777623eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155998; x=1781760798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4EM+UIGlG3Y9zev600+fYgRTFgH/Jj6ovukjiVYu1J4=;
 b=YqFEvJ/ntftIBfWJeLYol6Ksme8ZNhA83QPe5Aj6V9XMKXR4GhUgZdENaEPzpozHnn
 vGptKVmeUne/bk1VtEpCi/TlTOZKAoU809LmJfi6UiYpJ0hw/jdGYmDiA2TnxzuNKM96
 QF5fNUOSFcpxvUsYKs7ZU2XBmYvhg4lziSIX4qiz/1SmE5rQlsO8UgJKnxgCx2Kz3Kl+
 GtymGia60AfTVdWjQXvnaIh2GADunBujkXCwrT7R2xAqFxS5Pj/UITpSqNDEbrw4IpvL
 GWAAVfgvMPqz7UbjpZ7tfidKCo82n2Kzp/t3/cWLKYxZfpM21GfQ4lg0WFR00Vw2zI+2
 WG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155998; x=1781760798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4EM+UIGlG3Y9zev600+fYgRTFgH/Jj6ovukjiVYu1J4=;
 b=pOBwpAfwSJBjOvglWa/7vLvkwjplhLnvLXTwnlWrH+e6s4UaBH5dfIzCBqM2gPcdUG
 dpxXyB5zo9i2kwUG963aRUlvY5kCqLzru9p9K3HHRE3XoiCcu6kmNMfdZN+9FU14b/TY
 q6YXBBf8vURXK0+5rHcdCjKH3bkBFCqFasW7E1Z+aSMmo/0mskOBQvty3Z7SE1cBqd++
 nFSt2rsRfXb6KO/zsL15qvuIunAOPObImcc99X+fONWR+eX64ua7eO3tAoL2W3s4vnyg
 qNPb+nvW+hZ5QYK0TsAAwWRjqNlMk4Zk9PhV1WKkDgz+cst9VoyKcwGAYhV4vSCHT5CM
 WvtQ==
X-Gm-Message-State: AOJu0YwNtlG6zXp1EMBzBL66qjocJdk672q0edFOuNc7lgBZePjsqBWJ
 e175CBPpwrHDdWErbOs7zAv4h6dzhA9zANXOznvB6MqGRZBSxrajBnL7ARi8y507r/cDHtU6oH1
 ceM3/vNYk+jOHTHUGS88Xn8VqHXF0GxkjP07MMVzfl0OXg0lVZrJcIfGB26txiOJpmA==
X-Gm-Gg: Acq92OETAjbEUB0sHwozNR0hH/HSJQ1idlswJunjbWcLjtHJ6mI/zKwu7sBdoLC3sZf
 cZcspCaztkZhQ6WOFZhxYV2t47ZniG0JGy6DWrq6c0+Bp+8q0I2HTzGpqLzmbb0705y1BsjVx/e
 xuovPbeHgDacCgYeoFtVbSA9VVx3hTQ0yD6GD0T+GwoJDJ7tBFUiUWPRCyABmttsSEqwFsuUTwe
 RyvEAz1J2oV2tOmzstfnyStw68HPNErV+YxK8qtTUbx0rp2YKiWZOCy2U23/ayaCYg4/AHVnN3W
 ANMTOsVTJ3Ao15xTTVH6ZOGiScYxAAO1BujjB7Q7X3l+pvmkGIOsKSyPz+UL/TR5eNCe819nx0B
 ErnF+0eVrCM07WFo9HIsQCqGwimlXwmiZ7xBQC12Ef8+s6lhWKwzRPyPsaI9d519Wy19GF4j23b
 cIXKY5
X-Received: by 2002:a05:7300:8608:b0:304:df8b:71ee with SMTP id
 5a478bee46e88-308046225camr956902eec.7.1781155997643; 
 Wed, 10 Jun 2026 22:33:17 -0700 (PDT)
X-Received: by 2002:a05:7300:8608:b0:304:df8b:71ee with SMTP id
 5a478bee46e88-308046225camr956881eec.7.1781155997091; 
 Wed, 10 Jun 2026 22:33:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement hexagon_resume_threads()
Date: Wed, 10 Jun 2026 22:32:35 -0700
Message-Id: <20260611053249.3918491-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: CzNnH2y-3kSJBQC7PV71eVPgmYOBe2mH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX/6Ue8kNHjbCy
 hqnF3n6U09CnZC5/3mdr59YUmGoBTIRdKXZtmQO8Pucs0Crc8EO+WHtQAufXPdC/iLiUid1fNmE
 gVsn0HZt6Y0aCh7HNJUD/GW5n0HIFs8=
X-Proofpoint-GUID: CzNnH2y-3kSJBQC7PV71eVPgmYOBe2mH
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a489e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=uy5dMy9T3THg1DqjAFIA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX/SGeC0VECgFj
 sc96hSsPGjKPUuzOQ10MqrsX5VSR5Mr9+DIFFvSFyaQsShcDTdEXP5eEl1HcyEEfCP095O5BJa4
 vzJo4mMlDOo7rK7WSg4R7tz7ub8e/5PS0o1RWi+C6PH+yjl2gGRfzuvXUzK52bMo8hds7TUq53+
 9OMpYzUUcw6bZ1HVbrle5+G6dLuwlBY+GX+p+ybpqLXxkXVGtgXto3CwTU9brvbivfY4BZPLLdY
 kv2hiQFHn6F9gbaYR0bSYQ9D0xD9+II43tJJg8rC/utTmY706xQG2tJ68cmZdKb1GlhOiofSQxW
 /NUtY7WiqGUerTo17fGa3jPeLcEepDiBbtxGeO/uhB4nXz+LmJXau+N+Jqrb9Ii5pzzdRfFjGK6
 Wv6Dyj5Suv2OqVk0j94VskVPkdO6LwIdTb2Jc+MJDxSXLKBBZTMoxExiXIbKRacCIO/Vhm3JT+K
 XbjrbUzt6eegooi7Pyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
dS5oICAgICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMgKystCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggOTJkNGJi
OTcxMjkuLjZhOTVhNmJjNWIxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNTIsNiArNTIsNyBAQCB0eXBlZGVmIHN0cnVjdCBI
ZXhhZ29uR2xvYmFsUmVnU3RhdGUgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlOwogI2RlZmluZSBQUkVE
X1dSSVRFU19NQVggNSAgICAgICAgICAgICAgICAgICAvKiA0IGluc25zICsgZW5kbG9vcCAqLwog
I2RlZmluZSBWU1RPUkVTX01BWCAyCiAjZGVmaW5lIE1BWF9UTEJfRU5UUklFUyAxMDI0CisjZGVm
aW5lIFRIUkVBRFNfTUFYIDgKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhB
R09OX0NQVQogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDNlMTAz
NjA5ZmQ0Li4yYmMxZjBkMzEzYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVy
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE2MDAsNyArMTYwMCw4IEBA
IHZvaWQgSEVMUEVSKHdhaXQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykKIAog
dm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgaGV4YWdvbl9yZXN1bWVfdGhyZWFkcyhlbnYsIG1hc2spOwogfQogCiB1aW50MzJfdCBIRUxQ
RVIoZ2V0aW1hc2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpCi0tIAoyLjM0
LjEKCg==

