Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391BFC56208
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws5lw-00051B-K6; Thu, 06 Aug 2026 17:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1ws5lq-00050t-3B
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:36:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1ws5lm-00005M-HN
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 17:36:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676L8KGi2851711
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 21:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fMt3ZVXeQAKrBr5mKmgYzz
 NKpu4BWrb1it6+EzrmyAo=; b=UU0/HWBovgcOspEaBn1Z93RlRV3+iWVdfNb0gh
 Yn6giMIfqTtgGO7V8npjppTIHthXmKoYHUjFIWlYsGFgnSOv+BqWaLzvXM5D1B2l
 pETjPRs8Tsg9qVSmx2zdNdtPmwmifgMn6tUtB0sS+IMkeT8uHGjdyBqOHRJ3TdLx
 pMuMNb8ehMbz/aglJZTsyvJiwFlnKNc0829UB4onoH6OKiNX0UhP5mnxttJzwxAB
 lOsRjqgxzcw2OswJlMB/9cG6gdLSQpe0hBLOBJxQEv3CbvltGbINsCIEfPOQzJld
 moDi85FGf4EW9g5pBa55G2G4juX4f9okwLpeNqtjqTKJsOPQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6k0x0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 21:36:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso3002964b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786052203; x=1786657003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fMt3ZVXeQAKrBr5mKmgYzzNKpu4BWrb1it6+EzrmyAo=;
 b=V96P2rjYjEdWipZ9tTLRWJkj2G28jsKDmIJG9UVBaWzggs5RHmNzB6CUVPZ177yMMV
 hoiWqf57/CONVt56TpDPXoCx7ENBbPtMAZtq/oxmKdykyWyOxhNt8BUQm+GnJieh9mJ/
 IodKF35dnDL0F1KYVn9zV7AV112UhkwcRJDUTs6U6+gALRVyB7Dm3QodyMoKqnH2VjnL
 b9YJPpalydRzgE03JYtwvNQgjThzbv75s4VEca7puy/JsownzuOzpg3Zn5mDcULKDShC
 q0gTd1gFChIGKJLTCJwArcd+o6d1snynsu9CDTwdWJc4c5qh5z0C6MUGux4Flf/hC90y
 FczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786052203; x=1786657003;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fMt3ZVXeQAKrBr5mKmgYzzNKpu4BWrb1it6+EzrmyAo=;
 b=OUtsUY9XCiZ6oF95t9ivpS3AbFiORYXvIUfvOItnnpdQV+aBpNkC0QDxVDlVaUoW2u
 ws1Lh0PAOPL1jHvooER7KfymUfrAOIFuoeflt+78stZVPvHPw+eF3GDMH8UdXcbNjlbX
 cUZYU7SkWC/K5R6iI+ekhNIG4P14DpqFX1Tz1RF8ZyHMpHpyB4qfHdfeZh00dbYU8Cr0
 dqSLnAfsDFHJ2ebQAHvWh0OZtmFR5p3p87mlTorADsKi+yn9rp110znpLa8tbn7a+Sko
 nHBOj/sYfQy3MwXZwIu9nbHQO6i2oayLc1Oyt8Y9xPNWZkVtyoxZ/16O3KT624DDh8P4
 UpkA==
X-Gm-Message-State: AOJu0YwASWkjtMz21vQcgFQmV2W9nRmEI1KjMBam3Py46cMDcZU+6O3x
 SeEMCsfTs4mMb9nfaT0s1YiuWW4CBiGrGZKmkjD3/wTl1io7n1Z+oLUCFCw8n46G5hjKUKjGUHE
 hP0fvqs0TADNDtdQ5umx9GQsGaC6IkoxEMXkWfIOVyBK1P5X/zHEVprFJkNcGOtmRqA==
X-Gm-Gg: AR+sD11uN1bNNgA6prdIMAxoDAhtN4lfunluJ1oaPehYVqoz7UenwlevzRnB8ltuITB
 vuTOFlkuwwptPlOknIGRxFUKCFoIBY2xPdlThhhqNu1xi3Li70HkJVeggvsGRU07qApy7C8KVCJ
 yMQcVPivRneHG9xGHC3KV6xUVKq6D2buNNBRUggGHeymNdLjCF9Ye38lopOyI5gxsJL7W1qCsE8
 297FfCoDMW1iCpnEuXqxyhrWZmyET3cdIHt0rlFOCSB906p3SCgY/N+owN3HVRd3enfvSRjjOML
 0sLbJ0E8zQ3pNar3uFlEl5xZv6MemMsCnmZOGFzsw8iOfRY1q6Sk2kC/toJxDwZaBv8RK7ap1jI
 HT95h4bIsdHk5UWX+gc2FhO3CErOUCHUiDV4FYiIix6wujcht
X-Received: by 2002:a05:6a20:a11f:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cbad874668mr4821680637.0.1786052202660; 
 Thu, 06 Aug 2026 14:36:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11f:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cbad874668mr4821636637.0.1786052202171; 
 Thu, 06 Aug 2026 14:36:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm223557c88.13.2026.08.06.14.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:36:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com
