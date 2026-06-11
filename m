Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4E7CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY9S-0000ik-1k; Thu, 11 Jun 2026 01:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8N-0007tb-TE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8M-0004vL-BH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GGaw3863232
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6REoKtxYW7iJZ83sL9K/XDhR2zy+Z5Cq4HxI3B3weCM=; b=CtsmLAlOn/vp1Cm5
 2hjHxCb81SYUmw4D8FuyIe8pJVx+GIpoiiAWhBfQ4QSquYRp1uGw4zAoG2Tnkt4T
 XY88xmQOBzvThYZBJoU8NUb371wSfRSHym6bEow6Y2AlqLiHp/mailUhwYCbcbS2
 RMReSjH0pPPd6rk7f9Pc/4yeRGtoZGEDQz9+rtCZyS4tgd9maY8sxfXehMg5yWPz
 xrBWrvCnZLaa0Pkq5k6KD3jdmwstOOfR7fdpVzM5edVMVAUlet/X62agZsGKYZPY
 gpSV4Lr8QPLeucM8XfYHy8Oy8Fmoe3U6lGyZJc1FoFjYd3Gnx36hmjdcXGxh6ECn
 QwZ7eg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6shu8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304d2447962so484379eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156356; x=1781761156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6REoKtxYW7iJZ83sL9K/XDhR2zy+Z5Cq4HxI3B3weCM=;
 b=FdvMAdaMuY44hvXGvQD3B6qA0gIZQpH4c38rJK7pFYLo6J8kplPwkbt/xtblmKp+oN
 fu8j09Zq9P8UHTW+t3S044JbvuRm4Nhx/+wE1TjLnEquNPtXQpOvzG0tcnuy5vF/Tuk6
 dSYYkL6zBYDDPLwzZ8AqDYF4PgKGCqb2JOInwi6xrAz2cbDWjVx/o4tEvKvWJGIEaMFC
 TY1snxgsjCpIhvvuLAHsyrQb1XpAY3iuw94tYNHcqWMSlH4o67CB34lmS3DIzjoUoKye
 IsXte8WQl1F6sp2G2N2+naWYVphgfvW542DwaA2nuLZyUe6X2vVVAjHG9g2nkWl5IVWB
 hWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156356; x=1781761156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6REoKtxYW7iJZ83sL9K/XDhR2zy+Z5Cq4HxI3B3weCM=;
 b=MImSzNMuUrIxMQZXzLIsP3AUn/jVBSFzbElqLdq/xV2tVzIyJC4ZNwt0Kf36j2pLyB
 FbJ1qhkLr0vtZnkfUIDR0SnysOhWBEHmEA4aRq+zQBsUjkTWAtyzhmSGg7AA1gx6oL3W
 U8g55zeLCUEIgV0zwmyVdTg/4xT5NS3T2YQPvSE4avr7ivLUQqYelw+i9Jy8Q5re+oWD
 En8OJCJYMmGTANvgkZswdJi/ck7fBitB81eX8WbC8ZB7vEyxmC7Fh7tPGltOCXAKbmMb
 XLBcW1Mcx9Ogk9GZ4CEYHxAevZ8L8YgU7ba6hKN2kad7KNWfvx/T4cR92jDTtdNZkkVR
 Jplg==
X-Gm-Message-State: AOJu0Yz2d1p1pt+pnxmPnEJDuPknMySpR0DmHMEftlploXKDKhZEVe63
 M+fnOg50c9kXxe6vrIBNmIz1y9V0uHV1acBP/rgWNZO05zI7TgUjfFZ4Z4B6HdsBpKBuwTuGt9O
 B47YqbhFMSKpbBXhbQyUlOqU5aH1pnZXHCWQAon3IJC1J1y5n5Dxl9HCXgX+CiKOPmw==
