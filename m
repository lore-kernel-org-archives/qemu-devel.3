Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2652FDEE5E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 02:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6P3-0006kd-JO; Thu, 23 Apr 2026 22:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6P2-0006jj-07
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wG6Oy-0008JN-QN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 22:36:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O0C1EL1204917
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j2kp/jUn5Ky3qTZMPIfFLxVQK9jhybJ5P30/1L6hUHw=; b=PKHroozwhMsRYV8i
 HWVOygDYCFnRQTlA5l4BOaLmDBiAdrTTPGrcfdIwYkpn+mlVqYk5JCoZxntwLlbQ
 QnMBqFCuuhf7h02ZNlyr1Oi8Q90f0g3Sq73hD4KHQMhMmK1Z+2pLcYFcrxsCorSn
 HUT/KlP3zxZIxq77/x/N4rBAfExJXF/BmKj55IrDMSGs7PgVwiWisclo9MgeGvH5
 lEWQdgi+sdwO/n31atXRUS55IX14v6vxFw9+0ufDv/3qmtQqlrhp3EcHOsSVpQP3
 LWhKPJQyw+8NY227XnXJ27sYE+iCW5HXXEzr+NTthXOshJtRevkq6hgT1jHOcuqE
 f1716g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqggnbx4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:36:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2dd1c74508cso11943078eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 19:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776998179; x=1777602979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2kp/jUn5Ky3qTZMPIfFLxVQK9jhybJ5P30/1L6hUHw=;
 b=GkBWAMUvgrtqZZolj/w+qWWyf4m7EPxWTkW0xq1RTc8fdBdBhWvB0whWju7m+tzEQY
 5vy5swK0H7Ym+qE/o4Mr53WhyfHKDk0kRPoJ7ZzlNsItHs7s1Hqg0IaveTmAG+EYpO+8
 btpMc13LuuY8YcT5tvvCkxU8PBuB2jAf9D5LX2T2YUA7ImfG7WOXyZw74OXJKnsEED4z
 P+VFpfP71Y2jSfGggKXrhqf0TuajjTaeYX9krSG0O+XU3r5rnQosB0JT5V6aAxD4x5Ki
 cVrk6KS8Kh35y4IZyBIjlPqIsRmrA1mLJhsY1Oy0FjbWFRLqEFGVi/IZ8Y8/v5fz31dU
 apPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776998179; x=1777602979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j2kp/jUn5Ky3qTZMPIfFLxVQK9jhybJ5P30/1L6hUHw=;
 b=DPoeetr27tBFGzUpsK/9Zwo3BT5D4sC3zGz/vcrSLwytVS59h4vQ9Ia45oHVoH/Q54
 O7bsVoGeO0gnPM7qvDLl/eaA7K3Ed/ceq87aKhO05OEK9DGnIv5FLPXG4MrUpJkBufP4
 2Piv2+HYRbz1RarKUpMpJLRl0EvgI/Ebrgi34d4lXky+MS0wGnG6oxnJwqgi29V0r+lY
 ABGMu+hnVE0TWJqYXOJNDzigi+FTMlamGUBqU8W12cEmEiq7NCMYuA024xdRkEp4D2Sl
 iG3iHQWTQVedIVA+ngMfYwn9tARdrGk+af69ululXBL7DJEw5TgVGge10Rgq2krQt7MS
 AOeg==
X-Gm-Message-State: AOJu0YwYf5QUzaOAb4zp+WQxivt1diJjcAcLan48XtbagFgVOgxUMI4H
 5p7gcAj+X6fq+HKexnb8flFMeV/bVmS92dnvMFeI3UjoyTpHrj2R5lzWGzVrRejUZOeWYBaolc6
 avxyfcXFuXduGGVPrPF0M0kRwtbXqN+tpKzQ+way55PrENs5wbxl7xF1wM0UCFVCQtg==