Subject: [PULL 0/3] Hex queue
Date: Thu,  6 Aug 2026 14:36:37 -0700
Message-Id: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RpX16imK c=1 sm=1 tr=0 ts=6a74fe70 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=wt-ez078E_3xGIYuAwIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 2q98duWPTNGyEzqqpK10MMwOdensOIlL
X-Proofpoint-GUID: 2q98duWPTNGyEzqqpK10MMwOdensOIlL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE2OSBTYWx0ZWRfX5KWjtpejpTw5
 w15ou7rk8WP8BTlmZvC3QwDjpCAvy1EmHXo5aIyDV1m2AgA2p5vvuMBVfbIhhuvg39df55klEMd
 ekiCKafs/mNkbcydJhN4nAv9zXtTOgTXqjsZv4kIQF1NCmSrxbFpJsuqLM+eqGjk3PaIsuf9n+1
 5RphIS5xXhfcU4R7mtKOFf/VwHhMMmwg2UMAgDelzNu44y+JcCz14lD3SXQ4sYjFeUf38+6Z/Kv
 Eat7cNa1nHdEF3E5zq6f7AxFcAeaELC7m/LQjxXCLw7lDWkF+FpBHJoAx3LDvhR9OSyCWwS2Qwx
 r6vBOwfYxQ1Dsq7jaCgp+Bu5xVl98+kMieutk1nmIe/emI7ag1uVQ5Rev+EMfIZL86Jod27WKQk
 SkbdjmB6Wd25RgeiO8s+j+EbpheUCUilDtLTQ7V6h+tH29w49K7JFeS4um9gcfqHyjgW62Z7ILa
 wGpBTLsXSTRyzGqbgwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE2OSBTYWx0ZWRfXzJ+GvRwVpkC/
 z/D+WDqIIQ8KnfiMmSxjiKkVaRS00WuOdo/awCEUJld+VtX6Z4cps3EynvO0AhxiQQyvLpoqA+m
 L77RaDv/TwuFW0aCNEM6rYMQ2AdYufQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_03,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060169
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAzZTNjY2FiMTA2Zjg3OWIxNTEyZjhl
MGQ1MWE4MjdkZDRkZTMwZTIyOgoKICBVcGRhdGUgdmVyc2lvbiBmb3IgdjExLjEuMC1yYzMgcmVs
ZWFzZSAoMjAyNi0wOC0wNCAxNTozNjowOCAtMDQwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdp
dCByZXBvc2l0b3J5IGF0OgoKICBodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdSB0YWdz
L2hleC0yMDI2MDgwNi1wdWxsLXJlcXVlc3QKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byA4ZjViZjRmYTBhYTJmNTY0OGYwMTZiODI2NWQ4NmQ0YjA1YjQyMzA3OgoKICB0YXJnZXQvaGV4
YWdvbjogZG9uJ3QgbGV0IGFuIGlkZWYtcGFyc2VyIGRlc3QgY2xvYmJlciBpdHMgb3duIHNvdXJj
ZSAoMjAyNi0wOC0wNiAwODoxODo1MSAtMDcwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KaGV4YWdvbjogZml4IGNtcHkq
KCksIHNhbWUtc2xvdCBwYWNrZXRzCgpGaXhlcyBmb3IgdGhlc2UgdHdvIGJ1Z3M6Ciogc2hvcnQt
Y2lyY3VpdGVkIHBhY2tldHMgd2l0aCBgY21weShScyxSdClgIHdvdWxkIGdldCB0aGUgd3Jvbmcg
cmVzdWx0CndoZW4gUnMgaXMgdGhlIHNhbWUgcmVnaXN0ZXIgYXMgUnQuCiogc29tZSBwYWNrZXRz
IHdpdGggc2xvdCBjb25zdHJhaW50cyB3ZXJlIGluY29ycmVjdGx5IHJlamVjdGVkIGFzIGhhdmlu
ZwphbiBpbnZhbGlkIGVuY29kaW5nL3NodWZmbGUuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpCcmlhbiBDYWluICgzKToK
ICB0YXJnZXQvaGV4YWdvbjogYWNjZXB0IHZhbGlkIHBhY2tldHMgcmVqZWN0ZWQgYnkgY2hlY2sK
ICB0ZXN0cy90Y2cvaGV4YWdvbjogYWRkIHNsb3QtYXNzaWdubWVudCB0ZXN0cwogIHRhcmdldC9o
ZXhhZ29uOiBkb24ndCBsZXQgYW4gaWRlZi1wYXJzZXIgZGVzdCBjbG9iYmVyIGl0cyBvd24gc291
cmNlCgogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmggICAgICAgICAgICAgICAgfCAgMSArCiB0YXJn
ZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgICB8IDMwICsrKysrKysrLS0tCiB0YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICB8IDExICsrKysKIHRlc3RzL3RjZy9o
ZXhhZ29uL2ludmFsaWQtc2xvdHMuYyAgICAgIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKysr
KysKIHRlc3RzL3RjZy9oZXhhZ29uL3JlYWRfd3JpdGVfb3ZlcmxhcC5jIHwgNDcgKysrKysrKysr
KysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL3ZhbGlkLXNsb3RzLmMgICAgICAgIHwgNjIgKysr
KysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAg
ICAgfCAxNSArKysrKysKIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAgICAgICAgIHwg
MTIgKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdldCAgICAgIHwgIDEgKwog
OSBmaWxlcyBjaGFuZ2VkLCAyNDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi92YWxpZC1zbG90cy5jCgotLSAKMi4zNC4x
Cgo=