X-Gm-Gg: Acq92OG8SSK5e7YIpQFAVygfiADL1M8Rq67xtobeJkoTGR5yvMiYTvxd0BGnIBmhF3Q
 EB91p5xPH94/DeBxaGwDWpCZw/kDASvQtrjnwY3Zq6wfK+C0GpDpX+A7p0g18W4lBF4u8+sx3Og
 Ym7Dv+zLQW8LSrFAUttdM+i2oHB8LtdwbyY2+xagQH9QdVgbs6UQSkfgi2Ix3thdj8MCgZz91BM
 scKeiKMUBh59Co3CLyT0arDoNG8lwKSZyJcbZywdmq4GpnSO2/BGO/pyoVAmi0cQSg7fkarLU4N
 U/Djs8F7Vn8xjmGUX8q3lfuIsoOsc9UWGcqiHvwZLaMZhTFyOUSCO7XuDpSMkhpuO6rK4wXTeiv
 3Ro6bAmXWZs4M/7l6h13ESXCswuh9IrKmq653bZj+9rIXgqAAuIoeuIwwxZqiI4bnEQ3G2xRfDS
 Nbc3IT
X-Received: by 2002:a05:693c:2c88:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-30805da6511mr835166eec.1.1781156356161; 
 Wed, 10 Jun 2026 22:39:16 -0700 (PDT)
X-Received: by 2002:a05:693c:2c88:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-30805da6511mr835153eec.1.1781156355617; 
 Wed, 10 Jun 2026 22:39:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a9fesm735778eec.16.2026.06.10.22.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:39:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v7] hw/hexagon: Add support for cfgbase
Date: Wed, 10 Jun 2026 22:38:59 -0700
Message-Id: <20260611053902.3927367-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
References: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: R0gASR-FTuFeb4ZT5HmKkVllje4Iavo1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfXzgy9mN2siwvF
 K8r7IesY9pdw2YeutlHBZo7SgaF1iUKLHc+IVNnBcK+pRW/WZcO5OHiIHbYy6hhS+tCoGj6g9Xg
 De3Cpt9q+J41tCPPrA3gPX3ic6qUy8w=
X-Proofpoint-ORIG-GUID: R0gASR-FTuFeb4ZT5HmKkVllje4Iavo1
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2a4a05 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX8Qfyinuhv6VA
 6hK+2fzFhl0/tVTzVkHawAvOhhSfbfJOD+4ktmOHxdAy4AYHnr3LT16DQLpeAV+ac2p76dgnUA5
 ItPfQnlGfpllMf5Izw0hPMzwhs18JgIReVWRrMrW024NuouiX04JhqsAMC23Y2nmhxTkLZNYJFw
 YzmJVQQEut3frL4r5rcvkHf63LiSamrJaw9FKoAbPS2qooOWfvugvqVpGsJfp6gyJ4XV2355HI2
 DZ4J1qKiu85UH9JWiu3W/BwBpxx5yOoKfk8u3zj/9Rowo1LuhPGnLwCz/D3aNX6xK8iXds5V+4m
 BTE3xvPa75FF9pYdE69YbBapbyXEO5wlw4RCTk3mQiaSHBYtoTpFANQUjFD75yxPi7TvXCGELY+
 lZSEd0DWUeM/8nnAAOMGrDxYbCMNw8mE0bum3u9ng2ZtUmFGjUOh2lK60M4mcvK1neBlyAjUFMN
 Bjg0p/xzOzWVr0ngRNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110053
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgfCAxIC0KIDIgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaGV4
YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCmluZGV4IDU5MzRh
OTliNTIyLi5mM2IxMzE5OTY3OCAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5j
CisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpAQCAtMTYxLDYgKzE2MSwxMCBAQCBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgUmV2X3Qg
cmV2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKHRsYl9kZXYpLCAm
ZXJyb3JfZmF0YWwpOwogICAgICAgICBxZGV2X3JlYWxpemVfYW5kX3VucmVmKERFVklDRShjcHUp
LCBOVUxMLCAmZXJyb3JfZmF0YWwpOwogICAgIH0KKworICAgIHJvbV9hZGRfYmxvYl9maXhlZF9h
cygiY29uZmlnX3RhYmxlLnJvbSIsICZtX2NmZy0+Y2ZndGFibGUsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKIH0KIAogc3RhdGlj
IHZvaWQgaW5pdF9tYyhNYWNoaW5lQ2xhc3MgKm1jKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA0ZmUwOTAyMWE1ZC4uNjFiODZm
NjdkMTcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0zOTksNyArMzk5LDYgQEAgdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0
KENQVUhleGFnb25TdGF0ZSAqZW52KQogfQogI2VuZGlmCiAKLQogc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiB7CiAgICAgQ1BV
U3RhdGUgKmNzID0gQ1BVKG9iaik7Ci0tIAoyLjM0LjEKCg==