X-Gm-Gg: AeBDieuISAT/AHsrxF6zFNZQFvlv2WpT5mceVLERN5qx9HmqyM49fSUeVL1p5qVN4W/
 ZDB63uuuVazWkzdtM+07OXf5GoLVwULWak9BNRbBdyF43rk2w3f6EowDFcCdCdqIpKwpkoJSV7i
 cASZRQlLB5A0BIH723mb1e8rbdETU12zOfWWKsFcYeoj4h9QYrABtijF/zlC/xFq5DDdl3O5QrN
 u9hqKqWT2hYJAMiHiKdRPYM0QQ2S6ZDAasZIi4IqQdZpJnRbz3amE23CtvaqyRpqegEPp2je7m/
 GLCtpsfJv9xU34FyBg+7h3goVoO30B//12A5Grk2G5j0Xep55VzhfKhEOJ9Q7lMlOTRKq4ErRbd
 v/r6R2oe6VzZGwmC2bUrrvCFCCWdK0MiH9Fa+UmMpBoKEi2wCjyCKfNtotqRpsxGHOR+odThC6U
 tv5Arj
X-Received: by 2002:a05:7300:641b:b0:2d1:d434:d022 with SMTP id
 5a478bee46e88-2e4521f9d92mr15964340eec.0.1776998178541; 
 Thu, 23 Apr 2026 19:36:18 -0700 (PDT)
X-Received: by 2002:a05:7300:641b:b0:2d1:d434:d022 with SMTP id
 5a478bee46e88-2e4521f9d92mr15964330eec.0.1776998178036; 
 Thu, 23 Apr 2026 19:36:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm31240868eec.3.2026.04.23.19.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 19:36:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 2/9] Hexagon (linux-user/hexagon) Identify Hexagon version in
 ELF file
Date: Thu, 23 Apr 2026 19:35:59 -0700
Message-Id: <20260424023606.2556830-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
References: <20260424023606.2556830-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: YQJzqK61zRdQKN8s086l2l4drq09AZaV
X-Authority-Analysis: v=2.4 cv=YZeNIQRf c=1 sm=1 tr=0 ts=69ead723 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VbRvh4igG6xmFnRxfGQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAyMCBTYWx0ZWRfX8GTn2syvvCbj
 cTw2Fl92qEg3CygZ2pRPcoO2Bpg7d/6L4TbngOybufq68lrX1AWHA2NZLsVzRIyFpFpALvwku+s
 QB7OPKHTPBtakOya+QnKiIYb4E4ZvLuTU9Z0TIuMyt5CMspvrw11rd+wwVYfOeH16IkIyVwPXii
 eKy/6KylOo6HldKDsnWg0P8OIa6Bwbg9h05zjg4Spi4Nu2iyquaY5gfiTp3M0VTAVl2cESk/xId
 TKYEdIaEsuqdCyCZqSFQ5kXUKZkUym4yT3p9N7p5AdXgynMIqKMLEacWKCxchAal8YUC7CsOIxW
 GfhMiTRrVGRjPrJScqkQ6WZmc6luWkEe8lSMhQmSrWUxEWYbVuIW5bs7NT7IROkz9acyqvz9RLS
 IMAuOw5B4u1vsHaMA5ZTgXGwZnaSb32ogebqYTyWoke7V43HszQ5/sfubEaQRZwxwloFiafCtOT
 yZWLXcGifhVBp1CZRWw==
