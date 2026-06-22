Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487A3CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn92-0003Mp-Ka; Mon, 22 Jun 2026 18:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn90-0003MS-Lm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8z-0006LE-AJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbFme2206068
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=; b=Xl
 mgaUQPY0LGyG8AQ7gDt8vHjgyxotH0G9roSC642TGmlmmJBtTvoVpcrNmRcT7pD2
 VsNvHZhsrPLymGMbaG0t6DSef+v8F+GPdJpwhtiLrXKk5yQhZz2iwO/GbHDyxJgi
 eEIa0Hiwocsetoa2wmv0hyKoeW87EcyNRmjW62oI7+yspWhbS0HMRltvagxdNIUD
 HqELt3yFmK9TPUudAw0MErspMFFS+qxmZ1X5E2prnFWwfTFBWHJYbs+KvcBMBFPT
 iLRatJbe3T55mnl2jL1F8E15CpmYv9/K5ULID+7HQDDks5IArmhHIBhfNeP8LgzM
 8sXwLNWvhNviBzbfHyAw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmsp2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so15194053eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167367; x=1782772167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=kX38m4keBoiTDVA8ja9cFzfj9xiUjinc2OC84WTkZrnvnWHcPGxzVj/EAjFSv5mq3F
 jrjp5axwy+/NRwQ27WpfkzHTPK+9Pz0vpMdBeDC6o1HkVUcN0M1rGBI5LbMhI15iHOyu
 AXOyVIhjxKpZE+pXTX6L+MYtX/TSj2IzeZ3LyOmJ4/z8vU9V7GsrWOrzRHVJd8FHx4Md
 rtopZPCbSY67VjSIIKuQBQQm53Uqp0gh7Bp2G3CR6JenSC6SO29RknPx+hHjuRR4Ky/K
 VxR4jorPwr5miDFnAJHR2snr6u5JGMfE6wVIGPp45cbeCB/90oVc9RJqLjwMqf6G8J6M
 wOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167367; x=1782772167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=RETpAs/ZGsMS/e0GxFCKl9RJnCNaTVWW7EhKgOsuBtMsv8rK8/w+oNx8Zk/DchhH9J
 An8x5Ld8Fum4si7Fz6s9nD/t8g+6kpP0YHB8o8MBIE/XUwP/PdMYtft10gsvmkBD0eCW
 jvCV/8ovWkP7nHY+aky0U4XO5bD6gfb4dP85apvGc/pgQkC7JYqWSQa0UlYxh31gm53O
 o9ndnrFEAMVIIKXAhr5kqjpfoLyCvq0GlX9jOJplghPUKKw5h0icdxD8uMFs1NkqsvKd
 RsoQ9tZ4sxyZydunkEowTG/Q/o5VC5e3nix1Qg/IkFn2PUpBchb1xaPsUEqRnetPNTw5
 bdXA==
X-Gm-Message-State: AOJu0YyeDxnD1wKWmn6BnslBkow9aDBETXYEeLzE4vcG28QGfMBsabAL
 Amqac6pmeNQDr81a2/SDuhcO/f4zPaXUYyKFcrD3jEAH11GbP2PFuB3lwVFbxKTiE0hPiiwEd6A
 fAu2oay034vR2hyHcYJLqgP8hpQlDyMj5EwycuqDsImX5pbKQdftVXNkVcoAc80Nohw==
X-Gm-Gg: AfdE7cl0HxQh4o6pKY95+5jkwMkgHLxDGIIZxLVaPY9e1vIVbvoySQB6xvxkbSexGeF
 SV5KRbwmGWgdRgEu6s6Kn6abVXtmaAuRsWbP10bniDQlDEG8m3mdUIRWjiNA6J3jdmFa2PywHCS
 VcZpl9BKyIhsjNdOHMtuhpyymOMSXKWN9ZJsfb1HPi6V8Fcu9W8pxs/evvq3gELl6j3e7CiiVKp
 lAooASL/btQiFq+njROHn14+Xi6diCLb2rc8fomfgj2UTxgRs8JLTncyn7Y/AZtydheAMezJTKL
 w8usJZbfBDhvnZpdDIP8/EO8XbQrD4k8h7vL5uJUr8Mbu32lHE4M19XGf4GeF6Yw4/W2fOO78DD
 bIKvrKouAKo+VIZsshEuH1ZHqFbe2L0KvrIjEh3Ressjz0t3/O0AMWfXJoug=
X-Received: by 2002:a05:7300:3245:b0:30c:550d:3c7b with SMTP id
 5a478bee46e88-30c550d416dmr1476118eec.1.1782167367489; 
 Mon, 22 Jun 2026 15:29:27 -0700 (PDT)
X-Received: by 2002:a05:7300:3245:b0:30c:550d:3c7b with SMTP id
 5a478bee46e88-30c550d416dmr1476085eec.1.1782167367012; 
 Mon, 22 Jun 2026 15:29:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 10/75] target/hexagon: Add a placeholder fp exception
Date: Mon, 22 Jun 2026 15:27:59 -0700
Message-Id: <20260622222904.607771-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX/Qf2U3hwWQOP
 9OWYBk/vrJ3aBVc7+BKwLlRydnhG9ULWCWlY4+KFticlCWZYucGxZdkm+f3/EvEfD7IaDwTh75E
 uJG4H1A3OufxP1QLAroH24D/jaGqCaI=
X-Proofpoint-GUID: w5BfEUTqp8u1LT2lvP15uJPygDTWXuqs
X-Proofpoint-ORIG-GUID: w5BfEUTqp8u1LT2lvP15uJPygDTWXuqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXxcg0lS25ME1U
 35qXFVUou3Bx/iwwB46qFc9Tpmtk0pHDWw8dgXYRiGRZV8zCKsEaTKftD7FZQxKLZCJekTrBNht
 e34UHMJ7Wt4bak/BL+tOvYxm5R3S9UCVApClJbmR68ftNFZatehm1wCw0KBbDRA8fluULUvdawg
 McVhAc3qPRjKKvD4CUqv2DWbzWHFaUCIG+4FLULToMF7/5vMxpjmxBQ9JYelzt+2ZW3PT3COAoQ
 NOLz8yWYS7oLuAHxuG2YUcACuP9lmh3js7FraY4X4jfY2rjXzLMKpeDhNueFQeL7qIGE/CqXdKY
 iXVXNCIhvH5mqysX2wFFH0lPa+KeQQnK68A6YP5QwImgmZn2DUWqOXN2S75ADQUCEEZdiRR7c+J
 N2TBAFzdNc+e2bvD4C0vOQqRyL6QXlIHGsNcr1wFuFZjKpcxvjsAFN483rPBvjbP+akH51u8QPd
 3SG87RUHsblWUPgp2ig==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39b748 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