X-Proofpoint-GUID: YQJzqK61zRdQKN8s086l2l4drq09AZaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240020
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJldHVybiBw
cm9wZXIgSGV4YWdvbiBDUFUgdmVyc2lvbiBmcm9tIGdldF9lbGZfY3B1X21vZGVsCgpDby1hdXRo
b3JlZC1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bv
c3MucXVhbGNvbW0uY29tPgpDby1hdXRob3JlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBv
c3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNp
bXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5u
Zz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIGxpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgfCA0MyArKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAx
NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5j
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCBkOGI1NDUwMzJhYi4uMzliMDIw
MTgxNDUgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysrIGIvbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtMTAsMjMgKzEwLDMyIEBAIGNvbnN0IGNoYXIg
KmdldF9lbGZfY3B1X21vZGVsKHVpbnQzMl90IGVmbGFncykKICAgICBzdGF0aWMgY2hhciBidWZb
MzJdOwogICAgIGludCBlcnI7CiAKLSAgICAvKiBGb3Igbm93LCB0cmVhdCBhbnl0aGluZyBuZXdl
ciB0aGFuIHY1IGFzIGEgdjczICovCi0gICAgLyogRklYTUUgLSBEaXNhYmxlIGluc3RydWN0aW9u
cyB0aGF0IGFyZSBuZXdlciB0aGFuIHRoZSBzcGVjaWZpZWQgYXJjaCAqLwotICAgIGlmIChlZmxh
Z3MgPT0gMHgwNCB8fCAgICAvKiB2NSAgKi8KLSAgICAgICAgZWZsYWdzID09IDB4MDUgfHwgICAg
LyogdjU1ICovCi0gICAgICAgIGVmbGFncyA9PSAweDYwIHx8ICAgIC8qIHY2MCAqLwotICAgICAg
ICBlZmxhZ3MgPT0gMHg2MSB8fCAgICAvKiB2NjEgKi8KLSAgICAgICAgZWZsYWdzID09IDB4NjIg
fHwgICAgLyogdjYyICovCi0gICAgICAgIGVmbGFncyA9PSAweDY1IHx8ICAgIC8qIHY2NSAqLwot
ICAgICAgICBlZmxhZ3MgPT0gMHg2NiB8fCAgICAvKiB2NjYgKi8KLSAgICAgICAgZWZsYWdzID09
IDB4NjcgfHwgICAgLyogdjY3ICovCi0gICAgICAgIGVmbGFncyA9PSAweDgwNjcgfHwgIC8qIHY2
N3QgKi8KLSAgICAgICAgZWZsYWdzID09IDB4NjggfHwgICAgLyogdjY4ICovCi0gICAgICAgIGVm
bGFncyA9PSAweDY5IHx8ICAgIC8qIHY2OSAqLwotICAgICAgICBlZmxhZ3MgPT0gMHg3MSB8fCAg
ICAvKiB2NzEgKi8KLSAgICAgICAgZWZsYWdzID09IDB4ODA3MSB8fCAgLyogdjcxdCAqLwotICAg
ICAgICBlZmxhZ3MgPT0gMHg3MyAgICAgICAvKiB2NzMgKi8KLSAgICAgICApIHsKKyAgICBzd2l0
Y2ggKGVmbGFncykgeworICAgIGNhc2UgMHgwNDoKKyAgICAgICAgcmV0dXJuICJ2NSI7CisgICAg
Y2FzZSAweDA1OgorICAgICAgICByZXR1cm4gInY1NSI7CisgICAgY2FzZSAweDYwOgorICAgICAg
ICByZXR1cm4gInY2MCI7CisgICAgY2FzZSAweDYxOgorICAgICAgICByZXR1cm4gInY2MSI7Cisg
ICAgY2FzZSAweDYyOgorICAgICAgICByZXR1cm4gInY2MiI7CisgICAgY2FzZSAweDY1OgorICAg
ICAgICByZXR1cm4gInY2NSI7CisgICAgY2FzZSAweDY2OgorICAgICAgICByZXR1cm4gInY2NiI7
CisgICAgY2FzZSAweDY3OgorICAgIGNhc2UgMHg4MDY3OiAgICAgICAgLyogdjY3dCAqLworICAg
ICAgICByZXR1cm4gInY2NyI7CisgICAgY2FzZSAweDY4OgorICAgICAgICByZXR1cm4gInY2OCI7
CisgICAgY2FzZSAweDY5OgorICAgICAgICByZXR1cm4gInY2OSI7CisgICAgY2FzZSAweDcxOgor
ICAgIGNhc2UgMHg4MDcxOiAgICAgICAgLyogdjcxdCAqLworICAgICAgICByZXR1cm4gInY3MSI7
CisgICAgY2FzZSAweDczOgogICAgICAgICByZXR1cm4gInY3MyI7CiAgICAgfQogCi0tIAoyLjM0
LjEKCg==

